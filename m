Return-Path: <linux-wireless+bounces-15539-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6B49D4688
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 05:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52A0DB2238F
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 04:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7EE6CDAF;
	Thu, 21 Nov 2024 04:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iUDRcBzC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4055B80027;
	Thu, 21 Nov 2024 04:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732162564; cv=none; b=Og1vl3xkLNfHMn4+JUCuC8ADOGgtNaFKLr+xonLJLroLTFnQtX39s0C6cEIEqHMJ0UOn8+PvPdaubhUp8OVGYQ3xZ9bnwr09g39INHHqBk+a3ol28o7LUmSG6oCNRCGT2Zm1rcxmYu0DjhtfTVPsV3eLtLUSwYsl6PYyeDW4Ojc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732162564; c=relaxed/simple;
	bh=ufaqCgMUfr0dpZ6LZVRRdGKZcb523eDuCrZNiQDcIBE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=GJdR1/v2eCffraLi7/i9W/BOSqOM+Rd5M22wItzbbMVbDfQD4tLBSYwNELspipd0SX+vhszAmJMFrZ2oZpboxTjdFzclXYFl4h92f4XX1QpwJsTF66xIqrVdP7R6Wej/3z7P6U2h99lLSebjeRKSFDc8LXSaIJpdPMTtMCDGwkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iUDRcBzC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKJEXSI003948;
	Thu, 21 Nov 2024 04:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ZJf9Qhs8+ccuGfiE346i9Z
	Q7rv15xtnbHQXyVgIw0L8=; b=iUDRcBzCpCk13EotFbkoW7QIZpeDdZIza5tUb+
	KxkrAGfYUC+QMTw4y+sCze7HxckuCOOeJhetMTcZ5Iu7Gp+XPEGXmKiZkZNOMgRP
	8viaKMytVafZLMUeHJjdGczZ1Og1SOQAnicwXLOCgSAxpyv+0w2RCBo/BtYPM9dG
	WceItq5uPSIJKsBmgGdiAhJ7OCQUyQF15xfJSMGaJqcqINd5S2jyiZcrtxHyOx5O
	NG1RjNNRukvE4leV10Q8Oj7pyxHMQLqLV2jqgMJ3675QBAQqypHel2FYWO8ujEFA
	R7OpcfBC9v1I3x122lROtge+AYmFRJ9vKUB60PQIX2k41aUQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 431ce3ap4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 04:15:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AL4Ft2W002854
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 04:15:55 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 20 Nov 2024 20:15:53 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Date: Thu, 21 Nov 2024 09:45:30 +0530
Subject: [PATCH v2] wifi: cfg80211: clear link ID from bitmap during link
 delete after clean up
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241121-mlo_dfs_fix-v2-1-92c3bf7ab551@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAOGzPmcC/22MQQrCMBAAv1L2bCSbhBQ9+Q8pxaZbu2ATTTQoJ
 X839uxxBmZWSBSZEhybFSJlThx8BbVrwM0XfyXBY2VQUhlE1GK5hX6cUj/xWyAqLa1EeRgc1OI
 eqertdu4qz5yeIX62ecaf/f/JKFCQ0cq22mrTDqfHix17t3dhga6U8gUJYSnhqAAAAA==
X-Change-ID: 20241113-mlo_dfs_fix-1123060109bc
To: Johannes Berg <johannes@sipsolutions.net>
CC: Aditya Kumar Singh <quic_adisi@quicinc.com>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: diL7LLVcMdiZUbmxgGapio-QiPBAFOG2
X-Proofpoint-ORIG-GUID: diL7LLVcMdiZUbmxgGapio-QiPBAFOG2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 bulkscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=423
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411210030

Currently, during link deletion, the link ID is first removed from the
valid_links bitmap before performing any clean-up operations. However, some
functions require the link ID to remain in the valid_links bitmap. One
such example is cfg80211_cac_event(). The flow is -

nl80211_remove_link()
    cfg80211_remove_link()
        ieee80211_del_intf_link()
            ieee80211_vif_set_links()
                ieee80211_vif_update_links()
                    ieee80211_link_stop()
                        cfg80211_cac_event()

cfg80211_cac_event() requires link ID to be present but it is cleared
already in cfg80211_remove_link(). Ultimately, WARN_ON() is hit.

Therefore, clear the link ID from the bitmap only after completing the link
clean-up.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
Changes in v2:
- Handled link ID removal properly instead of removing the WARN_ON()
- Renamed subject accordingly.
- Link to v1: https://lore.kernel.org/r/20241113-mlo_dfs_fix-v1-1-e4326736347b@quicinc.com
---
 net/mac80211/cfg.c  | 8 +++++++-
 net/wireless/util.c | 3 +--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 61a824ec33da356a9d2c4c99a5507b340bbf909e..53dc76bde158b8ada4a504c793246b856c52c83a 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -5046,10 +5046,16 @@ static void ieee80211_del_intf_link(struct wiphy *wiphy,
 				    unsigned int link_id)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
+	u16 new_links = wdev->valid_links & ~BIT(link_id);
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
-	ieee80211_vif_set_links(sdata, wdev->valid_links, 0);
+	/* During the link teardown process, certain functions require the
+	 * link_id to remain in the valid_links bitmap. Therefore, instead
+	 * of removing the link_id from the bitmap, pass a masked value to
+	 * simulate as if link_id does not exist anymore.
+	 */
+	ieee80211_vif_set_links(sdata, new_links, 0);
 }
 
 static int
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 040d62051eb96ea52ba301f0767d2e4e4ba51e0b..65c8e47246b7c3889e9c2faf0c0b508c426ee513 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -2843,10 +2843,9 @@ void cfg80211_remove_link(struct wireless_dev *wdev, unsigned int link_id)
 		break;
 	}
 
-	wdev->valid_links &= ~BIT(link_id);
-
 	rdev_del_intf_link(rdev, wdev, link_id);
 
+	wdev->valid_links &= ~BIT(link_id);
 	eth_zero_addr(wdev->links[link_id].addr);
 }
 

---
base-commit: dfc14664794a4706e0c2186a0c082386e6b14c4d
change-id: 20241113-mlo_dfs_fix-1123060109bc


