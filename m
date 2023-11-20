Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E545B7F0BD1
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Nov 2023 07:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjKTGXW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Nov 2023 01:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKTGXV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Nov 2023 01:23:21 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C45BDB
        for <linux-wireless@vger.kernel.org>; Sun, 19 Nov 2023 22:23:17 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AK52cGQ018983;
        Mon, 20 Nov 2023 06:23:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=ZZmDfo2cixmlw30akZ0EuRNmmu3NoDZLVRi03HacEK8=;
 b=h19D4HarwtQegS6U6uZo7jP/QbhCe1dhSUBO+omupjW54vqunp+9S+Y47UX+JcO2XSDV
 Ur+0YREgC75iFTaV7E5Hcvt3n0t3DYj6ZMtD7FV9W54R2CykQOiESTmIInEvKrEO6HmW
 cW3fIQSVXhNq/zaHo0XMTzws5eY/4UnntSE7ek4JvhwoExux+u99jrTK04si9TC5Rgeq
 RZSvTFgzqZ1WESzNIa4WVOQU6PvXeWVVuFaaCuRBVfpZ3oT3g3CUMt6OGcnKqb9uzaCi
 Bge5CxZ2ABMzr92K0/7U4+wGzj/SmvDQxcX6bdbvcIEmKmxv+3Yhs3ic8bsldu3WcxDG qA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uepjhk1d9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 06:23:13 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AK6NCaQ006186
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 06:23:12 GMT
Received: from hu-akhera-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 19 Nov 2023 22:23:10 -0800
From:   Anuj Khera <quic_akhera@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <quic_akhera@quicinc.com>
Subject: [PATCH] wifi: cfg80211: Rename bssid to peer_addr in cfg80211_pmksa
Date:   Mon, 20 Nov 2023 11:52:52 +0530
Message-ID: <20231120062252.7818-1-quic_akhera@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: H9E-RVyBQY3kRsWTMCQKUCw4_KVPuGVD
X-Proofpoint-GUID: H9E-RVyBQY3kRsWTMCQKUCw4_KVPuGVD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_03,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311200039
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The cfg80211_pmksa structure uses bssid member to store
the PMKSA for a BSS in Station mode. Change the name of
structure member bssid to peer_addr so that same member
can be used to store the PMKSA for a station in AP mode
using station MAC address.

Signed-off-by: Anuj Khera <quic_akhera@quicinc.com>
---
 drivers/net/wireless/ath/ath6kl/cfg80211.c           |  8 ++++----
 .../wireless/broadcom/brcm80211/brcmfmac/cfg80211.c  | 12 ++++++------
 drivers/net/wireless/microchip/wilc1000/cfg80211.c   | 10 +++++-----
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c    |  8 ++++----
 include/net/cfg80211.h                               |  2 +-
 net/wireless/nl80211.c                               |  2 +-
 net/wireless/trace.h                                 |  2 +-
 net/wireless/wext-compat.c                           |  2 +-
 8 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/cfg80211.c b/drivers/net/wireless/ath/ath6kl/cfg80211.c
