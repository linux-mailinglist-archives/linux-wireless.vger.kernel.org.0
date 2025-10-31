Return-Path: <linux-wireless+bounces-28426-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E32C230B4
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 03:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DC2618927AB
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 02:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F063081B5;
	Fri, 31 Oct 2025 02:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DMbdBDJy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wt6bgqZ0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223CC2C3271
	for <linux-wireless@vger.kernel.org>; Fri, 31 Oct 2025 02:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761878589; cv=none; b=MLhYO2McqSp+qeBWZziZax9rWVz/w1quKI6PABesbtnCqbHtyKn6Jzn8Pl+IX5qp0DUXZAyAb1PuxY0hnCuLYBYdh/lgmLjW9yW+s46xBDkVUbQhZX+M2U0I/GOmq6b3zL6KQdQ7CrnJkbuLIAPGyHKsapll7gZh7GtFFDhSUkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761878589; c=relaxed/simple;
	bh=3xpe/u+umBwh3iWjjLU3VUCqiNVzlIwOoLMx1RqSURI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o1GbNFfZAGKn1rGrUSbzkde5Hnptbywlv2cJSrdzYjopye+alkf08cswDXYaabTGHPpntvG392Bck0hwB4UGxYQd9qvzm2kvyrEgfsm+pPtQW6VL5RGPTJAoMHCzHhVBgjo6l3hCq7ZOohUoyY2xSJf46jk+O00ZSpgpnDslMlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DMbdBDJy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Wt6bgqZ0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59UI6H2M3115819
	for <linux-wireless@vger.kernel.org>; Fri, 31 Oct 2025 02:43:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zaaBloIJGhaoPgQ7d71zW2258dFe1LLg6EVGK/EBrpk=; b=DMbdBDJyehDD5EkG
	3NYYD9iuLX2ZZjLN7z//9yHqBW5zaf1leAY2I3+vf7LGxHr8E0igItnzHFZV1vgs
	TcBLpQuj66vCxy9Ldaqw55ktwx/8GdarNR4jBIamzDGw8dIxPYE/A3WPl0FhYy3h
	Lab3GZUPWmvmY7R0ClpqE5XqjGeHN5//qWNfmXmypiT8IncfIJE8RlG4ys3YpEfy
	HU6KgL+vsyOcMfmEUb7y54HiaDDu0UUkLvPy0VeeOncMEtMBtra7FT8VwMFGHSRF
	E/PjF4lf8YhCnkvN0BqwaeO/zfPpdRMqvN4s+Gj3xl7w4UQnMYoS31Ryd+02Q4TS
	l4TzRQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a45b42n5q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 31 Oct 2025 02:43:06 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-290e4fade70so20803195ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 19:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761878585; x=1762483385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zaaBloIJGhaoPgQ7d71zW2258dFe1LLg6EVGK/EBrpk=;
        b=Wt6bgqZ0dbdG9w7/idtIJNTFdUGlzCQUXCYWs1XVAaWrkpDiTliXTdRFLWq2gYzAlz
         Uuf1W8RAnLtpN+8mV8pAMaTe/CJw4bPwvo0bPZMi4ynfokV3a/O3n1KMDuyUIh7a/0Gj
         fk5Pf5+V/NW3XWVqrTtz6WeLgEOXlvdkW4kEGeHozDokaYiLKtgRxcwIrlzTQ3ifTpaz
         cct5huuh6V0176VX8QnAHeLlrZOgSuw+2HhVaY+fJpxHJ/lU8XzTBpfejIdAfk7yyUyU
         Utak1LKcyQEuFHMOt1GIagCwF+ujC+sswi5yVXMMSrjNqh8uFJBz6uvqLb9Bqwqy4V8h
         4O2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761878585; x=1762483385;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zaaBloIJGhaoPgQ7d71zW2258dFe1LLg6EVGK/EBrpk=;
        b=elDMv3xDkz1Rf6I23nJ2kE5lAmuZo4Xcp7v+WSBSPhGVAJTg0ePhTvw9FCDv6UoqtD
         hq01TYiHOO3aKtYDT3/xyCuPsH1B1flUI8MijkTwW3gIF5g3077sBqUUOHPWoSrTM5IM
         /twzHG8tZzsJbKmTPRjUGqulXdCsxt0uEdiy6I1A7OdggpCMFSOQLe5yvLtXabcZAGDh
         bEJmUebYA0iKPoFRR8l3Nf7sIH2WFA1wKZBcKmNsTX4UOIr9oNGMaEMMcPzZWOe+3Naj
         3hfu0Dra9VJM1flHp8GxOC7437nwPP6gyOxB8MWbe7uLev5XhfrioUcm3EBrPmmzT69z
         RlgA==
