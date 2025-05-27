Return-Path: <linux-wireless+bounces-23440-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C268EAC4A6F
	for <lists+linux-wireless@lfdr.de>; Tue, 27 May 2025 10:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F3577A3370
	for <lists+linux-wireless@lfdr.de>; Tue, 27 May 2025 08:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03C3248F70;
	Tue, 27 May 2025 08:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lNX/Wmdv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D983A248893;
	Tue, 27 May 2025 08:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748335340; cv=none; b=Ge6KwP8Ej1UNUb57S7xQ7q0rRSOpVATZr+lTmTrcvZNA2JTDsbOs0X2JXHo7JXf9NpoctIBxae/bzK4vBI0iiOhTer9j0oIi+Ru17snLCfD+h0CdBD4lYi3jwQcgEcxBWMcyU/5mQJ4aBbmc/fPilXHnLsmmbjnjeDlbiVVfgOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748335340; c=relaxed/simple;
	bh=BAkOsZym8zgsV79PGUzMv7r6LQerpmOADTGe9fx7CFI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=M2x5Ci6FIiNHCM1FzzGLdthKCV7WopQRTYgk6Z+s4oVfKOmpSUeZjfw74W8R2gYZg4W92SLJtOwjNiFXDF+mFRmLqbeO9ndnpuUbCdTTZw088pLdQxH0oLLud0+9nUFPP1W2xyTaxK4u0jdUE5Ri+pDLS3THBrUzFqtRU41ttS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lNX/Wmdv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54R3fu46028266;
	Tue, 27 May 2025 08:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bqgKli/gnbu0vGAXAwaBYhZ0/XXUgw0Rqq6rWxgu9Ww=; b=lNX/WmdvJgKXX5bp
	JpwdVa6ULYv8DenM/tKGPp/e3c7J75WbF5F/JGoDh1DGaWuRCPNypvYkIBmLPMnz
	+Tt2wGCpaaSE2Q2stWvK1HKZPao54nz0/Y15cPWZPXVe7ZUSvsmO+ev9Uly/g15V
	wtTTMPBOYGa0nNSDaVX4NeeMR0izfyicL6xeL1dzC/YMOALm9VIK+D9xI6hgXl4U
	5rbviD9oDqi5bq1dNj91cs4bwbMErsPhZHJb82Obwx/nCB8RGRKlgtdne0fAt9Lx
	4Px0qfTAbsZIRQnQiBtUTXmzXcXI6iE1kmT9rdVDnxiJrj6D6LTiOwtsfJeLbp+W
	yhScSQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u6vjp6vu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 08:42:08 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54R8g7rd013911
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 08:42:07 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 27 May 2025 01:42:05 -0700
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Date: Tue, 27 May 2025 14:11:43 +0530
Subject: [PATCH wireless-next v2 1/3] wifi: cfg80211: Add utility API to
 get radio index from channel
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250527-mlo-dfs-acs-v2-1-92c2f37c81d9@quicinc.com>
References: <20250527-mlo-dfs-acs-v2-0-92c2f37c81d9@quicinc.com>
In-Reply-To: <20250527-mlo-dfs-acs-v2-0-92c2f37c81d9@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        "Raj
 Kumar Bhagat" <quic_rajkbhag@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=UOXdHDfy c=1 sm=1 tr=0 ts=68357ae0 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=QnIzrQ3vd9YidwGbO6EA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 9nChck4vcUDqiEdudOINcshBNdBGw_ZF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA3MCBTYWx0ZWRfXx5cre0XaKFDt
 3Q5WnTt6p+0ACr0OscRxbtTItmBAYuYM0GFveY4z7tyCywzCI7bNLdmLMWH06ITO7tE4s7uu/Y6
 F2ImFb5B2/spe2mwJ0kM7Od82WQChEFrjZPn4nQLDsjKf2PrHITPkX71NO5AiWGEIHSBEF20bja
 VXcTwJ64IOm0m6usAbYJBpGnoXg19HUIUoj5n62gS+7N/aU5TTbQMF+hB1bY4aVuITl0h7JZpnl
 ALzH7bMyoaQJId5f/63/p0ethSDNgdzcQR5qiGh5zx4yKuLqbapT22NJfJpCn6TuJg4+hHnz+LI
 8SzRAAO84C2GzBTmZ7DExtP4hXOWM95y1WZHplqM0Hm/U7osPUwM2t3WCN0UFT/PTqoRSR42yw5
 WaogqosMguKZ6n41y15ulTGUk/jOzMZtIGND+3Dz8g4BLeTyCbuaiHEjIMWK7PZGGhbPzPzq
X-Proofpoint-GUID: 9nChck4vcUDqiEdudOINcshBNdBGw_ZF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_04,2025-05-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 malwarescore=0 impostorscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505270070

From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

Add utility API cfg80211_get_radio_idx_by_chan() to retrieve the radio
index corresponding to a given channel in a multi-radio wiphy.

This utility function can be used when we want to check the radio-specific
data for a channel in a multi-radio wiphy. For example, it can help
determine the radio index required to handle a scan request. This index
can then be used to decide whether the scan can proceed without
interfering with ongoing DFS operations on another radio.

Signed-off-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Co-developed-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 include/net/cfg80211.h | 11 +++++++++++
 net/wireless/util.c    | 24 ++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index d1848dc8ec99df36592517b46d58223be9bee7e5..7719a90ab4d75045983ac8a63360fd90472cbb7d 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -9372,6 +9372,17 @@ int cfg80211_iter_combinations(struct wiphy *wiphy,
 			       void (*iter)(const struct ieee80211_iface_combination *c,
 					    void *data),
 			       void *data);
+/**
+ * cfg80211_get_radio_idx_by_chan - get the radio index by the channel
+ *
+ * @wiphy: the wiphy
+ * @chan: channel for which the supported radio index is required
+ *
+ * Return: radio index on success or a negative error code
+ */
+int cfg80211_get_radio_idx_by_chan(struct wiphy *wiphy,
+				   const struct ieee80211_channel *chan);
+
 
 /**
  * cfg80211_stop_iface - trigger interface disconnection
diff --git a/net/wireless/util.c b/net/wireless/util.c
index ed868c0f7ca8ed7a9e85e70c10a738f592eac1d6..e438f883f085b3aed0c0438d94957f08aa2c6688 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -2516,6 +2516,30 @@ int cfg80211_check_combinations(struct wiphy *wiphy,
 }
 EXPORT_SYMBOL(cfg80211_check_combinations);
 
+int cfg80211_get_radio_idx_by_chan(struct wiphy *wiphy,
+				   const struct ieee80211_channel *chan)
+{
+	const struct wiphy_radio *radio;
+	int i, j;
+	u32 freq;
+
+	if (!chan)
+		return -EINVAL;
+
+	freq = ieee80211_channel_to_khz(chan);
+	for (i = 0; i < wiphy->n_radio; i++) {
+		radio = &wiphy->radio[i];
+		for (j = 0; j < radio->n_freq_range; j++) {
+			if (freq >= radio->freq_range[j].start_freq &&
+			    freq < radio->freq_range[j].end_freq)
+				return i;
+		}
+	}
+
+	return -ENOENT;
+}
+EXPORT_SYMBOL(cfg80211_get_radio_idx_by_chan);
+
 int ieee80211_get_ratemask(struct ieee80211_supported_band *sband,
 			   const u8 *rates, unsigned int n_rates,
 			   u32 *mask)

-- 
2.34.1


