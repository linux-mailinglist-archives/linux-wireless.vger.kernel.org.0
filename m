Return-Path: <linux-wireless+bounces-24729-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C93AEFBC9
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 16:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEF0C17F77D
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 14:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83AF276056;
	Tue,  1 Jul 2025 14:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZOufW+0R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6BA275852
	for <linux-wireless@vger.kernel.org>; Tue,  1 Jul 2025 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751379214; cv=none; b=OlASD3vr+3osRx/08zjskr4l5ITYQVqHdTSlA365aKXINV9I5oUkn+Pkm2aAxJls/KYFOBZrOK4bRzxMXsJTMvqvVVcQYepbz2+4FHDLhSPQr6c8EBu6ZPXqWu5FNM3ec4x3edLZlZe2yE1xQ8JcjsGdcxjsmQlX2/PYqLNsWxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751379214; c=relaxed/simple;
	bh=HiHX14iCcN1lbPCFiWfiGrmqcKZzoGiFL3jWQ7IJGwM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=la8lA0EZBZNKd0zZ3vaYJ8zs9n1RyLCNNpUfBJO4Cege5UWT6l9hc4ZVrZx4DMNlGgnE83YBkKDWuzq0VL/yu22Lx+n09EzbCFsS4tFxPPasHcATrudBMBumuCUhyFaBruYdn3UhrV9siHkV6+QJ1FS/AwBbbK+Y0/Vh5OKx3nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZOufW+0R; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5619LEZb028664;
	Tue, 1 Jul 2025 14:13:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=QcYzD7jcQTpcS9W92rr9u9
	ZxsQ1SFgX3VN+KJGOQe+A=; b=ZOufW+0R8G8s0hi22Is+N+C5YUhpGxXcZ5Dnq/
	AdrwOr650N2HSnZfQs3O9KzmC+UBUcDSzT8xa7Bu5xsmII9kvYT21yHCExSUTFKV
	xL5UDQojsClRmTx9k1o2Cq9SN05rCzBmK8dCpmsPw7P3Mq/YqQ4ewgKPz5dg96/s
	3KbjCweB/a8Ruvxmj1MXDtQNgYg2bImt58fIeaU3O1rdv6SgUiPVNVe/jioU/Puq
	VUv7u2uZf/6AXF8pBOOiGmdvQoOhI7ZvDlALtzd1DrF6h71iM5Wg0qEKb07kVNUz
	YwrHoh0swBjnn9rcvERDqBjJEC41OYD4gr6kvsDzB86IXFgg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j7bvs45u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 14:13:27 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 561EDQwZ002417
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Jul 2025 14:13:26 GMT
Received: from hu-amitajit-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 1 Jul 2025 07:13:24 -0700
From: Amith A <quic_amitajit@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <quic_amitajit@quicinc.com>,
        "Aditya
 Kumar Singh" <aditya.kumar.singh@oss.qualcomm.com>
Subject: [PATCH wireless-next] wifi: cfg80211: fix off channel operation allowed check for MLO
Date: Tue, 1 Jul 2025 19:43:08 +0530
Message-ID: <20250701141308.733013-1-quic_amitajit@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pwRAURBDl_4JGsU0iopmSQByfN3pplps
X-Authority-Analysis: v=2.4 cv=RJCzH5i+ c=1 sm=1 tr=0 ts=6863ed07 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=mVBg5cK-9P9u6yz4axkA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: pwRAURBDl_4JGsU0iopmSQByfN3pplps
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA5MiBTYWx0ZWRfXw8QF/X9BvuHw
 wDW9N1yGBBRlC/A6x4RiH9bPiHf8IiRDHjJuVhLmH0hfDoqGhyBhjOZJ92j1pnCmntWTJwOV4VT
 SPnl2xsoId15I5Rfa5KS5VVOSEXWRTNQtWDXoLZ7AUK5USc+HS2IHJTJ2xbPMi+azZKFisRpEVY
 vx41iUdpOIKIqHImT6T9m8LVaUOfpG9nlRUzWmwckgCa98n7xT+o2sg8KL7r2eQH5PAs8HbB8ep
 Q1K3axPALKJGO7yfBgVXDN1XycUm+TWPJOxRAxsB/0zT0SwaI14UF9C1GqIFfe8JRuzXNhPFUqh
 DenZqPR9fG5RdEpbqAYmGYNn2icJYIyg1iKcGwHeYzkLQaKQrhsVMQPKemHtIoYYI2DsjOcLDHW
 pmf5NRWWZPM6aYYabctthzm50kBRZMlRtlvGlMv36VUP8m7NNfXiZPTk4pCbaP7gYg6AJUNE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0
 malwarescore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507010092