X-Forwarded-Encrypted: i=1; AJvYcCUPTawLEpRFrMSYUHPQFvKQgdbQNxYSfzo0Zz3VNN//CqmQ1ctRMgUljJaA3I6zR7OMfDtplb+3YMOXJS+RMA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfutjm69LbP9nHjirT8CMPHm6B8PoWJIMsCj92FM1DQi3I/2Cs
	6MA8/7If7zeHwqHck87xXIVzcLEZTNO/DXRQyJusyvKqODL9kcU4VtCeMqV1+SLDnn8uL7lbRcV
	kGAzTMWb4Yy/NNUPTvp7kdomvGDBE2YQA2Weya2MizmIIjRwLzZPGRbIxXgzOye5rv4JQDry/9p
	oY14Hm
X-Gm-Gg: ASbGncsqJlDAqj1e5Lm2nt54gEj4SEGgoFcgge2R5WhUvE4Yzl8IASLR8vOxkIudlk3
	M5i5iy/+PkS05telN3dBIJ4V0FeGiBrhHdQPwROQrryLv8PO2YZOvlyndpfnIyE4mGlNiJbRZNv
	Pu/aRR0x9t/xbJ4fl5couxJco0Ku6N9/hPTpfmN8unt5bApmkm19Snkz2+E/2h5qk+wVYDRHAUH
	k6hRPsQqHj4gw81uvDOMbWg2abLoDYvxknArxk27YgxThToOFqQraVX8eekU5TQE4bHU6zqJqyR
	4rJ5z2d3SrbCmCokeBLywbcIHceZ1j/PhhcIRxUYD7qjNCAXi7qXjBqAnUtk80ruGUyxrbVBohP
	QWXTzlliPYDX/uzz/RVe/MESdCJzu2BVJtWODAjkCGrgZaCNhN4ZFeORKitI5XYzH+M36oq0=
X-Received: by 2002:a17:903:41c4:b0:293:b97:c323 with SMTP id d9443c01a7336-2951a4d8a1amr22756875ad.32.1761878584942;
        Thu, 30 Oct 2025 19:43:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYAINtH87QCRpaxqVNeNSoSEV2daxmlFd7YpOAhUp+qFnEbICbCWiL3U2ZX63kl/mhI4m9tA==
X-Received: by 2002:a17:903:41c4:b0:293:b97:c323 with SMTP id d9443c01a7336-2951a4d8a1amr22756625ad.32.1761878584373;
        Thu, 30 Oct 2025 19:43:04 -0700 (PDT)
Received: from [10.133.33.51] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295268cdfcesm4592145ad.48.2025.10.30.19.43.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 19:43:04 -0700 (PDT)
Message-ID: <ba928aa0-d1d0-4e10-bfd4-ab7a577dc8c1@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 10:42:45 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 1/6] wifi: ath11k: Add initialization and
 deinitialization sequence for CFR module
To: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>, jjohnson@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
References: <20251030043150.3905086-1-yu.zhang@oss.qualcomm.com>
 <20251030043150.3905086-2-yu.zhang@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251030043150.3905086-2-yu.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDAyMiBTYWx0ZWRfX6eQTVobIbV60
 641f5ROsr0VncOm064uTVrdk1e4j8z6rpbt2thNlLXl65vJlW6TyWinMO1m1oI5r3m0O+4YXhOO
 AWlzyb7fjpVUdgiBcK3EiHhbt0q73cxa1fSSHT/HfltQkaY/jMSb9tE165DNn+i61cK3h8z3pui
 GuHuSoMsf+9nGKdBDgHznC66/NlMUMOKUAumjAoFmU5bhE+Y6MzqOESZtLeVQXJAlC3vOaEis0A
 mLGFWErz+l+VbkCqvHUE3RzLUwDsRwcf4rd3ezXErM9QmEszzQ2qXXxZW+BLR8zXH07rfQgVue3
 zkVCl6TetuzdlO4QFE1dT+T9LWP1zXO+rWbTzS5xevCzptvvJ6EklIbFHk0xm3N87CNPrgRogNq
 TUBefe/L8otGYI/d0eVDC+yTfNzjZw==
