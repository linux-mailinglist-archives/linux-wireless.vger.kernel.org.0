Return-Path: <linux-wireless+bounces-22919-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F11AB5871
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 17:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 352B51B62301
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 15:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F060E2BF3C8;
	Tue, 13 May 2025 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LIZas53f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368732BF3C5
	for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 15:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747149420; cv=none; b=uinNxsS6W7zrTxhkRrgdaPv+80njarZ6jiy6liJoAAenMWti7l/7UMSbHlTFGZNqrO3E5Si7TL2lkgpSmRbMEqd1MRS+ek5t1KZ4GPzRmGW6JtJX1hi1sbUtnc8dijnhAQ87/kafq+vxyfoT3hFFTqoKXU6PPWl/B+LgAxiufBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747149420; c=relaxed/simple;
	bh=efFpneV7rV4EY30pj6fIANj7dCK+In4mFisjbvF0K04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Um56e5QzhwCnkFEll3ubtyCWBFyLsC0IpZc517jHnUELldL9tyUQcXDj7LpGbc2/TZa8e5dJN08tgHEXtXujBK2KRlJzkzh+XMPlevr0fUD+jHqjOz3FYvJMyWFC64TRcF/zcIWJkCx4hNpwKr/kHNP8glEgHmn3j/lx6gEcEbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LIZas53f; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54DDMBjg020259
	for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 15:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3ztrdVxrn8TBfS/7xFyW3WzhZsuxUDilww8DQjUsNkI=; b=LIZas53faEkTAKOj
	U+9+fr4CgM/DHXntykZu+DTxCM7n/wNvla8Yh1M+Anl8FZ44LK2LogmklpCLkpK9
	ONsYCV+6mRfxkfS5hLHXeS/+TSb6/aDAEYnmUKnwjV4PqZYtINQKI75BU66Wo+7X
	s8meOhsXZUR2zSgnWQVCvcnBs7z6wEJ2vf1smom/uOYDRtyQ/cak3+CYZ6hjYzs6
	i5OqptPTI4GG74bcH+w9cX4y1HTJ0C0dikakvsFgpOFvAuyk1PcIJtYMRXp2loFa
	Oat6rwKbqMK0h37WAFX9RGU4Juw/aOaCMdsc2RZna9NpYYng9tp5Se0b8TqUYNtW
	ysBcEg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46kc3mw2ua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 15:16:58 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b20755ac243so3997672a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 08:16:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747149417; x=1747754217;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ztrdVxrn8TBfS/7xFyW3WzhZsuxUDilww8DQjUsNkI=;
        b=tyM3aqD2HRm9Rbt1JaL2rLjEUfXBEEBUhgIsWZJz5tySS+5IJp10htZ6ez8CaBRWVp
         4TELp8Uh9cUGojBG8EaDNGGUpkE5yOGLsPSoIoEDupMeWZJmO1NQ6UgLzE4QS/GT0uqm
         /EeTeXOthUPs1cutJ1+bEiuwCjQVIoaGB1O3s2hA+l/9UB/7SxbUZIgH/HAOz4gfCBJ9
         ILYqXqXHCEthCZ+WSywOPFsoEDOBorC/4HX5b5iihtPkMHX3+CNx3mqRLUTGB4Y79MnF
         A2lLE4BogQjYpRQOcSrr/D6NRFB9sBDI+RiuLLjcsnIUP2B79EPjtsHwSIvdCBqGRwsY
         ImAA==
X-Forwarded-Encrypted: i=1; AJvYcCXmaVrdq0qG0gpxLTs4MwGZsXqGF4w2HSfqyqJ2XUw6v8RrAJcSG0PHqYZMAz2Ofwca9UKHVc8WMjVnkU0hOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDlFbUpjga/M3w9nbwroff4Psy6aR/eqnybUPoOL8ohO3wASpB
	tXpXJO4qwj+boWp77H7KNqBCefkCXLgrq0b5m7ZTmTV3FYZFkMVA9GtVKdLKb4my3aypy4tPvRH
	kS4iFksQ9G2RhOZN0YOnjkjneJcC0RGYQ7/2GbC+uxNLUA7DHCBSTId8ZTGC5iJtxUQ==
