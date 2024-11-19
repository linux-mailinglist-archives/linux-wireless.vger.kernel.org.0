Return-Path: <linux-wireless+bounces-15487-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CF69D1F3A
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 05:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 522F52812C0
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 04:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178521514DC;
	Tue, 19 Nov 2024 04:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GhNnRXyB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7355E14E2DA;
	Tue, 19 Nov 2024 04:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731990512; cv=none; b=W57vrs64/lJ0WD1fyBi6G8d/A5wDtcZG5QK353pJG1FaaoGhnXYxaDddmo1GG+T9t0RJOGLw0e07S9sA66r0ZHAJLppAxv/AQNox1ECMgM4jEgOejGKp+9JvE+lOM+cHu2DA3x8QW1kogrMFNPqieyJ1XOx0PKrxiaJsQT+TV9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731990512; c=relaxed/simple;
	bh=Ai/qJ8g97geA07BRCNdNxXm1EmJ92IRz6KQ7oTIR/rM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=gkLcNdkMDuEAOvYWoec7gxMz6z6KS4EENb7BP1VknPZUVKVlEm0AD9HIZMY/JH26zyCrIR5lCMDCKTfWNyvCchpK2Djbvo/Idxk7qcDoeHhxIccRToq624Mfv0aX5lldxwixUrrILph+z9FurwntgmoTpnWhIYX6Zcs196TTMoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GhNnRXyB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIGGmhl022573;
	Tue, 19 Nov 2024 04:28:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q+bfNasZwELhw3Tjkohr6bQw1hP1ghrC6uyW6hVjp44=; b=GhNnRXyBWycHS2Up
	raXKl2ptdKKSWTVkN1LDNYsxrmSpGJqMyoSpaxb2fCEqBoTKJKpm2HN4aRGU63/+
	jFqml6d1YXGMzDq3qaRpG3LfmdR6sVX9pH7uwCecGDZ4XKn/MnFy6FeGr390+S6v
	/103Z0A9d/9ditxKcyg6XzC2meLhV+AnOo2SsjSswd4i9ffp8MFdwyyKY59yVc89
	afzvg2k7iGYfHk4FOhZHsRgWlQFVIrlhV5pCuUDrfdOSiAvuZ1s2epFQ72FMwEvz
	KqUZkJyKWfJO6bJHdXvqP1KkMghtd1pCoYjY+R+fFsm24Q1LbJAcxeCANzcbnUlZ
	g5cwAw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4308y61c68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 04:28:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AJ4SMkp001047
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 04:28:22 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 18 Nov 2024 20:28:20 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Date: Tue, 19 Nov 2024 09:57:59 +0530
Subject: [PATCH 1/2] wifi: mac80211: add EHT 320 MHz support for mesh
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241119-mesh_320mhz_support-v1-1-f9463338d584@quicinc.com>
References: <20241119-mesh_320mhz_support-v1-0-f9463338d584@quicinc.com>
In-Reply-To: <20241119-mesh_320mhz_support-v1-0-f9463338d584@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>, Kalle Valo <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sathishkumar Muruganandam <quic_murugana@quicinc.com>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: su3XLFhiPcEpgwDRbqvIrOtxnGc6qZkg
X-Proofpoint-ORIG-GUID: su3XLFhiPcEpgwDRbqvIrOtxnGc6qZkg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=924 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411190034

From: Sathishkumar Muruganandam <quic_murugana@quicinc.com>

Currently, ieee80211_ie_build_he_oper() lacks support for 320 MHz handling
(already noted as a TODO). This is because 320 MHz is not included in
IEEE 802.11-ax. However, IEEE 802.11-be introduces 320 MHz support and if
the chandef indicates a 320 MHz bandwidth and is used directly as it is, it
will result in an incorrect HE Operation Information Element.

