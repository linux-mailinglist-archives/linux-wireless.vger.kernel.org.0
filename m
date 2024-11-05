Return-Path: <linux-wireless+bounces-14942-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCA69BD90F
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 23:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12627283B87
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 22:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A93C2161EA;
	Tue,  5 Nov 2024 22:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Fc8ZPhJf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC4F1F8EE4
	for <linux-wireless@vger.kernel.org>; Tue,  5 Nov 2024 22:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730846973; cv=none; b=fs4+FTaUYXhEN4YIY1JD0Os/AvVimy+i1j5LB37imudnCKYy9xr5YC/lEmXFxp/VdR/sOodZUCblji97hknyyQUJQRe7M0n7O+w5I5hPmkJGoH0L0Cqt5ooU+3sjhcgYk5UoZ4lbjiFyPVoUp51Hz15MtR12BzhskM78ml2Hrts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730846973; c=relaxed/simple;
	bh=q85KXj/Svem+8de+I7mhDZKocAXqEGXolOVXUzwAqFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Tx/0IHXlHpaGflEXQIBsY0tdIBYG41zf+cdZTEAGCSDt9deUxhb+Ey8Cf3TWmFHLrPF28A2P+mllQ1dXVbIYIvrhOv78HYzEP9AAilwvvHFA6xAuXujpMD0UYoFsSf6NwbNPH+yj78hGeXva1XmoH5CwGApmq4PNv9n5/PdOoB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Fc8ZPhJf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5KBrwG023076;
	Tue, 5 Nov 2024 22:49:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HjBRuP+PO8rt0Q+N7DS31Dgoiyc9z8V/Iw9DRLB03rY=; b=Fc8ZPhJftiiAbsfc
	R+EUBK5zApynx6VIxCjtNIJ+Kswgpn+eajqQPHipCTgSC36+sRvCs16tb35sMlZ6
	o1DU/S1+KCPNmYflrKe5dMCkzZNfjiBeQTJRHqN34B9vcXpN2zkknpkF/c/epDTq
	5vsNqpcHg9WADoLA7+IXkEk2sNAW2gKnvFcWjvzA/L2lavijFXYjyMyng1wAhDHS
	jKySFrdUVGr/RhMhwsPFiLAtPxLnUt8PGjhlssgDWDBiMjsaAOsSpTN3vc2q27/q
	PSbGd7ey1az9Kp/LMTT/DWo2m54fg1v0wJeAjdLSRcnqR17y8d2SWLcMsXPWaZ9r
	dBXmjg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42nd1fs8ft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 22:49:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A5MnQHL009967
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Nov 2024 22:49:26 GMT
Received: from [10.48.242.250] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 5 Nov 2024
 14:49:26 -0800
Message-ID: <6a275d37-9aac-4bf9-936f-0272cb3737df@quicinc.com>
Date: Tue, 5 Nov 2024 14:49:25 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] wifi: ath12k: Support Downlink Pager Stats
To: Roopni Devanathan <quic_rdevanat@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>
References: <20241105045406.2098436-1-quic_rdevanat@quicinc.com>
 <20241105045406.2098436-2-quic_rdevanat@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241105045406.2098436-2-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zDOtvuSPr0p1bE7krUTLZ8FACFzW_6f6
X-Proofpoint-ORIG-GUID: zDOtvuSPr0p1bE7krUTLZ8FACFzW_6f6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 malwarescore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411050176

On 11/4/2024 8:54 PM, Roopni Devanathan wrote:
> From: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> 
> Add support to request downlink pager stats from firmware through HTT
> stats type 36. These stats give paging information like number of pages,
> their timestamp, number of locked and free pages, synchronous and
> asynchronous locked pages.

...

> +static void ath12k_htt_print_dlpager_entry(const struct ath12k_htt_pgs_info *pg_info,
> +					   int idx, char *str_buf)
> +{
> +	u32 ts_lo;
> +	u32 ts_hi;
> +	unsigned long long page_timestamp;
> +	u16 index = 0;
> +
> +	ts_lo = le32_to_cpu(pg_info->ts_lsb);
> +	ts_hi = le32_to_cpu(pg_info->ts_msb);
> +	page_timestamp = ((unsigned long long)ts_hi) << 32 | ts_lo;

use u64 and ath12k_le32hilo_to_u64(pg_info->ts_msb, pg_info->ts_lsb)?

> +
> +	index += snprintf(&str_buf[index], ATH12K_HTT_MAX_STRING_LEN - index,
> +			  "Index - %u ; Page Number - %u ; ",
> +			  idx, le32_to_cpu(pg_info->page_num));
> +	index += snprintf(&str_buf[index], ATH12K_HTT_MAX_STRING_LEN - index,
> +			  "Num of pages - %u ; Timestamp - %lluus\n",
> +			  le32_to_cpu(pg_info->num_pgs), page_timestamp);
> +}


