Return-Path: <linux-wireless+bounces-28558-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AAAC33CE7
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 03:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F249518C17DA
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 02:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B32D246793;
	Wed,  5 Nov 2025 02:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HoSWexWG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a7wKuTwr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB6423BF9F
	for <linux-wireless@vger.kernel.org>; Wed,  5 Nov 2025 02:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762310992; cv=none; b=D9pAUXIUNhD0uZG5z1ANggwmtL7K603l7fcpb+nVdGiGZJsPzz84xXajCnAXqJgGfzAPHU9w+eze4t7bzroprvhzguZcm7MZk21Fdcg4M0hUxs20chd86k0/iN0TYYddS+ivBM54mP5KTuIjEnldim7okmovqdRXbctePsnKQ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762310992; c=relaxed/simple;
	bh=bdA5YaMWZUGOajbWkqFMXdVrbQu94SDAD8I7zKtcZ/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y/MwkgoFCShWu779QuH9EUKB03z+MQNnBXKHkTKtURqLLC0kAUXe541IZEGEmWol1oRnv89TCeoTCTG8WfaBG0Lfw/dXbjq2UXYeGpZu1eJ+jzNbaeXeHpajOWvMn5U326BOHgUz/zO4AAPCvfwTVj0r8Z+hnACXsdghsQJwPQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HoSWexWG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a7wKuTwr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4Kg2FU2904473
	for <linux-wireless@vger.kernel.org>; Wed, 5 Nov 2025 02:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z6fE25BWx2cqViq02OoeLjnc0qT5FrD3WFYx473CdTs=; b=HoSWexWGizap5AgJ
	FqZzHP/6i/annH3353tKGyBFj4mEZrJd9lUr/AXkC7ejnKlYtxBBWno+96D862ES
	onQVPEOM1Dp9QQqnzCFiKH4IA53nR4BUOyf6iqfF+hynL5IkmOIyXM1wEhgAqW54
	JNHiy5HW5+OPFudGFs9G2xOe1VYy9Jqf5ogvlesvqIBOFGKmWyaml9BVdigGw97g
	E8DmIHGCXRTlhETVaicc7fDCCbrjvLjRsfHhCDU6uIAQn8K74atfo/1lGCuLQyzJ
	g0+5rk6HG+VvJAjr6xnw/tHCj5kgPcBwVerFmKaINmBnT2mL4p5mfxNX5Flx+Fy3
	k8gzvw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7mbbsted-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 05 Nov 2025 02:49:50 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-295592eb5dbso42879345ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 04 Nov 2025 18:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762310990; x=1762915790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z6fE25BWx2cqViq02OoeLjnc0qT5FrD3WFYx473CdTs=;
        b=a7wKuTwrmVGcNDbL2Fp9JkQZtjeRX9k1ob7KA3VDghDDQV7xmqBkTMk8Amivax4j+t
         z1r8neJOg2fnTiYgrVs2rmm+ORChFd7qxnwIY6Snr1wHr9ICF3snUrUPViRhmkLcWxuv
         LCVrluDHIRpA5Q/Fuq43wV80u4eGD8h3H0K5vL5s8yoHWWl1GXnPJyPbywYbpuwfdlNM
         RJxbeKRMwU7ndR+Xx+4dyjGHR7vrZjQvCRq0wtTCKQ+pZMYFYdhbF7wtx2uStSZwMiLH
         kLT6A37nfcp71ebL2LHPKIlbzv1XUHhir3VYUXgcCk75JQUN1Q3iIeFFe7JStI9lL0l4
         Mj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762310990; x=1762915790;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z6fE25BWx2cqViq02OoeLjnc0qT5FrD3WFYx473CdTs=;
        b=BHVhiYn7BiZY7TxMOUYCvOWLKWOcV6Jn2Fwm1sZArJPGOSdEHlbl+sQKOkzwoYWzmb
         RvioYMx7iWBGmoaLpPO/A7b8Wn60h36NURHoMfybwmavgJ51VSxLng3/UYyRI/2FDLJL
         gakaegIjJK7o57Xll2nDoPypJzqXo4wI0O0JN5GB4WY9mmXTlo2AEoQioqJ6l6BOeRP3
         VOvv5Y7uKmKdFCLoYg/BHm3ppmsASs/BZW/rJM6SC3SMK8XJHn7F/lBYSDfR8OmZS+yH
         xgVbtSSlBND9Bci6zseFTVMAT4vRP6bLpS1L4LrixTlqrDVVjw5tMyU6uC7oQvW9GTzc
         2WtA==
X-Forwarded-Encrypted: i=1; AJvYcCXfXdH9Oj3ePcNpbYOgFtsAlAB6jQ68pudILwBfmWR1FMQnhjOiBp7EhK+tShDvjM2IW7xeea3HD1lXZd1uAw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZY0EJLGC/qaijCHYKvqP5mPWcMAStWURjviOwGlMyjygCKniq
	j6McMU31evMpIwlxlktOjFsXHfeJz1+zDwR/uU6kWCSpHrDBMxNbSMBwpZNvvZ4qGZuoRgHgEUx
	oQ/XO+6qZGe5phUxZDJsJlhU1kMCssdphVZYzovtZ9GPYbPLlsJFyD/akj50GqCPp7zlyFw==
