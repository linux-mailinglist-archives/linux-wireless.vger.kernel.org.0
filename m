Return-Path: <linux-wireless+bounces-18171-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FF4A22707
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 00:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E49716592C
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 23:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604DE1B423B;
	Wed, 29 Jan 2025 23:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SKkVnpa0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937B71A2398
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 23:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738194761; cv=none; b=PgalqSSdt3o01uxFlroAwwRnLK9mzelyb7H/7/FZmm3gdEsZwFKTzmNz9sDuKXB4kjJJYJJRdi2hrW0BWx56ehs2D8xZ2y8p8PeEZv1KVbuJEVXRvUCC+iT0Qu6gYddPi84z6AxhV2ZNsK++Bw35qFFLimRdTGcVXHMCneUUjC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738194761; c=relaxed/simple;
	bh=VoYK4KCGBGo39LKZd2XLZwpSi9UbFhrXQFeupTN5q0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uCyOpWvBouYfCB/ykWgKfeAb6vdrCQL1ksZEEaYPI6kMNxbOJE9+dQ96P7IgDKkkTw+7ZBmQ3NQNqSb+qDoYdyowOV/kbXCHjJFmuHOpItQL/NBq1BZIupKusKt2vpwFDFEzyU5pQQMx+TA7ZGqj8xIRB7mr7JyXX3v8KM4As5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SKkVnpa0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TFab2U028276
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 23:52:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	clcrYXE/xU0IeSxr30zaRsk0pTGNb4h/2PI2joNP4us=; b=SKkVnpa0SFS/X8uL
	8AEQ506NSNtJJlcahD1DRCh0UAwcA9oL5B2a7BI3+kAfwy4lir5a6BiyBUjnmEhW
	eclA35H+jjsIN8S5VFdKihIHIKEfsvfTOGxIwLzYo4++vCRkLR6h4TLc+NVpv/YJ
	xKwK+xoNNmbC1zeY6/SDCCi6P58XbWggeT3rjum+q2KReHSn2XteVGEFI6zyJ9aF
	a9QYoB5WfmBFHhNxHfPDEdA1KVMaZPownQA1oNoduMLzr1Y8xg3qt7XLNpwxjDfZ
	0bRsR/CslTpbv0yUvJe8U6lhzFBpDZ+VNgOv5VkJ49RXBAst2Nwf/Bv0jfbv5vdU
	iTuEsQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44fq4gh4c0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 23:52:38 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2166464e236so5968515ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 15:52:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738194757; x=1738799557;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=clcrYXE/xU0IeSxr30zaRsk0pTGNb4h/2PI2joNP4us=;
        b=R4pdDDYNfXG1jbbnUAz73UPCex/TY/pFjaSVd+Ve8M/OMLF3m/p26D7F/W+oGxNLuH
         1wVuR7s7p1HdZxBmHvuuA7ZSL6I2bE/1T3QON4o2Qt1IUF8y37pRWf6uZ41JBieYvlb/
         jK1nlLI/I9zZyR5RM32r8pNNIzCjmPI/P6lqjvo8yyILurcxIjhk3FAcUuUGqilO7W2V
         x1mz395g8WJVBnmhm1VbpKyPD5fcg3QQB3WW2rMu+N6MjtkGcM05HK4qMpuVqeWs5ZzD
         GSwN1ASM5wAOQUAfAKP6qTBAwIuPl6vWA6KG7f+Ir5uxgZyGGi5V8+q5/ObSMGrjgESf
         ymNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRzeqF2iDZ4SKdTvWP0M7htdKGH2K6oMYbx+dGHxtEG1qungegJHL7b3bSxsRyZqYTA33DU2n2c2Jq0pgtEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzJoVBI38eDH+zIvG3DAN6nE8qAfo5E5IAxWsUYHDetu/jGvXD
	brqx3LXU3lu/200OwJprtGb0f+9E3mMx25C4Dvt22F61gZqc6GZMQtRaAivTvffdSZwv3lzbqZR
	nnO3M6Uphh3BlRy4cDCMMl7giyDeOa3rotbRfsG+PNC/kSKEjbECD5/IthDi3gOtzRFSo5Er9QQ
	==
