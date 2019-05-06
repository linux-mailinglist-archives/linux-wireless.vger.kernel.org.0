Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF3F14A49
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2019 14:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfEFMy1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 May 2019 08:54:27 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:48096 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfEFMy1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 May 2019 08:54:27 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x46CiOL0157962;
        Mon, 6 May 2019 12:54:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=+QirhigEffLdcMVAjibEhy8hlxrWaK2VezDFWTYfl9o=;
 b=dOBcNcXyMVl4RNOr43UgQ1umiEbL0MtwvJiemCRcVFRT6FxAhIn/KgENLHFj9kaIUIY+
 BjD7LIojVANf1Qd+xuJgJc7WW+TgPebQFnMqb950LtAgPfiUz5tSnlTWsr2q+kNp68hJ
 uOUGpUKrqqewbuJ5UC+tUl7t7ZiCOsSh6rJTx0Jbq0tXHksFQutXXF53lhrt228duKFr
 pPhZcC01w3+O3nJjMVp+gTDt2KqWdLGegs+Cvrj45mBct6V5jOMlMcYDK0C1OjV6shuQ
 tEE+s6/mWnG/kg/tegzVIXrG4WN5GrxBfTPPtiLL2ioyNBi/oAZ7pTxTUzOzIMxHt41D 7A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2s94b5p9jv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 May 2019 12:54:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x46Cr1YJ140473;
        Mon, 6 May 2019 12:54:22 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2s9aye9q4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 May 2019 12:54:22 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x46CsKwR009565;
        Mon, 6 May 2019 12:54:20 GMT
Received: from mwanda (/105.52.123.240)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 May 2019 05:54:20 -0700
Date:   Mon, 6 May 2019 15:54:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Naftali Goldstein <naftali.goldstein@intel.com>,
        Sara Sharon <sara.sharon@intel.com>,
        Shaul Triebitz <shaul.triebitz@intel.com>,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Liad Kaufman <liad.kaufman@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] iwlwifi: remove some unnecessary NULL checks
Message-ID: <20190506125409.GC13799@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9248 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905060112
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9248 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905060112
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

These pointers are an offset into the "sta" struct.  They're assigned
like this:

	const struct ieee80211_sta_vht_cap *vht_cap = &sta->vht_cap;

They're not the first member of the struct (->supp_rates[] is first) so
they can't be NULL.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    | 23 +++++++++----------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index 659e21b2d4e7..b6fb670d249c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -101,7 +101,7 @@ static u8 rs_fw_sgi_cw_support(struct ieee80211_sta *sta)
 	struct ieee80211_sta_he_cap *he_cap = &sta->he_cap;
 	u8 supp = 0;
 
-	if (he_cap && he_cap->has_he)
+	if (he_cap->has_he)
 		return 0;
 
 	if (ht_cap->cap & IEEE80211_HT_CAP_SGI_20)
