Return-Path: <linux-wireless+bounces-28557-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C498AC33CD2
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 03:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D6C418C140A
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 02:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B4B23F405;
	Wed,  5 Nov 2025 02:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y6Irj+iW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wtbe4q4+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEF42D7BF
	for <linux-wireless@vger.kernel.org>; Wed,  5 Nov 2025 02:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762310825; cv=none; b=Rad2vJTLaoUh6dEATNH7hnzY+WuNWRX3bGvau/nWvGmpQIH2F3YzQUJ0uGc5EvEqGUZK0hwjFjtjrZfkv29crl/GUQcgi8v497uu+Uf36hoCmsw/XqPS1xwp+PrPX8Cjb6ieiSJiOgurk8whAfT3FQGl4Q7L+D1AI7x8znlulDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762310825; c=relaxed/simple;
	bh=dkLYJehyR9lg3oijQsJr+ApeZ1eMMGVXQWsn/CtkOAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K05QyjdHH8Fu95qTvdEORKPTD7bgt8BYlCjENjTGHT0I/GJjqtLopg12cIVJj/71D2KZhpZ0Qzs75sJbGBHtqhXQqurihkfQ66I3Yb8LkNETrvP1nStPSjhY3fTNMvb4aOK8BTX/AAWbzEy4auqcDr7Aq78J1mqIbVumyLeWQhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y6Irj+iW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Wtbe4q4+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4Kg67S2968519
	for <linux-wireless@vger.kernel.org>; Wed, 5 Nov 2025 02:47:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xEgKxTzFP5wtiwCINthvDjzT8DEp1xPRg4SO6G8xn2c=; b=Y6Irj+iWoATxQYrG
	5Z+y9o7SE6YyPNcWVGkCzJQ0hlISPUcVdUzTQYQEQfv68RRYHxq5XC+ELN5HUZ2z
	4RToSObOufxg52mH4xH8HvoXQ6Z/Vsvd09WiPazfe+jE1/T1uHQnCcnudBnNu2kn
	9LTM6BNf1FUQ2Rk21Rg0z7WkDvxvq4b+Lt2myXhsOiCfRErf6Gknc+wGmx7HuSCw
	IIoX9LLxKfdbw8tf2avcC9EqYCg0zF0RUn6kPEV1pONE1XPfEy6hB2VBUEIaBh1J
	XEqKP1NiNgC5EbpeNf3PnNCIbjzE/gray0HDbVwQw20HyCti4z08R/FML6oMBpvq
	gYwSWQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7heajbhf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 05 Nov 2025 02:47:02 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-340ad9349b3so9646866a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 04 Nov 2025 18:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762310822; x=1762915622; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xEgKxTzFP5wtiwCINthvDjzT8DEp1xPRg4SO6G8xn2c=;
        b=Wtbe4q4+wuNJPIGCmAQiI7Hkh36EqUgqf2Dyl3WudzK4DWditiG1YHajr4ACNId+e8
         U/l6n/mm6Zdzf9s3OHCIJvCvRktVRQ+Fu5Fe/kLCEbuhvouzFokltdqgd63ebmiEK7fz
         fBrdCL3A83fyDc6nlixL/pCWiQue+ojKhsbEGesUbhHAW2E8B0yLUscwb7pmMtAX1S0f
         u1lMA9iY6vv84J84wLLt9rwU+x00O8e2d7+jniKirjz0qk1YClwHm3CJP98VWuyNJaXQ
         mNzKlkK3dJTh8xmEETvrqDS6/cRid6vpZWbts87On5Sr8rqlPxSFXQyJ19unQBxkmSXh
         mMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762310822; x=1762915622;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xEgKxTzFP5wtiwCINthvDjzT8DEp1xPRg4SO6G8xn2c=;
        b=hteIJFimrEbJAYHYzKoK7lolc55gckqltmK6Pd6KmyGphXmS+so0Dss+1Lvyipw38l
         DSah6UgldAGojShIRhhYQij7cV12UOx+kNWXDbUy7zHRXiKoM4nIWvx3F/CwC+2yQo6A
         gHkLs8zbgoLuGFadz4xKlyNkuRcDvyXxdY7Zope7t7BGAN9cv/DR1Rl/Gp6uni+LgDlW
         F2ct6cnqARFagN4D4IomsO0BTvoLwIWsnpU6MQMjvOmOvCszmjSjd+BKTCTJpgsg52Cm
         KHt2Ov3cvJtD0ouQRyhqBe6Pnt036ZWVbLrQ9J94K89ki+v6UxmcaGzjJB9PoECTzQAW
         bbGg==
