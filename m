Return-Path: <linux-wireless+bounces-17442-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD77FA0C14D
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 20:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEFA318838D5
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 19:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9B81C5F2A;
	Mon, 13 Jan 2025 19:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UHPowSBj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42AE33E4
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 19:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736796236; cv=none; b=ttSUZTPlQATValAManvHqulzb34lwXZ3QiuXUkut1mQk/z15ERyoLRIOqe7MLMkBzVdh0soLrdXYivReFwV19VqLK2tV+aKmU98f55psM+L89uIzFqHc3FKKKxsv2uFJbCI6A0Yu/rrDcizpw2HyQv4sx9cVWanuEsS4dH94DxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736796236; c=relaxed/simple;
	bh=LF+AuV0ARDzMcyEv7Xj+u8fef6mjE2wu+k77sVj4s/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XyB9OvfYLm2RpftTdYUeZai94SsKi2iDnI7PYZRgXAWYb43uCtJ0pmRVDD8T3D3TDPReivmfjh/hhAwCEOuWN0v8Hpyiq0YzmF9WJ7R9X3kxmUujR2GZ4dMSGVFaeQF73OsPjk/1lvFFpefxMfKCZBxllZfGF3766h1bRx63De8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UHPowSBj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DBllPp007061
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 19:23:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NXde1w5kelBQI0tygiDvTjNW7ZPGIES67vcDwSi0qjw=; b=UHPowSBj12iXa2H+
	3BwNbs9AHbPsFn8vmwYwSAw1ej4vilBphI5zLX6ywTFhyjNj9HRkVPTFxU+0wVe+
	+MFNExZNcMSvzKQA5eX9GgiUlI/VhlDXNuAtMsqTib4rMEs0GQ07zg/SY8xPaxoQ
	aoTuvGxCQAvOXjXAvtCxMddSOxOHzPawPJMxOLcu1PE3HxVOaGSxYq2rWgXO3O/x
	vVDuXAP78fmuCXB9wSk/2b2ZioXsfg2fwitTfgVsSfUoLiWhh87u9Y3gTM1TTZBt
	XYRJARosQavNACC/KkSqUIpGLao/Ij49yEniEaZvJ9yGyibwlhF7mYxnZQ+sNHc1
	iM/3Sg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4452939b40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 19:23:53 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2166f9f52fbso142314915ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 11:23:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736796232; x=1737401032;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NXde1w5kelBQI0tygiDvTjNW7ZPGIES67vcDwSi0qjw=;
        b=fWyfR6BUxB2dxhd2Z56RMW+BsE0OOBfgB/cWUgFdSQS9J2Y3EWAcIPsnxPMXL7eqUB
         JHsV5GCEX/oyLyMxwHHTZqeMei40FjBRtR5Jy3aBWpaj2oW8yeNwIYWe+o2iA/Jznb/+
         xyNP5urw3njBZHnFChh3nZmPxk2O0CS9UxnIPCG49+LxQXE6edzzydeu9TK1EIURtE04
         4THvXhLxk3uI11LokRgBJE4GUeNTNFxisa0HQvrBMLTakBuTC00ILqd/TqNFZpL8neWT
         RISREk0gBVoZjyi0kG7EVnigB1CmIpzQaL1qF1GLR3Yo8g/gyBIEXhUd03j4OZTwcVMm
         Mi3A==
X-Forwarded-Encrypted: i=1; AJvYcCU7yFntUzwK9J9XP0aTPoxzndRFN0u/UaCdug5VYTjNYpHzSjFnOMlIOmgZtunFb8N/2TsAMpffatnszLDHlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx01fYkEkdS9N3bTDV/z08sFTHafQUsr/FamZXXxBPyMk7FjKvM
	VO0xmAcfVdoVAQ52QSevD24Fs6riwqetuY6+8EWliAA3SUdAGytLDqCupt84GrMxUke/srtu5KI
	vKS7VRouQL7qoaGSi4iurnaEhZwpmmDX4xYPLx5BfiB1TxdrlVnmnhGuwRkI/ek7CDg==
X-Gm-Gg: ASbGncvH/zV7G9T655+qLlSd7ju18NNA7Aewv2aoyeRTkMYPs9RxyTKh1ckYN1zc5dK
	nVlbNkde93Z+4DesJSR7+HE+vIKyhV1pYU6cCZjbUnqZiLcZACe9E1AIobmGL5Fn49nxBVB6k33
	RoRlbg+TS7rybrjAGTd2uSw6fpJ4cOjS02cDuqgxdW5UE3PWMPTHF2enONur5c/2gPEVVkp92Sk
	q+diEHSr7Ih4lLOmOAMYPOELULyBxOcRMhvv50WeaAJHwyQNxlG5CdB/UtUK6L9l2dKC7xohJGP
	T/q8Nz55vdUmxES8In+fVmfZDNCCZPod/jpOQNm2PktyYFNCEA==
X-Received: by 2002:a17:903:2301:b0:211:3275:3fe with SMTP id d9443c01a7336-21a83f5243cmr121124925ad.17.1736796232147;
        Mon, 13 Jan 2025 11:23:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXldcpH+05wO8UMutlychiEfsS4TSMNdLeLT/myX2snP2ooR13NCLU5K/VFffyts1ZTb8e5g==
X-Received: by 2002:a17:903:2301:b0:211:3275:3fe with SMTP id d9443c01a7336-21a83f5243cmr121124475ad.17.1736796231715;
        Mon, 13 Jan 2025 11:23:51 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f12f925sm57436325ad.61.2025.01.13.11.23.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 11:23:51 -0800 (PST)
Message-ID: <f2d2a1a7-8cc9-4c42-9788-9a6e12df212e@oss.qualcomm.com>
Date: Mon, 13 Jan 2025 11:23:50 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] wifi: ath12k: handle ath12k_core_restart() with
 hardware grouping
To: Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Kalle Valo
 <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Harshitha Prem <quic_hprem@quicinc.com>
Cc: Kalle Valo <quic_kvalo@quicinc.com>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250109-fix_reboot_issues_with_hw_grouping-v1-0-fb39ec03451e@quicinc.com>
 <20250109-fix_reboot_issues_with_hw_grouping-v1-8-fb39ec03451e@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250109-fix_reboot_issues_with_hw_grouping-v1-8-fb39ec03451e@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ZCsgxVnUwL2yLO8gu62VO3sFL2KKSZj1
X-Proofpoint-ORIG-GUID: ZCsgxVnUwL2yLO8gu62VO3sFL2KKSZj1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=999 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501130155

On 1/8/2025 8:25 PM, Aditya Kumar Singh wrote:
> Currently, when ath12k_core_restart() is called and the ab->is_reset flag
> is set, it invokes ieee80211_restart_hw() for all hardware in the same
> group. However, other hardware might still be in the recovery process,
> making this call inappropriate with grouping into picture.
> 
> To address this, add a condition to check if the group is ready. If the
> group is not ready, do not call ieee80211_restart_hw().
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>

Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>