@@ -123,12 +123,12 @@ static u16 rs_fw_get_config_flags(struct iwl_mvm *mvm,
 	struct ieee80211_sta_ht_cap *ht_cap = &sta->ht_cap;
 	struct ieee80211_sta_vht_cap *vht_cap = &sta->vht_cap;
 	struct ieee80211_sta_he_cap *he_cap = &sta->he_cap;
-	bool vht_ena = vht_cap && vht_cap->vht_supported;
+	bool vht_ena = vht_cap->vht_supported;
 	u16 flags = 0;
 
 	if (mvm->cfg->ht_params->stbc &&
 	    (num_of_ant(iwl_mvm_get_valid_tx_ant(mvm)) > 1)) {
-		if (he_cap && he_cap->has_he) {
+		if (he_cap->has_he) {
 			if (he_cap->he_cap_elem.phy_cap_info[2] &
 			    IEEE80211_HE_PHY_CAP2_STBC_RX_UNDER_80MHZ)
 				flags |= IWL_TLC_MNG_CFG_FLAGS_STBC_MSK;
@@ -136,15 +136,14 @@ static u16 rs_fw_get_config_flags(struct iwl_mvm *mvm,
 			if (he_cap->he_cap_elem.phy_cap_info[7] &
 			    IEEE80211_HE_PHY_CAP7_STBC_RX_ABOVE_80MHZ)
 				flags |= IWL_TLC_MNG_CFG_FLAGS_HE_STBC_160MHZ_MSK;
-		} else if ((ht_cap &&
-			    (ht_cap->cap & IEEE80211_HT_CAP_RX_STBC)) ||
+		} else if ((ht_cap->cap & IEEE80211_HT_CAP_RX_STBC) ||
 			   (vht_ena &&
 			    (vht_cap->cap & IEEE80211_VHT_CAP_RXSTBC_MASK)))
 			flags |= IWL_TLC_MNG_CFG_FLAGS_STBC_MSK;
 	}
 
 	if (mvm->cfg->ht_params->ldpc &&
-	    ((ht_cap && (ht_cap->cap & IEEE80211_HT_CAP_LDPC_CODING)) ||
+	    ((ht_cap->cap & IEEE80211_HT_CAP_LDPC_CODING) ||
 	     (vht_ena && (vht_cap->cap & IEEE80211_VHT_CAP_RXLDPC))))
 		flags |= IWL_TLC_MNG_CFG_FLAGS_LDPC_MSK;
 
@@ -154,7 +153,7 @@ static u16 rs_fw_get_config_flags(struct iwl_mvm *mvm,
 	     IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD))
 		flags &= ~IWL_TLC_MNG_CFG_FLAGS_LDPC_MSK;
 
-	if (he_cap && he_cap->has_he &&
+	if (he_cap->has_he &&
 	    (he_cap->he_cap_elem.phy_cap_info[3] &
 	     IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_RX_MASK))
 		flags |= IWL_TLC_MNG_CFG_FLAGS_HE_DCM_NSS_1_MSK;
@@ -293,13 +292,13 @@ static void rs_fw_set_supp_rates(struct ieee80211_sta *sta,
 	cmd->mode = IWL_TLC_MNG_MODE_NON_HT;
 
 	/* HT/VHT rates */
-	if (he_cap && he_cap->has_he) {
+	if (he_cap->has_he) {
 		cmd->mode = IWL_TLC_MNG_MODE_HE;
 		rs_fw_he_set_enabled_rates(sta, sband, cmd);
-	} else if (vht_cap && vht_cap->vht_supported) {
+	} else if (vht_cap->vht_supported) {
 		cmd->mode = IWL_TLC_MNG_MODE_VHT;
 		rs_fw_vht_set_enabled_rates(sta, vht_cap, cmd);
-	} else if (ht_cap && ht_cap->ht_supported) {
+	} else if (ht_cap->ht_supported) {
 		cmd->mode = IWL_TLC_MNG_MODE_HT;
 		cmd->ht_rates[0][0] = cpu_to_le16(ht_cap->mcs.rx_mask[0]);
 		cmd->ht_rates[1][0] = cpu_to_le16(ht_cap->mcs.rx_mask[1]);
@@ -381,7 +380,7 @@ static u16 rs_fw_get_max_amsdu_len(struct ieee80211_sta *sta)
 	const struct ieee80211_sta_vht_cap *vht_cap = &sta->vht_cap;
 	const struct ieee80211_sta_ht_cap *ht_cap = &sta->ht_cap;
 
-	if (vht_cap && vht_cap->vht_supported) {
+	if (vht_cap->vht_supported) {
 		switch (vht_cap->cap & IEEE80211_VHT_CAP_MAX_MPDU_MASK) {
 		case IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454:
 			return IEEE80211_MAX_MPDU_LEN_VHT_11454;
@@ -391,7 +390,7 @@ static u16 rs_fw_get_max_amsdu_len(struct ieee80211_sta *sta)
 			return IEEE80211_MAX_MPDU_LEN_VHT_3895;
 	}
 
-	} else if (ht_cap && ht_cap->ht_supported) {
+	} else if (ht_cap->ht_supported) {
 		if (ht_cap->cap & IEEE80211_HT_CAP_MAX_AMSDU)
 			/*
 			 * agg is offloaded so we need to assume that agg
-- 
2.18.0

