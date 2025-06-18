Return-Path: <linux-wireless+bounces-24230-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42632ADE014
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 02:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AEF83B0775
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 00:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148555475E;
	Wed, 18 Jun 2025 00:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aLODXMmR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC192F531E
	for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 00:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750207083; cv=none; b=ZINFHlG5JI5+0yqkcaS1wzitroorKwl9giEed5O+Jnqi2rRFxgDlkb76Wo0ffF70M1/xs02CES2MujY7Z9XBoMXXulDQ8OOtLJO5MIGMasmEHO908QBNWabSwS8uAguYoEiOGVMG3owVWHIE2ZcgnOvcphw25YpYg76UPYD4Yls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750207083; c=relaxed/simple;
	bh=Rt6my2o1M0e/pISpG76AtZ0sXNGnasnX1avz34XtJ1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LDtu3IuuHSDXu3/v1sYj5vDYDX3NlScEf7Iw6i0B0p2Fj6u2TIMStnrI+IVYMRmjyUq/NDgp1tX4Uj8zNi2M3n/buIu+XylIgn5vroFFfoqgo6Zyxo281faBZPKCfmx3d1Mq+ayYKjhv8THwrkjieFYwA2TFgXByZ6GGAJcWzk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aLODXMmR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HF8dxc027925
	for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 00:37:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jtsxo71Ss+Fxx3eNA8h7CzAEpCZjWON0qU+YW0EyqVA=; b=aLODXMmRv2zH3N8I
	SDaywaOPsg4IGbq56jOvuTjgBIex0DHemod94S2MMQz6xUNbp3OLzdYz+naoNPLK
	1biYS7Kd5vEL84qzaTVBYLs2E7Sy53f9uReGgCF/twh7k0rhBUcTsJbbwk2qRkZy
	2MWEphLIiNmGDoLkUGPWuO0wFHV7wfhKLcoYpymJKveVGpQVjMLtcNkEVC0iwlDJ
	AZGoBe38IQ1fmopZX+4VRrJCvSesiKI/Z4nvCgzI+b1WDhUR3eWjmIbeafdRo7iG
	svvcJ3CzrBzblRt8jJYWQNTEnH+Je+ZZdJmLVIKYuj1NcgC9ufoDZvUExdMnaMHY
	rzRaVw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791crt0q3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 00:37:53 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-231d13ac4d4so91957445ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 17:37:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750207072; x=1750811872;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jtsxo71Ss+Fxx3eNA8h7CzAEpCZjWON0qU+YW0EyqVA=;
        b=Jb10MI+RnhJYgG5Uq3eVn+lQa0GSd+Rn+09vqTgR2fdc7SOYdVEHVZi1iS2HyZvzNX
         nkZI8qQ/HJZtlKNN9WhxUt39l2kVeTZRB/ZcAjqbGk1VYhrDbIt3U+9PhWZIBg7gnuf+
         dELxQSFZf33OV00M8aS60Bmzl54eYkVu+ngpHdZb+wzIKRZU1txgdBIV4Cg7nYuTZZew
         IK5sUozLk1h9j1ruYxKihjGiRO2BRlbmwHZ9cgD85CTpZmLLPnKJptM9+SHuD5LedMW9
         AXsR177mhpM7x+Kd/zRORnBLyTkrDQv+1Yg0dwCVQqhSb8RbUir1k6Xqd8v82nY+IN/b
         gkBg==
X-Gm-Message-State: AOJu0Yw8Q0Sr5BIGiuEf5OIjLpOCOMohgnXaR9+iyeDA3q82U783biU+
	+NwVu4CZ9aZ/vrkpZgAXJnOmRXwx9XvHmPIZ9GpqmxiFAh8r4ie5d/+/XEjsTTVgFDua6PKw4KM
	4BTz2lL0xYVL4lOoqUE9Wo2SdPcXKR92k8OS2DNDqquH/nNihADN8n2s81pjVkQ4Lc95FMQ==
X-Gm-Gg: ASbGnctUjFyzDMyi8NAjHs1Ardr0QHPN2r88tsAWKGmla2tcIHvZFuFKbnBqhxvbpqL
	jhDF0jZ7CecUt5A9MLvE7cYJiIEQgbmHp9+ejZe318m2xDOB82sTRuIXPxBELZCjhnf7K/GuCSD
	9Qskcos6KW9DYzJpS4JkJopu+trVltcNFbvnvV1cSABNHwcC+05P/vUuHQHpUMU2mDMpOThRA9h
	iIJjxqGABPqXd/cabky7NpP+q4zkjAOaZbla5XGd0C9ub/IkAz7jFqp85EN80DQjxxgTCGUZa9j
	Zg22PQFXxho0ottQ4IiNSgsFvRjV/HE6Ws1ufJY6KotOa+vJvmSEyWB2yzkZSDRhS7NlfgNIwzr
	auW4Xc+mG3AOFUAs=
