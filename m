Return-Path: <linux-wireless+bounces-27013-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9615B43EB5
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 16:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F9163A62F7
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 14:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63E7308F19;
	Thu,  4 Sep 2025 14:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k1Xtgth/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F006308F33
	for <linux-wireless@vger.kernel.org>; Thu,  4 Sep 2025 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756995871; cv=none; b=NMoc42WDEsmjYr0xnbuL0odNGjyYL64wY96SYGGs1gwWFgE5Bl8kx5XZd2d8WaiPxa8bD7nHKzd7naqgnQ27KNmppdbF+iTmRONW7q7Ud4+BBN60uZ47Q8z7PzGykroWvKksNS3Z09RrR6mgcboibXM3GG4i3wnLbEF2t1+o+UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756995871; c=relaxed/simple;
	bh=+jC5eO0c+6wLrwz1m3PfrUeAtN3PqYAEgrYboTlAIfk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nRmKe67zBXcTeeI5Yid+wZn5SLA7B98HoOhXGOjI4qRVSnxk+Kra4BSaRELd7EZZlWTgdHrq74My9H6Kpxr7NJxDF3NlND+AbUvi5jtCvyknkg/ebkG5XwZVQm+IubqQBcOaObFSVIG5GvHkMVZD6s/Dxhgp8CrSOf6jfnPlFYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k1Xtgth/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849X7C3003768
	for <linux-wireless@vger.kernel.org>; Thu, 4 Sep 2025 14:24:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ecdWL+gMctvmIk4A7C5DLi8OCbzaOb4CdDwJ+hBWvlo=; b=k1Xtgth/aeQC2R8E
	PUyyX270lqABz/CXcfuCxYwb8GgeGI2RyGQ222RogAJf+bsG8ujHRq9P7Jf6II2U
	uy5L1MR4ysCHcEy5HrWKKFtZ+QHxt7JEcInQxmpU5z4J2hsayduCtgHkm98MUhNg
	UeGlA5cbKukxadutoa/dQOuP0dXpAcrslCkJCzdfK/j8ghsZ9Ip+HMX4EinmbXGG
	EntVi4Ecx6tf79/yJDnLz5g6MC1MARXp/+3atgP9NQTyEHK+coK1e14JXupfEBXF
	ez4S1ikYtCpeiG6azZY7IanCIoYJPP/WuA1yED1nZVFwJueDQzj01a3FjAVoBBbY
	FXpM0Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8s7tuq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 04 Sep 2025 14:24:28 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-248942647c5so29158985ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 04 Sep 2025 07:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756995867; x=1757600667;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ecdWL+gMctvmIk4A7C5DLi8OCbzaOb4CdDwJ+hBWvlo=;
        b=GA+FrR3B0zHcFC83ct0oHx7eMwwmsRTKyrWC/P0Gps52jSMnfK1kslzB6YPWUMFkiP
         fV09u3IwnUwGXs+6VhfpC1yBpSYdCo4xMtScQgId0QdB+Ma+KF5Cy7lv4U+UIpT5R4lx
         NZLWVxDG83VqubTwK3o83/9G/Q4C7hGgusVjXC4L93l2R6vjsi7yOuiahgz4jyKTti7A
         9JdTRkFzDM210upvejdbdSPMbp51i2bi2t0/8itbauFerT6+NGewfRr4feNHO4hWALR1
         oAtjHU9z9YQT49rkG5o4CBfLAd32k5ZKnR6VYsEOO3sK7tBqoXlW6uz22jk7SO5G5+XG
         sG7A==
X-Gm-Message-State: AOJu0YwlKkvWDfhPT6v/VsND1eV1Fe5hGemoWCkUYTA+v735yB6dr7sq
	oyLhGe7E18J/+ihy+cZQs3ppBgSwq2/LoZuRAePvHIRRRiJpbRxQqvCIBFNbH7QyLD7FMfDpSfG
	dMDGRXBlzv92fS/IUoubsFtncky7zOjblQ0MKZuKz5ToBzXg75VCDaPUKTky4ombJkBZG7Q==
X-Gm-Gg: ASbGncv+WUaNdQPvjwj0Wx6xN7/Diw2bKsHyj/2BTJj8LNuAmEJXFvvwd6+o3IuL3in
	0XBMGJgJTbzjJZwV9Z6ZiA7LeFTmJo3+0UFQuM2Yr3/NLIAIEMgU8738YVjszlDBU7CvOHKa2iu
	QaRm/lgj9U3UG2bF2piz/s9oDY9lEgYiErdPh1Kdecl578MVxvyC719zXzvv2iwpxpHjfSD2RQJ
	KWcff6f+ERFeJ/rwHp9WJR4ovyhEjAyXzUBS2KCJmW9FZOiDBvp6ItbER/SlGrj8wfi/rZ9iD1U
	Iaq/kbkAD4Xk+dH1KbPY9zkQUdSC+i3t7XUYNnFdPKebV+nx+D77OWP/9yhl/BAWKbhLGytcDta
	zj3GhLnjW2r47jtnhwUxn8uLe
