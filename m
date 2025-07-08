Return-Path: <linux-wireless+bounces-24936-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6068BAFCA21
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 14:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED3C07AFEA8
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 12:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134EB274651;
	Tue,  8 Jul 2025 12:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RRHZdRlx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F11238D53
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 12:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751976797; cv=none; b=kNfRk7saZjRRbgpl+o8FElG0Q1as/WEke+xagLMVjbBl8/FYqTDF2mtDiJXcv50YzCy0/cdGzjNgdIshd0hXK5DK8gQy/EWrgAJSnYizE32pqKyoPyr4khHQ6FqVcCSV91zGCINKZRBHAUBwXL2nyrG2N2NT8pPO2ITA8mpI7pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751976797; c=relaxed/simple;
	bh=N1Uu8aGcSSb4hwmX8EF6gidgYUyF8F8SgoCUF7Rfe3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WARKf1pGaNfQRBdX7ZXRl/KTMKWENi+AB5jWWoQ+pV/RG/hUKIEvj4V1ZD6ENFDbBzNpQ8bXDGR85EbFioICkmDcG5Luz2Ow6kDm5V+sG4S3G6ndaiAKk/hPlE6EOrKgTdVF7nAxQUfBISi2DHsamiaB2ipozk4ry7SvZ51gPSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RRHZdRlx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AAFcM000333;
	Tue, 8 Jul 2025 12:13:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aU0D3E8y/z9/cHZufna89AUhaI0dv4ex6Wjyijo/YuA=; b=RRHZdRlxw+oX7bXo
	DsSYDYeCz2CmWKGOKDauxUeAct/qo21Kh4917w0KLrDNN7+YHuE1Sn25EorBz7Y6
	e1BEzffZUKQ4dZBgmndgINJlaU4DLzrJH0GAQfC9TBAylW2RhssTkVs9YzosUPMH
	aSErI2yHdeeGQ0/fUMVK8C1f3SZ2TMJB+Hi368KoQa0ZhqGX/wcW0BQtZKqA1rW/
	ctp8KvKHvBl2LByUHODXFnAhPOv/9dczRoGVpwbelQnpgsLtewhNwJC9cduSSNeO
	FlprmRAgom9zhpfFFC2vXJYF0C40bcNZAfZqmX8uEuGvd0Qxz2gUxuPbiG/k7Z7b
	M/BgUg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47psrkmydb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Jul 2025 12:13:10 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 568CDA2u025376
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 8 Jul 2025 12:13:10 GMT
Received: from [10.206.97.56] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 8 Jul
 2025 05:13:08 -0700
Message-ID: <61213657-4df3-4ed5-9950-04e52be92df6@quicinc.com>
Date: Tue, 8 Jul 2025 17:43:05 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/5] wifi: nl80211: Add more NAN capabilities
To: Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
        <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250622222444.356435-1-andrei.otcheretianski@intel.com>
 <20250622222444.356435-3-andrei.otcheretianski@intel.com>
Content-Language: en-US
From: Vinay Gannevaram <quic_vganneva@quicinc.com>
In-Reply-To: <20250622222444.356435-3-andrei.otcheretianski@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ffwpoELTVAukRNLpMpfl5l7Go7zFh_X1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDEwMSBTYWx0ZWRfXyuWD/MyBiYgC
 /rYd+PrESOJEKAmcH2DRcXM+S4el+8rMf/sigAD5UPq+61FbdxReajaSzXWikthtwnwmrUCg0MA
 mS5jACei7ZJynMEbyxZo8oDTjZPuhYvbqJZ02n3qhmxE+ZoGnSihI4JBJvxl5FyK0EkW7Bg1J3A
 VRddFWY/byAghBkobE5wgbVPwDOA1VPQDJm1duAJ5UN95NJwblFJXz33nckSDZ/7X6pOXp4Uoos
 c1RulKM/CwpijcKkNYkVp8J/U/5SNnFLOyi6B1MZUYIJEKeOpm/2Am5syQ8/YqJwbXCSXFWH1W5
 iDhx+bjokJeqbHNkOzfUElw1c22mHzrk6y1i4sJUbSCOwed5tbxswGdPxJCz3JIICKHj/+sgUTX
 B2ntNdSpuCW/yQ9NLBE/tfKCBNKI/hgCvxuDD9UQtNoXA+HxgT9t2OXqpyvbFQl443a1NTiE
X-Proofpoint-GUID: ffwpoELTVAukRNLpMpfl5l7Go7zFh_X1
X-Authority-Analysis: v=2.4 cv=GtBC+l1C c=1 sm=1 tr=0 ts=686d0b56 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=QyXUC8HyAAAA:8
 a=CgGbvogpmOpHRdTH6AIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1011 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507080101