X-Received: by 2002:a17:902:cecb:b0:234:b44c:d3c8 with SMTP id d9443c01a7336-2366b3c38e6mr230344365ad.37.1750207072213;
        Tue, 17 Jun 2025 17:37:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkPzSzPmO4tfjjl83hquV3ywd9TVPJ0+3DO+ZDgWpwWJTWPeSP03HZwobSq8Al3QEM0CZfnw==
X-Received: by 2002:a17:902:cecb:b0:234:b44c:d3c8 with SMTP id d9443c01a7336-2366b3c38e6mr230344145ad.37.1750207071856;
        Tue, 17 Jun 2025 17:37:51 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23699a75d65sm14373275ad.91.2025.06.17.17.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 17:37:51 -0700 (PDT)
Message-ID: <cbd285e8-9ee2-4825-a0b6-da64fbd6b71e@oss.qualcomm.com>
Date: Tue, 17 Jun 2025 17:37:50 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v3 5/6] wifi: ath11k: choose default PM policy
 for hibernation
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Johan Hovold <johan+linaro@kernel.org>
References: <20250328-ath11k-bring-hibernation-back-v3-0-23405ae23431@quicinc.com>
 <20250328-ath11k-bring-hibernation-back-v3-5-23405ae23431@quicinc.com>
 <d0cd065c-1cd1-4e56-8c57-60777b1f3664@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <d0cd065c-1cd1-4e56-8c57-60777b1f3664@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: TbFBDgto9AZb_BSHdZZ3Tn24jfrSG5Dl
X-Authority-Analysis: v=2.4 cv=BoedwZX5 c=1 sm=1 tr=0 ts=68520a61 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=IUDzS62LCLz5u6N7BFMA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=FO4_E8m0qiDe52t0p3_H:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: TbFBDgto9AZb_BSHdZZ3Tn24jfrSG5Dl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDAwMyBTYWx0ZWRfXz6tQpB1SiveC
 bU6RRgWU3IOqAJnuzAXEAdCVoDe7K/7dK61PQrIJ5BriGqf64tMWlPMiEGTeghTmgXNgUrQjJAZ
 HorlrH1vqze3kq7y4e1OVEdPzWcckIphst85fatIb4+WGKuXEQivrdwCzQaNxVPVM2yhq00v5j5
 CV8bylipSAK6BeMl4Pm4M/Ezhif9nfXJhLTn2DIbsCPcG3ho4Ip4tSHOMLZIps7nSEgAIFW2f++
 9ICuwC5thNIwyBc+jX9AwqG9FOUgIkVY3QE7OmXDgqQySkcIZW2k2Y0nQID2ASRF8w84/gnlUjC
 7gL02yRm6sdApUDBBZTMbnyi42tIEMt6QFynoXMFsXcF1pNN2mhqYRs6IL9d5tKwS1xBCDzAE+F
 U+AfVgVS6K3k3sxWSX87emJ0WSxAV8rLNE5rune5Yjn0OiggB2TtsBzPr+hjHkwQL+yXTfqY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_09,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=643 bulkscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 spamscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506180003

On 6/17/2025 5:15 PM, Konrad Dybcio wrote:
> On 3/28/25 6:32 AM, Baochen Qiang wrote:
>> Now WoWLAN mode is chosen for those machines listed in the quirk table.
>> This works for suspend (S3) but breaks for hibernation (S4), because
>> WoWLAN mode requires WLAN power to be sustained, which is not the case
>> during hibernation. For hibernation, the default mode should be used.
>>
>> Register a PM notifier with which kernel can notify us of the actual PM
>> operation: if system is going to suspend, the original PM policy is
>> honored; while if it is hibernation, overwrite it with default policy.
>>
>> To summarize: for suspend (S3), WoWLAN mode is chosen for machines listed
>> in the quirk table, non-WoWLAN mode for others; for hibernation (S4),
>> non-WoWLAN mode is chosen for all.
>>
>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
>>
>> Tested-by: Takashi Iwai <tiwai@suse.de>
>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
>> ---
> 
> I've bisected the following splat to this patch, still happening on
> linux-next/master, WCN6855 + SC8280XP CRD, 100% reproducibility 

This smells a lot like the issue recently fixed in ath12k:
https://msgid.link/20250604055250.1228501-1-miaoqing.pan@oss.qualcomm.com

Baochen, can you look at the applicability of that patch?

/jeff

