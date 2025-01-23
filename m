Return-Path: <linux-wireless+bounces-17866-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97369A1A8B9
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 18:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 345271891789
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 17:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B83A149C51;
	Thu, 23 Jan 2025 17:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aPbocEG4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBEB146A7B
	for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 17:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737652364; cv=none; b=hmOskKZ/QkNKM7Vy7FB8CG1fSRjCD4+C1BcOl3B36WOy00Qzu9T9FezarX91E6oJwRr++5mGEgbmxng/uvaR1VrssLNINsA0or5CAnngu9De8IMQmMdnq3SW0hwQQHDMLMAiXlyot+Kb+K7YhZmQR3E6OBcC6k1b/pRs2kTpmDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737652364; c=relaxed/simple;
	bh=HGU5iSG9x/njAM7pSpVd92El321Yvqs8b6IOX4KPrM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a+ZX0apWjtvmrQQj8iZ5qwsLKIE3oFsFuvAdqDLFe4pWhe8b7NE+bey0NB0DsQr5rT0BryHZtv2OtnXcb5dGLc8X6zVde5N9xJG56ZtpPvTIMJg3IAmFegeQ9hH08sf8GFN2yVl6B8zTI65PxPrNjsyWwOO8uLo/PhhtmpkOCaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aPbocEG4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NCsWPY000937
	for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 17:12:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	d3az1RKU17qwjiOPGrZkVior54Yx4OI9sSB4ahewp44=; b=aPbocEG43Lzi6hRy
	Q1EjDsZ88n7tVcr24oKDA9eMzFoXg7r0VR7p+mZeXyZN11RGK7ujRv9v3txHA/v2
	yESOe/bnDYHPxn6OtoJExcWktW+ZAS8cgul1ubpfLVi9gRI4CkuOl62dtLH0MSA+
	eWfj/sE7yoDObSHVVrZ7zInev/5bCPhDXEbaWALczfsEc5sEsgz072VLWoCuuOEL
	v30QNAeAfvYz6472+9CFGCxOoFeA2U2wgxW1liwVY3i7a9xppLlEWQbTVjwr8IV5
	hg8jJyWjR0hMKq0CxyYAWCzMtAODDJCRWfCLNRVeouYhslbBoZK0BAo8pA6fZHbX
	pm/fXw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44bp6grmhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 17:12:41 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-216717543b7so29040915ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 09:12:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737652360; x=1738257160;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d3az1RKU17qwjiOPGrZkVior54Yx4OI9sSB4ahewp44=;
        b=nUD4M05GyHuIsBkuNMD+b45eSfwNAjy1x603SrvxxeT2JrQHl5gUW/AxWuM4f/3vvp
         7OEg/LxpuUYmtidckwOVcDCiv6Utg4TdqRucHkCWka8lZSTCnO9rSu/rvswrSGPSb2aN
         bMZ5JpnrvhJZ3lbailNkZVM1uqbNzU8/h4vHmdG3z19kK++t4vt/SLPebaV/J+/Ibahm
         VCiQHn8KWW880ILLYi9DkhpybbAu5i2hIQBmflch7d2lLXzp0yl/SwnKOiKXvYUqNkfQ
         do/a4lrMu9Yfc0KeNGb3SaXVtuH+IQ8sKYr4g8UujtFXa5tVRkv8ghK4llywh0QRA+FJ
         p02Q==
X-Forwarded-Encrypted: i=1; AJvYcCWF9zsxbBX/vkD8ONWa5b4U7PqJ3t/6D2bho2KmH04J4Io3X9hphdKV386OEVHPG2DjMnzitDMMxzOuwuqulQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTBa76smSVh4CbLPPu0sQKK4Gs/LN3iJqWKUqWZCkyz60oOG2G
	gMlPtxMANFq2Qi5tKJmzIiktF5xIkXqoSCZHK+RtJIG/heWFHMnlYzpKI2Y5fTmUvY02bobmpQX
	3wQ20BrFzbdeph4aVqBQw5WtaSzab5I85vPHGuKpCEwr+GhcATMB+P6E+wIfMAuI9eQ==
X-Gm-Gg: ASbGncvTogsEjjIPKKRM9Dx09OgqRXZpK+Jng75NInGgOkoYpWa2slRjAfECB4mjQYf
	gVjtvtnwscoz/Meaae1Zls8R8quXIrwZKTzWPDldGQUbLmt51cL0WZKdVn9pSSWjUVcY2gr+lxx
	cvupu9ej5Il40z4XQ9Vl4kQxZXYkpaWqvU85/cMJaiZzLwtDE8yJkNRgt8q5vygPXjSC/28MEwU
	BXO9bLsT98a6J1P7i9gOfV69xFek1UnwoIt99CFyrkOJvnvu/0MiHmX7LyqiK9D4qwtX2I5149b
	TdjlrkZDqo7QE99nheqJdYiC3t2DsEBLBRSQ7l4LAFFC7nRvguPyuqyQOTK/76A=
X-Received: by 2002:a17:903:2290:b0:216:5e6e:68cb with SMTP id d9443c01a7336-21c3540d18cmr423745215ad.16.1737652360431;
        Thu, 23 Jan 2025 09:12:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2Q1Ks0mnL3M2R9V9Lg+xPeJhjuHsVJ1yl2ugFUokMhKI673ryaHT2sM/t/6MrSM2ggR2uuQ==
X-Received: by 2002:a17:903:2290:b0:216:5e6e:68cb with SMTP id d9443c01a7336-21c3540d18cmr423744625ad.16.1737652360030;
        Thu, 23 Jan 2025 09:12:40 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414e2f6sm1294225ad.197.2025.01.23.09.12.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 09:12:39 -0800 (PST)
Message-ID: <d39befa5-58cd-4052-a71f-c632462ccce0@oss.qualcomm.com>
Date: Thu, 23 Jan 2025 09:12:37 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-current] wifi: ath12k: fix handling of 6 GHz rules
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        Wen Gong <quic_wgong@quicinc.com>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Cc: Balamurugan Selvarajan <quic_bselvara@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        Bhagavathi Perumal S <quic_bperumal@quicinc.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250123-fix_6ghz_rules_handling-v1-1-d734bfa58ff4@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250123-fix_6ghz_rules_handling-v1-1-d734bfa58ff4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: OW3xQs5XUEzDeBaPflw1V1cEvsyRkMxq
X-Proofpoint-ORIG-GUID: OW3xQs5XUEzDeBaPflw1V1cEvsyRkMxq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=978 mlxscore=0
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230126

On 1/23/2025 8:21 AM, Aditya Kumar Singh wrote:
> In the US country code, to avoid including 6 GHz rules in the 5 GHz rules
> list, the number of 5 GHz rules is set to a default constant value of 4
> (REG_US_5G_NUM_REG_RULES). However, if there are more than 4 valid 5 GHz
> rules, the current logic will bypass the legitimate 6 GHz rules.
> 
> For example, if there are 5 valid 5 GHz rules and 1 valid 6 GHz rule, the
> current logic will only consider 4 of the 5 GHz rules, treating the last
> valid rule as a 6 GHz rule. Consequently, the actual 6 GHz rule is never
> processed, leading to the eventual disabling of 6 GHz channels.
> 
> To fix this issue, instead of hardcoding the value to 4, use a helper
> function to determine the number of 6 GHz rules present in the 5 GHz rules
> list and ignore only those rules.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Cc: stable@vger.kernel.org

Note that an upcoming linux-firmware PR will bring in firmware that triggers
this issue, so want to get all affected versions of the driver patched before
issuing that PR.

/jeff

