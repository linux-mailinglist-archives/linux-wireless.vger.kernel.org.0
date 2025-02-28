Return-Path: <linux-wireless+bounces-19596-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD4FA49DA1
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 16:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F116816F8A4
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 15:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DFA17A2E8;
	Fri, 28 Feb 2025 15:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DLPIcTPR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B33518871F
	for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 15:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740757101; cv=none; b=IE43AK6PMtqgx9UnBoZSSRuGWvHMPaeaEMrbkmdPEOXWUMeaw37x7uHlXJZdBpkuCIHbTpecandYIw6CBTBhpr8U7kZfmiNMaaAW6yhlSOHfKHQJZFTqjV181W9yrFi2TKNCxvDGLBA9v8IaOXWGyK6Q511bsaJeGJN0UT+0UAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740757101; c=relaxed/simple;
	bh=Vv/QMAwZcdHeazWrgZHZAOtR+MkgUhw7F+Chcv5IzP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LskxlKYDRwAKSbZW/+pmymCWqq1WUmqkl5/qJBqhjN97foYeePTHRprR999T/B3B/PhrKOezcGL4Ku7TaBsEHP53qTqMbCmEtb4FhtVRXaJYEdwvHOIHgNJS06aQ0BpiI0UxeX9mOT3paZQPuVibYzgI1VwOzher2xJLlYgfmBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DLPIcTPR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SAXKUS002061
	for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 15:38:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8LNUpDIdNaYqmVN760bwRMxn2l9LZA3ETnVlarvrMvs=; b=DLPIcTPRotTuKfTf
	33hlPqh05yNpkp7abvi4/OzcSu0iGx/2OBAjoSaFPg3hxO+XL26VYoNcDVs+3I6d
	ga86erWfQN3KmfQihoV3hIsOpF1jE86yj8eMB068F1UFkHsj0GQkvFvTgp30699x
	dQiiOlnpa7deVA/aZytPHYx7ubb86OxWscl4dLVa9LRt2ZjhACLjcy5UpMJSqCvC
	RpicbvxhNFHar6VIWZIIzI8b92FCihl9dq7WA6xQVU9FmRTGnLWhhM0If4vWYWQ5
	Y9ChsunhMVETusHv9sP+QIBAivelJkf9crLQyKpEKfDcThkxlvXnlCVW2/eMAL8a
	1FNyLQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 452ynwtr75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 15:38:18 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fed0f307ccso272336a91.0
        for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 07:38:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740757097; x=1741361897;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8LNUpDIdNaYqmVN760bwRMxn2l9LZA3ETnVlarvrMvs=;
        b=nVEBxPFAmo7lSycTQsl1qaNu2SyPiH+vmbN9GERgxIjcVMSDT5sO2S64z1NwcmloBo
         4F5Ma2tXYOHS9G2Avq72omWbD3LTrwK9rnigop7NlR/kNSYXgsLkjpmAsoCiywjNkpGf
         YqvOloXsRsLtQZRoYH6m73ia8+Xfx3EAWoA89VeMdo7TlWGtCSA5vQL1jk1WBue9t4zs
         76jClo9aQDAh8sqYAGXRhy/G6Y3SD7gdfSoYTREL8A8uUvbyr5qxG7LbuIuuGnDrpTmY
         0fmELvzot2uFjw/qrbCl8+xv3hi2BTm7Z5HWChSXJe2J8NtdZCRlwr/UfKvNnqUdSOYN
         ks5A==
X-Forwarded-Encrypted: i=1; AJvYcCVYpfeg+nv7MUICtgwS4Ea8mmt91161+Xxf5tOZKkfKRhtAYnkcBdT6zfcuxXW/iR1kyhuAYxEfzZf03v+yKA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzghpPEC7eRUnoiGqNKwnA2Q8KfUz6uV1Mq0gV9WzE2tEQ8Z7bG
	E1HjEHIULUClYyZbdaAYEASEV+oJd0Qn9w/u8XF7Whpc6MVMVTcJniUrQF8caXJVuLj5M2mPbAe
	iHkeZ+S6ikpIFQTs4XLfwyGhxFQmRWz4KOnjSu0R02Y0Hy3haDMFJN2t9KWc275wRQA==
X-Gm-Gg: ASbGncvrh/HACurRUa8czzf+WUQzBcJ462T1OHPA3ZtrJ0i3oXPJbBwDkdjCUq4JcEm
	tVP8UtLLTfdTwufx2DHL5wJWW4jSlDdFsaLz2Ou6kXYsADp8I+vOkraiYtK8F2HG9yVbS5i1ccU
	DeVCgjL4qqK9U+mzrazWlc9ItG3CO88jY5oZfN1k0Jny9tOLk0E2veorcG1uBfHIMPUvZI9+dQm
	N0QjquVbyLtzXQaDkGi9Ar3dGWqjPpzCRqumvsXPISb7+nhK36o5nj9vbpBufecIpiYE7G4WqU4
	72dlzhgLgg8x1U9vepRsnTEqXz91Ve+nLzMYAWOoC21LuiG4Da4JeywbIQsCAksRmGQZI2nkecW
	TgwIBXNTr
