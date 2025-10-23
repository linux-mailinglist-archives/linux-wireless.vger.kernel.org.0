Return-Path: <linux-wireless+bounces-28203-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15040C02BF7
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Oct 2025 19:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 028C31A688AC
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Oct 2025 17:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B3534B1A1;
	Thu, 23 Oct 2025 17:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F1MerIhR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9985334B182
	for <linux-wireless@vger.kernel.org>; Thu, 23 Oct 2025 17:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761240904; cv=none; b=DigKjErArL/LamDtTjNwnXHZQ1uKYHAxidpOlLmgDjJrM5V4px6XTTN5HGiWXRNaEWP233Ti8JCt0+iUMCMEKEZKcxZerM+y7rOJOipOzKDRb6SnBkglJAlF3L9BOGcr4U+aiUnvYmb2gSruoD0NsNpNtIn6IGrrWYNEN2QumTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761240904; c=relaxed/simple;
	bh=ShcS3JhxHmVF1aAh3VkCJGIlsU2iKRTmbYx6fHe3PJs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Uv8wOGNb1DlAeblaQCMQtb3YcByACaWb6vrTvLMAZ8k4CHc0hvSg0mugFu8xolNcbhXepxCJzMXJgB2Zfi+kzbr/PJRhdlUsw4gmPhrIVFjTL49xFX2HNxfbnNBoTl2uqgoucVqtf3ko/88Q3xzlSFcBaZEoq5vIh5YtheSqXdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F1MerIhR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NE8wL5011684
	for <linux-wireless@vger.kernel.org>; Thu, 23 Oct 2025 17:34:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GRq1ugaT90FNBOZl/OCD7yyFwBcTZ9ecupEzJ/5yXAA=; b=F1MerIhRYX/nFUpP
	bhHAettHN6rjCJZejqzrgRdMSpzWKNJv7tiGIep2Oi11MiDOuD580WapfD/Qjxfa
	7rbcRz0eUHXBFYy2bc2ADFp1jh7XKQYkRPtyPsJzDnvdM75DPi37Bq4/sokQE4WA
	tPF+z6J6fHaGz53YwK0HEt+/Ctu1lilw4HMm7rE33CjkTn4VqYJ4XQqZNcaTRxcq
	Z54D8XUQv3amWhOvlcvwbPgtC9RfpiR6gQc3CRWMreLCmjBZpeLYeM+oxs/KbkgU
	VuP5uX++EA4S7CXXN2dRnAzGY2PoCJSEP0JMXelFuF5LNNFyLL7Q6uwCVKXhk7fp
	mucTYQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y524bj5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 23 Oct 2025 17:34:56 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-290bd7c835dso10859075ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 23 Oct 2025 10:34:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761240896; x=1761845696;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRq1ugaT90FNBOZl/OCD7yyFwBcTZ9ecupEzJ/5yXAA=;
        b=ktY+2A9x3V/hNcvIqyhoTKlOoxKwm+ikKzN4s03TPlhA1K/xqXtRbFXaxWMsHZj3G0
         IoObMTWHj1otHspjqRRA3XWYNae1TU9pWYFxcgchfw+09J5fWU/RkA6MIuCbZos8SvQf
         niZMY+Rg6ZrlplqC4/CIQ+liVuK6FCk+U/Ah8aLJkB89/7hxQoxExSghnH5QUESUmzBM
         ST5UzDQyqsd1cL83kmeKhPGcNocdbO+7LcE3ePw0CH7u7i07Dk7UkoYrrasgINtF8nb4
         WL0V48fe4vSYQITsteGtGsCqcmpx8Dp9PuL4iX2iDKiXG3bHXKgQ4pYEdfZvtL/4jlAT
         N2lg==
X-Gm-Message-State: AOJu0YyydBetstORxvCSTNowQwANesbCZsYCcLASBBriatw15SfJS40K
	4zn16INaM5RuFNXs8Uc7jZUQ28dzGjJv2KjYMlMhqJx+QETF+d9LqQ1xBWjtI8qJzbLEN9EpPeW
	F3ceXpVZFeewgv8dA5oEFI+DytYUpubHJ8uvEjf+6zKblueJxjocJ4V3OZNozMozgVLlJ3g==