X-Received: by 2002:a17:902:ea02:b0:24c:ea1c:1156 with SMTP id d9443c01a7336-24cea1c14d4mr2881575ad.24.1756995867409;
        Thu, 04 Sep 2025 07:24:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYkWaooo7lvy2SHnG1OKcPL6yZ9fqmrBdzyaLzPeQPQyPF3rWwNLsETI7CnYlTGgzFdx0jXQ==
X-Received: by 2002:a17:902:ea02:b0:24c:ea1c:1156 with SMTP id d9443c01a7336-24cea1c14d4mr2881215ad.24.1756995866878;
        Thu, 04 Sep 2025 07:24:26 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7725f0c4008sm11336627b3a.35.2025.09.04.07.24.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 07:24:26 -0700 (PDT)
Message-ID: <e79d3239-d536-45c9-b081-09ea7ba5bb00@oss.qualcomm.com>
Date: Thu, 4 Sep 2025 07:24:24 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [DESIGN RFC] Critical Update handling in the kernel
To: Ping-Ke Shih <pkshih@realtek.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>
References: <20250717045540.27208-1-aditya.kumar.singh@oss.qualcomm.com>
 <1a77ca6a35ad03f839b7c997de3977b521d88edc.camel@sipsolutions.net>
 <fce447412112421887a1a81f5ada850e@realtek.com>
Content-Language: en-US
In-Reply-To: <fce447412112421887a1a81f5ada850e@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfX+nULZnKS/cYi
 FAYbzqkxGhlg+zTYJi1s3PGZPenzsJkuxKTuERjvFjO+I8aqF979l+IWw5/8qAN9mfi0nA/rzsx
 NFpgppKGYNtNF2BRJo1w/Bf+VRn33TTpLnVZSuwgrtZWWI875Rp9tJ1gSAVA/9zPjMnwWKpzaDk
 ZxXodlM/fVi4KfRsHhlwHzXpuXyjWehB8dS6MgJHBk7E6yt2xkUp16jM7L0bE1c/1L2AZiygElN
 E7bXQt2txE7KUipZ6LpRFDPkc/ooEj3LMHZnlSdljGOx++CQpW40J9OTMVzpxh2Q8FZhPfX8BUf
 h9Yq2JVppB2i1GX0K3X/1tI7/MdlaHsThskC1Fl/jEx4xi57YAyX0AC5Ecy10KAuu3xxhJbeZEx
 sfrTltcI
X-Proofpoint-GUID: h2sT-ao07aaIMdT3-jt3GFNlkag76Vp8
X-Proofpoint-ORIG-GUID: h2sT-ao07aaIMdT3-jt3GFNlkag76Vp8
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68b9a11c cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=stkexhm8AAAA:8 a=4fHwpUKUfmS_V_Wzw-EA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=pIW3pCRaVxJDc-hWtpF8:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019

On 7/24/2025 1:48 AM, Ping-Ke Shih wrote:
> Johannes Berg <johannes@sipsolutions.net> wrote:
>>> Before we move forward with implementation, we'd like to confirm whether
>>> the proposed design looks sound. Are there any concerns or potential issues
>>> we should be aware of?
>>>
>>> Out of curiosity, we're also interested in understanding how other vendors
>>> are currently handling this feature in their downstream drivers. Is it
>>> typically offloaded to firmware, or is the logic implemented in the kernel?
>>> Just want to confirm whether all this will be used only by mac80211_hwsim
>>> or will there be any actual users?
>>
>> I think Ping-Ke previously indicated that they were planning to do
>> things host side? I'm not super familiar with the timing constraints
>> though, so I'm not sure what that might imply.
> 
> Yes, Realtek vendor driver handles the feature in host driver. Having not
> tested CSA and ML procedure mentioned in this discussion thread, we
> are also not sure how timing constraint to evaluate if we have to implement
> the feature in firmware.  

Ping-Ke (and Johannes),
Have you had a chance to review Aditya's August 21 follow-up?

We'd like to move forward with our firmware-based approach (since that logic
is already shipping in our OpenWrt-based systems). Perhaps Realtek can propose
alternative host-based logic, and there can be a flag to select either
host-based or firmware-based Critical Update handling?

Thanks,
/jeff