From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

In cfg80211_off_channel_oper_allowed(), the current logic disallows
off-channel operations if any link operates on a radar channel,
assuming such channels cannot be vacated. This assumption holds for
non-MLO interfaces but not for MLO.

With MLO and multi-radio devices, different links may operate on
separate radios. This allows one link to scan off-channel while
another remains on a radar channel. For example, in a 5 GHz
split-phy setup, the lower band can scan while the upper band
stays on a radar channel.

Off-channel operations can be allowed if the radio/link onto which the
input channel falls is different from the radio/link which has an active
radar channel. Therefore, fix cfg80211_off_channel_oper_allowed() by
returning false only if the requested channel maps to the same radio as
an active radar channel. Allow off-channel operations when the requested
channel is on a different radio, as in MLO with multi-radio setups.

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Signed-off-by: Amith A <quic_amitajit@quicinc.com>
---
 net/wireless/nl80211.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 70ca74a75f22..395794dba0a7 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -9758,6 +9758,7 @@ static bool cfg80211_off_channel_oper_allowed(struct wireless_dev *wdev,
 {
 	unsigned int link_id;
 	bool all_ok = true;
+	int radio_idx;
 
 	lockdep_assert_wiphy(wdev->wiphy);
 
@@ -9765,10 +9766,16 @@ static bool cfg80211_off_channel_oper_allowed(struct wireless_dev *wdev,
 		return false;
 
 	if (!cfg80211_beaconing_iface_active(wdev))
-		return true;
+		return all_ok;
+
+	if (wdev->valid_links) {
+		radio_idx = cfg80211_get_radio_idx_by_chan(wdev->wiphy, chan);
+		if (radio_idx < 0)
+			return !all_ok;
+	}
 
 	/*
-	 * FIXME: check if we have a free HW resource/link for chan
+	 * FIXME: check if we have a free radio/link for chan
 	 *
 	 * This, as well as the FIXME below, requires knowing the link
 	 * capabilities of the hardware.
@@ -9777,20 +9784,33 @@ static bool cfg80211_off_channel_oper_allowed(struct wireless_dev *wdev,
 	/* we cannot leave radar channels */
 	for_each_valid_link(wdev, link_id) {
 		struct cfg80211_chan_def *chandef;
+		int link_radio_idx;
 
 		chandef = wdev_chandef(wdev, link_id);
 		if (!chandef || !chandef->chan)
 			continue;
 
+		if (!(chandef->chan->flags & IEEE80211_CHAN_RADAR))
+			continue;
+
 		/*
-		 * FIXME: don't require all_ok, but rather check only the
-		 *	  correct HW resource/link onto which 'chan' falls,
-		 *	  as only that link leaves the channel for doing
-		 *	  the off-channel operation.
+		 * chandef->chan is a radar channel. If the radio/link onto
+		 * which this radar channel falls is the same radio/link onto
+		 * which the input 'chan' falls, off-channel operation should
+		 * not be allowed. Hence, set 'all_ok' to false.
 		 */
 
-		if (chandef->chan->flags & IEEE80211_CHAN_RADAR)
+		if (wdev->valid_links) {
+			link_radio_idx = cfg80211_get_radio_idx_by_chan(wdev->wiphy,
+									chandef->chan);
+			if (link_radio_idx < 0 ||
+			    link_radio_idx == radio_idx) {
+				all_ok = false;
+				break;
+			}
+		} else {
 			all_ok = false;
+		}
 	}
 
 	if (all_ok)

base-commit: 28aa52b6189f1cc409f96910c63fa1b99370b99e
-- 
2.34.1


