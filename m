Return-Path: <linux-wireless+bounces-21529-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D21A892C7
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 06:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70765189628B
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 04:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0964B214A66;
	Tue, 15 Apr 2025 04:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="E8db/KMC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3E914B945
	for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 04:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744690877; cv=none; b=Jeic+lzYwgE/2VN5ha2jHnVnHg5at39BEc9/DV3nBO5Pv+jRV6U4mQUsbrgHqRvf+qYo+J9QrtR0R28cBHaBPr4CXYrcC8HTQPOQSq4NG1r7Pc4MKygjivJpkllMdoiKLUufog6HVB6uDRl2jCt+klOrDw0mdfaAHRBOv7JPND4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744690877; c=relaxed/simple;
	bh=P33HxJ8jyMbGLZ0jZUO1te6ahtbWeXnez4abJKN+aaI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=edq0k8hUG5jDfjWW/WeM7VTZqUKW6AJTKxvYqLB5oxARBeNVvn8Kq9vYfRcKhOSmNI6YIsftvEGfMjV4+0mt03NibtcuqoEN+ZTKlYv03dxXwfjPCQWzRf6hhtxlqes9yIvTIFDWYq93Qmpt0i7A+ih1dhp9gryl/iCcvtTVIqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=E8db/KMC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F15MWR022245;
	Tue, 15 Apr 2025 04:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oY0VV/wD87YSUP8kllDZvpPM7QKtrRdwd3RKLGtxOlE=; b=E8db/KMCi1a0+rcR
	zmPl9AE90nA7JmZGNpIsrl7dV1tu7D0TGDVen5llv7YQVcOYVfp69T4Kb1SOP9hU
	iYJ+K44aWilRFSGnzjNhPxkSdM1dFDP7vcfyH/Li8tQqktqxsGibggGzsUi6pCCh
	BPO1OZZT7nI4JY8ha9ZqBV0hl22zjUp0ziRBlQYUXXgdXA556yApVjtw1rA+WRCB
	OxFOkSQ3tt78nIOdvJ+/Zj5B9mb9I9I4LHQDZIdyfnz0Lb3XvgmZKJphExR2AO15
	DgUh/gsaHa5ttf5qvOCsa5B/7opOQ9e4w1oLxGe2DzDnLsjEEXZmlQviMKO93erK
	sb5qPA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yf4veq4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 04:21:09 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53F4L93i018932
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 04:21:09 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 14 Apr 2025 21:21:07 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next v6 05/11] wifi: cfg80211: extend statistics for link level in sinfo
Date: Tue, 15 Apr 2025 09:50:24 +0530
Message-ID: <20250415042030.1246187-6-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250415042030.1246187-1-quic_sarishar@quicinc.com>
References: <20250415042030.1246187-1-quic_sarishar@quicinc.com>
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
X-Proofpoint-ORIG-GUID: bJAKLhGKAWWph1owQbJ_x2QnJZI7jrzI
X-Authority-Analysis: v=2.4 cv=IZ6HWXqa c=1 sm=1 tr=0 ts=67fddeb5 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=SwNc09q8ckjM_n_EI2QA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: bJAKLhGKAWWph1owQbJ_x2QnJZI7jrzI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504150026

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
 include/net/cfg80211.h | 20 ++++++-----
 net/wireless/nl80211.c | 76 +++++++++++++++++++++++++++++++++---------
 2 files changed, 71 insertions(+), 25 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 4275f0240631..4f7eb59ef3ee 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2172,11 +2172,6 @@ struct link_station_info {
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
@@ -2190,6 +2185,9 @@ struct link_station_info {
  *	dump_station() callbacks. User space needs this information to determine
  *	the accepted and rejected affiliated links of the connected station.
  * @assoc_resp_ies_len: Length of @assoc_resp_ies buffer in octets.
+ * @valid_links: bitmap of valid links, or 0 for non-MLO. Drivers fill this
+ *	information in cfg80211_new_sta(), cfg80211_del_sta_sinfo(),
+ *	get_station() and dump_station() callbacks.
  * @links: reference to Link sta entries for MLO STA. For non-MLO STA
  *	and case where the driver offload link decisions and do not provide
  *	per-link statistics, all link specific information is accessed
@@ -2217,12 +2215,12 @@ struct station_info {
 	enum nl80211_mesh_power_mode peer_pm;
 	enum nl80211_mesh_power_mode nonpeer_pm;
 
-	bool mlo_params_valid;
 	u8 assoc_link_id;
 	u8 mld_addr[ETH_ALEN] __aligned(2);
 	const u8 *assoc_resp_ies;
 	size_t assoc_resp_ies_len;
 
+	u16 valid_links;
 	struct link_station_info *links[IEEE80211_MLD_MAX_NUM_LINKS];
 };
 
@@ -8534,9 +8532,13 @@ int cfg80211_sinfo_alloc_tid_stats(struct link_station_info *sinfo, gfp_t gfp);
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
index 9202f6ba2aaf..4d5ed9a22fe9 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6878,8 +6878,9 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
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
@@ -6916,22 +6917,16 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
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
@@ -6940,8 +6935,57 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
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
+			link_sinfoattr =
+				nla_nest_start_noflag(msg, NL80211_ATTR_STA_INFO);
+			if (!link_sinfoattr)
+				goto nla_put_failure;
+
+			if (link_sinfo && nl80211_fill_link_station(msg, rdev,
+								    link_sinfo))
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


