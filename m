Return-Path: <linux-wireless+bounces-14914-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 450389BC5F0
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 07:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24D621C20CEA
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 06:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E30A1714A0;
	Tue,  5 Nov 2024 06:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XlCadiTX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E66186284
	for <linux-wireless@vger.kernel.org>; Tue,  5 Nov 2024 06:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730789310; cv=none; b=pEJFZDcmyu0onPRic17oK0154sram8QijZQ/VWfA2duS7IPG5/yXqAHo1wh2gu8x7b9Vj9K3sC3ocuQTyL6aqiLBrjPXgugminI4QhfdB16q6WKoocyOFkOOJaFCChY/YO2uUHNKzmm8OcbDGhF9r1OM3bHGeVuocmFB7qcYsQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730789310; c=relaxed/simple;
	bh=5STOPZ1DISJ6sxPFC6Jj5t+kg2SUYn4l6FQvztXxPmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ENY8we08TbPZRjJxh1HVNRQ4earG4D/jpR2MtYTWVCqUWPOBQ/xnLzyXYTN9q3VtPmKdrAGyFgpXsGGOGpT9Uer8kFb4NQy/kqFcjBJzP6C/9I6O4h0E1MwoneOCms/Q+hZa4BXE/RgPER77iqnojo9mVokZyMSheN9TSBM3LdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XlCadiTX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4LIlBq028840;
	Tue, 5 Nov 2024 06:48:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=6gWf8PM3qhADCSfQKQ1gjQotnB8DriADqXr
	T756Gu7U=; b=XlCadiTXbh6S5VwONZnosR44VkbzwxBulEzOs2WrmNvh3MHLjuH
	wKLuli0B+xhstR9MBEYSh3OF3DxpDxDm7/wdjaNu6fa/9fvVUSuIuixO6lZbUuEH
	GyZJbmA9pxJ0i5aqHKfVSdeRcp3ThXMFdb46jsIc9D1Orli0Rf4HNf9+zext3UAF
	jMi8K56gZ/hm4g2/lvZAsASPylvkh7v6FSts66S6Fbg2a/+I797KESKsvRjArzQ+
	yuOJCMeomEVsQkD5C23ECaE0E43PlLfYjRTGTHpDmdj0/Zq2g251FbRlo27wa8xt
	hpUm2qQgt8c+E514R+hRi9Iatyj1AHDLSPA==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42nd286nve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 06:48:15 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A56mCCp020369;
	Tue, 5 Nov 2024 06:48:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 42nd5kvpgr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 06:48:12 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4A56mCrd020362;
	Tue, 5 Nov 2024 06:48:12 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-mrajraje-blr.qualcomm.com [10.190.104.79])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4A56mCeD020361
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 06:48:12 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 4581094)
	id 7911B410E8; Tue,  5 Nov 2024 12:18:11 +0530 (+0530)
From: Mohan Raj <quic_mrajraje@quicinc.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, Mohan Raj <quic_mrajraje@quicinc.com>
Subject: [PATCH 1/1] wifi: iw: Add support to display  max number of simultaneous links in phy info
Date: Tue,  5 Nov 2024 12:18:09 +0530
Message-Id: <20241105064809.2091332-1-quic_mrajraje@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: I9mUALOcq6j_s72QhwbPkwI4_IV-3Ml9
X-Proofpoint-GUID: I9mUALOcq6j_s72QhwbPkwI4_IV-3Ml9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 clxscore=1011 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411050048

To display the max number of simultaneous links in phy info	

    The maximum number of simultaneous links affiliated to an AP-MLD
    Present as a subfield in MLD capabilities and operations,the
    Capability is extracted through nl80211 specific attribute
    and added as part of phy information.

usage: iw <phy interface>

output:
Wiphy phy00
        wiphy index: 0
        max # scan SSIDs: 16
        max scan IEs length: 83 bytes
        max # sched scan SSIDs: 0
        max # match sets: 0
        Retry short limit: 7
        Retry long limit: 4
        Coverage class: 0 (up to 0m)
        Device supports AP-side u-APSD.
        Available Antennas: TX 0xf RX 0xf
        Configured Antennas: TX 0xf RX 0xf
        Supported interface modes:
                 * managed
                 * AP
                 * AP/VLAN
                 * monitor
                 * mesh point
        Band 1:
                Capabilities: 0x19ef
                        RX LDPC
                        HT20/HT40
                        SM Power Save disabled
                        RX HT20 SGI
                        RX HT40 SGI
                        TX STBC
                        RX STBC 1-stream
                        Max AMSDU length: 7935 bytes
                        DSSS/CCK HT40
				.
				.
				.
				.
				.
				.
				.
				.
				.
              * [ BSS_COLOR ]: BSS coloring support
                * [ RADAR_BACKGROUND ]: Radar background support
                * [ STA_MGMT_RTS_CTS ]: station management RTS CTS support
        MLD Capability: 0x44
                Max Number of Simultaneous Links: 4

        hw_idx 0 channel list:
                1 2 3 4 5 6 7 8 9 10 11 12 13 14
        hw_idx 1 channel list:
                36 40 44 48 52 56 60 64 100 104 108 112 116 120 124 128 
		132 136 140 144 149 153 157 161 165 169 173 177
        hw_idx 2 channel list:
                1 2 5 9 13 17 21 25 29 33 37 41 45 49 53 57 61 65 69 73
                77 81 85 89 93 97 101 105 109 113 117 121 125 129 133 
		137 141 145 149 153 157 161 165 169 173 177 181 185 189
		193 197 201 205 209 213 217 221 225 229 233

Signed-off-by: Mohan Raj <quic_mrajraje@quicinc.com>
---
 info.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/info.c b/info.c
index c5e863f..0d19d99 100644
--- a/info.c
+++ b/info.c
@@ -884,6 +884,31 @@ broken_combination:
 	if (tb_msg[NL80211_ATTR_MAX_AP_ASSOC_STA])
 		printf("\tMaximum associated stations in AP mode: %u\n",
 		       nla_get_u32(tb_msg[NL80211_ATTR_MAX_AP_ASSOC_STA]));
+	if (tb_msg[NL80211_ATTR_IFTYPE_EXT_CAPA]) {
+		int rem_ext = 0;
+		struct nlattr *tb1[NL80211_ATTR_MAX + 1];
+		struct nlattr *ext_attr;
+		__u8 max_simul_links;
+		__u16 mld_cap;
+
+		nla_for_each_nested(ext_attr, tb_msg[NL80211_ATTR_IFTYPE_EXT_CAPA], rem_ext) {
+			nla_parse(tb1, NL80211_ATTR_MAX, nla_data(ext_attr),
+				 nla_len(ext_attr), NULL);
+			if (tb1[NL80211_ATTR_EML_CAPABILITY] &&
+			   tb1[NL80211_ATTR_MLD_CAPA_AND_OPS]) {
+				mld_cap = nla_get_u16(tb1[NL80211_ATTR_MLD_CAPA_AND_OPS]);
+
+				if (mld_cap != 0) {
+					printf("\tMLD Capability: 0x%x\n",
+					      nla_get_u16(tb1[NL80211_ATTR_MLD_CAPA_AND_OPS]));
+					max_simul_links = mld_cap & 0xf;
+					printf("\t\tMax Number of Simultaneous Links: %d\n",
+					      max_simul_links);
+				}
+			}
+		}
+	}
+
 
 	return NL_SKIP;
 }
-- 
2.34.1