X-Forwarded-Encrypted: i=1; AJvYcCVfJW99gtKcdAVB792HDU1w+ArjWbpKeBx7AJvtf1AqkGBQcf04oViRf3/TkN1e/BOB9K45elq+cJ3mnkb25A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWleBziWAmMvIK4AYT2uKLAycW7MaMSJ9bVD7/hfTzWGowa+82
	W01kfv9zhzq77srznPmEfPZVKGVKcszW8mMTB8G44lIIMccsdkPHnmAkUVSCsx7G6Y8LBf9p3Jx
	/BeZOkwLhLYYCJNh2FGsxPuS9UJ4TT3WgaTt5FirNUSbQOGYEJMxswsJX5V3G7zGEnUCpfw==
X-Gm-Gg: ASbGnctPHGHLIMNWcGDj/ZtpGsurQoZsOb9rmCFIaJsW512BhSb0+gNjFhGHP8PS6Y5
	hOuLgMKZ9s+7AyhqZg8vpOD/g2F89qy1WGxgvg1Bwti6jpldozq1/JAa9MTCLzMrATasURNuG71
	BJ4py8ttArkJEfSTyhRVppFIC8OMghJqJ6lm6HTKPIJS3eB7Ts6SaejzBpMbsuS8ELOwQa2Lm91
	iO1H+mqMbtf/IQQ6DMVTV9izWJyusVxosMAZvfI3psCvYya5a0tCExug4asuas0Cvbv9Fr2cyud
	m8t0RAB+aAtiqHaz3WQdUMltrvhkWMMWgh2NuYO8muMCY7FYTJ7So1t05MF5pL3douG8k9j7IlY
	j8+yywePUaEOCRXjDH9Ugdrw+z0kX0raUZO4YO/3UmKRKXBMbz7fnRdPrazNwcP2XvBBwSqI=
X-Received: by 2002:a17:90b:5350:b0:340:776d:f4ca with SMTP id 98e67ed59e1d1-341a6de83a1mr1783541a91.26.1762310821992;
        Tue, 04 Nov 2025 18:47:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuwMno/jN7iUuFKpQ58L3wuOLckMwb2hS/UjoC4WxCpQxVIypLOXTOb+caLCW75bcojVp0Yg==
X-Received: by 2002:a17:90b:5350:b0:340:776d:f4ca with SMTP id 98e67ed59e1d1-341a6de83a1mr1783499a91.26.1762310821509;
        Tue, 04 Nov 2025 18:47:01 -0800 (PST)
Received: from [10.133.33.42] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f942a9d9sm3829624a12.33.2025.11.04.18.46.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 18:47:01 -0800 (PST)
Message-ID: <9830e3fb-3f08-4343-bae8-07d446f86173@oss.qualcomm.com>
Date: Wed, 5 Nov 2025 10:46:55 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2 5/6] wifi: ath11k: Register DBR event handler
 for CFR data
