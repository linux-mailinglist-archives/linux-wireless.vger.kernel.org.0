Return-Path: <linux-wireless+bounces-20140-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CA0A5B93B
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 07:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03D7B7A5600
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 06:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582B21EB19F;
	Tue, 11 Mar 2025 06:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="p5sJJ7EK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4821E5B6D
	for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 06:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741674459; cv=none; b=HGnBvA5UHWFXh8lUALrBEavOT4YcBHL6g1Ojd4dLFRGP/hKHmcnbPXcZixuPuPjzYz8TnPZ/BSNYBHmqfCpC5kljunbvxz34cYA6QlEtsrec81HJZqYS+JAHuHZHH0Vzjsaps+7vIuJYhE7PEiRZPCx86v2AL5U2FzmnzNj/z44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741674459; c=relaxed/simple;
	bh=BjSdqNsTsHiTj3m7kVd3IZB6+ogeP2qKGDt4u5mdPaA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tc614TG8qxSqSxzr3yQCWui3p3bO9W1NoCHQEkHY48pCStFAT+zchNs8w8CR9UfIE0GmzmVe5vgIcym8vGpTxU0Yy+WwKiZdBnNAY75oZ8JevKkzfXgsZLVgPLGmsvUvyXg9LGM3jsn3QkmP7jyrZXdmr7tPsaov7ZPPIG8J5ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=p5sJJ7EK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AIMn9e025707;
	Tue, 11 Mar 2025 06:27:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QQOm2TJMzUkv3Gh8QuCD4FHCFI2rJTjOjtMeIcjCmKk=; b=p5sJJ7EKS0d2Gs7I
	Jt8tNz+BntOP0Bgwt4PJo34SP6AaoHb3ylT4Y61vmQbRjEYCR3C6ZJIiTOkU1iZA
	t1okDFhS5BQACGFGvk329cbo71Adf1tV4OOyzwu6hgny6swX8A1hPSUm4Q/5Cl4v
	+SZGj4vKCtQwy8lW3nrcgvJvg7anjJ2iWTk5NMEBMOzmFkBPHi4Rnsd6fDinbwa1
	3aJssEftCdMtg4bpYgDB+ItXCOf8pUjz9Mu595RXXQOA1m6KQ4UpM0AOcKvDn+bF
	nTwCr6BN1YoFkYuQnfQ6H1KIdYNb+KT8aaAr8sViVKkwcgmzEE65WeN3RYQ7en3S
	DJ4uuw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458ewk7bkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 06:27:23 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52B6RMSQ025635
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 06:27:22 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 10 Mar 2025 23:27:20 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next v4 05/11] wifi: cfg80211: extend statistics for link level in sinfo
Date: Tue, 11 Mar 2025 11:56:48 +0530
Message-ID: <20250311062654.1407532-6-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250311062654.1407532-1-quic_sarishar@quicinc.com>
References: <20250311062654.1407532-1-quic_sarishar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=Tr8chCXh c=1 sm=1 tr=0 ts=67cfd7cb cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=SwNc09q8ckjM_n_EI2QA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: u-sbnkESMGUdKtDS6zAA5QnqnC7NuwvS
X-Proofpoint-ORIG-GUID: u-sbnkESMGUdKtDS6zAA5QnqnC7NuwvS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_01,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 mlxscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503110042

Currently, statistics is supported at deflink( or one of the links)
level for station. This has problems when applied to multi-link(ML)
connections.

Hence, add changes to support link level statistics in sinfo structure.
Additionally, remove mlo_params_valid from the sinfo structure and
add valid_links to indicate bitmap of valid links for MLO.

This will be helpful to check the link related statistics during MLO.

The statistics will be embedded into NL message as below:
For MLO:
cmd ->
    NL80211_ATTR_IFINDEX
    NL80211_ATTR_MAC
    NL80211_ATTR_GENERATION
    .......etc
    NL80211_ATTR_STA_INFO | nested
        NL80211_STA_INFO_CONNECTED_TIME,
        NL80211_STA_INFO_STA_FLAGS,
        ........etc
    NL80211_ATTR_MLO_LINK_ID,
    NL80211_ATTR_MLD_ADDR,
    NL80211_ATTR_MLO_LINKS | nested
        link_id-1 | nested
            NL80211_ATTR_MLO_LINK_ID,
            NL80211_ATTR_MAC,
            NL80211_ATTR_STA_INFO | nested
                NL80211_STA_INFO_RX_BYTES,
                NL80211_STA_INFO_TX_BYTES,
               ..........etc.
        link_id-2 | nested
            NL80211_ATTR_MLO_LINK_ID,
            NL80211_ATTR_MAC,
            NL80211_ATTR_STA_INFO | nested
                NL80211_STA_INFO_RX_BYTES,
                NL80211_STA_INFO_TX_BYTES,
                .........etc
