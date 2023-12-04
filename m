Return-Path: <linux-wireless+bounces-380-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F9B80394A
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 16:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3DBF280E28
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 15:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEAA2D041;
	Mon,  4 Dec 2023 15:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="wiRTziqT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward100c.mail.yandex.net (forward100c.mail.yandex.net [178.154.239.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DC6A4
	for <linux-wireless@vger.kernel.org>; Mon,  4 Dec 2023 07:56:23 -0800 (PST)
Received: from mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:2612:0:640:2e49:0])
	by forward100c.mail.yandex.net (Yandex) with ESMTP id 7322A60036;
	Mon,  4 Dec 2023 18:56:21 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id KucJcIOn9iE0-BA8yVF0i;
	Mon, 04 Dec 2023 18:56:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1701705380; bh=hgJ1dv8lCdDXqdsTAJUZOMd60URy+PklyC8vyq5AcHc=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=wiRTziqTzPz3g2yt7MAewtpDvsv1MGaAjLDeuj4Jp2jqS0pzshI4ySk8AHDZHmZuy
	 Suv3RNOQVSRGxtiG4G7RCxC91tDniKnzb5oi/DUsCvpoL+PaFmHgdjWZjFoeahMbgK
	 4cFtvKv1DcoGUsffeqV0mikIX5IxDtJ4rb4/oa5A=
Authentication-Results: mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: wfx: fix possible NULL pointer dereference in wfx_set_mfp_ap()
Date: Mon,  4 Dec 2023 18:55:37 +0300
Message-ID: <20231204155558.133839-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since 'ieee80211_beacon_get()' can return NULL, 'wfx_set_mfp_ap()'
should check the return value before examining skb data. So convert
the latter to return an appropriate error code and propagate it to
return from 'wfx_start_ap()' as well. Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/silabs/wfx/sta.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/silabs/wfx/sta.c b/drivers/net/wireless/silabs/wfx/sta.c
index 1b6c158457b4..df100d8513ad 100644
--- a/drivers/net/wireless/silabs/wfx/sta.c
+++ b/drivers/net/wireless/silabs/wfx/sta.c
@@ -336,29 +336,35 @@ static int wfx_upload_ap_templates(struct wfx_vif *wvif)
 	return 0;
 }
 
-static void wfx_set_mfp_ap(struct wfx_vif *wvif)
+static int wfx_set_mfp_ap(struct wfx_vif *wvif)
 {
 	struct ieee80211_vif *vif = wvif_to_vif(wvif);
 	struct sk_buff *skb = ieee80211_beacon_get(wvif->wdev->hw, vif, 0);
 	const int ieoffset = offsetof(struct ieee80211_mgmt, u.beacon.variable);
-	const u16 *ptr = (u16 *)cfg80211_find_ie(WLAN_EID_RSN, skb->data + ieoffset,
-						 skb->len - ieoffset);
 	const int pairwise_cipher_suite_count_offset = 8 / sizeof(u16);
 	const int pairwise_cipher_suite_size = 4 / sizeof(u16);
 	const int akm_suite_size = 4 / sizeof(u16);
+	const u16 *ptr;
 
+	if (unlikely(!skb))
+		return -ENOMEM;
+
+	ptr = (u16 *)cfg80211_find_ie(WLAN_EID_RSN, skb->data + ieoffset,
+				      skb->len - ieoffset);
 	if (ptr) {
 		ptr += pairwise_cipher_suite_count_offset;
 		if (WARN_ON(ptr > (u16 *)skb_tail_pointer(skb)))
-			return;
+			return -EINVAL;
 		ptr += 1 + pairwise_cipher_suite_size * *ptr;
 		if (WARN_ON(ptr > (u16 *)skb_tail_pointer(skb)))
-			return;
+			return -EINVAL;
 		ptr += 1 + akm_suite_size * *ptr;
 		if (WARN_ON(ptr > (u16 *)skb_tail_pointer(skb)))
-			return;
+			return -EINVAL;
 		wfx_hif_set_mfp(wvif, *ptr & BIT(7), *ptr & BIT(6));
+		return 0;
 	}
+	return -EINVAL;
 }
 
 int wfx_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
@@ -374,10 +380,7 @@ int wfx_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	wvif = (struct wfx_vif *)vif->drv_priv;
 	wfx_upload_ap_templates(wvif);
 	ret = wfx_hif_start(wvif, &vif->bss_conf, wvif->channel);
-	if (ret > 0)
-		return -EIO;
-	wfx_set_mfp_ap(wvif);
-	return ret;
+	return ret > 0 ? -EIO : wfx_set_mfp_ap(wvif);
 }
 
 void wfx_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-- 
2.43.0