X-Gm-Gg: ASbGnctpoLMoWMY3COllunxwaraoQQFp6eeWSqTKjGt+xGimspxfisdBJT4bQa9g4TY
	OsBHlDHobtRtcTAEA8gLpcrWPAzIKRrBD0cVIy2opJO2XeFDF1unSusEuENPuRepCo/ckhi8lG5
	fKszIp9LZPpjuZhQsgUKI1kekcZnyF5906XLU6NkzZXBDkZ6caLYD8t43Nema2cIM5HpQeJVrmz
	co6u6wb74kjB377wN6Y3kHvU/WAgt7RvPgouyU7WeD3pI7A6Ipv371CrdprBZAqyh92JDQdC/Vc
	NmFOrJYl4aSjy9Dk2FuRKxZsB1TcWSZKX64hMAgtbGcQRMf8cHrVvLNvlIoayg==
X-Received: by 2002:a05:6a21:328b:b0:1ee:d664:17a4 with SMTP id adf61e73a8af0-215eb73ff9bmr5239885637.10.1747149416978;
        Tue, 13 May 2025 08:16:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/qZgi8tIjcUeE0ohWzU4Mnw55YfaTgtINhOjXu6Fl8drDxzQO1FyRbVY4oDD29OgLNL9FTQ==
X-Received: by 2002:a05:6a21:328b:b0:1ee:d664:17a4 with SMTP id adf61e73a8af0-215eb73ff9bmr5239835637.10.1747149416526;
        Tue, 13 May 2025 08:16:56 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b234ad3ea02sm6349451a12.39.2025.05.13.08.16.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 08:16:56 -0700 (PDT)
Message-ID: <57e04b5a-9f04-49bb-8a7d-978276e9033f@oss.qualcomm.com>
Date: Tue, 13 May 2025 09:16:53 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] bus: mhi: host: don't free bhie tables during
 suspend/hibernation
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Youssef Samir
 <quic_yabdulra@quicinc.com>,
        Matthew Leung <quic_mattleun@quicinc.com>, Yan Zhen <yanzhen@vivo.com>,
        Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Kunwu Chan <chentao@kylinos.cn>,
        Troy Hanson <quic_thanson@quicinc.com>,
        "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: kernel@collabora.com, sebastian.reichel@collabora.com,
        Carl Vanderlip <quic_carlv@quicinc.com>, Alex Elder <elder@kernel.org>,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org
References: <20250506144941.2715345-1-usama.anjum@collabora.com>
 <4a6b83f4-885a-46e1-ae31-21a4f3959bae@oss.qualcomm.com>
 <5521efad-1ca8-41e3-b820-5527d634c539@collabora.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <5521efad-1ca8-41e3-b820-5527d634c539@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: B_fMDJcbwhe6dlVWAtqE1o75wXUXHwsP
X-Proofpoint-GUID: B_fMDJcbwhe6dlVWAtqE1o75wXUXHwsP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDE0NSBTYWx0ZWRfXwbgDKSGQvF+H
 UcaUdGsLNhoqk+w8ynC3mrg05C4nj1H0cXqwu0JyPUTnORfgH47rJ4Wna+it3u6Ke4BX1iJSGTe
 n95odxRugqfhfiK8EaqJT8vpdVOd/DSd1ufi2uybPI7QajO/GR9bnNX0jnuTdgKOEuRqeYr1ild
 W2TK9IV04T4IzjveElMozCbcVRPjRqNIsU62znq1PRNrfItneTJdMknn0CU6E1E77hiylRI4idY
 RpJog+34NNouMkBaFxSjg6JldU7kOOyCB6XVBERacuhKrO+Qk24wK6naWfKFwQmaDrxjU53mMXS
 j6c5yihYNri5dZea6YQTwzs8/+b5mSkU44SEsUHFUp167UPZlNacQIl/e5Ura3uu6FrqvwAJtsS
 XF6Nfp77obB+mDZyz7rJlg54464mOWGqj29NFK4LEotN83xUpUI/QsqIPQrnaLos1jpCoc1k
X-Authority-Analysis: v=2.4 cv=afhhnQot c=1 sm=1 tr=0 ts=6823626a cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=ql1YSk0x1lwMMiQrb4cA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_03,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 impostorscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505130145

