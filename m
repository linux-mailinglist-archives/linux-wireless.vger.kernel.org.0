Return-Path: <linux-wireless+bounces-25769-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF86B0CCBB
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 23:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0E1A7B0500
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 21:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9CE242D60;
	Mon, 21 Jul 2025 21:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AKSw07Hq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC78A24169B
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 21:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753133823; cv=none; b=jb/kR5LfEE6LzaU0q1b3jJKBMLbiA3Ipvuva2jZMRtT3zFVhzQauJpwin0Cm8hVIYfsh5ZfbWnXyHasHI1J8UvgksFMlaLig9LQBMSR6itz9GxZ9G5To0gvOdi6xHR5PyY4VwZIVQ5VFsL/NLqgBPLytUNxSsmgJGi+lwYtlSHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753133823; c=relaxed/simple;
	bh=lYYKUhCs+uz4dDmKo3vq02h3Jse8lPTWG6JPP2itZp0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=n/rOJkPAKmf4a0Mv6W2MoM2izWcC592jL1a/p5hEJF5QKRRH6VfZ1h1Du9WAo3bXw2TwUZjUG6C7rsl0WUcRQOoZuP8lIUqqcNpQrUl8dSe6HoLSL6YqpZij41J6i+gkBplIplsEWLpr3hapXLGBrP1y4CjXCfV2ZojlWdkpBGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AKSw07Hq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LIgmM4004723
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 21:37:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Xz9e7mclBhH5orfH4FzOHx/oIgFQjvxzhGF7K+F4Uks=; b=AKSw07HqCfy4xvUY
	UzFFJrNjfYEG5Oll/OMW5uICGOTmAC5p/grrW6lOf5l8UgIL20ULK+jJFAmNz8yr
	522+IjvYlM5zli87Leg0JCX3jwtm8LPGiQ+5tfXrlpAHxVWqkyVgZ2ao7O5Jfnbc
	EwpJERbfiZsyMaC88UYHt+5XsXJ2fjUc39UcaPaVPcTC9lTuUEl29Wa19Tjjm5zq
	osL8bm2mwsDrUBu66yo54z8B4InSbhEgdzv7vRQEfeTx6RWn9LHeyNiFIgKb+Idk
	F04UCCuxLEiHI/gQQ3+VAtJa36JVU/zxmFm0TrzqHNrhgW3G76vSb3b6/aM4dtnQ
	mSs8og==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048v5k0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 21:37:00 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b3ba7659210so3430165a12.2
        for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 14:37:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753133820; x=1753738620;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xz9e7mclBhH5orfH4FzOHx/oIgFQjvxzhGF7K+F4Uks=;
        b=Jntx3DXBaVyOFDhv4JdF3vXE5KNOVSKCOptcrnJSobgDT9DZ4i1P/iNzIWJnv7t9AD
         co7ZksgDaR0YwG5uXO7melOSxVvjSZ8gLeultpt0mS38PUnShOPATf+Fz7aExDzK+Ef1
         A1AG7fXYr2fBOwRV58eCKj4MFKkg6hEfnTbDU4jti1OptpS4idrHnUang4HH4gUBx/DA
         sGBOe0YdirpKnP0/uyHtPs7wtv6b8JVp+XsPV0+PbzbYMfNV9pnoMis/528R6WuTnlS9
         qUN4O3NkuZ2nc9IBKSf8KiKeZkavVr/EugOiA0PdhR5Jadi7us0rjhUqVgbW7Yew4kmq
         zMEQ==
X-Gm-Message-State: AOJu0Yyd/2BUtftcwjo1Q/syKaXG1+iNfjYfRUHj2yU5bk1X8xyv84aC
	ULgJMRMEF1kS2DZdJOGPtUyr/J5Yaz4xDRq2swmjaS73EnE8FMnyCFHJAz3vmZJlyo3iH16wPip
	Wo9FHtJknTWQrKS4+oyi8mttF7l1yOGCmfd5a9AmPdgAqePTZaGdLH8jxHW7LIglZp+WB0Q==
