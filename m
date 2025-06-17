Return-Path: <linux-wireless+bounces-24221-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9A6ADDC10
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 21:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4AB34A18C2
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 19:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FE4277C86;
	Tue, 17 Jun 2025 19:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MD8pljo5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3AB215F42
	for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 19:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750187435; cv=none; b=GSoeKueL/qmTaD5dT/x4AWA9pf1NQ9IjJJ/q6JiW7rGqGsVz7Szfhed+9o2hcz5D+QrhobQphE4GYQguMDNHOqoBN48yBWMpLjUIU1Iejo0/areKDmm6SSyh99MFZ4xL5M4llimRfxgpXCOlUWeNfUth13U+ZG5V0xWh6Wq+5SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750187435; c=relaxed/simple;
	bh=L+9OMSQBWMtFERWxIUq+ka3HXLpVK6R7V5M2DG3Eep8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FJU15YGwBUgRYdBpaw9VP8nKpoIB18r6k0YzvejQD0bYGU2oV8hPr83lHnsGvXYpBOVXt3IQb3R6iBDb05cqKpomr9R2jk5HRmz4bLej6R7Dmsvg7EPxhZJoaifg6PUkY8vAULNv/6Vjerw8gd4QHX46l+3Tx0zjXbCzArG1mWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MD8pljo5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HCPGJu019929
	for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 19:10:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Nw0QUXlsMhEkFgTso96jd3TihQNPbPKo3B41cVzkc4g=; b=MD8pljo5QwEWTft5
	H6OemEJFlVvF6pnSmz6rK9zTT/JACVs9fMBEhvNYXMZV2dheOkE6BTLuuq+IC/6s
	SBtcBjIkI7GcoxiOP6dhyB1076+f732B3TJtYR0ZndsKUsrM5ZDBPTpXhzSozOBo
	07ThwAmKhJdA3yWGShMDsIuPl1VZ/jQHMAcYyBO4ZWrt1Ym+MvG/e+F9q8h2yBhn
	bDRajbpI3bQIWUT91ChAbUHQutllab8fpVjisf2ceH7cYT+Ky4MqdnhUS7hJl64Q
	40OCp7vH3i1UWb/OFk2TpEQIK0aOL+9fDF/GbkZse959ndQpmM9hljcv/Mq4Qv++
	xBIHEQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791hfhjkn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 19:10:32 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-311ef4fb5eeso1995a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 12:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750187431; x=1750792231;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nw0QUXlsMhEkFgTso96jd3TihQNPbPKo3B41cVzkc4g=;
        b=lMYsSndQx84C0ZHfikbYi0zdNfB3Qa104kEILIAhRNp329h12NmNghO9cBHPA/xXgC
         0piUq3Eauee2pJeD8XIKAraqKWgsAL/qyub0HfUZf30wghO3I/8ajHS9euvm/dy6xyW3
         nIJ8x3jEfyenWxRYHWgu0lw7SERSZxRya/7SAcqrIqNBx//dInohp+7LVWHXk8YWo1dz
         ALbo/Eh9iXdBVwI0UDQ+vfGf4LGz4cGlRIUp42RNY9T9tCyUM0hDbcDjfEyeBZLpMyEQ
         yPUHDmIn+F9jnkf5tPGBn/x0xPD0dnn9JtOuc0qUx5kjY9bACyjM5Tl0gxlYOKPCnlg3
         dIOA==
X-Forwarded-Encrypted: i=1; AJvYcCU0yz6j0qCNPkntW+F+XK2da6e/mAkw6wHEz9+mcxYnogfMLnxReQFiE1RA45VMem8hO9+B1DqquoZXnEONQA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yye4RAumAGleHIL9H/FehAsvuxDTbS5FL5NKnp5creFZfg1tPU5
	0kQRlHm3Zb9yVo3g5JTsUGLUlhK6+6CvuSD/NwsgIruK88MpMcWLBO4ta9ZxCPw8iE84xXQvMNk
	R//TzVYnIJKSzT6I6ewghVIGuToDreP85oDaEe+w/wRWfJ/obb1lb1j9Bk1bVahhQZGhn7A==
