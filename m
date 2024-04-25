Return-Path: <linux-wireless+bounces-6844-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C28C78B2038
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 13:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 640861F24179
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 11:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B1A12A16C;
	Thu, 25 Apr 2024 11:29:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7024D12AADC
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 11:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714044575; cv=none; b=SW2BlfDmRx9FgBEw2xh/HrUJRfdq1LOEWTHcaMopj53E/7lkvAAMmWgg76QejcSRvB1xcggVQMfHMWC1+t1lTLCxBmezjEJze2T0itxufihb6uLC/2FLNtPOXGQar9l0TH9Yi+zz2vTiD6ysdL84yMvvVcuUBIxfGkwnDeQI0jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714044575; c=relaxed/simple;
	bh=qVsJmO4OdQkpa++CVwtrbeXEpCiPZp8TDzheY3lCRx4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oEYpKbq/MAcNStau19XCnZBZzAO+9CLKloR9SysYPeHC3YOrdOnZ62qpDw1L+vipovD5+2fqgAz+Fnn7BpuA7btP5yE2rpsGs4AubNvVgqOKVjISKF2yyyXk3E2PhrWcP/rw4Jzg4A/VAifShm5uUwO0sjNjk/1YnRGXhHvx+6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43PBTVs743482374, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43PBTVs743482374
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 19:29:31 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 19:29:31 +0800
Received: from [127.0.1.1] (172.16.16.129) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 25 Apr
 2024 19:29:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <timlee@realtek.com>
Subject: [PATCH 11/12] wifi: rtw89: wow: support WEP cipher on WoWLAN
Date: Thu, 25 Apr 2024 19:28:15 +0800
Message-ID: <20240425112816.26431-12-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240425112816.26431-1-pkshih@realtek.com>
References: <20240425112816.26431-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

From: Chih-Kang Chang <gary.chang@realtek.com>

When using the WEP cipher, we need to add the address cam type as all
unicast mode to let firmware to work. Although WEP only set GTK in
mac80211, but we need to set both PTK and GTK information to firmware.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/cam.c |  7 +++++--
 drivers/net/wireless/realtek/rtw89/wow.c | 13 +++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/cam.c b/drivers/net/wireless/realtek/rtw89/cam.c
index e334b0c8ec5b..1864f543a6c6 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.c
+++ b/drivers/net/wireless/realtek/rtw89/cam.c
@@ -150,8 +150,6 @@ static int rtw89_cam_get_addr_cam_key_idx(struct rtw89_addr_cam_entry *addr_cam,
 	case RTW89_ADDR_CAM_SEC_NONE:
 		return -EINVAL;
 	case RTW89_ADDR_CAM_SEC_ALL_UNI:
-		if (!(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
-			return -EINVAL;
 		idx = find_first_zero_bit(addr_cam->sec_cam_map,
 					  RTW89_SEC_CAM_IN_ADDR_CAM);
 		if (idx >= RTW89_SEC_CAM_IN_ADDR_CAM)
@@ -232,6 +230,11 @@ static int rtw89_cam_attach_sec_cam(struct rtw89_dev *rtwdev,
 
 	rtwvif = (struct rtw89_vif *)vif->drv_priv;
 	addr_cam = rtw89_get_addr_cam_of(rtwvif, rtwsta);
+
+	if (key->cipher == WLAN_CIPHER_SUITE_WEP40 ||
+	    key->cipher == WLAN_CIPHER_SUITE_WEP104)
+		addr_cam->sec_ent_mode = RTW89_ADDR_CAM_SEC_ALL_UNI;
+
 	ret = rtw89_cam_get_addr_cam_key_idx(addr_cam, sec_cam, key, &key_idx);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to get addr cam key idx %d, %d\n",
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index f85f622893ba..434b29ae8ae9 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -310,6 +310,16 @@ static void rtw89_wow_get_key_info_iter(struct ieee80211_hw *hw,
 		if (ret)
 			goto err;
 		break;
+	case WLAN_CIPHER_SUITE_WEP40:
+	case WLAN_CIPHER_SUITE_WEP104:
+		/* WEP only set group key in mac80211, but fw need to set
+		 * both of pairwise key and group key.
+		 */
+		rtw_wow->ptk_alg = cipher_info->fw_alg;
+		rtw_wow->ptk_keyidx = key->keyidx;
+		rtw_wow->gtk_alg = cipher_info->fw_alg;
+		key_info->gtk_keyidx = key->keyidx;
+		break;
 	default:
 		rtw89_debug(rtwdev, RTW89_DBG_WOW, "unsupport cipher %x\n",
 			    key->cipher);
@@ -375,6 +385,9 @@ static void rtw89_wow_set_key_info_iter(struct ieee80211_hw *hw,
 				goto err;
 		}
 		break;
+	case WLAN_CIPHER_SUITE_WEP40:
+	case WLAN_CIPHER_SUITE_WEP104:
+		break;
 	default:
 		rtw89_debug(rtwdev, RTW89_DBG_WOW, "unsupport cipher %x\n",
 			    key->cipher);
-- 
2.25.1