To: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>, jjohnson@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
References: <20251104162633.3007874-1-yu.zhang@oss.qualcomm.com>
 <20251104162633.3007874-6-yu.zhang@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251104162633.3007874-6-yu.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=GekaXAXL c=1 sm=1 tr=0 ts=690abaa6 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=wcWF3zN8gqulG0AiaMQA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDAxNiBTYWx0ZWRfX6RTV6uPWa21i
 /SoAxIKuONWqw4Rfs3dtoHoOEXqXDWi+Kxq6LoQj+nKUMZ8E4fr3hvybpeyI3lKKYerdWiQersB
 3VEPIccyYfQmbHutgoB87zy6PihlzfLiK6TjXSkibvkxnyrYhS7zhEuM0phK02b18umsQxpHK/v
 2lQZqgNH6I0oBM+BP0fHkCQcUF8fQMp27jZPoyV10tmG1J/4ofwWSNCNK+MCXx8+7D3h+HnMAH5
 HXaA8wv7eMDnLpJTO7JCkq+hUnUyRCykXBILdf9ETGPDTZI839vIRu8qRvLZ3OAakGnOdS5G48Z
 zJUL4CRsyTYrkOQenuZisY9nC2WUKvMEDmB0eq+8nvl73FGVG0ITkHZkNmjzXPGSOGQHmQ0CDca
 JgVb3AGrRvEoPQaEoeT7wdB+fYg1tA==
X-Proofpoint-GUID: K4dRrbTjko1DDvUABXfONy4AKF2OKVPB
X-Proofpoint-ORIG-GUID: K4dRrbTjko1DDvUABXfONy4AKF2OKVPB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511050016



On 11/5/2025 12:26 AM, Yu Zhang(Yuriy) wrote:

> +static enum ath11k_cfr_correlate_status
> +ath11k_cfr_correlate_and_relay(struct ath11k *ar,
> +			       struct ath11k_look_up_table *lut,
> +			       u8 event_type)
> +{
> +	enum ath11k_cfr_correlate_status status;
> +	struct ath11k_cfr *cfr = &ar->cfr;
> +	u64 diff;
> +
> +	if (event_type == ATH11K_CORRELATE_TX_EVENT) {
> +		if (lut->tx_recv)
> +			cfr->cfr_dma_aborts++;
> +		cfr->tx_evt_cnt++;
> +		lut->tx_recv = true;
> +	} else if (event_type == ATH11K_CORRELATE_DBR_EVENT) {
> +		cfr->dbr_evt_cnt++;
> +		lut->dbr_recv = true;
> +	}
> +
> +	if (lut->dbr_recv && lut->tx_recv) {
> +		if (lut->dbr_ppdu_id == lut->tx_ppdu_id) {
> +			/* 64-bit counters make wraparound highly improbable,
> +			 * wraparound handling is omitted.
> +			 */

I was meaning that we need to change to the common Linux comment style which starts with
an empty line:

	/*
	 * your comments start here
	 */

> +			cfr->last_success_tstamp = lut->dbr_tstamp;
> +			if (lut->dbr_tstamp > lut->txrx_tstamp) {
> +				diff = lut->dbr_tstamp - lut->txrx_tstamp;
> +				ath11k_dbg(ar->ab, ATH11K_DBG_CFR,
> +					   "txrx event -> dbr event delay = %u ms",
> +					   jiffies_to_msecs(diff));
> +			} else if (lut->txrx_tstamp > lut->dbr_tstamp) {
> +				diff = lut->txrx_tstamp - lut->dbr_tstamp;
> +				ath11k_dbg(ar->ab, ATH11K_DBG_CFR,
> +					   "dbr event -> txrx event delay = %u ms",
> +					   jiffies_to_msecs(diff));
> +			}
> +
> +			ath11k_cfr_free_pending_dbr_events(ar);
> +
> +			cfr->release_cnt++;
> +			status = ATH11K_CORRELATE_STATUS_RELEASE;
> +		} else {
> +			/* Discard TXRX event on PPDU ID mismatch because multiple PPDUs
> +			 * may share the same DMA address due to ucode aborts.
> +			 */
> +

same here

> +			ath11k_dbg(ar->ab, ATH11K_DBG_CFR,
> +				   "Received dbr event twice for the same lut entry");
> +			lut->tx_recv = false;
> +			lut->tx_ppdu_id = 0;
> +			cfr->clear_txrx_event++;
> +			cfr->cfr_dma_aborts++;
> +			status = ATH11K_CORRELATE_STATUS_HOLD;
> +		}
> +	} else {
> +		status = ATH11K_CORRELATE_STATUS_HOLD;
> +	}
> +
> +	return status;
> +}
> +

