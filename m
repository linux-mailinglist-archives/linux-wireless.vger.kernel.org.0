Return-Path: <linux-wireless+bounces-24485-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF291AE870A
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 16:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D5433A8401
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 14:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CB41D7E5C;
	Wed, 25 Jun 2025 14:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YDMPZmUS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF381BE238
	for <linux-wireless@vger.kernel.org>; Wed, 25 Jun 2025 14:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750862941; cv=none; b=a+Vy+DdIxzYTTqkMcKZxYl9XMNC3tDst39WEbXxFxZBpsNb+vWfFCAbUNL3fUvyHEMK4mtUyJF6Mu0lLV3Z71Mh07ROqAVMXsA/v9/8ahoQ0VbifQc4qPAb2ZKApQFoGE1F6/EiQbVZEjjfACTmSxs8zsrwzp0VRFzqwc7Qbx5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750862941; c=relaxed/simple;
	bh=BWPoKXwqfeDMulZOutw5Fsd5LPnsifJw/UB3yiZ9u3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eDdTZclcOax5El9KpXphuWscaVZxi5vv2WpKDUdhXiUi+1qvG8Ljxj5Z6rPJv5Eb/oz8E11rQExQGmseYVvSvDv8R7WgZSOgb9+Zkq7dQ4pb5gDxU12fuodsHGjz4/u0UWiddNBTtPE2mVuGobvH3nNnhdrBrem6g2Weye9CAew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YDMPZmUS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PBnFDP013198
	for <linux-wireless@vger.kernel.org>; Wed, 25 Jun 2025 14:48:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IqGGFhx6AVCTLXfpWHpti1jyp5AazE3wQBZfo+NlLJg=; b=YDMPZmUSCEGdHORf
	VKxpYOmQXtgilnrbYwx3ONk1guyObWr6p5Z2iWrVitTkdtaHr2elr2sP97BlTOWB
	Av4816s0UV4DXyLJMKu6fzlZQoqSFWQwpmHYc998VHerijgYr1H+/zCJrR2WQgSK
	qGzDSjXY5BJzv0uaqxoaPKVrNbZ8LvLU1ZO3qHTIdFP3qXaSFmRdnniaLjFpcgOy
	UXSEW6CNNwC/p1DomXr1IRzyEIAJmjLrOdWz3PLMmbb1u32VrGhTdXco9w9ULIop
	OJg6DZc65BuA0trhL8fK2hjgF2yxhB/wjF4CcbyGFBjo78BvyzigiYFCAewrGGXM
	BMaNkQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47fbm1xuqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 25 Jun 2025 14:48:58 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-748d96b974cso1323170b3a.2
        for <linux-wireless@vger.kernel.org>; Wed, 25 Jun 2025 07:48:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750862937; x=1751467737;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IqGGFhx6AVCTLXfpWHpti1jyp5AazE3wQBZfo+NlLJg=;
        b=bDs3tejcuAUIlOAKF/ncATtnGjJsG7SnKrM+YRsih9BXA53chWkN2ROP6uECVNgaeE
         X8xA5bfrvRv2oQFLiZbtQznAlOI7IWirjxXCIHoR0UoKYysMphPAkQNFOYoAEcGX99pd
         NFcgqG/1jts/P8OIJD4zG4XdLUT6b4lxFTVvDCEuVJmJ8YlYOqa1G1U7iURiY0/Oal6y
         RrYDuRuIDxInBTSHrg3nOOi18mporiLgdcnIXLOs3l+BFK2xTrnOTAhNSpWm1aIKYrQJ
         WOs/a4udzOQsUhNd7zqGrup5Zv1cKxM/QijdX1gvmMp6T4y/3+l1ynhJXjwcfREaADK4
         KSnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjc8hodJmOC9jMsor4CCHJD6hj66cqln5+lsi9u0Y6jqlzCIX1NnPBv0aW7aH8kbjGre2m4uqKbx7O9o/SFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbBHVFJO/4xUKXhEiAGmgcUVVD2G0fDgyHzFPnd1RMk0SONJuv
	YTIStrs5FH7NVVvngURyOlRD3chAofWEPq3mPMhB13fjaq26lz3r0D/oQuetvZjehH5P3vJ6IHW
	XHQe+sribDM4/D2moyKXXX1gfxGTu57/4y2ncZhg5tFAnR7LGEVLH0Oo6mTDSYxT622bFTA==
X-Gm-Gg: ASbGncsdlaaepoAIONEPgXle9jF/jnTSjLjgDsU2U1m4RWb/d0946MCuj55TDpW7x0X
	xs5f+4aURViyhYZEHoWVyvPu4IkDNr4QQhJhEAMosD1qlGFnraKuUPiMlAz65ig/xVMWGBnUOBN
	cbwktRPyypyZkIuG+W5X20GHyOXHqh39hepGX/k38i+EaGkE0Sn7yGe/2fTQRus0K0k6jqblWD4
	TsClKE1qWixQCeYbMSbEvRGxGXf8JU7zROzwbPA2y04fzLcYU+H2ZArqdBLDd1nK73WTq3olgRk
	UnLys+xTKphDar6he3sRekDNgh7yxmoHO6OsX1TBqktRm0jLJj+RPKU6XE/4uZr8WN16UnLHr+3
	TmQ==
