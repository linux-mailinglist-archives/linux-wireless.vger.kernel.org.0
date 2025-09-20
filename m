Return-Path: <linux-wireless+bounces-27544-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CFCB8CC5D
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Sep 2025 17:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D72A7A727C
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Sep 2025 15:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51CE2D0C68;
	Sat, 20 Sep 2025 15:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="omqj98/9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CDF35942
	for <linux-wireless@vger.kernel.org>; Sat, 20 Sep 2025 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758383727; cv=none; b=SKsZv4z9IyhOjVQqZxJ63XedHUGmmKz7L0zqS6iOFTFNW+1mL1Sn6EFE6XPeAxjaNhqFtJa0/TXcReMwicOgLJ4PP2EPlmODsZvdaMXip76o75K0Q3JXZlLGALiwRQkh5GuAohzVQLgkNfPaxOlpYAHamjON7O/Xl0TjV00Rd+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758383727; c=relaxed/simple;
	bh=OB06cC8xAuL3KWcW6Hg+m8/AaE/xu/6RHB6DggGNVJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T5TwM5QqYVNa0obxS0JcgbMGIW0RIhVwuVpda8Ft8H7aOCHQ4i/tq11h/AJ+pVzeZbVFWH3aCQ7js9/KtUoQY15qbx2s9RMg1nfAVJfJUEEcdpZDJDTkMsN8vYBvzE7AOXZDMjYgi4085qB7Kk/48Oeml8TAJfn/8p87IgLVoiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=omqj98/9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58KDQ0Wx018356
	for <linux-wireless@vger.kernel.org>; Sat, 20 Sep 2025 15:55:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ana8meb3LHSVJnJyVOUf7gTwHScScF51sLLwxr1JAzc=; b=omqj98/9y2UsYy3J
	B9CUW8I+wxx9gMctpszRNYgcaOXyRmb1FksPnRwJZ71Eo3z/KmCbzz6mn41JeaL7
	+2WpaqvmndKLq1RnRxDUUhrC7lSuRpvVwE0/FBddASofmudfwNCkDkFgcQDTOP6n
	O5J1Dgx2/OFP4BFhJfjMZYc5nRH6jm/B+L8OVAjtl9SogbfTXb56CyihyJ7AFMl9
	drd6P34/P+CVeToUU1THqWWtJhq3eEFMR/WtL+LXcH66Gp6eWB8OZNXj1xROyFoY
	9nOA/r2a8NEMUDsgfJqgRJXTdEpeOhhdlP2RC2n/QJjKz1tYjflEGllWXgsSnlpK
	AhnfSg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499k9890r0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 20 Sep 2025 15:55:24 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-77619bb3871so5526056b3a.1
        for <linux-wireless@vger.kernel.org>; Sat, 20 Sep 2025 08:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758383723; x=1758988523;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ana8meb3LHSVJnJyVOUf7gTwHScScF51sLLwxr1JAzc=;
        b=M9WZMND6ABq4a26rIbSGvxqDG/bsGN3HWNOqwYUw5jPOV/930Enl+NRaB/9wjzOMG3
         O4Y6NaGbkgu27z5SAm7LY9O9/XG5myogX3aGBBeAQuGWCAZCEbzx91YwLtMTbEhSXrwG
         DTWwbtlDS0gzGck2IhLy5Woh/0sv/tzgl6j0Y68J7uKF/BzRci9zCvwwHgLysTEavG8y
         oj3DpKWO++7WgtaW5L5TI0Xv76dlbxVdYCgqiiDJpId5a5pr1ysxLifHsgcEunZtolmm
         k9dtpRGi50K7I1OlOgaLcqrd4bIE8hfXTOvxrUPxa/a2PDEcU1TQIZhOFTLbXlR5kiDj
         CsTA==
X-Gm-Message-State: AOJu0Yy/eD21pD+I2RQFfJ/3NipoFthgeW3Nr62KMv2efYn+EcwWTwwA
	ZanMQmW5+wjuitOD1uljUUGQXuK8YjYfUoEVuHbspaezqRsOcQb5CX5dg6MnVlz5SL15jD9IBbB
	BR0tVJkVZKV+29uWDC1XjXUxp9s9UV6Yw6Ae/MFvbIrUxbKYd4bCwLustLuxfBkmBQgiyrw==
