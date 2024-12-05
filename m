Return-Path: <linux-wireless+bounces-15923-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 565C79E5373
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 12:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22D091625AB
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 11:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2601DB92E;
	Thu,  5 Dec 2024 11:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gCDvJaiB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6906FBA20;
	Thu,  5 Dec 2024 11:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733397182; cv=none; b=mVfEDWiDCuA7lJWSWPn3hUXN9UI6TWkJtkj8fef91D9YFud2dvSfg7Ul1LGOBZaXfCahUc4f49/V1cwh0byG2xiz7RgF/KXRmTL50qd8bN9CB8VoLlWm9sA55y3itT1+tkvgE2EGGizZTOQ7z9Al5CUSgrYvZ76etvawYMmwWxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733397182; c=relaxed/simple;
	bh=/c82GpciulD+V1NmC6rYM0xAptB9LFFqAWm4HBC3Xp4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=rV5Z1kP4K8oJCP/Z2OzxGVedUPKWhHgfUdnjnV5jTnbGBOBLCpZdYRsrIzPKXeXoJXBVhSJ2iqXCFhW3DjZQi5bhRsd6O+RtQ16NjQpe1vhIt2H67LoXivlMQQ/k4uTSztZMK4mawHl3LYwj9YQUqukhsBCoAZD4O2uIj221RmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gCDvJaiB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B57NIl2006403;
	Thu, 5 Dec 2024 11:12:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=pfBHUQ+1L4hZg9B3i+OA5e
	zZK2rdQcKq/CUY8D+zAt4=; b=gCDvJaiB27H0MsVj81ENg/N7+XnBz35jQ+73Bv
	JJOnVDfAGh8m3TZiZPuQCY8LfhKLTOVGFMhzb3aufsFLiHZAos042QEta4MiZQWX
	g1ch0RVnrZpE58I1t8viFcyZSpbQApTDiZ5Gscj6aZRQuqHs5yVl7/3sf2sOu/Df
	xtPSsirmfyer8vRfRqed87tYadue5NVnUFiSMcvJYu1BIjjNKSQf4dnDG2JLLZq1
	aQA4574lTX1RW7XzrVkwfQOYwdwFycVetx9yatfFEENDoFUVRuwy7NYDD5MTFTL8
	4Nw54AW7dCm4igAMj1Pku6meGHwUY4eZQi7T0ebxHTbqdkkw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 439w3eqb26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 11:12:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B5BCsbT018198
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Dec 2024 11:12:54 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 5 Dec 2024 03:12:52 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Date: Thu, 5 Dec 2024 16:42:39 +0530
Subject: [PATCH v2] wifi: mac80211: re-order unassigning channel in
 activate links
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241205-unassign_activate_links-v2-1-ba3f0a2bb4a4@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAKeKUWcC/4WNQQ6CMBBFr2JmbQ1tQKgr72EIGcoIE7VoBxoN4
 e5WLuDyveS/v4BQYBI47RYIFFl49AnMfgduQN+T4i4xmMzk2mSFmj2KcO8bdBNHnKi5s7+JOmJ
 R5lVhW2tLSOtnoCu/t/KlTjywTGP4bEdR/+z/ZtRKqyrPbIka247a82tmx94d3PiAel3XL9UId
 u3AAAAA
X-Change-ID: 20241205-unassign_activate_links-6a574859b997
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Aditya
 Kumar Singh" <quic_adisi@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Mw-k7KFfRlzJ1tn5Yn6nMvuX5ISpYNbu
X-Proofpoint-ORIG-GUID: Mw-k7KFfRlzJ1tn5Yn6nMvuX5ISpYNbu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 bulkscore=0 mlxscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412050080

The current flow in _ieee80211_set_active_links() during link removal
does not align with the operational requirements of drivers that groups
multiple hardware under a single wiphy. These drivers (e.g ath12k) rely on
channel information to determine the appropriate hardware for each link.

Now, during the link removal process, the channel is first unassigned from
the links via a call to __ieee80211_link_release_channel(). After this, the
state of all connected stations is updated via drv_change_sta_links().
This is followed by handling keys in the links, and finally, removing the
link by calling drv_change_vif_links().