X-Gm-Gg: ASbGncsRMYBeX/ENrmvouLGq0zRQnErgrMxnHCRLqD12wgPAsW+/bcFQQNaSf/TPSSb
	6GEErq+/4KnAMoSJLleRaG7ltg4gsvszGDBvh6OIAoMVW1grvAZffAeStWtgG0A/liQ4mDf3Kty
	gVBWEaNlLF6BJbunyB2r1Rq9GO0sF8SsZ4HXM3h7TQZ1CjYfWlDCPNy8Wpwd2KriuJhvY33bH9H
	uf2eyxn2RHjCH3w6a8qw/sFW92MX/eHLef7JUSmBbQ6aHyzSY/TLO3Ppr/uTncrVDwFEkVvw6c8
	nH+8SO0uQygXeYNBH2tzhjqXqnd9bSQcREyRC2aUK4FjBLjiglBAgrDvRZvs9RlJf+DARX36eg=
	=
X-Received: by 2002:a17:903:41c3:b0:215:b190:de6 with SMTP id d9443c01a7336-21dd7c49786mr60956225ad.3.1738194757426;
        Wed, 29 Jan 2025 15:52:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3H4vVJC6rZ3Hk1xg9tDfL6qJSIWM/KCIRVVCxKy7dxe20bT08UxAnmPL52QeNr66mrIGgFA==
X-Received: by 2002:a17:903:41c3:b0:215:b190:de6 with SMTP id d9443c01a7336-21dd7c49786mr60955995ad.3.1738194757013;
        Wed, 29 Jan 2025 15:52:37 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de32eda31sm1617855ad.109.2025.01.29.15.52.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 15:52:36 -0800 (PST)
Message-ID: <85216244-8348-4fc0-957d-6ffbcbcdb28b@oss.qualcomm.com>
Date: Wed, 29 Jan 2025 15:52:35 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] wifi: ath11k: refactor transmitted arvif retrieval
To: aloka.dixit@oss.qualcomm.com, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
References: <20250119052250.3488343-1-aloka.dixit@oss.qualcomm.com>
 <20250119052250.3488343-2-aloka.dixit@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250119052250.3488343-2-aloka.dixit@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 85ayiI92eL3zPer2nsdHltbE8NuRUeiu
X-Proofpoint-GUID: 85ayiI92eL3zPer2nsdHltbE8NuRUeiu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_05,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 suspectscore=0 spamscore=0
 malwarescore=0 mlxlogscore=722 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501290181

On 1/18/2025 9:22 PM, aloka.dixit@oss.qualcomm.com wrote:

...

> @@ -1538,7 +1546,7 @@ static int ath11k_mac_setup_bcn_tmpl_ema(struct ath11k_vif *arvif)
>  	u32 params = 0;
>  	u8 i = 0;
>  
> -	tx_arvif = ath11k_vif_to_arvif(arvif->vif->mbssid_tx_vif);
> +	tx_arvif = ath11k_mac_get_tx_arvif(arvif);
>  
>  	beacons = ieee80211_beacon_get_template_ema_list(tx_arvif->ar->hw,
>  							 tx_arvif->vif, 0);
> @@ -1597,7 +1605,7 @@ static int ath11k_mac_setup_bcn_tmpl_mbssid(struct ath11k_vif *arvif)
>  	int ret;
>  
>  	if (vif->mbssid_tx_vif) {

can/should we remove this test since ath11k_mac_get_tx_arvif() already does
this test? note ath11k_control_beaconing() removes the test

> -		tx_arvif = ath11k_vif_to_arvif(vif->mbssid_tx_vif);
> +		tx_arvif = ath11k_mac_get_tx_arvif(arvif);
>  		if (tx_arvif != arvif) {
>  			ar = tx_arvif->ar;
>  			ab = ar->ab;
...
> @@ -1701,9 +1709,7 @@ static void ath11k_control_beaconing(struct ath11k_vif *arvif,
>  
>  	ether_addr_copy(arvif->bssid, info->bssid);
>  
> -	if (arvif->vif->mbssid_tx_vif)
> -		tx_arvif = ath11k_vif_to_arvif(arvif->vif->mbssid_tx_vif);
> -
> +	tx_arvif = ath11k_mac_get_tx_arvif(arvif);
>  	ret = ath11k_wmi_vdev_up(arvif->ar, arvif->vdev_id, arvif->aid,
>  				 arvif->bssid,
>  				 tx_arvif ? tx_arvif->bssid : NULL,


