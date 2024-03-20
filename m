Return-Path: <linux-wireless+bounces-5006-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FC1881746
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 19:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C43F11F235F6
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 18:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545636BFD7;
	Wed, 20 Mar 2024 18:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMZJW6YB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED806BFCD
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 18:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710959093; cv=none; b=LStRnJMo64pgABzEpaAuS8qqyGBiomkim7B+ORcF8X9LbHd5p5ddzoMhz2QbiEBm+OIdl6lGwV1EvOp/4J7HKKZQJ9WI/sPxz5j4wZi2x068XF3QsSQlm66KUiSAnZUCexXf3HFowe8fQ+borg3gMoPd94pmFG3vet86XwbzTRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710959093; c=relaxed/simple;
	bh=HzPD7CxYDWBNaQwTUA0uqhVdoK7VubOfkLy+vU3jGto=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TjBCfxug5LZUzjqvuUSReUYXwEC35qZIEtzBRhzXP/2N7110PzaWgS/QnEXAeG/byo42LA0AjMFuOCATp7Y5Hd9721rZXlBgtcZUsQC83EMeiRxOY3uN2z2PSvTOpCcksbaV0USBNVpcQE3Kq+0wZ3PCW+E6OA2Isi2t0Oiaz28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMZJW6YB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8ABC433C7
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 18:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710959093;
	bh=HzPD7CxYDWBNaQwTUA0uqhVdoK7VubOfkLy+vU3jGto=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pMZJW6YBKDBgLfTpe9qld67Mm0SVsuQ5toFIxNCfaw8TnbhcKj3aPvR0h/MgTmRfD
	 YZp6OwtwPEQsF9xbHl47jMijE+1QMi9mgeB7hf4VCaqVfFDvhAUrKhFgmdWgVvlpZG
	 asT0MXs0TQqwaVFY3dvOKQCcA48zSbsdARDbhNOIBUZUXFe+YHszwt/lgDchI3Crlx
	 lyGQdo31kSwa5NF/RlwniVFR9mjSPr+GPfT3zUz+6sHbay88VKz56xJ5b7U1nKRhU6
	 WnQe6lnBXkgnvttf5fxCykZuk56+Y81M5VYkoi2NoUrb1HkJwL6smIzRXtANvA1Z5d
	 LEqUV0XjQyNFQ==
From: Kalle Valo <kvalo@kernel.org>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 1/4] wifi: ath6kl: fix sparse warnings
Date: Wed, 20 Mar 2024 20:24:46 +0200
Message-Id: <20240320182449.3757215-2-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240320182449.3757215-1-kvalo@kernel.org>
References: <20240320182449.3757215-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kalle Valo <quic_kvalo@quicinc.com>

Sparse warns:

drivers/net/wireless/ath/ath6kl/htc_pipe.c:241:17: warning: incorrect type in assignment (different base types)
drivers/net/wireless/ath/ath6kl/htc_pipe.c:241:17:    expected restricted __le16 x
drivers/net/wireless/ath/ath6kl/htc_pipe.c:241:17:    got unsigned short [usertype]
drivers/net/wireless/ath/ath6kl/htc_mbox.c:368:9: warning: incorrect type in assignment (different base types)
drivers/net/wireless/ath/ath6kl/htc_mbox.c:368:9:    expected restricted __le16 x
drivers/net/wireless/ath/ath6kl/htc_mbox.c:368:9:    got unsigned short [usertype]

Use put_unaligned_le16() so that the value is converted to little endian before
storing it to the header.

Compile tested only.

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath6kl/htc_mbox.c | 3 +--
 drivers/net/wireless/ath/ath6kl/htc_pipe.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/htc_mbox.c b/drivers/net/wireless/ath/ath6kl/htc_mbox.c
index 1963d3145481..fb5144e2d86c 100644
--- a/drivers/net/wireless/ath/ath6kl/htc_mbox.c
+++ b/drivers/net/wireless/ath/ath6kl/htc_mbox.c
@@ -364,8 +364,7 @@ static void ath6kl_htc_tx_prep_pkt(struct htc_packet *packet, u8 flags,
 	packet->buf -= HTC_HDR_LENGTH;
 	hdr =  (struct htc_frame_hdr *)packet->buf;
 
-	/* Endianess? */
-	put_unaligned((u16)packet->act_len, &hdr->payld_len);
+	put_unaligned_le16(packet->act_len, &hdr->payld_len);
 	hdr->flags = flags;
 	hdr->eid = packet->endpoint;
 	hdr->ctrl[0] = ctrl0;
diff --git a/drivers/net/wireless/ath/ath6kl/htc_pipe.c b/drivers/net/wireless/ath/ath6kl/htc_pipe.c
index 9b88d96bfe96..2f2edfe43761 100644
--- a/drivers/net/wireless/ath/ath6kl/htc_pipe.c
+++ b/drivers/net/wireless/ath/ath6kl/htc_pipe.c
@@ -237,8 +237,7 @@ static int htc_issue_packets(struct htc_target *target,
 
 		packet->info.tx.flags |= HTC_FLAGS_TX_FIXUP_NETBUF;
 
-		/* Endianess? */
-		put_unaligned((u16) payload_len, &htc_hdr->payld_len);
+		put_unaligned_le16(payload_len, &htc_hdr->payld_len);
 		htc_hdr->flags = packet->info.tx.flags;
 		htc_hdr->eid = (u8) packet->endpoint;
 		htc_hdr->ctrl[0] = 0;
-- 
2.39.2