In order to support EHT 320 MHz, HE Operation Element should indicate
bandwidth as 160 MHz only. In EHT Operation IE, the correct bandwidth will
be present. Devices capable of EHT can parse EHT Information Element and
connect in 320 MHz and other HE capable devices can parse HE and can
connect in 160 MHz.

Add support to downgrade the bandwidth in ieee80211_ie_build_he_oper()
during 320 MHz operation and advertise it.

Signed-off-by: Sathishkumar Muruganandam <quic_murugana@quicinc.com>
Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 net/mac80211/util.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index a4e1301cc999d24d6ab1bd899742a2ff04229040..c88ce537aaa7ea5d59dc42e5f30805c6eb4a5c6d 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2762,6 +2762,7 @@ u8 *ieee80211_ie_build_he_oper(u8 *pos, const struct cfg80211_chan_def *chandef)
 {
 	struct ieee80211_he_operation *he_oper;
 	struct ieee80211_he_6ghz_oper *he_6ghz_op;
+	struct cfg80211_chan_def he_chandef;
 	u32 he_oper_params;
 	u8 ie_len = 1 + sizeof(struct ieee80211_he_operation);
 
@@ -2793,27 +2794,33 @@ u8 *ieee80211_ie_build_he_oper(u8 *pos, const struct cfg80211_chan_def *chandef)
 	if (chandef->chan->band != NL80211_BAND_6GHZ)
 		goto out;
 
+	cfg80211_chandef_create(&he_chandef, chandef->chan, NL80211_CHAN_NO_HT);
+	he_chandef.center_freq1 = chandef->center_freq1;
+	he_chandef.center_freq2 = chandef->center_freq2;
+	he_chandef.width = chandef->width;
+
 	/* TODO add VHT operational */
 	he_6ghz_op = (struct ieee80211_he_6ghz_oper *)pos;
 	he_6ghz_op->minrate = 6; /* 6 Mbps */
 	he_6ghz_op->primary =
-		ieee80211_frequency_to_channel(chandef->chan->center_freq);
+		ieee80211_frequency_to_channel(he_chandef.chan->center_freq);
 	he_6ghz_op->ccfs0 =
-		ieee80211_frequency_to_channel(chandef->center_freq1);
-	if (chandef->center_freq2)
+		ieee80211_frequency_to_channel(he_chandef.center_freq1);
+	if (he_chandef.center_freq2)
 		he_6ghz_op->ccfs1 =
-			ieee80211_frequency_to_channel(chandef->center_freq2);
+			ieee80211_frequency_to_channel(he_chandef.center_freq2);
 	else
 		he_6ghz_op->ccfs1 = 0;
 
-	switch (chandef->width) {
+	switch (he_chandef.width) {
 	case NL80211_CHAN_WIDTH_320:
-		/*
-		 * TODO: mesh operation is not defined over 6GHz 320 MHz
-		 * channels.
+		/* Downgrade EHT 320 MHz BW to 160 MHz for HE and set new
+		 * center_freq1
 		 */
-		WARN_ON(1);
-		break;
+		ieee80211_chandef_downgrade(&he_chandef, NULL);
+		he_6ghz_op->ccfs0 =
+			ieee80211_frequency_to_channel(he_chandef.center_freq1);
+		fallthrough;
 	case NL80211_CHAN_WIDTH_160:
 		/* Convert 160 MHz channel width to new style as interop
 		 * workaround.
@@ -2821,7 +2828,7 @@ u8 *ieee80211_ie_build_he_oper(u8 *pos, const struct cfg80211_chan_def *chandef)
 		he_6ghz_op->control =
 			IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_160MHZ;
 		he_6ghz_op->ccfs1 = he_6ghz_op->ccfs0;
-		if (chandef->chan->center_freq < chandef->center_freq1)
+		if (he_chandef.chan->center_freq < he_chandef.center_freq1)
 			he_6ghz_op->ccfs0 -= 8;
 		else
 			he_6ghz_op->ccfs0 += 8;

-- 
2.34.1