For above mentioned drivers (such as ath12k), with the above flow, once the
channel is unassigned from the link, the link would be deleted at the
driver and firmware level. However, at this point, the station still exist,
leading to failures in deactivating the links.

Additionally, if we consider the link addition flow [1], channels are first
assigned, and then stations are created. So conversely, during removal,
ideally, the station should be removed first, and then the channel should
be unassigned.

Therefore, re-order the logic so that stations are handled first and then
channel is unassigned.

[1]: https://lore.kernel.org/linux-wireless/20241001085034.2745669-1-quic_adisi@quicinc.com/

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
Changes in v2:
- Changed function doc as well to reflect the correct flow.
- Link to v1: https://lore.kernel.org/r/20241205-unassign_activate_links-v1-1-84097a1abdeb@quicinc.com
---
 include/net/mac80211.h |  2 +-
 net/mac80211/link.c    | 44 ++++++++++++++++++++++----------------------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 5ce4dfa3fba55fd6c33e6261c340feea9e5031ed..6159dff1bdbc2e3e0ec40581efee66730eb7300d 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -7671,13 +7671,13 @@ static inline bool ieee80211_is_tx_data(struct sk_buff *skb)
  * a sequence of calls like
  *
  *  - change_vif_links(0x11)
- *  - unassign_vif_chanctx(link_id=0)
  *  - assign_vif_chanctx(link_id=4)
  *  - change_sta_links(0x11) for each affected STA (the AP)
  *    (TDLS connections on now inactive links should be torn down)
  *  - remove group keys on the old link (link_id 0)
  *  - add new group keys (GTK/IGTK/BIGTK) on the new link (link_id 4)
  *  - change_sta_links(0x10) for each affected STA (the AP)
+ *  - unassign_vif_chanctx(link_id=0)
  *  - change_vif_links(0x10)
  *
  * Return: 0 on success. An error code otherwise.
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 58a76bcd6ae68670fbbe7fa7d07540c04ff996f8..3c46d2b2ee254fab324d57f4d0fbe94ace76d89d 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -367,28 +367,6 @@ static int _ieee80211_set_active_links(struct ieee80211_sub_if_data *sdata,
 		}
 	}
 
-	for_each_set_bit(link_id, &rem, IEEE80211_MLD_MAX_NUM_LINKS) {
-		struct ieee80211_link_data *link;
-
-		link = sdata_dereference(sdata->link[link_id], sdata);
-
-		ieee80211_teardown_tdls_peers(link);
-
-		__ieee80211_link_release_channel(link, true);
-
-		/*
-		 * If CSA is (still) active while the link is deactivated,
-		 * just schedule the channel switch work for the time we
-		 * had previously calculated, and we'll take the process
-		 * from there.
-		 */
-		if (link->conf->csa_active)
-			wiphy_delayed_work_queue(local->hw.wiphy,
-						 &link->u.mgd.csa.switch_work,
-						 link->u.mgd.csa.time -
-						 jiffies);
-	}
-
 	for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
 		struct ieee80211_link_data *link;
 
@@ -458,6 +436,28 @@ static int _ieee80211_set_active_links(struct ieee80211_sub_if_data *sdata,
 		__ieee80211_sta_recalc_aggregates(sta, active_links);
 	}
 
+	for_each_set_bit(link_id, &rem, IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct ieee80211_link_data *link;
+
+		link = sdata_dereference(sdata->link[link_id], sdata);
+
+		ieee80211_teardown_tdls_peers(link);
+
+		__ieee80211_link_release_channel(link, true);
+
+		/*
+		 * If CSA is (still) active while the link is deactivated,
+		 * just schedule the channel switch work for the time we
+		 * had previously calculated, and we'll take the process
+		 * from there.
+		 */
+		if (link->conf->csa_active)
+			wiphy_delayed_work_queue(local->hw.wiphy,
+						 &link->u.mgd.csa.switch_work,
+						 link->u.mgd.csa.time -
+						 jiffies);
+	}
+
 	for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
 		struct ieee80211_link_data *link;
 

---
base-commit: b81e0211e9c70be9eb70924e4e29698bfbbbc03a
change-id: 20241205-unassign_activate_links-6a574859b997


