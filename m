Return-Path: <linux-wireless+bounces-21405-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B48AA84F54
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 23:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26F0A4C68FC
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 21:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FC31EB9F9;
	Thu, 10 Apr 2025 21:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="kt6cDyBj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4962F1EB1B7;
	Thu, 10 Apr 2025 21:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744322143; cv=none; b=kkCpcNG2sED19rNSyPqxp6X6oYCjf7tLMF5xCLonTgj/5nAIXutD06LsCA5/SoWEbyN/SfWykUwdaZZcOSNMCeKnzWGlYVYYSjOaUrCc+b0znv8+E/bNbv2SthZ2kW7FMTPVjHjcXB+OAXeC+Tfx7J6lTdawy/DkRjOhKaGrf9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744322143; c=relaxed/simple;
	bh=fDnGzJ51J5/a9sHZkR0tANFKUezttWMIbMlufgjren8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m2xCgrbO/4o2unJjAvP0vzuAHD6/h/nOIuXFpHOPNFMQGdusnBgDKmrhAG9qr6RHY565ggXQuLWZRqQ4hJKoRpniewKd73lFQD3316B5a8BGmKCpDoMfeXJLgnA81Q9IIR41IxqLcceRKiEm0r333WYTZvhtE+pwMwWzrP9dPLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=kt6cDyBj; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1744322130; x=1744926930; i=spasswolf@web.de;
	bh=1GY5ZMdZjhKMFGAZ7nYgIWIy42frcEP+JsCHcKOsgqQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kt6cDyBjk3di39ySKMXxNJJSDf7ACBvMcKxHVjuHSfx9XsSR9b33dx3RqDtl1KIZ
	 s8Yt4x8Dvvm7oImGEkA+P4NjuL6jI0xxNpDnGJAO7MQmMEcbDU4JOCvSb7rzHuDt6
	 XFbi2JZQ6bvUXn/SRX0Hixr+DHneHHPeH9/NzOQ7BjlEr9pT19+syt02GiM11LJpr
	 Dsz/2D1ThNPxb+TuxTkgAdPJr3anvb48NBU1FZmxWYigzt8B4/UtdCc0gPH69MI8l
	 mzw5gw6oqiXxQ1vsFdcDnSAif/Ru+OowM3ZhS85AO5wQLdAVp+U7BoL8ANwqppITp
	 zJVVUeT++ZXHUecBAQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([95.223.134.88]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1N0qr9-1t9MTX1cPt-015Ira; Thu, 10 Apr 2025 23:55:30 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: Remi Pommarel <repk@triplefau.lt>
Cc: Bert Karwatzki <spasswolf@web.de>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	johannes@sipsolutions.net
Subject: Re: [PATCH wireless v2 1/2] wifi: mac80211: Update skb's control block key in ieee80211_tx_dequeue()
Date: Thu, 10 Apr 2025 23:55:26 +0200
Message-ID: <20250410215527.3001-1-spasswolf@web.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <06aa507b853ca385ceded81c18b0a6dd0f081bc8.1742833382.git.repk@triplefau.lt> 
References: 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jlxP9/8AIyquEdtoNCqulxHz9+nHygCEXW2jW8hWQeTxaXavBpY
 63/haJUpFk1ieYl9yYFurB0ZLRJF5xGDBNfsO9EV/HnsLhJCoYAbFUCS6w6TCkH9+Xvw/g1
 DTlv8uGQdIkRLYrdRgWDtfQk5FLd7SGqTzHPNC5L42nVJ++82df/XJWQDHz3wiRRupoqUbm
 HkH0jY7BnoBlKkaRbhxyA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UsEJkpJn51k=;OR3GCSoMhdpY9ZcnUceXxgEdQky
 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

This commit breaks the mediatek mt7921 wireless driver. In linux-next-2025=
0410
my mt7921e Wi-Fi controller is no longer able to connect to a network.
I bisected this to commit a104042e2bf6 ("wifi: mac80211: Update skb's cont=
rol
block key in ieee80211_tx_dequeue()").

Hardware:
04:00.0 Network controller: MEDIATEK Corp. MT7921K (RZ608) Wi-Fi 6E 80MHz

This debugging patch reveals that the change causes key to be NULL in
mt7921_tx_prepare_skb().

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c b/drivers=
/net/wireless/mediatek/mt76/mt7921/pci_mac.c
index 881812ba03ff..3b8552a1055c 100644
=2D-- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
@@ -13,6 +13,7 @@ int mt7921e_tx_prepare_skb(struct mt76_dev *mdev, void *=
txwi_ptr,
        struct mt792x_dev *dev =3D container_of(mdev, struct mt792x_dev, m=
t76);
        struct ieee80211_tx_info *info =3D IEEE80211_SKB_CB(tx_info->skb);
        struct ieee80211_key_conf *key =3D info->control.hw_key;
+       dev_info(mdev->dev, "%s: key =3D %px\n", __func__, key);
        struct mt76_connac_hw_txp *txp;
        struct mt76_txwi_cache *t;
        int id, pid;


So why is info->control.hw_key not updated by ieee80211_tx_h_select_key()?

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 34f229a6eab0..2510e3533d13 100644
=2D-- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -631,8 +631,10 @@ ieee80211_tx_h_select_key(struct ieee80211_tx_data *t=
x)
 		case WLAN_CIPHER_SUITE_WEP40:
 		case WLAN_CIPHER_SUITE_WEP104:
 		case WLAN_CIPHER_SUITE_TKIP:
-			if (!ieee80211_is_data_present(hdr->frame_control))
+			if (!ieee80211_is_data_present(hdr->frame_control)) {
+				printk(KERN_INFO "%s %d: setting tx->key =3D NULL\n", __func__, __LIN=
E__);
 				tx->key =3D NULL;
+			}
 			break;
 		case WLAN_CIPHER_SUITE_CCMP:
 		case WLAN_CIPHER_SUITE_CCMP_256:
@@ -641,19 +643,23 @@ ieee80211_tx_h_select_key(struct ieee80211_tx_data *=
tx)
 			if (!ieee80211_is_data_present(hdr->frame_control) &&
 			    !ieee80211_use_mfp(hdr->frame_control, tx->sta,
 					       tx->skb) &&
-			    !ieee80211_is_group_privacy_action(tx->skb))
+			    !ieee80211_is_group_privacy_action(tx->skb)) {
+				printk(KERN_INFO "%s %d: setting tx->key =3D NULL\n", __func__, __LIN=
E__);
 				tx->key =3D NULL;
-			else
+			} else {
 				skip_hw =3D (tx->key->conf.flags &
 					   IEEE80211_KEY_FLAG_SW_MGMT_TX) &&
 					ieee80211_is_mgmt(hdr->frame_control);
+			}
 			break;
 		case WLAN_CIPHER_SUITE_AES_CMAC:
 		case WLAN_CIPHER_SUITE_BIP_CMAC_256:
 		case WLAN_CIPHER_SUITE_BIP_GMAC_128:
 		case WLAN_CIPHER_SUITE_BIP_GMAC_256:
-			if (!ieee80211_is_mgmt(hdr->frame_control))
+			if (!ieee80211_is_mgmt(hdr->frame_control)) {
+				printk(KERN_INFO "%s %d: setting tx->key =3D NULL\n", __func__, __LIN=
E__);
 				tx->key =3D NULL;
+			}
 			break;
 		}

@@ -662,9 +668,13 @@ ieee80211_tx_h_select_key(struct ieee80211_tx_data *t=
x)
 			     tx->skb->protocol !=3D tx->sdata->control_port_protocol)
 			return TX_DROP;

