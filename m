Return-Path: <linux-wireless+bounces-9353-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 263C0911A55
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 07:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEBB11F22298
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 05:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6D912C81D;
	Fri, 21 Jun 2024 05:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VNJ5WxVB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAA163A
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 05:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718947615; cv=none; b=MG0wgEBXByfjfVaL66mN9b4RQ24u8IfTatLoJ7q99viUEcTJs8nPDL44psZrI9Pf/o7WAp7y985D/AqsCZJSK59AfW+xthIJpL6fqEzqnnbkhL0xG85Z1iQHYlwDWNzIzs6CxoeV4qNVvlbYlIWDDMd7mlUn/O9sr0ZMnzRwoj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718947615; c=relaxed/simple;
	bh=f0BwmdRG72mRTc7MOmSmRvAAXWFLH4DvmmlrLg0mz8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=n5c7nnUfVrxn2DWqaVkWChCIhIi4o3leiAeu8hHRU4FXbnKra1VY21+5nvNLzvPG7JJMjkJTMY6Cu4TlXRjE3+K+fQ3E3m2zb34VUBy682qnMRuXW5W5ORgCszwWCagYLs7cjfVH+JOyWb8mYY065E9qrcxfNFNjl/mpsFoYBNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VNJ5WxVB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KHC42j013885;
	Fri, 21 Jun 2024 05:26:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tbvxEEmrf1WUVKjVz0HBTxc9t3fYIPzHdn1Hn+ZaVOs=; b=VNJ5WxVBzpN1dvE6
	K+YYkXxzcCYO5Z3KCwalS/+BE55gnuzbG7k4XoWYfW6Ge6iJ8eu3ZthekjRovz83
	KU9PzIvfdc/O4BTB8+cjXl1ZBjpGpcMANHZUj+utPZXWBE4OnOxdxHnyupi1uvCY
	e8wBqFt0gLqRSxA0sk9nYVVrPo9c4GQvLqXRvRG98DzW35lynlwE2rAABbqpHPW9
	IqnzewhUEgVvLLnhr1g70/Wso5G0GDZN/KqDMpl7bzmVJt3SXt9Dbc/C5CmXaHVh
	DtJF8p/tNcCPmluVmuvSbTo+Gq0RH31tGcVXCy2RITSW2nm5KVLvFiwZYLeojgEp
	9c4Aqg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yvrm7scv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 05:26:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45L5Qh6v021871
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 05:26:43 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 20 Jun
 2024 22:26:42 -0700
Message-ID: <778a1696-bc91-46f7-93c9-67c4d3e93788@quicinc.com>
Date: Fri, 21 Jun 2024 13:26:41 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] wifi: ath12k: add WoW net-detect functionality
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240530072714.25671-1-quic_bqiang@quicinc.com>
 <20240530072714.25671-5-quic_bqiang@quicinc.com> <87le2zkgxv.fsf@kernel.org>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <87le2zkgxv.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _E5FtySxWrTdcyiRd0jITcS7wWeerI6J
X-Proofpoint-GUID: _E5FtySxWrTdcyiRd0jITcS7wWeerI6J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_12,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406210038



