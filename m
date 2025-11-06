Return-Path: <linux-wireless+bounces-28668-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCCAC3C184
	for <lists+linux-wireless@lfdr.de>; Thu, 06 Nov 2025 16:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BD7518893CF
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Nov 2025 15:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8045A28C00C;
	Thu,  6 Nov 2025 15:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fTjW0Gyu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ko9CAoQq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208B128A3F2
	for <linux-wireless@vger.kernel.org>; Thu,  6 Nov 2025 15:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762443257; cv=none; b=JJTBuXp1k6IyNRrAnJq22xAexHi0ULhNBuWt4TQf8eLTs6be8Tpq/zuIkOYZhF7fqwbh3KH1P6fP9HumhD+6iLTqW+qHXl18yGcVuZGQX7Y87J9PkenbrmUyQtk4z6Wr6TqTVtcqc8mJLDw5nyXnsBCGW7oZtxuXT5mJrYHdGIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762443257; c=relaxed/simple;
	bh=RCRydMsjtz7PKoWEJvV8ZBHEvVMhBauTyRcLqeEBWOQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ETRrgXGrAn8ks4qY4sLFYNqlZdLsQjTDol/6ZWWroKpli5/cVtN14kGh+uhLXW0KkMWyds5TgsE/eU0I4OQBlU53/Y+6Cf9H/v44VzqBZs+rTw0TujiW1rm6mNXCDn2WlLhw2tp5aSOy1MKIQtGEduFKB67cXRtU6bQ+7by0FLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fTjW0Gyu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ko9CAoQq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A6F5mcq3361973
	for <linux-wireless@vger.kernel.org>; Thu, 6 Nov 2025 15:34:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yqxjaHTpe4VK+QTHaTKoDB5Cp5IvAuOvPPRr4D6XufA=; b=fTjW0GyufQjJtTWE
	4Ur1e2Nc5g0InqaOLSRU0pO+VAxkun+S57avNjm70n7REUUbdUf6qAo0uxbIYP7r
	FwYvl7NZdbcu2UqfD1z0MW5hVpPmtBjiHDMPGT+uyb/bQPaVG+YMDqtJoJpClfPp
	RUEJ6Qz3nmyb5ByVQJigqmOHgxhU0e79eYzKuygwb6Y8HKO3AwNJgEFUMfffhaY6
	n6Lj+5Z27uvfwTrJcmD4MQjQ9B2akJ5EEfQRqDR0LR+fBhh0iy58oDmOaPt/gz+t
	ELfW8JBwJcMIlIPw2o6D8h9j6N9AdXxi3r/JJObfMj4dgfcdgYibwsdtRbVTRxt2
	CsWF1Q==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8pt59fb3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 06 Nov 2025 15:34:15 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7aa440465a1so962676b3a.1
        for <linux-wireless@vger.kernel.org>; Thu, 06 Nov 2025 07:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762443254; x=1763048054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqxjaHTpe4VK+QTHaTKoDB5Cp5IvAuOvPPRr4D6XufA=;
        b=Ko9CAoQqKX1wvLTbV3lVEYE/coIb+kZMIchv5BtPEog8VOiPK3Getya5os3532uzKb
         F4HRBg5b0M29LvvVwC8UDdjK5A0yKiNjYBiih1rXXIVSkMh9oev7l4wpSZW+vODnAgmJ
         hMhaK7awx+376jDR4DiAO/k9vLD4a5R0EYMO2ZiL2GaWpW+4BrpnQYvOretf1bP0Kn03
         7R8bAoVygp040g1LNSMRMjtHni9UxgWS5E2g2ej8LeuH20xtbPWZmnhDc4TJ+/Ly7TaS
         IeaNekCzG8K3yFbbkdjvUbR6mYM5WJtHf+DRkj41x/E9jpLgkdC8hl4gfyh1S9/8vGZy
         Rw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762443254; x=1763048054;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yqxjaHTpe4VK+QTHaTKoDB5Cp5IvAuOvPPRr4D6XufA=;
        b=k+Bs/s9nLzPITE6s0G5K8biV6yjZxpd2g1ZYeylVD4LnND40GLkIR4MYrTq+WuBbaf
         vaaB4EiPmaYKMnV+t3K1wyVG9qMYY84e9/z65VDfPx0b+gjVPBWUHgbzth+JQj5PouBo
         RieNwQqLtGqIoqRIRNS2U6nTiIpQef5wNyxUSq9uldeRpLaVFYN1N+4Ug0ipOJ+U4PDG
         p9mbvNz8mmImmWJf27WNS2XdmQjYX+DRvQzt59sVXQT9ITvLqh2I5ho0zy1naV5JBPhT
         ls7Cbb6lrYB9FHuu1Wc8vtYeihRoQLIVxt4G3XFUtMAlfHB6EyFfH561+ruCVGeKZIX0
         H7Sw==
