Return-Path: <linux-wireless+bounces-20249-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CD1A5DFF4
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 16:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 250B1188C44A
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 15:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E9E2505DF;
	Wed, 12 Mar 2025 15:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZNiITNCF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F87E24501D
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792525; cv=none; b=eUgEeCWrsb9l4wAZrTcD29cbHXXPtLpQ8IyntrB3aPum58brP2wbMREXtxPDKxf4q/MwTO4fk2b2IaHerg8PoEG/aEUYADSbfeHSqevEsN1D5yv/LdsD/zGfcBnn1w+aP0BfTkeC9ri4wp0n2Knn/FUIRslGNjge8+UxKqz6NLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792525; c=relaxed/simple;
	bh=rQCyYo1q5LlHeQmc/jvBgqAwBqok1aeeDQVozDHX8OE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pRucFLLLB1F5DFUGqTZU6auyO2XF9ODNUMjE4ARL3t5x4OV4zV5b3gXVaMxluQsac+6oDV7qvqxv7xsKb12uVbEVtrt05IbOuKxuka3/Po21jxRfmSN26qRnlEuB6FMr3LYVk17IqMR8mYzgtv0Vd7U2381f1qWH/BWHWdvJIHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZNiITNCF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52C9jkoE018627
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 15:15:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sX4AAf7m5Hmzy6uxAgPsldQmewUW0wWhuO0d0xDGmO8=; b=ZNiITNCFHf76RD2d
	BJkcFBoTieDJGgtaZS2gQ2IZlTyTr5pKwG0dBaC9+MDHtzlXyajYlBG/DwOIvm6s
	pIBfhL8TylWKsX6J49MiXrMFfDkqVRykdaZcG2hdMJuOMHW+ZdO5JSrbcOqaMo/C
	EO3B64YRsoEMyk56ct9O8CZkbbPLqgQE0kb9bLU4ZRi9A/ZvCVQBMDDWBlI/ebBn
	AldGDf1exSUTGX/hZh2eN/VHbsnP8om+07/D5DtYenSgPRns1XWrNLJHiGkP1Nq1
	Au+trOHPDMvWDcwyNE+8zOyNiZoLyHOGJKFKOaba66q8+TkHKKhQJVZpfLohO4Ub
	8R1u8A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2ntun7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 15:15:21 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-225107fbdc7so75643505ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 08:15:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741792521; x=1742397321;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sX4AAf7m5Hmzy6uxAgPsldQmewUW0wWhuO0d0xDGmO8=;
        b=b8qZ+euTM5fgXZDb0YslE+XA4Ixd1YiFApQMZbc9cz9IFjhM+zl6KPX8ZnMDx8iZtt
         sJ0Gah6m9ite6hq09JOIB7fdXEvSwQAIBuvlCm+zjgQ2BbnGTbZWx6z5DCdYPWULyWuB
         BbESsngPe16DtaozsGjT4DtWazt2E48VpgIxWGdhZ07AxHquTUdkrGXbj1bPqm72+71H
         nJQQKLBjOsnqf3myALU2GooOQkbDZd8e+6JjrUxGRoy6BtpB7BlHJ+uWkL13RHQMagEB
         zxD53r5jYJf7r6zgsa4EdG/SPsfcD+nCggDpatO7JgJiy5a/Xp2j4sx1+RPOqsjPtx87
         nxJg==
X-Forwarded-Encrypted: i=1; AJvYcCXFNy7ZifEC71NpXjiBvlSGGgKcqPS6eD5in0W7e+y9eXdyAC/ZoIjCU7199De4eBMFNX0bDKM80GcB8YSzrw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/N4ls3ZRdgO31lEvonnBeLwMdCDcLvMGbDd9Tdb2afzLJCpl1
	08ruNXOG9eCYobpahTZzn+eyMnBGTtaBTajp3ecJ7f4C4Nz2PnW2RJGqoswbOa/FsvSvqos+nX7
	RjYxrxDfA/ntMGQ4s/iqIyvqq03NHTUnQ+7V0vBDj1UPKxMJfsp2YKJwjH7KZYZr4dg==
