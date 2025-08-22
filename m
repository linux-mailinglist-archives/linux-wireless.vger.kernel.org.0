Return-Path: <linux-wireless+bounces-26554-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B39B30E2D
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Aug 2025 07:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FC317BFBFF
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Aug 2025 05:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D252E2676;
	Fri, 22 Aug 2025 05:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cXgZEZ/t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C87D2E282D
	for <linux-wireless@vger.kernel.org>; Fri, 22 Aug 2025 05:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755841184; cv=none; b=MFKHiU1q4PsTVG47Kf5/Aa7m9Wpp/ofXEtNo1toa1CxP/0GhjGeoJ3rY2+1V7dWsb6cAsGWf/onz6OMIeGyDOO39a3G7YJPxMl9gu2lfThjqyCi8ecNkPXkWtCkOE7hltyaM7FiqQlikgPrrGS1tBzvfD2VS5nFPy0uUEfkbrcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755841184; c=relaxed/simple;
	bh=9AQNwxQDknVcD9fqzZswefnuxfX/bEPGdaxQnYlNcz8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mv3Ll2wuxok3ISxJOcj21aWMkBOtkGawJhB8n94VZ7ck+no0UkMe7UlmERbV7zhXDmgz7fDXZSNCX91UxpUEaoAvl0n1xb9LJMzPyAM40kWa/SWMHmBxnCzBWITEvP8PwStQf6Cw2XTMx9EM2Kb1U0fmGkbCnnISmsu4GX7QEho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cXgZEZ/t; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LI92S5008806;
	Fri, 22 Aug 2025 05:39:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ZrpGqjQhyAJuISjw7XxNeR
	5U/tACHYoEWAG/1H5LELE=; b=cXgZEZ/tLGjAUHNWbXhdkYLbNwRbmTj303dkut
	pd1k6j+nEvIXDoHKyskfUkcRQiPyOgCSuOJzFOBS+Li8SqzaqwxkMTEVAjfo0k7P
	Nr8k/5/ait3hh7yjvNBqF2W4HzldQ+q5TdH2WdodgbTLKvsquA5GKJB4+Cqg/ubB
	RmUP0iChrNbI6RqsWFJTzkc+mv9EC2oAwrjtNhaZcGoq+/T8CgRU/S46Tn2EViuL
	ASAgU56J19NkpltUxG/cWAh2vpULhZpfjmK1ylhmsrKri5XN7Y2E8klV5afQ5ent
	x5rkApuO4zkpkUIhpBsUfG5keM645oNRXcwO/hJ8gi7HbpuQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n528ywef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 05:39:36 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57M5dZZC013323
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 05:39:35 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 21 Aug 2025 22:39:34 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH] iw: add support to print link level information in station dump
Date: Fri, 22 Aug 2025 11:09:18 +0530
Message-ID: <20250822053918.528306-1-quic_sarishar@quicinc.com>
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
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=fpOFpF4f c=1 sm=1 tr=0 ts=68a80298 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=FkwUKBB4bU-CPWA2L7oA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: P_dONHfr8kmzsDBr2kiUB2qpEBTk8IDQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXxnq0eOMdtkyF
 cwUq6E9ghJQPNFm+KMbR+wyZ5kzLKmi5+tdDvFR5xm3nFrJa8ELftt41tA14ZOFCItP54KuywT8
 NilpaF7YYc2Yp49ic9iTk8tL22fQNIhOYAcKasiKNkxJE8we9C1e2SblquVAWYbrlB7V/9B3H5w
 AoX25K5O2NBqC20fmLB7cPTNBurx+POOqtzc+wx4wtP+dt2MCM3hPG5+K+39iQmNk8V73e1C64z
 mLYqcAELyE3PqhxBmoL+HDNrfbpyWL318SFWa9HMPL6bvQnf/Ig7n98Tcuox7xzoqIyat41+M21
 7iUQCEzh8oK9HBNv3Q9q6jB2n9IMt1OME/RinlMI1nLgBPVkZCgjizSfB+C1nRDcAN1V4K07M+K
 MEGtQYF98s/T1YdMIQuE/Txo3KyjlA==
X-Proofpoint-ORIG-GUID: P_dONHfr8kmzsDBr2kiUB2qpEBTk8IDQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_01,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

Currently, the iw station dump displays the overall statistics of
associated MLO (multi-link operation) station. While it provides a
overall summary view, it does not reflect the individual link-level
statistics.

