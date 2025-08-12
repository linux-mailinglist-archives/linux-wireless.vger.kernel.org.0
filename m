Return-Path: <linux-wireless+bounces-26310-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A91B2260F
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 13:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 271737B771B
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 11:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A412EE261;
	Tue, 12 Aug 2025 11:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QdeowLlF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263742E62D8
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 11:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754998877; cv=none; b=DzYteYqD8yQEdqi7WaOAw3ZEcm8Dnbcfj/V5bzcx4I8D61TDV64ElPiocRCJDNUvTajLaEgwGPnPV/qkAmn8BFLwEjCUymznXjgKWoa731E/Ifm1rxwyDCEW4tHNoIxtiD+zpHy/R07C/5KNWjf+luQGWxbjI6OYPcJ2vaRiLb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754998877; c=relaxed/simple;
	bh=FSU7Z5vcwR7rTsJBdnKiVNJMGn8NbMzayj1rop2wk2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=G8mg5Npyw/LUsIJZhaT9SHh8HSQdu5kX6b8BSiPDLHXiC7SCeRRfeHLH6effna0cIalCYKXZChsTulfVzHJXQs6ijkqYBeSFlaLBhh0eWqM1rcHuvuXMJ0Txh5GkFmmUTfmtEYvIdhb+yY5kkLad5914SbmG8YBuhZV0P2Ykk4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QdeowLlF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CAvjUg003162
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 11:41:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=jL+BUz6i3Ni4prcmDmiApvyCea8cugfM8Leas4LkRfI=; b=Qd
	eowLlFQ2tQ5mj9YlwyOmzIlIiU/NTXPi+vFYaEwuqbDLBH57QzfzdQP4gJq8M4tM
	mBOHA9IpUEB5l9kxZQMLKg+PfqTnZpEYaJdC29oNOldxMs2uoY3lEG3d++Bg+HHg
	6uxwoHON88BJ5yZvLKg/q48H7Av5qBsplcQpiETS3cbF/+XjUHJ2Gg6JzS+VWig8
	zTjNYqAHgg5gBMKPYKf6XLVO/MfZlbkfM6K4NwBqc1EqUzhZW5JrK3fCFbT7DKge
	5QJejRYQp82DCWFMiE0R8nytkM7nPnbv9d9xDaQLlxPxb5ePkQgLZQXP6CVihpRz
	s5VVuke1Ra8I/Ki0W5BQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dupmr3k9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 11:41:14 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76be85bfc0aso4260019b3a.0
        for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 04:41:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754998873; x=1755603673;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jL+BUz6i3Ni4prcmDmiApvyCea8cugfM8Leas4LkRfI=;
        b=mLNQWC/4AryD2Vs2TLJTj5HBmgpUhRO5wh9TexBmtn/aIuRkz9OBMqmt0rpksVqDlw
         ZOuqRogibfqJf1jfzYWZbBsKVFI8erho6X0e4lSEiMkbDQXf4i0S7O7wwkjpRHq5/MOs
         jJSWRSnhuk9GhLkuCBjgxaySwTlDATbuQm2GkElPJdNqRqnxchf2Y0aNCEizaW7igUbR
         vaIyD23oLOUjA2/NNIZm172i639N1rclAbW5yCdJ8OmtQyt60HXg3C49Ozrh+ls8UiCN
         nYU6lRBOiV7UECUzboCWvjLxfR6Wae1mrDCE8FfkyH2O3d4JGNzlQv2TC/+Qy6nN5KKH
         a9cA==
X-Gm-Message-State: AOJu0Ywnlu16wVsLLE4RsQwKnBHWt1eMurWjkC2uTRPCaKEfCyyrcrwk
	D640+Q9TgdBPeaun1vcHcNwQLehBtvRAVxIyjAczd6lnJ7MPBNVjPbXGFZMuckbliv58OtPIQq/
	y2Scmuf540/llcglGHc5BUWOEzRviSxqah4rcE4uHjzlhbyQnUikCirF0qTzaWfSBWZumTYVg3C
	y9bQ==
