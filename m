Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1EAC7BE283
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Oct 2023 16:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377682AbjJIOUN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Oct 2023 10:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377676AbjJIOUI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Oct 2023 10:20:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C6B123;
        Mon,  9 Oct 2023 07:19:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A832C43391;
        Mon,  9 Oct 2023 14:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696861185;
        bh=qurHPSaxaerUBIWBBJM1her7dqjfg3T8lLqWHPz1LRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MtriG6qt1xmvE5IJvM+5YG+nxpueFX4v4vYHtq2VHe4OpalneV/b2/MflST5QKMUg
         20D6mg+7E2fFtH5cl2wxz+7OalwJK9bhPUNfeFh+HE0ZUkvq+Nzm1MpIU55VNdgOlC
         fnQl49E061SvHMO5EbAmkBGFEWARyT+j7lVPwzWE56LVNg14NO6m1UDWSprFZcDPkj
         2zbrRplqqJ+OQ70kpnJ0lHTyludBKFMPR25yjXuGq7DmWrlabRbwpcHd5/eFPjVZgs
         tiJPVoMYWVWjjUT5kYVbaNInTXJHpk4uXE1+RoJldtr4I28TRsq2FX2biKfLboZUFG
         ys6ZLSS8588ZA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wpan@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Doug Brown <doug@schmorgal.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 07/10] staging: rtl8723bs: remove dead code
Date:   Mon,  9 Oct 2023 16:19:05 +0200
Message-Id: <20231009141908.1767241-7-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009141908.1767241-1-arnd@kernel.org>
References: <20231009141908.1767241-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The .ndo_do_ioctl functions are never called, so the three implementation here
is useless but only works as a way to identify the device in the notifiers,
which can really be removed as well.

Looking through the exported functions, I found a bunch more that have
no callers, so just drop all of those.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/rtl8723bs/Makefile            |    1 -
 .../staging/rtl8723bs/include/osdep_intf.h    |   32 -
 drivers/staging/rtl8723bs/include/rtw_io.h    |    1 -
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    | 1300 -----------------
 drivers/staging/rtl8723bs/os_dep/os_intfs.c   |   29 -
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c  |   23 +-
 6 files changed, 1 insertion(+), 1385 deletions(-)
 delete mode 100644 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c

diff --git a/drivers/staging/rtl8723bs/Makefile b/drivers/staging/rtl8723bs/Makefile
index 590bde02058c7..0f3f6dea4955e 100644
--- a/drivers/staging/rtl8723bs/Makefile
+++ b/drivers/staging/rtl8723bs/Makefile
@@ -50,7 +50,6 @@ r8723bs-y = \
 		hal/HalHWImg8723B_RF.o \
 		hal/HalPhyRf_8723B.o \
 		os_dep/ioctl_cfg80211.o \
-		os_dep/ioctl_linux.o \
 		os_dep/mlme_linux.o \
 		os_dep/osdep_service.o \
 		os_dep/os_intfs.o \
diff --git a/drivers/staging/rtl8723bs/include/osdep_intf.h b/drivers/staging/rtl8723bs/include/osdep_intf.h
index 111e0179712ac..83a25598e9627 100644
--- a/drivers/staging/rtl8723bs/include/osdep_intf.h
+++ b/drivers/staging/rtl8723bs/include/osdep_intf.h
@@ -8,33 +8,6 @@
 #ifndef __OSDEP_INTF_H_
 #define __OSDEP_INTF_H_
 
-
-struct intf_priv {
-
-	u8 *intf_dev;
-	u32 max_iosz;	/* USB2.0: 128, USB1.1: 64, SDIO:64 */
-	u32 max_xmitsz; /* USB2.0: unlimited, SDIO:512 */
-	u32 max_recvsz; /* USB2.0: unlimited, SDIO:512 */
-
-	volatile u8 *io_rwmem;
-	volatile u8 *allocated_io_rwmem;
-	u32 io_wsz; /* unit: 4bytes */
-	u32 io_rsz;/* unit: 4bytes */
-	u8 intf_status;
-
-	void (*_bus_io)(u8 *priv);
-
-/*
-Under Sync. IRP (SDIO/USB)
-A protection mechanism is necessary for the io_rwmem(read/write protocol)
-
-Under Async. IRP (SDIO/USB)
-The protection mechanism is through the pending queue.
-*/
-
-	struct mutex ioctl_mutex;
-};
-
 struct dvobj_priv *devobj_init(void);
 void devobj_deinit(struct dvobj_priv *pdvobj);
 
@@ -47,17 +20,12 @@ u32 rtw_start_drv_threads(struct adapter *padapter);
 void rtw_stop_drv_threads(struct adapter *padapter);
 void rtw_cancel_all_timer(struct adapter *padapter);
 
-int rtw_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
-
 int rtw_init_netdev_name(struct net_device *pnetdev, const char *ifname);
 struct net_device *rtw_init_netdev(struct adapter *padapter);
 void rtw_unregister_netdevs(struct dvobj_priv *dvobj);
 
 u16 rtw_recv_select_queue(struct sk_buff *skb);
 
-int rtw_ndev_notifier_register(void);
-void rtw_ndev_notifier_unregister(void);
-
 void rtw_ips_dev_unload(struct adapter *padapter);
 
 int rtw_ips_pwr_up(struct adapter *padapter);
diff --git a/drivers/staging/rtl8723bs/include/rtw_io.h b/drivers/staging/rtl8723bs/include/rtw_io.h
index e98083a07a660..f92093e73fe67 100644
--- a/drivers/staging/rtl8723bs/include/rtw_io.h
+++ b/drivers/staging/rtl8723bs/include/rtw_io.h
@@ -72,7 +72,6 @@
 
 #define _INTF_ASYNC_	BIT(0)	/* support async io */
 