+		printk(KERN_INFO "%s: skip_hw=3D%d tx->key=3D%px\n",
+				__func__, skip_hw, tx->key);
 		if (!skip_hw && tx->key &&
-		    tx->key->flags & KEY_FLAG_UPLOADED_TO_HARDWARE)
+		    tx->key->flags & KEY_FLAG_UPLOADED_TO_HARDWARE) {
 			info->control.hw_key =3D &tx->key->conf;
+			printk(KERN_INFO "%s: info->control.hw_key =3D %px\n", __func__, info-=
>control.hw_key);
+		}
 	} else if (ieee80211_is_data_present(hdr->frame_control) && tx->sta &&
 		   test_sta_flag(tx->sta, WLAN_STA_USES_ENCRYPTION)) {
 		return TX_DROP;
@@ -3894,6 +3904,8 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee8021=
1_hw *hw,
 	 * The key can be removed while the packet was queued, so need to call
 	 * this here to get the current key.
 	 */
+	printk(KERN_INFO "%s: info->control.hw_key =3D %px, setting to NULL\n",
+			__func__, info->control.hw_key);
 	info->control.hw_key =3D NULL;
 	r =3D ieee80211_tx_h_select_key(&tx);
 	if (r !=3D TX_CONTINUE) {

This patch reveals that tx->key is set to NULL (in the @@ -641,19 +643,23 =
@@ chunk)
and so the updating of info->contro.hw_key is skipped:

[   17.411298] [   T1232] ieee80211_tx_h_select_key 647: setting tx->key =
=3D NULL
[   17.411300] [   T1232] ieee80211_tx_h_select_key: skip_hw=3D0 tx->key=
=3D0000000000000000
[   17.411307] [   T1232] mt7921e 0000:04:00.0: mt7921e_tx_prepare_skb: ke=
y =3D 0000000000000000

If I revert commit a104042e2bf6 while keeping the debug patches it shows t=
hat
the for mt7921e the key is never updated in ieee80211_tx_h_select_key(), m=
t7921e
relies on the key your patch is setting to NULL.

Is this a problem with your patch or with the mt7921e driver that just got
revealed by your patch?

Bert Karwatzki

