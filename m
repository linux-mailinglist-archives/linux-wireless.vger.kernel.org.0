Return-Path: <linux-wireless+bounces-29264-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E8619C7E188
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Nov 2025 15:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 43F1B34A278
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Nov 2025 14:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A1E2356A4;
	Sun, 23 Nov 2025 14:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SksbuSa5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TqDzRpO8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE1B21CC47
	for <linux-wireless@vger.kernel.org>; Sun, 23 Nov 2025 14:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763906656; cv=none; b=VMFgyBmZzTgj1AJ+8TurUA2+mtnKFM8SHzv5CtIl6o+VBbySDqzALYvKG1bZtBWrSH75KyKJYF6PSHOwkqicZlPmQyqA+cD4PqMmgrJgFnRmqt00pE2YqEeWvbdnkE/OTB0auJWA++8EdflGhQ5R68lXx/oRbTp75h/Wfttc2Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763906656; c=relaxed/simple;
	bh=lRbjJlp59GAMzJRPEnDFBWc0sPkEwAFH9hSejHG93LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXLgwr/AVkx4avyaI5Zi8CIwXVELmKnjuQVaw1EGxWjUu7JUB2PnIuAdeobqzA9009I7N7B/tfFL2rR8XSpCQF4x8Is5Dq0c48ngrL6sch83DwZiUUuq89PiR9XNOiZedeAMNljs1PdDXIYsLi28YJjtTU6z1QRSXGDsthdQUi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SksbuSa5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TqDzRpO8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AN1STYY3711332
	for <linux-wireless@vger.kernel.org>; Sun, 23 Nov 2025 14:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=kIQXksD1+6SDUmTMSnfV9teK
	jLLZHPsYxRRVvLas3lE=; b=SksbuSa5wLyIO56XEp4lfEGOpLldn30VHHchYbC5
	58smXuRaAYxfu8AoZTnUkA5eXne1iPrdvQYk1QBU8SKQv/a8LY3ug1Fe2gu/kjpS
	6PXq/2zfyT/odEBu+shVol/Gv3q8AJg+lrevWsYz4n68gbP14Le7c7uK3Ni0Nzb0
	vIfAO5MSlIU+udhOYTrXK7QQ+dYajuUXAqkVt/5EWzswdx26ZAYg48jQCHO//PAl
	UCO0TQGEi0UFMyfysqOHkbQo8xCHJI8UQr//ayNTt7MeW3vG54V7RcsC0q8ZnxxV
	TYf+U1i4jF/I6uIxm0XKP116JMHCwze7sy8TDwehDquDGw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ak6f82ecf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 23 Nov 2025 14:04:11 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-88237204cc8so77715386d6.2
        for <linux-wireless@vger.kernel.org>; Sun, 23 Nov 2025 06:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763906651; x=1764511451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kIQXksD1+6SDUmTMSnfV9teKjLLZHPsYxRRVvLas3lE=;
        b=TqDzRpO8gfKrWy/Z69l8sFxxf7OfiuoTevaAjT4Q2MRNXnAYq28X1nwGxbiml7K3be
         9sALw+ZU0pcgewHwZYFkrTSWO2fwygok8/tYaohe4+ipH2rHgWJRHRHvkgrLYKBd2moL
         NTjIgkog77iuuBcglP0jSRpSXWGP8//WHqdMTYff4AnOhAWTLLHCWDHrBeftNabzTElX
         7hdPXR2XcBsgAFDs14g0eZAo/ygzqQAaUzJThVu2H9/lzOF6boU7ejxzJP4m5w1Z6QCj
         /lTi58rUsoTuMF2Tmi6gQydoMY89HYmo/3g79Ad1P66zR+SeZvGyhmUVlBYkWlgsyFBG
         eMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763906651; x=1764511451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kIQXksD1+6SDUmTMSnfV9teKjLLZHPsYxRRVvLas3lE=;
        b=hUDTK/sYp5qoKmGXMyA5Apnv4oSBZ6s3A/kRC1wyMZJ7cVlqzNxma0F1XJoTVJ7+oM
         9cjNESstCUAKHP8SDHoORM3X9VyAY8PbHMdkd5ukEZRahTCGAxp9jPPIOmnasg7Fdfa8
         JiqbIMRP6A2yUb54lOrZdWLR19eHZJ2S1aEnxjKpZIhmk/rE0YRQjEJ5A6VVMtNTs2xD
         04IgLu33uZAhFu5+Yj6ZMD9r45l7u2+ggIHWOVRwuWaQgDiGcHFvxr9KZvkI6M1wd2KZ
         XX8Jnu9jT1b153dvvEp0YhI30iTtnmuuvtsqZUbiDODSq8ueNU2iFGFLUaKB0N0BGT1m
         j5ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQg8lLRo0gZcAk7b/RgB6tLd9mT6POvL+R/FIKaEO/bxaQRbQgMxH+M0y5jv467IRbQjwFJIpdSydbnu9Pqw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyP2hCy6VL7jjIHhZLzJ9uL/VDinSgeR57lkY9Bj9yok+etuYN2
	JsLC4oTvjnLu8ZFakMwkgnqxBZ3BpFZwnzAw32FTXfI0wBNofVDl/BGPFWCUBbbnHAGOD5UpZYK
	aja5Ai7H1uj09LUT6huunpZbpma4q5ofzulzeo634Z6aj8u9NZc+7fIHLOwf96gyT6D50Xw==