For non-ML:
cmd->
    NL80211_ATTR_IFINDEX
    NL80211_ATTR_MAC
    NL80211_ATTR_GENERATION
    ....etc
    NL80211_ATTR_STA_INFO | nested
        NL80211_STA_INFO_CONNECTED_TIME,
        NL80211_STA_INFO_STA_FLAGS,
        NL80211_STA_INFO_RX_BYTES,
        NL80211_STA_INFO_TX_BYTES,
        .........etc

The output of iw dev wlan0 station dump for MLO will look like below:

Station 00:03:7f:04:31:78 (on wlan0)
    authorized:     yes
    authenticated:  yes
    associated:     yes
    preamble:       long
    WMM/WME:        yes
    MFP:            yes
    TDLS peer:      no
    connected time: 383 seconds
    associated at [boottime]:       93.740s
    associated at:  93685 ms
    current time:   340046 ms
    MLD address: 00:03:7f:04:31:78
    Link 0:
        Address: 00:03:7f:04:31:78
        inactive time:  330120 ms
        rx bytes:       116
        rx packets:     3
        tx bytes:       0
        tx packets:     0
        tx retries:     0
        tx failed:      0
        rx drop misc:   0
        signal:         -95 dBm
        tx bitrate:     6.0 MBit/s
        tx duration:    2669 us
        rx duration:    0 us
        DTIM period:    2
        beacon interval:100
    Link 1:
        Address: 00:03:7f:04:31:79
        inactive time:  81268 ms
        rx bytes:       1323
        rx packets:     12
        tx bytes:       1538
        tx packets:     8
        tx retries:     0
        tx failed:      0
        rx drop misc:   0
        signal:         -95 dBm
        tx bitrate:     6.0 MBit/s
        tx duration:    2669 us
        rx bitrate:     6.0 MBit/s
        rx duration:    0 us
        DTIM period:    2
        beacon interval:100

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 include/net/cfg80211.h | 20 +++++++-----
 net/wireless/nl80211.c | 74 +++++++++++++++++++++++++++++++++---------
 2 files changed, 69 insertions(+), 25 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index a198b6ee0629..a7f7bfbc87f3 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2158,11 +2158,6 @@ struct link_station_info {
  * @local_pm: local mesh STA power save mode
  * @peer_pm: peer mesh STA power save mode
  * @nonpeer_pm: non-peer mesh STA power save mode
- * @mlo_params_valid: Indicates @assoc_link_id and @mld_addr fields are filled
- *	by driver. Drivers use this only in cfg80211_new_sta() calls when AP
- *	MLD's MLME/SME is offload to driver. Drivers won't fill this
- *	information in cfg80211_del_sta_sinfo(), get_station() and
- *	dump_station() callbacks.
  * @assoc_link_id: Indicates MLO link ID of the AP, with which the station
  *	completed (re)association. This information filled for both MLO
  *	and non-MLO STA connections when the AP affiliated with an MLD.
@@ -2176,6 +2171,9 @@ struct link_station_info {
  *	dump_station() callbacks. User space needs this information to determine
  *	the accepted and rejected affiliated links of the connected station.
  * @assoc_resp_ies_len: Length of @assoc_resp_ies buffer in octets.
+ * @valid_links: bitmap of valid links, or 0 for non-MLO. Drivers fill this
+ *	information in cfg80211_new_sta(), cfg80211_del_sta_sinfo(),
+ *	get_station() and dump_station() callbacks.
  * @links: reference to Link sta entries for MLO STA. For non-MLO STA
  *	and case where the driver offload link decisions and do not provide
  *	per-link statistics, all link specific information is accessed
@@ -2203,12 +2201,12 @@ struct station_info {
 	enum nl80211_mesh_power_mode peer_pm;
 	enum nl80211_mesh_power_mode nonpeer_pm;
 
-	bool mlo_params_valid;
 	u8 assoc_link_id;
 	u8 mld_addr[ETH_ALEN] __aligned(2);
 	const u8 *assoc_resp_ies;
 	size_t assoc_resp_ies_len;
 
+	u16 valid_links;
 	/* TODO: Need to check and add protection access to links memory */
 	struct link_station_info *links[IEEE80211_MLD_MAX_NUM_LINKS];
 };
@@ -8506,9 +8504,13 @@ int cfg80211_sinfo_alloc_tid_stats(struct link_station_info *sinfo, gfp_t gfp);
  */
 static inline void cfg80211_sinfo_release_content(struct station_info *sinfo)
 {
-	if (sinfo->links[0]) {
-		kfree(sinfo->links[0]->pertid);
-		kfree(sinfo->links[0]);
+	int link_id;
+
+	for_each_valid_link(sinfo, link_id) {
+		if (sinfo->links[link_id]) {
+			kfree(sinfo->links[link_id]->pertid);
+			kfree(sinfo->links[link_id]);
+		}
 	}
 }
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 1f51b295c958..619427513361 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6867,8 +6867,9 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 				const u8 *mac_addr, struct station_info *sinfo)
 {
 	void *hdr;
-	struct nlattr *sinfoattr;
-	struct link_station_info *link_sinfo = sinfo->links[0];
+	struct nlattr *sinfoattr, *link_sinfoattr, *links, *link;
+	struct link_station_info *link_sinfo;
+	int link_id;
 
 	hdr = nl80211hdr_put(msg, portid, seq, flags, cmd);
 	if (!hdr) {
@@ -6905,22 +6906,16 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 		    &sinfo->sta_flags))
 		goto nla_put_failure;
 
-	if (link_sinfo && nl80211_fill_link_station(msg, rdev, link_sinfo))
-		goto nla_put_failure;
-
-	nla_nest_end(msg, sinfoattr);
-
-	if (sinfo->assoc_req_ies_len &&
-	    nla_put(msg, NL80211_ATTR_IE, sinfo->assoc_req_ies_len,
-		    sinfo->assoc_req_ies))
-		goto nla_put_failure;
+	if (sinfo->valid_links) {
+		/* TODO: Add accumulated stats for packets, bytes for
+		 *	 better representation at MLO level.
+		 */
 
-	if (sinfo->assoc_resp_ies_len &&
-	    nla_put(msg, NL80211_ATTR_RESP_IE, sinfo->assoc_resp_ies_len,
-		    sinfo->assoc_resp_ies))
-		goto nla_put_failure;
+		/* Closing nested STA_INFO as MLO links ATTR should not
+		 * be in nested STA_INFO
+		 */
+		nla_nest_end(msg, sinfoattr);
 
-	if (sinfo->mlo_params_valid) {
 		if (nla_put_u8(msg, NL80211_ATTR_MLO_LINK_ID,
 			       sinfo->assoc_link_id))
 			goto nla_put_failure;
@@ -6929,8 +6924,55 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 		    nla_put(msg, NL80211_ATTR_MLD_ADDR, ETH_ALEN,
 			    sinfo->mld_addr))
 			goto nla_put_failure;
+
+		links = nla_nest_start(msg, NL80211_ATTR_MLO_LINKS);
+		if (!links)
+			goto nla_put_failure;
+
+		for_each_valid_link(sinfo, link_id) {
+			link_sinfo = sinfo->links[link_id];
+			link = nla_nest_start(msg, link_id + 1);
+			if (!link)
+				goto nla_put_failure;
+
+			if (nla_put_u8(msg, NL80211_ATTR_MLO_LINK_ID,
+				       link_id))
+				goto nla_put_failure;
+
+			if (link_sinfo && !is_zero_ether_addr(link_sinfo->addr) &&
+			    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN,
+				    link_sinfo->addr))
+				goto nla_put_failure;
+
+			link_sinfoattr = nla_nest_start_noflag(msg, NL80211_ATTR_STA_INFO);
+			if (!link_sinfoattr)
+				goto nla_put_failure;
+
+			if (link_sinfo && nl80211_fill_link_station(msg, rdev, link_sinfo))
+				goto nla_put_failure;
+
+			nla_nest_end(msg, link_sinfoattr);
+			nla_nest_end(msg, link);
+		}
+		nla_nest_end(msg, links);
+	} else {
+		link_sinfo = sinfo->links[0];
+		if (link_sinfo && nl80211_fill_link_station(msg, rdev, link_sinfo))
+			goto nla_put_failure;
+
+		nla_nest_end(msg, sinfoattr);
 	}
 
+	if (sinfo->assoc_req_ies_len &&
+	    nla_put(msg, NL80211_ATTR_IE, sinfo->assoc_req_ies_len,
+		    sinfo->assoc_req_ies))
+		goto nla_put_failure;
+
+	if (sinfo->assoc_resp_ies_len &&
+	    nla_put(msg, NL80211_ATTR_RESP_IE, sinfo->assoc_resp_ies_len,
+		    sinfo->assoc_resp_ies))
+		goto nla_put_failure;
+
 	cfg80211_sinfo_release_content(sinfo);
 	genlmsg_end(msg, hdr);
 	return 0;
-- 
2.34.1


