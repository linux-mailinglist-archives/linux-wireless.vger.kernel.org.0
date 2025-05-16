Return-Path: <linux-wireless+bounces-23094-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 459B4ABA369
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 21:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 403659E01CB
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 19:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0A32741D2;
	Fri, 16 May 2025 19:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QcNBF8mC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151242798EB
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 19:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747422445; cv=none; b=HObjjAQn5EY6Q+gV3FON5LuTo68mQI78wZJfpCxFIGI1yWeTip3I3LoYuMkC+UVsPxs/29f8vNvnuS11/pfR7exENfAmgy3raNUKQvL3h3fDpM7lYjDUirZ+6AEIPJByHBkgyq8eNuEa72JG8cMSUHmYEexiszSVudhabuveGPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747422445; c=relaxed/simple;
	bh=6OMAleZ/ee9YO4/rsb0r1/EcIpx2FnUb2zPjPXqMYTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MAgzfYNMSQ6BWU0dLeAYKrHneJMBix/y1oVy7VKL3ilzsVd+BxqwqbdyhJqT4+O5dQL/TJUtH1Ca9RwkiGfbeMeddfHuxzMqU5gnUL7rlUDpNlY9uQRprp27O7eBfCVGORlVpiZXryWTsBlkIokfRciej7N587wa7MEL0sIlTGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QcNBF8mC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GB0gvb024393
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 19:07:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zuBZNub7s/zzshvs4wkXnAmFdJFJB/AhOGzilGXBH6s=; b=QcNBF8mCDeyS5Naa
	0T8m/NLXdTMUNhPA/tfAQMn+l+rCX6qgTYgoGHGbr/2nCbMRoUv83DkADcWXRnzs
	+98CposOLGncta3FYfLQ7SyThCfMb6a+5++M3Da7ZCvgxXHGV3Bvr1O9KS83xG68
	4SegbEtYALcK6MT4ebdPPkvg1/RU9PnMoQO98unwPaOLlBT/jbVchSXIej79vOx1
	bavNeC1aZbwEnaMdbTqR0DqEIRYNxC+kVvafyuMoFRr39gA/eI4TZgrfYmZacZkZ
	69iEnyXf6BdClH6MsAGUAk0ngtahfqF9pVNplhiata72SH9VIEJHlrFR2ACXvLp/
	X5TMpQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcn351v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 19:07:22 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-742229c8d8eso3267256b3a.2
        for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 12:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747422442; x=1748027242;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zuBZNub7s/zzshvs4wkXnAmFdJFJB/AhOGzilGXBH6s=;
        b=S8pYmOgP3+/yov6LGPqEESZggpuTvgY8St3Ml+zWIqzMoZn5tuQcTYIeuYCa++xSNE
         ChQ/go+7K9ksF+Q5je80+tMXrXq2E6NrX6yR3jYG8v04Vf3nnGq9TukxEXmVUGfKDnvJ
         h40NP1d0mXR7vCrVbk5axrfAq2+jgme0KqnHNX8iuU3unJIl9dpbkteQ6xXh1tn2geqK
         SHVR5/QbLvGgNsONY9z6t62KZ+dKAXMGW/5POkcBl0q3UQEy0Wf12iYdYxexRuyp0tcg
         42Kc8oLimnnCLdDFO/ZQaerhsyY7ShV6+WgWgh1IIDeopJ1btfEYC6b4V5U6Q8wh4Hen
         BunQ==
X-Forwarded-Encrypted: i=1; AJvYcCUP7SMZ4SZ5YQr/yzYJy6gDMAoy/p71Pgsuj7LNH3T5q0ijVM5NRavLig4LpW3wWpdMux157qgk/aUFHT9wpw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5oOyiLghcPefGD3LJzz9Zzx/zKM8UV4HVjHt1oLx3gWbzmS/1
	OQIJc/bkNo7vUqgnPn3DORKw/iVcQh0vvchxjM19s88kxIcomtbBot51WOdGtTafiUvgvmHmI6Q
	ryjkajUEhIJuPdCjheh1Xn7kB19qfnky64UZghO3bnz9x7eWdRmttyUQmC+kF0bJEtYWUVw==
X-Gm-Gg: ASbGncuV8QhSsQPbHv5sK4YBqyzG1W7Yal75iyEHoXpkyoamT/nLUqjphLX+6v4TGx+
	u51B9kEB5XU1/QhfmBHQei1ND2PvZ3yygV/FVkVKYfB/3k4dVwUoPGPbHrWvZOFmK5838oeV2Eh
	/AWL3vuYnHlHEP6+iqV1fCW+HFZR3y2Qq/lhu5ClhLeqKkdsp1r3khIMulemEZ9bosn6y6eynAE
	GijGY6U14R39u1SA0fUs9RxkueojO9MYBeOhALHpS4uFQA+TfUMBrerR+fS95N+NMUNpPrW9sLK
	6Dx9GuX0j+IEPqjZe4MOgm73frhlcW6Ll9wHpFb+Ye+uQyhIQLoe/iuZdTciNw==
