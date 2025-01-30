Return-Path: <linux-wireless+bounces-18174-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F80A2277F
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 02:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F413163B8A
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 01:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3474A32;
	Thu, 30 Jan 2025 01:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="klnQtvdm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C254A07
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 01:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738200681; cv=none; b=t9LVxisNBilZZp4uBTzSm3YjY5h/XbNhy335uCTygAlUZnXbeq012MsPMa4gSN1gqcUnqklG/it0oR+CS+Fffz5KPcI/WCjQ4hyh2C00NN6AMUB64hEAURjpk96rDPquGUsJeOlaeSs+etqEWb/aRtgT3r49kllHY8OYyXCJbcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738200681; c=relaxed/simple;
	bh=FPS8hc0aWS7P619Hbx/Ie4TfR+sDHeAbJFxBOhnvoxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eue0Rvl18O+F7HFBj0cKvEYBxfghloMVgFTPxYITlZ1WScarAcfatrIq+4PoRJwo6R++oH3lStN7K2CLviSK/3kKDL99QH+r2CxXZQAPLTlhTX0FQLsqtFMHdEUZJi8l1tnrurmxmIM1+/GwSoUJSTO5QLUE+MOaewiucx8JlBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=klnQtvdm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TIWoOa021101
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 01:31:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eZmfgbDyRs8egvyZJaS061p9zREsNe9WuLNjZIbWswE=; b=klnQtvdmU59xccvr
	SrUkUC1rdjdcYqXfWwFmUMFpYOjDRlokxoON2e23GH4JuZ4rMhSAZh6RgANt/zRc
	f6PP+K+VKQl3G8d8N1pbTm1QJ2dYjly624PFauI8taXWo7ewJCB4P4oGtw2Dynsk
	stj5eVGPdMM8nqBbEp2VaH2GWD18IDVWc84c7ut/dVtgg1PRAjjTxllWOZWYTv+C
	VborwRDlCNlzBk5Wq6m5qE/8nOOHEOup4bnvwclyRUB5d09EcE7w9H+pfYKYvEEp
	pEVDTPd2Hhb0dwXm3jnc3egddChBSEuLPUgV/TcDI2AJmBJnEs/zijil05MeHUtE
	sHvXxw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44fsq28tyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 01:31:18 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2166a1a5cc4so5600635ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 17:31:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738200677; x=1738805477;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eZmfgbDyRs8egvyZJaS061p9zREsNe9WuLNjZIbWswE=;
        b=d78IV3u4LjtZbH5StWIojx0AszGzxNYJT8eu8SVKQwcqn0dYtfZlKDoNtnrd6MS0Op
         vup7zObmguwbDF2pC2SvzgRh1XHJBW2Capkg1EvZ3oJ93Fj+/232D5qgm/TnCaBlOO4J
         zaM2TbzapaZek19FHQgGD4wEQtrF2YErJSQ+WJo7rXx9A84XrO9agPNNtR/rK3aE0YMk
         kitX8yIAVxeciQ8Bf7D76esJZSue+6wXnzSdlsSHTtEJ2SYIV6hFlQxPu92tKOeNr/jC
         aGvOtYneYAk7BnF+kvPM8/JqdsllVgpsXsMnkxWTr7xwue8C3KAblWNVGkDtQWnlBOe5
         KMJw==
X-Gm-Message-State: AOJu0YxmKZXtuWBQdPQ23ftToMnnK5YSObb5gudvbsKbEtl4IBSSpL7y
	zUMtIW5M60pKFZAP6ViJqVZOKeFLkeIK6I8bLO3uHGb/GclXzC3cc1nCFsbS7IE9mJiar424L+p
	y70MpwQUe9Xea9UdeclG/Ui3Ij9ylksfNrXssl67XjsuM/5jcHluboM9169VDeWIgWQ==
X-Gm-Gg: ASbGncu9OVD/4hzfCI2X1UpbEqSFrRwG1uOA+Tn24TQwPhOh/x51NpAC0Kr4mfF7Opu
	Z5mIgp3h6WSNrYHWjVTkPCEokAPbAC+JP2k682sZbulIF7195/x4MkZqobC8OITf4jugJE72gzS
	Ir9wIa1bRq1HwIJaCG0GYTrwTJ23W/KBjEN453+0AZjUkSqhXVcbnPnDshanKE3PL7aK4ee5xIJ
	rcGgA2ySw0OyBtUb7F93Mp46LUC63NXIB6m6roB57nuZ5GyLsMlmNGiHKG7kCv2Q9/znhtURBlK
	NXc4Ctn5xfiFNMkpf/hdjq5Qfssqojc8TrAoEi6T1T/D6XDO/EIZzg/mXbIi5FmENlFzL365GA=
	=
