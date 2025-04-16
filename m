Return-Path: <linux-wireless+bounces-21603-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F547A907E0
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 17:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89DE11889585
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 15:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDEF1CAA97;
	Wed, 16 Apr 2025 15:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nl9IIZ4a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C331E1DF985
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 15:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744817816; cv=none; b=IZkTev8U/BbkGUYsfSbq7SKDDRdo9Jz+kHhnJpP26ng5pjxFfvS9nQkAYSV/psSMMcxt3C3qAEQvOwZl+3k3cbp0ZfO5nff94wXGAVJhIuJd4vsq3jdK7rKZvEr1R8BX/SapC+/WwNq7Vss5ipAwBsYFYwIrQI6RDDLASI/wpnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744817816; c=relaxed/simple;
	bh=jhd5yWzgsp+WPFZ50PHgECkRVKELFgc18NNUDfEXB2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fiObMEfw9HeBDPsLNayvITsWpklRR9h6izrVK21h5dj9Ei2FzgeOwiDCK7xO6aOV7oejYJYkyBrE3OveczFE9sRte8wXc1AZiipIUBGvrvWK73c7qB2rQ/aO3xLqhClEJ7xUzKxRDSW0egwkA3eG3xYv/zLKwnrSDRPn64V905Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nl9IIZ4a; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53G9mExX005968
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 15:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c78LnrTp8qvX8Bx5aesz/R6PctldqwCYeHndy417HQA=; b=nl9IIZ4aBWb2HaJC
	sY3STxFqPyArDzHZQOOLc5KeW6RQLQosTKM9bpzrCLjCvKBs/1P5v0mScnD0lFwT
	BuTShn3G080zYn0eE1Mdw22YSLXFfnSvt09CxG07aLICCcbu0FswbmPqpni2GmW2
	3RgAW14fzJKsNXKlKqe+Pot0VJRXjSLAM4hFVnLpzy+bwginPKagnBXDrsrjC9Ed
	EFaZjVKKdmiQfZXtjE98w8xyiUcc0UyDTDxzaMjuApQyvFhG89+1H6AKuWEa/GZI
	8u3kDTtdKH+Nv1IVo1+oT3/lWwt95afBSyxAUsfDiMAA7mSa0dc2/tSS7X84GjLj
	10DJ0A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ydhqc7nu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 15:36:53 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-306e76c04f4so5968564a91.0
        for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 08:36:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744817812; x=1745422612;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c78LnrTp8qvX8Bx5aesz/R6PctldqwCYeHndy417HQA=;
        b=V4v4prQET7QqBMaDKntkY/S+rgfv1ZUipSQnD1/ND6+eNbzPv+RXQQgi/GDlR0NV9H
         NQBWIulFTL8jwczKJxEV+fESSP86RCuk7jUfWKWFDjLa09wEq23zFsLkgTOT+TcBbCT0
         dzuTRs1GI5qC6yJ8cV8asnLedvg5errw6pn97PX9mYxjRNXPtZhjukvtErQcpsSW00F7
         JnClDTcZyi32UwiEc7Y8LOpcrDretHAm0GQF5nzycPDiDF1Iu8Nzj3yE1FOPjGeZbyei
         VX5w6wCB9lY3WkvYtj23YHmYGKOu4zbwehfleKGhZr/CmPXWMfUaEWAqBuWhbKt1SqYO
         cJBw==
X-Gm-Message-State: AOJu0Yxf0nMcH1ZjO46zplR4CYtglYlg3VQtmOXjMAgHgJn6w/SdsImr
	UkGFz3s0IfUMOi2lQD84D6+0Mx75+JAle8IRVgqJP3eTSMwDQ3UIWP5t7ZjyZAtA+4AP/4PGYGA
	iq83vTkX13J1oaVvLa2lTHebkv8WJHbRzL/f8fPIgGLLfwHazXerngQSbzK6A1x3/XZP5nJbqgw
	==
X-Gm-Gg: ASbGncuV3qhU9xybL3GP+QDL5pdEuEh8dowihmj57tq0n1Ys9e2+gm8R+4It4wgH24l
	t5Nz6WDOvw5GHVxm5kwO1Jzgg3HLx5t9kN4RwvBs7jU98y1kKtmGbOB1UeN1JwOEHh8Ol5sg95q
	owhWy2I2D2xWhbgerh0leHB+5g+vEwjcpPCHYlKhMeDTLGy9W10+ds749Is7PxyvRzktS18F79e
	3SKzSi1YXIJyEB3ut7Vljr/zlk9OuJPXAgCN0s/8APPLAmOdOZcbsR8/sHZpYPIz+DK5O66PxDa
	rObIU/UU+pJV15qDRGKUelyxfYmgXKUTIfobF2PGjEtgKv60thOF0/LofQNbuAOt/0g=
X-Received: by 2002:a17:90b:6c4:b0:301:1d03:93cd with SMTP id 98e67ed59e1d1-30864167feamr4008153a91.24.1744817811801;
        Wed, 16 Apr 2025 08:36:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKPdIhuLdVvaJY3YwngnADlYsQ47zNzelQAlI6OUXwZBAf6r6y1dh5qlR4Nz/ob+K1uF5UYQ==
X-Received: by 2002:a17:90b:6c4:b0:301:1d03:93cd with SMTP id 98e67ed59e1d1-30864167feamr4008105a91.24.1744817811343;
        Wed, 16 Apr 2025 08:36:51 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33fcad31sm15514165ad.186.2025.04.16.08.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 08:36:51 -0700 (PDT)
Message-ID: <d3a04a1b-5020-44c0-9bec-2d1c2014b6b4@oss.qualcomm.com>
Date: Wed, 16 Apr 2025 08:36:50 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v4] wifi: ath12k: read country code from SMBIOS
 for WCN7850
To: Kang Yang <quic_kangyang@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250327021403.1577-1-quic_kangyang@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250327021403.1577-1-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: -k3PjJDyt0Lu00_KFyEXIdTOrbhLB2jO
X-Authority-Analysis: v=2.4 cv=C7DpyRP+ c=1 sm=1 tr=0 ts=67ffce95 cx=c_pps a=vVfyC5vLCtgYJKYeQD43oA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=Ft5rZQkPytZ3RTzrGcYA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: -k3PjJDyt0Lu00_KFyEXIdTOrbhLB2jO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_04,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=856
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 bulkscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504160128

On 3/26/2025 7:14 PM, Kang Yang wrote:
> Read the country code from SMBIOS and send it to the firmware. The
> firmware will then indicate the regulatory domain information for
> the country code, which ath12k will use.
> 
> dmesg:
> [ 1242.637253] ath12k_pci 0000:02:00.0: worldwide regdomain setting from SMBIOS
> [ 1242.637259] ath12k_pci 0000:02:00.0: bdf variant name not found.
> [ 1242.637261] ath12k_pci 0000:02:00.0: SMBIOS bdf variant name not set.
> [ 1242.927543] ath12k_pci 0000:02:00.0: set current country pdev id 0 alpha2 00
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-02582-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
> ---
> 
> Depends-On:
>         [PATCH ath-next v14 0/4] wifi: ath12k: add 11d scan offload support and handle country code for WCN7850
> 	https://lore.kernel.org/linux-wireless/20250327020527.1527-1-quic_kangyang@quicinc.com/
> 
> Note: This patch is an old patch in public review written by
> Wen Gong. Just resend it for him.

This should have had a From: header that shows Wen Gong as author.

I've fixed this in the pending branch:
https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=336569497f976fac962933fc6995eb8778c41b47

/jeff

