Return-Path: <linux-wireless+bounces-27981-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBEFBDF74A
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Oct 2025 17:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72E951A20781
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Oct 2025 15:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE67D320CD5;
	Wed, 15 Oct 2025 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F2XkscGF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DB9323406
	for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 15:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760543021; cv=none; b=J5W9CI5TU9RvZSnLVaq5tRx19mhmW8CG7krfzPje7lKVkFn8bkFi7GjUW6UV8fFOHY1GmG+5UYpjzU0vet8SO0AFIYmDHRbfW4Y2+Xz2E7Snd17yt5JYQCaDUXCpp1fbyHQw3wCB71k24R1+XeZoGX47eVl2g7aCJMnImLnTQYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760543021; c=relaxed/simple;
	bh=S5YTzOmEgD9frthWaWUhAzOrRFU3jUCYixtVAZFmHtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cPwUvm3ipU12uNAWQdmhFjwfbbPYHBiHqCkE0MiySvNb4G0eUHBkXzQ9YyqyXx+2fcydG8FGEh/QI9PLVNt0chTKaJqCkD6HaBHTNkYljiv7eIRMbdlCJIFBeAJ+tjoAxqMy1B+YRmrLGpYltN1Qfk8vBAj1XbkhoZYVlWqWFlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F2XkscGF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FAjFhM004230
	for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 15:43:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZlmsSHrLJYXaKznqs6bL438Vt/4Grdh8SIvj1W2VJP4=; b=F2XkscGFHATu1Yof
	Dffmk1QP5JkTyGJIGHCX+Y6S9dlWf3L8oswHkgXtOcUjv/jEHsmRnvQb/lM/Hxfd
	Ap1FqKew8Lp7xXVkAtdARH0L3TlGl3p4QwZqOrUQ6pWcWUW8w8URvEvM/MdZeBGJ
	5h+9m8+eR88ADkLByTwZWdNskhdS8I988GyK0/E121R5HBTKVSZ4U/wiz40gEHzn
	DPqkU/bOAveLUvxYLw2A9FANVbrgBkS18qcrk8dq5RDDzeoP7lFPUwT7Xd2caFQf
	tDVr2arK2n/7VH9RWOkRDbiH0I0NSVW/pw2T02+KjnOT8AOLXDtim9HZPpE2KGoH
	aBJaPg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49s6mwq8vp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 15:43:39 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-33428befc08so23007704a91.2
        for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 08:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760543018; x=1761147818;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlmsSHrLJYXaKznqs6bL438Vt/4Grdh8SIvj1W2VJP4=;
        b=CRX6yACFaaV0kA7mceUkcghP6ibu9yOv9KJkP73geZDOw0Y0tD0P2shutks7kSGAe0
         lqzCbsSkbPZsBEVjfMMDNw5yZu24Ae1F4xMKXRHevKz0Tnc6MRfyE1zAaLsitZiEngPi
         4jYt9/q1iRjsvlnQ/nIrGdgCn8qtU9laARhBfj4Gn5mzC9eZjyFp6dQv9lKBDRa1vxPc
         ekTveSR0yGr8Iqg+/XVcY5e6ffcguhvKJ6u41lfilHpwdJr1gfLklyG2unynB9cUlgV6
         h92g+BNhdOkrNZJ/7/kGjzmqi0DAIWLZ97bRTD4h0rsxiqZQPD2BFzopvMKmeKB5rD1b
         5IJg==
X-Gm-Message-State: AOJu0YydQWO3ANUkjAo+eTbAiI8TUXAdLbCu2cpQhdQWnmM/+JksLisc
	5J774AJXI2KcOeW68z7OtnYR066LyBmUS6rRgHLHH0el0vL7BVmHvtwhmsPSCJYpcfurmgcWdfc
	Qlo8QYeg5eESODBAesoxHU+WMofYpfFDsK+GHcGcybDgy3JUP0rfWanfqnLz+QS0JeVogDQ==
