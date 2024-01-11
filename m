Return-Path: <linux-wireless+bounces-1744-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C86EE82B3B6
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 18:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F1481F22AF5
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 17:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEFB5100A;
	Thu, 11 Jan 2024 17:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kpb4Mo67"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A44150264
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 17:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40BD0BNw002914;
	Thu, 11 Jan 2024 17:13:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=sWD84rJRLqbEtVzfWvj6R1HmffiIMEh0vfU6ueEr5bg=; b=kp
	b4Mo67HDbzgXitSvExkpYTpweUrZhBjL5ihmQA3Rde5ExixPsloVXkKU//ec8IDr
	gfJfSYb/Yb+Qw2l4jgWPNYEFvV6UwgMsFZTsk/yEpGKNjOTSx/ihRJyXJbyooxnd
	lL8TPc4DFacyNb9GlbdMkpxcB/M8W92HMVlHFZ+17XC5yXED/TdKXcjq4e+3NGm2
	RwYhBXtTYjz7+hkIFMFnKT1Ji2gfDB8OnjSyTrnrR54q47QVEiYGVxBcwgFK2YND
	PbApz4mCzFhFgWZTXwebJ1w71ht73EDASnK6cpDL6C+CM1HC9614eFXtJG67Pswj
	mbsn2bWX8FBG72y32iXg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vjgtjgka5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 17:13:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40BHDKLk006615
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 17:13:20 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 11 Jan
 2024 09:13:19 -0800
Message-ID: <93c178cd-8a16-48e5-b352-f14afab07498@quicinc.com>
Date: Thu, 11 Jan 2024 09:13:19 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 07/12] wifi: ath11k: add parse of transmit power
 envelope element
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20231218085844.2658-1-quic_bqiang@quicinc.com>
 <20231218085844.2658-8-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231218085844.2658-8-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pxOioXd6TTHEwKYU3W4pdiQHB1aYjzDL
X-Proofpoint-ORIG-GUID: pxOioXd6TTHEwKYU3W4pdiQHB1aYjzDL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=622 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401110135

On 12/18/2023 12:58 AM, Baochen Qiang wrote:
> +/**
> + * struct reg_tpc_power_info - regulatory TPC power info

Kalle,

just spotted this kernel-doc issue in the pending branch

s/reg_tpc_power_info/ath11k_reg_tpc_power_info/

can you update?

> + * @is_psd_power: is PSD power or not
> + * @eirp_power: Maximum EIRP power (dBm), valid only if power is PSD
> + * @ap_power_type: type of power (SP/LPI/VLP)
> + * @num_pwr_levels: number of power levels
> + * @reg_max: Array of maximum TX power (dBm) per PSD value
> + * @ap_constraint_power: AP constraint power (dBm)
> + * @tpe: TPE values processed from TPE IE
> + * @chan_power_info: power info to send to firmware
> + */
> +struct ath11k_reg_tpc_power_info {
> +	bool is_psd_power;
> +	u8 eirp_power;
> +	enum wmi_reg_6ghz_ap_type ap_power_type;
> +	u8 num_pwr_levels;
> +	u8 reg_max[IEEE80211_MAX_NUM_PWR_LEVEL];
> +	u8 ap_constraint_power;
> +	s8 tpe[IEEE80211_MAX_NUM_PWR_LEVEL];
> +	struct chan_power_info chan_power_info[IEEE80211_MAX_NUM_PWR_LEVEL];
> +};



