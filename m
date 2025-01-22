Return-Path: <linux-wireless+bounces-17839-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CCFA196CC
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 17:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9AF6160E97
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 16:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A3521422F;
	Wed, 22 Jan 2025 16:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xbs9Cnyz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A21614C5AA
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 16:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737564388; cv=none; b=DJN4VXRZm53urZysN/P3oOwj+pigRUJ3HWrXUbsPTS7vu8NaCKLFT3DMTiOoYJytTyerwL9ljXwSo9voB6dYS7osMU9ySazA6aALpfaouBNZdAUJnY1bX0iHBNzWl8SNU7uyJ8hcwSdwkIBe6CqwOUjD05U03d/hBIGXSB7RvaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737564388; c=relaxed/simple;
	bh=Ysh+3XOPnSmfnhcjxY46HMbXLGilzxXWwr/AEDlAPn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PtYevPlebjEEW7whWsZY5h5LNIeWxsUOsX7YX6umKNtfBaciYexsXjMrBMrvO3ijKvDTYjXGjTyyLUNxWJ0h9bZyvE/Ew29y+LU/DLUL8gh+E7h2/aFNgCco/6Zdeb/OIqhRBRCiC5v2R+uiCIvnd+Kc2Ocok2vij2iVHJPSoF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xbs9Cnyz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50ME3cED005029
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 16:46:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7v+bEFk1ICZblmKW/sZaG3nJ5WzJr94iOz+HstkL5bg=; b=Xbs9CnyzzyS/ciz0
	AoyC3lMA3cGyXWWyGIhvmr+QTut1NZNCZFLPHCLmmO94UE1qNQR1REqdrJLFhUn/
	hM88j9hDXdp1L3UBNNXFZxM46fFnQj+APgmBaQMlhYYb0qczw0IMVQVAIOydXEsR
	+jgZBN6yuY9za/bAMKIMHQ2OOKqvvNbiBISru3jUdBw8qfwaxiqld5Ng+0P4HOVv
	o+BapLdtq0UT3TQQSTQeAseaHC0rj2Ol+0bQTMUrYdx3HzHAvygx/OEn9lgBHO/+
	u5XN2+U2IWIIvsj5jaKIC029Ifyz7t4QfKqXpw9/xOuaNEgNfmdWNX0R2HjZwOR5
	vpSNVw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44b23w0cww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 16:46:24 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2166f9f52fbso213121165ad.2
        for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 08:46:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737564383; x=1738169183;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7v+bEFk1ICZblmKW/sZaG3nJ5WzJr94iOz+HstkL5bg=;
        b=r0feAduOnmPYabggRSdpEf0mlIrd5mP9co2799nxXrsY1wYHBWDtEb7ixblcw+Zl3j
         bC8Zyf0DA2Nvy4+qDqPwVnOwzf71RlRV2q7yQzQKSqB953W3n9s7eiHV+ezrpKLOaLs9
         sWrb4MrGcWHg19jQBWAcSV56/qMFcWJGhAnzoA/D5kSZVEIIn46R58LCiWF3M6dI9rmV
         V0ZdznbJl5ejX/CtDvmM+JKhMvugLQFg5IGhBAgMkosZ9lvu/C9Tu0ray7tDzul8oieW
         mMVszzkeJpeVotEw9eNKcS2JgUoAdD2SaH85W1jhN9+0GJoEhRT0AOXHvJNKfqmoyzaZ
         3ffA==
X-Gm-Message-State: AOJu0YwPhUiPDYDduwETipz1TcDAIbPlN9IzaEMQvzbyjYzwLsu3DinH
	z4c4wfJFKrvcbCO25iuq+aTk6I5ZYPu69d9slaNH8bouTcDof5s0lEZVzFDkB3vyOWRZp4knsq4
	cTITtiluIbkl+inN7zbyASqaj6I/thYskZxHepT+o+DdKdoEFOzAEGuUQX36c2m7ESklBpq0lTA
	==
X-Gm-Gg: ASbGnctZ+sl0hLTykd1RICQ/xy1hIQ/WNS3oxK7/IliLuCaRLz+ljkuQOw1ue4gE/Xg
	xh0VuVt/n2l0IbAdqh9U/UH6BVARuJBcNfGUKbGySdW3sxVpxEK1wAqNRBeX69u3oafNNwVCKfE
	OONyqz8lwPxzUEY7x9OmA21Ma0F3eZJXssCuRw+C1KC1K9p/GZ8YRoMumtOhu5PrbNPTXpJIlje
	gq401/Gq/t5SHG6BIOY++wkDRod2HSmaep8eiRCudABrgnF/oJUfMhfCmN/JErzWhmMyd7Zaaia
	73+ElYmj9OUrScp7641iLy2qvKQcpQ==
X-Received: by 2002:a17:902:d2cb:b0:215:b74c:d7ad with SMTP id d9443c01a7336-21c356307e6mr345524085ad.36.1737564383513;
        Wed, 22 Jan 2025 08:46:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnU64udupAVVoRUnYBL4fK+FwmbcgZ+CvYqXuySY8jX6GWUUERwVhakwXz27rfrIGpdPUe4g==
X-Received: by 2002:a17:902:d2cb:b0:215:b74c:d7ad with SMTP id d9443c01a7336-21c356307e6mr345523705ad.36.1737564383127;
        Wed, 22 Jan 2025 08:46:23 -0800 (PST)
Received: from [192.168.29.221] ([49.37.208.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2ce9efd6sm97200435ad.23.2025.01.22.08.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2025 08:46:22 -0800 (PST)
Message-ID: <101c0824-1c0d-4e5f-bb4c-7d6ef65f1698@oss.qualcomm.com>
Date: Wed, 22 Jan 2025 22:16:20 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix skb_ext_desc leak in ath12k_dp_tx error
 path
To: Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250122160112.3234558-1-nico.escande@gmail.com>
Content-Language: en-US
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
In-Reply-To: <20250122160112.3234558-1-nico.escande@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: HMZeltILTQLam1Irjc4rSD24NMWKvgWw
X-Proofpoint-ORIG-GUID: HMZeltILTQLam1Irjc4rSD24NMWKvgWw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_07,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=914 malwarescore=0
 impostorscore=0 clxscore=1015 mlxscore=0 adultscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501220123

On 1/22/25 21:31, Nicolas Escande wrote:
> When vlan support was added, we missed that when
> ath12k_dp_prepare_htt_metadata returns an error we also need to free the

nit: Always refer function name with () for clarity.

> skb holding the metadata before going on with the cleanup process.
> Compile tested only.
> 
> Fixes: 26dd8ccdba4d ("wifi: ath12k: dynamic VLAN support")
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
> ---

If there's going to be a new version please take care of above nit 
comment. Otherwise -

Reviewed-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>


-- 
Aditya