X-Received: by 2002:a05:6a00:91d4:b0:736:35d4:f03f with SMTP id d2e1a72fcca58-742a97dadf7mr5579632b3a.6.1747422442036;
        Fri, 16 May 2025 12:07:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrLgC8dkstiJdx29E4dD097tJ0PNl82Z3nmB55Pim85MbNDC4YrFBzPEITGZxbyFl2dSY5OA==
X-Received: by 2002:a05:6a00:91d4:b0:736:35d4:f03f with SMTP id d2e1a72fcca58-742a97dadf7mr5579575b3a.6.1747422441535;
        Fri, 16 May 2025 12:07:21 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9876d39sm1914504b3a.146.2025.05.16.12.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 12:07:21 -0700 (PDT)
Message-ID: <b0c132e1-b75b-490a-b2b5-3f5e5c7b99ad@oss.qualcomm.com>
Date: Fri, 16 May 2025 13:07:18 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] bus: mhi: host: don't free bhie tables during
 suspend/hibernation
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Youssef Samir
 <quic_yabdulra@quicinc.com>,
        Matthew Leung <quic_mattleun@quicinc.com>, Yan Zhen <yanzhen@vivo.com>,
        Alex Elder <elder@kernel.org>, Kunwu Chan <chentao@kylinos.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: kernel@collabora.com, sebastian.reichel@collabora.com,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Baochen Qiang <quic_bqiang@quicinc.com>, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org
References: <20250514081447.279981-1-usama.anjum@collabora.com>
 <f6eac84d-3d67-4f99-a9c5-a9f03d748010@oss.qualcomm.com>
 <0e21b693-e03e-4a76-aada-0c48aeae6eec@collabora.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <0e21b693-e03e-4a76-aada-0c48aeae6eec@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: zU87jRPxPrC7Q1QIPzRNPKawdeBF35Aa
X-Authority-Analysis: v=2.4 cv=HZ4UTjE8 c=1 sm=1 tr=0 ts=68278cea cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=REsDF6D9n_RRfkEuQ0QA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: zU87jRPxPrC7Q1QIPzRNPKawdeBF35Aa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDE4NyBTYWx0ZWRfX/OwNCcu/okdS
 QyGj44FTgDxYzuYIF0hQFO+cRbxnSxZK/8SmWYga8UKOfg95ks6jd3zu6sJeNtG2hNfwhWioPJW
 JaOABH9dqGlaBeFJxpakNICY0lVgep8ic/h8P3Z6YH4CqZMuAowqXAUXCe3WDXrV/OOF7qnhI71
 /FpitYLLbTfQAazRwz8FV73/hq5rSb++qtbnRFkymesSHfVpikSQfXgimgtyEYAAWcs0bbDCTFH
 zyANGFWO/0JwUJXP9lI1AMOz0HKCMl1AWVaCvIvrnRV6OcowP+JEsnO4/HF3VOl1vKD4Yqb5Xa8
 IvQwzg5F/X1tUNLuanAiz8ncZ1DSbBP7litb+iqbEYsTHuJVkRYTXoh8/0Jv4OPqr4jZ/F7+OMh
 +atvr8KyrgLRtHCYyw8izVplNS8POqN3ZvP8GRpd0ZeY70FlQ6V2BT9d6HgokUNFA4Mw+dFm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 mlxscore=0 mlxlogscore=979 lowpriorityscore=0 malwarescore=0
 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505160187

On 5/16/2025 12:42 PM, Muhammad Usama Anjum wrote:
> On 5/16/25 7:59 PM, Jeff Hugo wrote:
>> On 5/14/2025 2:14 AM, Muhammad Usama Anjum wrote:
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
>>> There are two allocations of bhie; rddm and fbc. Optimize both of those
>>
>> There are 3, but you touch 2.  I just commented on this in v4.  Only
>> touching two is fine (the device for the 3rd one doesn't need this), but
>> the documentation must be accurate.
> Yeah, for 3rd one in mhi_load_image_bhie(), this optimization isn't
> needed. Let me rephrase and resent v6.
> 
>>
>>> allocations. The rddm is of constant size for a given hardware. While
>>> the fbc_image size depends on the firmware. If the firmware changes,
>>> we'll free and allocate new memory for it. This patch is moticated from
>>
>> moticated?  Motivated maybe?
> I'm using checkpatch --strict --codespell and hopping that it'll catch
> typos. But it misses some of them. Do you use any such tool?

I use the same. Codespell is nice, but doesn't catch everything.

-Jeff

