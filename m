Return-Path: <linux-wireless+bounces-26635-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8D4B36D97
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 17:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F546189CE89
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 15:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B38226C399;
	Tue, 26 Aug 2025 15:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eIgUxzsw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8197121ADA4
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 15:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756221557; cv=none; b=pvAD10mmRZfbgIqFBOtmJsMz7HWXVvbzWz7fi7wqL6KGO1fgagYl7S5TPBrY3x4Ll52+ULVCnfaoa6GP3FXBOSSldogz8o/cgzJ6eSjyhRBuEdmnICNy/fd8uF7/zINtQaUZQeHExfMOkxbDj+/3lW46bb3nQ0X1CGYR0O8UukA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756221557; c=relaxed/simple;
	bh=2qMlQd1EHzZMq6k8FmHmnZfMzOsgEOBbXiMatiIDWT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s51Yv/ntCQtExB77pBpU8irjJut/2iXu7luhS5WWRIpYeUgecKTUs8Be+2EgmGDGChJaOKZvJBsGvGmLTA6AdipVzyGPG3aiGI1UvOzQDZQMesu3UG4f1wEdm9tgBwepKB/ONQ5oH9CMLZwYPcRORcpPzJ03Hx1jr89PTTckMq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eIgUxzsw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QDBIH3027928
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 15:19:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SwQL66e3Nu9k+2rWN9KxTqPiCmr+WouftcMZ22iOrnk=; b=eIgUxzswlkZHaCJj
	rnGJn/nm+urEM+YqiKmfCGzN9GianKouzNyZ4SMpX/5oHoXQBdOD92gtcvaJyGHJ
	HYcIwvtBb3wL+6ClPuis+8ZugT820zeUWhxaAf/J8MFqajlb0f8yyom/5qH5LcMG
	MPAUcLqG5oXx2rNdeim+dtqRMpnKQN3VNzUkXKaqRqHcyyoEQYQ32v2vAd5GIvcj
	I/rZmy9gjqo6fhYhEZZ7aPePWpgmlf8i9yjFrk4UWnkuiUfZKWJqX5k3ICVl6duZ
	fkRGBAvgp9w8u/ByXFJ3YR7qq/jxHiPjhtl5ldeR9VJji7FtqxQDrB7rFCfZIW9A
	ZrE4EQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5we14ya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 15:19:14 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32752f91beaso441367a91.2
        for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 08:19:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756221553; x=1756826353;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SwQL66e3Nu9k+2rWN9KxTqPiCmr+WouftcMZ22iOrnk=;
        b=C8WGyYVubhXIpTMOAyL8OV2sWQ0Ko3Kfp0pVmFYCgDw538YmjAEZ6SsXa6OD+Dy8V/
         J+eNm58inKrHVk1QYFtRT/qQJoXBoDbnfHfAwtSuUufGyAOLW8COwgCJzr4Gk9deJpUv
         qgAVogao+NQcgEv3D5JWrn3cLcRfyYOEU65vKRuahePDEaAcWyk0niDchusQW3K6meVe
         boaxTQhNzJVOORKabIp1VGIxv9CSDtp+X+o0rGqFIdKEc/zsVMyxmHJ4fho9yWvNPhFD
         kL9tSf6ZVlPhj2uXZhjWo+b12LktpAZOhvIpAMjzb6zsaDTKmJMyP8RDf5GU4P5vs03Z
         qDVw==
X-Forwarded-Encrypted: i=1; AJvYcCXiDNdPnifZSuXlQo73vi7ut1K/bOu0OLqRhJTwMozZRiljkUzy2OTUpUFNYtk++dstsmPCKJJ3vawdb2S+Tg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Et48wlNIckc0ojW00kvjiC+b3Y+xJPq8VQ6QkHjD5c+M19bU
	4khUsjJbgd2HjbJCxJzUzgwvViEU8qhZnZ69r/pOYuKhdEAKQEegY7aGs05SvQC0lB21SbfIJ7M
	3hM9jXAGXtz0js91HAoUq2D+Xc0Z9fmOPBwiPi2N2XCUywuDzdSzYu9NYEIxg1HWBEFv3Xg==
