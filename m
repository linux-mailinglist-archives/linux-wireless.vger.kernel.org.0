Return-Path: <linux-wireless+bounces-20357-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8AAA60625
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 00:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7196416945B
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 23:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8241F5831;
	Thu, 13 Mar 2025 23:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dwGqZGNB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CFE1F4630
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 23:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741909730; cv=none; b=Sfz8x6ITAP7e3AGew9Bp/Yhbfx9VXqpDgEvlMVhoya2yOLkqPM0ou5/VWHUSONJvheWya3ijcmVqO21xzlcrpbDE51dWTSBhnMZxsd0SFF9gMhOVNX6XfZlRlVoin+a1mdq6EsZCh8pIenxXBk4ys7BImQzrel3ZR87xOkEr27k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741909730; c=relaxed/simple;
	bh=0lu8oU1tyqYj57FgsKOmobIAzRwBp7FW+RRAsiYBpss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tCEy9dFjAHEHYJ5enXbVQIu70qeBO856ZJMm/Gh7cPSgp1dZn/gg8kmCKWadi6qZkPUj3/LqJ4spUQpS54ZRiCggKqa5qEANIERiJcAxz9k00yzzk8OZ6VdVJxhs4SXqKRf5s3u5ltFMJz83bnOc2OIrtg3Pne24oZ0rOHljClw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dwGqZGNB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DKDu4V029014
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 23:48:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Zkd/Jggqn86Uyh/5JzZQRlmlyi5xVymwBZ1NTqzN0CE=; b=dwGqZGNB2o/W1vhD
	lMvadEKnxYanIo9kqSUDcDRjzYmf0TZceWIIFAN5IMf9GLnu0vKfBl3PmMir/KAk
	WlP/r2ERc2k4tD8cZEiRtt8U6GhiW/3HsZAfKDfDxREL6QCLQJZumrxiCZoUrobj
	pPSJMo/CUvLm3P7FqRGHPp/lUzAaaD0iIqgbxHEUd4/4JGcTN2GOIwGJM+Pw/Y24
	/IjsOyMx6/5dwvtNvPO93+76BHj4j8w1KpQldr2S6nNQXj5cvMNNm1fjqL3bhgOJ
	7VUI9ZyZbtkc0yR2cfQX6LW2QF7I3TlWpXNfCgJDt7E7kXr0g2A23DXmkNyrdAsY
	oWs4Hg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45c6730ddh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 23:48:47 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-224191d9228so29679065ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 16:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741909727; x=1742514527;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zkd/Jggqn86Uyh/5JzZQRlmlyi5xVymwBZ1NTqzN0CE=;
        b=atu0khc+VMXw37Mt5byZtMGkmatw6LWcHGUWXcA4tAclPJHq+p6oyO5NhcqY3flGaS
         b3+tUxlnbqrBu3TAR3PzDrf+J/u3YXET2jo+FfERb/86ZrAjh4iFEibROrWnKkWtKLYd
         jz8CJiz5S/L9+eDxq3+ta9EuJbFRs8jCVJUPKtslr0jnL2aC6L9wGggqyB/WfpYzGFbC
         mxA09Bc+hN5SpBiL3dIV1wAofFblTD6snbkIUIrDbxSlXJ/1QoKxhrPk9EVEJ8kNUajV
         IoxETLLWJy0OOcAKbTYfwMgAMo5Monz8vy2Jz8BDox05LFdnUhegiQoIkhPqHzjggn07
         E/7w==
X-Forwarded-Encrypted: i=1; AJvYcCX4BEnsNdBzhWRpomVA6Mi7jBJPHQ0emq3aRoPIJgVD0Da8uDfQzQPpEvAczSj/AZmLoXf7tWRJKnbgFmYe3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZbRgCQXugCqiNV7jYUUjDLrOz7du7pI4ovFM4ylMyG6j89kNF
	K3ktN7DUL/12d162FKTGQnTX9rpEStbs/3/TEYbY4r7QbUXSw1g4lvGbv3zSYW7TpNMJoAtQB0E
	9K8QT/bP0dJ/e2+y4kiAVplv+yq5Vae1wAhXDLRW7ysC5F0szqABCOSegUt0ea3eLYQ==
X-Gm-Gg: ASbGnctgv2uqki902txIMtsK76TLhXXUe1Eksy6QP+obmDrFUrrgtS9iltyY3gdlWVS
	xYhd+K1UTdL9zJdunY/RBAuygBqSwaEEptFxIILjx9bfL8DYPvy/dbqEt7iU73mBmUqlxhdH82G
	k8bEYst4O+yYfabNhFti7e9t/F9/uXgIDJtQ7IJCgro8TDJu340wNQIeUFnLkBv57s37c4H9/C1
	kv/DIX0ThbhfvXwGWD+Tqlay3AN/SeIrVIB1VkfAKVcAjDR5Q5JuCU0pcGtEvUA6OR4ppzQ9GTD
	ZXYkQELH7iUIPoiaJbOJA1ONjTsczrv6BMmiweRL+XfKAN8Nq3zMtUNj7cwmshKMHRXQvt9Mzyj
	aPClXzZT0
X-Received: by 2002:a17:902:ecc5:b0:223:f7ec:f834 with SMTP id d9443c01a7336-225e0a840camr4626005ad.31.1741909727064;
        Thu, 13 Mar 2025 16:48:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcphUQ8UCrGDx8Md02DmjuseFiFZVhQ2qPU88RhdsaxrxfnuW+c53+Y3w5UiXV4O9t74jPcQ==
X-Received: by 2002:a17:902:ecc5:b0:223:f7ec:f834 with SMTP id d9443c01a7336-225e0a840camr4625785ad.31.1741909726725;
        Thu, 13 Mar 2025 16:48:46 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68887fcsm19356845ad.39.2025.03.13.16.48.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 16:48:46 -0700 (PDT)
Message-ID: <2654f986-eb8b-430d-b962-8e77d9e11826@oss.qualcomm.com>
Date: Thu, 13 Mar 2025 16:48:44 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] PCI: Add function to convert lnkctl2speed to
 pci_bus_speed
To: Bjorn Helgaas <helgaas@kernel.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        mhi@lists.linux.dev, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, quic_pyarlaga@quicinc.com,
        quic_vbadigan@quicinc.com, quic_vpernami@quicinc.com,
        quic_mrana@quicinc.com
References: <20250313171637.GA739165@bhelgaas>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250313171637.GA739165@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=a5Iw9VSF c=1 sm=1 tr=0 ts=67d36edf cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=e70TP3dOR9hTogukJ0528Q==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=wUlHnouiQKlN4MMnk_oA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: xFYizk4AkeTsf1jYMR4LTYJBE5vsrFwZ
X-Proofpoint-ORIG-GUID: xFYizk4AkeTsf1jYMR4LTYJBE5vsrFwZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_10,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=736
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130180

On 3/13/2025 10:16 AM, Bjorn Helgaas wrote:
> On Thu, Mar 13, 2025 at 05:10:16PM +0530, Krishna Chaitanya Chundru wrote:
>> + * @speed: LNKCAP2 SLS value
>> + *
>> + * Returns pci_bus_speed
> 
> Not sure how strict kernel-doc is about this, but I've been told
> it wants "Return:" with a colon here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/doc-guide/kernel-doc.rst?id=v6.13#n142

Yes, patchwork is flagging kernel-doc issues in this series.
However, there are numerous pre-existing kdoc issues in the MHI and PCI files
being modified in this series. Just look at the patches with errors being
flagged in patchwork (including build errors with 06/10):

https://patchwork.kernel.org/project/linux-wireless/list/?series=943497