Extend iw to parse and display nested per-link attributes for MLO
station, incorporating recent kernel support for reporting per-link
statistics. This allows users to view detailed statistics for each
link, along with overall statistics which improving visibility and
debugging capabilities for MLO stations.

Sample output:

For MLO client: iw dev wlan0 station dump -v
Station xx:xx:xx:xx:xx:xx (on wlan0)
        authorized:     yes
        authenticated:  yes
        associated:     yes
        preamble:       long
        WMM/WME:        yes
        MFP:            yes
        TDLS peer:      no
        inactive time:  328 ms
        rx bytes:       11319
        rx packets:     98
        tx bytes:       1496
        tx packets:     9
        tx retries:     3
        tx failed:      0
        rx drop misc:   0
        signal:         -33 dBm
        signal avg:     -28 dBm
        tx bitrate:     6.0 MBit/s
        tx duration:    3989 us
        rx bitrate:     576.4 MBit/s 80MHz EHT-MCS 5 EHT-NSS 2 EHT-GI 0
        rx duration:    0 us
        last ack signal:-35 dBm
        avg ack signal: -33 dBm
        MSDU:
        TID     rx      tx      tx retries      tx failed
        0       88      3       0               0
        1       0       0       0               0
        2       0       0       0               0
        3       0       0       0               0
        4       0       0       0               0
        5       0       0       0               0
        6       2       0       0               0
        7       0       2       0               0
        8       0       0       0               0
        9       0       0       0               0
        10      0       0       0               0
        11      0       0       0               0
        12      0       0       0               0
        13      0       0       0               0
        14      0       0       0               0
        15      0       0       0               0
        16      0       4       0               0
        TXQs:
                TID     qsz-byt qsz-pkt flows   drops   marks   overlmt hashcol tx-bytes        tx-packets
                0       0       0       3       0       0       0       0       186             3
                1       0       0       0       0       0       0       0       0               0
                2       0       0       0       0       0       0       0       0               0
                3       0       0       0       0       0       0       0       0               0
                4       0       0       0       0       0       0       0       0               0
                5       0       0       0       0       0       0       0       0               0
                6       0       0       0       0       0       0       0       0               0
                7       0       0       2       0       0       0       0       580             2
                8       0       0       0       0       0       0       0       0               0
                9       0       0       0       0       0       0       0       0               0
                10      0       0       0       0       0       0       0       0               0
                11      0       0       0       0       0       0       0       0               0
                12      0       0       0       0       0       0       0       0               0
                13      0       0       0       0       0       0       0       0               0
                14      0       0       0       0       0       0       0       0               0
                15      0       0       0       0       0       0       0       0               0
        DTIM period:    2
        beacon interval:100
        connected time: 188 seconds
        associated at [boottime]:       659.536s
        associated at:  659536 ms
        current time:   847264 ms
        Link 0:
                address: xx:xx:xx:xx:xx:xx
                inactive time:  5324 ms
                rx bytes:       7838
                rx packets:     69
                tx bytes:       0
                tx packets:     0
                tx retries:     0
                tx failed:      0
                rx drop misc:   0
                signal:         -33 dBm
                signal avg:     -28 dBm
                tx bitrate:     6.0 MBit/s
                tx duration:    1264 us
                rx bitrate:     576.4 MBit/s 80MHz EHT-MCS 5 EHT-NSS 2 EHT-GI 0
                rx duration:    0 us
                MSDU:
                TID     rx      tx      tx retries      tx failed
                0       65      0       0               0
                1       0       0       0               0
                2       0       0       0               0
                3       0       0       0               0
                4       0       0       0               0
                5       0       0       0               0
                6       0       0       0               0
                7       0       0       0               0
                8       0       0       0               0
                9       0       0       0               0
                10      0       0       0               0
                11      0       0       0               0
                12      0       0       0               0
                13      0       0       0               0
                14      0       0       0               0
                15      0       0       0               0
                16      0       0       0               0
                DTIM period:    2
                beacon interval:100
        Link 1:
                address: xx:xx:xx:xx:xx:xx
                inactive time:  328 ms
                rx bytes:       3481
                rx packets:     29
                tx bytes:       1496
                tx packets:     9
                tx retries:     3
                tx failed:      0
                rx drop misc:   0
                signal:         -33 dBm
                signal avg:     -32 dBm
                tx bitrate:     6.0 MBit/s
                tx duration:    2725 us
                rx bitrate:     864.8 MBit/s 80MHz EHT-MCS 8 EHT-NSS 2 EHT-GI 0
                rx duration:    0 us
                last ack signal:-35 dBm
                avg ack signal: -33 dBm
                MSDU:
                TID     rx      tx      tx retries      tx failed
                0       23      3       0               0
                1       0       0       0               0
                2       0       0       0               0
                3       0       0       0               0
                4       0       0       0               0
                5       0       0       0               0
                6       2       0       0               0
                7       0       2       0               0
                8       0       0       0               0
                9       0       0       0               0
                10      0       0       0               0
                11      0       0       0               0
                12      0       0       0               0
                13      0       0       0               0
                14      0       0       0               0
                15      0       0       0               0
                16      0       4       0               0
                DTIM period:    2
                beacon interval:100