X-Gm-Gg: ASbGncvD1oYjI8sIRTm+STW6g9+020KOE6i/8JHCs0uP+/lPA2l56/NpAPLg8iaF4HN
	KNWUfzxrXMOMzcS0hWeesBm26eykdwgXRAL4ClIhT2s1obBH7vcdqfrXETYUmAmGSCUKL8IQwlP
	FRmixN8w6pcUubJvacaCL+yxBnK2cPx1s6h/bVmpG1YudG5u84YhuBk6++8Iwx7tBcRSgG/xmmC
	hve6t2wDO0P5jjvZgRSjxLoSCkWLyAWsYXdjlo6ZkhS3RrsYawCY5L/ImSmHAG0/Ly/Cp8DU7Tk
	I4TJEb3t7f1s4caUQKulfvrRYFtZIfuU6/EJJujcQHdeL3WWAaV+qGS9eZCK6jNMTQk/7e+Vred
	0sYvR/3Y=
X-Received: by 2002:a05:6a00:c87:b0:76b:f2d9:c760 with SMTP id d2e1a72fcca58-76e0de1bd4cmr4636916b3a.7.1754998873253;
        Tue, 12 Aug 2025 04:41:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErzZzU+2R2i+sfq8hAQpvcezy9yJFSveGhyYncj5Fq3eZmr6ada6tWsZ18ho/Vuj01SJ+PVg==
X-Received: by 2002:a05:6a00:c87:b0:76b:f2d9:c760 with SMTP id d2e1a72fcca58-76e0de1bd4cmr4636874b3a.7.1754998872763;
        Tue, 12 Aug 2025 04:41:12 -0700 (PDT)
Received: from che-ventolnx02.qualcomm.com ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccead450sm29344061b3a.54.2025.08.12.04.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 04:41:12 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH wireless-next v2 1/2] wifi: nl80211/cfg80211: Add last_beacon_seen in station info
Date: Tue, 12 Aug 2025 17:10:28 +0530
Message-Id: <20250812114029.23538-2-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250812114029.23538-1-maharaja.kennadyrajan@oss.qualcomm.com>
References: <20250812114029.23538-1-maharaja.kennadyrajan@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=bY5rUPPB c=1 sm=1 tr=0 ts=689b285a cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=9qpAqQ5L1sTy75WFsvEA:9
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: 4EQnmDev7h9Ak7lknO6gNSzd2dKSaa4P
X-Proofpoint-ORIG-GUID: 4EQnmDev7h9Ak7lknO6gNSzd2dKSaa4P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAwMCBTYWx0ZWRfX5PhdnIsq6YP8
 WW2E/eckB2PA6eEcGJLV8DjgGTWK1NnQ6p5JIBVmVL/uo7cAeW8HpdKJX4i+8mdXt3olPevZUqj
 2TYInp3wKT26FwA18yZAmseD26o7xgYfDrtsvmmkVPKkI798hXTGBmsE9XgMnpRzaxjQLJcxSfn
 NwHldGO52B194fOEG94KCSOV+0gMOIrvRepYD8m/je/WtE5rVYbUGperAJu9khf1/YAG+cvHf26
 K6/OWTT3DlapTbGN9Gywu2WEPtcMu2Bm0VIUt1lmjX6RxJ0UApxWSCUBy7NgSWavxg8+3q2WPVR
 m68rAA9MbJ14ML4PJHrGKjeaGm5fFhLf02RjOUQ/S3TD8T4ykGVCJTtKEAxJXiAVUatjSEK0gwz
 1JqPl/h5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_06,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 clxscore=1015 phishscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090000
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

Report the time since last beacon was received for each beaconing peer to
userspace. In MLO, this information is reported per link and additionally,
it is reported at the MLD level, the timestamp of the most recently
received beacon across all affiliated links to give a unified view of
beacon reception status.

This allows applications to detect potential beacon misses and make
informed decisions.