X-Gm-Gg: ASbGnctpuouki8TCMI3AXGDisNhXacu9LdeediBAwMozhtv1YS3bwDrgzeL52f5gDdE
	WNVUmNIFxvIqfKhc0Ib/mr8oZCN2szF7qknXX5Fqrk3i9PpudoD9U8VXiDCOtE0f7uGakD0nCcp
	8qVzw6yVLU+Scl3bb0rHTYC6hj1IGp6uL+07RXGoNSanMCGsCb9LyQHAOPxhZ9Sp5xEC78nQwR0
	3uMUNX9T4yJJ2NFNUiYvZVvYJuVGHp6c1GopcTQAfLT3YuoXQzL+Iv8Ebbq9xGK+j7fITgd/oDM
	R70yC6hRYIbpGiiiGTibVyQIbpHuVCOPQysFHWMcvLtdr7ICyciAIdV3AvL6LoO3cLWciFg=
X-Received: by 2002:a17:903:32c5:b0:224:249f:9734 with SMTP id d9443c01a7336-2242887ecd7mr325197665ad.4.1741792520670;
        Wed, 12 Mar 2025 08:15:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOdNtgjzF0uLcKmrq8uktA9l8TaPAfGY6t6+ICMeOkLWYWs6gFJGHlW3ZY4NQTKvR6YiogdA==
X-Received: by 2002:a17:903:32c5:b0:224:249f:9734 with SMTP id d9443c01a7336-2242887ecd7mr325197275ad.4.1741792520273;
        Wed, 12 Mar 2025 08:15:20 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736c78389d7sm7863261b3a.4.2025.03.12.08.15.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 08:15:19 -0700 (PDT)
Message-ID: <a21610ae-e155-44bc-bcc5-b9b8b1c8cbd1@oss.qualcomm.com>
Date: Wed, 12 Mar 2025 08:15:18 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] wifi: iwlwifi: Fix uninitialized variable with
 __free()
To: Dan Carpenter <dan.carpenter@linaro.org>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Johannes Berg <johannes.berg@intel.com>,
        Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Avraham Stern <avraham.stern@intel.com>,
        Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
        Daniel Gabay <daniel.gabay@intel.com>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <f7c17a7f-f173-43bf-bc39-316b8adde349@stanley.mountain>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <f7c17a7f-f173-43bf-bc39-316b8adde349@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 76M5Tg69wU4hqkqAQNjDj5aXkarw2nmX
X-Authority-Analysis: v=2.4 cv=Q4XS452a c=1 sm=1 tr=0 ts=67d1a50a cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=-Q16Wm--JIC0Ijc-Z3AA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 76M5Tg69wU4hqkqAQNjDj5aXkarw2nmX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=830 adultscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503120104

On 3/12/2025 1:31 AM, Dan Carpenter wrote:
> Pointers declared with the __free(kfree) attribute need to be initialized
> because they will be passed to kfree() on every return path.  There are
> two return statement before the "cmd" pointer is initialized so this
> leads to an uninitialized variable bug.
> 
> Fixes: d1e879ec600f ("wifi: iwlwifi: add iwlmld sub-driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/net/wireless/intel/iwlwifi/mld/debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
> index c759c5c68dc0..1d4b2ad5d388 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
> @@ -556,8 +556,8 @@ iwl_dbgfs_vif_twt_setup_write(struct iwl_mld *mld, char *buf, size_t count,
>  	};
>  	struct ieee80211_vif *vif = data;
>  	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
> +	struct iwl_dhc_cmd *cmd __free(kfree) = NULL;

hmm, I thought the recommended convention was to define __free() pointers at
the point of allocation. cleanup.h explicitly says:

 * Given that the "__free(...) = NULL" pattern for variables defined at
 * the top of the function poses this potential interdependency problem
 * the recommendation is to always define and assign variables in one
 * statement and not group variable definitions at the top of the
 * function when __free() is used.

>  	struct iwl_dhc_twt_operation *dhc_twt_cmd;
> -	struct iwl_dhc_cmd *cmd __free(kfree);
>  	u64 target_wake_time;
>  	u32 twt_operation, interval_exp, interval_mantissa, min_wake_duration;
>  	u8 trigger, flow_type, flow_id, protection, tenth_param;