For non-ML client: iw dev wlan0 station dump
Station xx:xx:xx:xx:xx:xx (on wlan0)
        authorized:     yes
        authenticated:  yes
        associated:     yes
        preamble:       long
        WMM/WME:        yes
        MFP:            yes
        TDLS peer:      no
        inactive time:  540 ms
        rx bytes:       2944
        rx packets:     27
        tx bytes:       2156
        tx packets:     18
        tx retries:     34
        tx failed:      0
        rx drop misc:   0
        signal:         -95 dBm
        tx bitrate:     344.1 MBit/s HE-MCS 7 HE-NSS 4 HE-GI 0 HE-DCM
        tx duration:    3695 us
        rx bitrate:     1441.3 MBit/s 80MHz HE-MCS 7 HE-NSS 4 HE-GI 0 HE-DCM 0
        rx duration:    0 us
        DTIM period:    2
        beacon interval:100
        connected time: 128 seconds
        associated at [boottime]:       10850.471s
        associated at: 10850467 ms
        current time:   10978261 ms

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 station.c | 316 +++++++++++++++++++++++++++++++-----------------------
 1 file changed, 181 insertions(+), 135 deletions(-)

diff --git a/station.c b/station.c
index bf7c0f5..a07ead6 100644
--- a/station.c
+++ b/station.c
@@ -101,7 +101,7 @@ int parse_txq_stats(char *buf, int buflen, struct nlattr *tid_stats_attr, int he
 
 }
 
