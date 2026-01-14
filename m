Return-Path: <linux-wireless+bounces-30822-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AA9D1FADA
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 16:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5941D3047978
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 15:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6C23191DE;
	Wed, 14 Jan 2026 15:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OfkRh90k";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IAviAJbp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103C526CE04
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768403630; cv=none; b=WI9P5SUTOER5SFUWczLcFSXm5ZBGTFtHG22SgbH4F183tf61/6xU70t1AHcsmRAaMCBRhbLX926DC0RsQZOucosEw3dodmsEdNJZBWf80g9yiC8irt0Sknee/fQ7VFmAkQICO3Kke/iZEB6uNo3uTwVFVvcGKIZysPZwV9Shdm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768403630; c=relaxed/simple;
	bh=pPbCTg8bhX2UM5WHOWZ3y3gxRg637vCwar2DW8Tuy9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CoDhkQPbIeE94mC9zeD6z61M2aTxQITKil7xxZxFjhZPZPR0a4VrlhbVG3CO8tSuIoMUMj26/9x8Kc/pZaWwtHuDlbF/2A5gZphJsKx19kzQj1+JwK1ikiGWRE5GAPAVRrWMUMAiTpCMmHjNstziLoOpAXWD82I34Cc1SvlzTcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OfkRh90k; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IAviAJbp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EB2ZIu3416148
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 15:13:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pAMa8b+pnjmawngmNFoBkoxVHrQu9nmKZxAfyT5nEVA=; b=OfkRh90kkBzRfjB+
	TrHiZFodm1rMkrXeNAe/ZRfl9nFCqMA5x+w/OX/j9VXzxw3adUx7fFNkIA7vOGK8
	RwhDH/YsnVp5vrI/DQftnHelkAugA8RBHCNOndO1ddcdil0aZn2HTxZKmAMWZs7q
	M4Fhw7y6dY9bn1yd0VHoBi2VjFBImsQ2XU+D25h2zbuHvD3cF1ncnurPxy69kLRU
	FHHQg771egZN4ShHvv1aHismkVJewuV2BDumqxguDgjcJPjxnSfAe1UBxEQAPkoD
	ahuKOtzaJXE1QEz1+WLMbouiAZpXHL2nDuREMaHU69omPmhVnUi3ZyOfatN+ZXd1
	UfT2nQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bp9x2gr6q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 15:13:48 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2ae25c02e7bso30943621eec.0
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 07:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768403627; x=1769008427; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pAMa8b+pnjmawngmNFoBkoxVHrQu9nmKZxAfyT5nEVA=;
        b=IAviAJbp1lstXJY1KTueFoCUgqTs2aiPF/rX9mlt17VT+tlTqZdf/s69YTb64Bmz7s
         jU6jF3DnpbO3sVwVnIZHiPbr4HAEp3/2QDxHPyFNQQ82tWC6aRfPL+7KPcpkk9QVtgre
         rAQeBTxy+kdAWZAXEUcehFWSCuGBkHks2/4BSEwNxUj4tmV7Q1HAU9T6YsxGoiu9nkua
         0cBxAPNO6BmEt+x/O26nKqFfEplG/2aMoH20Mmxv56tJ9R9SmBG+nI9rE+NnCa6DDVrp
         MFKZhnhm3dLd4kKxn25bXG0RDzJfIMJPnHvA5b8lckiBZDXBfAfFCGohL7dHDg2ciZJ7
         Sp1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768403627; x=1769008427;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pAMa8b+pnjmawngmNFoBkoxVHrQu9nmKZxAfyT5nEVA=;
        b=jJYqBFiQ96lRKuo4UjnpFpck+80gdCRIp05de1B2MeDOOXl6SR+lFeFPYZzMqFJgdu
         04tbWpcOdU2ebJVKL2gYH/JwwG97yLhvTWnV7E/vVclwAy9iZO6qt5UluCVgzWt6K3K4
         INJlViPGLvK0hZpu5m4LjiHN0csfkev2AKIF7ms+oaKF3sm1J1CKdQEzLO8z4Eb6RnzL
         9EY4wOQMb3I4XyRBvzelA7dYa+boRdspXDUnl2DQS/lP+5BmzYULobGYzpgFrxwgJLzC
         hY2kwpoaj7NfclR6lJzURnGpPZJSG5fN8xtWNrE6N+xOps4RpwQe63YBKCNV5H/vL8yR
         9vIA==
X-Forwarded-Encrypted: i=1; AJvYcCXVOnBkDuOFK20Ysn5JrkzU675NPKi60Xve7g32hCvCS5y2YqT8yXJB8jeoUNX2uj606nTDg9lxbXaMCg7uNg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBxQDV/t4FQRX0fdSxMjdH9HpKVq6o0WyEQCLpHvMx7PHOmBsP
	9Fj752/UTi86aIQPBOJKxRxQVw2vQc+tVdHRM5rzzXf0aypXfCqf73c2ow62vSK+/rcy4W4MHYb
	pM0LnbXE/eHGOjLdKwWNvAOCyyOPwimg0tb1Am3PaXJjgoCfid6CxUUKUKg5UWLVJoUY8qT9d/f
	9CCw==
