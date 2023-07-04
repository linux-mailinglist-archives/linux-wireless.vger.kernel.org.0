Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A5A7469AE
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jul 2023 08:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjGDG2w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Jul 2023 02:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjGDG2u (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Jul 2023 02:28:50 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DE8E47
        for <linux-wireless@vger.kernel.org>; Mon,  3 Jul 2023 23:28:46 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230704062843epoutp02030174cbf2bd5e6de03b51f754a3dba4~ulkLD4NsS1445514455epoutp02U
        for <linux-wireless@vger.kernel.org>; Tue,  4 Jul 2023 06:28:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230704062843epoutp02030174cbf2bd5e6de03b51f754a3dba4~ulkLD4NsS1445514455epoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1688452123;
        bh=7vlc9XlJtxocyOda11OuwIqLtzDcAyjFlBA5JfEM9B8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Q+TfXoJBSi+soeSjxOhzSNuFpm/eci4YShKMgoat/dyg7QZK/1w9+Ar1eYqJWSH/e
         svNQsBZ5JyW8IFDKhFK3AIqOS7Y0GblZMc+CCrdaOdmAPABmNxTzqfFJzoHl5E4cRD
         /u0Zl2v38Sfk4w/iF/+43wDkQKFTURSnRnyPn9e4=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230704062843epcas5p3e93e489e352d590ae42f2d3dc46af90d~ulkKzdcCc0106401064epcas5p3P;
        Tue,  4 Jul 2023 06:28:43 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BC.7D.44250.B1CB3A46; Tue,  4 Jul 2023 15:28:43 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230704061838epcas5p2d56b04612af73c01545bc7acb4400cab~ulbXLNMBH1672116721epcas5p2-;
        Tue,  4 Jul 2023 06:18:38 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230704061838epsmtrp238c7c91ac0958edccfcc85065bfe8643~ulbXKTd3E1925619256epsmtrp2_;
        Tue,  4 Jul 2023 06:18:38 +0000 (GMT)
X-AuditID: b6c32a4a-c4fff7000000acda-5b-64a3bc1b66f9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2B.E6.30535.EB9B3A46; Tue,  4 Jul 2023 15:18:38 +0900 (KST)
Received: from administrator-PowerEdge-R740xd.sa.corp.samsungelectronics.net
        (unknown [107.109.114.216]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA
        id
        20230704061837epsmtip260ebc490c9f17d176da2da23fdac1f1d~ulbWsey2a1336613366epsmtip2M;
        Tue,  4 Jul 2023 06:18:37 +0000 (GMT)
Received: from administrator-PowerEdge-R740xd.sa.corp.samsungelectronics.net
        (localhost [127.0.0.1]) by
        administrator-PowerEdge-R740xd.sa.corp.samsungelectronics.net
        (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 364EKOm91020197; Tue, 4 Jul
        2023 19:50:24 +0530
Received: (from user2@localhost) by
        administrator-PowerEdge-R740xd.sa.corp.samsungelectronics.net
        (8.15.2/8.15.2/Submit) id 364EKNDS1020196; Tue, 4 Jul 2023 19:50:23 +0530
From:   Kavitha Velayutham <k.velayutham@samsung.com>
To:     hostap@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Kavitha Velayutham <k.velayutham@samsung.com>
Subject: [PATCH 1/1] Patch [1/1] Changes for FILS External Authentication
Date:   Tue,  4 Jul 2023 19:50:19 +0530
Message-Id: <20230704142019.1020183-1-k.velayutham@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsWy7bCmlq70nsUpBp9ecFmsfZRmsfv5BVaL
        NyvusDswe2xeUu/Rt2UVo8fnTXIBzFFcNimpOZllqUX6dglcGT27L7AVzFvIVHHsz0PmBsYn
        rxm7GDk5JARMJBZMe8nSxcjFISSwm1Fi7e11TBDOJ0aJ39/uM0M43xglzsz/x9rFyAHWMnFu
        HkR8L6PEjn+LWEFGCQnMZ5KYtFESItHDJPFs9maoUesZJb7M7mQGqWITMJa4f6UHbLmIgJzE
        yZcXwOLMAsESXZv2sIPYwgKeErNb34PFWQRUJZqWLmYBsXkF7CUWzvoPdbi8xP6DZ5kh4oIS
        J2c+YYGYIy/RvHU22NkSAvvYJeZ+mcAC0eAisevNdiYIW1ji1fEt7BC2lMTnd3vZIOxsiZuL
        j0LVl0hsXrUcKm4v0b+/Gex9ZgFNifW79CHCshJTT61jgtjLJ9H7+wnUeF6JHfNgbDWJEx2r
        oEbKSCxueAple0gcfP6EcQKj4iwkL8xC8sIshG0LGJlXMUqmFhTnpqcWmxYY5aWW6xUn5haX
        5qXrJefnbmIEpw0trx2MDx980DvEyMTBeIhRgoNZSYS3+eH8FCHelMTKqtSi/Pii0pzU4kOM
        0hwsSuK8r1vnpggJpCeWpGanphakFsFkmTg4pRqYYo23iavVHXxiV+O2ab2Oy6IEoxWXFRVM
        lRosJ06fuG/NC8dV2+7fbJ4rsOqqVwcby9p5po1aXY+nXrPROlPHMbtJQntCeMK9/U4auz7w
        pb4X2NF00lfZd9aJZ1Njr5/YI10T1saQ1H+3g/XGZJ63hTKtbl2zTTm1Co/4cqnZMp7ftWvS
        B/v0oFVtsRPs1Uxbq8ortr/ZG5KU/c+mZc/VnfnfMzKm7J2mbePBOaM1s2Bx/1WxzvSbW/uW
        nMra47fgy/nz/7/+crPVcSrUmpHyb9s/L/bKE8Vd8lE3Znr7lhidako30ll6++wJrWJe0+I1
        W57yL1K9vtaJUyOjlPnLK7HDQUv2KvqInN/yWKlOiaU4I9FQi7moOBEAJVlVq4oDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsWy7bCSvO6+nYtTDPq3cVmsfZRmsfv5BVaL
        NyvusDswe2xeUu/Rt2UVo8fnTXIBzFFcNimpOZllqUX6dglcGT27L7AVzFvIVHHsz0PmBsYn
        rxm7GDk4JARMJCbOzeti5OIQEtjNKLG/9z1TFyMnUFxG4k73MUYIW1hi5b/n7BBFs5kkmm9u
        YIRwOpgk1s39zArhrGeUuHh+JjNIC5uAscT9Kz1g7SICchInX14AizMLREkc+H0NbIWwgKfE
        7Nb3YHEWAVWJpqWLWUBsXgF7iYWz/kOtlpfYf/AsM0RcUOLkzCcsEHPkJZq3zmaewCgwC0lq
        FpLUAkamVYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5uZsYwcGppbWDcc+qD3qHGJk4GA8x
        SnAwK4nwNj+cnyLEm5JYWZValB9fVJqTWnyIUZqDRUmc99vr3hQhgfTEktTs1NSC1CKYLBMH
        p1QDU9Ue+bDZjdcb5j49dOFpvcPjRZOuM2za2yVVumXFyidvHcPDy2xDAjpCQsstbuxq/XWS
        N6pjwk9x/0nrJjbd+JzRJfNv+wflf0sMPk14lLGJRXL7NbHT99+97wpvL/kuIrNpt4uRvvDT
        Auulv/uPrlIPD72ZdkPQxnPCedNFmn9lf2lXG/98oM8oGPq8h10iouaV5Q7FJ6s3HRJdF3k8
        fuGhtsyw81Yd0kv2hTE/VLwzzYab59nM0AfLJyR0Slw7UTzXnT9XztYgLC3KTXHmiocrpKeE
        ++1WvBI0aZrC1Wdli/mXLDj2VkFD6UtQ3bpauRWNPrtfTWL6kFxkJiid7zHpSuO+lQxBwhsT
        bx6qPavEUpyRaKjFXFScCADDzPUyvQIAAA==
X-CMS-MailID: 20230704061838epcas5p2d56b04612af73c01545bc7acb4400cab
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20230704061838epcas5p2d56b04612af73c01545bc7acb4400cab
References: <CGME20230704061838epcas5p2d56b04612af73c01545bc7acb4400cab@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        NO_DNS_FOR_FROM,RCVD_IN_DNSWL_MED,SPF_FAIL,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Changes for Authentication to be done in supplicant where sme is in driver
for FILS Authentication.

Signed-off-by: Kavitha Velayutham <k.velayutham@samsung.com>
---
 src/drivers/driver.h               |  14 ++
 src/drivers/driver_nl80211.c       |  57 +++++
 src/drivers/driver_nl80211_capa.c  |   6 +-
 src/drivers/driver_nl80211_event.c |   1 +
 src/drivers/nl80211_copy.h         |   6 +
 src/rsn_supp/wpa.c                 | 365 ++++++++++++++++++++---------
 src/rsn_supp/wpa.h                 |  11 +
 wpa_supplicant/driver_i.h          |  11 +
 wpa_supplicant/events.c            |  36 ++-
 wpa_supplicant/sme.c               | 253 ++++++++++++++++++--
 wpa_supplicant/sme.h               |   6 +
 wpa_supplicant/wpa_supplicant.c    |   9 +-
 12 files changed, 632 insertions(+), 143 deletions(-)

diff --git a/src/drivers/driver.h b/src/drivers/driver.h
index 101f98a72..2463c7baa 100644
--- a/src/drivers/driver.h
+++ b/src/drivers/driver.h
@@ -1294,6 +1294,16 @@ struct wpa_driver_associate_params {
 	 */
 	enum sae_pwe sae_pwe;
 
+	/**
+	 * fils_key_auth_sta - Length of Key Auth STA
+	 */
+	u8 *fils_key_auth_sta;
+
+	/**
+	 * fils_key_auth_sta_len - Length of fils_key_auth_sta in bytes
+	 */
+	size_t fils_key_auth_sta_len;
+
 	/**
 	 * disable_eht - Disable EHT for this connection
 	 */
@@ -2226,6 +2236,7 @@ struct wpa_driver_capa {
 #define WPA_DRIVER_FLAGS2_PROT_RANGE_NEG_STA	0x0000000000002000ULL
 /** Driver supports MLO in station/AP mode */
 #define WPA_DRIVER_FLAGS2_MLO			0x0000000000004000ULL
+#define WPA_DRIVER_FLAGS_FILS_EXTERNAL_AUTH	0x0000000000008000ULL
 	u64 flags2;
 
 #define FULL_AP_CLIENT_STATE_SUPP(drv_flags) \
@@ -4948,6 +4959,9 @@ struct wpa_driver_ops {
 	int (*send_external_auth_status)(void *priv,
 					 struct external_auth *params);
 
+	int (*send_assoc_fils_ie)(void *priv,
+				  struct wpa_driver_associate_params *params);
+
 	/**
 	 * set_4addr_mode - Set 4-address mode
 	 * @priv: Private driver interface data
diff --git a/src/drivers/driver_nl80211.c b/src/drivers/driver_nl80211.c
index eb25730c5..41a0db06b 100644
--- a/src/drivers/driver_nl80211.c
+++ b/src/drivers/driver_nl80211.c
@@ -2446,6 +2446,10 @@ static int nl80211_mgmt_subscribe_non_ap(struct i802_bss *bss)
 		nl80211_register_frame(bss, bss->nl_mgmt, type,
 				       (u8 *) "\x03\x00", 2, false);
 	}
+	if (drv->capa.flags2 & WPA_DRIVER_FLAGS_FILS_EXTERNAL_AUTH) {
+		nl80211_register_frame(bss, bss->nl_mgmt, type,
+                                       (u8 *) "\x04\x00", 2, false);
+	}
 
 #ifdef CONFIG_PASN
 	/* register for PASN Authentication frames */
@@ -6850,6 +6854,10 @@ static int nl80211_connect_common(struct wpa_driver_nl80211_data *drv,
 		return -1;
 
 	if ((wpa_key_mgmt_sae(params->key_mgmt_suite) ||
+	     params->key_mgmt_suite == WPA_KEY_MGMT_FILS_SHA256 ||
+	     params->key_mgmt_suite == WPA_KEY_MGMT_FILS_SHA384 ||
+	     params->key_mgmt_suite == WPA_KEY_MGMT_FT_FILS_SHA256 ||
+	     params->key_mgmt_suite == WPA_KEY_MGMT_FT_FILS_SHA384 ||
 	     wpa_key_mgmt_sae(params->allowed_key_mgmts)) &&
 	    (!(drv->capa.flags & WPA_DRIVER_FLAGS_SME)) &&
 	    nla_put_flag(msg, NL80211_ATTR_EXTERNAL_AUTH_SUPPORT))
@@ -7013,6 +7021,10 @@ static int wpa_driver_nl80211_associate(
 		if (wpa_driver_nl80211_set_mode(priv, nlmode) < 0)
 			return -1;
 		if (wpa_key_mgmt_sae(params->key_mgmt_suite) ||
+		    params->key_mgmt_suite == WPA_KEY_MGMT_FILS_SHA256 ||
+		    params->key_mgmt_suite == WPA_KEY_MGMT_FILS_SHA384 ||
+		    params->key_mgmt_suite == WPA_KEY_MGMT_FT_FILS_SHA256 ||
+		    params->key_mgmt_suite == WPA_KEY_MGMT_FT_FILS_SHA384 ||
 		    wpa_key_mgmt_sae(params->allowed_key_mgmts))
 			bss->use_nl_connect = 1;
 		else
@@ -13269,6 +13281,50 @@ fail:
 	return ret;
 }
 
+static int nl80211_send_assoc_fils_ie(void *priv,
+				      struct wpa_driver_associate_params *params)
+{
+	struct i802_bss *bss = priv;
+	struct wpa_driver_nl80211_data *drv = bss->drv;
+	struct nl_msg *msg = NULL;
+	int ret = -1;
+
+	if (!(drv->capa.flags2 & WPA_DRIVER_FLAGS_FILS_EXTERNAL_AUTH))
+		return -1;
+
+	wpa_dbg(drv->ctx, MSG_DEBUG,
+		"nl80211: External Assoc Fils key auth sta Len: %zu", params->fils_key_auth_sta_len);
+
+	msg = nl80211_drv_msg(drv, 0, NL80211_CMD_FILS_ASSOC_REQ_INFO);
+	if (!msg ||
+	     nla_put(msg, NL80211_ATTR_FILS_ASSOC_IE, params->fils_key_auth_sta_len, params->fils_key_auth_sta))
+		goto fail;
+	if (params->fils_kek) {
+		wpa_printf(MSG_DEBUG, "  * FILS KEK (len=%u)",
+			   (unsigned int) params->fils_kek_len);
+		if (nla_put(msg, NL80211_ATTR_FILS_KEK, params->fils_kek_len,
+			    params->fils_kek))
+			goto fail;
+	}
+	if (params->fils_nonces) {
+		wpa_printf(MSG_DEBUG, "  * FILS NONCE (len=%u)",
+			   (unsigned int) params->fils_nonces_len);
+		if (nla_put(msg, NL80211_ATTR_FILS_NONCES, params->fils_nonces_len,
+			    params->fils_nonces))
+			goto fail;
+	}
+	ret = send_and_recv_msgs(drv, msg, NULL, NULL, NULL, NULL);
+	msg = NULL;
+
+	if (ret) {
+		wpa_printf(MSG_DEBUG,
+			   "nl80211: Send Assoc Fils IE Failed: ret=%d (%s)",
+			   ret, strerror(-ret));
+	}
+fail:
+	nlmsg_free(msg);
+	return ret;
+}
 
 static int nl80211_set_4addr_mode(void *priv, const char *bridge_ifname,
 				  int val)
@@ -13599,6 +13655,7 @@ const struct wpa_driver_ops wpa_driver_nl80211_ops = {
 	.update_connect_params = nl80211_update_connection_params,
 	.send_external_auth_status = nl80211_send_external_auth_status,
 	.set_4addr_mode = nl80211_set_4addr_mode,
+	.send_assoc_fils_ie = nl80211_send_assoc_fils_ie,
 #ifdef CONFIG_DPP
 	.dpp_listen = nl80211_dpp_listen,
 #endif /* CONFIG_DPP */
diff --git a/src/drivers/driver_nl80211_capa.c b/src/drivers/driver_nl80211_capa.c
index b904398ca..b33c3ab0e 100644
--- a/src/drivers/driver_nl80211_capa.c
+++ b/src/drivers/driver_nl80211_capa.c
@@ -592,6 +592,9 @@ static void wiphy_info_ext_feature_flags(struct wiphy_info_data *info,
 	if (ext_feature_isset(ext_features, len,
 			      NL80211_EXT_FEATURE_FILS_SK_OFFLOAD))
 		capa->flags |= WPA_DRIVER_FLAGS_FILS_SK_OFFLOAD;
+	if (ext_feature_isset(ext_features, len,
+			      NL80211_EXT_FEATURE_EXTERNAL_AUTH_FILS))
+		capa->flags2 |= WPA_DRIVER_FLAGS_FILS_EXTERNAL_AUTH;
 
 	if (ext_feature_isset(ext_features, len,
 			      NL80211_EXT_FEATURE_4WAY_HANDSHAKE_STA_PSK))
@@ -1451,7 +1454,8 @@ int wpa_driver_nl80211_capa(struct wpa_driver_nl80211_data *drv)
 				WPA_DRIVER_CAPA_KEY_MGMT_FT_FILS_SHA256 |
 				WPA_DRIVER_CAPA_KEY_MGMT_FT_FILS_SHA384 |
 				WPA_DRIVER_CAPA_KEY_MGMT_SAE;
-		else if (drv->capa.flags & WPA_DRIVER_FLAGS_FILS_SK_OFFLOAD)
+		else if (drv->capa.flags & WPA_DRIVER_FLAGS_FILS_SK_OFFLOAD ||
+			 drv->capa.flags2 & WPA_DRIVER_FLAGS_FILS_EXTERNAL_AUTH)
 			drv->capa.key_mgmt |=
 				WPA_DRIVER_CAPA_KEY_MGMT_FILS_SHA256 |
 				WPA_DRIVER_CAPA_KEY_MGMT_FILS_SHA384;
diff --git a/src/drivers/driver_nl80211_event.c b/src/drivers/driver_nl80211_event.c
index a6f8c97ca..2037261a0 100644
--- a/src/drivers/driver_nl80211_event.c
+++ b/src/drivers/driver_nl80211_event.c
@@ -185,6 +185,7 @@ static const char * nl80211_command_to_string(enum nl80211_commands cmd)
 	C2S(NL80211_CMD_MODIFY_LINK_STA)
 	C2S(NL80211_CMD_REMOVE_LINK_STA)
 	C2S(NL80211_CMD_SET_HW_TIMESTAMP)
+	C2S(NL80211_CMD_FILS_ASSOC_REQ_INFO)
 	C2S(__NL80211_CMD_AFTER_LAST)
 	}
 #undef C2S
diff --git a/src/drivers/nl80211_copy.h b/src/drivers/nl80211_copy.h
index c59fec406..4a31127b6 100644
--- a/src/drivers/nl80211_copy.h
+++ b/src/drivers/nl80211_copy.h
@@ -1562,6 +1562,8 @@ enum nl80211_commands {
 
 	NL80211_CMD_SET_HW_TIMESTAMP,
 
+	NL80211_CMD_FILS_ASSOC_REQ_INFO,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
@@ -1583,6 +1585,7 @@ enum nl80211_commands {
 #define NL80211_CMD_REG_BEACON_HINT NL80211_CMD_REG_BEACON_HINT
 
 #define NL80211_ATTR_FEATURE_FLAGS NL80211_ATTR_FEATURE_FLAGS
+#define NL80211_CMD_FILS_ASSOC_REQ_INFO NL80211_CMD_FILS_ASSOC_REQ_INFO
 
 /* source-level API compatibility */
 #define NL80211_CMD_GET_MESH_PARAMS NL80211_CMD_GET_MESH_CONFIG
@@ -3341,6 +3344,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_EMA_RNR_ELEMS,
 
+	NL80211_ATTR_FILS_ASSOC_IE,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -6443,6 +6448,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_PUNCT,
 	NL80211_EXT_FEATURE_SECURE_NAN,
 	NL80211_EXT_FEATURE_AUTH_AND_DEAUTH_RANDOM_TA,
+	NL80211_EXT_FEATURE_EXTERNAL_AUTH_FILS,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/src/rsn_supp/wpa.c b/src/rsn_supp/wpa.c
index 9c7c526fc..2806fb327 100644
--- a/src/rsn_supp/wpa.c
+++ b/src/rsn_supp/wpa.c
@@ -5225,6 +5225,259 @@ const u8 * wpa_sm_get_auth_addr(struct wpa_sm *sm)
 
 #ifdef CONFIG_FILS
 
+#ifdef CONFIG_IEEE80211R
+static int fils_ft_build_assoc_req_rsne(struct wpa_sm *sm, struct wpabuf *buf)
+{
+	struct rsn_ie_hdr *rsnie;
+	u16 capab;
+	u8 *pos;
+	int use_sha384 = wpa_key_mgmt_sha384(sm->key_mgmt);
+
+	/* RSNIE[PMKR0Name/PMKR1Name] */
+	rsnie = wpabuf_put(buf, sizeof(*rsnie));
+	rsnie->elem_id = WLAN_EID_RSN;
+	WPA_PUT_LE16(rsnie->version, RSN_VERSION);
+
+	/* Group Suite Selector */
+	if (!wpa_cipher_valid_group(sm->group_cipher)) {
+		wpa_printf(MSG_WARNING, "FT: Invalid group cipher (%d)",
+			   sm->group_cipher);
+		return -1;
+	}
+	pos = wpabuf_put(buf, RSN_SELECTOR_LEN);
+	RSN_SELECTOR_PUT(pos, wpa_cipher_to_suite(WPA_PROTO_RSN,
+						  sm->group_cipher));
+
+	/* Pairwise Suite Count */
+	wpabuf_put_le16(buf, 1);
+
+	/* Pairwise Suite List */
+	if (!wpa_cipher_valid_pairwise(sm->pairwise_cipher)) {
+		wpa_printf(MSG_WARNING, "FT: Invalid pairwise cipher (%d)",
+			   sm->pairwise_cipher);
+		return -1;
+	}
+	pos = wpabuf_put(buf, RSN_SELECTOR_LEN);
+	RSN_SELECTOR_PUT(pos, wpa_cipher_to_suite(WPA_PROTO_RSN,
+						  sm->pairwise_cipher));
+
+	/* Authenticated Key Management Suite Count */
+	wpabuf_put_le16(buf, 1);
+
+	/* Authenticated Key Management Suite List */
+	pos = wpabuf_put(buf, RSN_SELECTOR_LEN);
+	if (sm->key_mgmt == WPA_KEY_MGMT_FT_FILS_SHA256)
+		RSN_SELECTOR_PUT(pos, RSN_AUTH_KEY_MGMT_FT_FILS_SHA256);
+	else if (sm->key_mgmt == WPA_KEY_MGMT_FT_FILS_SHA384)
+		RSN_SELECTOR_PUT(pos, RSN_AUTH_KEY_MGMT_FT_FILS_SHA384);
+	else {
+		wpa_printf(MSG_WARNING,
+			   "FILS+FT: Invalid key management type (%d)",
+			   sm->key_mgmt);
+		return -1;
+	}
+
+	/* RSN Capabilities */
+	capab = 0;
+	if (sm->mfp)
+		capab |= WPA_CAPABILITY_MFPC;
+	if (sm->mfp == 2)
+		capab |= WPA_CAPABILITY_MFPR;
+	if (sm->ocv)
+		capab |= WPA_CAPABILITY_OCVC;
+	if (sm->ext_key_id)
+		capab |= WPA_CAPABILITY_EXT_KEY_ID_FOR_UNICAST;
+	wpabuf_put_le16(buf, capab);
+
+	/* PMKID Count */
+	wpabuf_put_le16(buf, 1);
+
+	/* PMKID List [PMKR1Name] */
+	wpa_hexdump_key(MSG_DEBUG, "FILS+FT: XXKey (FILS-FT)",
+			sm->fils_ft, sm->fils_ft_len);
+	wpa_hexdump_ascii(MSG_DEBUG, "FILS+FT: SSID", sm->ssid, sm->ssid_len);
+	wpa_hexdump(MSG_DEBUG, "FILS+FT: MDID",
+		    sm->mobility_domain, MOBILITY_DOMAIN_ID_LEN);
+	wpa_hexdump_ascii(MSG_DEBUG, "FILS+FT: R0KH-ID",
+			  sm->r0kh_id, sm->r0kh_id_len);
+	if (wpa_derive_pmk_r0(sm->fils_ft, sm->fils_ft_len, sm->ssid,
+			      sm->ssid_len, sm->mobility_domain,
+			      sm->r0kh_id, sm->r0kh_id_len, sm->own_addr,
+			      sm->pmk_r0, sm->pmk_r0_name, use_sha384) < 0) {
+		wpa_printf(MSG_WARNING, "FILS+FT: Could not derive PMK-R0");
+		return -1;
+	}
+	sm->pmk_r0_len = use_sha384 ? SHA384_MAC_LEN : PMK_LEN;
+	wpa_printf(MSG_DEBUG, "FILS+FT: R1KH-ID: " MACSTR,
+		   MAC2STR(sm->r1kh_id));
+	pos = wpabuf_put(buf, WPA_PMK_NAME_LEN);
+	if (wpa_derive_pmk_r1_name(sm->pmk_r0_name, sm->r1kh_id, sm->own_addr,
+				   sm->pmk_r1_name, use_sha384) < 0) {
+		wpa_printf(MSG_WARNING, "FILS+FT: Could not derive PMKR1Name");
+		return -1;
+	}
+	os_memcpy(pos, sm->pmk_r1_name, WPA_PMK_NAME_LEN);
+
+	if (sm->mgmt_group_cipher == WPA_CIPHER_AES_128_CMAC) {
+		/* Management Group Cipher Suite */
+		pos = wpabuf_put(buf, RSN_SELECTOR_LEN);
+		RSN_SELECTOR_PUT(pos, RSN_CIPHER_SUITE_AES_128_CMAC);
+	}
+
+	rsnie->len = ((u8 *) wpabuf_put(buf, 0) - (u8 *) rsnie) - 2;
+	return 0;
+}
+#endif /* CONFIG_IEEE80211R */
+
+struct wpabuf * fils_build_assoc_req_plain_external(struct wpa_sm *sm, const u8 **kek,
+						    size_t *kek_len, const u8 **snonce,
+						    const u8 **anonce,
+						    const struct wpabuf **hlp,
+						    unsigned int num_hlp)
+{
+	struct wpabuf *buf;
+	size_t len = 0;
+	unsigned int i;
+
+	for (i = 0; hlp && i < num_hlp; i++)
+		len += 10 + wpabuf_len(hlp[i]);
+	buf = wpabuf_alloc(len + 1000);
+	if (!buf)
+		return NULL;
+	/* FILS Key Confirm */
+	wpabuf_put_u8(buf, WLAN_EID_EXTENSION); /* Element ID */
+	wpabuf_put_u8(buf, 1 + sm->fils_key_auth_len); /* Length */
+	/* Element ID Extension */
+	wpabuf_put_u8(buf, WLAN_EID_EXT_FILS_KEY_CONFIRM);
+	wpabuf_put_data(buf, sm->fils_key_auth_sta, sm->fils_key_auth_len);
+
+	/* FILS HLP Container */
+	for (i = 0; hlp && i < num_hlp; i++) {
+		const u8 *pos = wpabuf_head(hlp[i]);
+		size_t left = wpabuf_len(hlp[i]);
+
+		wpabuf_put_u8(buf, WLAN_EID_EXTENSION); /* Element ID */
+		if (left <= 254)
+			len = 1 + left;
+		else
+			len = 255;
+		wpabuf_put_u8(buf, len); /* Length */
+		/* Element ID Extension */
+		wpabuf_put_u8(buf, WLAN_EID_EXT_FILS_HLP_CONTAINER);
+		/* Destination MAC Address, Source MAC Address, HLP Packet.
+		 * HLP Packet is in MSDU format (i.e., included the LLC/SNAP
+		 * header when LPD is used). */
+		wpabuf_put_data(buf, pos, len - 1);
+		pos += len - 1;
+		left -= len - 1;
+		while (left) {
+			wpabuf_put_u8(buf, WLAN_EID_FRAGMENT);
+			len = left > 255 ? 255 : left;
+			wpabuf_put_u8(buf, len);
+			wpabuf_put_data(buf, pos, len);
+			pos += len;
+			left -= len;
+		}
+	}
+
+	/* TODO: FILS IP Address Assignment */
+
+#ifdef CONFIG_OCV
+	if (wpa_sm_ocv_enabled(sm)) {
+		struct wpa_channel_info ci;
+		u8 *pos;
+
+		if (wpa_sm_channel_info(sm, &ci) != 0) {
+			wpa_printf(MSG_WARNING,
+				   "FILS: Failed to get channel info for OCI element");
+			wpabuf_free(buf);
+			return NULL;
+		}
+
+		pos = wpabuf_put(buf, OCV_OCI_EXTENDED_LEN);
+		if (ocv_insert_extended_oci(&ci, pos) < 0) {
+			wpabuf_free(buf);
+			return NULL;
+		}
+	}
+#endif /* CONFIG_OCV */
+
+	wpa_hexdump_buf(MSG_DEBUG, "FILS: Association Request plaintext", buf);
+
+	*kek = sm->ptk.kek;
+	*kek_len = sm->ptk.kek_len;
+	wpa_hexdump_key(MSG_DEBUG, "FILS: KEK for AEAD", *kek, *kek_len);
+	*snonce = sm->fils_nonce;
+	wpa_hexdump(MSG_DEBUG, "FILS: SNonce for AEAD AAD",
+		    *snonce, FILS_NONCE_LEN);
+	*anonce = sm->fils_anonce;
+	wpa_hexdump(MSG_DEBUG, "FILS: ANonce for AEAD AAD",
+		    *anonce, FILS_NONCE_LEN);
+
+	return buf;
+}
+
+struct wpabuf * fils_build_assoc_req_external(struct wpa_sm *sm, const u8 **kek,
+					      size_t *kek_len, const u8 **snonce,
+					      const u8 **anonce,
+					      const struct wpabuf **hlp,
+					      unsigned int num_hlp, u8 *sa, const u8 *bssid,
+					      int *len_encr_start)
+{
+	struct wpabuf *buf , *plain;
+	size_t len;
+	unsigned int i, pos;
+	const u8 *aad[5];
+	size_t aad_len[5];
+	le16 capab_info = 0x0000;
+
+	len = 10000;
+#ifdef CONFIG_IEEE80211R
+	if (sm->fils_ft_ies)
+		len += wpabuf_len(sm->fils_ft_ies);
+	if (wpa_key_mgmt_ft(sm->key_mgmt))
+		len += 256;
+#endif /* CONFIG_IEEE80211R */
+	for (i = 0; hlp && i < num_hlp; i++)
+		len += 10 + wpabuf_len(hlp[i]);
+	len += AES_BLOCK_SIZE;
+
+	buf = wpabuf_alloc(len);
+	if (!buf)
+		return NULL;
+
+#ifdef CONFIG_IEEE80211R
+	if (wpa_key_mgmt_ft(sm->key_mgmt) && sm->fils_ft_ies) {
+		/* MDE and FTE when using FILS+FT */
+		wpabuf_put_buf(buf, sm->fils_ft_ies);
+		/* RSNE with PMKR1Name in PMKID field */
+		if (fils_ft_build_assoc_req_rsne(sm, buf) < 0) {
+			wpabuf_free(buf);
+			return NULL;
+		}
+	}
+#endif /* CONFIG_IEEE80211R */
+	/* FILS Session */
+	wpabuf_put_u8(buf, WLAN_EID_EXTENSION); /* Element ID */
+	wpabuf_put_u8(buf, 1 + FILS_SESSION_LEN); /* Length */
+	/* Element ID Extension */
+	wpabuf_put_u8(buf, WLAN_EID_EXT_FILS_SESSION);
+	wpabuf_put_data(buf, sm->fils_session, FILS_SESSION_LEN);
+
+	*len_encr_start = buf->used;
+
+	/* TODO: FILS Public Key */
+	plain = fils_build_assoc_req_plain_external(sm, kek,
+						    kek_len, snonce,
+						    anonce,
+						    (const struct wpabuf **) hlp,
+						    num_hlp);
+
+	wpabuf_put_data(buf, wpabuf_head(plain), wpabuf_len(plain));
+
+	return buf;
+}
+
 struct wpabuf * fils_build_auth(struct wpa_sm *sm, int dh_group, const u8 *md)
 {
 	struct wpabuf *buf = NULL;
@@ -5669,118 +5922,6 @@ fail:
 	return -1;
 }
 
-
-#ifdef CONFIG_IEEE80211R
-static int fils_ft_build_assoc_req_rsne(struct wpa_sm *sm, struct wpabuf *buf)
-{
-	struct rsn_ie_hdr *rsnie;
-	u16 capab;
-	u8 *pos;
-	int use_sha384 = wpa_key_mgmt_sha384(sm->key_mgmt);
-
-	/* RSNIE[PMKR0Name/PMKR1Name] */
-	rsnie = wpabuf_put(buf, sizeof(*rsnie));
-	rsnie->elem_id = WLAN_EID_RSN;
-	WPA_PUT_LE16(rsnie->version, RSN_VERSION);
-
-	/* Group Suite Selector */
-	if (!wpa_cipher_valid_group(sm->group_cipher)) {
-		wpa_printf(MSG_WARNING, "FT: Invalid group cipher (%d)",
-			   sm->group_cipher);
-		return -1;
-	}
-	pos = wpabuf_put(buf, RSN_SELECTOR_LEN);
-	RSN_SELECTOR_PUT(pos, wpa_cipher_to_suite(WPA_PROTO_RSN,
-						  sm->group_cipher));
-
-	/* Pairwise Suite Count */
-	wpabuf_put_le16(buf, 1);
-
-	/* Pairwise Suite List */
-	if (!wpa_cipher_valid_pairwise(sm->pairwise_cipher)) {
-		wpa_printf(MSG_WARNING, "FT: Invalid pairwise cipher (%d)",
-			   sm->pairwise_cipher);
-		return -1;
-	}
-	pos = wpabuf_put(buf, RSN_SELECTOR_LEN);
-	RSN_SELECTOR_PUT(pos, wpa_cipher_to_suite(WPA_PROTO_RSN,
-						  sm->pairwise_cipher));
-
-	/* Authenticated Key Management Suite Count */
-	wpabuf_put_le16(buf, 1);
-
-	/* Authenticated Key Management Suite List */
-	pos = wpabuf_put(buf, RSN_SELECTOR_LEN);
-	if (sm->key_mgmt == WPA_KEY_MGMT_FT_FILS_SHA256)
-		RSN_SELECTOR_PUT(pos, RSN_AUTH_KEY_MGMT_FT_FILS_SHA256);
-	else if (sm->key_mgmt == WPA_KEY_MGMT_FT_FILS_SHA384)
-		RSN_SELECTOR_PUT(pos, RSN_AUTH_KEY_MGMT_FT_FILS_SHA384);
-	else {
-		wpa_printf(MSG_WARNING,
-			   "FILS+FT: Invalid key management type (%d)",
-			   sm->key_mgmt);
-		return -1;
-	}
-
-	/* RSN Capabilities */
-	capab = 0;
-	if (sm->mfp)
-		capab |= WPA_CAPABILITY_MFPC;
-	if (sm->mfp == 2)
-		capab |= WPA_CAPABILITY_MFPR;
-	if (sm->ocv)
-		capab |= WPA_CAPABILITY_OCVC;
-	if (sm->ext_key_id)
-		capab |= WPA_CAPABILITY_EXT_KEY_ID_FOR_UNICAST;
-	wpabuf_put_le16(buf, capab);
-
-	/* PMKID Count */
-	wpabuf_put_le16(buf, 1);
-
-	/* PMKID List [PMKR1Name] */
-	wpa_hexdump_key(MSG_DEBUG, "FILS+FT: XXKey (FILS-FT)",
-			sm->fils_ft, sm->fils_ft_len);
-	wpa_hexdump_ascii(MSG_DEBUG, "FILS+FT: SSID", sm->ssid, sm->ssid_len);
-	wpa_hexdump(MSG_DEBUG, "FILS+FT: MDID",
-		    sm->mobility_domain, MOBILITY_DOMAIN_ID_LEN);
-	wpa_hexdump_ascii(MSG_DEBUG, "FILS+FT: R0KH-ID",
-			  sm->r0kh_id, sm->r0kh_id_len);
-	if (wpa_derive_pmk_r0(sm->fils_ft, sm->fils_ft_len, sm->ssid,
-			      sm->ssid_len, sm->mobility_domain,
-			      sm->r0kh_id, sm->r0kh_id_len, sm->own_addr,
-			      sm->pmk_r0, sm->pmk_r0_name, sm->key_mgmt) < 0) {
-		wpa_printf(MSG_WARNING, "FILS+FT: Could not derive PMK-R0");
-		return -1;
-	}
-	if (wpa_key_mgmt_sae_ext_key(sm->key_mgmt))
-		sm->pmk_r0_len = sm->fils_ft_len;
-	else
-		sm->pmk_r0_len = use_sha384 ? SHA384_MAC_LEN : PMK_LEN;
-	wpa_printf(MSG_DEBUG, "FILS+FT: R1KH-ID: " MACSTR,
-		   MAC2STR(sm->r1kh_id));
-	pos = wpabuf_put(buf, WPA_PMK_NAME_LEN);
-	if (wpa_derive_pmk_r1_name(sm->pmk_r0_name, sm->r1kh_id, sm->own_addr,
-				   sm->pmk_r1_name, sm->fils_ft_len) < 0) {
-		wpa_printf(MSG_WARNING, "FILS+FT: Could not derive PMKR1Name");
-		return -1;
-	}
-	os_memcpy(pos, sm->pmk_r1_name, WPA_PMK_NAME_LEN);
-
-	os_memcpy(sm->key_mobility_domain, sm->mobility_domain,
-		  MOBILITY_DOMAIN_ID_LEN);
-
-	if (sm->mgmt_group_cipher == WPA_CIPHER_AES_128_CMAC) {
-		/* Management Group Cipher Suite */
-		pos = wpabuf_put(buf, RSN_SELECTOR_LEN);
-		RSN_SELECTOR_PUT(pos, RSN_CIPHER_SUITE_AES_128_CMAC);
-	}
-
-	rsnie->len = ((u8 *) wpabuf_put(buf, 0) - (u8 *) rsnie) - 2;
-	return 0;
-}
-#endif /* CONFIG_IEEE80211R */
-
-
 struct wpabuf * fils_build_assoc_req(struct wpa_sm *sm, const u8 **kek,
 				     size_t *kek_len, const u8 **snonce,
 				     const u8 **anonce,
diff --git a/src/rsn_supp/wpa.h b/src/rsn_supp/wpa.h
index b3c8b6a7d..03d15a84b 100644
--- a/src/rsn_supp/wpa.h
+++ b/src/rsn_supp/wpa.h
@@ -490,6 +490,17 @@ int wpa_ft_validate_reassoc_resp(struct wpa_sm *sm, const u8 *ies,
 				 size_t ies_len, const u8 *src_addr);
 int wpa_ft_start_over_ds(struct wpa_sm *sm, const u8 *target_ap,
 			 const u8 *mdie, bool force);
+struct wpabuf * fils_build_assoc_req_external(struct wpa_sm *sm, const u8 **kek,
+					      size_t *kek_len, const u8 **snonce,
+					      const u8 **anonce,
+					      const struct wpabuf **hlp,
+					      unsigned int num_hlp, u8 *sa, const u8 *bssid,
+					      int *len_encr_start);
+struct wpabuf * fils_build_assoc_req_plain_external(struct wpa_sm *sm, const u8 **kek,
+						    size_t *kek_len, const u8 **snonce,
+						    const u8 **anonce,
+						    const struct wpabuf **hlp,
+						    unsigned int num_hlp);
 
 #ifdef CONFIG_PASN
 
diff --git a/wpa_supplicant/driver_i.h b/wpa_supplicant/driver_i.h
index d707cf556..747197954 100644
--- a/wpa_supplicant/driver_i.h
+++ b/wpa_supplicant/driver_i.h
@@ -1112,6 +1112,17 @@ wpa_drv_send_external_auth_status(struct wpa_supplicant *wpa_s,
 							params);
 }
 
+static inline int
+wpa_drv_send_external_assoc_fils_ie(struct wpa_supplicant *wpa_s,
+				    struct wpa_driver_associate_params *params)
+{
+	if (!wpa_s->driver->send_assoc_fils_ie)
+		return -1;
+	return wpa_s->driver->send_assoc_fils_ie(wpa_s->drv_priv,
+						 params);
+}
+
+
 static inline int wpa_drv_set_4addr_mode(struct wpa_supplicant *wpa_s, int val)
 {
 	if (!wpa_s->driver->set_4addr_mode)
diff --git a/wpa_supplicant/events.c b/wpa_supplicant/events.c
index 896c53841..aedacdc0a 100644
--- a/wpa_supplicant/events.c
+++ b/wpa_supplicant/events.c
@@ -4989,7 +4989,8 @@ static void wpa_supplicant_event_assoc_auth(struct wpa_supplicant *wpa_s,
 			       data->assoc_info.ptk_kek,
 			       data->assoc_info.ptk_kek_len);
 #ifdef CONFIG_FILS
-	if (wpa_s->auth_alg == WPA_AUTH_ALG_FILS) {
+	if (wpa_s->auth_alg == WPA_AUTH_ALG_FILS &&
+	    !(wpa_s->drv_flags2 & WPA_DRIVER_FLAGS_FILS_EXTERNAL_AUTH)) {
 		struct wpa_bss *bss = wpa_bss_get_bssid(wpa_s, wpa_s->bssid);
 		const u8 *fils_cache_id = wpa_bss_get_fils_cache_id(bss);
 
@@ -5314,6 +5315,15 @@ void wpa_supplicant_event(void *ctx, enum wpa_event_type event,
 				   "Ignore unexpected EVENT_ASSOC in disconnected state");
 			break;
 		}
+		if (!(wpa_s->drv_flags & WPA_DRIVER_FLAGS_SME) &&
+		    wpa_auth_alg_fils(wpa_s->auth_alg)) {
+			if (fils_process_assoc_resp(wpa_s->wpa,
+						    data->assoc_info.resp_ies,
+						    data->assoc_info.resp_ies_len) < 0) {
+				wpa_supplicant_deauthenticate(wpa_s, WLAN_REASON_UNSPECIFIED);
+				return;
+			}
+		}
 		wpa_supplicant_event_assoc(wpa_s, data);
 		wpa_s->assoc_status_code = WLAN_STATUS_SUCCESS;
 		if (data &&
@@ -5752,11 +5762,19 @@ void wpa_supplicant_event(void *ctx, enum wpa_event_type event,
 #ifdef CONFIG_SAE
 			if (stype == WLAN_FC_STYPE_AUTH &&
 			    !(wpa_s->drv_flags & WPA_DRIVER_FLAGS_SME) &&
-			    (wpa_s->drv_flags & WPA_DRIVER_FLAGS_SAE)) {
-				sme_external_auth_mgmt_rx(
-					wpa_s, data->rx_mgmt.frame,
-					data->rx_mgmt.frame_len);
-				break;
+			    (wpa_s->drv_flags & WPA_DRIVER_FLAGS_SAE ||
+			    wpa_s->drv_flags2 & WPA_DRIVER_FLAGS_FILS_EXTERNAL_AUTH)) {
+				if (le_to_host16(mgmt->u.auth.auth_alg) == WLAN_AUTH_SAE) {
+					sme_external_auth_mgmt_rx(wpa_s, data->rx_mgmt.frame,
+								  data->rx_mgmt.frame_len);
+					break;
+				}
+				if (le_to_host16(mgmt->u.auth.auth_alg) == WLAN_AUTH_FILS_SK) {
+					sme_external_auth_mgmt_rx_fils(wpa_s, data->rx_mgmt.frame,
+								       data->rx_mgmt.frame_len);
+					break;
+
+				}
 			}
 #endif /* CONFIG_SAE */
 			wpa_dbg(wpa_s, MSG_DEBUG, "AP: ignore received "
@@ -6108,13 +6126,13 @@ void wpa_supplicant_event(void *ctx, enum wpa_event_type event,
 		bgscan_notify_beacon_loss(wpa_s);
 		break;
 	case EVENT_EXTERNAL_AUTH:
-#ifdef CONFIG_SAE
+#if defined(CONFIG_SAE) || defined(CONFIG_FILS)
 		if (!wpa_s->current_ssid) {
-			wpa_printf(MSG_DEBUG, "SAE: current_ssid is NULL");
+			wpa_printf(MSG_DEBUG, "Auth: Current_ssid is NULL");
 			break;
 		}
 		sme_external_auth_trigger(wpa_s, data);
-#endif /* CONFIG_SAE */
+#endif /* CONFIG_SAE CONFIG_FILS*/
 		break;
 #ifdef CONFIG_PASN
 	case EVENT_PASN_AUTH:
diff --git a/wpa_supplicant/sme.c b/wpa_supplicant/sme.c
index 51bc44246..38f02d22c 100644
--- a/wpa_supplicant/sme.c
+++ b/wpa_supplicant/sme.c
@@ -1321,6 +1321,219 @@ void sme_authenticate(struct wpa_supplicant *wpa_s,
 		wpas_connect_work_free(cwork);
 }
 
+static void sme_send_external_auth_status(struct wpa_supplicant *wpa_s,
+					  u16 status)
+{
+	struct external_auth params;
+
+	os_memset(&params, 0, sizeof(params));
+	params.status = status;
+	params.ssid = wpa_s->sme.ext_auth_ssid;
+	params.ssid_len = wpa_s->sme.ext_auth_ssid_len;
+	params.bssid = wpa_s->sme.ext_auth_bssid;
+	if (wpa_s->conf->sae_pmkid_in_assoc && status == WLAN_STATUS_SUCCESS)
+		params.pmkid = wpa_s->sme.sae.pmkid;
+	wpa_drv_send_external_auth_status(wpa_s, &params);
+}
+
+#ifdef CONFIG_FILS
+
+static void sme_external_send_fils_kek_key_auth_sta(struct wpa_supplicant *wpa_s, struct wpabuf *buf)
+{
+	struct wpa_driver_associate_params params;
+	u8 nonces[2 * FILS_NONCE_LEN];
+
+	params.fils_kek = wpa_s->wpa->ptk.kek;
+	params.fils_kek_len = wpa_s->wpa->ptk.kek_len;
+	params.fils_key_auth_sta = buf->buf;
+	params.fils_key_auth_sta_len = wpabuf_len(buf);
+	os_memcpy(nonces, wpa_s->wpa->fils_nonce, FILS_NONCE_LEN);
+	os_memcpy(nonces + FILS_NONCE_LEN, wpa_s->wpa->fils_anonce, FILS_NONCE_LEN);
+	params.fils_nonces = nonces;
+	params.fils_nonces_len = sizeof(nonces);
+
+	wpa_drv_send_external_assoc_fils_ie(wpa_s, &params);
+}
+
+
+static struct wpabuf * sme_assoc_build_external_fils(struct wpa_supplicant *wpa_s,
+						     enum wpas_mode mode,
+						     const u8 *bssid, u16 auth_type)
+{
+	struct wpa_driver_associate_params params;
+	struct ieee802_11_elems elems;
+	struct wpabuf *resp;
+	struct wpabuf *buf = NULL,*fils_plain = NULL;
+	int len_encr_start;
+	int len;
+
+#ifdef CONFIG_FILS
+	u8 nonces[2 * FILS_NONCE_LEN];
+#endif /* CONFIG_FILS */
+	os_memset(&params, 0, sizeof(params));
+
+	if (auth_type == WLAN_AUTH_FILS_SK ||
+	    auth_type == WLAN_AUTH_FILS_SK_PFS) {
+		const u8 *snonce, *anonce;
+		const unsigned int max_hlp = 20;
+		struct wpabuf *hlp[max_hlp];
+		unsigned int i, num_hlp = 0;
+		struct fils_hlp_req *req;
+
+		dl_list_for_each(req, &wpa_s->fils_hlp_req, struct fils_hlp_req,
+				 list) {
+			hlp[num_hlp] = wpabuf_alloc(2 * ETH_ALEN + 6 +
+					      wpabuf_len(req->pkt));
+			if (!hlp[num_hlp])
+				break;
+			wpabuf_put_data(hlp[num_hlp], req->dst, ETH_ALEN);
+			wpabuf_put_data(hlp[num_hlp], wpa_s->own_addr,
+					ETH_ALEN);
+			wpabuf_put_data(hlp[num_hlp],
+					"\xaa\xaa\x03\x00\x00\x00", 6);
+			wpabuf_put_buf(hlp[num_hlp], req->pkt);
+			num_hlp++;
+			if (num_hlp >= max_hlp)
+				break;
+		}
+
+		fils_plain = fils_build_assoc_req_external(wpa_s->wpa, &params.fils_kek,
+							   &params.fils_kek_len, &snonce,
+							   &anonce,
+							   (const struct wpabuf **) hlp,
+							   num_hlp, wpa_s->own_addr, bssid,
+							   &len_encr_start);
+		for (i = 0; i < num_hlp; i++)
+			wpabuf_free(hlp[i]);
+		if (!fils_plain) {
+			wpa_dbg(wpa_s, MSG_DEBUG, "Fils plain ie is Null");
+			return NULL;
+		}
+	}
+	return fils_plain;
+}
+
+static int sme_external_auth_send_fils(struct wpa_supplicant *wpa_s,
+				       const u8 *bssid,
+				       const u8 *ssid_authframe)
+{
+	struct wpabuf *resp, *buf;
+	struct ieee80211_mgmt *authframe;
+	int use_pt;
+	int auth_alg;
+	const u8 *md = NULL;
+	struct wpa_bss *bss;
+	struct wpa_ssid *ssid = wpa_s->current_ssid;
+
+	resp = fils_build_auth(wpa_s->wpa, ssid->fils_dh_group, md);
+
+	if (!resp) {
+		wpa_printf(MSG_DEBUG, "SAE: Failed to build FILS Auth");
+		return -1;
+	}
+	wpa_s->sme.seq_num++;
+	buf = wpabuf_alloc(sizeof(struct ieee80211_hdr) + 6 + wpabuf_len(resp));
+	if (!buf) {
+		wpabuf_free(resp);
+		return -1;
+	}
+
+	authframe = wpabuf_put(buf, offsetof(struct ieee80211_mgmt,
+					     u.auth.auth_transaction));
+
+	authframe->frame_control = host_to_le16((WLAN_FC_TYPE_MGMT << 2) |
+						(WLAN_FC_STYPE_AUTH << 4));
+	os_memcpy(authframe->da, bssid, ETH_ALEN);
+	os_memcpy(authframe->sa, wpa_s->own_addr, ETH_ALEN);
+	os_memcpy(authframe->bssid, bssid, ETH_ALEN);
+
+	if (ssid->fils_dh_group)
+		wpa_printf(MSG_DEBUG,
+			   "SME: Try to use FILS SK authentication with PFS (DH Group %u)",
+			   ssid->fils_dh_group);
+	else
+		wpa_printf(MSG_DEBUG,
+			   "SME: Try to use FILS SK authentication without PFS");
+	auth_alg = ssid->fils_dh_group ?
+		WLAN_AUTH_FILS_SK_PFS : WLAN_AUTH_FILS_SK;
+
+	authframe->seq_ctrl = host_to_le16(wpa_s->sme.seq_num << 4);
+	authframe->u.auth.auth_alg = host_to_le16(0x0004);
+
+	if (resp)
+		wpabuf_put_buf(buf, resp);
+
+	wpa_drv_send_mlme(wpa_s, wpabuf_head(buf), wpabuf_len(buf), 1, 0, 0);
+	wpabuf_free(resp);
+	wpabuf_free(buf);
+
+	return 0;
+}
+
+void sme_external_auth_mgmt_rx_fils(struct wpa_supplicant *wpa_s,
+				    const u8 *auth_frame, size_t len)
+{
+	const struct ieee80211_mgmt *header;
+	size_t auth_length;
+	struct wpabuf *buf = NULL;
+
+	header = (const struct ieee80211_mgmt *) auth_frame;
+	auth_length = IEEE80211_HDRLEN + sizeof(header->u.auth);
+
+	if (len < auth_length) {
+		sme_send_external_auth_status(wpa_s,
+					      WLAN_STATUS_UNSPECIFIED_FAILURE);
+		return;
+	}
+
+	if (header->u.auth.status_code != WLAN_STATUS_SUCCESS) {
+		sme_send_external_auth_status(wpa_s,
+					      WLAN_STATUS_UNSPECIFIED_FAILURE);
+
+		wpa_msg(wpa_s, MSG_INFO, WPA_EVENT_AUTH_REJECT MACSTR
+			" auth_alg=%u auth_transaction=%u status_code=%u",
+			MAC2STR(header->sa), header->u.auth.auth_alg,
+			header->u.auth.auth_transaction, header->u.auth.status_code);
+
+		if (wpa_s->auth_alg == WPA_AUTH_ALG_FILS ||
+		    wpa_s->auth_alg == WPA_AUTH_ALG_FILS_SK_PFS)
+			fils_connection_failure(wpa_s);
+
+		if (header->u.auth.status_code !=
+		    WLAN_STATUS_NOT_SUPPORTED_AUTH_ALG ||
+		    wpa_s->auth_alg == header->u.auth.auth_alg||
+		    wpa_s->current_ssid->auth_alg == WPA_AUTH_ALG_LEAP) {
+			wpas_connection_failed(wpa_s, wpa_s->pending_bssid);
+			wpa_supplicant_set_state(wpa_s, WPA_DISCONNECTED);
+			return;
+		}
+
+		wpas_connect_work_done(wpa_s);
+	}
+
+	if (le_to_host16(header->u.auth.auth_alg) == WLAN_AUTH_FILS_SK ||
+	    le_to_host16(header->u.auth.auth_alg) == WLAN_AUTH_FILS_SK_PFS ||
+	    le_to_host16(header->u.auth.auth_alg) == WLAN_AUTH_FILS_PK) {
+
+		if (fils_process_auth(wpa_s->wpa, header->bssid,
+		    header->u.auth.variable, len - (IEEE80211_HDRLEN + 6)) < 0) {
+			sme_send_external_auth_status(wpa_s, WLAN_STATUS_UNSPECIFIED_FAILURE);
+		} else {
+
+			buf = sme_assoc_build_external_fils(wpa_s, wpa_s->current_ssid->mode, header->bssid,
+							    header->u.auth.auth_alg);
+
+			sme_external_send_fils_kek_key_auth_sta(wpa_s, buf);
+
+			//This needs to be sent after sending the KEK and Fils element
+
+			if (le_to_host16(header->u.auth.status_code) == WLAN_STATUS_SUCCESS)
+				sme_send_external_auth_status(wpa_s, WLAN_STATUS_SUCCESS);
+		}
+	}
+}
+
+#endif
 
 #ifdef CONFIG_SAE
 
@@ -1420,24 +1633,6 @@ static int sme_external_auth_send_sae_commit(struct wpa_supplicant *wpa_s,
 	return 0;
 }
 
-
-static void sme_send_external_auth_status(struct wpa_supplicant *wpa_s,
-					  u16 status)
-{
-	struct external_auth params;
-
-	wpa_s->sme.ext_auth_wpa_ssid = NULL;
-	os_memset(&params, 0, sizeof(params));
-	params.status = status;
-	params.ssid = wpa_s->sme.ext_auth_ssid;
-	params.ssid_len = wpa_s->sme.ext_auth_ssid_len;
-	params.bssid = wpa_s->sme.ext_auth_bssid;
-	if (wpa_s->conf->sae_pmkid_in_assoc && status == WLAN_STATUS_SUCCESS)
-		params.pmkid = wpa_s->sme.sae.pmkid;
-	wpa_drv_send_external_auth_status(wpa_s, &params);
-}
-
-
 static int sme_handle_external_auth_start(struct wpa_supplicant *wpa_s,
 					  union wpa_event_data *data)
 {
@@ -1534,6 +1729,28 @@ static bool is_sae_key_mgmt_suite(struct wpa_supplicant *wpa_s, u32 suite)
 void sme_external_auth_trigger(struct wpa_supplicant *wpa_s,
 			       union wpa_event_data *data)
 {
+	if (RSN_SELECTOR_GET(&data->external_auth.key_mgmt_suite) ==
+	    RSN_AUTH_KEY_MGMT_FILS_SHA256 ||
+	    RSN_SELECTOR_GET(&data->external_auth.key_mgmt_suite) ==
+	    RSN_AUTH_KEY_MGMT_FILS_SHA384 ||
+	    RSN_SELECTOR_GET(&data->external_auth.key_mgmt_suite) ==
+	    RSN_AUTH_KEY_MGMT_FT_FILS_SHA256  ||
+	    RSN_SELECTOR_GET(&data->external_auth.key_mgmt_suite) ==
+	    RSN_AUTH_KEY_MGMT_FT_FILS_SHA384) {
+		if (data->external_auth.action == EXT_AUTH_START) {
+			os_memcpy(wpa_s->sme.ext_auth_bssid, data->external_auth.bssid, ETH_ALEN);
+			os_memcpy(wpa_s->sme.ext_auth_ssid, data->external_auth.ssid,
+				  data->external_auth.ssid_len);
+			wpa_s->sme.ext_auth_ssid_len = data->external_auth.ssid_len;
+			sme_external_auth_send_fils(wpa_s, data->external_auth.bssid,
+						    data->external_auth.ssid);
+			return;
+		} else if (data->external_auth.action == EXT_AUTH_ABORT) {
+			/* Report failure to driver for the wrong trigger */
+			sme_send_external_auth_status(wpa_s,
+						      WLAN_STATUS_UNSPECIFIED_FAILURE);
+		}
+	}
 	if (!is_sae_key_mgmt_suite(wpa_s, data->external_auth.key_mgmt_suite))
 		return;
 
diff --git a/wpa_supplicant/sme.h b/wpa_supplicant/sme.h
index c797d2e9e..680ffa088 100644
--- a/wpa_supplicant/sme.h
+++ b/wpa_supplicant/sme.h
@@ -43,6 +43,8 @@ void sme_external_auth_trigger(struct wpa_supplicant *wpa_s,
 			       union wpa_event_data *data);
 void sme_external_auth_mgmt_rx(struct wpa_supplicant *wpa_s,
 			       const u8 *auth_frame, size_t len);
+void sme_external_auth_mgmt_rx_fils(struct wpa_supplicant *wpa_s,
+				    const u8 *auth_frame, size_t len);
 
 #else /* CONFIG_SME */
 
@@ -131,6 +133,10 @@ static inline void sme_external_auth_mgmt_rx(struct wpa_supplicant *wpa_s,
 					     const u8 *auth_frame, size_t len)
 {
 }
+static inline void sme_external_auth_mgmt_rx_fils(struct wpa_supplicant *wpa_s,
+						  const u8 *auth_frame, size_t len)
+{
+}
 
 #endif /* CONFIG_SME */
 
diff --git a/wpa_supplicant/wpa_supplicant.c b/wpa_supplicant/wpa_supplicant.c
index 909a4bcfe..320eb3ecc 100644
--- a/wpa_supplicant/wpa_supplicant.c
+++ b/wpa_supplicant/wpa_supplicant.c
@@ -3156,7 +3156,8 @@ int wpa_is_fils_supported(struct wpa_supplicant *wpa_s)
 	return (((wpa_s->drv_flags & WPA_DRIVER_FLAGS_SME) &&
 		 (wpa_s->drv_flags & WPA_DRIVER_FLAGS_SUPPORT_FILS)) ||
 		(!(wpa_s->drv_flags & WPA_DRIVER_FLAGS_SME) &&
-		 (wpa_s->drv_flags & WPA_DRIVER_FLAGS_FILS_SK_OFFLOAD)));
+		 (wpa_s->drv_flags & WPA_DRIVER_FLAGS_FILS_SK_OFFLOAD ||
+		 wpa_s->drv_flags2 & WPA_DRIVER_FLAGS_FILS_EXTERNAL_AUTH)));
 }
 
 
@@ -3368,7 +3369,8 @@ static u8 * wpas_populate_assoc_ies(
 	/* Clear FILS association */
 	wpa_sm_set_reset_fils_completed(wpa_s->wpa, 0);
 
-	if ((wpa_s->drv_flags & WPA_DRIVER_FLAGS_FILS_SK_OFFLOAD) &&
+	if ((wpa_s->drv_flags & WPA_DRIVER_FLAGS_FILS_SK_OFFLOAD||
+	    wpa_s->drv_flags2 & WPA_DRIVER_FLAGS_FILS_EXTERNAL_AUTH) &&
 	    ssid->eap.erp && wpa_key_mgmt_fils(wpa_s->key_mgmt) &&
 	    eapol_sm_get_erp_info(wpa_s->eapol, &ssid->eap, &username,
 				  &username_len, &realm, &realm_len,
@@ -3387,7 +3389,8 @@ static u8 * wpas_populate_assoc_ies(
 
 		if (mask)
 			*mask |= WPA_DRV_UPDATE_FILS_ERP_INFO;
-	} else if ((wpa_s->drv_flags & WPA_DRIVER_FLAGS_FILS_SK_OFFLOAD) &&
+	} else if ((wpa_s->drv_flags & WPA_DRIVER_FLAGS_FILS_SK_OFFLOAD ||
+		   wpa_s->drv_flags2 & WPA_DRIVER_FLAGS_FILS_EXTERNAL_AUTH) &&
 		   ssid->eap.erp && wpa_key_mgmt_fils(wpa_s->key_mgmt) &&
 		   pmksa_cached) {
 		algs = WPA_AUTH_ALG_FILS;
-- 
2.34.1

