Return-Path: <linux-wireless+bounces-25346-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EBBB0351A
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 06:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 992EB18994D2
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 04:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101E71A317D;
	Mon, 14 Jul 2025 04:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Fi8C6pc8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EA84A11
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 04:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752466108; cv=none; b=BLWFthQGoGmuaT3bOhfRd+4kZGndOokAE9dU0AendFOm2S9jvJwI6NbtDABFxfSwpfluuzofADgdUMhUUcjd8XK8ecEdpwc5Lrrvltc9m+xoTZGQb0UWoIRiMJLNPKImGZfi+atozxSKM/RQkg0ThohTIuXHarU2SzUOujxQD4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752466108; c=relaxed/simple;
	bh=3NspWYfLp9A6ORLDz+tl0gxz64Zye9e7hzIpz93leIM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jq6Kbrj/xj6l8eUB61m6oC8ckavx9e5Ire08P6qL7jXFoNpkqyf0/M2DHyxM23CLz9p4iLEpCCKQKCUoKmf6noxzIK0HzINnulkmRR5A3EzV4ifjPhHHKmOR4Cff9l3F0xldw6mFkZCnNJY4RuwhFeH+a7vOgGNaZncLclpe+2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Fi8C6pc8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DNBqeI016114;
	Mon, 14 Jul 2025 04:08:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=CkY3xolqxisli54EeCcRQf
	gegoJKwqKJK/zSYY052xA=; b=Fi8C6pc8bNpEFQNujdVJKykxmp3FDgqIQIuOqS
	riQiY1mamIX/tQD/bQgp2IwhUuckSTag1Mq4JLmbxsfpjAKYKl6LITR6aJHJ+whl
	OLFsuZaKquiM455rZTQJW+9wjapyh0DUIlB7QOebJPwBloPrnkei67VQEpNBSStA
	UFhFZdmN0hq6H1OoE0o8eLoXh0XbvOpBlJJ5jzdharvqiUbqDO4gtP/U1Fd2FQ0X
	1UyGCzDpXoZSJ6oNcz6scinGOQWX01+yawCZBtqRQRkGU49hanJgcJpcuE0mxOem
	Gaupt1Vk5vbVt1blvkj+FxyxFYHli6hamAH6oTjX8puAywoA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ugfhb63k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 04:08:01 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56E480lF002528
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 04:08:00 GMT
Received: from hu-amitajit-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Sun, 13 Jul 2025 21:07:58 -0700
From: Amith A <quic_amitajit@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <quic_amitajit@quicinc.com>,
        "Aditya
 Kumar Singh" <aditya.kumar.singh@oss.qualcomm.com>
Subject: [PATCH wireless-next v2] wifi: cfg80211: fix off channel operation allowed check for MLO
Date: Mon, 14 Jul 2025 09:37:42 +0530
Message-ID: <20250714040742.538550-1-quic_amitajit@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 9Hcl2T-f3D19deluuktgMPH8e2Ay5OgB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDAyMSBTYWx0ZWRfX6BAubQzSeFry
 Jso9Eg2wSSTfddBRZEHPfbNLnt34tWjoMx0Nb3bFy9P9fTdp2zqjBWsiPvp0aKEoaqTd+Qf/h0G
 s9V8U3GDCPF4aAQS3FjFHaajxFiCm8+AkYggO4P4ukYPCK7NDwpx0SKZdjXtCvz9o84LcBfu+Cu
 mRhUMCoGdaLao5YpBuuaW7H5k+7v6vtVXmWKt1lOvfEttouJyi8PG2Pr1ddkHoi4BdrBPGOleoL
 KUzag50b7aRDnW+jFdnRgHGfB4Et1uazBPoX51/PSVoa0r+igtx86BBmcYX03nWyjSuoWhLSayK
 4pP58seaiXCPF8UD1KGy9ak1cL0DvQVYM2M1ETA0FE5PgQan/mj7xBuGM9LcI4Po55EghgiKxju
 3dVCmXF0LREOpcrA5PUJTu9fHuUag6cdN/sa08OFtcJ0Lu6eKH4l/Knk4tYlzjuhXJyJGE/R
X-Proofpoint-GUID: 9Hcl2T-f3D19deluuktgMPH8e2Ay5OgB
X-Authority-Analysis: v=2.4 cv=HYkUTjE8 c=1 sm=1 tr=0 ts=687482a1 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=mVBg5cK-9P9u6yz4axkA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 mlxscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140021

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
Chnages in v2:
	- Fixed Johannes's comment to return constants where possible
	instead of variables and also simplified the logic of matching
	the radio of the input channel and the radio of the radar channel

 net/wireless/nl80211.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 70ca74a75f22..9286a7195d53 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -9758,6 +9758,7 @@ static bool cfg80211_off_channel_oper_allowed(struct wireless_dev *wdev,
 {
 	unsigned int link_id;
 	bool all_ok = true;
+	int radio_idx;
 
 	lockdep_assert_wiphy(wdev->wiphy);
 
@@ -9767,8 +9768,10 @@ static bool cfg80211_off_channel_oper_allowed(struct wireless_dev *wdev,
 	if (!cfg80211_beaconing_iface_active(wdev))
 		return true;
 
+	radio_idx = cfg80211_get_radio_idx_by_chan(wdev->wiphy, chan);
+
 	/*
-	 * FIXME: check if we have a free HW resource/link for chan
+	 * FIXME: check if we have a free radio/link for chan
 	 *
 	 * This, as well as the FIXME below, requires knowing the link
 	 * capabilities of the hardware.
@@ -9777,20 +9780,28 @@ static bool cfg80211_off_channel_oper_allowed(struct wireless_dev *wdev,
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
+		link_radio_idx = cfg80211_get_radio_idx_by_chan(wdev->wiphy,
+								chandef->chan);
+		if (link_radio_idx == radio_idx) {
 			all_ok = false;
+			break;
+		}
 	}
 
 	if (all_ok)

base-commit: 28aa52b6189f1cc409f96910c63fa1b99370b99e
-- 
2.34.1


