Return-Path: <linux-wireless+bounces-831-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B76A781486A
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Dec 2023 13:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 430291F241B8
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Dec 2023 12:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E592C6B6;
	Fri, 15 Dec 2023 12:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="lsmAvTrq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward202b.mail.yandex.net (forward202b.mail.yandex.net [178.154.239.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8384B134BF
	for <linux-wireless@vger.kernel.org>; Fri, 15 Dec 2023 12:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d101])
	by forward202b.mail.yandex.net (Yandex) with ESMTP id 86B4764A97
	for <linux-wireless@vger.kernel.org>; Fri, 15 Dec 2023 15:43:50 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:47a7:0:640:b27a:0])
	by forward101b.mail.yandex.net (Yandex) with ESMTP id BB76E60906;
	Fri, 15 Dec 2023 15:43:42 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ehk5Ww9j9W20-0t0XZDJE;
	Fri, 15 Dec 2023 15:43:42 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1702644222; bh=TegX+b1MeIhyCw21tTI1d6dy0UZhkzNSn15M6//DtzM=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=lsmAvTrqW4tHU36aHXsxgR6yjzx/WKgSUAHTdXkRZR0aN0JYN9s2RdYPm9tsHZmFj
	 F99v2q4ktkeACNfK4R5AdnzGHLDwEG2N4zfH2S8GPpBFJnoYugYXUv9Yo1HTle8C9t
	 jNuGI+kAiBtKNC9184CrEE6pyXkwINuj0I4fIeeg=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Brian Norris <briannorris@chromium.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/3] wifi: mwifiex: use cfg80211_ssid_eq() instead of mwifiex_ssid_cmp()
Date: Fri, 15 Dec 2023 15:38:52 +0300
Message-ID: <20231215123859.196350-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215123859.196350-1-dmantipov@yandex.ru>
References: <20231215123859.196350-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prefer generic 'cfg80211_ssid_eq()' over dropped 'mwifiex_ssid_cmp()'.
Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/marvell/mwifiex/join.c      |  4 ++--
 drivers/net/wireless/marvell/mwifiex/main.h      |  1 -
 drivers/net/wireless/marvell/mwifiex/scan.c      | 11 -----------
 drivers/net/wireless/marvell/mwifiex/sta_ioctl.c |  4 ++--
 4 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/join.c b/drivers/net/wireless/marvell/mwifiex/join.c
index a6e254a1185c..9d98a1908dd6 100644
--- a/drivers/net/wireless/marvell/mwifiex/join.c
+++ b/drivers/net/wireless/marvell/mwifiex/join.c
@@ -1427,8 +1427,8 @@ int mwifiex_adhoc_join(struct mwifiex_private *priv,
 
 	/* Check if the requested SSID is already joined */
 	if (priv->curr_bss_params.bss_descriptor.ssid.ssid_len &&
-	    !mwifiex_ssid_cmp(&bss_desc->ssid,
-			      &priv->curr_bss_params.bss_descriptor.ssid) &&
+	    cfg80211_ssid_eq(&bss_desc->ssid,
+			     &priv->curr_bss_params.bss_descriptor.ssid) &&
 	    (priv->curr_bss_params.bss_descriptor.bss_mode ==
 							NL80211_IFTYPE_ADHOC)) {
 		mwifiex_dbg(priv->adapter, INFO,
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index d263eae6078c..318b42b1896f 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -1152,7 +1152,6 @@ void mwifiex_queue_scan_cmd(struct mwifiex_private *priv,
 			    struct cmd_ctrl_node *cmd_node);
 int mwifiex_ret_802_11_scan(struct mwifiex_private *priv,
 			    struct host_cmd_ds_command *resp);
-s32 mwifiex_ssid_cmp(struct cfg80211_ssid *ssid1, struct cfg80211_ssid *ssid2);
 int mwifiex_associate(struct mwifiex_private *priv,
 		      struct mwifiex_bssdescriptor *bss_desc);
 int mwifiex_cmd_802_11_associate(struct mwifiex_private *priv,
diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
index 72904c275461..a2ddac363b10 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -179,17 +179,6 @@ mwifiex_is_wpa_oui_present(struct mwifiex_bssdescriptor *bss_desc, u32 cipher)
 	return ret;
 }
 
-/*
- * This function compares two SSIDs and checks if they match.
- */
-s32
-mwifiex_ssid_cmp(struct cfg80211_ssid *ssid1, struct cfg80211_ssid *ssid2)
-{
-	if (!ssid1 || !ssid2 || (ssid1->ssid_len != ssid2->ssid_len))
-		return -1;
-	return memcmp(ssid1->ssid, ssid2->ssid, ssid1->ssid_len);
-}
-
 /*
  * This function checks if wapi is enabled in driver and scanned network is
  * compatible with it.
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
index a2ad2b53f016..32a27fad7b79 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
@@ -345,8 +345,8 @@ int mwifiex_bss_start(struct mwifiex_private *priv, struct cfg80211_bss *bss,
 		/* Adhoc mode */
 		/* If the requested SSID matches current SSID, return */
 		if (bss_desc && bss_desc->ssid.ssid_len &&
-		    (!mwifiex_ssid_cmp(&priv->curr_bss_params.bss_descriptor.
-				       ssid, &bss_desc->ssid))) {
+		    cfg80211_ssid_eq(&priv->curr_bss_params.bss_descriptor.ssid,
+				     &bss_desc->ssid)) {
 			ret = 0;
 			goto done;
 		}
-- 
2.43.0