X-Gm-Gg: ASbGncvAMDlAjVQaB3qHgzq8soXbk1AJF9GCq8HBNG247YmuNlHYnS3mBNVi/Cjj0n7
	s33chqZlboo4IpGx8VjnD/Vs6VLCths+8qeTmPGroLbpad9ZpGa2H1A31rdwUr6jQJgtAq3zGbh
	tBGndz674RY5JvvF2Vwufgk/aoxfjkjTvMrrkSliPaE4xrtgdWk/2XjoRtDPdgzSV4hVROIOgBz
	A5LPyDUAjU9HSNo9j6YUxURSMobfDsO0zgrAaiU6q6DdQvuUpoidwW2Egt1NlpE8DWSG8R5TG4j
	w4Oer9AiC2jl7MBzhcqyiCA1X63guuEEcSVxAhRJF+XVpfXD2Q72a/nTp+H+LuWFv3pxgiTseVJ
	y
X-Received: by 2002:a05:6a20:6a1c:b0:21d:1fbf:c71a with SMTP id adf61e73a8af0-23811d5b54emr38208372637.4.1753133819751;
        Mon, 21 Jul 2025 14:36:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7+hgdKgVE4EXjVGVzar57QfYjh4Oy05x6E9LQmjF74p8a+b+VC5yfpsbdqrk8pYEzeHsKQw==
X-Received: by 2002:a05:6a20:6a1c:b0:21d:1fbf:c71a with SMTP id adf61e73a8af0-23811d5b54emr38208344637.4.1753133819355;
        Mon, 21 Jul 2025 14:36:59 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cbc68046sm6201934b3a.151.2025.07.21.14.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 14:36:59 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250720-ath11k-zero-brace-v1-1-6132e2ef1748@oss.qualcomm.com>
References: <20250720-ath11k-zero-brace-v1-1-6132e2ef1748@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath11k: Prefer {} to {0} in
 initializers
Message-Id: <175313381869.971667.17737779436475573060.b4-ty@oss.qualcomm.com>
Date: Mon, 21 Jul 2025 14:36:58 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: FYiUKq4K7o9hsJpVJDuweXI23PCGG5u6
X-Authority-Analysis: v=2.4 cv=SYL3duRu c=1 sm=1 tr=0 ts=687eb2fc cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=tljXboN4zLINjdsvJowA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDE5MiBTYWx0ZWRfX3Qw3Mg6uN8UV
 V9/PcDegqKGp0x3sidChgEo9Q6R85Ts18pxQTEziepTYb6VnmYh/1Mtjm64OxCGqXhpHEOL2Mhh
 VCKhUG0DbN/rKSgubsHtFBT4eTWYbBnwD//pfeDLhn2AjFgEgMyVLpdGnS0vSS2yQq702aKwGR2
 Pmtw9dwZP5injuZngyBfbMFBJce9hsRwIPDM9Ml3JtTxj2NRa/2Sy4KFXTgIu3MSnOlTz4MHhvp
 tS2oC2+boZKGm8d3fKN6r5B23y5C8reLxC5j/le2o1JqCtbwmE2+3Eef3UfwB6gGSo1RC0FiExh
 orMnldw9dFOa4+mJxkjHFOrxthn6ymu7rIz12CB/LMoVI/N8L0mnLPOEs48sIffq7TACPhqq5Dr
 r1XHzQmrRtJf34a/TXRDLtqTpCJlPI63JRfp3BRLxNy5/0sK/Hyf8nreAg4lLKE+eCsS5k7S
X-Proofpoint-ORIG-GUID: FYiUKq4K7o9hsJpVJDuweXI23PCGG5u6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_05,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=621
 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507210192


On Sun, 20 Jul 2025 08:13:38 -0700, Jeff Johnson wrote:
> Prefer {} to {0} in initializers since {} works even when the first
> member is not a scalar.
> 
> Generated using:
> sed -i 's/{[[:space:]]*0[[:space:]]*}/{}/g' drivers/net/wireless/ath/ath11k/*
> 
> Compile tested only.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: Prefer {} to {0} in initializers
      commit: 1228d99fac4c103a1ca6af82ddd27ba2c445d0ca

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


