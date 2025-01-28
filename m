Return-Path: <linux-wireless+bounces-18050-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A03A2038A
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 05:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 783183A68E4
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 04:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5141CEEBE;
	Tue, 28 Jan 2025 04:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lvMcTsnc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15711B393C
	for <linux-wireless@vger.kernel.org>; Tue, 28 Jan 2025 04:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738039504; cv=none; b=V3JL8NlNZSaWNphy6WBsSmqMkPdejEvCQ6fC24Du0jIizPenc0GCZtVoLAkwzNgmCdLhchR2IizkWpceyI4967o2LjeY5n4gK8ZAOg/eJEmiUDjotlRIXusKSPvmoMubIHUQipCxxc3ez5szaB2Dc9PfTERgRNImbPbd+YM7dDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738039504; c=relaxed/simple;
	bh=ATncaKPgttUqKtSHH/hf1z8sWEqlLa9HgpCJvwGOnG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JrzoE8+iqPg2PjeY2193URo04wpPG16Cw0oQcRmGT6tFmRlgAPCfTe/aSuj+1JYmZwtEF0RTrGa32sfXS4A5aiaMfabd9z8kPkUX+qqlCGNEO7cv36vP2hoJVyKDwf8obXnGK6plMdhJ3r8GTfu4vRm0gVMqe5EURwy1Ne4Ydsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lvMcTsnc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RN8DGm000820
	for <linux-wireless@vger.kernel.org>; Tue, 28 Jan 2025 04:45:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XHvNkDqjZCrz9kfzAbAzz4NEpnRiJwgy1SkFRz5kXpc=; b=lvMcTsncO+ko3VgL
	gewSnk0aCnn4QpuKevBiK645+a7C3A/5FjjEyfP0v1o/lNmFtdUFwDrmHxuzEqQT
	enk2OemuzbcE2ni7Nv696p/8dBfpqdaI/UnEkZGD/Bt1lQZBhlQFIc82ZixIBOhn
	RCdbFBjFWw0P2JxbnhPnYaZl91VuGHLAXkrdvtIRh4He/gtQ2T3LnLWe/ofHPLn9
	b4Gt0Bs+/F9xnYlaQ8OT+d3Hovn/zxJra7P67Vh3ErY4iE5DyLpmj8IJHSM666TT
	DVvGfvmQ4qpPURGK79XzT6VQTp06CEfFWPFZ+aFCJcEXL5blIsCASmCiGRfk9acD
	B0J93w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ekhw0e9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 28 Jan 2025 04:45:01 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2164fad3792so88562005ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2025 20:45:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738039500; x=1738644300;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XHvNkDqjZCrz9kfzAbAzz4NEpnRiJwgy1SkFRz5kXpc=;
        b=VZG4q7DO8CAr2yLVu06lcUxKCpB6qwZaxLet5des/rvD1Y/yGbj3H6hrli1zBrZihh
         gKqY8pYidq3HRnPvIHS58j70EBoqfd+ijEjTUBSWMdLTWH+Oalol4+n6HkHsZjDPUVGx
         xgBK8jH/lP6tE0fYFuywhN7CO0bzRgJXO6zY8BAtz8WSW67K+PCj3OwB7keDJ05hGiI0
         iOTZuz6J6vNajI9xhpiGePKOKCDbapNgmqyXVgy3+CUneQyh3D8/Codu1F7jdJ33Me6U
         HjCs2A5UHqShMtUSsgK33pkbGKU2HKyNxQVzAAHI1YqOr9Uqd7FGRomBHem1+3tgOEei
         WEMw==
X-Gm-Message-State: AOJu0Yw99Ph8y3bJyNPjvy5SGOoiMmKu+apDnTGZLjqhEaDOX6hEF/3c
	10N+aZ/AZgO1QLiFwLtruHbP7seKpUjRQIjB9cZM3MAauxn+s1cHeugaEE/8kCspRnGhAodbOkr
	rWape354lOUkc3h9qMY/WiojmKow3mNUToZd/sEienOVuZoY/OzVW3SXpOJD+vFOOzQ==
