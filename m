Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D10E3F25EF
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Aug 2021 06:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbhHTEhP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Aug 2021 00:37:15 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:39207 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbhHTEhO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Aug 2021 00:37:14 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 17K4aWssD003747, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 17K4aWssD003747
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 20 Aug 2021 12:36:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 20 Aug 2021 12:36:32 +0800
Received: from localhost (172.21.69.146) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 20 Aug
 2021 12:36:31 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v6 01/24] rtw89: add CAM files
Date:   Fri, 20 Aug 2021 12:35:15 +0800
Message-ID: <20210820043538.12424-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210820043538.12424-1-pkshih@realtek.com>
References: <20210820043538.12424-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.146]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/20/2021 04:22:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzgvMjAgpFekyCAwMzowODowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 08/20/2021 04:18:54
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 165674 [Aug 20 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 454 454 39c6e442fd417993330528e7f9d13ac1bf7fdf8c
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: realtek.com:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/20/2021 04:22:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Three kinds of CAM, security, address and bssid, are implemented in the
chip, and then we control them via H2C commands.

Every vif contains one address and one bssid CAM entries, and both are
allocated while vif is adding. Once any state is changed, driver notices
firmware. For example, add/remove vif, sta assoc/disassoc, and changed
security key.

When connecting to an AP with security, a security CAM entry is allocated
from security CAM pool and filled key values, and then attached to the
address CAM that contains seven keys entries for unicast, group and BIP
keys. Since the functions of these seven keys are predefined by firmware,
we should attach key to proper position depends on security entry mode and
key type.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/cam.c | 700 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/cam.h | 165 ++++++
 2 files changed, 865 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw89/cam.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/cam.h

diff --git a/drivers/net/wireless/realtek/rtw89/cam.c b/drivers/net/wireless/realtek/rtw89/cam.c
new file mode 100644
index 000000000000..fac5b6e99089
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/cam.c
@@ -0,0 +1,700 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2019-2020  Realtek Corporation
+ */
+
+#include "cam.h"
+#include "debug.h"
+#include "fw.h"
+#include "mac.h"
+
+static struct sk_buff *
+rtw89_cam_get_sec_key_cmd(struct rtw89_dev *rtwdev,
+			  struct rtw89_sec_cam_entry *sec_cam,
+			  bool ext_key)
+{
+	struct sk_buff *skb;
+	u32 cmd_len = H2C_SEC_CAM_LEN;
+	u32 key32[4];
+	u8 *cmd;
+	int i, j;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(cmd_len);
+	if (!skb)
+		return NULL;
+
+	skb_put_zero(skb, cmd_len);
+
+	for (i = 0; i < 4; i++) {
+		j = i * 4;
+		j += ext_key ? 16 : 0;
+		key32[i] = FIELD_PREP(GENMASK(7, 0), sec_cam->key[j + 0]) |
+			   FIELD_PREP(GENMASK(15, 8), sec_cam->key[j + 1]) |
+			   FIELD_PREP(GENMASK(23, 16), sec_cam->key[j + 2]) |
+			   FIELD_PREP(GENMASK(31, 24), sec_cam->key[j + 3]);
+	}
+
+	cmd = skb->data;
+	RTW89_SET_FWCMD_SEC_IDX(cmd, sec_cam->sec_cam_idx + (ext_key ? 1 : 0));
+	RTW89_SET_FWCMD_SEC_OFFSET(cmd, sec_cam->offset);
+	RTW89_SET_FWCMD_SEC_LEN(cmd, sec_cam->len);
+	RTW89_SET_FWCMD_SEC_TYPE(cmd, sec_cam->type);
+	RTW89_SET_FWCMD_SEC_EXT_KEY(cmd, ext_key);
+	RTW89_SET_FWCMD_SEC_SPP_MODE(cmd, sec_cam->spp_mode);
+	RTW89_SET_FWCMD_SEC_KEY0(cmd, key32[0]);
+	RTW89_SET_FWCMD_SEC_KEY1(cmd, key32[1]);
+	RTW89_SET_FWCMD_SEC_KEY2(cmd, key32[2]);
+	RTW89_SET_FWCMD_SEC_KEY3(cmd, key32[3]);
+
+	return skb;
+}
+
+static int rtw89_cam_send_sec_key_cmd(struct rtw89_dev *rtwdev,
+				      struct rtw89_sec_cam_entry *sec_cam)
+{
+	struct sk_buff *skb, *ext_skb;
+	int ret;
+
+	skb = rtw89_cam_get_sec_key_cmd(rtwdev, sec_cam, false);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to get sec key command\n");
+		return -ENOMEM;
+	}
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb,
+			      FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC,
+			      H2C_CL_MAC_SEC_CAM,
+			      H2C_FUNC_MAC_SEC_UPD, 1, 0,
+			      H2C_SEC_CAM_LEN);
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to send sec key h2c: %d\n", ret);
+		dev_kfree_skb(skb);
+		return ret;
+	}
+
+	if (!sec_cam->ext_key)
+		return 0;
+
+	ext_skb = rtw89_cam_get_sec_key_cmd(rtwdev, sec_cam, true);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to get ext sec key command\n");
+		return -ENOMEM;
+	}
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, ext_skb,
+			      FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC,
+			      H2C_CL_MAC_SEC_CAM,
+			      H2C_FUNC_MAC_SEC_UPD,
+			      1, 0, H2C_SEC_CAM_LEN);
+	ret = rtw89_h2c_tx(rtwdev, ext_skb, false);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to send ext sec key h2c: %d\n", ret);
+		dev_kfree_skb(ext_skb);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int rtw89_cam_get_avail_sec_cam(struct rtw89_dev *rtwdev,
+				       u8 *sec_cam_idx, bool ext_key)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_cam_info *cam_info = &rtwdev->cam_info;
+	u8 sec_cam_num = chip->scam_num;
+	u8 idx = 0;
+
+	if (!ext_key) {
+		idx = find_first_zero_bit(cam_info->sec_cam_map, sec_cam_num);
+		if (idx >= sec_cam_num)
+			return -EBUSY;
+
+		set_bit(idx, cam_info->sec_cam_map);
+		*sec_cam_idx = idx;
+
+		return 0;
+	}
+
+again:
+	idx = find_next_zero_bit(cam_info->sec_cam_map, sec_cam_num, idx);
+	if (idx >= sec_cam_num - 1)
+		return -EBUSY;
+	/* ext keys need two cam entries for 256-bit key */
+	if (test_bit(idx + 1, cam_info->sec_cam_map)) {
+		idx++;
+		goto again;
+	}
+
+	set_bit(idx, cam_info->sec_cam_map);
+	set_bit(idx + 1, cam_info->sec_cam_map);
+	*sec_cam_idx = idx;
+
+	return 0;
+}
+
+static int rtw89_cam_get_addr_cam_key_idx(struct rtw89_addr_cam_entry *addr_cam,
+					  struct rtw89_sec_cam_entry *sec_cam,
+					  struct ieee80211_key_conf *key,
+					  u8 *key_idx)
+{
+	u8 idx;
+
+	/* RTW89_ADDR_CAM_SEC_NONE	: not enabled
+	 * RTW89_ADDR_CAM_SEC_ALL_UNI	: 0 - 6 unicast
+	 * RTW89_ADDR_CAM_SEC_NORMAL	: 0 - 1 unicast, 2 - 4 group, 5 - 6 BIP
+	 * RTW89_ADDR_CAM_SEC_4GROUP	: 0 - 1 unicast, 2 - 5 group, 6 BIP
+	 */
+	switch (addr_cam->sec_ent_mode) {
+	case RTW89_ADDR_CAM_SEC_NONE:
+		return -EINVAL;
+	case RTW89_ADDR_CAM_SEC_ALL_UNI:
+		if (!(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
+			return -EINVAL;
+		idx = find_first_zero_bit(addr_cam->sec_cam_map,
+					  RTW89_SEC_CAM_IN_ADDR_CAM);
+		if (idx >= RTW89_SEC_CAM_IN_ADDR_CAM)
+			return -EBUSY;
+		*key_idx = idx;
+		break;
+	case RTW89_ADDR_CAM_SEC_NORMAL:
+		if (sec_cam->type == RTW89_SEC_KEY_TYPE_BIP_CCMP128) {
+			idx = find_next_zero_bit(addr_cam->sec_cam_map,
+						 RTW89_SEC_CAM_IN_ADDR_CAM, 5);
+			if (idx > 6)
+				return -EBUSY;
+			*key_idx = idx;
+			break;
+		}
+
+		if (key->flags & IEEE80211_KEY_FLAG_PAIRWISE) {
+			idx = find_next_zero_bit(addr_cam->sec_cam_map,
+						 RTW89_SEC_CAM_IN_ADDR_CAM, 0);
+			if (idx > 1)
+				return -EBUSY;
+			*key_idx = idx;
+			break;
+		}
+
+		/* Group keys */
+		idx = find_next_zero_bit(addr_cam->sec_cam_map,
+					 RTW89_SEC_CAM_IN_ADDR_CAM, 2);
+		if (idx > 4)
+			return -EBUSY;
+		*key_idx = idx;
+		break;
+	case RTW89_ADDR_CAM_SEC_4GROUP:
+		if (sec_cam->type == RTW89_SEC_KEY_TYPE_BIP_CCMP128) {
+			if (test_bit(6, addr_cam->sec_cam_map))
+				return -EINVAL;
+			*key_idx = 6;
+			break;
+		}
+
+		if (key->flags & IEEE80211_KEY_FLAG_PAIRWISE) {
+			idx = find_next_zero_bit(addr_cam->sec_cam_map,
+						 RTW89_SEC_CAM_IN_ADDR_CAM, 0);
+			if (idx > 1)
+				return -EBUSY;
+			*key_idx = idx;
+			break;
+		}
+
+		/* Group keys */
+		idx = find_next_zero_bit(addr_cam->sec_cam_map,
+					 RTW89_SEC_CAM_IN_ADDR_CAM, 2);
+		if (idx > 5)
+			return -EBUSY;
+		*key_idx = idx;
+		break;
+	}
+
+	return 0;
+}
+
+static int rtw89_cam_attach_sec_cam(struct rtw89_dev *rtwdev,
+				    struct ieee80211_vif *vif,
+				    struct ieee80211_sta *sta,
+				    struct ieee80211_key_conf *key,
+				    struct rtw89_sec_cam_entry *sec_cam)
+{
+	struct rtw89_vif *rtwvif;
+	struct rtw89_addr_cam_entry *addr_cam;
+	u8 key_idx = 0;
+	int ret;
+
+	if (!vif) {
+		rtw89_err(rtwdev, "No iface for adding sec cam\n");
+		return -EINVAL;
+	}
+
+	rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	addr_cam = &rtwvif->addr_cam;
+	ret = rtw89_cam_get_addr_cam_key_idx(addr_cam, sec_cam, key, &key_idx);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to get addr cam key idx %d, %d\n",
+			  addr_cam->sec_ent_mode, sec_cam->type);
+		return ret;
+	}
+
+	key->hw_key_idx = key_idx;
+	addr_cam->sec_ent_keyid[key_idx] = key->keyidx;
+	addr_cam->sec_ent[key_idx] = sec_cam->sec_cam_idx;
+	addr_cam->sec_entries[key_idx] = sec_cam;
+	set_bit(key_idx, addr_cam->sec_cam_map);
+	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to update addr cam sec entry: %d\n",
+			  ret);
+		clear_bit(key_idx, addr_cam->sec_cam_map);
+		addr_cam->sec_entries[key_idx] = NULL;
+		return ret;
+	}
+
+	return 0;
+}
+
+static int rtw89_cam_sec_key_install(struct rtw89_dev *rtwdev,
+				     struct ieee80211_vif *vif,
+				     struct ieee80211_sta *sta,
+				     struct ieee80211_key_conf *key,
+				     u8 hw_key_type, bool ext_key)
+{
+	struct rtw89_sec_cam_entry *sec_cam = NULL;
+	struct rtw89_cam_info *cam_info = &rtwdev->cam_info;
+	u8 sec_cam_idx;
+	int ret;
+
+	/* maximum key length 256-bit */
+	if (key->keylen > 32) {
+		rtw89_err(rtwdev, "invalid sec key length %d\n", key->keylen);
+		return -EINVAL;
+	}
+
+	ret = rtw89_cam_get_avail_sec_cam(rtwdev, &sec_cam_idx, ext_key);
+	if (ret) {
+		rtw89_warn(rtwdev, "no available sec cam: %d ext: %d\n",
+			   ret, ext_key);
+		return ret;
+	}
+
+	sec_cam = kzalloc(sizeof(*sec_cam), GFP_KERNEL);
+	if (!sec_cam) {
+		ret = -ENOMEM;
+		goto err_release_cam;
+	}
+
+	sec_cam->sec_cam_idx = sec_cam_idx;
+	sec_cam->type = hw_key_type;
+	sec_cam->len = RTW89_SEC_CAM_LEN;
+	sec_cam->ext_key = ext_key;
+	memcpy(sec_cam->key, key->key, key->keylen);
+	ret = rtw89_cam_send_sec_key_cmd(rtwdev, sec_cam);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to send sec key cmd: %d\n", ret);
+		goto err_release_cam;
+	}
+
+	/* associate with addr cam */
+	ret = rtw89_cam_attach_sec_cam(rtwdev, vif, sta, key, sec_cam);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to attach sec cam: %d\n", ret);
+		goto err_release_cam;
+	}
+
+	return 0;
+
+err_release_cam:
+	kfree(sec_cam);
+	clear_bit(sec_cam_idx, cam_info->sec_cam_map);
+	if (ext_key)
+		clear_bit(sec_cam_idx + 1, cam_info->sec_cam_map);
+
+	return ret;
+}
+
+int rtw89_cam_sec_key_add(struct rtw89_dev *rtwdev,
+			  struct ieee80211_vif *vif,
+			  struct ieee80211_sta *sta,
+			  struct ieee80211_key_conf *key)
+{
+	u8 hw_key_type;
+	bool ext_key = false;
+	int ret;
+
+	switch (key->cipher) {
+	case WLAN_CIPHER_SUITE_WEP40:
+		hw_key_type = RTW89_SEC_KEY_TYPE_WEP40;
+		break;
+	case WLAN_CIPHER_SUITE_WEP104:
+		hw_key_type = RTW89_SEC_KEY_TYPE_WEP104;
+		break;
+	case WLAN_CIPHER_SUITE_CCMP:
+		hw_key_type = RTW89_SEC_KEY_TYPE_CCMP128;
+		key->flags |= IEEE80211_KEY_FLAG_SW_MGMT_TX;
+		break;
+	case WLAN_CIPHER_SUITE_CCMP_256:
+		hw_key_type = RTW89_SEC_KEY_TYPE_CCMP256;
+		key->flags |= IEEE80211_KEY_FLAG_SW_MGMT_TX;
+		ext_key = true;
+		break;
+	case WLAN_CIPHER_SUITE_GCMP:
+		hw_key_type = RTW89_SEC_KEY_TYPE_GCMP128;
+		key->flags |= IEEE80211_KEY_FLAG_SW_MGMT_TX;
+		break;
+	case WLAN_CIPHER_SUITE_GCMP_256:
+		hw_key_type = RTW89_SEC_KEY_TYPE_GCMP256;
+		key->flags |= IEEE80211_KEY_FLAG_SW_MGMT_TX;
+		ext_key = true;
+		break;
+	case WLAN_CIPHER_SUITE_TKIP:
+	case WLAN_CIPHER_SUITE_AES_CMAC:
+	case WLAN_CIPHER_SUITE_BIP_CMAC_256:
+	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
+	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
+		/* suppress error messages */
+		return -EOPNOTSUPP;
+	default:
+		return -ENOTSUPP;
+	}
+
+	key->flags |= IEEE80211_KEY_FLAG_GENERATE_IV;
+
+	ret = rtw89_cam_sec_key_install(rtwdev, vif, sta, key, hw_key_type,
+					ext_key);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to install key type %d ext %d: %d\n",
+			  hw_key_type, ext_key, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+int rtw89_cam_sec_key_del(struct rtw89_dev *rtwdev,
+			  struct ieee80211_vif *vif,
+			  struct ieee80211_sta *sta,
+			  struct ieee80211_key_conf *key,
+			  bool inform_fw)
+{
+	struct rtw89_cam_info *cam_info = &rtwdev->cam_info;
+	struct rtw89_vif *rtwvif;
+	struct rtw89_addr_cam_entry *addr_cam;
+	struct rtw89_sec_cam_entry *sec_cam;
+	u8 key_idx = key->hw_key_idx;
+	u8 sec_cam_idx;
+	int ret = 0;
+
+	if (!vif) {
+		rtw89_err(rtwdev, "No iface for deleting sec cam\n");
+		return -EINVAL;
+	}
+
+	rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	addr_cam = &rtwvif->addr_cam;
+	sec_cam = addr_cam->sec_entries[key_idx];
+
+	/* detach sec cam from addr cam */
+	clear_bit(key_idx, addr_cam->sec_cam_map);
+	addr_cam->sec_entries[key_idx] = NULL;
+	if (inform_fw) {
+		ret = rtw89_fw_h2c_cam(rtwdev, rtwvif);
+		if (ret)
+			rtw89_err(rtwdev, "failed to update cam del key: %d\n", ret);
+	}
+
+	/* clear valid bit in addr cam will disable sec cam,
+	 * so we don't need to send H2C command again
+	 */
+	sec_cam_idx = sec_cam->sec_cam_idx;
+	clear_bit(sec_cam_idx, cam_info->sec_cam_map);
+	if (sec_cam->ext_key)
+		clear_bit(sec_cam_idx + 1, cam_info->sec_cam_map);
+
+	kfree(sec_cam);
+
+	return ret;
+}
+
+static void rtw89_cam_reset_key_iter(struct ieee80211_hw *hw,
+				     struct ieee80211_vif *vif,
+				     struct ieee80211_sta *sta,
+				     struct ieee80211_key_conf *key,
+				     void *data)
+{
+	struct rtw89_dev *rtwdev = (struct rtw89_dev *)data;
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+
+	rtw89_cam_sec_key_del(rtwdev, vif, sta, key, false);
+	rtw89_cam_deinit(rtwdev, rtwvif);
+}
+
+void rtw89_cam_deinit(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+{
+	struct rtw89_cam_info *cam_info = &rtwdev->cam_info;
+	struct rtw89_addr_cam_entry *addr_cam = &rtwvif->addr_cam;
+	struct rtw89_bssid_cam_entry *bssid_cam = &rtwvif->bssid_cam;
+
+	addr_cam->valid = false;
+	bssid_cam->valid = false;
+	clear_bit(addr_cam->addr_cam_idx, cam_info->addr_cam_map);
+	clear_bit(bssid_cam->bssid_cam_idx, cam_info->bssid_cam_map);
+}
+
+void rtw89_cam_reset_keys(struct rtw89_dev *rtwdev)
+{
+	rcu_read_lock();
+	ieee80211_iter_keys_rcu(rtwdev->hw, NULL, rtw89_cam_reset_key_iter, rtwdev);
+	rcu_read_unlock();
+}
+
+static int rtw89_cam_get_avail_addr_cam(struct rtw89_dev *rtwdev,
+					u8 *addr_cam_idx)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_cam_info *cam_info = &rtwdev->cam_info;
+	u8 addr_cam_num = chip->acam_num;
+	u8 idx;
+
+	idx = find_first_zero_bit(cam_info->addr_cam_map, addr_cam_num);
+	if (idx >= addr_cam_num)
+		return -EBUSY;
+
+	set_bit(idx, cam_info->addr_cam_map);
+	*addr_cam_idx = idx;
+
+	return 0;
+}
+
+static int rtw89_cam_init_addr_cam(struct rtw89_dev *rtwdev,
+				   struct rtw89_vif *rtwvif)
+{
+	struct rtw89_addr_cam_entry *addr_cam = &rtwvif->addr_cam;
+	u8 addr_cam_idx;
+	int i;
+	int ret;
+
+	ret = rtw89_cam_get_avail_addr_cam(rtwdev, &addr_cam_idx);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to get available addr cam\n");
+		return ret;
+	}
+
+	addr_cam->addr_cam_idx = addr_cam_idx;
+	addr_cam->len = ADDR_CAM_ENT_SIZE;
+	addr_cam->offset = 0;
+	addr_cam->valid = true;
+	addr_cam->addr_mask = 0;
+	addr_cam->mask_sel = RTW89_NO_MSK;
+	bitmap_zero(addr_cam->sec_cam_map, RTW89_SEC_CAM_IN_ADDR_CAM);
+	ether_addr_copy(addr_cam->sma, rtwvif->mac_addr);
+
+	for (i = 0; i < RTW89_SEC_CAM_IN_ADDR_CAM; i++) {
+		addr_cam->sec_ent_keyid[i] = 0;
+		addr_cam->sec_ent[i] = 0;
+	}
+
+	return 0;
+}
+
+static int rtw89_cam_get_avail_bssid_cam(struct rtw89_dev *rtwdev,
+					 u8 *bssid_cam_idx)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_cam_info *cam_info = &rtwdev->cam_info;
+	u8 bssid_cam_num = chip->bcam_num;
+	u8 idx;
+
+	idx = find_first_zero_bit(cam_info->bssid_cam_map, bssid_cam_num);
+	if (idx >= bssid_cam_num)
+		return -EBUSY;
+
+	set_bit(idx, cam_info->bssid_cam_map);
+	*bssid_cam_idx = idx;
+
+	return 0;
+}
+
+static int rtw89_cam_init_bssid_cam(struct rtw89_dev *rtwdev,
+				    struct rtw89_vif *rtwvif)
+{
+	struct rtw89_bssid_cam_entry *bssid_cam = &rtwvif->bssid_cam;
+	u8 bssid_cam_idx;
+	int ret;
+
+	ret = rtw89_cam_get_avail_bssid_cam(rtwdev, &bssid_cam_idx);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to get available bssid cam\n");
+		return ret;
+	}
+
+	bssid_cam->bssid_cam_idx = bssid_cam_idx;
+	bssid_cam->phy_idx = rtwvif->phy_idx;
+	bssid_cam->len = BSSID_CAM_ENT_SIZE;
+	bssid_cam->offset = 0;
+	bssid_cam->valid = true;
+	ether_addr_copy(bssid_cam->bssid, rtwvif->bssid);
+
+	return 0;
+}
+
+void rtw89_cam_bssid_changed(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+{
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+	struct rtw89_addr_cam_entry *addr_cam = &rtwvif->addr_cam;
+	struct rtw89_bssid_cam_entry *bssid_cam = &rtwvif->bssid_cam;
+
+	if (vif->type == NL80211_IFTYPE_STATION)
+		ether_addr_copy(addr_cam->tma, rtwvif->bssid);
+	ether_addr_copy(bssid_cam->bssid, rtwvif->bssid);
+}
+
+int rtw89_cam_init(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+{
+	struct rtw89_addr_cam_entry *addr_cam = &rtwvif->addr_cam;
+	struct rtw89_bssid_cam_entry *bssid_cam = &rtwvif->bssid_cam;
+	int ret;
+
+	ret = rtw89_cam_init_addr_cam(rtwdev, rtwvif);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to init addr cam\n");
+		return ret;
+	}
+
+	ret = rtw89_cam_init_bssid_cam(rtwdev, rtwvif);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to init bssid cam\n");
+		return ret;
+	}
+
+	/* associate addr cam with bssid cam */
+	addr_cam->bssid_cam_idx = bssid_cam->bssid_cam_idx;
+
+	return 0;
+}
+
+int rtw89_cam_fill_bssid_cam_info(struct rtw89_dev *rtwdev,
+				  struct rtw89_vif *rtwvif, u8 *cmd)
+{
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+	struct rtw89_bssid_cam_entry *bssid_cam = &rtwvif->bssid_cam;
+	u8 bss_color = vif->bss_conf.he_bss_color.color;
+
+	FWCMD_SET_ADDR_BSSID_IDX(cmd, bssid_cam->bssid_cam_idx);
+	FWCMD_SET_ADDR_BSSID_OFFSET(cmd, bssid_cam->offset);
+	FWCMD_SET_ADDR_BSSID_LEN(cmd, bssid_cam->len);
+	FWCMD_SET_ADDR_BSSID_VALID(cmd, bssid_cam->valid);
+	FWCMD_SET_ADDR_BSSID_BB_SEL(cmd, bssid_cam->phy_idx);
+	FWCMD_SET_ADDR_BSSID_BSS_COLOR(cmd, bss_color);
+
+	FWCMD_SET_ADDR_BSSID_BSSID0(cmd, bssid_cam->bssid[0]);
+	FWCMD_SET_ADDR_BSSID_BSSID1(cmd, bssid_cam->bssid[1]);
+	FWCMD_SET_ADDR_BSSID_BSSID2(cmd, bssid_cam->bssid[2]);
+	FWCMD_SET_ADDR_BSSID_BSSID3(cmd, bssid_cam->bssid[3]);
+	FWCMD_SET_ADDR_BSSID_BSSID4(cmd, bssid_cam->bssid[4]);
+	FWCMD_SET_ADDR_BSSID_BSSID5(cmd, bssid_cam->bssid[5]);
+
+	return 0;
+}
+
+static u8 rtw89_cam_addr_hash(u8 start, u8 *addr)
+{
+	u8 hash = 0;
+	u8 i;
+
+	for (i = start; i < ETH_ALEN; i++)
+		hash ^= addr[i];
+
+	return hash;
+}
+
+void rtw89_cam_fill_addr_cam_info(struct rtw89_dev *rtwdev,
+				  struct rtw89_vif *rtwvif,
+				  u8 *cmd)
+{
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+	struct ieee80211_sta *sta;
+	struct rtw89_sta *rtwsta;
+	struct rtw89_addr_cam_entry *addr_cam = &rtwvif->addr_cam;
+	u8 sma_hash, tma_hash, addr_msk_start;
+	u8 sma_start = 0;
+	u8 tma_start = 0;
+
+	if (addr_cam->addr_mask != 0) {
+		addr_msk_start = __ffs(addr_cam->addr_mask);
+		if (addr_cam->mask_sel == RTW89_SMA)
+			sma_start = addr_msk_start;
+		else if (addr_cam->mask_sel == RTW89_TMA)
+			tma_start = addr_msk_start;
+	}
+	sma_hash = rtw89_cam_addr_hash(sma_start, rtwvif->mac_addr);
+	tma_hash = rtw89_cam_addr_hash(tma_start, addr_cam->tma);
+
+	FWCMD_SET_ADDR_IDX(cmd, addr_cam->addr_cam_idx);
+	FWCMD_SET_ADDR_OFFSET(cmd, addr_cam->offset);
+	FWCMD_SET_ADDR_LEN(cmd, addr_cam->len);
+
+	FWCMD_SET_ADDR_VALID(cmd, addr_cam->valid);
+	FWCMD_SET_ADDR_NET_TYPE(cmd, rtwvif->net_type);
+	FWCMD_SET_ADDR_BCN_HIT_COND(cmd, rtwvif->bcn_hit_cond);
+	FWCMD_SET_ADDR_HIT_RULE(cmd, rtwvif->hit_rule);
+	FWCMD_SET_ADDR_BB_SEL(cmd, rtwvif->phy_idx);
+	FWCMD_SET_ADDR_ADDR_MASK(cmd, addr_cam->addr_mask);
+	FWCMD_SET_ADDR_MASK_SEL(cmd, addr_cam->mask_sel);
+	FWCMD_SET_ADDR_SMA_HASH(cmd, sma_hash);
+	FWCMD_SET_ADDR_TMA_HASH(cmd, tma_hash);
+
+	FWCMD_SET_ADDR_BSSID_CAM_IDX(cmd, addr_cam->bssid_cam_idx);
+
+	FWCMD_SET_ADDR_SMA0(cmd, rtwvif->mac_addr[0]);
+	FWCMD_SET_ADDR_SMA1(cmd, rtwvif->mac_addr[1]);
+	FWCMD_SET_ADDR_SMA2(cmd, rtwvif->mac_addr[2]);
+	FWCMD_SET_ADDR_SMA3(cmd, rtwvif->mac_addr[3]);
+	FWCMD_SET_ADDR_SMA4(cmd, rtwvif->mac_addr[4]);
+	FWCMD_SET_ADDR_SMA5(cmd, rtwvif->mac_addr[5]);
+
+	FWCMD_SET_ADDR_TMA0(cmd, addr_cam->tma[0]);
+	FWCMD_SET_ADDR_TMA1(cmd, addr_cam->tma[1]);
+	FWCMD_SET_ADDR_TMA2(cmd, addr_cam->tma[2]);
+	FWCMD_SET_ADDR_TMA3(cmd, addr_cam->tma[3]);
+	FWCMD_SET_ADDR_TMA4(cmd, addr_cam->tma[4]);
+	FWCMD_SET_ADDR_TMA5(cmd, addr_cam->tma[5]);
+
+	FWCMD_SET_ADDR_PORT_INT(cmd, rtwvif->port);
+	FWCMD_SET_ADDR_TSF_SYNC(cmd, rtwvif->port);
+	FWCMD_SET_ADDR_TF_TRS(cmd, rtwvif->trigger);
+	FWCMD_SET_ADDR_LSIG_TXOP(cmd, rtwvif->lsig_txop);
+	FWCMD_SET_ADDR_TGT_IND(cmd, rtwvif->tgt_ind);
+	FWCMD_SET_ADDR_FRM_TGT_IND(cmd, rtwvif->frm_tgt_ind);
+
+	if (vif->type == NL80211_IFTYPE_STATION) {
+		sta = rtwvif->mgd.ap;
+		if (sta) {
+			rtwsta = (struct rtw89_sta *)sta->drv_priv;
+			FWCMD_SET_ADDR_MACID(cmd, rtwsta->mac_id);
+			FWCMD_SET_ADDR_AID12(cmd, vif->bss_conf.aid & 0xfff);
+		}
+	}
+	FWCMD_SET_ADDR_WOL_PATTERN(cmd, rtwvif->wowlan_pattern);
+	FWCMD_SET_ADDR_WOL_UC(cmd, rtwvif->wowlan_uc);
+	FWCMD_SET_ADDR_WOL_MAGIC(cmd, rtwvif->wowlan_magic);
+	FWCMD_SET_ADDR_WAPI(cmd, addr_cam->wapi);
+	FWCMD_SET_ADDR_SEC_ENT_MODE(cmd, addr_cam->sec_ent_mode);
+	FWCMD_SET_ADDR_SEC_ENT0_KEYID(cmd, addr_cam->sec_ent_keyid[0]);
+	FWCMD_SET_ADDR_SEC_ENT1_KEYID(cmd, addr_cam->sec_ent_keyid[1]);
+	FWCMD_SET_ADDR_SEC_ENT2_KEYID(cmd, addr_cam->sec_ent_keyid[2]);
+	FWCMD_SET_ADDR_SEC_ENT3_KEYID(cmd, addr_cam->sec_ent_keyid[3]);
+	FWCMD_SET_ADDR_SEC_ENT4_KEYID(cmd, addr_cam->sec_ent_keyid[4]);
+	FWCMD_SET_ADDR_SEC_ENT5_KEYID(cmd, addr_cam->sec_ent_keyid[5]);
+	FWCMD_SET_ADDR_SEC_ENT6_KEYID(cmd, addr_cam->sec_ent_keyid[6]);
+
+	FWCMD_SET_ADDR_SEC_ENT_VALID(cmd, addr_cam->sec_cam_map[0] & 0xff);
+	FWCMD_SET_ADDR_SEC_ENT0(cmd, addr_cam->sec_ent[0]);
+	FWCMD_SET_ADDR_SEC_ENT1(cmd, addr_cam->sec_ent[1]);
+	FWCMD_SET_ADDR_SEC_ENT2(cmd, addr_cam->sec_ent[2]);
+	FWCMD_SET_ADDR_SEC_ENT3(cmd, addr_cam->sec_ent[3]);
+	FWCMD_SET_ADDR_SEC_ENT4(cmd, addr_cam->sec_ent[4]);
+	FWCMD_SET_ADDR_SEC_ENT5(cmd, addr_cam->sec_ent[5]);
+	FWCMD_SET_ADDR_SEC_ENT6(cmd, addr_cam->sec_ent[6]);
+}
diff --git a/drivers/net/wireless/realtek/rtw89/cam.h b/drivers/net/wireless/realtek/rtw89/cam.h
new file mode 100644
index 000000000000..90a20a5375c6
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/cam.h
@@ -0,0 +1,165 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2019-2020  Realtek Corporation
+ */
+
+#ifndef __RTW89_CAM_H__
+#define __RTW89_CAM_H__
+
+#include "core.h"
+
+#define RTW89_SEC_CAM_LEN	20
+
+#define FWCMD_SET_ADDR_IDX(cmd, value)					\
+	le32p_replace_bits((__le32 *)(cmd) + 1, value, GENMASK(7, 0))
+#define FWCMD_SET_ADDR_OFFSET(cmd, value)				\
+	le32p_replace_bits((__le32 *)(cmd) + 1, value, GENMASK(15, 8))
+#define FWCMD_SET_ADDR_LEN(cmd, value)					\
+	le32p_replace_bits((__le32 *)(cmd) + 1, value, GENMASK(23, 16))
+#define FWCMD_SET_ADDR_VALID(cmd, value)				\
+	le32p_replace_bits((__le32 *)(cmd) + 2, value, BIT(0))
+#define FWCMD_SET_ADDR_NET_TYPE(cmd, value)				\
+	le32p_replace_bits((__le32 *)(cmd) + 2, value, GENMASK(2, 1))
+#define FWCMD_SET_ADDR_BCN_HIT_COND(cmd, value)				\
+	le32p_replace_bits((__le32 *)(cmd) + 2, value, GENMASK(4, 3))
+#define FWCMD_SET_ADDR_HIT_RULE(cmd, value)				\
+	le32p_replace_bits((__le32 *)(cmd) + 2, value, GENMASK(6, 5))
+#define FWCMD_SET_ADDR_BB_SEL(cmd, value)				\
+	le32p_replace_bits((__le32 *)(cmd) + 2, value, BIT(7))
+#define FWCMD_SET_ADDR_ADDR_MASK(cmd, value)				\
+	le32p_replace_bits((__le32 *)(cmd) + 2, value, GENMASK(13, 8))
+#define FWCMD_SET_ADDR_MASK_SEL(cmd, value)				\
+	le32p_replace_bits((__le32 *)(cmd) + 2, value, GENMASK(15, 14))
+#define FWCMD_SET_ADDR_SMA_HASH(cmd, value)				\
+	le32p_replace_bits((__le32 *)(cmd) + 2, value, GENMASK(23, 16))
+#define FWCMD_SET_ADDR_TMA_HASH(cmd, value)				\
+	le32p_replace_bits((__le32 *)(cmd) + 2, value, GENMASK(31, 24))
+#define FWCMD_SET_ADDR_BSSID_CAM_IDX(cmd, value)			\
+	le32p_replace_bits((__le32 *)(cmd) + 3, value, GENMASK(5, 0))
+#define FWCMD_SET_ADDR_SMA0(cmd, value)					\
+	le32p_replace_bits((__le32 *)(cmd) + 4, value, GENMASK(7, 0))
+#define FWCMD_SET_ADDR_SMA1(cmd, value)					\
+	le32p_replace_bits((__le32 *)(cmd) + 4, value, GENMASK(15, 8))
+#define FWCMD_SET_ADDR_SMA2(cmd, value)					\
+	le32p_replace_bits((__le32 *)(cmd) + 4, value, GENMASK(23, 16))
+#define FWCMD_SET_ADDR_SMA3(cmd, value)					\
+	le32p_replace_bits((__le32 *)(cmd) + 4, value, GENMASK(31, 24))
+#define FWCMD_SET_ADDR_SMA4(cmd, value)					\
+	le32p_replace_bits((__le32 *)(cmd) + 5, value, GENMASK(7, 0))
+#define FWCMD_SET_ADDR_SMA5(cmd, value)					\
+	le32p_replace_bits((__le32 *)(cmd) + 5, value, GENMASK(15, 8))
+#define FWCMD_SET_ADDR_TMA0(cmd, value)					\
+	le32p_replace_bits((__le32 *)(cmd) + 5, value, GENMASK(23, 16))
+#define FWCMD_SET_ADDR_TMA1(cmd, value)					\
+	le32p_replace_bits((__le32 *)(cmd) + 5, value, GENMASK(31, 24))
+#define FWCMD_SET_ADDR_TMA2(cmd, value)					\
+	le32p_replace_bits((__le32 *)(cmd) + 6, value, GENMASK(7, 0))
+#define FWCMD_SET_ADDR_TMA3(cmd, value)					\
+	le32p_replace_bits((__le32 *)(cmd) + 6, value, GENMASK(15, 8))
+#define FWCMD_SET_ADDR_TMA4(cmd, value)					\
+	le32p_replace_bits((__le32 *)(cmd) + 6, value, GENMASK(23, 16))
+#define FWCMD_SET_ADDR_TMA5(cmd, value)					\
+	le32p_replace_bits((__le32 *)(cmd) + 6, value, GENMASK(31, 24))
+#define FWCMD_SET_ADDR_MACID(cmd, value)				\
+	le32p_replace_bits((__le32 *)(cmd) + 8, value, GENMASK(7, 0))
+#define FWCMD_SET_ADDR_PORT_INT(cmd, value)				\
+	le32p_replace_bits((__le32 *)(cmd) + 8, value, GENMASK(10, 8))
+#define FWCMD_SET_ADDR_TSF_SYNC(cmd, value)				\
+	le32p_replace_bits((__le32 *)(cmd) + 8, value, GENMASK(13, 11))
+#define FWCMD_SET_ADDR_TF_TRS(cmd, value)				\
+	le32p_replace_bits((__le32 *)(cmd) + 8, value, BIT(14))
+#define FWCMD_SET_ADDR_LSIG_TXOP(cmd, value)				\
+	le32p_replace_bits((__le32 *)(cmd) + 8, value, BIT(15))
+#define FWCMD_SET_ADDR_TGT_IND(cmd, value)				\
+	le32p_replace_bits((__le32 *)(cmd) + 8, value, GENMASK(26, 24))
+#define FWCMD_SET_ADDR_FRM_TGT_IND(cmd, value)				\
+	le32p_replace_bits((__le32 *)(cmd) + 8, value, GENMASK(29, 27))
+#define FWCMD_SET_ADDR_AID12(cmd, value)				\
+	le32p_replace_bits((__le32 *)(cmd) + 9, value, GENMASK(11, 0))
+#define FWCMD_SET_ADDR_AID12_0(cmd, value)				\
+	le32p_replace_bits((__le32 *)(cmd) + 9, value, GENMASK(7, 0))
+#define FWCMD_SET_ADDR_AID12_1(cmd, value)				\
+	le32p_replace_bits((__le32 *)(cmd) + 9, value, GENMASK(11, 8))
+#define FWCMD_SET_ADDR_WOL_PATTERN(cmd, value)				\
+	le32p_replace_bits((__le32 *)(cmd) + 9, value, BIT(12))
+#define FWCMD_SET_ADDR_WOL_UC(cmd, value)				\
+	le32p_replace_bits((__le32 *)(cmd) + 9, value, BIT(13))
+#define FWCMD_SET_ADDR_WOL_MAGIC(cmd, value)				\
+	le32p_replace_bits((__le32 *)(cmd) + 9, value, BIT(14))
+#define FWCMD_SET_ADDR_WAPI(cmd, value)					\
+	le32p_replace_bits((__le32 *)(cmd) + 9, value, BIT(15))
+#define FWCMD_SET_ADDR_SEC_ENT_MODE(cmd, value)				\
+	le32p_replace_bits((__le32 *)(cmd) + 9, value, GENMASK(17, 16))
+#define FWCMD_SET_ADDR_SEC_ENT0_KEYID(cmd, value)			\
+	le32p_replace_bits((__le32 *)(cmd) + 9, value, GENMASK(19, 18))
+#define FWCMD_SET_ADDR_SEC_ENT1_KEYID(cmd, value)			\
+	le32p_replace_bits((__le32 *)(cmd) + 9, value, GENMASK(21, 20))
+#define FWCMD_SET_ADDR_SEC_ENT2_KEYID(cmd, value)			\
+	le32p_replace_bits((__le32 *)(cmd) + 9, value, GENMASK(23, 22))
+#define FWCMD_SET_ADDR_SEC_ENT3_KEYID(cmd, value)			\
+	le32p_replace_bits((__le32 *)(cmd) + 9, value, GENMASK(25, 24))
+#define FWCMD_SET_ADDR_SEC_ENT4_KEYID(cmd, value)			\
+	le32p_replace_bits((__le32 *)(cmd) + 9, value, GENMASK(27, 26))
+#define FWCMD_SET_ADDR_SEC_ENT5_KEYID(cmd, value)			\
+	le32p_replace_bits((__le32 *)(cmd) + 9, value, GENMASK(29, 28))
+#define FWCMD_SET_ADDR_SEC_ENT6_KEYID(cmd, value)			\
+	le32p_replace_bits((__le32 *)(cmd) + 9, value, GENMASK(31, 30))
+#define FWCMD_SET_ADDR_SEC_ENT_VALID(cmd, value)			\
+	le32p_replace_bits((__le32 *)(cmd) + 10, value, GENMASK(7, 0))
+#define FWCMD_SET_ADDR_SEC_ENT0(cmd, value)				\
+	le32p_replace_bits((__le32 *)(cmd) + 10, value, GENMASK(15, 8))
+#define FWCMD_SET_ADDR_SEC_ENT1(cmd, value)				\
+	le32p_replace_bits((__le32 *)(cmd) + 10, value, GENMASK(23, 16))
+#define FWCMD_SET_ADDR_SEC_ENT2(cmd, value)				\
+	le32p_replace_bits((__le32 *)(cmd) + 10, value, GENMASK(31, 24))
+#define FWCMD_SET_ADDR_SEC_ENT3(cmd, value)				\
+	le32p_replace_bits((__le32 *)(cmd) + 11, value, GENMASK(7, 0))
+#define FWCMD_SET_ADDR_SEC_ENT4(cmd, value)				\
+	le32p_replace_bits((__le32 *)(cmd) + 11, value, GENMASK(15, 8))
+#define FWCMD_SET_ADDR_SEC_ENT5(cmd, value)				\
+	le32p_replace_bits((__le32 *)(cmd) + 11, value, GENMASK(23, 16))
+#define FWCMD_SET_ADDR_SEC_ENT6(cmd, value)				\
+	le32p_replace_bits((__le32 *)(cmd) + 11, value, GENMASK(31, 24))
+#define FWCMD_SET_ADDR_BSSID_IDX(cmd, value)				\
+	le32p_replace_bits((__le32 *)(cmd) + 12, value, GENMASK(7, 0))
+#define FWCMD_SET_ADDR_BSSID_OFFSET(cmd, value)				\
+	le32p_replace_bits((__le32 *)(cmd) + 12, value, GENMASK(15, 8))
+#define FWCMD_SET_ADDR_BSSID_LEN(cmd, value)				\
+	le32p_replace_bits((__le32 *)(cmd) + 12, value, GENMASK(23, 16))
+#define FWCMD_SET_ADDR_BSSID_VALID(cmd, value)				\
+	le32p_replace_bits((__le32 *)(cmd) + 13, value, BIT(0))
+#define FWCMD_SET_ADDR_BSSID_BB_SEL(cmd, value)				\
+	le32p_replace_bits((__le32 *)(cmd) + 13, value, BIT(1))
+#define FWCMD_SET_ADDR_BSSID_BSS_COLOR(cmd, value)			\
+	le32p_replace_bits((__le32 *)(cmd) + 13, value, GENMASK(13, 8))
+#define FWCMD_SET_ADDR_BSSID_BSSID0(cmd, value)				\
+	le32p_replace_bits((__le32 *)(cmd) + 13, value, GENMASK(23, 16))
+#define FWCMD_SET_ADDR_BSSID_BSSID1(cmd, value)				\
+	le32p_replace_bits((__le32 *)(cmd) + 13, value, GENMASK(31, 24))
+#define FWCMD_SET_ADDR_BSSID_BSSID2(cmd, value)				\
+	le32p_replace_bits((__le32 *)(cmd) + 14, value, GENMASK(7, 0))
+#define FWCMD_SET_ADDR_BSSID_BSSID3(cmd, value)				\
+	le32p_replace_bits((__le32 *)(cmd) + 14, value, GENMASK(15, 8))
+#define FWCMD_SET_ADDR_BSSID_BSSID4(cmd, value)				\
+	le32p_replace_bits((__le32 *)(cmd) + 14, value, GENMASK(23, 16))
+#define FWCMD_SET_ADDR_BSSID_BSSID5(cmd, value)				\
+	le32p_replace_bits((__le32 *)(cmd) + 14, value, GENMASK(31, 24))
+
+int rtw89_cam_init(struct rtw89_dev *rtwdev, struct rtw89_vif *vif);
+void rtw89_cam_deinit(struct rtw89_dev *rtwdev, struct rtw89_vif *vif);
+void rtw89_cam_fill_addr_cam_info(struct rtw89_dev *rtwdev,
+				  struct rtw89_vif *vif, u8 *cmd);
+int rtw89_cam_fill_bssid_cam_info(struct rtw89_dev *rtwdev,
+				  struct rtw89_vif *vif, u8 *cmd);
+int rtw89_cam_sec_key_add(struct rtw89_dev *rtwdev,
+			  struct ieee80211_vif *vif,
+			  struct ieee80211_sta *sta,
+			  struct ieee80211_key_conf *key);
+int rtw89_cam_sec_key_del(struct rtw89_dev *rtwdev,
+			  struct ieee80211_vif *vif,
+			  struct ieee80211_sta *sta,
+			  struct ieee80211_key_conf *key,
+			  bool inform_fw);
+void rtw89_cam_bssid_changed(struct rtw89_dev *rtwdev,
+			     struct rtw89_vif *rtwvif);
+void rtw89_cam_reset_keys(struct rtw89_dev *rtwdev);
+#endif
-- 
2.25.1