X-Gm-Message-State: AOJu0Yz/USRXJVt8GzbqDELIVYirF393+kyMVK73zHc7bc1fcMSt3YiA
	gbMeGscuCb6+ghoU2LtRQTlXnwHskV+vAE6W2NAHFuUTC6KuZ5HFsSgM/MU4n69vTRB9WbUn+vY
	JSyAzNUP7tbBUukrqL+RPSoq03V1k6oO0P0nQc+q4Rzo1dwuldiLziywxD60xEPbDmq8btnVlBw
	WFpA==
X-Gm-Gg: ASbGnctGFEXU41HM4YbBMlFGhG4TrXL6+LteExlBJ5FaJBC055Zb/0S1rES4wQmEc6j
	Fn7hyrf5O7EZCgzIPqJ1MJc/CFIqDHsLaZTTriLErgXmSG7mGPaneBBPyfpHKKE1hs0k+goOAf6
	x47aU+eX1N0Bfiw9Pkcw6zOnGHzdLkPQklYXqYeDbeQhuKFTMAZdDc7rZ2YKyJqSNs7P+wtPu4v
	X95JL83oXvIqjEgmVM3DwhOAiMTWZF+jKnfZyMz2gjm69laI4+xa4w+8dMLRgQgnbnvnSXViBjT
	jC9aqd1TWZCphgRTQmRdf3vmkiIs87FCAJUMfJUd3VY3xmw1X3B96F8PpdzaRL3iaCWGjy8TzGK
	BWeqAqj5TahltYvRrU0PlN1NgU+Ptq6OS670=
X-Received: by 2002:a05:6a20:549d:b0:341:8e52:4be with SMTP id adf61e73a8af0-35227d6e1d5mr7707637.6.1762443254314;
        Thu, 06 Nov 2025 07:34:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCj36n+Q5SurmQpG593kSmZIdLE+nEKuCfluWpwGoAjzJO18NF4Rn0ZSbl4e9YApuVZ50s5Q==
X-Received: by 2002:a05:6a20:549d:b0:341:8e52:4be with SMTP id adf61e73a8af0-35227d6e1d5mr7664637.6.1762443253867;
        Thu, 06 Nov 2025 07:34:13 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d0593cb1sm2945865a91.15.2025.11.06.07.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 07:34:13 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20251031-beacon_stats-v1-0-f52fce7b03ac@qti.qualcomm.com>
References: <20251031-beacon_stats-v1-0-f52fce7b03ac@qti.qualcomm.com>
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: Address issues during
 beacon stats retrieval
Message-Id: <176244325323.1820628.921013394397437129.b4-ty@oss.qualcomm.com>
Date: Thu, 06 Nov 2025 07:34:13 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: uYAobaehXUG3Vv4Zii8Ku1soOn9yOO07
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDEyMyBTYWx0ZWRfX8jnH7tsRGo2P
 9qJUun6i2+akIySHN/Saqp21VG05YmdzcXBvqL2mgrKyys10UYJuO3AyvPhmW0M0jl6eDPV2VA5
 EaJ6TxXfUV4djA8COQkFfdiC7x2I+VXhsmLNndSpuN5l8gBTAQlojUpTRlXwYYqPCZqbu+dEGJk
 jPN6k4vkh7S3RgaqcbC8s44C10nK6vOQ980jyEN2b/4k7RgfVsAH05wAU9y/l3fU7pZixBRSDId
 +X09QzsMiqqd+H5w9bDBSOYYV2o9f1/lOKkmzHsi/aiSZS5dPRCSKD1ql4+TxnT6aXmpmlZPr2E
 vOxe4cp2p+5HPUvTdPB8bJZhmr5o7FWcxAGs4qIXPTHy2SP05LOIxxnCtSqzZ52JapaBrfdjYJL
 sJ6VrmRx85uPdxw816zNHR9br5zyvw==
X-Authority-Analysis: v=2.4 cv=XNI9iAhE c=1 sm=1 tr=0 ts=690cbff7 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=IN4UVXusT1ehFvA6WGYA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: uYAobaehXUG3Vv4Zii8Ku1soOn9yOO07
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060123


On Fri, 31 Oct 2025 08:37:44 +0530, Manish Dharanenthiran wrote:
> Currently, retrieving beacon stats is getting failed with timed out error
> when multiple BSSes are enabled. This patch series tries to address the
> mentioned issue by the following,
> 
> #1: Reset the firmware stats only after retrieving the complete stats
>  #2: Remove the wait timeout to get stats for all enabled BSSes during
>  beacon stats retrieval.
> 
> [...]

Applied, thanks!

[1/2] wifi: ath12k: Make firmware stats reset caller-driven
      commit: bd6ec8111e6546d01f16bb113aee1fcada6e86a9
[2/2] wifi: ath12k: Fix timeout error during beacon stats retrieval
      commit: 2977567b244f056d86658160659f06cd6c78ba3d

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