X-Received: by 2002:a17:90b:180b:b0:2ee:cded:9ac7 with SMTP id 98e67ed59e1d1-2febab79a02mr6270488a91.20.1740757097279;
        Fri, 28 Feb 2025 07:38:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESTQBcE0OFBLHlj8E+mhhVJ+4hIEvlMb3ba1zyf+ZYTUKbNkLyE8zPsVDOKn9heQeZqiPpoA==
X-Received: by 2002:a17:90b:180b:b0:2ee:cded:9ac7 with SMTP id 98e67ed59e1d1-2febab79a02mr6270453a91.20.1740757096898;
        Fri, 28 Feb 2025 07:38:16 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501f9dcdsm34738965ad.77.2025.02.28.07.38.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 07:38:16 -0800 (PST)
Message-ID: <e702e39a-e199-4ea4-a066-0b2e26253f98@oss.qualcomm.com>
Date: Fri, 28 Feb 2025 07:38:15 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/13] wifi: ath12k: add support for fixed QMI firmware
 memory
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, ath12k@lists.infradead.org
Cc: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250227191034.1949954-1-quic_rajkbhag@quicinc.com>
 <20250227191034.1949954-8-quic_rajkbhag@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250227191034.1949954-8-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 619UQQFJHvFJ_hUDeFzyBhpiioDdeE7i
X-Proofpoint-GUID: 619UQQFJHvFJ_hUDeFzyBhpiioDdeE7i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_04,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 impostorscore=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502280114

On 2/27/2025 11:10 AM, Raj Kumar Bhagat wrote:
...
> +static int ath12k_qmi_assign_target_mem_chunk(struct ath12k_base *ab)
> +{
> +	struct reserved_mem *rmem;
> +	phys_addr_t bdf_size;
> +	int i, idx, ret;
> +
> +	for (i = 0, idx = 0; i < ab->qmi.mem_seg_count; i++) {
> +		switch (ab->qmi.target_mem[i].type) {
> +		case HOST_DDR_REGION_TYPE:
> +			rmem = ath12k_core_get_reserved_mem(ab, 0);
> +			if (!rmem) {
> +				ret = -ENODEV;
> +				goto out;
> +			}
> +
> +			if (rmem->size < ab->qmi.target_mem[i].size) {
> +				ath12k_dbg(ab, ATH12K_DBG_QMI,
> +					   "failed to assign mem type %d req size %d avail size %lld\n",
> +					   ab->qmi.target_mem[i].type,
> +					   ab->qmi.target_mem[i].size,
> +					   rmem->size);

The v6 version had a kernel test robot build warning here when building for
MIPS and it looks like nothing has changed.

I don't know the history of why struct reserved_mem::size is of type
phys_addr_t, but that type has a different size depending upon architecture,
therefore you can't use %lld.

To print it correctly you either need to use the %paa format that is meant for
that type, or probably better would be to assign it to a variable of type
size_t and then use %zu (and use that variable in the size test as well)

(also consider if the other %d formats should be %u instead)

> +				ret = -EINVAL;
> +				goto out;
> +			}
> +
> +			ab->qmi.target_mem[idx].paddr = rmem->base;
> +			ab->qmi.target_mem[idx].v.ioaddr =
> +				ioremap(ab->qmi.target_mem[idx].paddr,
> +					ab->qmi.target_mem[i].size);
> +			if (!ab->qmi.target_mem[idx].v.ioaddr) {
> +				ret = -EIO;
> +				goto out;
> +			}
> +			ab->qmi.target_mem[idx].size = ab->qmi.target_mem[i].size;
> +			ab->qmi.target_mem[idx].type = ab->qmi.target_mem[i].type;
> +			idx++;
> +			break;
> +		case BDF_MEM_REGION_TYPE:
> +			rmem = ath12k_core_get_reserved_mem(ab, 0);
> +			if (!rmem) {
> +				ret = -ENODEV;
> +				goto out;
> +			}
> +
> +			bdf_size = rmem->size - ab->hw_params->bdf_addr_offset;
> +			if (bdf_size < ab->qmi.target_mem[i].size) {
> +				ath12k_dbg(ab, ATH12K_DBG_QMI,
> +					   "failed to assign mem type %d req size %d avail size %lld\n",
> +					   ab->qmi.target_mem[i].type,
> +					   ab->qmi.target_mem[i].size,
> +					   bdf_size);

the same issue exists here.
again this would be fixed by making bdf_size type size_t and using %zu

> +				ret = -EINVAL;
> +				goto out;
> +			}
> +			ab->qmi.target_mem[idx].paddr =
> +				rmem->base + ab->hw_params->bdf_addr_offset;
> +			ab->qmi.target_mem[idx].v.ioaddr =
> +				ioremap(ab->qmi.target_mem[idx].paddr,
> +					ab->qmi.target_mem[i].size);
> +			if (!ab->qmi.target_mem[idx].v.ioaddr) {
> +				ret = -EIO;
> +				goto out;
> +			}
> +			ab->qmi.target_mem[idx].size = ab->qmi.target_mem[i].size;
> +			ab->qmi.target_mem[idx].type = ab->qmi.target_mem[i].type;
> +			idx++;
> +			break;

