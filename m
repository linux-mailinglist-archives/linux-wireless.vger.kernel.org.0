Return-Path: <linux-wireless+bounces-24234-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5305ADE1B5
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 05:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 095C5189AC5B
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 03:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5CE5475E;
	Wed, 18 Jun 2025 03:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m3n/VMBX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC23A28E7
	for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 03:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750217849; cv=none; b=GHbcxmsxhqJHQrMcGVz/zPdUaow72BmmXpKfQJN0YSEBtwO7n0e85laE7qLXE5wgdObRZEfo2EgVK+aexe26LKPP1gP8zQxOeUY7ctPp8Bk7vl8FZBO1VuBqoSufaaim/vjNXzWtyi3HAc0CF18a8iWVy9voTLRi//cZcAzqzj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750217849; c=relaxed/simple;
	bh=f29PUTzurnAqjTL5Z/wd3QXuwqkkzcw2/F768Z+0cK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mzurgT2y06qXN6SSt5c6BTv2jZAxwXzMeX1kYt9FcpHhYORM6Yhg6W8+zHLqHJn+NYWz0nVN7HpX+x6S8hG19Rg8vvoCVjErDbhgWE4WSaMh2sCJS7jVIp2pdmhRVKy7igXohF64UyK44r4qkmVM98u0YLAvFBFFvz+6bMLc9wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m3n/VMBX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55I3TABG027539
	for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 03:37:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SH/xLON/sF+RHyfqsMlGQqmogH2BUwLihx6/jpfEEdY=; b=m3n/VMBXVRWxuGy7
	mhHsI7Fi2d+DBJ/mfJ4tTRmJiUKnWdOMNhOAbH0z1wNL9EelBF1klDWZJr+cNx+I
	nb5oSuMTOZ3lv2U7xVCHjrDjAxI7asDJwbHzBGqwZY3wfyDlUH17eXUZBZCem7vT
	PUEMWojZRIfQzctIxMMPWfZvy4e/94fHc0R2YEpgyBhUfGQ+Omm1mZ9QranM58Np
	Tky4IILNfsrbfa53ZLKb8HUfdTn7/rms4O1wbHvGAA8KbpJVCGGfE6yPNBNf8bbi
	IVAH7kNjVQ9jHd43Q8ZmMONaKNvlanEmeCVv7dEDEyPmMWYTMf5auniO/9iVQVlj
	DNL+pg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791hd2nek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 03:37:21 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-235e1d66fa6so63097345ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 20:37:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750217840; x=1750822640;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SH/xLON/sF+RHyfqsMlGQqmogH2BUwLihx6/jpfEEdY=;
        b=R9d/tBkgxO5OFfEzhF3bg/fB7D0wIl6zKcAyNVuOXzq02WZvOtqXvMmETnfJWXL6pC
         VQ1yiPYvdEHpSp73WFjQy/GxsZiramYhSnaaFObTSTBwTP3nDr445BBNoTRNv04qwMkf
         JAm5B0PRzJ8q8bp4RxohRHG8zStq4c3BUW7HsND8cde6IO3aQ7iARhnZ7GVX1NvFgQag
         UMnQG1iw6Me5lgA+z81LqntGB1JH2r26gdHsGLtXJt6g9ZPDuGU2N/pnqPufx4N5E7bs
         p558w4NOtiuBlMbDUgwOpqMNXPO6kmpXbBH8Ppjn7v5LHWE9z+9Y5bqNYGEGfHY1K0gK
         eyyA==
X-Gm-Message-State: AOJu0YzWRdiFdicZh0fZaso0sqvonqyBIQL6V/ArL00psthn1cPr5ac8
	pIXqxo+SLQ3eVfjJjd3659VffW0zUNMEcGVOsO5+vVg5KbOoBUTwyqJccgwrqzeDahCIimSNdEm
	VgZaO8lvMOPUs1j9DwONk4j2ushft5Z2MvF9JYTmJMFpuChxEaRV/lsh3CFiFlCMis+jl4msCyY
	Uygw==