X-Received: by 2002:a05:6a21:38a:b0:21a:de8e:44b1 with SMTP id adf61e73a8af0-2208c610eeemr176599637.34.1750862937304;
        Wed, 25 Jun 2025 07:48:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+XHscp/yEzgIUgr5HvkN796Je8M5rUAoryyGJvsCBmHFT8xX3ENlpIX1qc5J+I50JLhQlLw==
X-Received: by 2002:a05:6a21:38a:b0:21a:de8e:44b1 with SMTP id adf61e73a8af0-2208c610eeemr176572637.34.1750862936922;
        Wed, 25 Jun 2025 07:48:56 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f124249bsm11161411a12.38.2025.06.25.07.48.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 07:48:56 -0700 (PDT)
Message-ID: <e23d7674-31cd-4499-9711-6e5695b149c6@oss.qualcomm.com>
Date: Wed, 25 Jun 2025 07:48:54 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: install pairwise key first
To: stable@vger.kernel.org
Cc: Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gregoire <gregoire.s93@live.fr>, Sebastian Reichel <sre@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        Johan Hovold <johan@kernel.org>
References: <20250523-ath12k-unicast-key-first-v1-0-f53c3880e6d8@quicinc.com>
 <aFvGnJwMTqDbYsHF@hovoldconsulting.com>
 <2d688040-e547-4e18-905e-ea31ea9d627b@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <2d688040-e547-4e18-905e-ea31ea9d627b@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YYu95xRf c=1 sm=1 tr=0 ts=685c0c5a cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=UqCG9HQmAAAA:8
 a=bC-a23v3AAAA:8 a=COk6AnOGAAAA:8 a=dh4-YsZgxDmbEjmCT7kA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=FO4_E8m0qiDe52t0p3_H:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: hu6OBDA1AHbsJle37RPLZWT1cItjqXXl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDEwNyBTYWx0ZWRfX7bUkAz6qYU63
 eKEv+JroPCh316fsG7QPmRmMMqPpliMFFizmA3ROnzRb/2tLSDM3t7391BFWmvJw95oPnmS2qEG
 hLFdaB6Bqe9uuKDX7mHUFqGjMe6pmLGQCv/lMewKCoDUNfbUS+rsjieqhfctoPv+wCU17cM5Psv
 9jf4tKMJ/Zx27nM9EPBHaiCNcf5pecwMYKxJEoD4XZx3RFUiIYinp+t8zOzFG3wt3wyv7wmjvuG
 C6cLj+R791D02/TmonFvoIlusa3kCZzMjatCk2Jj+Q+hw0dXphbxN9l+YrqhAn334O9XhHNRUJn
 fQogMUw/ugrD/hbviHGitLR2rgxDJmH2SWOjNYJ2SztIG2KdbDZ5jR1rijVmyOTv3zQ0zozTCWa
 hKKHvXr7J2ZWs8oP+bFiB0OZLj+1pANIu3UzCnIx+DJDfT1J+1/f6oBHe5mb9b6Yfj0jXw3M
X-Proofpoint-ORIG-GUID: hu6OBDA1AHbsJle37RPLZWT1cItjqXXl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_04,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506250107

On 6/25/2025 3:15 AM, Baochen Qiang wrote:
> 
> 
> On 6/25/2025 5:51 PM, Johan Hovold wrote:
>> [ +CC: Gregoire ]
>>
>> On Fri, May 23, 2025 at 11:49:00AM +0800, Baochen Qiang wrote:
>>> We got report that WCN7850 is not working with IWD [1][2]. Debug
>>> shows the reason is that IWD installs group key before pairwise
>>> key, which goes against WCN7850's firmware.
>>>
>>> Reorder key install to workaround this.
>>>
>>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=218733
>>> [2] https://lore.kernel.org/all/AS8P190MB12051DDBD84CD88E71C40AD7873F2@AS8P190MB1205.EURP190.PROD.OUTLOOK.COM
>>>
>>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
>>> ---
>>> ---
>>> Baochen Qiang (2):
>>>       wifi: ath12k: avoid bit operation on key flags
>>>       wifi: ath12k: install pairwise key first
>>
>> Thanks for fixing this, Baochen.
>>
>> I noticed the patches weren't clearly marked as fixes. Do you think we
>> should ask the stable team to backport these once they are in mainline
>> (e.g. after 6.17-rc1 is out)? Or do you think they are too intrusive and
>> risky to backport or similar?
> 
> Yeah, I think they should be backported.
> 
>>
>> [ Also please try to remember to CC any (public) reporters. I only found
>>   out today that this had been addressed in linux-next. ]
> 
> Thanks, will keep in mind.

+Stable team,
Per the above discussion please backport the series:
https://msgid.link/20250523-ath12k-unicast-key-first-v1-0-f53c3880e6d8@quicinc.com

This is a 0-day issue so ideally this should be backported from 6.6+

/jeff

