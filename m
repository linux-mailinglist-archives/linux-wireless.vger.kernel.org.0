Return-Path: <linux-wireless+bounces-35131-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDyJCq5c52l87AEAu9opvQ
	(envelope-from <linux-wireless+bounces-35131-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 13:17:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A85C043A02A
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 13:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 001C9304E5EC
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 11:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE0C3BD649;
	Tue, 21 Apr 2026 11:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pFe2gNVi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56003BE62F
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 11:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776770079; cv=none; b=nNrhMg6QBvVPOi+iSToXmpatKuBWDIxyjdzyudlkDx7J1Rk0l2ibMV3sDR7p8TMVkx0FTVH15Os2TI9bF9Mok10oAQQ0vmiQ/ExVY/Ucdtt/B/DNeMLOlp9pO2Y3N3cyuNB48L5XYPSrxn7W2ok/FFMhFJ5akVY9ZbpjCL+r08A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776770079; c=relaxed/simple;
	bh=ASh8MN3m2IXIjGlUYnMVVnJ57RfgJMq89gEQeWyRUy0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eO1WyShK2Kf0WyVaVf3xkcnWfGHGcGfGiQ3IjLId6KowflnzKPEQFnLgfapjja7mTM6D1pg5Cbs0USOtkg8BS0yEOKljFdLzTCKS3+Eq7bxswaKUFVsXnNtz33RTmhz7E1GQbDxrib/3+KDI8WW0e2RJaliWXbhMHJ39SnlN0ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pFe2gNVi; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48909558b3aso32025745e9.0
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 04:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776770076; x=1777374876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8dxTEamxG2iViltzh1y5Nt5gW26CRUBebPaGh+x7fcM=;
        b=pFe2gNVim2YdOEs/2xz52LlcLf2HZ6A5hUim03FeBtotCi5D7sDOuCEolvEfjEI5DR
         Kkcso2zTX1MxDQBYy8DIKxtct+Y4gnHLVdxXxnlLCwvE6gLUzXT/QOp/Q+8khZO0yFGF
         uBELp3cxzCDoKzyCZdCQImy5qPdbnILlKJztnqTMeuNfSjuFUt1Csb917vGiwXdchzJF
         o1xwAoKJh4Cp9j6NabxRH7gXOaEJEvYoi9uBtCc9Q2Katg/tL46M/yRk8ESzuBVFpusW
         Bq2Hp2tDdgkZC5vprtZcPOF0N8aVwE29WeLsC2uAWEutNC3QImq/WtF8QJRc0mUfW1Yy
         dI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776770076; x=1777374876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dxTEamxG2iViltzh1y5Nt5gW26CRUBebPaGh+x7fcM=;
        b=S8kmwdZTojxqw5Il1jVqHw7IoGTDXLGnasO/MbwmhMz4T0X8XKqF+rb6vJDx++PxXM
         E+4gWhJcjQRkQ6ZStlAq0iM63ybRHMI15b8CiazGGuVciEIUX8hhMFTpDbHwxQMRZWgt
         MPBRo4tEsMCAWBbbzR0KaIT8MYkB17AA0JoUtG0mICnywvTMfthGiZNAWoTpiMLs4kv8
         7NG6C8fSHX6eVVNI/+7tFefHPR6RVRF6D4MDqWMNB8T0hI3m2iUWVmg1V2LEGvJp/CI+
         VWijm9gRjhjFnBK4nIZurjKjpPPNvL+4ut8CDXvPv42H+a1doM21l4Unw0D6oKpFqqwe
         tlRA==
X-Forwarded-Encrypted: i=1; AFNElJ8TZEXlqRDPVECBAuGwISMSQslea/fZ2PBlxgxLDlZEUDK9fmfNnCk/dVr/F3hfPemqhGilSIguL5oVxOzexg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwM86BXj8Ck3Zn6QBLdnN8BDHVFj4kjdY5AGwha/KglrUTjjHzR
	vMMgtDzBoMp5RX3sqp+6aYIrbD53/dkCMOR9pzUKKaxRGRf6HhXH85o=
X-Gm-Gg: AeBDiesNpXkoM1/pYP6lI3QF9o2w6XoUjYsB1+cPRiE41SvKi5rPTHExZv496Swu3Zl
	TMkV2HBLqnAbXpjK1Xd/Uncvh6rHf+87LV01v3OlGFAyOO9ZnlMQZhB2W22gLyUGUgsF8fxVvxU
	k137a+M//H/eF+GN9uwyn3ywmp+bkyJ4AbCmTa7JbAlunxTsfZdBNbXectAN+ZY2xEqDmq6cN7d
	Dyw/r6L9xLQvPpfmdb+hAdcWny0vqCboqsgwo9qzIPH5uFvx4H1JyqjbI51iXY9hHd9Frk31LXp
	Hu+hvAfy69EKwJU0wWw6LEcIUE0mXk2bEFINC9+iTs/PTc9UKJrBLExx/p/GgsLBM7qA8LiOcrY
	jDnk0PV6mKLiKdN+4YRAe89tK4l13d32kt83K30EFxI+uar+yzB/iSYxjjRMmTb2csL/m2QVnBS
	orY70=
X-Received: by 2002:a05:600c:c4a1:b0:488:c014:34da with SMTP id 5b1f17b1804b1-488fb77ed1bmr237390455e9.26.1776770075850;
        Tue, 21 Apr 2026 04:14:35 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4eec9sm34889235f8f.34.2026.04.21.04.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 04:14:35 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3] wifi: rtw88: fix OOB read from firmware RX descriptor exceeding DMA buffer
Date: Tue, 21 Apr 2026 11:14:34 +0000
Message-ID: <20260421111434.3389674-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,sipsolutions.net,vger.kernel.org,talencesecurity.com];
	TAGGED_FROM(0.00)[bounces-35131-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: A85C043A02A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

In rtw_pci_rx_napi(), new_len is computed as the sum of pkt_len (14-bit
descriptor field, max 16383) and pkt_offset (drv_info_sz + shift, both
firmware-controlled). The result can exceed RTK_PCI_RX_BUF_SIZE (11478),
causing an out-of-bounds read from the pre-allocated DMA buffer when
skb_put_data copies new_len bytes. The USB transport already validates
this (rtw_usb_rx_data_put checks against RTW_USB_MAX_RECVBUF_SZ); the
PCIe path does not.

Add a check that new_len does not exceed the DMA buffer size.

Fixes: e3037485c68e ("rtw88: new Realtek 802.11ac driver")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v3:
  - Wrap check in unlikely() since this is the RX hot path, per
    Ping-Ke Shih.

Changes in v2:
  - Clarify field widths and maximum new_len derivation in commit
    message, per Ping-Ke Shih.
 drivers/net/wireless/realtek/rtw88/pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index bba370ad510cf..465598d5dc467 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1077,6 +1077,11 @@ static u32 rtw_pci_rx_napi(struct rtw_dev *rtwdev, struct rtw_pci *rtwpci,
 		 * discard the frame if none available
 		 */
 		new_len = pkt_stat.pkt_len + pkt_offset;
+		if (unlikely(new_len > RTK_PCI_RX_BUF_SIZE)) {
+			rtw_dbg(rtwdev, RTW_DBG_RX,
+				"oversized RX packet: %u\n", new_len);
+			goto next_rp;
+		}
 		new = dev_alloc_skb(new_len);
 		if (WARN_ONCE(!new, "rx routine starvation\n"))
 			goto next_rp;
-- 
2.47.3