X-Gm-Gg: ASbGncvSQOiK2gnggGaWkr1t/K/FEvnVWxzt5GOsqEocH78Wg6BjHzHGR3ot4jwFgqT
	94ieYJ0sc2spoAfK1S3f5oE5+ECOcr+oO+yGF48r8J4uDv9jDjmP/ad1gNYDXNpzY8IIQslgDrO
	DaMwtsT1WUrSqiyFe6+uW5VowrwMXrDctcIhlfhI8C9QFvCAzGeey0r+bYPw3nTTi3W0lnxAQGO
	ZZMYZTyRnMtrMsMJVo3HqbcDpDE9IUN1UD/1ZZ+FGSda5vJGikP03MW5hbzOEN6Pa+4uHMATGUs
	OFrVwOKGO7IvRta6p8sH+zlQwA7TUJOfUCL7Mlk=
X-Received: by 2002:a05:6a20:7349:b0:1e1:afa9:d38b with SMTP id adf61e73a8af0-1eb2145ccd8mr66197564637.8.1738039500488;
        Mon, 27 Jan 2025 20:45:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGaTFAD0E8nKrDiDsQhtizA2nj6BdBpdks4DapPR3CbaQzgrnQv0lkI+28Q4b8NU4GEsoA1vg==
X-Received: by 2002:a05:6a20:7349:b0:1e1:afa9:d38b with SMTP id adf61e73a8af0-1eb2145ccd8mr66197537637.8.1738039500037;
        Mon, 27 Jan 2025 20:45:00 -0800 (PST)
Received: from [10.152.202.18] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a76150csm8129438b3a.87.2025.01.27.20.44.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 20:44:59 -0800 (PST)
Message-ID: <c51499f4-dc6b-4d54-a6a3-fd0d81505ec8@oss.qualcomm.com>
Date: Tue, 28 Jan 2025 10:14:56 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] wifi: ath12k: Add Support to Parse TPC Event from
 Firmware
To: Roopni Devanathan <quic_rdevanat@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>
References: <20250127073255.3374341-1-quic_rdevanat@quicinc.com>
 <20250127073255.3374341-2-quic_rdevanat@quicinc.com>
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250127073255.3374341-2-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 9SKcv9TepbJ6OrDucrcfw4qqW7ViUfhN
X-Proofpoint-GUID: 9SKcv9TepbJ6OrDucrcfw4qqW7ViUfhN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_01,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501280033

On 1/27/25 13:02, Roopni Devanathan wrote:
> Parse various events and save it in local structures. Create tpc_stats
> file using debugfs to store these local structures. Create function to
> handle TPC stats read to relay the information to the user.
> 
> Command usage:
> echo 1 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/tpc_stats_type

This patch is adding tpc_stats alone. So usage of this file should be 
mentioned here instead of tpc_stats_type which is added in next patch?

[..]

> +static int ath12k_wmi_tpc_stats_subtlv_parser(struct ath12k_base *ab,
> +					      u16 tag, u16 len,
> +					      const void *ptr, void *data)
> +{
> +	struct wmi_tpc_rates_array_fixed_params *tpc_rates_array;
> +	struct wmi_max_reg_power_fixed_params *tpc_reg_pwr;
> +	struct wmi_tpc_ctl_pwr_fixed_params *tpc_ctl_pwr;
> +	struct wmi_tpc_stats_info *tpc_stats = data;
> +	struct wmi_tpc_config_params *tpc_config;
> +	int ret = 0;
> +
> +	if (!tpc_stats) {
> +		ath12k_warn(ab, "tpc stats memory unavailable\n");
> +		return -EINVAL;
> +	}
> +
> +	switch (tag) {
> +	case WMI_TAG_TPC_STATS_CONFIG_EVENT:
> +		tpc_config = (struct wmi_tpc_config_params *)ptr;
> +		memcpy(&tpc_stats->tpc_config, tpc_config,
> +		       sizeof(struct wmi_tpc_config_params));
> +		break;
> +

extra line break not needed?

> +	case WMI_TAG_TPC_STATS_REG_PWR_ALLOWED:
> +		tpc_reg_pwr = (struct wmi_max_reg_power_fixed_params *)ptr;
> +		ret = ath12k_tpc_get_reg_pwr(ab, tpc_stats, tpc_reg_pwr);
> +		break;
> +	case WMI_TAG_TPC_STATS_RATES_ARRAY:
> +		tpc_rates_array = (struct wmi_tpc_rates_array_fixed_params *)ptr;
> +		ret = ath12k_tpc_get_rate_array(ab, tpc_stats, tpc_rates_array);
> +		break;
> +

same here

> +	case WMI_TAG_TPC_STATS_CTL_PWR_TABLE_EVENT:
> +		tpc_ctl_pwr = (struct wmi_tpc_ctl_pwr_fixed_params *)ptr;
> +		ret = ath12k_tpc_get_ctl_pwr_tbl(ab, tpc_stats, tpc_ctl_pwr);
> +		break;
> +

same here

> +	default:
> +		ath12k_warn(ab,
> +			    "Received invalid tag for tpc stats in subtlvs\n");
> +		return -EINVAL;
> +	}
> +	return ret;
> +}