X-Gm-Gg: ASbGnctul1f3Ng0cRwc3b/pNM6rkJ0S9UPHzeNfQ66+eO5Ib4ebrI/ixnYnaWrwEZiX
	LGnhNkYsIr3ptSj7KguFFMzSaVyKjIHDbWqe9s7Gv+GpIzm6m+17IM7JzaCRMbQq72UZu45Qpns
	ldClV/GfxzCzGLNQJRmCk4D+fsqPAa8dNg+zP/nEh7rkhfyFMfcuGBYuiXD0BFLDkkDWOiV23kH
	MBF2ed/2KPCCwo1yTcOkhDgUbOIPbl0vyo1vFruxq79myam3Qa/t/bQ1HqlPJEdyL0Z0wKbwXyg
	SP2X7qH6uaRem2Y6eFbMtl6A6w5D3I7yCbKbMJaiYSF5bUpwvnueM1574gYe1vOHgyZfgdq8frX
	2mZRebD/fHyY4sWCKGgdjsiCEMNOF5VIEwe7P
X-Received: by 2002:a05:6a00:2354:b0:77f:169d:7f62 with SMTP id d2e1a72fcca58-77f169d83e5mr5467953b3a.14.1758383723005;
        Sat, 20 Sep 2025 08:55:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOaB7iCjI78POPZVbbl+FVK1OsIR/scW1RaIBr44/RHLmSkmoH5nr7aySf6I4T55ojb3L+nw==
X-Received: by 2002:a05:6a00:2354:b0:77f:169d:7f62 with SMTP id d2e1a72fcca58-77f169d83e5mr5467933b3a.14.1758383722325;
        Sat, 20 Sep 2025 08:55:22 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77ecd17bddbsm4548805b3a.46.2025.09.20.08.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Sep 2025 08:55:21 -0700 (PDT)
Message-ID: <4e204f93-b964-40fb-8eb5-f723f309a2c1@oss.qualcomm.com>
Date: Sat, 20 Sep 2025 08:55:20 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Fix NSS value update in
 ext_rx_stats
To: Thiraviyam Mariyappan <thiraviyam.mariyappan@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250725084426.3989966-1-thiraviyam.mariyappan@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250725084426.3989966-1-thiraviyam.mariyappan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 50ll-pBUFLncm5Jlx8VceIy0e2-qc2l8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxOCBTYWx0ZWRfX0M25LNH7IHJF
 Kr4BW3Qo064ZZ6LxfFpAcFaak+/YjuN/IlBgYl2vl6BbEcIWjeDu51l6omzSzNtdAg7AROV0MWQ
 YzY2z+tfgJi2oAhq8Eq5sr53eUCxcxW0+IEk5zkx1Uf5+evbUaMCQU19HYxOl5KeM4J5X40FU4p
 bvgL6QNjCFtIvpokg0faaE08eEB7v627dljpPB2A3ueJFMiAnMxYSLiglbUBftJX+dj/C44fIWn
 1XKK/XmMn7zqC5KgCEK2uXrEKrToKBpNVEhTD23OK2o5WuOByynTnHMKasIz/IVdgF7NYbcy34U
 Oz5ux4sJFMCYfNiwUG94iiVYZZMFvjk30KiyhSWP7Rhhly3VieAGlHn3NMjemK4FGdib+BZpG9J
 N8TyxTBG
X-Proofpoint-ORIG-GUID: 50ll-pBUFLncm5Jlx8VceIy0e2-qc2l8
X-Authority-Analysis: v=2.4 cv=Dp1W+H/+ c=1 sm=1 tr=0 ts=68cece6c cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=tApd-Sg5WrpdobDWgDUA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_06,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200018

On 7/25/2025 1:44 AM, Thiraviyam Mariyappan wrote:
> Currently, in ext_rx_stats, the NSS value is taken directly from
> the firmware, which results in incorrect mapping:
>         4x4, 3x3, 2x2, 1x1 SS are incorrectly updated as 3x3, 2x2,
> 1x1, 0x0 SS respectively.
> 
> Fix the issue by incrementing the NSS value by 1 while updating
> the PPDU info to ensure accurate spatial stream statistics.
> 
> Remove the redundant +1 increment in the radiotap header when monitor
> mode is enabled to prevent double counting.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Thiraviyam Mariyappan <thiraviyam.mariyappan@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath12k/dp_mon.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

This patch no longer cleanly applies to ath/main:
Applying: wifi: ath12k: Fix NSS value update in ext_rx_stats
Using index info to reconstruct a base tree...
M       drivers/net/wireless/ath/ath12k/dp_mon.c
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/wireless/ath/ath12k/dp_mon.c
CONFLICT (content): Merge conflict in drivers/net/wireless/ath/ath12k/dp_mon.c

Please rebase. And when you do so, please follow current legal guidance and
replace the existing QUIC copyright with the new QTI one.

/jeff