-static void parse_tid_stats(struct nlattr *tid_stats_attr)
+static void parse_tid_stats(struct nlattr *tid_stats_attr, const char *indent)
 {
 	struct nlattr *stats_info[NL80211_TID_STATS_MAX + 1], *tidattr, *info;
 	static struct nla_policy stats_policy[NL80211_TID_STATS_MAX + 1] = {
@@ -115,14 +115,14 @@ static void parse_tid_stats(struct nlattr *tid_stats_attr)
 	char txqbuf[2000] = {}, *pos = txqbuf;
 	int buflen = sizeof(txqbuf), foundtxq = 0;
 
-	printf("\n\tMSDU:\n\t\tTID\trx\ttx\ttx retries\ttx failed");
+	printf("%sMSDU:%sTID\trx\ttx\ttx retries\ttx failed", indent, indent);
 	nla_for_each_nested(tidattr, tid_stats_attr, rem) {
 		if (nla_parse_nested(stats_info, NL80211_TID_STATS_MAX,
 				     tidattr, stats_policy)) {
 			printf("failed to parse nested stats attributes!");
 			return;
 		}
-		printf("\n\t\t%d", i);
+		printf("%s%d", indent, i);
 		info = stats_info[NL80211_TID_STATS_RX_MSDU];
 		if (info)
 			printf("\t%llu", (unsigned long long)nla_get_u64(info));
@@ -145,10 +145,10 @@ static void parse_tid_stats(struct nlattr *tid_stats_attr)
 	}
 
 	if (foundtxq)
-		printf("\n\tTXQs:%s", txqbuf);
+		printf("%sTXQs:%s", indent, txqbuf);
 }
 
-static void parse_bss_param(struct nlattr *bss_param_attr)
+static void parse_bss_param(struct nlattr *bss_param_attr, const char *indent)
 {
 	struct nlattr *bss_param_info[NL80211_STA_BSS_PARAM_MAX + 1], *info;
 	static struct nla_policy bss_poilcy[NL80211_STA_BSS_PARAM_MAX + 1] = {
@@ -166,13 +166,13 @@ static void parse_bss_param(struct nlattr *bss_param_attr)
 
 	info = bss_param_info[NL80211_STA_BSS_PARAM_DTIM_PERIOD];
 	if (info)
-		printf("\n\tDTIM period:\t%u", nla_get_u8(info));
+		printf("%sDTIM period:\t%u", indent, nla_get_u8(info));
 	info = bss_param_info[NL80211_STA_BSS_PARAM_BEACON_INTERVAL];
 	if (info)
-		printf("\n\tbeacon interval:%u", nla_get_u16(info));
+		printf("%sbeacon interval:%u", indent, nla_get_u16(info));
 	info = bss_param_info[NL80211_STA_BSS_PARAM_CTS_PROT];
 	if (info) {
-		printf("\n\tCTS protection:");
+		printf("%sCTS protection:", indent);
 		if (nla_get_u16(info))
 			printf("\tyes");
 		else
@@ -180,7 +180,7 @@ static void parse_bss_param(struct nlattr *bss_param_attr)
 	}
 	info = bss_param_info[NL80211_STA_BSS_PARAM_SHORT_PREAMBLE];
 	if (info) {
-		printf("\n\tshort preamble:");
+		printf("%sshort preamble:", indent);
 		if (nla_get_u16(info))
 			printf("\tyes");
 		else
@@ -188,7 +188,7 @@ static void parse_bss_param(struct nlattr *bss_param_attr)
 	}
 	info = bss_param_info[NL80211_STA_BSS_PARAM_SHORT_SLOT_TIME];
 	if (info) {
-		printf("\n\tshort slot time:");
+		printf("%sshort slot time:", indent);
 		if (nla_get_u16(info))
 			printf("yes");
 		else
@@ -312,11 +312,152 @@ static char *get_chain_signal(struct nlattr *attr_list)
 	return buf;
 }
 
+static void print_nested_sta_handler(struct nlattr *link_sinfo[NL80211_STA_INFO_MAX + 1],
+				     void *arg, const char *indent)
+{
+	char *chain;
+	struct timeval now;
+	unsigned long long now_ms;
+
+	gettimeofday(&now, NULL);
+	now_ms = now.tv_sec * 1000ULL;
+	now_ms += (now.tv_usec / 1000);
+
+	if (link_sinfo[NL80211_STA_INFO_INACTIVE_TIME])
+		printf("%sinactive time:\t%u ms", indent,
+			nla_get_u32(link_sinfo[NL80211_STA_INFO_INACTIVE_TIME]));
+	if (link_sinfo[NL80211_STA_INFO_RX_BYTES64])
+		printf("%srx bytes:\t%llu", indent,
+		       (unsigned long long)nla_get_u64(link_sinfo[NL80211_STA_INFO_RX_BYTES64]));
+	else if (link_sinfo[NL80211_STA_INFO_RX_BYTES])
+		printf("%srx bytes:\t%u", indent,
+		       nla_get_u32(link_sinfo[NL80211_STA_INFO_RX_BYTES]));
+	if (link_sinfo[NL80211_STA_INFO_RX_PACKETS])
+		printf("%srx packets:\t%u", indent,
+			nla_get_u32(link_sinfo[NL80211_STA_INFO_RX_PACKETS]));
+	if (link_sinfo[NL80211_STA_INFO_TX_BYTES64])
+		printf("%stx bytes:\t%llu", indent,
+		       (unsigned long long)nla_get_u64(link_sinfo[NL80211_STA_INFO_TX_BYTES64]));
+	else if (link_sinfo[NL80211_STA_INFO_TX_BYTES])
+		printf("%stx bytes:\t%u", indent,
+		       nla_get_u32(link_sinfo[NL80211_STA_INFO_TX_BYTES]));
+	if (link_sinfo[NL80211_STA_INFO_TX_PACKETS])
+		printf("%stx packets:\t%u", indent,
+			nla_get_u32(link_sinfo[NL80211_STA_INFO_TX_PACKETS]));
+	if (link_sinfo[NL80211_STA_INFO_TX_RETRIES])
+		printf("%stx retries:\t%u", indent,
+			nla_get_u32(link_sinfo[NL80211_STA_INFO_TX_RETRIES]));
+	if (link_sinfo[NL80211_STA_INFO_TX_FAILED])
+		printf("%stx failed:\t%u", indent,
+			nla_get_u32(link_sinfo[NL80211_STA_INFO_TX_FAILED]));
+	if (link_sinfo[NL80211_STA_INFO_BEACON_LOSS])
+		printf("%sbeacon loss:\t%u", indent,
+		       nla_get_u32(link_sinfo[NL80211_STA_INFO_BEACON_LOSS]));
+	if (link_sinfo[NL80211_STA_INFO_BEACON_RX])
+		printf("\n\t\tbeacon rx:\t%llu",
+		       (unsigned long long)nla_get_u64(link_sinfo[NL80211_STA_INFO_BEACON_RX]));
+	if (link_sinfo[NL80211_STA_INFO_RX_DROP_MISC])
+		printf("%srx drop misc:\t%llu", indent,
+		       (unsigned long long)nla_get_u64(link_sinfo[NL80211_STA_INFO_RX_DROP_MISC]));
+
+	chain = get_chain_signal(link_sinfo[NL80211_STA_INFO_CHAIN_SIGNAL]);
+	if (link_sinfo[NL80211_STA_INFO_SIGNAL])
+		printf("%ssignal:  \t%d %sdBm", indent,
+			(int8_t)nla_get_u8(link_sinfo[NL80211_STA_INFO_SIGNAL]),
+			chain);
+
+	chain = get_chain_signal(link_sinfo[NL80211_STA_INFO_CHAIN_SIGNAL_AVG]);
+	if (link_sinfo[NL80211_STA_INFO_SIGNAL_AVG])
+		printf("%ssignal avg:\t%d %sdBm", indent,
+			(int8_t)nla_get_u8(link_sinfo[NL80211_STA_INFO_SIGNAL_AVG]),
+			chain);
+
+	if (link_sinfo[NL80211_STA_INFO_BEACON_SIGNAL_AVG])
+		printf("%sbeacon signal avg:\t%d dBm", indent,
+		       (int8_t)nla_get_u8(link_sinfo[NL80211_STA_INFO_BEACON_SIGNAL_AVG]));
+	if (link_sinfo[NL80211_STA_INFO_T_OFFSET])
+		printf("%sToffset:\t%llu us", indent,
+		       (unsigned long long)nla_get_u64(link_sinfo[NL80211_STA_INFO_T_OFFSET]));
+
+	if (link_sinfo[NL80211_STA_INFO_TX_BITRATE]) {
+		char buf[100];
+
+		parse_bitrate(link_sinfo[NL80211_STA_INFO_TX_BITRATE], buf, sizeof(buf));
+		printf("%stx bitrate:\t%s", indent, buf);
+	}
+
+	if (link_sinfo[NL80211_STA_INFO_TX_DURATION])
+		printf("%stx duration:\t%lld us", indent,
+		       (unsigned long long)nla_get_u64(link_sinfo[NL80211_STA_INFO_TX_DURATION]));
+
+	if (link_sinfo[NL80211_STA_INFO_RX_BITRATE]) {
+		char buf[100];
+
+		parse_bitrate(link_sinfo[NL80211_STA_INFO_RX_BITRATE], buf, sizeof(buf));
+		printf("%srx bitrate:\t%s", indent, buf);
+	}
+
+	if (link_sinfo[NL80211_STA_INFO_RX_DURATION])
+		printf("%srx duration:\t%lld us", indent,
+		       (unsigned long long)nla_get_u64(link_sinfo[NL80211_STA_INFO_RX_DURATION]));
+
+	if (link_sinfo[NL80211_STA_INFO_ACK_SIGNAL])
+		printf("%slast ack signal:%d dBm", indent,
+		       (int8_t)nla_get_u8(link_sinfo[NL80211_STA_INFO_ACK_SIGNAL]));
+
+	if (link_sinfo[NL80211_STA_INFO_ACK_SIGNAL_AVG])
+		printf("%savg ack signal:\t%d dBm", indent,
+			(int8_t)nla_get_u8(link_sinfo[NL80211_STA_INFO_ACK_SIGNAL_AVG]));
+
+	if (link_sinfo[NL80211_STA_INFO_AIRTIME_WEIGHT]) {
+		printf("%sairtime weight: %d", indent,
+		       nla_get_u16(link_sinfo[NL80211_STA_INFO_AIRTIME_WEIGHT]));
+	}
+
+	if (link_sinfo[NL80211_STA_INFO_EXPECTED_THROUGHPUT]) {
+		uint32_t thr;
+
+		thr = nla_get_u32(link_sinfo[NL80211_STA_INFO_EXPECTED_THROUGHPUT]);
+		/* convert in Mbps but scale by 1000 to save kbps units */
+		thr = thr * 1000 / 1024;
+
+		printf("%sexpected throughput:\t%u.%uMbps", indent,
+		       thr / 1000, thr % 1000);
+	}
+
+	if (link_sinfo[NL80211_STA_INFO_TID_STATS] && arg != NULL &&
+	    !strcmp((char *)arg, "-v"))
+		parse_tid_stats(link_sinfo[NL80211_STA_INFO_TID_STATS], indent);
+	if (link_sinfo[NL80211_STA_INFO_BSS_PARAM])
+		parse_bss_param(link_sinfo[NL80211_STA_INFO_BSS_PARAM], indent);
+	if (link_sinfo[NL80211_STA_INFO_CONNECTED_TIME])
+		printf("%sconnected time:\t%u seconds", indent,
+			nla_get_u32(link_sinfo[NL80211_STA_INFO_CONNECTED_TIME]));
+	if (link_sinfo[NL80211_STA_INFO_ASSOC_AT_BOOTTIME]) {
+		unsigned long long bt;
+		struct timespec now_ts;
+		unsigned long long boot_ns;
+		unsigned long long assoc_at_ms;
+
+		clock_gettime(CLOCK_BOOTTIME, &now_ts);
+		boot_ns = now_ts.tv_sec * 1000000000ULL;
+		boot_ns += now_ts.tv_nsec;
+
+		bt = (unsigned long long)nla_get_u64(link_sinfo[NL80211_STA_INFO_ASSOC_AT_BOOTTIME]);
+		printf("%sassociated at [boottime]:\t%llu.%.3llus",
+		       indent, bt/1000000000, (bt%1000000000)/1000000);
+		assoc_at_ms = now_ms - ((boot_ns - bt) / 1000000);
+		printf("%sassociated at:\t%llu ms", indent, assoc_at_ms);
+	}
+}
+
 static int print_sta_handler(struct nl_msg *msg, void *arg)
 {
 	struct nlattr *tb[NL80211_ATTR_MAX + 1];
 	struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
 	struct nlattr *sinfo[NL80211_STA_INFO_MAX + 1];
+	struct nlattr *link_sinfo[NL80211_STA_INFO_MAX + 1];
+	struct nlattr *attrs, *link[NL80211_ATTR_MAX + 1];
 	char mac_addr[20], state_name[10], dev[20];
 	struct nl80211_sta_flag_update *sta_flags;
 	static struct nla_policy stats_policy[NL80211_STA_INFO_MAX + 1] = {
@@ -356,7 +497,6 @@ static int print_sta_handler(struct nl_msg *msg, void *arg)
 		[NL80211_STA_INFO_CONNECTED_TO_AS] = { .type = NLA_U8 },
 		[NL80211_STA_INFO_CONNECTED_TO_GATE] = { .type = NLA_U8 },
 	};
-	char *chain;
 	struct timeval now;
 	unsigned long long now_ms;
 
@@ -388,107 +528,6 @@ static int print_sta_handler(struct nl_msg *msg, void *arg)
 	if_indextoname(nla_get_u32(tb[NL80211_ATTR_IFINDEX]), dev);
 	printf("Station %s (on %s)", mac_addr, dev);
 
-	if (sinfo[NL80211_STA_INFO_INACTIVE_TIME])
-		printf("\n\tinactive time:\t%u ms",
-			nla_get_u32(sinfo[NL80211_STA_INFO_INACTIVE_TIME]));
-	if (sinfo[NL80211_STA_INFO_RX_BYTES64])
-		printf("\n\trx bytes:\t%llu",
-		       (unsigned long long)nla_get_u64(sinfo[NL80211_STA_INFO_RX_BYTES64]));
-	else if (sinfo[NL80211_STA_INFO_RX_BYTES])
-		printf("\n\trx bytes:\t%u",
-		       nla_get_u32(sinfo[NL80211_STA_INFO_RX_BYTES]));
-	if (sinfo[NL80211_STA_INFO_RX_PACKETS])
-		printf("\n\trx packets:\t%u",
-			nla_get_u32(sinfo[NL80211_STA_INFO_RX_PACKETS]));
-	if (sinfo[NL80211_STA_INFO_TX_BYTES64])
-		printf("\n\ttx bytes:\t%llu",
-		       (unsigned long long)nla_get_u64(sinfo[NL80211_STA_INFO_TX_BYTES64]));
-	else if (sinfo[NL80211_STA_INFO_TX_BYTES])
-		printf("\n\ttx bytes:\t%u",
-		       nla_get_u32(sinfo[NL80211_STA_INFO_TX_BYTES]));
-	if (sinfo[NL80211_STA_INFO_TX_PACKETS])
-		printf("\n\ttx packets:\t%u",
-			nla_get_u32(sinfo[NL80211_STA_INFO_TX_PACKETS]));
-	if (sinfo[NL80211_STA_INFO_TX_RETRIES])
-		printf("\n\ttx retries:\t%u",
-			nla_get_u32(sinfo[NL80211_STA_INFO_TX_RETRIES]));
-	if (sinfo[NL80211_STA_INFO_TX_FAILED])
-		printf("\n\ttx failed:\t%u",
-			nla_get_u32(sinfo[NL80211_STA_INFO_TX_FAILED]));
-	if (sinfo[NL80211_STA_INFO_BEACON_LOSS])
-		printf("\n\tbeacon loss:\t%u",
-		       nla_get_u32(sinfo[NL80211_STA_INFO_BEACON_LOSS]));
-	if (sinfo[NL80211_STA_INFO_BEACON_RX])
-		printf("\n\tbeacon rx:\t%llu",
-		       (unsigned long long)nla_get_u64(sinfo[NL80211_STA_INFO_BEACON_RX]));
-	if (sinfo[NL80211_STA_INFO_RX_DROP_MISC])
-		printf("\n\trx drop misc:\t%llu",
-		       (unsigned long long)nla_get_u64(sinfo[NL80211_STA_INFO_RX_DROP_MISC]));
-
-	chain = get_chain_signal(sinfo[NL80211_STA_INFO_CHAIN_SIGNAL]);
-	if (sinfo[NL80211_STA_INFO_SIGNAL])
-		printf("\n\tsignal:  \t%d %sdBm",
-			(int8_t)nla_get_u8(sinfo[NL80211_STA_INFO_SIGNAL]),
-			chain);
-
-	chain = get_chain_signal(sinfo[NL80211_STA_INFO_CHAIN_SIGNAL_AVG]);
-	if (sinfo[NL80211_STA_INFO_SIGNAL_AVG])
-		printf("\n\tsignal avg:\t%d %sdBm",
-			(int8_t)nla_get_u8(sinfo[NL80211_STA_INFO_SIGNAL_AVG]),
-			chain);
-
-	if (sinfo[NL80211_STA_INFO_BEACON_SIGNAL_AVG])
-		printf("\n\tbeacon signal avg:\t%d dBm",
-		       (int8_t)nla_get_u8(sinfo[NL80211_STA_INFO_BEACON_SIGNAL_AVG]));
-	if (sinfo[NL80211_STA_INFO_T_OFFSET])
-		printf("\n\tToffset:\t%llu us",
-		       (unsigned long long)nla_get_u64(sinfo[NL80211_STA_INFO_T_OFFSET]));
-
-	if (sinfo[NL80211_STA_INFO_TX_BITRATE]) {
-		char buf[100];
-
-		parse_bitrate(sinfo[NL80211_STA_INFO_TX_BITRATE], buf, sizeof(buf));
-		printf("\n\ttx bitrate:\t%s", buf);
-	}
-
-	if (sinfo[NL80211_STA_INFO_TX_DURATION])
-		printf("\n\ttx duration:\t%lld us",
-		       (unsigned long long)nla_get_u64(sinfo[NL80211_STA_INFO_TX_DURATION]));
-
-	if (sinfo[NL80211_STA_INFO_RX_BITRATE]) {
-		char buf[100];
-
-		parse_bitrate(sinfo[NL80211_STA_INFO_RX_BITRATE], buf, sizeof(buf));
-		printf("\n\trx bitrate:\t%s", buf);
-	}
-
-	if (sinfo[NL80211_STA_INFO_RX_DURATION])
-		printf("\n\trx duration:\t%lld us",
-		       (unsigned long long)nla_get_u64(sinfo[NL80211_STA_INFO_RX_DURATION]));
-
-	if (sinfo[NL80211_STA_INFO_ACK_SIGNAL])
-		printf("\n\tlast ack signal:%d dBm",
-			(int8_t)nla_get_u8(sinfo[NL80211_STA_INFO_ACK_SIGNAL]));
-
-	if (sinfo[NL80211_STA_INFO_ACK_SIGNAL_AVG])
-		printf("\n\tavg ack signal:\t%d dBm",
-			(int8_t)nla_get_u8(sinfo[NL80211_STA_INFO_ACK_SIGNAL_AVG]));
-
-	if (sinfo[NL80211_STA_INFO_AIRTIME_WEIGHT]) {
-		printf("\n\tairtime weight: %d", nla_get_u16(sinfo[NL80211_STA_INFO_AIRTIME_WEIGHT]));
-	}
-
-	if (sinfo[NL80211_STA_INFO_EXPECTED_THROUGHPUT]) {
-		uint32_t thr;
-
-		thr = nla_get_u32(sinfo[NL80211_STA_INFO_EXPECTED_THROUGHPUT]);
-		/* convert in Mbps but scale by 1000 to save kbps units */
-		thr = thr * 1000 / 1024;
-
-		printf("\n\texpected throughput:\t%u.%uMbps",
-		       thr / 1000, thr % 1000);
-	}
-
 	if (sinfo[NL80211_STA_INFO_LLID])
 		printf("\n\tmesh llid:\t%d",
 			nla_get_u16(sinfo[NL80211_STA_INFO_LLID]));
@@ -610,32 +649,39 @@ static int print_sta_handler(struct nl_msg *msg, void *arg)
 		}
 	}
 
-	if (sinfo[NL80211_STA_INFO_TID_STATS] && arg != NULL &&
-	    !strcmp((char *)arg, "-v"))
-		parse_tid_stats(sinfo[NL80211_STA_INFO_TID_STATS]);
-	if (sinfo[NL80211_STA_INFO_BSS_PARAM])
-		parse_bss_param(sinfo[NL80211_STA_INFO_BSS_PARAM]);
-	if (sinfo[NL80211_STA_INFO_CONNECTED_TIME])
-		printf("\n\tconnected time:\t%u seconds",
-			nla_get_u32(sinfo[NL80211_STA_INFO_CONNECTED_TIME]));
-	if (sinfo[NL80211_STA_INFO_ASSOC_AT_BOOTTIME]) {
-		unsigned long long bt;
-		struct timespec now_ts;
-		unsigned long long boot_ns;
-		unsigned long long assoc_at_ms;
+	/* print non-MLO/MLO specific fields */
+	print_nested_sta_handler(sinfo, arg, "\n\t");
 
-		clock_gettime(CLOCK_BOOTTIME, &now_ts);
-		boot_ns = now_ts.tv_sec * 1000000000ULL;
-		boot_ns += now_ts.tv_nsec;
+	printf("\n\tcurrent time:\t%llu ms\n", now_ms);
 
-		bt = (unsigned long long)nla_get_u64(sinfo[NL80211_STA_INFO_ASSOC_AT_BOOTTIME]);
-		printf("\n\tassociated at [boottime]:\t%llu.%.3llus",
-		       bt/1000000000, (bt%1000000000)/1000000);
-		assoc_at_ms = now_ms - ((boot_ns - bt) / 1000000);
-		printf("\n\tassociated at:\t%llu ms", assoc_at_ms);
+	/* print link specific fields */
+	if (tb[NL80211_ATTR_MLO_LINKS]) {
+		int ret = 0;
+
+		nla_for_each_nested(attrs, tb[NL80211_ATTR_MLO_LINKS], ret) {
+			nla_parse_nested(link, NL80211_ATTR_MAX, attrs, NULL);
+			if (link[NL80211_ATTR_MLO_LINK_ID]) {
+				printf("\n\tLink %u:", nla_get_u8(link[NL80211_ATTR_MLO_LINK_ID]));
+				if (link[NL80211_ATTR_MAC]) {
+					mac_addr_n2a(mac_addr, nla_data(link[NL80211_ATTR_MAC]));
+					printf("\n\t\taddress: %s", mac_addr);
+				}
+				if (!link[NL80211_ATTR_STA_INFO]) {
+					fprintf(stderr, "link sta stats missing!\n");
+					return NL_SKIP;
+				}
+
+				if (nla_parse_nested(link_sinfo, NL80211_STA_INFO_MAX,
+						     link[NL80211_ATTR_STA_INFO],
+						     stats_policy)) {
+					fprintf(stderr, "failed to parse nested attributes!\n");
+					return NL_SKIP;
+				}
+				print_nested_sta_handler(link_sinfo, arg, "\n\t\t");
+			}
+		}
 	}
-
-	printf("\n\tcurrent time:\t%llu ms\n", now_ms);
+	printf("\n");
 	return NL_SKIP;
 }
 

base-commit: 8d52fb4ccc5398a89dd99eba132a7faa3136e1ce
-- 
2.34.1


