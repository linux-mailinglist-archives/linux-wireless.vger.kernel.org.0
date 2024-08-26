Return-Path: <linux-wireless+bounces-11977-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D57695EF80
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 13:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EDEA1C22321
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 11:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6091553A3;
	Mon, 26 Aug 2024 11:12:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FF714F10E
	for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2024 11:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724670728; cv=none; b=k5NJq+fn4Jv5ETzfNha9oJsBnqOXZny+Kc3RNjAEFzf34mlyL+ikSyni+q0GM/xpVYvcZf2Y8mudUqoOoVH965N+EAoPJJxGQX/5Y4QDHCJXumgx/MrPRUWFS4fs5Rp3uXX/yEN801/pqmhlCTfCv5LCYxq42OByMGije+LRWes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724670728; c=relaxed/simple;
	bh=brLuPSpeCSGZC63ZIjuVtjX7mczDWGArTLmOgdfnTjg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nNUtg2blpIDqFNqncN1ZvU68uWe6U31YQD2Vu1H+7/ZrWVJDzbSGhl+jNk0X5gGGioal1p4yA2iuXVmQL1CM5aqgRL7atmHINTTuin73LI6B5+HCz32oAc8Bf0uTHXhoY4DlbdZWI1UVaBLZguMIi8W88jr2tayuQk+ETQ862rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1siXdc-0005U9-Kc; Mon, 26 Aug 2024 13:11:56 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1siXdc-003AwT-2j; Mon, 26 Aug 2024 13:11:56 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1siXTX-004aRi-30;
	Mon, 26 Aug 2024 13:01:31 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 26 Aug 2024 13:01:31 +0200
Subject: [PATCH 10/12] wifi: mwifiex: make locally used function static
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-mwifiex-cleanup-1-v1-10-56e6f8e056ec@pengutronix.de>
References: <20240826-mwifiex-cleanup-1-v1-0-56e6f8e056ec@pengutronix.de>
In-Reply-To: <20240826-mwifiex-cleanup-1-v1-0-56e6f8e056ec@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724670091; l=1579;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=brLuPSpeCSGZC63ZIjuVtjX7mczDWGArTLmOgdfnTjg=;
 b=MjRkjIFNGoncttUcrHgeuS3aHoekPcmMfyaarr8TRdpCpXHkMstUD03SIBzV+rlQddSa9gZxo
 4pq6/qwSUhTDaxA8K2pjG3PGwlNB/njzACKqRoI1i63CdDXCJ0D6UAi
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

mwifiex_is_tdls_off_chan() is only used locally. Make it static.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/main.h | 1 -
 drivers/net/wireless/marvell/mwifiex/util.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index 56f413cb6eb30..f026e6069be3f 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -1604,7 +1604,6 @@ mwifiex_add_sta_entry(struct mwifiex_private *priv, const u8 *mac);
 struct mwifiex_sta_node *
 mwifiex_get_sta_entry(struct mwifiex_private *priv, const u8 *mac);
 u8 mwifiex_is_tdls_chan_switching(struct mwifiex_private *priv);
-u8 mwifiex_is_tdls_off_chan(struct mwifiex_private *priv);
 u8 mwifiex_is_send_cmd_allowed(struct mwifiex_private *priv);
 int mwifiex_send_tdls_data_frame(struct mwifiex_private *priv, const u8 *peer,
 				 u8 action_code, u8 dialog_token,
diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
index 1f1f6280a0f25..ea28d604ee69c 100644
--- a/drivers/net/wireless/marvell/mwifiex/util.c
+++ b/drivers/net/wireless/marvell/mwifiex/util.c
@@ -663,7 +663,7 @@ u8 mwifiex_is_tdls_chan_switching(struct mwifiex_private *priv)
 	return false;
 }
 
-u8 mwifiex_is_tdls_off_chan(struct mwifiex_private *priv)
+static u8 mwifiex_is_tdls_off_chan(struct mwifiex_private *priv)
 {
 	struct mwifiex_sta_node *sta_ptr;
 

-- 
2.39.2