On 6/23/2025 3:54 AM, Andrei Otcheretianski wrote:
> Add better break down for NAN capabilities, as NAN has multiple optional
> features. This allows to better indicate which features are supported or
> or offloaded to the device.
>
> Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
> ---
>   include/uapi/linux/nl80211.h | 36 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)
>
> diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
> index a68c486e2083..f2d4a2007463 100644
> --- a/include/uapi/linux/nl80211.h
> +++ b/include/uapi/linux/nl80211.h
> @@ -2915,6 +2915,10 @@ enum nl80211_commands {
>    *	%NL80211_CMD_START_NAN and %NL80211_CMD_CHANGE_NAN_CONFIG.
>    *	See &enum nl80211_nan_conf_attributes for details.
>    *	This attribute is optional.
> + * @NL80211_ATTR_NAN_CAPABILITIES: Nested attribute for NAN capabilities.
> + *	This is used with %NL80211_CMD_GET_WIPHY to indicate the NAN
> + *	capabilities supported by the driver. See &enum nl80211_nan_capabilities
> + *	for details.
>    *
>    * @NUM_NL80211_ATTR: total number of nl80211_attrs available
>    * @NL80211_ATTR_MAX: highest attribute number currently defined
> @@ -3474,6 +3478,7 @@ enum nl80211_attrs {
>   	NL80211_ATTR_ASSOC_MLD_EXT_CAPA_OPS,
>   
>   	NL80211_ATTR_NAN_CONFIG,
> +	NL80211_ATTR_NAN_CAPABILITIES,
>   	/* add attributes here, update the policy in nl80211.c */
>   
>   	__NL80211_ATTR_AFTER_LAST,
> @@ -8226,4 +8231,35 @@ enum nl80211_wiphy_radio_freq_range {
>   	NL80211_WIPHY_RADIO_FREQ_ATTR_MAX = __NL80211_WIPHY_RADIO_FREQ_ATTR_LAST - 1,
>   };
>   
> +/**
> + * enum nl80211_nan_capabilities - NAN (Neighbor Aware Networking)
> + *	capabilities.
> + *
> + * @__NL80211_NAN_CAPABILITIES_INVALID: Invalid.
> + * @NL80211_NAN_CAPA_SYNC_OFFLOAD: Flag attribute indicating that
> + *	NAN synchronization offload is supported. If this capability is set,
> + *	the driver must be able to handle %NL80211_ATTR_NAN_CONFIG
> + *	attribute in the %NL80211_CMD_START_NAN (and change) command.
> + * @NL80211_NAN_CAPA_DE_OFFLOAD: Flag attribute indicating that
> + *	NAN Discovery Engine (DE) offload is supported. Drivers/devices that set
> + *	this capability must be able to handle %NL80211_CMD_ADD_NAN_FUNCTION,
> + *	%NL80211_CMD_DEL_NAN_FUNCTION and %NL80211_CMD_NAN_MATCH commands.
> + * @NL80211_NAN_CAPA_DW_NOTIF_SUPPORT: Flag attribute indicating that
> + *	the device supports notifying user space about the upcoming
> + *	discovery window (DW) using %NL80211_CMD_NAN_NEXT_DW_NOTIFICATION.

Can we add below additional capabilities also.

* @NL80211_NAN_CAPA_INSTANT_MODE_SUPPORT: Flag attribute indicating if the

  *    device supports instant mode operation for faster NAN session setup.
  * @NL80211_NAN_CAPA_6G_SUPPORT: Flag attribute indicating if the device
  *    supports NAN operation in 6 GHz band.
  * @NL80211_NAN_CAPA_HE_SUPPORT: Flag attribute indicating if the device
  *    supports 802.11ax (HE) features in NAN.
  * @NL80211_NAN_CAPA_PAIRING_SUPPORT: Flag attribute indicating if the 
device
  *    supports secure pairing over NAN.
  * @NL80211_NAN_CAPA_SET_CLUSTER_ID_SUPPORT: Flag attribute indicating 
if the
  *    device supports setting a custom cluster ID for NAN operation.
  * @NL80211_NAN_CAPA_PERIODIC_RANGING_SUPPORT: Flag attribute 
indicating if the
  *    device supports periodic ranging sessions over NAN.
  * @NL80211_NAN_CAPA_RTT_SUPPORTED_BW: (u32) Bitmask indicating supported
  *    bandwidths for RTT (ranging) over NAN.
  * @NL80211_NAN_CAPA_MAX_CONCURRENT_CLUSTERS: (u8) value to indicate 
maximum
  *    number of clusters the device can join concurrently.
  * @NL80211_NAN_CAPA_MAX_PUBLISH_SESSIONS: (u8) value to indicate 
maximum number
  *    of concurrent publish sessions supported.
  * @NL80211_NAN_CAPA_MAX_SUBSCRIBE_SESSIONS: (u8) value to indicate maximum
  *    number of concurrent subscribe sessions supported.
  * @NL80211_NAN_CAPA_MAX_MATCH_FILTER_LEN: (u16) Maximum length (in 
bytes) of an
  *    individual match filter.
  * @NL80211_NAN_CAPA_MAX_TOTAL_MATCH_FILTER_LEN: (u16) Maximum total length
  *    (in bytes) of all match filters combined across sessions.
  * @NL80211_NAN_CAPA_MAX_SSI_LEN: (u16) Maximum length (in bytes) of 
the service
  *    specific info (SSI) field.
  * @NL80211_NAN_CAPA_MAX_NDI_IFACES: (u8) Maximum number of NAN Data 
Interfaces
  *    (NDI) supported concurrently.
  * @NL80211_NAN_CAPA_MAX_NDP_SESSIONS: (u8) Maximum number of 
concurrent NAN
  *    Data Path (NDP) sessions supported.
  * @NL80211_NAN_CAPA_MAX_QUEUED_TRANSMIT_FOLLOWUP_MSGS: (u16) Maximum 
number of
  *    follow-up messages that can be queued for transmission.
  * @NL80211_NAN_CAPA_MAX_SDEA_SSI_LEN: (u16) Maximum length (in bytes) 
of the
  *    extended service specific info (SDEA SSI) field.
  * @NL80211_NAN_CAPA_MAX_SUBSCRIBE_ADDRESSES: (u8) Maximum number of 
subscribe
  *    addresses supported.
  * @NL80211_NAN_CAPA_MAX_RX_CHAINS: (u8) Maximum number of receive chains
  *    supported for NAN operation.
> + *
> + * @__NL80211_NAN_CAPABILITIES_LAST: Internal
> + * @NL80211_NAN_CAPABILITES_MAX: Highest NAN capability attribute.
> + */
> +enum nl80211_nan_capabilities {
> +	__NL80211_NAN_CAPABILITIES_INVALID,
> +
> +	NL80211_NAN_CAPA_SYNC_OFFLOAD,
> +	NL80211_NAN_CAPA_DE_OFFLOAD,
> +	NL80211_NAN_CAPA_DW_NOTIF_SUPPORT,
     NL80211_NAN_CAPA_INSTANT_MODE_SUPPORT,
     NL80211_NAN_CAPA_6G_SUPPORT,
     NL80211_NAN_CAPA_HE_SUPPORT,
     NL80211_NAN_CAPA_PAIRING_SUPPORT,
     NL80211_NAN_CAPA_SET_CLUSTER_ID_SUPPORT,
     NL80211_NAN_CAPA_PERIODIC_RANGING_SUPPORT,
     NL80211_NAN_CAPA_RTT_SUPPORTED_BW,
     NL80211_NAN_CAPA_MAX_CONCURRENT_CLUSTERS,
     NL80211_NAN_CAPA_MAX_PUBLISH_SESSIONS,
     NL80211_NAN_CAPA_MAX_SUBSCRIBE_SESSIONS,
     NL80211_NAN_CAPA_MAX_MATCH_FILTER_LEN,
     NL80211_NAN_CAPA_MAX_TOTAL_MATCH_FILTER_LEN,
     NL80211_NAN_CAPA_MAX_SSI_LEN,
     NL80211_NAN_CAPA_MAX_NDI_IFACES,
     NL80211_NAN_CAPA_MAX_NDP_SESSIONS,
     NL80211_NAN_CAPA_MAX_QUEUED_TRANSMIT_FOLLOWUP_MSGS,
     NL80211_NAN_CAPA_MAX_SDEA_SSI_LEN,
     NL80211_NAN_CAPA_MAX_SUBSCRIBE_ADDRESSES,
     NL80211_NAN_CAPA_MAX_RX_CHAINS,
> +	/* keep last */
> +	__NL80211_NAN_CAPABILITIES_LAST,
> +	NL80211_NAN_CAPABILITES_MAX = __NL80211_NAN_CAPABILITIES_LAST - 1,
> +};
> +
>   #endif /* __LINUX_NL80211_H */