Signed-off-by: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
---
 include/net/cfg80211.h       | 9 +++++++++
 include/uapi/linux/nl80211.h | 2 ++
 net/wireless/nl80211.c       | 3 +++
 3 files changed, 14 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 406626ff6cc8..58e0c07b0e31 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2094,6 +2094,9 @@ struct cfg80211_tid_stats {
  *	an FCS error. This counter should be incremented only when TA of the
  *	received packet with an FCS error matches the peer MAC address.
  * @addr: For MLO STA connection, filled with address of the link of station.
+ * @last_beacon_seen_msec_ago: Time (in milliseconds) since the last beacon
+ *	was received from this link of station. This is useful for
+ *	monitoring beacon reception status per link in MLO scenario.
  */
 struct link_station_info {
 	u64 filled;
@@ -2137,6 +2140,8 @@ struct link_station_info {
 	u32 fcs_err_count;
 
 	u8 addr[ETH_ALEN] __aligned(2);
+
+	u32 last_beacon_seen_msec_ago;
 };
 
 /**
@@ -2228,6 +2233,8 @@ struct link_station_info {
  *	get_station() and dump_station() callbacks.
  * @links: reference to Link sta entries for MLO STA, all link specific
  *	information is accessed through links[link_id].
+ * @last_beacon_seen_msec_ago: Time since last beacon is received in
+ *	milliseconds.
  */
 struct station_info {
 	u64 filled;
@@ -2295,6 +2302,8 @@ struct station_info {
 
 	u16 valid_links;
 	struct link_station_info *links[IEEE80211_MLD_MAX_NUM_LINKS];
+
+	u32 last_beacon_seen_msec_ago;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index d1a14f2892d9..5ad31418b4a3 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3975,6 +3975,7 @@ enum nl80211_sta_bss_param {
  *	of STA's association
  * @NL80211_STA_INFO_CONNECTED_TO_AS: set to true if STA has a path to a
  *	authentication server (u8, 0 or 1)
+ * @NL80211_STA_INFO_BEACON_SEEN_MSEC_AGO: time since last beacon is received (u32, msecs)
  * @__NL80211_STA_INFO_AFTER_LAST: internal
  * @NL80211_STA_INFO_MAX: highest possible station info attribute
  */
@@ -4023,6 +4024,7 @@ enum nl80211_sta_info {
 	NL80211_STA_INFO_AIRTIME_LINK_METRIC,
 	NL80211_STA_INFO_ASSOC_AT_BOOTTIME,
 	NL80211_STA_INFO_CONNECTED_TO_AS,
+	NL80211_STA_INFO_BEACON_SEEN_MSEC_AGO,
 
 	/* keep last */
 	__NL80211_STA_INFO_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 89519aa52893..08102cf347c9 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6963,6 +6963,8 @@ static int nl80211_fill_link_station(struct sk_buff *msg,
 	PUT_LINK_SINFO(TX_FAILED, tx_failed, u32);
 	PUT_LINK_SINFO(EXPECTED_THROUGHPUT, expected_throughput, u32);
 	PUT_LINK_SINFO(BEACON_LOSS, beacon_loss_count, u32);
+	PUT_LINK_SINFO(BEACON_SEEN_MSEC_AGO, last_beacon_seen_msec_ago,
+		       u32);
 
 	if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_BSS_PARAM)) {
 		bss_param = nla_nest_start_noflag(msg,
@@ -7161,6 +7163,7 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 	PUT_SINFO(TX_FAILED, tx_failed, u32);
 	PUT_SINFO(EXPECTED_THROUGHPUT, expected_throughput, u32);
 	PUT_SINFO(BEACON_LOSS, beacon_loss_count, u32);
+	PUT_SINFO(BEACON_SEEN_MSEC_AGO, last_beacon_seen_msec_ago, u32);
 
 	PUT_SINFO(LLID, llid, u16);
 	PUT_SINFO(PLID, plid, u16);
-- 
2.17.1