X-Gm-Gg: ASbGncvKl7cSzvo+eMgk1NVV3a6DM8JoruTXGcoom3IkI8VHrF54OseVX2qJfk11KVj
	vQ3a/mN/sAwVWIy/54seEGR236jxNjC9AB4uhJxSkjSpiswDaIPsRbsmczZJUUTHEl/wB4gk2I1
	pSJ60dXE6xpzf6oB52a6TgOSAsS3v9vo48wLo7IXNW3AdDUwWIE3uOSqgwrbOCGG1WkU/Qr1et2
	oSfpsuyQB3+ZA/Z3mkuqf4aIUyL/FW0k6rSA05oLezYPQiVJEYHjOGXaB2/pEv3qwuNB4wRfM9+
	wvCkA+Jl0Mfo6XhAYsEhGbqc2EQfZgwMvTto1ZMnzmsf8Vcxl0+5nOp6CYL+ED9XZTKedzpyyLm
	6UVqDymDs2wiY42UmB1koffAQEWosw1HrBVQ=
X-Received: by 2002:a17:902:f605:b0:24c:b39f:baaa with SMTP id d9443c01a7336-290cb183b74mr328998405ad.49.1761240895688;
        Thu, 23 Oct 2025 10:34:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGe1gNXGtcwmAY4vl7c21IrIBT/QHrguMJXJlGUhi5RMDu1zGJDn3KX9oBfiWJOjRr5Q+ZP2Q==
X-Received: by 2002:a17:902:f605:b0:24c:b39f:baaa with SMTP id d9443c01a7336-290cb183b74mr328998165ad.49.1761240895162;
        Thu, 23 Oct 2025 10:34:55 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4e158fdsm2631407a12.19.2025.10.23.10.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 10:34:54 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20251022-ath11k-bad-macro-arg-v1-1-93a8eadb6191@oss.qualcomm.com>
References: <20251022-ath11k-bad-macro-arg-v1-1-93a8eadb6191@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath11k: Correctly use "ab" macro
 parameter
Message-Id: <176124089446.3626081.12835571659447806961.b4-ty@oss.qualcomm.com>
Date: Thu, 23 Oct 2025 10:34:54 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE1NSBTYWx0ZWRfXxqWV+4ktjbeF
 wwAA8t3hTCeFSs/+jV6Labw/bDWIRBlrFgyyZl9Xhnd7wcg0gAr8aJ+utueDzIUOPrSZj8RaZbs
 wCsYYBs8Ttq404MOtHMKGnwtohRDbpngEkLxuvoxsQUl6vSoeXANO3mtTGQQEWTF13hsCIQJmKM
 00+qk5DXOeWe5KWZiqqEmtdnckWnNF0VjLWCwDnpt9fT7eo8/mTbHPJDPSKltqfa6FWXcb2sqH0
 rDuETJwDQW5zTG7p08pZqN7oRjboS0y66YV6VzcRJXmCx84oSMY7Z1ZDx8hQGYtNSSwWWbpCgFK
 LQ+BKn3SwFVXHFP8dgOw1tEwR61mpkKuxKuDqUGDou3VQILDFt1gtQMV4NwhdFsV5vx7//eghCF
 gtMwlD+WMnh0mQ7tpT7vHOYEamt0tA==
X-Authority-Analysis: v=2.4 cv=Uotu9uwB c=1 sm=1 tr=0 ts=68fa6740 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=6fyoW-0bdveP3ZPMVTgA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: wIBv4TGWUNrXcvr8pVgq6d6ulW0eZZVI
X-Proofpoint-ORIG-GUID: wIBv4TGWUNrXcvr8pVgq6d6ulW0eZZVI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220155


On Wed, 22 Oct 2025 08:24:46 -0700, Jeff Johnson wrote:
> The checkpatch script is reporting multiple instances of:
> 	Argument 'x' is not used in function-like macro
> 
> Fix these by renaming the argument to match the usage. In the process,
> also add parenthesis to the usage to avoid MACRO_ARG_PRECEDENCE
> issues.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: Correctly use "ab" macro parameter
      commit: 50cb7ccab8176cbce4e32420f9fc2d6d80e69a09

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