X-Received: by 2002:a17:903:1cb:b0:21c:2f41:f4cd with SMTP id d9443c01a7336-21dd7dea7b3mr90736935ad.43.1738200676754;
        Wed, 29 Jan 2025 17:31:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6AhMUA9yAsx/IDznDSEsVzexyxfxifa8JcyIZuIWrA8FHp+kVcds4sP7+xkMNrjoFHWgzmQ==
X-Received: by 2002:a17:903:1cb:b0:21c:2f41:f4cd with SMTP id d9443c01a7336-21dd7dea7b3mr90736535ad.43.1738200676352;
        Wed, 29 Jan 2025 17:31:16 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de31f5cd9sm2547775ad.58.2025.01.29.17.31.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 17:31:16 -0800 (PST)
Message-ID: <904c2c6e-c21b-4718-b60e-c29c60d80aa2@oss.qualcomm.com>
Date: Wed, 29 Jan 2025 17:31:15 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] wifi: ath12k: Add Support to Parse TPC Event from
 Firmware
To: Roopni Devanathan <quic_rdevanat@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>
References: <20250128111059.1690113-1-quic_rdevanat@quicinc.com>
 <20250128111059.1690113-2-quic_rdevanat@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250128111059.1690113-2-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 6ZIstDEnBai9uT2m23X6BzVnktV_5APR
X-Proofpoint-GUID: 6ZIstDEnBai9uT2m23X6BzVnktV_5APR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_01,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 suspectscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501300009

On 1/28/2025 3:10 AM, Roopni Devanathan wrote:
...
> +struct wmi_max_reg_power_allowed_params {

this seems to be misnamed. per the wmi naming convention _params are structs
passed from firmware. you cannot pass a pointer to an array from firmware to
host, you can only pass the array contents. hence seems this is a host-only
struct and should be named _arg

> +	struct wmi_max_reg_power_fixed_params tpc_reg_pwr;
> +	s16 *reg_pwr_array;
> +};
> +
> +struct wmi_tpc_rates_array_fixed_params {
> +	__le32 rate_array_type;
> +	__le32 rate_array_len;
> +} __packed;
> +
> +struct wmi_tpc_rates_array_params {

again seems this should be _arg

> +	struct wmi_tpc_rates_array_fixed_params tpc_rates_array;
> +	s16 *rate_array;
> +};
> +
> +struct wmi_tpc_ctl_pwr_fixed_params {
> +	__le32 ctl_array_type;
> +	__le32 ctl_array_len;
> +	__le32 end_of_ctl_pwr;
> +	__le32 ctl_pwr_count;
> +	__le32 d1;
> +	__le32 d2;
> +	__le32 d3;
> +	__le32 d4;
> +} __packed;
> +
> +struct wmi_tpc_ctl_pwr_table_params {

again seems this should be _arg

> +	struct wmi_tpc_ctl_pwr_fixed_params tpc_ctl_pwr;
> +	s8 *ctl_pwr_table;
> +};
> +
> +struct wmi_tpc_stats_info {

same here

> +	u32 pdev_id;
> +	u32 event_count;
> +	u32 end_of_event;
> +	u32 tlvs_rcvd;
> +	struct wmi_max_reg_power_allowed_params max_reg_allowed_power;
> +	struct wmi_tpc_rates_array_params rates_array1;
> +	struct wmi_tpc_rates_array_params rates_array2;
> +	struct wmi_tpc_config_params tpc_config;
> +	struct wmi_tpc_ctl_pwr_table_params ctl_array;
> +};

reminder from the top of the file:
/* Naming conventions for structures:
 *
 * _cmd means that this is a firmware command sent from host to firmware.
 *
 * _event means that this is a firmware event sent from firmware to host
 *
 * _params is a structure which is embedded either into _cmd or _event (or
 * both), it is not sent individually.
 *
 * _arg is used inside the host, the firmware does not see that at all.
 */