X-Authority-Analysis: v=2.4 cv=KePfcAYD c=1 sm=1 tr=0 ts=6904223a cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=d9LWlda1mWfGAY6gbx0A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: 8PU4Xk3qEk_FIuDw00YkUReq_QZZ4jNo
X-Proofpoint-GUID: 8PU4Xk3qEk_FIuDw00YkUReq_QZZ4jNo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_08,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310022



On 10/30/2025 12:31 PM, Yu Zhang(Yuriy) wrote:

> +void ath11k_cfr_deinit(struct ath11k_base *ab)
> +{
> +	struct ath11k_pdev *pdev;
> +	struct ath11k_cfr *cfr;
> +	struct ath11k *ar;
> +	int i;
> +
> +	if (!test_bit(WMI_TLV_SERVICE_CFR_CAPTURE_SUPPORT, ab->wmi_ab.svc_map) ||
> +	    !ab->hw_params.cfr_support)
> +		return;
> +
> +	for (i = 0; i <  ab->num_radios; i++) {
> +		pdev = rcu_dereference(ab->pdevs_active[i]);

_deinit() runs during driver unload etc where pdev may not be active hence issues can be
expected?

besides, pdevs_active used here but pdev used in _init() ...

IMO, we don't need pdev to be active here

> +		if (pdev && pdev->ar) {
> +			ar = ab->pdevs[i].ar;
> +			cfr = &ar->cfr;
> +
> +			ath11k_cfr_ring_free(ar);
> +
> +			spin_lock_bh(&cfr->lut_lock);
> +			kfree(cfr->lut);
> +			cfr->lut = NULL;
> +			spin_unlock_bh(&cfr->lut_lock);
> +		}
> +	}
> +}
> +
> +int ath11k_cfr_init(struct ath11k_base *ab)
> +{
> +	struct ath11k_dbring_cap db_cap;
> +	struct ath11k_cfr *cfr;
> +	u32 num_lut_entries;
> +	struct ath11k *ar;
> +	int i, ret;
> +
> +	if (!test_bit(WMI_TLV_SERVICE_CFR_CAPTURE_SUPPORT, ab->wmi_ab.svc_map) ||
> +	    !ab->hw_params.cfr_support)
> +		return 0;
> +
> +	for (i = 0; i < ab->num_radios; i++) {
> +		ar = ab->pdevs[i].ar;
> +		cfr = &ar->cfr;
> +
> +		ret = ath11k_dbring_get_cap(ar->ab, ar->pdev_idx,
> +					    WMI_DIRECT_BUF_CFR, &db_cap);
> +		if (ret)
> +			continue;
> +
> +		idr_init(&cfr->rx_ring.bufs_idr);
> +		spin_lock_init(&cfr->rx_ring.idr_lock);
> +		spin_lock_init(&cfr->lock);
> +		spin_lock_init(&cfr->lut_lock);
> +
> +		num_lut_entries = min_t(u32, CFR_MAX_LUT_ENTRIES, db_cap.min_elem);
> +		cfr->lut = kcalloc(num_lut_entries, sizeof(*cfr->lut),
> +				   GFP_KERNEL);
> +		if (!cfr->lut) {
> +			ret = -ENOMEM;
> +			goto err;
> +		}
> +
> +		ret = ath11k_cfr_ring_alloc(ar, &db_cap);
> +		if (ret) {
> +			ath11k_warn(ab, "failed to init cfr ring for pdev %d: %d\n",
> +				    i, ret);
> +			goto err;

you need to free lut before jumping to error handling

> +		}
> +
> +		cfr->lut_num = num_lut_entries;
> +	}
> +
> +	return 0;
> +
> +err:
> +	for (i = i - 1; i >= 0; i--) {
> +		ar = ab->pdevs[i].ar;
> +		cfr = &ar->cfr;
> +
> +		ath11k_cfr_ring_free(ar);
> +
> +		spin_lock_bh(&cfr->lut_lock);
> +		kfree(cfr->lut);
> +		cfr->lut = NULL;
> +		spin_unlock_bh(&cfr->lut_lock);
> +	}
> +	return ret;
> +}