X-Gm-Gg: ASbGncssh8fJDKxM8y9vFkX3PmX1e7axUXRCAOvvUG3cJbFK1wK9Hkcva1bkKBl6wKC
	TQT+7//HNPjVL6oypThgal7blWl2YPZ54yhudL9475lwHzBDQ2SeSHYonOXyIppxkai6b5u+ADg
	Pk6bF+XfygxeSyas+9IfRxg+THOTO+oqHBKqZJbG+EskU79nD5ZkbCwie5A+2a4VRroeOTIDu1a
	LyCKqCTM+4QPMvrtCpJQgUyqEgSvC43Ct5tYjWZkXgVmH4dhP5gfhWyoGwC9AiszinHQlJ2o4on
	zxVH5ww/VgT0R+DbPAffpueJUrOTTHzUr4g0v/+1QA49mTsXAt+dbnor+G60zaSNE3xUQxebXLJ
	vJB0fDHgcpqVuTCSaDyh5er9VKKu9Avd7d0qINP3R1ZmZRncAYnsFRihYarx+ga7AsAT6aQg=
X-Received: by 2002:a17:903:4b4c:b0:295:275d:21d8 with SMTP id d9443c01a7336-2962abeccd8mr23192635ad.0.1762310989534;
        Tue, 04 Nov 2025 18:49:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGasOAVoajsPy00I58jgS6ERqSmLZ5TtcB7lxyBLTzzfW7p5HgyQ6OUNo/j9HPzCCXDdgYuVA==
X-Received: by 2002:a17:903:4b4c:b0:295:275d:21d8 with SMTP id d9443c01a7336-2962abeccd8mr23192405ad.0.1762310988979;
        Tue, 04 Nov 2025 18:49:48 -0800 (PST)
Received: from [10.133.33.42] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601998da3sm42602315ad.27.2025.11.04.18.49.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 18:49:48 -0800 (PST)
Message-ID: <52b34262-ed22-43a1-b6dd-cea37c33d627@oss.qualcomm.com>
Date: Wed, 5 Nov 2025 10:49:45 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2 6/6] wifi: ath11k: Register handler for CFR
 capture event
To: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>, jjohnson@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
References: <20251104162633.3007874-1-yu.zhang@oss.qualcomm.com>
 <20251104162633.3007874-7-yu.zhang@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251104162633.3007874-7-yu.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: oHMlbJW5Uzux_Ydpr82EMYFtjK8RkNF5
X-Proofpoint-GUID: oHMlbJW5Uzux_Ydpr82EMYFtjK8RkNF5
X-Authority-Analysis: v=2.4 cv=MK1tWcZl c=1 sm=1 tr=0 ts=690abb4e cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=xBSK4iqqMxX8BZ_fnuAA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDAxNiBTYWx0ZWRfX+XK/afdrS3o1
 MepOOlfHhastj65XZ90Qo3X5XnKW+KvODfKTrpA33NwGmYovAPAGI6XhQUrYfAfhFDe5I1QxHMW
 HEyEpIghfur25r8Nlkrgy1OHFXyWq/VI+/GDRccOYAUOMYYe6bRLE/TI3H27wBlZLSbMCj9NVeC
 O/UbY8g8/6Gosw0emdovuUHGguiJa4uDalnN1/MIDAwT5fG1/fO721fO3ABxtIVNtQvYehBIwBJ
 J2Iygfe96hFDECxAWknd7Hx9suaQS6b59xDG/H7cfdxa2l7YZwiOZXOnocuI0KYY7cixmA5h++X
 spXQ0XNSrTMF8XERsaJuIE+s1znQ1/sog67FxJ0P8RjU5OhItB6+PDsdnyfQ4HwlwCGlPqJYudV
 OiIySyjSElnOPMqNnemC/iQ3o+12mA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511050016



On 11/5/2025 12:26 AM, Yu Zhang(Yuriy) wrote:

> +static void ath11k_cfr_fill_hdr_info(struct ath11k *ar,
> +				     struct ath11k_csi_cfr_header *header,
> +				     struct ath11k_cfr_peer_tx_param *params)
> +{
> +	header->cfr_metadata_version = ATH11K_CFR_META_VERSION_4;
> +	header->cfr_data_version = ATH11K_CFR_DATA_VERSION_1;
> +	header->cfr_metadata_len = sizeof(struct cfr_metadata);
> +	header->chip_type = ar->ab->hw_rev;
> +	header->meta_data.status = FIELD_GET(WMI_CFR_PEER_CAPTURE_STATUS,
> +					     params->status);
> +	header->meta_data.capture_bw = params->bandwidth;
> +	header->meta_data.phy_mode = params->phy_mode;
> +	header->meta_data.prim20_chan = params->primary_20mhz_chan;
> +	header->meta_data.center_freq1 = params->band_center_freq1;
> +	header->meta_data.center_freq2 = params->band_center_freq2;
> +
> +	/* CFR capture is triggered by the ACK of a QoS Null frame:
> +	 * - 20 MHz: Legacy ACK
> +	 * - 40/80/160 MHz: DUP Legacy ACK
> +	 */

same comment as in path 5/6

> +	header->meta_data.capture_mode = params->bandwidth ?
> +		ATH11K_CFR_CAPTURE_DUP_LEGACY_ACK : ATH11K_CFR_CAPTURE_LEGACY_ACK;
> +	header->meta_data.capture_type = params->capture_method;
> +	header->meta_data.num_rx_chain = ar->num_rx_chains;
> +	header->meta_data.sts_count = params->spatial_streams;
> +	header->meta_data.timestamp = params->timestamp_us;
> +	ether_addr_copy(header->meta_data.peer_addr, params->peer_mac_addr);
> +	memcpy(header->meta_data.chain_rssi, params->chain_rssi,
> +	       sizeof(params->chain_rssi));
> +	memcpy(header->meta_data.chain_phase, params->chain_phase,
> +	       sizeof(params->chain_phase));
> +	memcpy(header->meta_data.agc_gain, params->agc_gain,
> +	       sizeof(params->agc_gain));
> +}
> +