X-Gm-Gg: ASbGnctMQE3Rv4NCGcNsCssARz7GMUszFc+LU7yxBIH0qbhB7XPJE92MQnaGZBGLIyu
	U/0jzBycKLTyGmZ+zyY4TBoy5v1oSjc9stc7dVKXg/G/EBgWakA/dfyiwoZSUsINNJBSnySDsnc
	2X5H41vAnyPQ0OkgxfGT9SQtvOXkH1K6niskspL54E2SDpPUPqHiD22+uj+zds+8P3hxcaPH1HR
	+LEEAjMeIEWkI+5Cb7dgpm4oQku/0ezImjgr3XdpzwNmMwotPsEzwsPOOnWGgBdIrwdBtyjLelt
	BjelBYZkxwqoXe4KQOamNL/tSgVgyZFuhWSyKIGmHgTnZJ81zpEAT0blwqraOA==
X-Received: by 2002:a17:902:f710:b0:235:f45f:ed53 with SMTP id d9443c01a7336-2366b12fdf7mr243385425ad.33.1750217840155;
        Tue, 17 Jun 2025 20:37:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHak5M7iv074ewtls6BEJbLqeOl4DjT65kZ9T6yLL/AQRZ+K29GlOkPYFVEimnTq9V8mvUYCg==
X-Received: by 2002:a17:902:f710:b0:235:f45f:ed53 with SMTP id d9443c01a7336-2366b12fdf7mr243385115ad.33.1750217839747;
        Tue, 17 Jun 2025 20:37:19 -0700 (PDT)
Received: from [10.152.194.206] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365decb846sm88993475ad.227.2025.06.17.20.37.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 20:37:19 -0700 (PDT)
Message-ID: <00b8335c-4692-4d8b-89df-4196e11ddaee@oss.qualcomm.com>
Date: Wed, 18 Jun 2025 09:07:16 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: update channel list in worker when
 wait flag is set
To: Kang Yang <kang.yang@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250605082528.701-1-kang.yang@oss.qualcomm.com>
Content-Language: en-US
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
In-Reply-To: <20250605082528.701-1-kang.yang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDAyOCBTYWx0ZWRfXxXhHLugqlCz/
 jOQGt89eO5m0saavnpTOWxvdesnM8PjzUsnYPs25Ml/6kUwO102NjthFYj7n87Zt9QFl0jEwO2/
 pEeyiFFhaiKfOfEASHn3i5gejEy+XsgIIvOXRgmgq3X83LD6HNmJ537+db6mhDuKaGvUN+BW6VJ
 CAgoN4qOGTBNVQYFMTBOtck8ErjgT8Ta92BFNoHJpgpriDeC2pWBo4nPKkwHLkwJ/FMDuJINoog
 FalKYpnMCbu2HKO/g6E+Ou9zxHZK42nBAsK38GcYcyK13hHJ16xpfoBPEowcuAX1elzSw0kCk3F
 rkhCUOpRbrqpvSXxH35Y+iEXYmpmv5XwgOk3uS3pTk7S1UfC9jrBTCcJuZzrrrb2MXcdbqiid0q
 405QNGGEp1WQFX8cqcW78n10TvoscyR7Niy6IDputEpQUEDl3MOb87mwPL3QDwIWAoplYG+s
X-Authority-Analysis: v=2.4 cv=PtaTbxM3 c=1 sm=1 tr=0 ts=68523471 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=6o_ezUq-1U3ah4PhcdwA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: o238NUhNEPhGrFon1QdM0TRvOuaWO6va
X-Proofpoint-GUID: o238NUhNEPhGrFon1QdM0TRvOuaWO6va
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_01,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 mlxlogscore=959 suspectscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 spamscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506180028

On 6/5/2025 1:55 PM, Kang Yang wrote:
> With previous patch [1], ath12k_reg_update_chan_list() will be called
> during reg_process_self_managed_hint().
> 
> reg_process_self_managed_hint() will hold rtnl_lock all the time.
> But ath12k_reg_update_chan_list() may increase the occupation time of
> rtnl_lock, because when wait flag is set, wait_for_completion_timeout()
> will be called during 11d/hw scan.
> 
> Should minimize the occupation time of rtnl_lock as much as possible
> to avoid interfering with rest of the system. So move the update channel
> list operation to a new worker, so that wait_for_completion_timeout()
> won't be called with the rtnl_lock held.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Fixes: f335295aa29c ("wifi: ath12k: avoid deadlock during regulatory update in ath12k_regd_update()") #[1]
> Signed-off-by: Kang Yang <kang.yang@oss.qualcomm.com>
> ---
Reviewed-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

-- 
Aditya