X-Gm-Gg: ASbGncu9PRYSvoWYoIMwcTlXKh1sU5brq6+gQ3ep9vW2WQ/2g9KkJ01KzxrduHEYezQ
	cDwZZPazM+augi7zW3pwG2bIbJw7L8TNLW5tb8PLKPC7LRvAM80UHQjrBmhzOng8JYitO3jySw+
	MCMPD4c8s5CxViBFXqFjzFh/+s/hSLWx7NS13qmijJg70n5EpFN907G14nj5sySGN0nd5KE7VA4
	c9KETsazDlFFxq4el7JFRny2vdkOo4JIKeTjk/M3KKQA4bBAHu3/8+MzzwM+FYmY7VEcQ6enBw9
	40cjMXVmNxOqHj0E5RjmytTqTXkimyS+DSL8CwlB33gSG+ZuBWkFzjV4ldbqP/yh/In72jbP8JR
	IKN+BtzwB0nofGHR6
X-Received: by 2002:a17:90b:4b0b:b0:32e:a535:4872 with SMTP id 98e67ed59e1d1-33b510f8f79mr35812696a91.2.1760543018361;
        Wed, 15 Oct 2025 08:43:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzxSFXoULbOdZeQn2+c/zLnbkN0JS7GXtiAGLzcTxkdGfgAibXxaQEbKeu/7KLUzII7AKu8Q==
X-Received: by 2002:a17:90b:4b0b:b0:32e:a535:4872 with SMTP id 98e67ed59e1d1-33b510f8f79mr35812679a91.2.1760543017894;
        Wed, 15 Oct 2025 08:43:37 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.230.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b97879fc7sm3021860a91.17.2025.10.15.08.43.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 08:43:37 -0700 (PDT)
Message-ID: <f60950cb-c66a-753f-d657-e76b6c63ee10@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 21:13:33 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next] wifi: ath11k: restore register window after
 global reset
Content-Language: en-US
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
References: <20251014-ath11k-reset-window-cache-v1-1-b85271b111dd@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20251014-ath11k-reset-window-cache-v1-1-b85271b111dd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDA4MyBTYWx0ZWRfX/NZQpll8aJyo
 D1ZIeWBQ8G+C7uyiZKAJbKRYIc0Q4L30TrbJsuHJIFcJPZcauwCmWi2LOvDrv8gTwsbifLrvhQ9
 diNfgLSCpCxFMJHREHSs8m6YRp5GZG2oUkSWOgcqzyz0evTIDm9tk91tCcan8nbMTJT37Rj97QH
 j50OcSvIEA2SDvuujElvSzXeM8D3G2OASYxr4zYGeWIgQ7tgKiyTbQ9A/VRfOBUS9O/HbFFwuUh
 oYLCwlTCNKPEv+uq3CBwOu/p3gRvU40koOObcHN111DFHdufdcPYnFl3ahA2ciSNWTbw7XJcQib
 7woCLJnKdaRXko6l61UjYh5RZ5jwLJZFykrT7bezAglI0qDcx1oB7Zw2JPZgXnRGZeQNZIWPIzd
 vOmCFf3a7G//MVnMGA6gxpxNUbv4pA==
X-Authority-Analysis: v=2.4 cv=Fr4IPmrq c=1 sm=1 tr=0 ts=68efc12b cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ywaSrutoL1r6B8MZccleLQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=0ta-gCHYuXx5BB70YVgA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: ZiX_NtxN-sBJculTFtIq9njALNOEdpv1
X-Proofpoint-ORIG-GUID: ZiX_NtxN-sBJculTFtIq9njALNOEdpv1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130083



On 10/14/2025 8:00 AM, Baochen Qiang wrote:
> Hardware target implements an address space larger than that PCI BAR can
> map. In order to be able to access the whole target address space, the BAR
> space is split into 4 segments, of which the last 3, called windows, can
> be dynamically mapped to the desired area. This is achieved by updating
> window register with appropriate window value. Currently each time when
> accessing a register that beyond ATH11K_PCI_WINDOW_START, host calculates
> the window value and caches it after window update, this way next time
> when accessing a register falling in the same window, host knows that the
> window is already good hence no additional update needed.
> 
> However this mechanism breaks after global reset is triggered in
> ath11k_pci_soc_global_reset(), because with global reset hardware resets
> window register hence the window is not properly mapped any more. Current
> host does nothing about this, as a result a subsequent register access may
> not work as expected if it falls in a window same as before.
> 
> Although there is no obvious issue seen now, better to fix it to avoid
> future problem. The fix is done by restoring the window register after
> global reset.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

