Return-Path: <linux-wireless+bounces-17840-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAF3A19852
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 19:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D270F16A60F
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 18:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A688D21505D;
	Wed, 22 Jan 2025 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l4X2nVc0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AD0185B62
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 18:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737570026; cv=none; b=Hmox5AnzJG2iTLP1GNTBJPBoZrr9SOJ9N5nOymjZKlLP9hlJHZh1z7c9iIlIAxiPy/WfkMIGvVCqeqPKe1dNelZUuLuwxdX8mxakk7egTDtNxmJ2KehlBbAqQXUieEtWCePbKzaYS+0veuNOytJ+bT5Mn4UJjgPViZ9e4fAF9Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737570026; c=relaxed/simple;
	bh=lapDNx84xERtom7StX9gMRlNSe3XoFlIRgMvhQyme30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DOLBl/Ck14li4GN0AXBpbOM0hGJSQ89hKq6gNtHOTrHk8UT8b96CF86dVa3GM2xhNnF8S7p8VAEn29i1cmH3ILT0hxhCNJZRQ9YcPdk7ym5klFT+dMSZJCE9kdOb7FieRRHpWZxuxKxlNNFvN7eqAGBs4+S6Chcct3HgKibRZQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l4X2nVc0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MB7f3t000897
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 18:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+uJ52ubj7XfnuWc9JLHme1AuZ9nGUWqdoxinnTRr+PQ=; b=l4X2nVc065Lf4ajZ
	RrOJKl2UVDfMyMHa4tkl/suhYj91+rv7y95TcNgqB3X/wuBWxJlR16ij1ZHW/Rhy
	HYttp4L6nlgeGemDE34SvMpBlxDzP8ri9mmRQVFanUBlALiv6x4SXP1N2ANAVXeA
	osYBXhchOk8hhFYW/rjPX4k9fjgMJt2cJBNLGR35ZdXOOWOiuZBLxUIhxUw5yC/U
	qSTRJxdsyZzWFtLhUFL1WgpuM9rEmdau8fb+SQph0HmX3EPidgoB6FR8FGHb77aU
	xcUeJTSQFH7frJ4MkjEsP8ZZp8rcwckWXfviD/ndccqko1IqJHAygdk2ob2D4mRy
	7V6/cA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ayhcs0jx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 18:20:23 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ef9864e006so255267a91.2
        for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 10:20:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737570023; x=1738174823;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+uJ52ubj7XfnuWc9JLHme1AuZ9nGUWqdoxinnTRr+PQ=;
        b=AgzbtyXi2QF90pXO95mRMEnypq0HVndwdsuswzG6p5wzXm8HGUjFHcLM1AjAfAqYAv
         eWZR2IJfaTyhSEcbGhYS13tgaDwxTZXpCKNqiJebA+hRXqTz5D9QZplY3BJ3NDF/aK2B
         3jsWBEeOmwrDL6H871IfmQWnf3MW0LhhaA4DDK9Y6beGNza4XYqRBj7f3HoQ/vSl7bZl
         kqfxNNq9zY4d7a+kBOJfB4KDR6gWFn3JuRgXyi5Y+20PSwoSZa7ctSQIv+9GKl8DXFpC
         RP/M97Y1jtwjQVTvqQxcC8PrupFx47mdCCV8aM4r+3PzxpkZtJFRvUQIdrO2DIZYosdw
         8gcw==
X-Gm-Message-State: AOJu0YzhOShYAL2HuOsKoIwuNdp6iWv7cMOZvUtb/K+wyZ4+c6GfRPdI
	cUVkDCCpeVvlRJBBBg/RIdqQnYJSDcG+bRA7U1WYxesMtRIzN7K25JTyIXlDCdZHL4DW9uzXuLK
	NpMxhSZf07JG0hzrvR70HlVAeprTG64bFJt0vSRqq4hFUbJR6oZXiVLUCrO/Iq4yLSg==
X-Gm-Gg: ASbGnctiIjRqdHMxDWOg39kZaO90kLmsbYJj95c1XugeTL9DJLjPwZUiloFHIDsYjhw
	C24QzZ+l2WdqFu0hPhH+fsvrPWz7S5qoCtouXHr5rsghRxEHIIppNejo9ESThdMUo8lta7jP9YH
	GE21oXu5Av4aDUCt3X8X16islj8jh2P8neKkJFoA2x39JUvTEqYe2ki8pzyEao3xiwYc3bpYWQ8
	PCQnEIzA6/V6LJ381XO7B87AJzS11EY4/9NE9OTrnbtg9U78S6a5KBkihwVCraeUlJIS909oB2e
	SGwQtpQOPZIQi4G+p+HPk8Vz23DZsVvxVhbLMJrmOY8Od38WGCbdF+Ku/7qhUFY=
X-Received: by 2002:a17:90b:5201:b0:2ee:d797:40a4 with SMTP id 98e67ed59e1d1-2f782c70204mr32798371a91.8.1737570022927;
        Wed, 22 Jan 2025 10:20:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbV08zfYZrDeHkqmHseq+n+WM7WC0S7sRRhwWpTsgEUq3IreARUrYMbEj7IzJknYm3ZFHFsg==
X-Received: by 2002:a17:90b:5201:b0:2ee:d797:40a4 with SMTP id 98e67ed59e1d1-2f782c70204mr32798342a91.8.1737570022550;
        Wed, 22 Jan 2025 10:20:22 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7e6abee96sm2006077a91.31.2025.01.22.10.20.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2025 10:20:22 -0800 (PST)
Message-ID: <d0dfce80-3e57-4efe-8552-b18bae9e9437@oss.qualcomm.com>
Date: Wed, 22 Jan 2025 10:20:20 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix skb_ext_desc leak in ath12k_dp_tx error
 path
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250122160112.3234558-1-nico.escande@gmail.com>
 <101c0824-1c0d-4e5f-bb4c-7d6ef65f1698@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <101c0824-1c0d-4e5f-bb4c-7d6ef65f1698@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: uGOBV-Ulxs8WzMvwGLilFPBbkQPiYtF1
X-Proofpoint-ORIG-GUID: uGOBV-Ulxs8WzMvwGLilFPBbkQPiYtF1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_08,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=899 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501220134

On 1/22/2025 8:46 AM, Aditya Kumar Singh wrote:
> On 1/22/25 21:31, Nicolas Escande wrote:
>> When vlan support was added, we missed that when
>> ath12k_dp_prepare_htt_metadata returns an error we also need to free the
> 
> nit: Always refer function name with () for clarity.
> 
>> skb holding the metadata before going on with the cleanup process.
>> Compile tested only.
>>
>> Fixes: 26dd8ccdba4d ("wifi: ath12k: dynamic VLAN support")
>> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
>> ---
> 
> If there's going to be a new version please take care of above nit 
> comment. Otherwise -
> 
> Reviewed-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
> 
> 

I'll fixup () in both subject and description