X-Gm-Gg: ASbGnctnebTKbx//I4davQIM+93YFyb9QGpZhISj1kEEfyGbDPHIUY7IlF4d1jpF7Lq
	Fw8KW94HAZVptf4sfMtp50Jp/OGNC8sEIrbT9AE0ErOEkzBp2j+1rA7Amq0yjKo5kPcX/zcg3D0
	DldynODBwKG0OVYnGuTRjHpmwXDHqOMEaFlYh0r4Cso7g+vNvnkXeGCVc0akKMlk96i0RB77I7w
	0WJkIYGPxCV1DGNQrHh13bjHy0Q8iFKAwP2ZH7T8p0tBATXKd9aYxkpwV3TkVm5NOncxWmPBriA
	CKcncfNZJ310/yLhjqEpKd0zMOOftJyncf7xHSiU7+3grPIY8/40spfFLHRqQeB2Yi9hDcDka95
	GNx7o+cqh32FZje0=
X-Received: by 2002:a17:90b:28c7:b0:313:f995:91cc with SMTP id 98e67ed59e1d1-31427ce95fbmr5958441a91.2.1750187431126;
        Tue, 17 Jun 2025 12:10:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHz3sg+Bti7OtCetOfamrgptOPuG+Uk6MdsFlobnL9KTjjQn1QMD/1qQjKvN2It66ISolByPQ==
X-Received: by 2002:a17:90b:28c7:b0:313:f995:91cc with SMTP id 98e67ed59e1d1-31427ce95fbmr5958403a91.2.1750187430701;
        Tue, 17 Jun 2025 12:10:30 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2369ebca745sm4884225ad.100.2025.06.17.12.10.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 12:10:30 -0700 (PDT)
Message-ID: <bc04fea3-1a51-4113-8dda-5a3a38000ef0@oss.qualcomm.com>
Date: Tue, 17 Jun 2025 12:10:29 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless] wifi: ath6kl: remove WARN on bad firmware input
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
        syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com
References: <20250617114529.031a677a348e.I58bf1eb4ac16a82c546725ff010f3f0d2b0cca49@changeid>
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
In-Reply-To: <20250617114529.031a677a348e.I58bf1eb4ac16a82c546725ff010f3f0d2b0cca49@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDE1NCBTYWx0ZWRfX0Wyga+8RXdFE
 VCdhDSBA7L97buO25l5c3DAZnlcWl2RC2CXrLLMvtGq63OtRLvn8dedSso1kub7iruTmZgDPmj2
 D6Dd6N+RWwXgv7EXoz1z3XefIwlLnpDXq+EfaGzsI6CXtLXXWhxLIIkT2Eb+FKLbRV6QMseRBQX
 UxYXT9tmQDpNJ7dkggosApK6nf1FCidEJCHW15gzq5AzaiCq1n7KtGsG58XHRmclSmsD53oDzXq
 IP1S2P6gr/U465YlWICjGGP8DNV7ejRPAKOw7feMzafFVaxJdcO9Kct0rz32mo779svryrXn3Lp
 KjTRG4AVd5RehISM1p0E56RM+/KotXvuD2epeoi4XC88hHiEnIrSIjj8rImHzwYEi3CYFVy9rXt
 +W0A+7ikPdW48Nu6nfgaWBUTQeOiSyJDHl5nb++4Kot0ekCtXIdgOsi48YObd2EVonL3lMWl
X-Authority-Analysis: v=2.4 cv=VvEjA/2n c=1 sm=1 tr=0 ts=6851bda8 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=QyXUC8HyAAAA:8 a=hSkVLCK3AAAA:8
 a=EUspDBNiAAAA:8 a=pu5R2Ct2Ll0z6HGN6EoA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-GUID: 3t3oVSahDoHXi_UMynX3ajMpARqEEJhE
X-Proofpoint-ORIG-GUID: 3t3oVSahDoHXi_UMynX3ajMpARqEEJhE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_08,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506170154

On 6/17/2025 2:45 AM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> If the firmware gives bad input, that's nothing to do with
> the driver's stack at this point etc., so the WARN_ON()
> doesn't add any value. Additionally, this is one of the
> top syzbot reports now. Just print a message, and as an
> added bonus, print the sizes too.
> 
> Reported-by: syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Since you used the wireless tag I'm guessing you'll take this through your tree..

Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>


