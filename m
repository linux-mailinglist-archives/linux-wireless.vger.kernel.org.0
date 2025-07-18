Return-Path: <linux-wireless+bounces-25653-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 851B6B0A0A2
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 12:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD7084E2F56
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 10:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F31221297;
	Fri, 18 Jul 2025 10:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YSTm91bK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FFA29B218
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 10:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752834451; cv=none; b=QewHqA7Z5sQwxZ+olc12mViMmVyOAPd6ayiy+V1bQTROA0gMMRZ7B2siyO5XJZVOBw9lTOfQcdmqBfU1diNQ/ea2dogclXUuZxY1/Ah1q+Fv5P6u31BtCcpSvd3KLHiZKD0DU0SZwTQPRXWJ7k0ApvBjpHFgGL75TYz2kE1AgP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752834451; c=relaxed/simple;
	bh=vBr2FgFFDfnulZmIaKgfN5ggegmntUFJI5LACMPEEFM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jOqxCAhT0Xg9JejQWqMvDVvZetCF+GZ4g4nmErMkelL4W/fLN6ZC4DFzO7pLVARZV1+QnHsGQaCvUe17rTuMXmtHDYK1RV1lip81JrizSGlWwY0LfrtkBhYfgKlZPbgQgfDN94WMaLhMaUrMGupfH4BFLEFBg0BrHOETFe4RnNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YSTm91bK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I8TMZE007306;
	Fri, 18 Jul 2025 10:27:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=VG9vK9RtKGUs58TNh+emgm
	V6C4Up1lwz4mfMtUSB5Ko=; b=YSTm91bKrT3ZhT57iyN0/kTbnEN+EiQ6AvNwCS
	G4gYtRa7qQsM4fnQ+gWXA34xjGe5v4AbZ96laWq8RsAelHwJLQMwGKTH4mcx1pgZ
	NWvXezdW5kpzUX7BeiEbBFas1G1AvV9bW4rG7w5HB3gqkhJpvYKwjVaDraVU/b6W
	AbVXw8bQSPETU4WIy16Av3LQFQET6mU1p/fq4Swb6fGlYEd/pDlgPzNfl2Udq3LJ
	feKcQYu/5zseD9ejoXPb3XJRToFVAV8rafmPA3E37ZFTkffnGyTt+GKZKZ5JIpf5
	sjcZOGyocD06tsk+lqF3vpgGQePIx7ZUdRVB2OXhVrDbhPVw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wfcac9xr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 10:27:21 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56IARK9i024044
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 10:27:20 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 18 Jul 2025 03:27:19 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH v2] iw: Add support to set per-radio RTS threshold in multi-radio wiphy
Date: Fri, 18 Jul 2025 15:56:59 +0530
Message-ID: <20250718102659.111058-1-quic_rdevanat@quicinc.com>
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
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA4MSBTYWx0ZWRfX2XkbYhkFXs6F
 nbih0aTdFgOPrmP0Bkrg9G2Zx/WSmBRueg7B33BdI9frp0C8AtootSyiSXGUo/6jHDxkHjvctP1
 UE/WdV241mJbTch0GQMpDdq+AHA18iY+aUa80CN+dLEnwafSxCMimsdCjKGNSO9fUa1QdVGx2f2
 ekIWkS6+nAPr54mMsBGMl3dxTUtDBZEW3zbubWFyYUMhIFVb6EwOEMVdsg1kpgq/6FmlpSFjA0L
 PHDFR+JRme2Ho+R1iutF3r47v9e/icEjrwr6Uz+9oMpTvspRWxTNcPnFyEZ0dQUIPwqy646EmvS
 XNLAzsJS/qjpB+v27kVccyJiJ6whdt4Ihb2qzuHYGcmc59WJFoIMlmFOdugY8Lyqh9l0YdGtoNe
 IRTA6U7e5Wf/3rwLwDOTjO/YgOL7PIE9nlQbQmFdBxDUb1th9QwPjiceeW4cRqPPaNOUSHRd
X-Proofpoint-GUID: fM71nHD9CyJEc8bijmHPMbO2_8mAnnNW
X-Authority-Analysis: v=2.4 cv=SeX3duRu c=1 sm=1 tr=0 ts=687a2189 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=xbzPlRsWZ6QRjj0LRVsA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: fM71nHD9CyJEc8bijmHPMbO2_8mAnnNW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180081

