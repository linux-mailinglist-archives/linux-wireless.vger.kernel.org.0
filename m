Return-Path: <linux-wireless+bounces-19137-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1F4A3C64C
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 18:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8FCF189AB2F
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 17:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7D62147E3;
	Wed, 19 Feb 2025 17:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Uez5vy9/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86635210F5A
	for <linux-wireless@vger.kernel.org>; Wed, 19 Feb 2025 17:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739986600; cv=none; b=ZGRTXSwNwkmYSRGzWvm7urq3Izu5avr2wKduJDbN6ZvwRbq6X5xyxNohXw2K5rBG6+QFdgKf5mL9f/xUgq05krmnoagcmL+cTDREs1AgdBC01Fztybzr7QW/OgKU6WKBfRGUKiiktx4s/AR407KlCloah6INSNTBKEivdUPxeGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739986600; c=relaxed/simple;
	bh=cTRVC5cVHHMwudxEBc5SELgNQq75C7XYr5CxcEbuix0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m/gVAPFskBr3+wmghVy+oO2SfIIQRyDUIj8fjtmI20Fi1+RByFVKyFbhj7MINrPGp4Y/EhB/Y7MsAdG2lzmjwI0I8XPk4cyKKjS2ZkaO5qkVhHi5ZMnyQW7b2CVCMDNdmvcoQQ2OnT75JQPl9zS6OKvB4aLD0zXZaA6ET6NMvsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Uez5vy9/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JGF3Se031994
	for <linux-wireless@vger.kernel.org>; Wed, 19 Feb 2025 17:36:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ee6+eorvO+pF3kR9F+2d8nZr7k36mhnL8mV9SwVW8g0=; b=Uez5vy9/RyiB0tv/
	f+sAocr9hCj/X06Z3bMHTU+2ai1VgItIHof8aKzgmHvGInh5ayGKtEfnXeb8ay+A
	42eTidUs9ObQN05SdI57k7/45KJWBJRKZuAceU+KJGrJE3HYVbLjhxbDA6hLOcBC
	jenY1OhDJbmYu3n3RPlwv8rn23DJZg0QzteZ2BFAObmStL5ANhGoz3dxZtqVKtY8
	QlTkh28gT6Ar9FJgpxTvoovJ/eG/z/AabQFRSV0uKIiiyoPVlg2b+Hvp3HRTTwJv
	9YlWggH5LJlgFvV8apnkfboxrm8dYbZwu2sPVuqpm94SVbwgBWIz8U55bnXOFW7S
	cyBPXA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy5bf36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 19 Feb 2025 17:36:37 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fc46431885so98955a91.2
        for <linux-wireless@vger.kernel.org>; Wed, 19 Feb 2025 09:36:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739986596; x=1740591396;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ee6+eorvO+pF3kR9F+2d8nZr7k36mhnL8mV9SwVW8g0=;
        b=aSoMNDIn+geBYJ3Bhro2ghOQV3sxyGWFRz5l2dXKMYLw8SWuarZOPAaYfcyx2yjwf0
         S/Won8dQZF6chSOit4TfxzigfknU7R5yYqkMSjbgQQyo+UxrvcCPevT1MYTEbEZqUB1t
         pS0C+25p60A1Bz4uujhFu2WmIsF2Rrgn9gFTaNRP1wACHZ97Zb4yQKrbABBVyisMOORZ
         +t+zM/ZNSTHb22HhGSOUXNMM1/7YgJ004SiXXzU2l6TRfWxVTjNz3WhhdiIN9c+yHYNA
         rN5Ocoeh3frNjyjiuBIF/gAnKdnGg9Ah0RGm42yAiMq34eGLiSfLZHUemIQx+75JqVcD
         JnqA==
X-Forwarded-Encrypted: i=1; AJvYcCVF18tPpqw+PwswqFlTYeiW41Sl7MJXAbJYxviSIxtsFjbIzO6/ui7H/OEoj3SGY9geQYpQRyyxpBReMIG0Mg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAA2/NQxGRsacZrZPCRtBAZJ0YUBErV5RgnTZp7HtMc5fRT62t
	p23Xe7C+w2ogY75nPs37Wnv/ifRVk41eRSqmxghBIl/ZjJCfN1vtE39Bz4JLdigJBBpqgD8Y/kc
	2657qqHfeMMPTxsPJ96mRBqyppIS6G/9qZCli6KDdApDPb/08Ts4BXen5Uqk7VCxfQA==
X-Gm-Gg: ASbGncuOQRMcrxJEMu8w1ZMdZyJ6HHwaxPDjvO8GO0rABTfakppngxCEOEu3/MHM0g6
	WB4Md8T3Y21xZUcE2qOHXhskrm8PF7AKsNMpnwcdd+5/PiatZm9KeY8XC3N1zJ9NYbNRz/3Aiha
	TPSMKJKT3fJAuhiRZBEgIPd0WZI10aqdR+/8YvhpvjiSymOrK40iJSx2q6vR/LoSqo1opu9kCUl
	z9nUgQEX6iltRdM3Z792mIMdWAwj3I1OO+R24xV0Y8Mq6jyK+EvagrCs27g3JITIBjHEMW/Vxv4
	H4w8TMvGdVWy0bastinUAZnXMYb1PJhXCnRGeH6zyNH+tM42Gse3dioyoX+O
X-Received: by 2002:a17:90b:3b92:b0:2fc:3264:365d with SMTP id 98e67ed59e1d1-2fc40f0ea25mr29237103a91.11.1739986595756;
        Wed, 19 Feb 2025 09:36:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJWmXWsxGjClVm/zthfCXF+H+3XyeXB7GQZrRmqkGHU6xzsOjlVcHnjYZJYGEt/oE92j+xNw==
X-Received: by 2002:a17:90b:3b92:b0:2fc:3264:365d with SMTP id 98e67ed59e1d1-2fc40f0ea25mr29237070a91.11.1739986595423;
        Wed, 19 Feb 2025 09:36:35 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf98f4f62sm14557474a91.26.2025.02.19.09.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 09:36:35 -0800 (PST)
Message-ID: <b0027c1e-cc0b-46ff-8b46-774259f3ed0f@oss.qualcomm.com>
Date: Wed, 19 Feb 2025 09:36:32 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] PCI: Make pcie_link_speed variable public & export
 pci_set_target_speed()
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        quic_jjohnson@quicinc.com, quic_pyarlaga@quicinc.com,
        quic_vbadigan@quicinc.com, quic_vpernami@quicinc.com,
        quic_mrana@quicinc.com
References: <20250217-mhi_bw_up-v1-0-9bad1e42bdb1@oss.qualcomm.com>
 <20250217-mhi_bw_up-v1-7-9bad1e42bdb1@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250217-mhi_bw_up-v1-7-9bad1e42bdb1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: UADZHE7-FYU008PwFmjhEc2xot70AsWV
X-Proofpoint-GUID: UADZHE7-FYU008PwFmjhEc2xot70AsWV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_07,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=558 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 adultscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502190136

On 2/16/2025 10:34 PM, Krishna Chaitanya Chundru wrote:
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 58f1de626c37..8a3b3195122d 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -305,6 +305,7 @@ enum pci_bus_speed {
>  
>  enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev);
>  enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev);
> +extern const unsigned char pcie_link_speed[];

This, and the Patch 8/8 change that uses it, make me cringe.

Should we instead have a functional interface so that the client calls a
function to perform the lookup?

/jeff