index e37db4af33de..853f0e55e828 100644
--- a/drivers/net/wireless/ath/ath6kl/cfg80211.c
+++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
@@ -1877,8 +1877,8 @@ static int ath6kl_set_pmksa(struct wiphy *wiphy, struct net_device *netdev,
 	struct ath6kl *ar = ath6kl_priv(netdev);
 	struct ath6kl_vif *vif = netdev_priv(netdev);
 
-	return ath6kl_wmi_setpmkid_cmd(ar->wmi, vif->fw_vif_idx, pmksa->bssid,
-				       pmksa->pmkid, true);
+	return ath6kl_wmi_setpmkid_cmd(ar->wmi, vif->fw_vif_idx,
+				       pmksa->peer_addr, pmksa->pmkid, true);
 }
 
 static int ath6kl_del_pmksa(struct wiphy *wiphy, struct net_device *netdev,
@@ -1887,8 +1887,8 @@ static int ath6kl_del_pmksa(struct wiphy *wiphy, struct net_device *netdev,
 	struct ath6kl *ar = ath6kl_priv(netdev);
 	struct ath6kl_vif *vif = netdev_priv(netdev);
 
-	return ath6kl_wmi_setpmkid_cmd(ar->wmi, vif->fw_vif_idx, pmksa->bssid,
-				       pmksa->pmkid, false);
+	return ath6kl_wmi_setpmkid_cmd(ar->wmi, vif->fw_vif_idx,
+				       pmksa->peer_addr, pmksa->pmkid, false);
 }
 
 static int ath6kl_flush_pmksa(struct wiphy *wiphy, struct net_device *netdev)
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 133c5ea6429c..e00a2b858945 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -4329,7 +4329,7 @@ brcmf_pmksa_v3_op(struct brcmf_if *ifp, struct cfg80211_pmksa *pmksa,
 		/* Single PMK operation */
 		pmk_op->count = cpu_to_le16(1);
 		length += sizeof(struct brcmf_pmksa_v3);
-		memcpy(pmk_op->pmk[0].bssid, pmksa->bssid, ETH_ALEN);
+		memcpy(pmk_op->pmk[0].bssid, pmksa->peer_addr, ETH_ALEN);
 		memcpy(pmk_op->pmk[0].pmkid, pmksa->pmkid, WLAN_PMKID_LEN);
 		pmk_op->pmk[0].pmkid_len = WLAN_PMKID_LEN;
 		pmk_op->pmk[0].time_left = cpu_to_le32(alive ? BRCMF_PMKSA_NO_EXPIRY : 0);
@@ -4375,7 +4375,7 @@ brcmf_cfg80211_set_pmksa(struct wiphy *wiphy, struct net_device *ndev,
 	if (!check_vif_up(ifp->vif))
 		return -EIO;
 
-	brcmf_dbg(CONN, "set_pmksa - PMK bssid: %pM =\n", pmksa->bssid);
+	brcmf_dbg(CONN, "set_pmksa - PMK bssid: %pM =\n", pmksa->peer_addr);
 	brcmf_dbg(CONN, "%*ph\n", WLAN_PMKID_LEN, pmksa->pmkid);
 
 	if (brcmf_feat_is_enabled(ifp, BRCMF_FEAT_PMKID_V3))
@@ -4385,10 +4385,10 @@ brcmf_cfg80211_set_pmksa(struct wiphy *wiphy, struct net_device *ndev,
 
 	npmk = le32_to_cpu(cfg->pmk_list.npmk);
 	for (i = 0; i < npmk; i++)
-		if (!memcmp(pmksa->bssid, pmk[i].bssid, ETH_ALEN))
+		if (!memcmp(pmksa->peer_addr, pmk[i].bssid, ETH_ALEN))
 			break;
 	if (i < BRCMF_MAXPMKID) {
-		memcpy(pmk[i].bssid, pmksa->bssid, ETH_ALEN);
+		memcpy(pmk[i].bssid, pmksa->peer_addr, ETH_ALEN);
 		memcpy(pmk[i].pmkid, pmksa->pmkid, WLAN_PMKID_LEN);
 		if (i == npmk) {
 			npmk++;
@@ -4420,7 +4420,7 @@ brcmf_cfg80211_del_pmksa(struct wiphy *wiphy, struct net_device *ndev,
 	if (!check_vif_up(ifp->vif))
 		return -EIO;
 
-	brcmf_dbg(CONN, "del_pmksa - PMK bssid = %pM\n", pmksa->bssid);
+	brcmf_dbg(CONN, "del_pmksa - PMK bssid = %pM\n", pmksa->peer_addr);
 
 	if (brcmf_feat_is_enabled(ifp, BRCMF_FEAT_PMKID_V3))
 		return brcmf_pmksa_v3_op(ifp, pmksa, false);
@@ -4429,7 +4429,7 @@ brcmf_cfg80211_del_pmksa(struct wiphy *wiphy, struct net_device *ndev,
 
 	npmk = le32_to_cpu(cfg->pmk_list.npmk);
 	for (i = 0; i < npmk; i++)
-		if (!memcmp(pmksa->bssid, pmk[i].bssid, ETH_ALEN))
+		if (!memcmp(pmksa->peer_addr, pmk[i].bssid, ETH_ALEN))
 			break;
 
 	if ((npmk > 0) && (i < npmk)) {
diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index ad2509d8c99a..a2630506a619 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -877,14 +877,14 @@ static int set_pmksa(struct wiphy *wiphy, struct net_device *netdev,
 	u8 flag = 0;
 
 	for (i = 0; i < priv->pmkid_list.numpmkid; i++)	{
-		if (!memcmp(pmksa->bssid, priv->pmkid_list.pmkidlist[i].bssid,
-			    ETH_ALEN)) {
+		if (!memcmp(pmksa->peer_addr,
+			    priv->pmkid_list.pmkidlist[i].bssid, ETH_ALEN)) {
 			flag = PMKID_FOUND;
 			break;
 		}
 	}
 	if (i < WILC_MAX_NUM_PMKIDS) {
-		memcpy(priv->pmkid_list.pmkidlist[i].bssid, pmksa->bssid,
+		memcpy(priv->pmkid_list.pmkidlist[i].bssid, pmksa->peer_addr,
 		       ETH_ALEN);
 		memcpy(priv->pmkid_list.pmkidlist[i].pmkid, pmksa->pmkid,
 		       WLAN_PMKID_LEN);
@@ -909,8 +909,8 @@ static int del_pmksa(struct wiphy *wiphy, struct net_device *netdev,
 	struct wilc_priv *priv = &vif->priv;
 
 	for (i = 0; i < priv->pmkid_list.numpmkid; i++)	{
-		if (!memcmp(pmksa->bssid, priv->pmkid_list.pmkidlist[i].bssid,
-			    ETH_ALEN)) {
+		if (!memcmp(pmksa->peer_addr,
+			    priv->pmkid_list.pmkidlist[i].bssid, ETH_ALEN)) {
 			memset(&priv->pmkid_list.pmkidlist[i], 0,
 			       sizeof(struct wilc_pmkid));
 			break;
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 1ff763c10064..4dd78dd05955 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -1851,14 +1851,14 @@ static int cfg80211_rtw_set_pmksa(struct wiphy *wiphy,
 	struct adapter *padapter = rtw_netdev_priv(ndev);
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
 
-	if (is_zero_ether_addr((u8 *)pmksa->bssid))
+	if (is_zero_ether_addr((u8 *)pmksa->peer_addr))
 		return -EINVAL;
 
 	blInserted = false;
 
 	/* overwrite PMKID */
 	for (index = 0 ; index < NUM_PMKID_CACHE; index++) {
-		if (!memcmp(psecuritypriv->PMKIDList[index].Bssid, (u8 *)pmksa->bssid, ETH_ALEN)) {
+		if (!memcmp(psecuritypriv->PMKIDList[index].Bssid, (u8 *)pmksa->peer_addr, ETH_ALEN)) {
 			memcpy(psecuritypriv->PMKIDList[index].PMKID, (u8 *)pmksa->pmkid, WLAN_PMKID_LEN);
 			psecuritypriv->PMKIDList[index].bUsed = true;
 			psecuritypriv->PMKIDIndex = index + 1;
@@ -1868,7 +1868,7 @@ static int cfg80211_rtw_set_pmksa(struct wiphy *wiphy,
 	}
 
 	if (!blInserted) {
-		memcpy(psecuritypriv->PMKIDList[psecuritypriv->PMKIDIndex].Bssid, (u8 *)pmksa->bssid, ETH_ALEN);
+		memcpy(psecuritypriv->PMKIDList[psecuritypriv->PMKIDIndex].Bssid, (u8 *)pmksa->peer_addr, ETH_ALEN);
 		memcpy(psecuritypriv->PMKIDList[psecuritypriv->PMKIDIndex].PMKID, (u8 *)pmksa->pmkid, WLAN_PMKID_LEN);
 
 		psecuritypriv->PMKIDList[psecuritypriv->PMKIDIndex].bUsed = true;
@@ -1889,7 +1889,7 @@ static int cfg80211_rtw_del_pmksa(struct wiphy *wiphy,
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
 
 	for (index = 0 ; index < NUM_PMKID_CACHE; index++) {
-		if (!memcmp(psecuritypriv->PMKIDList[index].Bssid, (u8 *)pmksa->bssid, ETH_ALEN)) {
+		if (!memcmp(psecuritypriv->PMKIDList[index].Bssid, (u8 *)pmksa->peer_addr, ETH_ALEN)) {
 			/*
 			 * BSSID is matched, the same AP => Remove this PMKID information
 			 * and reset it.
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index b137a33a1b68..0bacd705c030 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3370,7 +3370,7 @@ enum wiphy_params_flags {
  *	threshold to generate a new PMK before the current one expires.
  */
 struct cfg80211_pmksa {
-	const u8 *bssid;
+	const u8 *peer_addr;
 	const u8 *pmkid;
 	const u8 *pmk;
 	size_t pmk_len;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 569234bc2be6..e4659c204102 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -12189,7 +12189,7 @@ static int nl80211_setdel_pmksa(struct sk_buff *skb, struct genl_info *info)
 	pmksa.pmkid = nla_data(info->attrs[NL80211_ATTR_PMKID]);
 
 	if (info->attrs[NL80211_ATTR_MAC]) {
-		pmksa.bssid = nla_data(info->attrs[NL80211_ATTR_MAC]);
+		pmksa.peer_addr = nla_data(info->attrs[NL80211_ATTR_MAC]);
 	} else if (info->attrs[NL80211_ATTR_SSID] &&
 		   info->attrs[NL80211_ATTR_FILS_CACHE_ID] &&
 		   (info->genlhdr->cmd == NL80211_CMD_DEL_PMKSA ||
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 30cd1bd58aac..8bc6e7dc70e7 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -1925,7 +1925,7 @@ DECLARE_EVENT_CLASS(rdev_pmksa,
 	TP_fast_assign(
 		WIPHY_ASSIGN;
 		NETDEV_ASSIGN;
-		MAC_ASSIGN(bssid, pmksa->bssid);
+		MAC_ASSIGN(bssid, pmksa->peer_addr);
 	),
 	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", bssid: %pM",
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->bssid)
diff --git a/net/wireless/wext-compat.c b/net/wireless/wext-compat.c
index 2371069f3c43..ee7d9066485f 100644
--- a/net/wireless/wext-compat.c
+++ b/net/wireless/wext-compat.c
@@ -1544,7 +1544,7 @@ static int cfg80211_wext_siwpmksa(struct net_device *dev,
 	if (wdev->iftype != NL80211_IFTYPE_STATION)
 		return -EINVAL;
 
-	cfg_pmksa.bssid = pmksa->bssid.sa_data;
+	cfg_pmksa.peer_addr = pmksa->bssid.sa_data;
 	cfg_pmksa.pmkid = pmksa->pmkid;
 
 	wiphy_lock(&rdev->wiphy);
-- 
2.17.1