-struct intf_priv;
 struct intf_hdl;
 struct io_queue;
 
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
deleted file mode 100644
index c81b30f1f1b05..0000000000000
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ /dev/null
@@ -1,1300 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2012 Realtek Corporation. All rights reserved.
- *
- ******************************************************************************/
-
-#include <linux/etherdevice.h>
-#include <drv_types.h>
-#include <rtw_debug.h>
-#include <rtw_mp.h>
-#include <hal_btcoex.h>
-#include <linux/jiffies.h>
-#include <linux/kernel.h>
-
-#define RTL_IOCTL_WPA_SUPPLICANT	(SIOCIWFIRSTPRIV + 30)
-
-static int wpa_set_auth_algs(struct net_device *dev, u32 value)
-{
-	struct adapter *padapter = rtw_netdev_priv(dev);
-	int ret = 0;
-
-	if ((value & IW_AUTH_ALG_SHARED_KEY) && (value & IW_AUTH_ALG_OPEN_SYSTEM)) {
-		padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
-		padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeAutoSwitch;
-		padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Auto;
-	} else if (value & IW_AUTH_ALG_SHARED_KEY)	{
-		padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
-
-		padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeShared;
-		padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Shared;
-	} else if (value & IW_AUTH_ALG_OPEN_SYSTEM) {
-		/* padapter->securitypriv.ndisencryptstatus = Ndis802_11EncryptionDisabled; */
-		if (padapter->securitypriv.ndisauthtype < Ndis802_11AuthModeWPAPSK) {
-			padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeOpen;
-			padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Open;
-		}
-	} else {
-		ret = -EINVAL;
-	}
-
-	return ret;
-}
-
-static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param, u32 param_len)
-{
-	int ret = 0;
-	u8 max_idx;
-	u32 wep_key_idx, wep_key_len, wep_total_len;
-	struct ndis_802_11_wep	 *pwep = NULL;
-	struct adapter *padapter = rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct security_priv *psecuritypriv = &padapter->securitypriv;
-
-	param->u.crypt.err = 0;
-	param->u.crypt.alg[IEEE_CRYPT_ALG_NAME_LEN - 1] = '\0';
-
-	if (param_len < (u32)((u8 *)param->u.crypt.key - (u8 *)param) + param->u.crypt.key_len) {
-		ret =  -EINVAL;
-		goto exit;
-	}
-
-	if (param->sta_addr[0] != 0xff || param->sta_addr[1] != 0xff ||
-	    param->sta_addr[2] != 0xff || param->sta_addr[3] != 0xff ||
-	    param->sta_addr[4] != 0xff || param->sta_addr[5] != 0xff) {
-		ret = -EINVAL;
-		goto exit;
-	}
-
-	if (strcmp(param->u.crypt.alg, "WEP") == 0)
-		max_idx = WEP_KEYS - 1;
-	else
-		max_idx = BIP_MAX_KEYID;
-
-	if (param->u.crypt.idx > max_idx) {
-		netdev_err(dev, "Error crypt.idx %d > %d\n", param->u.crypt.idx, max_idx);
-		ret = -EINVAL;
-		goto exit;
-	}
-
-	if (strcmp(param->u.crypt.alg, "WEP") == 0) {
-		padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
-		padapter->securitypriv.dot11PrivacyAlgrthm = _WEP40_;
-		padapter->securitypriv.dot118021XGrpPrivacy = _WEP40_;
-
-		wep_key_idx = param->u.crypt.idx;
-		wep_key_len = param->u.crypt.key_len;
-
-		if (wep_key_len > 0) {
-			wep_key_len = wep_key_len <= 5 ? 5 : 13;
-			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, key_material);
-			/* Allocate a full structure to avoid potentially running off the end. */
-			pwep = kzalloc(sizeof(*pwep), GFP_KERNEL);
-			if (!pwep) {
-				ret = -ENOMEM;
-				goto exit;
-			}
-
-			pwep->key_length = wep_key_len;
-			pwep->length = wep_total_len;
-
-			if (wep_key_len == 13) {
-				padapter->securitypriv.dot11PrivacyAlgrthm = _WEP104_;
-				padapter->securitypriv.dot118021XGrpPrivacy = _WEP104_;
-			}
-		} else {
-			ret = -EINVAL;
-			goto exit;
-		}
-
-		pwep->key_index = wep_key_idx;
-		pwep->key_index |= 0x80000000;
-
-		memcpy(pwep->key_material,  param->u.crypt.key, pwep->key_length);
-
-		if (param->u.crypt.set_tx) {
-			if (rtw_set_802_11_add_wep(padapter, pwep) == (u8)_FAIL)
-				ret = -EOPNOTSUPP;
-		} else {
-			/* don't update "psecuritypriv->dot11PrivacyAlgrthm" and */
-			/* psecuritypriv->dot11PrivacyKeyIndex =keyid", but can rtw_set_key to fw/cam */
-
-			if (wep_key_idx >= WEP_KEYS) {
-				ret = -EOPNOTSUPP;
-				goto exit;
-			}
-
-			memcpy(&psecuritypriv->dot11DefKey[wep_key_idx].skey[0], pwep->key_material, pwep->key_length);
-			psecuritypriv->dot11DefKeylen[wep_key_idx] = pwep->key_length;
-			rtw_set_key(padapter, psecuritypriv, wep_key_idx, 0, true);
-		}
-
-		goto exit;
-	}
-
-	if (padapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) { /*  802_1x */
-		struct sta_info *psta, *pbcmc_sta;
-		struct sta_priv *pstapriv = &padapter->stapriv;
-
-		if (check_fwstate(pmlmepriv, WIFI_STATION_STATE | WIFI_MP_STATE) == true) { /* sta mode */
-			psta = rtw_get_stainfo(pstapriv, get_bssid(pmlmepriv));
-			if (!psta) {
-				/* DEBUG_ERR(("Set wpa_set_encryption: Obtain Sta_info fail\n")); */
-			} else {
-				/* Jeff: don't disable ieee8021x_blocked while clearing key */
-				if (strcmp(param->u.crypt.alg, "none") != 0)
-					psta->ieee8021x_blocked = false;
-
-				if ((padapter->securitypriv.ndisencryptstatus == Ndis802_11Encryption2Enabled) ||
-				    (padapter->securitypriv.ndisencryptstatus ==  Ndis802_11Encryption3Enabled)) {
-					psta->dot118021XPrivacy = padapter->securitypriv.dot11PrivacyAlgrthm;
-				}
-
-				if (param->u.crypt.set_tx == 1) { /* pairwise key */
-					memcpy(psta->dot118021x_UncstKey.skey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
-
-					if (strcmp(param->u.crypt.alg, "TKIP") == 0) { /* set mic key */
-						/* DEBUG_ERR(("\nset key length :param->u.crypt.key_len =%d\n", param->u.crypt.key_len)); */
-						memcpy(psta->dot11tkiptxmickey.skey, &param->u.crypt.key[16], 8);
-						memcpy(psta->dot11tkiprxmickey.skey, &param->u.crypt.key[24], 8);
-
-						padapter->securitypriv.busetkipkey = false;
-						/* _set_timer(&padapter->securitypriv.tkip_timer, 50); */
-					}
-
-					rtw_setstakey_cmd(padapter, psta, true, true);
-				} else { /* group key */
-					if (strcmp(param->u.crypt.alg, "TKIP") == 0 || strcmp(param->u.crypt.alg, "CCMP") == 0) {
-						memcpy(padapter->securitypriv.dot118021XGrpKey[param->u.crypt.idx].skey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
-						/* only TKIP group key need to install this */
-						if (param->u.crypt.key_len > 16) {
-							memcpy(padapter->securitypriv.dot118021XGrptxmickey[param->u.crypt.idx].skey, &param->u.crypt.key[16], 8);
-							memcpy(padapter->securitypriv.dot118021XGrprxmickey[param->u.crypt.idx].skey, &param->u.crypt.key[24], 8);
-						}
-						padapter->securitypriv.binstallGrpkey = true;
-
-						padapter->securitypriv.dot118021XGrpKeyid = param->u.crypt.idx;
-
-						rtw_set_key(padapter, &padapter->securitypriv, param->u.crypt.idx, 1, true);
-					} else if (strcmp(param->u.crypt.alg, "BIP") == 0) {
-						/* printk("BIP key_len =%d , index =%d @@@@@@@@@@@@@@@@@@\n", param->u.crypt.key_len, param->u.crypt.idx); */
-						/* save the IGTK key, length 16 bytes */
-						memcpy(padapter->securitypriv.dot11wBIPKey[param->u.crypt.idx].skey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
-						/*printk("IGTK key below:\n");
-						for (no = 0;no<16;no++)
-							printk(" %02x ", padapter->securitypriv.dot11wBIPKey[param->u.crypt.idx].skey[no]);
-						printk("\n");*/
-						padapter->securitypriv.dot11wBIPKeyid = param->u.crypt.idx;
-						padapter->securitypriv.binstallBIPkey = true;
-					}
-				}
-			}
-
-			pbcmc_sta = rtw_get_bcmc_stainfo(padapter);
-			if (!pbcmc_sta) {
-				/* DEBUG_ERR(("Set OID_802_11_ADD_KEY: bcmc stainfo is null\n")); */
-			} else {
-				/* Jeff: don't disable ieee8021x_blocked while clearing key */
-				if (strcmp(param->u.crypt.alg, "none") != 0)
-					pbcmc_sta->ieee8021x_blocked = false;
-
-				if ((padapter->securitypriv.ndisencryptstatus == Ndis802_11Encryption2Enabled) ||
-				    (padapter->securitypriv.ndisencryptstatus ==  Ndis802_11Encryption3Enabled)) {
-					pbcmc_sta->dot118021XPrivacy = padapter->securitypriv.dot11PrivacyAlgrthm;
-				}
-			}
-		} else if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
-			/* adhoc mode */
-		}
-	}
-
-exit:
-
-	kfree(pwep);
-	return ret;
-}
-
-static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ielen)
-{
-	u8 *buf = NULL;
-	int group_cipher = 0, pairwise_cipher = 0;
-	int ret = 0;
-	u8 null_addr[] = {0, 0, 0, 0, 0, 0};
-
-	if (ielen > MAX_WPA_IE_LEN || !pie) {
-		_clr_fwstate_(&padapter->mlmepriv, WIFI_UNDER_WPS);
-		if (!pie)
-			return ret;
-		else
-			return -EINVAL;
-	}
-
-	if (ielen) {
-		buf = rtw_zmalloc(ielen);
-		if (!buf) {
-			ret =  -ENOMEM;
-			goto exit;
-		}
-
-		memcpy(buf, pie, ielen);
-
-		if (ielen < RSN_HEADER_LEN) {
-			ret  = -1;
-			goto exit;
-		}
-
-		if (rtw_parse_wpa_ie(buf, ielen, &group_cipher, &pairwise_cipher, NULL) == _SUCCESS) {
-			padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_8021X;
-			padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeWPAPSK;
-			memcpy(padapter->securitypriv.supplicant_ie, &buf[0], ielen);
-		}
-
-		if (rtw_parse_wpa2_ie(buf, ielen, &group_cipher, &pairwise_cipher, NULL) == _SUCCESS) {
-			padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_8021X;
-			padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeWPA2PSK;
-			memcpy(padapter->securitypriv.supplicant_ie, &buf[0], ielen);
-		}
-
-		if (group_cipher == 0)
-			group_cipher = WPA_CIPHER_NONE;
-		if (pairwise_cipher == 0)
-			pairwise_cipher = WPA_CIPHER_NONE;
-
-		switch (group_cipher) {
-		case WPA_CIPHER_NONE:
-			padapter->securitypriv.dot118021XGrpPrivacy = _NO_PRIVACY_;
-			padapter->securitypriv.ndisencryptstatus = Ndis802_11EncryptionDisabled;
-			break;
-		case WPA_CIPHER_WEP40:
-			padapter->securitypriv.dot118021XGrpPrivacy = _WEP40_;
-			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
-			break;
-		case WPA_CIPHER_TKIP:
-			padapter->securitypriv.dot118021XGrpPrivacy = _TKIP_;
-			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption2Enabled;
-			break;
-		case WPA_CIPHER_CCMP:
-			padapter->securitypriv.dot118021XGrpPrivacy = _AES_;
-			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption3Enabled;
-			break;
-		case WPA_CIPHER_WEP104:
-			padapter->securitypriv.dot118021XGrpPrivacy = _WEP104_;
-			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
-			break;
-		}
-
-		switch (pairwise_cipher) {
-		case WPA_CIPHER_NONE:
-			padapter->securitypriv.dot11PrivacyAlgrthm = _NO_PRIVACY_;
-			padapter->securitypriv.ndisencryptstatus = Ndis802_11EncryptionDisabled;
-			break;
-		case WPA_CIPHER_WEP40:
-			padapter->securitypriv.dot11PrivacyAlgrthm = _WEP40_;
-			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
-			break;
-		case WPA_CIPHER_TKIP:
-			padapter->securitypriv.dot11PrivacyAlgrthm = _TKIP_;
-			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption2Enabled;
-			break;
-		case WPA_CIPHER_CCMP:
-			padapter->securitypriv.dot11PrivacyAlgrthm = _AES_;
-			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption3Enabled;
-			break;
-		case WPA_CIPHER_WEP104:
-			padapter->securitypriv.dot11PrivacyAlgrthm = _WEP104_;
-			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
-			break;
-		}
-
-		_clr_fwstate_(&padapter->mlmepriv, WIFI_UNDER_WPS);
-		{/* set wps_ie */
-			u16 cnt = 0;
-			u8 eid, wps_oui[4] = {0x0, 0x50, 0xf2, 0x04};
-
-			while (cnt < ielen) {
-				eid = buf[cnt];
-
-				if ((eid == WLAN_EID_VENDOR_SPECIFIC) && (!memcmp(&buf[cnt + 2], wps_oui, 4))) {
-					padapter->securitypriv.wps_ie_len = ((buf[cnt + 1] + 2) < MAX_WPS_IE_LEN) ? (buf[cnt + 1] + 2) : MAX_WPS_IE_LEN;
-
-					memcpy(padapter->securitypriv.wps_ie, &buf[cnt], padapter->securitypriv.wps_ie_len);
-
-					set_fwstate(&padapter->mlmepriv, WIFI_UNDER_WPS);
-
-					cnt += buf[cnt + 1] + 2;
-
-					break;
-				} else {
-					cnt += buf[cnt + 1] + 2; /* goto next */
-				}
-			}
-		}
-	}
-
-	/* TKIP and AES disallow multicast packets until installing group key */
-	if (padapter->securitypriv.dot11PrivacyAlgrthm == _TKIP_ ||
-	    padapter->securitypriv.dot11PrivacyAlgrthm == _TKIP_WTMIC_ ||
-	    padapter->securitypriv.dot11PrivacyAlgrthm == _AES_)
-		/* WPS open need to enable multicast */
-		/*  check_fwstate(&padapter->mlmepriv, WIFI_UNDER_WPS) == true) */
-		rtw_hal_set_hwreg(padapter, HW_VAR_OFF_RCR_AM, null_addr);
-
-exit:
-
-	kfree(buf);
-
-	return ret;
-}
-
-static int wpa_set_param(struct net_device *dev, u8 name, u32 value)
-{
-	uint ret = 0;
-	struct adapter *padapter = rtw_netdev_priv(dev);
-
-	switch (name) {
-	case IEEE_PARAM_WPA_ENABLED:
-
-		padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_8021X; /* 802.1x */
-
-		/* ret = ieee80211_wpa_enable(ieee, value); */
-
-		switch ((value) & 0xff) {
-		case 1: /* WPA */
-			padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeWPAPSK; /* WPA_PSK */
-			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption2Enabled;
-			break;
-		case 2: /* WPA2 */
-			padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeWPA2PSK; /* WPA2_PSK */
-			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption3Enabled;
-			break;
-		}
-
-		break;
-
-	case IEEE_PARAM_TKIP_COUNTERMEASURES:
-		/* ieee->tkip_countermeasures =value; */
-		break;
-
-	case IEEE_PARAM_DROP_UNENCRYPTED:
-	{
-		/* HACK:
-		 *
-		 * wpa_supplicant calls set_wpa_enabled when the driver
-		 * is loaded and unloaded, regardless of if WPA is being
-		 * used.  No other calls are made which can be used to
-		 * determine if encryption will be used or not prior to
-		 * association being expected.  If encryption is not being
-		 * used, drop_unencrypted is set to false, else true -- we
-		 * can use this to determine if the CAP_PRIVACY_ON bit should
-		 * be set.
-		 */
-		break;
-	}
-	case IEEE_PARAM_PRIVACY_INVOKED:
-
-		/* ieee->privacy_invoked =value; */
-
-		break;
-
-	case IEEE_PARAM_AUTH_ALGS:
-
-		ret = wpa_set_auth_algs(dev, value);
-
-		break;
-
-	case IEEE_PARAM_IEEE_802_1X:
-
-		/* ieee->ieee802_1x =value; */
-
-		break;
-
-	case IEEE_PARAM_WPAX_SELECT:
-
-		/*  added for WPA2 mixed mode */
-		/*
-		spin_lock_irqsave(&ieee->wpax_suitlist_lock, flags);
-		ieee->wpax_type_set = 1;
-		ieee->wpax_type_notify = value;
-		spin_unlock_irqrestore(&ieee->wpax_suitlist_lock, flags);
-		*/
-
-		break;
-
-	default:
-
-		ret = -EOPNOTSUPP;
-
-		break;
-	}
-
-	return ret;
-}
-
-static int wpa_mlme(struct net_device *dev, u32 command, u32 reason)
-{
-	int ret = 0;
-	struct adapter *padapter = rtw_netdev_priv(dev);
-
-	switch (command) {
-	case IEEE_MLME_STA_DEAUTH:
-
-		if (!rtw_set_802_11_disassociate(padapter))
-			ret = -1;
-
-		break;
-
-	case IEEE_MLME_STA_DISASSOC:
-
-		if (!rtw_set_802_11_disassociate(padapter))
-			ret = -1;
-
-		break;
-
-	default:
-		ret = -EOPNOTSUPP;
-		break;
-	}
-
-	return ret;
-}
-
-static int wpa_supplicant_ioctl(struct net_device *dev, struct iw_point *p)
-{
-	struct ieee_param *param;
-	uint ret = 0;
-
-	/* down(&ieee->wx_sem); */
-
-	if (!p->pointer || p->length != sizeof(struct ieee_param))
-		return -EINVAL;
-
-	param = rtw_malloc(p->length);
-	if (!param)
-		return -ENOMEM;
-
-	if (copy_from_user(param, p->pointer, p->length)) {
-		kfree(param);
-		return -EFAULT;
-	}
-
-	switch (param->cmd) {
-	case IEEE_CMD_SET_WPA_PARAM:
-		ret = wpa_set_param(dev, param->u.wpa_param.name, param->u.wpa_param.value);
-		break;
-
-	case IEEE_CMD_SET_WPA_IE:
-		/* ret = wpa_set_wpa_ie(dev, param, p->length); */
-		ret =  rtw_set_wpa_ie(rtw_netdev_priv(dev), (char *)param->u.wpa_ie.data, (u16)param->u.wpa_ie.len);
-		break;
-
-	case IEEE_CMD_SET_ENCRYPTION:
-		ret = wpa_set_encryption(dev, param, p->length);
-		break;
-
-	case IEEE_CMD_MLME:
-		ret = wpa_mlme(dev, param->u.mlme.command, param->u.mlme.reason_code);
-		break;
-
-	default:
-		ret = -EOPNOTSUPP;
-		break;
-	}
-
-	if (ret == 0 && copy_to_user(p->pointer, param, p->length))
-		ret = -EFAULT;
-
-	kfree(param);
-
-	/* up(&ieee->wx_sem); */
-	return ret;
-}
-
-static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param, u32 param_len)
-{
-	int ret = 0;
-	u32 wep_key_idx, wep_key_len, wep_total_len;
-	struct ndis_802_11_wep	 *pwep = NULL;
-	struct sta_info *psta = NULL, *pbcmc_sta = NULL;
-	struct adapter *padapter = rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct security_priv *psecuritypriv = &padapter->securitypriv;
-	struct sta_priv *pstapriv = &padapter->stapriv;
-	char *txkey = padapter->securitypriv.dot118021XGrptxmickey[param->u.crypt.idx].skey;
-	char *rxkey = padapter->securitypriv.dot118021XGrprxmickey[param->u.crypt.idx].skey;
-	char *grpkey = psecuritypriv->dot118021XGrpKey[param->u.crypt.idx].skey;
-
-	param->u.crypt.err = 0;
-	param->u.crypt.alg[IEEE_CRYPT_ALG_NAME_LEN - 1] = '\0';
-
-	/* sizeof(struct ieee_param) = 64 bytes; */
-	/* if (param_len !=  (u32) ((u8 *) param->u.crypt.key - (u8 *) param) + param->u.crypt.key_len) */
-	if (param_len !=  sizeof(struct ieee_param) + param->u.crypt.key_len) {
-		ret =  -EINVAL;
-		goto exit;
-	}
-
-	if (param->sta_addr[0] == 0xff && param->sta_addr[1] == 0xff &&
-	    param->sta_addr[2] == 0xff && param->sta_addr[3] == 0xff &&
-	    param->sta_addr[4] == 0xff && param->sta_addr[5] == 0xff) {
-		if (param->u.crypt.idx >= WEP_KEYS) {
-			ret = -EINVAL;
-			goto exit;
-		}
-	} else {
-		psta = rtw_get_stainfo(pstapriv, param->sta_addr);
-		if (!psta)
-			/* ret = -EINVAL; */
-			goto exit;
-	}
-
-	if (strcmp(param->u.crypt.alg, "none") == 0 && !psta) {
-		/* todo:clear default encryption keys */
-
-		psecuritypriv->dot11AuthAlgrthm = dot11AuthAlgrthm_Open;
-		psecuritypriv->ndisencryptstatus = Ndis802_11EncryptionDisabled;
-		psecuritypriv->dot11PrivacyAlgrthm = _NO_PRIVACY_;
-		psecuritypriv->dot118021XGrpPrivacy = _NO_PRIVACY_;
-
-		goto exit;
-	}
-
-	if (strcmp(param->u.crypt.alg, "WEP") == 0 && !psta) {
-		wep_key_idx = param->u.crypt.idx;
-		wep_key_len = param->u.crypt.key_len;
-
-		if ((wep_key_idx >= WEP_KEYS) || (wep_key_len <= 0)) {
-			ret = -EINVAL;
-			goto exit;
-		}
-
-		if (wep_key_len > 0) {
-			wep_key_len = wep_key_len <= 5 ? 5 : 13;
-			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, key_material);
-			/* Allocate a full structure to avoid potentially running off the end. */
-			pwep = kzalloc(sizeof(*pwep), GFP_KERNEL);
-			if (!pwep)
-				goto exit;
-
-			pwep->key_length = wep_key_len;
-			pwep->length = wep_total_len;
-		}
-
-		pwep->key_index = wep_key_idx;
-
-		memcpy(pwep->key_material,  param->u.crypt.key, pwep->key_length);
-
-		if (param->u.crypt.set_tx) {
-			psecuritypriv->dot11AuthAlgrthm = dot11AuthAlgrthm_Auto;
-			psecuritypriv->ndisencryptstatus = Ndis802_11Encryption1Enabled;
-			psecuritypriv->dot11PrivacyAlgrthm = _WEP40_;
-			psecuritypriv->dot118021XGrpPrivacy = _WEP40_;
-
-			if (pwep->key_length == 13) {
-				psecuritypriv->dot11PrivacyAlgrthm = _WEP104_;
-				psecuritypriv->dot118021XGrpPrivacy = _WEP104_;
-			}
-
-			psecuritypriv->dot11PrivacyKeyIndex = wep_key_idx;
-
-			memcpy(&psecuritypriv->dot11DefKey[wep_key_idx].skey[0], pwep->key_material, pwep->key_length);
-
-			psecuritypriv->dot11DefKeylen[wep_key_idx] = pwep->key_length;
-
-			rtw_ap_set_wep_key(padapter, pwep->key_material, pwep->key_length, wep_key_idx, 1);
-		} else {
-			/* don't update "psecuritypriv->dot11PrivacyAlgrthm" and */
-			/* psecuritypriv->dot11PrivacyKeyIndex =keyid", but can rtw_set_key to cam */
-
-			memcpy(&psecuritypriv->dot11DefKey[wep_key_idx].skey[0], pwep->key_material, pwep->key_length);
-
-			psecuritypriv->dot11DefKeylen[wep_key_idx] = pwep->key_length;
-
-			rtw_ap_set_wep_key(padapter, pwep->key_material, pwep->key_length, wep_key_idx, 0);
-		}
-
-		goto exit;
-	}
-
-	if (!psta && check_fwstate(pmlmepriv, WIFI_AP_STATE)) { /*  group key */
-		if (param->u.crypt.set_tx == 1) {
-			if (strcmp(param->u.crypt.alg, "WEP") == 0) {
-				memcpy(grpkey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
-
-				psecuritypriv->dot118021XGrpPrivacy = _WEP40_;
-				if (param->u.crypt.key_len == 13)
-					psecuritypriv->dot118021XGrpPrivacy = _WEP104_;
-
-			} else if (strcmp(param->u.crypt.alg, "TKIP") == 0) {
-				psecuritypriv->dot118021XGrpPrivacy = _TKIP_;
-
-				memcpy(grpkey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
-
-				/* DEBUG_ERR("set key length :param->u.crypt.key_len =%d\n", param->u.crypt.key_len); */
-				/* set mic key */
-				memcpy(txkey, &param->u.crypt.key[16], 8);
-				memcpy(psecuritypriv->dot118021XGrprxmickey[param->u.crypt.idx].skey, &param->u.crypt.key[24], 8);
-
-				psecuritypriv->busetkipkey = true;
-
-			} else if (strcmp(param->u.crypt.alg, "CCMP") == 0) {
-				psecuritypriv->dot118021XGrpPrivacy = _AES_;
-
-				memcpy(grpkey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
-			} else {
-				psecuritypriv->dot118021XGrpPrivacy = _NO_PRIVACY_;
-			}
-
-			psecuritypriv->dot118021XGrpKeyid = param->u.crypt.idx;
-
-			psecuritypriv->binstallGrpkey = true;
-
-			psecuritypriv->dot11PrivacyAlgrthm = psecuritypriv->dot118021XGrpPrivacy;/*  */
-
-			rtw_ap_set_group_key(padapter, param->u.crypt.key, psecuritypriv->dot118021XGrpPrivacy, param->u.crypt.idx);
-
-			pbcmc_sta = rtw_get_bcmc_stainfo(padapter);
-			if (pbcmc_sta) {
-				pbcmc_sta->ieee8021x_blocked = false;
-				pbcmc_sta->dot118021XPrivacy = psecuritypriv->dot118021XGrpPrivacy;/* rx will use bmc_sta's dot118021XPrivacy */
-			}
-		}
-
-		goto exit;
-	}
-
-	if (psecuritypriv->dot11AuthAlgrthm == dot11AuthAlgrthm_8021X && psta) { /*  psk/802_1x */
-		if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
-			if (param->u.crypt.set_tx == 1)	{
-				memcpy(psta->dot118021x_UncstKey.skey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
-
-				if (strcmp(param->u.crypt.alg, "WEP") == 0) {
-					psta->dot118021XPrivacy = _WEP40_;
-					if (param->u.crypt.key_len == 13)
-						psta->dot118021XPrivacy = _WEP104_;
-				} else if (strcmp(param->u.crypt.alg, "TKIP") == 0) {
-					psta->dot118021XPrivacy = _TKIP_;
-
-					/* DEBUG_ERR("set key length :param->u.crypt.key_len =%d\n", param->u.crypt.key_len); */
-					/* set mic key */
-					memcpy(psta->dot11tkiptxmickey.skey, &param->u.crypt.key[16], 8);
-					memcpy(psta->dot11tkiprxmickey.skey, &param->u.crypt.key[24], 8);
-
-					psecuritypriv->busetkipkey = true;
-
-				} else if (strcmp(param->u.crypt.alg, "CCMP") == 0) {
-					psta->dot118021XPrivacy = _AES_;
-				} else {
-					psta->dot118021XPrivacy = _NO_PRIVACY_;
-				}
-
-				rtw_ap_set_pairwise_key(padapter, psta);
-
-				psta->ieee8021x_blocked = false;
-
-			} else { /* group key??? */
-				if (strcmp(param->u.crypt.alg, "WEP") == 0) {
-					memcpy(grpkey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
-
-					psecuritypriv->dot118021XGrpPrivacy = _WEP40_;
-					if (param->u.crypt.key_len == 13)
-						psecuritypriv->dot118021XGrpPrivacy = _WEP104_;
-				} else if (strcmp(param->u.crypt.alg, "TKIP") == 0) {
-					psecuritypriv->dot118021XGrpPrivacy = _TKIP_;
-
-					memcpy(grpkey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
-
-					/* DEBUG_ERR("set key length :param->u.crypt.key_len =%d\n", param->u.crypt.key_len); */
-					/* set mic key */
-					memcpy(txkey, &param->u.crypt.key[16], 8);
-					memcpy(rxkey, &param->u.crypt.key[24], 8);
-
-					psecuritypriv->busetkipkey = true;
-
-				} else if (strcmp(param->u.crypt.alg, "CCMP") == 0) {
-					psecuritypriv->dot118021XGrpPrivacy = _AES_;
-
-					memcpy(grpkey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
-				} else {
-					psecuritypriv->dot118021XGrpPrivacy = _NO_PRIVACY_;
-				}
-
-				psecuritypriv->dot118021XGrpKeyid = param->u.crypt.idx;
-
-				psecuritypriv->binstallGrpkey = true;
-
-				psecuritypriv->dot11PrivacyAlgrthm = psecuritypriv->dot118021XGrpPrivacy;/*  */
-
-				rtw_ap_set_group_key(padapter, param->u.crypt.key, psecuritypriv->dot118021XGrpPrivacy, param->u.crypt.idx);
-
-				pbcmc_sta = rtw_get_bcmc_stainfo(padapter);
-				if (pbcmc_sta) {
-					pbcmc_sta->ieee8021x_blocked = false;
-					pbcmc_sta->dot118021XPrivacy = psecuritypriv->dot118021XGrpPrivacy;/* rx will use bmc_sta's dot118021XPrivacy */
-				}
-			}
-		}
-	}
-
-exit:
-	kfree(pwep);
-
-	return ret;
-}
-
-static int rtw_set_beacon(struct net_device *dev, struct ieee_param *param, int len)
-{
-	int ret = 0;
-	struct adapter *padapter = rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct sta_priv *pstapriv = &padapter->stapriv;
-	unsigned char *pbuf = param->u.bcn_ie.buf;
-
-	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
-		return -EINVAL;
-
-	memcpy(&pstapriv->max_num_sta, param->u.bcn_ie.reserved, 2);
-
-	if ((pstapriv->max_num_sta > NUM_STA) || (pstapriv->max_num_sta <= 0))
-		pstapriv->max_num_sta = NUM_STA;
-
-	if (rtw_check_beacon_data(padapter, pbuf,  (len - 12 - 2)) == _SUCCESS)/*  12 = param header, 2:no packed */
-		ret = 0;
-	else
-		ret = -EINVAL;
-
-	return ret;
-}
-
-static void rtw_hostapd_sta_flush(struct net_device *dev)
-{
-	/* _irqL irqL; */
-	/* struct list_head	*phead, *plist; */
-	/* struct sta_info *psta = NULL; */
-	struct adapter *padapter = rtw_netdev_priv(dev);
-	/* struct sta_priv *pstapriv = &padapter->stapriv; */
-
-	flush_all_cam_entry(padapter);	/* clear CAM */
-
-	rtw_sta_flush(padapter);
-}
-
-static int rtw_add_sta(struct net_device *dev, struct ieee_param *param)
-{
-	int ret = 0;
-	struct sta_info *psta = NULL;
-	struct adapter *padapter = rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct sta_priv *pstapriv = &padapter->stapriv;
-
-	if (check_fwstate(pmlmepriv, (_FW_LINKED | WIFI_AP_STATE)) != true)
-		return -EINVAL;
-
-	if (param->sta_addr[0] == 0xff && param->sta_addr[1] == 0xff &&
-	    param->sta_addr[2] == 0xff && param->sta_addr[3] == 0xff &&
-	    param->sta_addr[4] == 0xff && param->sta_addr[5] == 0xff) {
-		return -EINVAL;
-	}
-
-/*
-	psta = rtw_get_stainfo(pstapriv, param->sta_addr);
-	if (psta)
-	{
-		rtw_free_stainfo(padapter,  psta);
-
-		psta = NULL;
-	}
-*/
-	/* psta = rtw_alloc_stainfo(pstapriv, param->sta_addr); */
-	psta = rtw_get_stainfo(pstapriv, param->sta_addr);
-	if (psta) {
-		int flags = param->u.add_sta.flags;
-
-		psta->aid = param->u.add_sta.aid;/* aid = 1~2007 */
-
-		memcpy(psta->bssrateset, param->u.add_sta.tx_supp_rates, 16);
-
-		/* check wmm cap. */
-		if (WLAN_STA_WME & flags)
-			psta->qos_option = 1;
-		else
-			psta->qos_option = 0;
-
-		if (pmlmepriv->qospriv.qos_option == 0)
-			psta->qos_option = 0;
-
-		/* chec 802.11n ht cap. */
-		if (WLAN_STA_HT & flags) {
-			psta->htpriv.ht_option = true;
-			psta->qos_option = 1;
-			memcpy((void *)&psta->htpriv.ht_cap, (void *)&param->u.add_sta.ht_cap, sizeof(struct ieee80211_ht_cap));
-		} else {
-			psta->htpriv.ht_option = false;
-		}
-
-		if (!pmlmepriv->htpriv.ht_option)
-			psta->htpriv.ht_option = false;
-
-		update_sta_info_apmode(padapter, psta);
-
-	} else {
-		ret = -ENOMEM;
-	}
-
-	return ret;
-}
-
-static int rtw_del_sta(struct net_device *dev, struct ieee_param *param)
-{
-	int ret = 0;
-	struct sta_info *psta = NULL;
-	struct adapter *padapter = rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct sta_priv *pstapriv = &padapter->stapriv;
-
-	if (check_fwstate(pmlmepriv, (_FW_LINKED | WIFI_AP_STATE)) != true)
-		return -EINVAL;
-
-	if (param->sta_addr[0] == 0xff && param->sta_addr[1] == 0xff &&
-	    param->sta_addr[2] == 0xff && param->sta_addr[3] == 0xff &&
-	    param->sta_addr[4] == 0xff && param->sta_addr[5] == 0xff) {
-		return -EINVAL;
-	}
-
-	psta = rtw_get_stainfo(pstapriv, param->sta_addr);
-	if (psta) {
-		u8 updated = false;
-
-		spin_lock_bh(&pstapriv->asoc_list_lock);
-		if (list_empty(&psta->asoc_list) == false) {
-			list_del_init(&psta->asoc_list);
-			pstapriv->asoc_list_cnt--;
-			updated = ap_free_sta(padapter, psta, true, WLAN_REASON_DEAUTH_LEAVING);
-		}
-		spin_unlock_bh(&pstapriv->asoc_list_lock);
-
-		associated_clients_update(padapter, updated);
-
-		psta = NULL;
-	}
-
-	return ret;
-}
-
-static int rtw_ioctl_get_sta_data(struct net_device *dev, struct ieee_param *param, int len)
-{
-	int ret = 0;
-	struct sta_info *psta = NULL;
-	struct adapter *padapter = rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct sta_priv *pstapriv = &padapter->stapriv;
-	struct ieee_param_ex *param_ex = (struct ieee_param_ex *)param;
-	struct sta_data *psta_data = (struct sta_data *)param_ex->data;
-
-	if (check_fwstate(pmlmepriv, (_FW_LINKED | WIFI_AP_STATE)) != true)
-		return -EINVAL;
-
-	if (param_ex->sta_addr[0] == 0xff && param_ex->sta_addr[1] == 0xff &&
-	    param_ex->sta_addr[2] == 0xff && param_ex->sta_addr[3] == 0xff &&
-	    param_ex->sta_addr[4] == 0xff && param_ex->sta_addr[5] == 0xff) {
-		return -EINVAL;
-	}
-
-	psta = rtw_get_stainfo(pstapriv, param_ex->sta_addr);
-	if (psta) {
-		psta_data->aid = (u16)psta->aid;
-		psta_data->capability = psta->capability;
-		psta_data->flags = psta->flags;
-
-/*
-		nonerp_set : BIT(0)
-		no_short_slot_time_set : BIT(1)
-		no_short_preamble_set : BIT(2)
-		no_ht_gf_set : BIT(3)
-		no_ht_set : BIT(4)
-		ht_20mhz_set : BIT(5)
-*/
-
-		psta_data->sta_set = ((psta->nonerp_set) |
-							 (psta->no_short_slot_time_set << 1) |
-							 (psta->no_short_preamble_set << 2) |
-							 (psta->no_ht_gf_set << 3) |
-							 (psta->no_ht_set << 4) |
-							 (psta->ht_20mhz_set << 5));
-
-		psta_data->tx_supp_rates_len =  psta->bssratelen;
-		memcpy(psta_data->tx_supp_rates, psta->bssrateset, psta->bssratelen);
-		memcpy(&psta_data->ht_cap, &psta->htpriv.ht_cap, sizeof(struct ieee80211_ht_cap));
-		psta_data->rx_pkts = psta->sta_stats.rx_data_pkts;
-		psta_data->rx_bytes = psta->sta_stats.rx_bytes;
-		psta_data->rx_drops = psta->sta_stats.rx_drops;
-
-		psta_data->tx_pkts = psta->sta_stats.tx_pkts;
-		psta_data->tx_bytes = psta->sta_stats.tx_bytes;
-		psta_data->tx_drops = psta->sta_stats.tx_drops;
-
-	} else {
-		ret = -1;
-	}
-
-	return ret;
-}
-
-static int rtw_get_sta_wpaie(struct net_device *dev, struct ieee_param *param)
-{
-	int ret = 0;
-	struct sta_info *psta = NULL;
-	struct adapter *padapter = rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct sta_priv *pstapriv = &padapter->stapriv;
-
-	if (check_fwstate(pmlmepriv, (_FW_LINKED | WIFI_AP_STATE)) != true)
-		return -EINVAL;
-
-	if (param->sta_addr[0] == 0xff && param->sta_addr[1] == 0xff &&
-	    param->sta_addr[2] == 0xff && param->sta_addr[3] == 0xff &&
-	    param->sta_addr[4] == 0xff && param->sta_addr[5] == 0xff) {
-		return -EINVAL;
-	}
-
-	psta = rtw_get_stainfo(pstapriv, param->sta_addr);
-	if (psta) {
-		if ((psta->wpa_ie[0] == WLAN_EID_RSN) || (psta->wpa_ie[0] == WLAN_EID_VENDOR_SPECIFIC)) {
-			int wpa_ie_len;
-			int copy_len;
-
-			wpa_ie_len = psta->wpa_ie[1];
-
-			copy_len = ((wpa_ie_len + 2) > sizeof(psta->wpa_ie)) ? (sizeof(psta->wpa_ie)) : (wpa_ie_len + 2);
-
-			param->u.wpa_ie.len = copy_len;
-
-			memcpy(param->u.wpa_ie.reserved, psta->wpa_ie, copy_len);
-		}
-	} else {
-		ret = -1;
-	}
-
-	return ret;
-}
-
-static int rtw_set_wps_beacon(struct net_device *dev, struct ieee_param *param, int len)
-{
-	int ret = 0;
-	unsigned char wps_oui[4] = {0x0, 0x50, 0xf2, 0x04};
-	struct adapter *padapter = rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	int ie_len;
-
-	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
-		return -EINVAL;
-
-	ie_len = len - 12 - 2;/*  12 = param header, 2:no packed */
-
-	kfree(pmlmepriv->wps_beacon_ie);
-	pmlmepriv->wps_beacon_ie = NULL;
-
-	if (ie_len > 0) {
-		pmlmepriv->wps_beacon_ie = rtw_malloc(ie_len);
-		pmlmepriv->wps_beacon_ie_len = ie_len;
-		if (!pmlmepriv->wps_beacon_ie)
-			return -EINVAL;
-
-		memcpy(pmlmepriv->wps_beacon_ie, param->u.bcn_ie.buf, ie_len);
-
-		update_beacon(padapter, WLAN_EID_VENDOR_SPECIFIC, wps_oui, true);
-
-		pmlmeext->bstart_bss = true;
-	}
-
-	return ret;
-}
-
-static int rtw_set_wps_probe_resp(struct net_device *dev, struct ieee_param *param, int len)
-{
-	int ret = 0;
-	struct adapter *padapter = rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	int ie_len;
-
-	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
-		return -EINVAL;
-
-	ie_len = len - 12 - 2;/*  12 = param header, 2:no packed */
-
-	kfree(pmlmepriv->wps_probe_resp_ie);
-	pmlmepriv->wps_probe_resp_ie = NULL;
-
-	if (ie_len > 0) {
-		pmlmepriv->wps_probe_resp_ie = rtw_malloc(ie_len);
-		pmlmepriv->wps_probe_resp_ie_len = ie_len;
-		if (!pmlmepriv->wps_probe_resp_ie)
-			return -EINVAL;
-
-		memcpy(pmlmepriv->wps_probe_resp_ie, param->u.bcn_ie.buf, ie_len);
-	}
-
-	return ret;
-}
-
-static int rtw_set_wps_assoc_resp(struct net_device *dev, struct ieee_param *param, int len)
-{
-	int ret = 0;
-	struct adapter *padapter = rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	int ie_len;
-
-	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
-		return -EINVAL;
-
-	ie_len = len - 12 - 2;/*  12 = param header, 2:no packed */
-
-	kfree(pmlmepriv->wps_assoc_resp_ie);
-	pmlmepriv->wps_assoc_resp_ie = NULL;
-
-	if (ie_len > 0) {
-		pmlmepriv->wps_assoc_resp_ie = rtw_malloc(ie_len);
-		pmlmepriv->wps_assoc_resp_ie_len = ie_len;
-		if (!pmlmepriv->wps_assoc_resp_ie)
-			return -EINVAL;
-
-		memcpy(pmlmepriv->wps_assoc_resp_ie, param->u.bcn_ie.buf, ie_len);
-	}
-
-	return ret;
-}
-
-static int rtw_set_hidden_ssid(struct net_device *dev, struct ieee_param *param, int len)
-{
-	int ret = 0;
-	struct adapter *adapter = rtw_netdev_priv(dev);
-	struct mlme_priv *mlmepriv = &adapter->mlmepriv;
-	struct mlme_ext_priv *mlmeext = &adapter->mlmeextpriv;
-	struct mlme_ext_info *mlmeinfo = &mlmeext->mlmext_info;
-	int ie_len;
-	u8 *ssid_ie;
-	char ssid[NDIS_802_11_LENGTH_SSID + 1];
-	signed int ssid_len;
-	u8 ignore_broadcast_ssid;
-
-	if (check_fwstate(mlmepriv, WIFI_AP_STATE) != true)
-		return -EPERM;
-
-	if (param->u.bcn_ie.reserved[0] != 0xea)
-		return -EINVAL;
-
-	mlmeinfo->hidden_ssid_mode = ignore_broadcast_ssid = param->u.bcn_ie.reserved[1];
-
-	ie_len = len - 12 - 2;/*  12 = param header, 2:no packed */
-	ssid_ie = rtw_get_ie(param->u.bcn_ie.buf,  WLAN_EID_SSID, &ssid_len, ie_len);
-
-	if (ssid_ie && ssid_len > 0 && ssid_len <= NDIS_802_11_LENGTH_SSID) {
-		struct wlan_bssid_ex *pbss_network = &mlmepriv->cur_network.network;
-		struct wlan_bssid_ex *pbss_network_ext = &mlmeinfo->network;
-
-		memcpy(ssid, ssid_ie + 2, ssid_len);
-		ssid[ssid_len] = 0x0;
-
-		memcpy(pbss_network->ssid.ssid, (void *)ssid, ssid_len);
-		pbss_network->ssid.ssid_length = ssid_len;
-		memcpy(pbss_network_ext->ssid.ssid, (void *)ssid, ssid_len);
-		pbss_network_ext->ssid.ssid_length = ssid_len;
-	}
-
-	return ret;
-}
-
-static int rtw_ioctl_acl_remove_sta(struct net_device *dev, struct ieee_param *param, int len)
-{
-	struct adapter *padapter = rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-
-	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
-		return -EINVAL;
-
-	if (param->sta_addr[0] == 0xff && param->sta_addr[1] == 0xff &&
-	    param->sta_addr[2] == 0xff && param->sta_addr[3] == 0xff &&
-	    param->sta_addr[4] == 0xff && param->sta_addr[5] == 0xff) {
-		return -EINVAL;
-	}
-
-	rtw_acl_remove_sta(padapter, param->sta_addr);
-	return 0;
-}
-
-static int rtw_ioctl_acl_add_sta(struct net_device *dev, struct ieee_param *param, int len)
-{
-	struct adapter *padapter = rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-
-	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
-		return -EINVAL;
-
-	if (param->sta_addr[0] == 0xff && param->sta_addr[1] == 0xff &&
-	    param->sta_addr[2] == 0xff && param->sta_addr[3] == 0xff &&
-	    param->sta_addr[4] == 0xff && param->sta_addr[5] == 0xff) {
-		return -EINVAL;
-	}
-
-	return rtw_acl_add_sta(padapter, param->sta_addr);
-}
-
-static int rtw_ioctl_set_macaddr_acl(struct net_device *dev, struct ieee_param *param, int len)
-{
-	int ret = 0;
-	struct adapter *padapter = rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-
-	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
-		return -EINVAL;
-
-	rtw_set_macaddr_acl(padapter, param->u.mlme.command);
-
-	return ret;
-}
-
-static int rtw_hostapd_ioctl(struct net_device *dev, struct iw_point *p)
-{
-	struct ieee_param *param;
-	int ret = 0;
-	struct adapter *padapter = rtw_netdev_priv(dev);
-
-	/*
-	 * this function is expect to call in master mode, which allows no power saving
-	 * so, we just check hw_init_completed
-	 */
-
-	if (!padapter->hw_init_completed)
-		return -EPERM;
-
-	if (!p->pointer || p->length != sizeof(*param))
-		return -EINVAL;
-
-	param = rtw_malloc(p->length);
-	if (!param)
-		return -ENOMEM;
-
-	if (copy_from_user(param, p->pointer, p->length)) {
-		kfree(param);
-		return -EFAULT;
-	}
-
-	switch (param->cmd) {
-	case RTL871X_HOSTAPD_FLUSH:
-
-		rtw_hostapd_sta_flush(dev);
-
-		break;
-
-	case RTL871X_HOSTAPD_ADD_STA:
-
-		ret = rtw_add_sta(dev, param);
-
-		break;
-
-	case RTL871X_HOSTAPD_REMOVE_STA:
-
-		ret = rtw_del_sta(dev, param);
-
-		break;
-
-	case RTL871X_HOSTAPD_SET_BEACON:
-
-		ret = rtw_set_beacon(dev, param, p->length);
-
-		break;
-
-	case RTL871X_SET_ENCRYPTION:
-
-		ret = rtw_set_encryption(dev, param, p->length);
-
-		break;
-
-	case RTL871X_HOSTAPD_GET_WPAIE_STA:
-
-		ret = rtw_get_sta_wpaie(dev, param);
-
-		break;
-
-	case RTL871X_HOSTAPD_SET_WPS_BEACON:
-
-		ret = rtw_set_wps_beacon(dev, param, p->length);
-
-		break;
-
-	case RTL871X_HOSTAPD_SET_WPS_PROBE_RESP:
-
-		ret = rtw_set_wps_probe_resp(dev, param, p->length);
-
-		break;
-
-	case RTL871X_HOSTAPD_SET_WPS_ASSOC_RESP:
-
-		ret = rtw_set_wps_assoc_resp(dev, param, p->length);
-
-		break;
-
-	case RTL871X_HOSTAPD_SET_HIDDEN_SSID:
-
-		ret = rtw_set_hidden_ssid(dev, param, p->length);
-
-		break;
-
-	case RTL871X_HOSTAPD_GET_INFO_STA:
-
-		ret = rtw_ioctl_get_sta_data(dev, param, p->length);
-
-		break;
-
-	case RTL871X_HOSTAPD_SET_MACADDR_ACL:
-
-		ret = rtw_ioctl_set_macaddr_acl(dev, param, p->length);
-
-		break;
-
-	case RTL871X_HOSTAPD_ACL_ADD_STA:
-
-		ret = rtw_ioctl_acl_add_sta(dev, param, p->length);
-
-		break;
-
-	case RTL871X_HOSTAPD_ACL_REMOVE_STA:
-
-		ret = rtw_ioctl_acl_remove_sta(dev, param, p->length);
-
-		break;
-
-	default:
-		ret = -EOPNOTSUPP;
-		break;
-	}
-
-	if (ret == 0 && copy_to_user(p->pointer, param, p->length))
-		ret = -EFAULT;
-
-	kfree(param);
-	return ret;
-}
-
-/*  copy from net/wireless/wext.c end */
-
-int rtw_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
-{
-	struct iwreq *wrq = (struct iwreq *)rq;
-	int ret = 0;
-
-	switch (cmd) {
-	case RTL_IOCTL_WPA_SUPPLICANT:
-		ret = wpa_supplicant_ioctl(dev, &wrq->u.data);
-		break;
-	case RTL_IOCTL_HOSTAPD:
-		ret = rtw_hostapd_ioctl(dev, &wrq->u.data);
-		break;
-	default:
-		ret = -EOPNOTSUPP;
-		break;
-	}
-
-	return ret;
-}
diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index 68bba3c0e757a..90564fbb78f34 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -382,34 +382,6 @@ u16 rtw_recv_select_queue(struct sk_buff *skb)
 	return rtw_1d_to_queue[priority];
 }
 
-static int rtw_ndev_notifier_call(struct notifier_block *nb, unsigned long state, void *ptr)
-{
-	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
-
-	if (dev->netdev_ops->ndo_do_ioctl != rtw_ioctl)
-		return NOTIFY_DONE;
-
-	netdev_dbg(dev, FUNC_NDEV_FMT " state:%lu\n", FUNC_NDEV_ARG(dev),
-		    state);
-
-	return NOTIFY_DONE;
-}
-
-static struct notifier_block rtw_ndev_notifier = {
-	.notifier_call = rtw_ndev_notifier_call,
-};
-
-int rtw_ndev_notifier_register(void)
-{
-	return register_netdevice_notifier(&rtw_ndev_notifier);
-}
-
-void rtw_ndev_notifier_unregister(void)
-{
-	unregister_netdevice_notifier(&rtw_ndev_notifier);
-}
-
-
 static int rtw_ndev_init(struct net_device *dev)
 {
 	struct adapter *adapter = rtw_netdev_priv(dev);
@@ -436,7 +408,6 @@ static const struct net_device_ops rtw_netdev_ops = {
 	.ndo_select_queue	= rtw_select_queue,
 	.ndo_set_mac_address = rtw_net_set_mac_address,
 	.ndo_get_stats = rtw_net_get_stats,
-	.ndo_do_ioctl = rtw_ioctl,
 };
 
 int rtw_init_netdev_name(struct net_device *pnetdev, const char *ifname)
diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index 4904314845242..effe4ffac54eb 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -383,7 +383,6 @@ static int rtw_drv_init(
 	if (sdio_alloc_irq(dvobj) != _SUCCESS)
 		goto free_if1;
 
-	rtw_ndev_notifier_register();
 	status = _SUCCESS;
 
 free_if1:
@@ -483,24 +482,4 @@ static int rtw_sdio_resume(struct device *dev)
 	return ret;
 }
 
-static int __init rtw_drv_entry(void)
-{
-	int ret;
-
-	ret = sdio_register_driver(&rtl8723bs_sdio_driver);
-	if (ret != 0)
-		rtw_ndev_notifier_unregister();
-
-	return ret;
-}
-
-static void __exit rtw_drv_halt(void)
-{
-	sdio_unregister_driver(&rtl8723bs_sdio_driver);
-
-	rtw_ndev_notifier_unregister();
-}
-
-
-module_init(rtw_drv_entry);
-module_exit(rtw_drv_halt);
+module_sdio_driver(rtl8723bs_sdio_driver);
-- 
2.39.2