On 5/13/2025 12:44 AM, Muhammad Usama Anjum wrote:
> On 5/12/25 11:46 PM, Jeff Hugo wrote:
>> On 5/6/2025 8:49 AM, Muhammad Usama Anjum wrote:
>>> Fix dma_direct_alloc() failure at resume time during bhie_table
>>> allocation because of memory pressure. There is a report where at
>>> resume time, the memory from the dma doesn't get allocated and MHI
>>> fails to re-initialize.
>>>
>>> To fix it, don't free the memory at power down during suspend /
>>> hibernation. Instead, use the same allocated memory again after every
>>> resume / hibernation. This patch has been tested with resume and
>>> hibernation both.
>>>
>>> The rddm is of constant size for a given hardware. While the fbc_image
>>> size depends on the firmware. If the firmware changes, we'll free and
>>> allocate new memory for it.
>>
>> Why is it valid to load new firmware as a result of suspend?  I don't
>> users would expect that.
> I'm not sure its valid or not. Like other users, I also don't expect
> that firmware would get changed. It doesn't seem to be tested and hence
> supported case.
> 
> But other drivers have code which have implementation like this. I'd
> mentioned previously that this patch was motivated from the ath12k [1]
> and ath11k [2] patches. They don't free the memory and reuse the same
> memory if new size is same.

It feels like this justification needs to be detailed in the commit 
text. I suspect at some point we'll have another MHI device where the FW 
will need to be cached.

>>> diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
>>> index efa3b6dddf4d2..bc8459798bbee 100644
>>> --- a/drivers/bus/mhi/host/boot.c
>>> +++ b/drivers/bus/mhi/host/boot.c
>>> @@ -584,10 +584,17 @@ void mhi_fw_load_handler(struct mhi_controller
>>> *mhi_cntrl)
>>>         * device transitioning into MHI READY state
>>>         */
>>>        if (fw_load_type == MHI_FW_LOAD_FBC) {
>>
>> Why is this FBC specific?
> It seems we allocate fbc_image only when firmware load type is
> FW_LOAD_FBC. I'm just optimizing the buffer allocation here.

We alloc bhie tables in non FBC usecases. Is this somehow an FBC 
specific issue? Perhaps you could clarify the limits of this solution in 
the commit text?

> 
>>
>>> -        ret = mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->fbc_image,
>>> fw_sz);
>>> -        if (ret) {
>>> -            release_firmware(firmware);
>>> -            goto error_fw_load;
>>> +        if (mhi_cntrl->fbc_image && fw_sz != mhi_cntrl->prev_fw_sz) {
>>> +            mhi_free_bhie_table(mhi_cntrl, mhi_cntrl->fbc_image);
>>> +            mhi_cntrl->fbc_image = NULL;
>>> +        }
>>> +        if (!mhi_cntrl->fbc_image) {
>>> +            ret = mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl-
>>>> fbc_image, fw_sz);
>>> +            if (ret) {
>>> +                release_firmware(firmware);
>>> +                goto error_fw_load;
>>> +            }
>>> +            mhi_cntrl->prev_fw_sz = fw_sz;
>>>            }
>>>              /* Load the firmware into BHIE vec table */
>>> diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
>>> index e6c3ff62bab1d..107d71b4cc51a 100644
>>> --- a/drivers/bus/mhi/host/pm.c
>>> +++ b/drivers/bus/mhi/host/pm.c
>>> @@ -1259,10 +1259,19 @@ void mhi_power_down(struct mhi_controller
>>> *mhi_cntrl, bool graceful)
>>>    }
>>>    EXPORT_SYMBOL_GPL(mhi_power_down);
>>>    +static void __mhi_power_down_unprepare_keep_dev(struct
>>> mhi_controller *mhi_cntrl)
>>> +{
>>> +    mhi_cntrl->bhi = NULL;
>>> +    mhi_cntrl->bhie = NULL;
>>
>> Why?
> This function is shorter version of mhi_unprepare_after_power_down(). As
> we need different code path in case of suspend/hibernation case, I was
> adding a new API which Mani asked me remove and consolidate into
> mhi_power_down_keep_dev() instead. So this static function has been
> added. [3]

I don't understand the need to zero these out.  Also, if you are copying 
part of the functionality of mhi_unprepare_after_power_down(), shouldn't 
that functionality be moved into your new API to eliminate duplication?