X-Gm-Gg: ASbGncsDXstS0I7aHakd9t0NC4prrxIC9QMBHE6WN3QvB4guEAFBPubA4Ma1dHCTKA7
	WhZne1zPV4kQBbVzXvP9IFv2kuywvSu3u5XSoAc7MAFhYr3YFVUs7QWo5sEHPXE7tEqDyV4U7UC
	03LaRbzdU3jT2VbK4LUyrTuddfzW3iqMlqE4gVdEty2N2vEa4LdjvJer/HjgMWGhLi4Z1CI3ijJ
	foKTi/lB9BdMbgcSWxNXOH0nEse5BWNzBV6HTZb9nMKVVtDQqIIiklA3lPBDJYXr0Po2CwylUA1
	6C0qo6zWDJsT394Terc4KQtAnKY/25mr2C0DpO+V+X5ZGdiNvzMl2sUn/jxJ9jvraeuuxOeo6cj
	vxqQQ98vgshycAO/ZsmU=
X-Received: by 2002:a17:90b:39cf:b0:325:17e1:ab69 with SMTP id 98e67ed59e1d1-32517e1b5a7mr19762823a91.3.1756221553190;
        Tue, 26 Aug 2025 08:19:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBFCqB9ocm/fFjwbsOzFsZHFiZH3GbPHYwnLpzF4CEcjFDhaSfsGGNUpwdAdtaM5f+IRrboQ==
X-Received: by 2002:a17:90b:39cf:b0:325:17e1:ab69 with SMTP id 98e67ed59e1d1-32517e1b5a7mr19762764a91.3.1756221552537;
        Tue, 26 Aug 2025 08:19:12 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3254aa708cdsm10154132a91.26.2025.08.26.08.19.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 08:19:12 -0700 (PDT)
Message-ID: <0993bd25-3cab-4f96-9398-bf5b5f7770cd@oss.qualcomm.com>
Date: Tue, 26 Aug 2025 08:19:09 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] PCI/ASPM: Return enabled ASPM states from
 pcie_aspm_enabled() API
To: manivannan.sadhasivam@oss.qualcomm.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam
 <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, ath11k@lists.infradead.org,
        ath10k@lists.infradead.org,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20250825-ath-aspm-fix-v2-0-61b2f2db7d89@oss.qualcomm.com>
 <20250825-ath-aspm-fix-v2-5-61b2f2db7d89@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250825-ath-aspm-fix-v2-5-61b2f2db7d89@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: NSvd6YL6A8Y9m1YXP_4OCiooZd27f_2F
X-Proofpoint-ORIG-GUID: NSvd6YL6A8Y9m1YXP_4OCiooZd27f_2F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX3emH3Obc1dPT
 sL4+i0LgfLiXo5gDXcAAE7gm81PEF0uDC1sifN6BBhpXPe555+oA6IAGm1qyd+3AszmcpNEl9yO
 8btDcl7qjSX548FLqtSqXyNBLdYX8DDRkEZfm/rIdiumoFfkdjvv088Bft1SfolEJZCzrLPc1Zi
 5H5I0aGgb07xp3to/if5EPjGCJP8VFphJMwJOCIVU81khapKSojKeWFFG2PR7POr13qvgObQAJw
 81oK5vLZVg9vCzQccu2YMqMftuVuGcbKcVzAH6lUvcl5qa8xSXsPZXzIebReEWnMlHHLf866uvS
 zfS5J5aOJqJ2SLDTchIIqXTn2JN1OH7y+GX2K+sj94TGjP6aY60dHpCHPkQKDFWIBOVPm+w8Eae
 1xoTOkO0
X-Authority-Analysis: v=2.4 cv=BJazrEQG c=1 sm=1 tr=0 ts=68add072 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=guytT1_IP8q0_Fb2ReoA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230033

On 8/25/2025 10:44 AM, Manivannan Sadhasivam via B4 Relay wrote:
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1851,7 +1851,7 @@ int pci_enable_link_state(struct pci_dev *pdev, int state);
>  int pci_enable_link_state_locked(struct pci_dev *pdev, int state);
>  void pcie_no_aspm(void);
>  bool pcie_aspm_support_enabled(void);
> -bool pcie_aspm_enabled(struct pci_dev *pdev);
> +u32 pcie_aspm_enabled(struct pci_dev *pdev);
>  #else
>  static inline int pci_disable_link_state(struct pci_dev *pdev, int state)
>  { return 0; }
> @@ -1863,7 +1863,7 @@ static inline int pci_enable_link_state_locked(struct pci_dev *pdev, int state)
>  { return 0; }
>  static inline void pcie_no_aspm(void) { }
>  static inline bool pcie_aspm_support_enabled(void) { return false; }
> -static inline bool pcie_aspm_enabled(struct pci_dev *pdev) { return false; }
> +static inline u32 pcie_aspm_enabled(struct pci_dev *pdev) { return false; }

return 0?

>  #endif
>  
>  #ifdef CONFIG_HOTPLUG_PCI
> 