X-Gm-Gg: ASbGncstLsJQmFfbZ4gsaGbgn44gFZmxA1FPIUBQKtYFKajqQD6g7XSu7joWksHGm+A
	A9qrF1E9qWhNlFQYOVAiuOtVblJqpRW+bmeC6ivaGyG7mHFrEjgka3CE/c7NhOYoDZfQAwrFdZR
	myqYkgFVcK7u5jd0JU7BX+SjwBjThJsbiUCL+GDxQOCVXj4TUItfO9FeRFu8bsYUezwHTvS2nKx
	jckNBLlBFSL3dX8Oxts7Vgnud7vy9NCeLleWK1eGnBJTze7T/I6HI8oBic5DZaiUNCoXMeW1FGC
	AIW/q7Zy7tqnJhrK44WGAMJaj1wVACq/wDI61HgKi7sUuQ94URajFK2fCSM4ez6w8ZS839/TUDb
	sLw2EWWM8VsLgGGwln9zGFJqgiHajXtt5XhbtdHjPRQBPUsK0yRlFauhCvNAh+L09lOLrMo0BzN
	5JH6bTNVicfW18E6QU2MPQo88=
X-Received: by 2002:a05:6214:d8d:b0:880:57dd:5f15 with SMTP id 6a1803df08f44-8847c534517mr124669896d6.54.1763906650660;
        Sun, 23 Nov 2025 06:04:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfjoGcV45DPhPepM3F6l0GjH9qQDHmDe7xVerH+yz6+TmBWarn8+u8xAR0g6pKONEzmVRL5w==
X-Received: by 2002:a05:6214:d8d:b0:880:57dd:5f15 with SMTP id 6a1803df08f44-8847c534517mr124669086d6.54.1763906650199;
        Sun, 23 Nov 2025 06:04:10 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5969db75699sm3324296e87.18.2025.11.23.06.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 06:04:09 -0800 (PST)
Date: Sun, 23 Nov 2025 16:04:06 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: Josh Boyer <jwboyer@kernel.org>,
        "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        "Yang, You-Sheng" <vicamo.yang@canonical.com>,
        "Hutchings, Ben" <ben@decadent.org.uk>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "Dreyfuss, Haim" <haim.dreyfuss@intel.com>,
        "Damary, Guy" <guy.damary@intel.com>
Subject: Re: pull request: iwlwifi firmware updates 2025-11-23
Message-ID: <mmrknanooabtlsdkkhl7gcwyoby47of35y3hij6lvl4hhq67ff@nlyx5skcmskj>
References: <DM3PPF63A6024A9CC529E3991D0F473DA69A3D3A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM3PPF63A6024A9CC529E3991D0F473DA69A3D3A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
X-Proofpoint-ORIG-GUID: WJzKwrwGCGBDP9WcnKGuKCr-FIUDayDW
X-Proofpoint-GUID: WJzKwrwGCGBDP9WcnKGuKCr-FIUDayDW
X-Authority-Analysis: v=2.4 cv=SINPlevH c=1 sm=1 tr=0 ts=6923145b cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=p0WdMEafAAAA:8 a=bxv7W_3ZIfJsmQTpWdQA:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIzMDEyNyBTYWx0ZWRfX6MVVqpFWQH6O
 8zYsz+80EJuL2l1J7iWt4Hg9qIyEuU8RM5SsBNTI54N6cOqJN+CNjSetAZ7bzuKpyaddhCxrZ/7
 cMBPBi88CNfb7kf1fAeiCvSgO89QtWgg8w73HpEgPY5cw+jcz9ytq1fTVqt6f/0Xij/CwyAFy6a
 TEFo1bEoTnl2CvlevtebfFznD/w4A3f2u9h2Rp2doISJk7wLlr1gRK+ogoAAmlcbDYVAt0iOKrw
 0JYB31xKrqy+3pCJCz2tG2dLXK1ajkbHueriKwzplaamvaC+AAHsrFyMCIu5Wrih8oU9wJh+gpi
 F9OxHjE0wcc8APpeE+PyThRvrlDwPt5VPVs7aGA9oXWOOtUyobau8y4s0SZhly3yffY5jsnpkT3
 aLlIUH9voZToZC2oh1F4Au71Uby4bw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-23_05,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511230127

On Sun, Nov 23, 2025 at 01:11:46PM +0000, Korenblit, Miriam Rachel wrote:
> Hi,
> 
> This contains a firmware of core98 for SC-WH.
> 
> Please pull or let me know if there are any issues.
> 
> Thanks,
> Miri
> ---
> 
> The following changes since commit ff6418d185528bb9b040de1066c34fa405ecd4bd:
> 
>   Merge branch 'amd-staging' into 'main' (2025-11-21 20:17:56 +0000)
> 
> are available in the Git repository at:
> 
>   http://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.git tags/iwlwifi-fw-2025-11-23

Merged and pushed out, thank you!

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/796

> 
> for you to fetch changes up to 4b245479aacaba0e3b073c31151b711e7aae1268:
> 
>   iwlwifi: add Sc/Wh FW for core98-181 release (2025-11-23 15:03:47 +0200)
> 
> ----------------------------------------------------------------
> iwlwifi FW for Sc/Wh. Core98, build 181
> 
> ----------------------------------------------------------------
> Miri Korenblit (1):
>       iwlwifi: add Sc/Wh FW for core98-181 release
> 
>  WHENCE                                      |   4 ++++
>  intel/iwlwifi/iwlwifi-sc-a0-wh-b0-101.ucode | Bin 0 -> 2096172 bytes
>  2 files changed, 4 insertions(+)
>  create mode 100644 intel/iwlwifi/iwlwifi-sc-a0-wh-b0-101.ucode

-- 
With best wishes
Dmitry