X-Gm-Gg: AY/fxX4OTR0wTHLFDzeKSFbWPh0GiB7Hi8lK8cmkkYuOSbPFSrFLHEYD4y3hSyoOC6y
	wFhZVtWd5hk4HpAtX6S32ocio5Tdcz3VtFQoVygX0HMqvEfRRgEP7Ew1jfaqvZR4QleJT+RebqJ
	IyQJae9G4wYb/sRGSe/z1JFBcW+bRH6PKjeljgNO551qTQ2KfsDkgO4B2o49OIx67FOU1qtpKcA
	Yn6brLCVLbwjFMwZmN7lrRs0HzzH2dKWeh81PN2pDGqV541cGSWDS0up7Djc+9lYIrSkZasNiKK
	N4a8cPJAd8CTrgymANDU7Y1f3XJuBNjjKfqkSVvpzIRKR2tShsGHDWOAWXzqHLCDQRWsox1W9ji
	Ssme1Nl858ptn1O+Jtoq7hcGk98QLuqksyPM4nFdQ9GrHhgbIfWnZeiLkhClwpiUd8U7wnQ==
X-Received: by 2002:a05:7300:23ce:b0:2ae:2c27:fc0e with SMTP id 5a478bee46e88-2b4870bd16fmr4248645eec.22.1768403627338;
        Wed, 14 Jan 2026 07:13:47 -0800 (PST)
X-Received: by 2002:a05:7300:23ce:b0:2ae:2c27:fc0e with SMTP id 5a478bee46e88-2b4870bd16fmr4248586eec.22.1768403626617;
        Wed, 14 Jan 2026 07:13:46 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b175bee31dsm17962169eec.32.2026.01.14.07.13.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 07:13:46 -0800 (PST)
Message-ID: <f12c186c-c76a-4d39-8591-4c8d7d04d307@oss.qualcomm.com>
Date: Wed, 14 Jan 2026 07:13:45 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: pull-request: ath-current-20260113
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, jjohnson@kernel.org
References: <98386125-c0bb-495e-b2ba-2765aaed19d8@oss.qualcomm.com>
 <33d998cc225a7aeef4731ebc53c28a32b241ca7e.camel@sipsolutions.net>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <33d998cc225a7aeef4731ebc53c28a32b241ca7e.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ox1QjklIQ0K2GC3dGWo0HlZAi6PRAfQS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDEyNyBTYWx0ZWRfXxa3oDfcQbWL3
 FNkxxYV21P6O0A6Nm+gMwY2Nn5Lezb70DDcYn9yEkRot/RHH81fxIBKs6Xu3+7r8NUQJAuSa4O6
 Sw/GFRDDTWfWcFjhRFEiKP69fS7HgFztZmHTVvbTvgJqKOs3bltlgPeRc9JW8Nwv8OHU4E1CpLm
 uNlHvOtyb0IpZc6dIjiz7uBc+70adJq5Lozg13rUFco9Y13mCZEzNkHMprS8/5+p1SZsr22A5Qw
 qHpTyW7oqB3/e5a2tbEXWCXIqzA25evXJi4mKKV7e4CihKkHbGAcJxzA6UJTTtCzu5GFPiAdfXO
 yvfhfTkavqtuj7YvLl+jUcbPNiubMF2f63cfXfaw0iVZ+gLCzqxslsmUKXX5FPpyifrIansGUWH
 69ZObBsDxtpRUhksxrjHESCbFXuRzmrz+zVIHS94dCC/S1E2i1WUsX2JIGyajksRAEB+fuOnBqd
 cXNylJg+k0d/DRFdT7w==
X-Authority-Analysis: v=2.4 cv=Fr0IPmrq c=1 sm=1 tr=0 ts=6967b2ac cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=s_ggy6vDphFXL1rJ9sYA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: ox1QjklIQ0K2GC3dGWo0HlZAi6PRAfQS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601140127

On 1/14/2026 1:47 AM, Johannes Berg wrote:
> On Tue, 2026-01-13 at 09:33 -0800, Jeff Johnson wrote:
>>
>> Note to maintainers:
>>
>> This tag includes:
>> 31707572108d ("wifi: ath12k: Fix wrong P2P device link id issue")
>>
>> That commit contains the following:
>>
>> Note to linux-next and netdev maintainers:
> 
> I'm a bit on the fence about this, I hadn't thought about it on the
> prior -next PR much, but I feel like this is a process thing that
> shouldn't get recorded in the tag for posterity?
> 
> I do appreciate the inclusion of this (*especially* when I won't notice
> the merge conflict myself), but I tend to think it should be in the
> email rather than the tag message, since the latter is something I use
> for the merge commit message and it gets recorded.
> 
> Either way I have to preserve it manually to the next level, so it
> doesn't really help all that much, although I guess in the tag there's a
> chance I could see it again when preparing my PR.
> 
> I'll just edit it out this time I think since it's so long, but you can
> complain and convince me otherwise for the next time ;-)

In retrospect I made one bad decision. I modified the commit text of that
patch in my "pending" branch to add the conflict resolution information.
Instead of that, I should have reposted the "pending" version with that
conflict resolution embedded in the "basement" of the patch so that then it
would be part of the email record on lore but not part of the patch record in
git. And then for the tag I could have referred to that lore link in the PR
email. So this was a good learning lesson for me.

Hopefully these merge conflicts will be much fewer once the refactored ath12k
lands in Linus' tree in the next merge window.

/jeff