On 6/20/2024 7:10 PM, Kalle Valo wrote:
> Baochen Qiang <quic_bqiang@quicinc.com> writes:
> 
>> Implement net-detect feature by setting flag
>> WIPHY_WOWLAN_NET_DETECT if firmware supports this
>> feature. Driver sets the related PNO configuration
>> to firmware before entering WoW and firmware then
>> scans periodically and wakes up host if a specific
>> SSID is found.
>>
>> Note that firmware crashes if we enable it for both
>> P2P vdev and station vdev simultaneously because
>> firmware can only support one vdev at a time. Since
>> there is rare scenario for a P2P vdev to do net-detect,
>> skip it for P2P vdevs.
>>
>> Tested-on: WCN7850 hw2.0 PCI
>> WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
>>
>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> 
> [...]
> 
>> +struct wmi_wow_nlo_config_cmd {
>> +	__le32 tlv_header;
>> +	__le32 flags;
>> +	__le32 vdev_id;
>> +	__le32 fast_scan_max_cycles;
>> +	__le32 active_dwell_time;
>> +	__le32 passive_dwell_time;
>> +	__le32 probe_bundle_size;
>> +
>> +	/* ART = IRT */
>> +	__le32 rest_time;
> 
> What's ART and IRT in this context? The comments are supposed to answer
> to questions but this is just adding more questions.
> 
>> +
>> +	/* Max value that can be reached after SBM */
>> +	__le32 max_rest_time;
> 
> It's good to avoid acronyms so I changed this to:
> 
> 	/* max value that can be reached after scan_backoff_multiplier */
> 	__le32 max_rest_time;
> 
>> +	/* SBM */
>> +	__le32 scan_backoff_multiplier;
>> +
>> +	/* SCBM */
>> +	__le32 fast_scan_period;
> 
> These two comments are not really providing any extra information I
> removed them.
> 
>> +static int
>> +ath12k_wow_pno_check_and_convert(struct ath12k *ar, u32 vdev_id,
>> +				 const struct cfg80211_sched_scan_request *nd_config,
>> +				 struct wmi_pno_scan_req_arg *pno)
>> +{
>> +	int i, j;
>> +	u8 ssid_len;
>> +
>> +	pno->enable = 1;
>> +	pno->vdev_id = vdev_id;
>> +	pno->uc_networks_count = nd_config->n_match_sets;
>> +
>> +	if (!pno->uc_networks_count ||
>> +	    pno->uc_networks_count > WMI_PNO_MAX_SUPP_NETWORKS)
>> +		return -EINVAL;
>> +
>> +	if (nd_config->n_channels > WMI_PNO_MAX_NETW_CHANNELS_EX)
>> +		return -EINVAL;
>> +
>> +	/* Filling per profile params */
>> +	for (i = 0; i < pno->uc_networks_count; i++) {
>> +		ssid_len = nd_config->match_sets[i].ssid.ssid_len;
>> +
>> +		if (ssid_len == 0 || ssid_len > 32)
>> +			return -EINVAL;
>> +
>> +		pno->a_networks[i].ssid.ssid_len = ssid_len;
>> +
>> +		memcpy(pno->a_networks[i].ssid.ssid,
>> +		       nd_config->match_sets[i].ssid.ssid,
>> +		       ssid_len);
>> +		pno->a_networks[i].authentication = 0;
>> +		pno->a_networks[i].encryption     = 0;
>> +		pno->a_networks[i].bcast_nw_type  = 0;
>> +
>> +		/* Copying list of valid channel into request */
>> +		pno->a_networks[i].channel_count = nd_config->n_channels;
>> +		pno->a_networks[i].rssi_threshold = nd_config->match_sets[i].rssi_thold;
>> +
>> +		for (j = 0; j < nd_config->n_channels; j++) {
>> +			pno->a_networks[i].channels[j] =
>> +					nd_config->channels[j]->center_freq;
>> +		}
>> +	}
>> +
>> +	/* set scan to passive if no SSIDs are specified in the request */
>> +	if (nd_config->n_ssids == 0)
>> +		pno->do_passive_scan = true;
>> +	else
>> +		pno->do_passive_scan = false;
>> +
>> +	for (i = 0; i < nd_config->n_ssids; i++) {
>> +		j = 0;
>> +		while (j < pno->uc_networks_count) {
>> +			if (pno->a_networks[j].ssid.ssid_len ==
>> +				nd_config->ssids[i].ssid_len &&
>> +			    !memcmp(pno->a_networks[j].ssid.ssid,
>> +				    nd_config->ssids[i].ssid,
>> +				    pno->a_networks[j].ssid.ssid_len)) {
>> +				pno->a_networks[j].bcast_nw_type = BCAST_HIDDEN;
>> +				break;
>> +			}
>> +			j++;
>> +		}
>> +	}
> 
> The while loop is just a simple for loop so I changed it to use for statement.
> 
>> +
>> +	if (nd_config->n_scan_plans == 2) {
>> +		pno->fast_scan_period = nd_config->scan_plans[0].interval * MSEC_PER_SEC;
>> +		pno->fast_scan_max_cycles = nd_config->scan_plans[0].iterations;
>> +		pno->slow_scan_period =
>> +			nd_config->scan_plans[1].interval * MSEC_PER_SEC;
>> +	} else if (nd_config->n_scan_plans == 1) {
>> +		pno->fast_scan_period = nd_config->scan_plans[0].interval * MSEC_PER_SEC;
>> +		pno->fast_scan_max_cycles = 1;
>> +		pno->slow_scan_period = nd_config->scan_plans[0].interval * MSEC_PER_SEC;
>> +	} else {
>> +		ath12k_warn(ar->ab, "Invalid number of scan plans %d !!",
>> +			    nd_config->n_scan_plans);
>> +	}
> 
> I cleaned up the error message here.
> 
>> +static int ath12k_wow_vdev_clean_nlo(struct ath12k *ar, u32 vdev_id)
>> +{
>> +	int ret = 0;
>> +
>> +	if (ar->nlo_enabled) {
>> +		struct wmi_pno_scan_req_arg *pno =
>> +			kzalloc(sizeof(*pno), GFP_KERNEL);
>> +		if (!pno)
>> +			return -ENOMEM;
>> +
>> +		pno->enable = 0;
>> +		ar->nlo_enabled = false;
>> +		ret = ath12k_wmi_wow_config_pno(ar, vdev_id, pno);
>> +		kfree(pno);
>> +	}
>> +
>> +	return ret;
>> +}
> 
> Avoid initialising ret variables and minimise the indentation. I changed
> this to:
> 
> static int ath12k_wow_vdev_clean_nlo(struct ath12k *ar, u32 vdev_id)
> {
> 	struct wmi_pno_scan_req_arg *pno;
> 	int ret;
> 
> 	if (!ar->nlo_enabled)
> 		return 0;
> 
> 	pno = kzalloc(sizeof(*pno), GFP_KERNEL);
> 	if (!pno)
> 		return -ENOMEM;
> 
> 	pno->enable = 0;
> 	ret = ath12k_wmi_wow_config_pno(ar, vdev_id, pno);
> 	if (ret) {
> 		ath12k_warn(ar->ab, "failed to disable PNO: %d", ret);
> 		goto out;
> 	}
> 
> 	ar->nlo_enabled = false;
> 
> out:
> 	kfree(pno);
> 	return ret;
> }
> 
>> +static int ath12k_wow_vif_clean_nlo(struct ath12k_vif *arvif)
>> +{
>> +	struct ath12k *ar = arvif->ar;
>> +	int ret = 0;
>> +
>> +	switch (arvif->vdev_type) {
>> +	case WMI_VDEV_TYPE_STA:
>> +		ret = ath12k_wow_vdev_clean_nlo(ar, arvif->vdev_id);
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +	return ret;
>> +}
> 
> ret variable is not really needed:
> 
> static int ath12k_wow_vif_clean_nlo(struct ath12k_vif *arvif)
> {
> 	struct ath12k *ar = arvif->ar;
> 
> 	switch (arvif->vdev_type) {
> 	case WMI_VDEV_TYPE_STA:
> 		return ath12k_wow_vdev_clean_nlo(ar, arvif->vdev_id);
> 	default:
> 		return 0;
> 	}
> }
> 
> In the pending branch I did also some minor cosmetic changes to this and
> earlier patches, too many to list here.
Thanks. All these changes look OK to me.

> 

