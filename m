Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01646745FB
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jan 2023 23:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjASWak (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 17:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjASW3X (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 17:29:23 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5DAC3810
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 14:13:34 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JM9SQa002764;
        Thu, 19 Jan 2023 22:13:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=/+kXlJEBEGsKzierd9cx4l3mAFpozbasaNCZJ5K4C0k=;
 b=KPCH1rNleDQcOjyK9/nhEf9r9FG5+zKkp9zSXWDBav55QTZQctP1awVUxN+HXyY+5mJc
 J3HNu5LAogmuRpmRK9sE20LrvPVZsgAVz3SDDFsl481GntOVq9rWVjrAyab0lwWJN2Wk
 ATYk+CNWCNfspGQzNRC4qref95kX/kVLa1pUsr5CAMpCjxWJYhXgN9jm3RyntGRcA7UF
 XNpPzDKygyUA7bdGX0aAoRv/UoG4CshLbEHSMOvULPjqnBCR0/Aigm8bzI47K6UAZVnm
 2dVRPqqyFC4iHe+zBMwj6PQEvgi05GhnW2i7+g73nr7IKyioCRtfo1MmV9ZwbXaXuX03 tw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n6vjbjndr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 22:13:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30JMDVue017783
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 22:13:31 GMT
Received: from srirrama-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 19 Jan 2023 14:13:29 -0800
From:   Sriram R <quic_srirrama@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Sriram R <quic_srirrama@quicinc.com>
Subject: [PATCH v2] wifi: mac80211: validate link status before deciding on mgmt tx
Date:   Fri, 20 Jan 2023 03:43:06 +0530
Message-ID: <20230119221306.24526-1-quic_srirrama@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Or5EAhEkaOgleS4DT6g6KYiIxwA-VoAk
X-Proofpoint-GUID: Or5EAhEkaOgleS4DT6g6KYiIxwA-VoAk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_14,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190187
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently we check the status of bss active flag to see if the
AP is active. But in case of a MLD AP, when some of the links
are getting teardown and some are active, mgmt Tx(like deauth)
can be sent on some links before they are brought down as well.

In such cases, the bss active flag might not provide the exact
status of the MLD links, which becomes false on first link deleted.
Hence check if any of the links can be used for mgmt tx
before returning error status.

Also, use the link id passed from userspace when the link bss
address matches the mgmt SA and the chan params match the request.
This will avoid scenario where the link id from userspace
gets reset.

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
---
v2: added wifi prefix in commit title
 net/mac80211/offchannel.c | 50 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
index d78c82d6b696..5e312860a976 100644
--- a/net/mac80211/offchannel.c
+++ b/net/mac80211/offchannel.c
@@ -763,6 +763,43 @@ int ieee80211_cancel_remain_on_channel(struct wiphy *wiphy,
 	return ieee80211_cancel_roc(local, cookie, false);
 }
 
+static bool ieee80211_is_link_bss_active(struct ieee80211_sub_if_data *sdata,
+					 int link_id)
+{
+	struct ieee80211_link_data *link;
+
+	if (!sdata->bss)
+		return false;
+
+	/* This is consolidated status of the MLD or non ML bss */
+	if (sdata->bss->active)
+		return true;
+
+	if (link_id < 0)
+		return false;
+
+	if (!sdata->vif.valid_links)
+		return false;
+
+	if (!(sdata->vif.valid_links & BIT(link_id)))
+		return false;
+
+	sdata_lock(sdata);
+	link = sdata_dereference(sdata->link[link_id], sdata);
+	if (!link) {
+		sdata_unlock(sdata);
+		return false;
+	}
+
+	if (sdata_dereference(link->u.ap.beacon, sdata)) {
+		sdata_unlock(sdata);
+		return true;
+	}
+
+	sdata_unlock(sdata);
+	return false;
+}
+
 int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 		      struct cfg80211_mgmt_tx_params *params, u64 *cookie)
 {
@@ -804,7 +841,7 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 	case NL80211_IFTYPE_P2P_GO:
 		if (sdata->vif.type != NL80211_IFTYPE_ADHOC &&
 		    !ieee80211_vif_is_mesh(&sdata->vif) &&
-		    !sdata->bss->active)
+		    !ieee80211_is_link_bss_active(sdata, params->link_id))
 			need_offchan = true;
 
 		rcu_read_lock();
@@ -883,8 +920,17 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 				break;
 			}
 
-			if (ether_addr_equal(conf->addr, mgmt->sa))
+			if (ether_addr_equal(conf->addr, mgmt->sa)) {
+				/* If userspace requested Tx on a specific link
+				 * use the same link id if the link bss is matching
+				 * the requested chan.
+				 */
+				if (sdata->vif.valid_links &&
+				    params->link_id >= 0 && params->link_id == i &&
+				    params->chan == chanctx_conf->def.chan)
+					link_id = i;
 				break;
+			}
 
 			chanctx_conf = NULL;
 		}
-- 
2.17.1

