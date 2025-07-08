Return-Path: <linux-wireless+bounces-24942-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A171AFCADF
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 14:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 941CF1BC6568
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 12:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79E328A407;
	Tue,  8 Jul 2025 12:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="P8uyozoe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DE517A2E0
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 12:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751978965; cv=none; b=ILQy/oEZGpicOoivmx4QhQLmnzIv194Z69rhF89mJLTXxKlX5QLncs09nEPuyn38/e7NtV85o/AQ8p02Yz+K+2NhT0wriBb+WTuJJ0QbMzZ1KcVuA0o1+e85tEJZeHY5BGbpx2vr1pjpM2agUtqGIfOCauOqMM6HOFQJ7UZ3/1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751978965; c=relaxed/simple;
	bh=Ii96zlSTi6U9mNqBZDSxvLUCxk1uSZUAFIKxXCKKhb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=i3azJwbFfFkTlounr1AiLpXsmnPB2/yikAQsn/acXIMzyKeKuETtbCcs6/X8LTAqKKOR9N/MRB5DrXTYBI0vPzoNH6ZYmw7VO+cjshPSStGsOErttSdhvWVQLTbkv91qPAEC4Vsko0NM9KbEvXKfiip2Oniex75bAp0HPgFmm9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=P8uyozoe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AAFUs008236;
	Tue, 8 Jul 2025 12:49:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qE+q6YiDFi5tgRSsZ0q7szoDXWmFjGYrVAZWa/VNd9g=; b=P8uyozoe7JVL+D0y
	j7Gf34cInlq7Ag6EJ00KUkfMSyjloavOXsVtyYLYfISDK39whxDDiYOXvE0tnQzS
	YWkXjwAgIcBImQJ+G6SpY+XaZJME9u6mpecimxb1RojmO/J43OvHWx0XWA3hdehN
	l7SLPHCs8VsQ+Kzy3TSqy+iJaBaNruJT/iaMx9YhxnF5i6WdOQNYFpHIahfAwWqj
	6Jir3t9PYBRm8P/SeSiG4DKKQp/c5X73oasR5Tupl1L3veArca9wpvH4GbkWePna
	74DpEd2w4z5ex6hpGuhm6I/MT9m243Zfjb9SIiWZejFMzM3BBF/TE6aaPX67Ml4B
	5BSFjA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pucmwswx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Jul 2025 12:49:18 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 568CnHhU020924
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 8 Jul 2025 12:49:17 GMT
Received: from [10.206.97.56] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 8 Jul
 2025 05:49:16 -0700
Message-ID: <d117e77a-39ef-4296-8f1b-41aabadf4406@quicinc.com>
Date: Tue, 8 Jul 2025 18:19:13 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/5] wifi: nl80211: Add more configuration options for NAN
 commands
To: Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
        <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250622222444.356435-1-andrei.otcheretianski@intel.com>
 <20250622222444.356435-2-andrei.otcheretianski@intel.com>
Content-Language: en-US
From: Vinay Gannevaram <quic_vganneva@quicinc.com>
In-Reply-To: <20250622222444.356435-2-andrei.otcheretianski@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=GdQXnRXL c=1 sm=1 tr=0 ts=686d13ce cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=bOKLgu7QxE6RKZFKgiMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: a1LimRhY_qVD2yQpCeoxOxCunWHjNMcc
X-Proofpoint-ORIG-GUID: a1LimRhY_qVD2yQpCeoxOxCunWHjNMcc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDEwNiBTYWx0ZWRfX+edOgcjltkmI
 xOUqYoIBzpOSpYMOGqjiAHVE0I9y1nAkD3LpmGtf+GU+ilYZJY8Or1rK0Oxj61SJnbYyvj/LwFJ
 nz+i25TjIvhj4DPokpEOTkTkEPQw8dmSy6ExVAllIPQSluMZYp/cOju49VA9DuPtJQjIf/erzO2
 cQc9R9dcxjGOP2XvtepNgOiV1d1hIS1xfBC9RVWkV7UyS77ONNAhIhHNZT1LZUFjrQd2Jis8ek+
 0ERqBa4n5OMu3jIl4iBGprAGGgRgOXpwbGGmISpe9LaGECfvn2sdvnAnwkFSr/uPwh0loNwG3M2
 5YSCGy7aSsdXmTYeWpAcRMJXxCtG65B6XUfxENaYsAb2NbjHCcBQPrOr16GuT1rtm+gt1VphbVO
 AGxntgxc8CVuBfCPLo2ukOpRTFkXhgOy6teCkm6pH1q6SYfYxasO5sI6qVvakYREVSnKjII3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 spamscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 malwarescore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080106


On 6/23/2025 3:54 AM, Andrei Otcheretianski wrote:
> + * @low_band_cfg: configuration for the low band.
> + * @high_band_cfg: configuration for the high band.
> + * @enable_scan: Flag to enable or disable scanning on 5 GHz band.
s/enable_scan/enable_hb_scan
> + * @extra_nan_attrs: pointer to additional NAN attributes.
> + * @extra_nan_attrs_len: length of the additional NAN attributes.
> + * @vendor_elems: pointer to vendor-specific elements.
> + * @vendor_elems_len: length of the vendor-specific elements.
Can you please review if the following additional parameters would be 
required for the drivers to start nan or change the config.

* @max_publish_sids_in_beacon: This indicates maximum number of service 
IDs that can be accommodated in the Service ID List attribute in a NAN 
beacon.
* @max_subscribe_sids_in_beacon: This indicates maximum number of 
service IDs that can be accommodated in the Subscribe Service ID List 
attribute in a NAN beacon.
* @hop_limit: Maximum number of hops that is allowed to join a cluster. 
Value 0 indicates no such restriction.
* @rssi_window_size: Moving average of RSSI to decide NAN role switch.
* @nss: No of TX and RX chains to be used. This can be reconfigured 
using change configs for any change in power setting.
* @enable_dw_early_termination: Flag to enable/disable early DW 
termination. The device can decide to move out of the DW before the 
dwell time if this is enabled.
>    */
>   struct cfg80211_nan_conf {
>   	u8 master_pref;
>   	u8 bands;
> +	u16 cluster_id;
> +	u16 scan_period;
> +	u16 scan_dwell_time;
> +	u16 discovery_beacon_interval;
> +	bool enable_dw_notification;
> +	struct cfg80211_nan_band_config low_band_cfg;
> +	struct cfg80211_nan_band_config high_band_cfg;
> +	bool enable_hb_scan;
> +	u8 *extra_nan_attrs;
> +	size_t extra_nan_attrs_len;
> +	u8 *vendor_elems;
> +	size_t vendor_elems_len;
u8 max_publish_sids_in_beacon;
u8 max_subscribe_sids_in_beacon;
u8 hop_limit;
u16 rssi_window_size;
u8 nss;
bool enable_dw_early_termination;
>   };
>   
>   /**
> @@ -3779,10 +3828,32 @@ struct cfg80211_nan_conf {
>    *
>    * @CFG80211_NAN_CONF_CHANGED_PREF: master preference
>    * @CFG80211_NAN_CONF_CHANGED_BANDS: operating bands
> + * @CFG80211_NAN_CONF_CHANGED_CLUSTER_ID: cluster ID
> + * @CFG80211_NAN_CONF_CHANGED_SCAN_PERIOD: scan period
> + * @CFG80211_NAN_CONF_CHANGED_SCAN_DWELL_TIME: scan dwell time