Currently, setting RTS threshold changes the threshold for all radios in a
multi-radio wiphy. But different radios in a multi-radio wiphy can have
different RTS threshold requirements. Modify the iw command to get radio
index from user to operate on per-radio attributes in a multi-radio wiphy.
Modify the command such that the legacy userspace will still interact with
traditional drivers as well as multi-radio wiphy drivers. Also, print the
RTS threshold along with other per-radio attributes for each radio under
the section - "Supported wiphy radios" in iw phy#XXX info command.

In order to be able to set RTS threshold for a particular radio from user
space, without disturbing the other radios in a wiphy, pass the radio
index for which RTS threshold needs to be changed as optional pair of
arguments, along with its corresponding RTS threshold value. The valid
radio index values can be checked in iw phy#XXX info, under "Supported
wiphy radios". If radio index is not available, i.e., in case of single
radio wiphy, passing radio index is not required. If the radio index is not
provided, then the current behavior of setting passed RTS threshold to all
radios will be retained.

Command Usage:
iw phyX set rts <rts threshold|off> [radio <radio index>]

Sample output:
root@buildroot:~# iw phyXXX info
Wiphy phy0
        wiphy index: 0
        max # scan SSIDs: 16
        max scan IEs length: 339 bytes
        RTS threshold: 536
        Retry short limit: 7
        Retry long limit: 4
	.....
	Supported wiphy radios:
                * Idx 0:
                        RTS Threshold: 536
                        Frequency Range: 5170 MHz - 5835 MHz
			.....

                * Idx 1:
                        RTS Threshold: 231
                        Frequency Range: 2312 MHz - 2732 MHz
			.....

                * Idx 2:
                        RTS Threshold: 425
                        Frequency Range: 5945 MHz - 7125 MHz
			.....

	Globally valid interface combinations:
		.....

Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
v2:
 - Made changes to adhere to kernel code.
 - Dropped patch "[PATCH 2/2] iw: Add support to set per-radio Tx power
   config in multi-radio wiphy" from the series. This has to wait until
   changes related to tx power are merged.
---
 info.c |  4 ++++
 phy.c  | 28 ++++++++++++++++++++++++----
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/info.c b/info.c
index 986eaa6..18dcd36 100644
--- a/info.c
+++ b/info.c
@@ -926,6 +926,10 @@ next:
 					if (!have_combinations)
 						printf("\t\t\tRadio level interface combinations are not supported\n");
 					break;
+				case NL80211_WIPHY_RADIO_ATTR_RTS_THRESHOLD:
+					printf("\t\t\tRTS Threshold: %d\n",
+					       nla_get_u32(radio_prop));
+					break;
 				default:
 					printf("\t\t\t* <failed to parse>\n");
 				}
diff --git a/phy.c b/phy.c
index 584b103..0c7f844 100644
--- a/phy.c
+++ b/phy.c
@@ -449,15 +449,14 @@ static int handle_rts(struct nl80211_state *state,
 		      enum id_input id)
 {
 	unsigned int rts;
+	char *end;
 
-	if (argc != 1)
+	if (argc != 1 && argc != 3)
 		return 1;
 
 	if (strcmp("off", argv[0]) == 0)
 		rts = -1;
 	else {
-		char *end;
-
 		if (!*argv[0])
 			return 1;
 		rts = strtoul(argv[0], &end, 10);
@@ -467,11 +466,32 @@ static int handle_rts(struct nl80211_state *state,
 
 	NLA_PUT_U32(msg, NL80211_ATTR_WIPHY_RTS_THRESHOLD, rts);
 
+	argv++;
+	argc--;
+
+	if (argc > 1 && strcmp("radio", argv[0]) == 0) {
+		int radio_idx;
+
+		argv++;
+		argc--;
+
+		radio_idx = strtoul(argv[0], &end, 10);
+		if (*end != '\0')
+			return 1;
+
+		NLA_PUT_U8(msg, NL80211_ATTR_WIPHY_RADIO_INDEX, radio_idx);
+		argv++;
+		argc--;
+	}
+
+	if (argc)
+		return 1;
+
 	return 0;
  nla_put_failure:
 	return -ENOBUFS;
 }
-COMMAND(set, rts, "<rts threshold|off>",
+COMMAND(set, rts, "<rts threshold|off> [radio <radio index>]",
 	NL80211_CMD_SET_WIPHY, 0, CIB_PHY, handle_rts,
 	"Set rts threshold.");
 

base-commit: 8d52fb4ccc5398a89dd99eba132a7faa3136e1ce
-- 
2.25.1


