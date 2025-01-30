Return-Path: <linux-wireless+bounces-18175-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F57A227D7
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 04:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34AB91653DE
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 03:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14D325634;
	Thu, 30 Jan 2025 03:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D2Jz90ex"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED1133F7
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 03:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738208208; cv=none; b=dEMFqRDx1ithMViSNAxEDiBXBN11N6eW0cPmCjtXKtCprXsRQVtXHkeCWCY61RNw838tmK66efCKzsZR0aX4h+L0nE1zsCtY/YZJnoJHPh67Kun4O0B/fxdmfW/GrHL/aVgUiD0Lxafbs40j8yhY6DDRcjQvOl/0AkMPkzqScsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738208208; c=relaxed/simple;
	bh=Dl7GI2cBmAppunQKRZj6T0qX4dIfPFP+x6zFbBEK4vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hCQCXlDDPI83Afi0BD0k6hmtLANQlcxk6WwY5ofnPkqjO5faQyFdWytBbmh2BDUX2OV6F303WyOxbpwnnYnstxrwRR4yW/fxTr4VWL0MMLbFAxDbGD+OstbDr+EhIQl2pQ5ry1OqQTnu0IBDyRhWufYuUMxqVaVVYFJK9WFnUWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D2Jz90ex; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TJmSVC022843
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 03:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xug+E7ij4WF0LuLuZ/OHsojEglbBOq/RVcXRzH7G0So=; b=D2Jz90exge5tU5Iq
	5mMbXyAAMEUkZXPRBiv5/GupHCS2HM05SR7LunIRQIa09LTj/LJicq9weMaPmzXP
	vspB3Gx6oI89A4iKRktHlwNJvD8ymswx8pQBaZu2MePLKKrv2UwO7mURn+HKxoca
	4ZSqQLhWayOt1T6NdOCbxrd/5Hlu/bpKxMIMoVoh5t8BGbtWIe6fE5qQUdMJ1hxm
	PAd4UxE+INIXiuu+FlNJWt0BnbEYnkRGsfjzoS0gUkwddOc/RdtH6Q7sorA8YvEd
	zMX+zdjguDIyrs7fqCrk7QByTvYLsdNFF3Df2Q6O+jdSHabJ5iliNSjeLYkhkm2J
	1UPOsA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44fttj0rh4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 03:36:46 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-216387ddda8so8044015ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 19:36:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738208205; x=1738813005;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xug+E7ij4WF0LuLuZ/OHsojEglbBOq/RVcXRzH7G0So=;
        b=FCFgX8sKjEnb7Z4uhWP26KFGZTyxpPJ2CRRqAQoVR6NS5mk4Ac3NkEiKZXod46XpdK
         YibjpvwU9oQVDCWLb8x/6e08PgNZkzfd48nF7hTa0f08ioQdh//lc1kxiOxiWB6kLONx
         8xPJrpyknjmfiRgOo0QCXA6BMTJJDScg6f9hCiUE9TQWKo9YDmGVisEwYvynOT91zukB
         mpr3VnhBPuzA47LK1gN+s5JipdoJkcewjAYr4cM19HgZ2ikJ6ynUfr8vUjxyFMHd5liR
         dS+kyT6FWsSMN2CUJ/639SYoh9Qx9yvL8A2gYVE+Vg7HEG0WWMnaECGpqvo5fWqnhc9q
         /Llg==
X-Gm-Message-State: AOJu0Yytz2EK6RyENsUqRnync+2MWfTk+8FzQvuS3F+ciyCHt5wMmUHt
	01HBbSPTbghTXYyw8MExlW6RZGCFZCRvH0BPnG9xhUevE86GI/LsqoknAkQ38p0pZaH9Pqgf3it
	hlAsTahcUS+duquSryfy4jGC7oT1S1+F92k3R3nwKubYikXuoXRlElhHIx7h9XZn4Yw==
X-Gm-Gg: ASbGncuMSxvlS5n+2dxFmBJopFl1JWdZecURW09J2j7ux0seN3oLeCXZj6As9kQRHp4
	gorv6cqZifPPtktBuXBXjXXbs5q1oK0FbH8edEBMm4ABCUk4ez9HbvJ9+qjcNwkoSb3KXY+pDSC
	NamzIJ2GZ16OI9JrY6SDSdNGoiC6gpzE5RK/i4qiMD0olhq2FB05g4lwZYKX/ZLrrvqsRkwrN7B
	7q3FEUmsBKb93DB2Te5J5wR9cA3EN7JLjSOW+7d8lexx1ROSxeGcIdlsHobOorrosOVvsKWp+qo
	IBZDovPkdB5prHGW668baCyr3A/E2qa0GcblRAg=
X-Received: by 2002:a17:902:db02:b0:216:69ca:7714 with SMTP id d9443c01a7336-21dd7c46297mr84253355ad.11.1738208205325;
        Wed, 29 Jan 2025 19:36:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIEes1x7Hp+Gh7oCa5B+RDPrqST2NNoI4k3f4nlFhDmTxUxUeMJxGThJr0IDzpglY+9vqCFw==
X-Received: by 2002:a17:902:db02:b0:216:69ca:7714 with SMTP id d9443c01a7336-21dd7c46297mr84253165ad.11.1738208204909;
        Wed, 29 Jan 2025 19:36:44 -0800 (PST)
Received: from [10.152.202.18] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de331fa58sm3673225ad.233.2025.01.29.19.36.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 19:36:44 -0800 (PST)
Message-ID: <0cc92ac1-9566-46cc-b130-7546168f43eb@oss.qualcomm.com>
Date: Thu, 30 Jan 2025 09:06:41 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] wifi: ath12k: fix handling of CSA offsets in
 beacon template command
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250124-ath12k_mlo_csa-v2-0-420c42fcfecf@quicinc.com>
 <20250124-ath12k_mlo_csa-v2-2-420c42fcfecf@quicinc.com>
 <6f52dcd2-3b0b-4c19-b8bd-cd17dc4543b5@oss.qualcomm.com>
 <2b5bdfc8-95f2-4919-830f-c35d152055d1@oss.qualcomm.com>
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <2b5bdfc8-95f2-4919-830f-c35d152055d1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: GFzq6RdNrx3ueiSvfUun_YQcdIM95xSR
X-Proofpoint-GUID: GFzq6RdNrx3ueiSvfUun_YQcdIM95xSR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_02,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=867 spamscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501300025

On 1/30/25 06:48, Jeff Johnson wrote:
> On 1/29/2025 4:40 PM, Jeff Johnson wrote:
>> On 1/23/2025 10:16 PM, Aditya Kumar Singh wrote:
>>> @@ -108,5 +108,6 @@ int ath12k_mac_vdev_stop(struct ath12k_link_vif *arvif);
>>>   void ath12k_mac_get_any_chanctx_conf_iter(struct ieee80211_hw *hw,
>>>   					  struct ieee80211_chanctx_conf *conf,
>>>   					  void *data);
>>> +struct ieee80211_bss_conf *ath12k_mac_get_link_bss_conf(struct ath12k_link_vif *arvif);
>>
>> This patch now conflicts with:
>> wifi: ath12k: report station mode transmit rate
>>
>> but i'll clean that up in 'pending'
> 
> 
> please check
> https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=47bc4c5c6598ef2ff3a362eb13dfe4573ab5d910


Looks fine, thanks.


-- 
Aditya