[..]

> +static void ath12k_process_tpc_stats(struct ath12k_base *ab,
> +				     struct sk_buff *skb)

Since this is WMI event processing function, name should have _wmi_ in it?

> +{
> +	struct ath12k_wmi_pdev_tpc_stats_event_fixed_params *fixed_param;
> +	struct wmi_tpc_stats_info *tpc_stats;

[..]

>   static void ath12k_wmi_op_rx(struct ath12k_base *ab, struct sk_buff *skb)
>   {
>   	struct wmi_cmd_hdr *cmd_hdr;
> @@ -8236,6 +8619,9 @@ static void ath12k_wmi_op_rx(struct ath12k_base *ab, struct sk_buff *skb)
>   		else
>   			ath12k_tm_wmi_event_unsegmented(ab, id, skb);
>   		break;
> +	case WMI_HALPHY_STATS_CTRL_PATH_EVENTID:
> +		ath12k_process_tpc_stats(ab, skb);
> +		break;

Can we add this above unsupported events comment? I see FTM elated event 
got missed and merged after it but okay, we can fix that later.

>   	default:
>   		ath12k_dbg(ab, ATH12K_DBG_WMI, "Unknown eventid: 0x%x\n", id);
>   		break;
> @@ -8372,6 +8758,78 @@ int ath12k_wmi_simulate_radar(struct ath12k *ar)
>   	return ath12k_wmi_send_unit_test_cmd(ar, wmi_ut, dfs_args);
>   }
>   
> +int ath12k_wmi_send_tpc_stats_request(struct ath12k *ar,
> +				      enum wmi_halphy_ctrl_path_stats_id tpc_stats_type)
> +{
> +	struct wmi_request_halphy_ctrl_path_stats_cmd_fixed_params *cmd;
> +	struct ath12k_wmi_pdev *wmi = ar->wmi;
> +	struct sk_buff *skb;
> +	struct wmi_tlv *tlv;
> +	__le32 *pdev_id;
> +	u32 buf_len;
> +	void *ptr;
> +	int ret;
> +
> +	buf_len = sizeof(*cmd) +
> +		  TLV_HDR_SIZE +
> +		  sizeof(u32) +
> +		  TLV_HDR_SIZE +
> +		  TLV_HDR_SIZE;
> +

Any specific reason each of these are split into multiple lines?

> +	skb = ath12k_wmi_alloc_skb(wmi->wmi_ab, buf_len);

[..]

> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
> index 2934d9589007..f88f6a6bb15e 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.h
> +++ b/drivers/net/wireless/ath/ath12k/wmi.h

[..]

> @@ -5896,7 +6031,9 @@ int ath12k_wmi_set_bios_geo_cmd(struct ath12k_base *ab, const u8 *pgeo_table);
>   int ath12k_wmi_send_stats_request_cmd(struct ath12k *ar, u32 stats_id,
>   				      u32 vdev_id, u32 pdev_id);
>   __le32 ath12k_wmi_tlv_hdr(u32 cmd, u32 len);
> -

keep this empty line for better code readibility?

> +int ath12k_wmi_send_tpc_stats_request(struct ath12k *ar,
> +				      enum wmi_halphy_ctrl_path_stats_id tpc_stats_type);
> +void ath12k_wmi_free_tpc_stats_mem(struct ath12k *ar);
>   static inline u32
>   ath12k_wmi_caps_ext_get_pdev_id(const struct ath12k_wmi_caps_ext_params *param)
>   {


-- 
Aditya

