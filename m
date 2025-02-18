Return-Path: <linux-wireless+bounces-19103-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0C1A3A4B4
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2025 18:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47BFD7A4D79
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2025 17:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41CB270EC0;
	Tue, 18 Feb 2025 17:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="maBnwhyN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38ABD22A80F
	for <linux-wireless@vger.kernel.org>; Tue, 18 Feb 2025 17:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739901377; cv=none; b=AVDK8Q5YcYFsb4c/LB3uI11ODmJnNs/cs9SIeXjnnjDBnwBqk00xK1UH2uFMVKJVO+R648fVTeQTQ3JsFXkIxS3BG8dHAbuaSTUCdGuz3BOB3msDmMUQmHmkFr+zq4v/ejyqImTPN8tNlLxu9sNbJEkH3fbjHNW3PfIAAfq0sZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739901377; c=relaxed/simple;
	bh=oTjuUiXvhzJTYfdkErAeQEBerMb8kTrvk9je9AIL49A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=D86Dtt3HDte9kzfVsA0Wem0GWLOaed7mr4RY5NIuUDG69EuJrbi3BA1AMZNPMk6CvDUjQJDgkia6Ag3OG0D3DdP9pvLUcAx+HxWF9/SVLljVFFU5OQWBj12SLMnwt5O84mO8vsZUYvjCdjqn304YGZscIHaDJ2IAjBRQO8yfrxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=maBnwhyN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IBM5AO025180
	for <linux-wireless@vger.kernel.org>; Tue, 18 Feb 2025 17:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5MZEcgITSiiKIsZylFwsENK2tYufFg6kig8Md0m03l0=; b=maBnwhyNo4vyavOI
	3qYJlKMw4oixT5ZXQ12wvrrJ8n48BTX4bMntxD7JOvvb3DQrVnPiuCHb5Bhskv+7
	c3QB1jED8ltc3AQeBNJagJpsLjNj9/TikfnKQVMD7Y5ZEpsIHfzezgks76us3eZ5
	vtjkZ0lfXIuPUHDpnYI/LN964F27tQzJ9XlRMgCO2wPegvmraveJR1Kg8vVMs+Rv
	Cqa4VX6HiR4vMAuHb5seMEOaBtfx5y8hpRCcN4rrFU7pxWNlBSUFHLHXrs8SviTE
	N7fR07kLTvXIyRzmLYhs2LSgpQMyIb3+0aTvhh3V6aZFE5x2nA4wYmZeF1hdZ835
	os4w9Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ut7swquw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 18 Feb 2025 17:56:15 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fc318bd470so8569597a91.0
        for <linux-wireless@vger.kernel.org>; Tue, 18 Feb 2025 09:56:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739901374; x=1740506174;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5MZEcgITSiiKIsZylFwsENK2tYufFg6kig8Md0m03l0=;
        b=mXWpMAML9vIaoQuPWxitSn57U9q7iSH9XoV5FVKYTjd+gpFvQha1qWF6RYWxrCAFbw
         HVXQmr9pxqJNe2A8eBelMSD+R4cFxWnkCepnakt0IXVSNVbhIYH700FVXPoJ87cUJtRd
         Exi7+kQHwgKWImND2XH+RMeVq9+gWPYv2S9k1mdKbHrNy+HGwW8EUd+lOIaA3iBSWBqH
         BkS+abIV9GXMWfUxr/FhEm0lzhtURyo8iM2JPxHktZDEyXtmn2CEoneSc7V1eHhEgDtF
         qptu7u8WmhvWIWynq5QOCkqWYlgPGyz+pmVyyhZZ9jkx0811LSG2VHt3k5ZT9r6P5FFu
         M9pQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnrJm6c7+5edJd7Q7kK4XL5HIZ6+jRgJJ/gt4aW/QknduykF8f8A41pWMZfKcqsuIAbbf/MnrJmZOB3aE/eg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxw6KxUMVKEfB3ygKzTXJSzzznQ6Cdxlyrq68dE0W207AD6wxx
	6XIDQkIKWTBng+1vgZO3K6klxXTtk2NVxuAymQUHIERUQ2VCEC41gTKxyvZkpnRbH6yBJNQG9tp
	08VS3wFcQwdFyLBbXRXALAp+M4O4nHOIwLGSA/nUpxSsx8MXvSx/yVhQUI5bHInxBPA==
X-Gm-Gg: ASbGnctm8acSD/jfXqs096Ta/wjYWLHf4NYfV7S12dL3gXSNx62VLukK6tH0A6+qreq
	mLD/PjeabTZ1AhWi8zvNsgixkj8td/lezOJPuG6v+lEDxBgXfjhh4CU4GM2wSIt/KsUmBpBcrr7
	sMi/K8j8NX4CBenOBnv+FxgFFHQsHZGyOSrIDTLqcSLO/sL1OlYkOzEz/fA+T7bI2VjbUVBIlzs
	oCw8QioEkKAuJUdSytW64ezebsvH/D0NLEBdJx8/NaSV8Whq6ptZc3kXTkfj4sRpDlfR1gc1w3b
	5JrOYPzaTnMl9DzkasvLVoR46EL3srt8FGefaIW3Qw==
X-Received: by 2002:a17:90a:ec8d:b0:2fc:3264:3666 with SMTP id 98e67ed59e1d1-2fc41153decmr20652828a91.30.1739901374479;
        Tue, 18 Feb 2025 09:56:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHRnoQUBRepGyq2OMwaJX32opGFnz5QDIQdI91vfH8K801jeMK8U9QrNGbTTdrdnvAPHaa+w==
X-Received: by 2002:a17:90a:ec8d:b0:2fc:3264:3666 with SMTP id 98e67ed59e1d1-2fc41153decmr20652787a91.30.1739901374048;
        Tue, 18 Feb 2025 09:56:14 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf98f698dsm12342252a91.28.2025.02.18.09.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 09:56:13 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Harshitha Prem <quic_hprem@quicinc.com>,
        Kalle Valo <quic_kvalo@quicinc.com>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
In-Reply-To: <20250210-ath12k-uninit-v2-1-3596f28dd380@ethancedwards.com>
References: <20250210-ath12k-uninit-v2-1-3596f28dd380@ethancedwards.com>
Subject: Re: [PATCH v2] wifi: ath12k: cleanup ath12k_mac_mlo_ready()
Message-Id: <173990137296.1304166.12952412255986592297.b4-ty@oss.qualcomm.com>
Date: Tue, 18 Feb 2025 09:56:12 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: p3KZR1fB3BMTBuAdRgzlBIYUJOkoYR-b
X-Proofpoint-ORIG-GUID: p3KZR1fB3BMTBuAdRgzlBIYUJOkoYR-b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_08,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=420 phishscore=0 spamscore=0 clxscore=1015
 mlxscore=0 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502180126


On Mon, 10 Feb 2025 21:49:41 -0500, Ethan Carter Edwards wrote:
> There is a possibility for an uninitialized *ret* variable to be
> returned in some code paths.
> 
> This explicitly returns 0 without an error. Also removes goto that
> returned *ret* and simply returns in place.
> 
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: cleanup ath12k_mac_mlo_ready()
      commit: ceb3b35f5ef4a0c490f54eb8b53075fd83a97d11

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


