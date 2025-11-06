Return-Path: <linux-wireless+bounces-28667-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A0BC3C17E
	for <lists+linux-wireless@lfdr.de>; Thu, 06 Nov 2025 16:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79A061B231AF
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Nov 2025 15:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E274F28850C;
	Thu,  6 Nov 2025 15:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fXqMdtr5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GDxb04xt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B81287518
	for <linux-wireless@vger.kernel.org>; Thu,  6 Nov 2025 15:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762443152; cv=none; b=pZYi25cqPz1PQKGZxz6QQJRrARYqbDKHliitVvhqZVneSDHURPhCDMCmxiIAdjNxjHSaENeCIdyCuXJ6uiuX90mbU8fPOZ7kUL8KLb6OW+RpMRupc3UXfVAbaZKQdzsuv4Si7xOYqrY2xrYr2vvWY/INCXQeNb7LzgDG+9TMVsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762443152; c=relaxed/simple;
	bh=tJuRLTBbnt8QzEMUAPDjN+o/zv//m/QOINWwPZqyotA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=L/VVaqdCRBmgVAdqEAt11qvIOSqoId0hlL0qeNeYdYJjovjucGLCRz1h+XCEaAAhhAK0HBblwb9k7nU/w4WXrMI1lc04cBE5ezlYzYRh395KLdN4atXty+fOE+RltQ9YmcTCfpg/pxfqvYPAmN8krb3HuBlBiNJVPGsS8iC1U3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fXqMdtr5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GDxb04xt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A6ASshf3749048
	for <linux-wireless@vger.kernel.org>; Thu, 6 Nov 2025 15:32:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qoESMWn7PrULWRu14sjXfmZhKckiVnKGNTN25vzvmQs=; b=fXqMdtr53wOVF3dL
	WK60UNxOi3glB5OA0HxFmC5kgweW+LcmTakEHK8oEzrcjQgFIX0/53KDV2lurSJJ
	OEkd+HzXx0XM9s3P7GJiEcNk2bwLhhpK9FTPf+KPtMR4FWHdiFfhuQwww2cInk/R
	Ou9UrdWUh5fJHHBwrNG/lqwFEyDEz8wUm0iDJ6VOdPMdDliQ3RwenZJiMcZTzGB+
	APmDO1U/GGYYbRLq3yCc/eIpwwj34E57tWmH7GEE5AwQK8143Jrjlu7N9nKyxloc
	1Y1aKRHGSDhhDxCMad7LYZGIoSSPfqR1HLQweIUVn4CJIj3kCN8Eut/fG4r8d2Jt
	mZ7k9Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8sy6guf1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 06 Nov 2025 15:32:30 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-340bb1bf12aso810861a91.1
        for <linux-wireless@vger.kernel.org>; Thu, 06 Nov 2025 07:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762443149; x=1763047949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qoESMWn7PrULWRu14sjXfmZhKckiVnKGNTN25vzvmQs=;
        b=GDxb04xt/T403QF7InddnDWZL7FbcD+X76s0BNAzUHoyvXgkaqZ1OLbTngWyiZK+ok
         GxzXUpRxgdDgvAskxzbBTFjVXv3eNtfiBWTsjn0cYiXuVaz/08MLNZGlDI4KEjHhdNXU
         wTe4d6O7bAgrd4bbtMitKkDwnJ3bgP3kkvSv+DSgHlHbhe4PDx7qtChklKTThsoufY5V
         q0Sd+jsvbj6djR4xCqu4HEotXymeDz6Hnm4eRdLvu9ZnVwZDOuDL1SyntIvzCKEK9G5e
         hzUZbnouO/pitZVGRw/6b0ORiHyzC4qypU0Vrb0eDmYQVbX011eVNEJUvjcU89lBGXn5
         4RIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762443149; x=1763047949;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qoESMWn7PrULWRu14sjXfmZhKckiVnKGNTN25vzvmQs=;
        b=Zjwsqvch6z0dHjjFI/D9vfEYA87PH3I/J41PnMkCiNWXgd2HZ4CkthOoqWXvwCuzOc
         BpyhGs2txL5YfSU2pmYrrAkRArv0rnZ2Pk/x5uMHUWioEcHDVRHSVYYkrOiUPoUvCnkh
         NzjylAr1VnbAPKWSMrnnzsPf0wyEjQnlzA+ER9uvC5DjYoyJLGjTagsDh0F2KFUBvVLl
         QkZKyn8oUartrWVgmBg7FQ4zoq1WTjAGVWLKDD72nYYEohFsfBXd7bmIQc3c26GbZJ9i
         FddxYqQ7Y0pOk4GldxNyQHeNCntrugn6cRZmFFXUpBAVgXcIHSb7uyPWxm2Lgpc79u6U
         g47Q==
X-Gm-Message-State: AOJu0YxQgLBnEpvkQ2te7XeoQ1WqX7jQDaibwPa9ds7PbHzS5V7ppp/t
	UuKjprXjIp0eASbus8lrBEdSkGz2+OIe9ODvuwDVRPRyL+ESnwdVvf//wMP96JCZ9HfkGGLLmT6
	dAnacnyDKTtZJTFMDpsmUv0juvRAl6ZOe7l1PBIkbryD4Qcu7I0g+cZpkIKBuDAe60T9UBhOzw0
	XMcg==
X-Gm-Gg: ASbGncvWVG24D9LsH0r9BEmKmHmrlN3vBhYykv93HbdebCYEepvodGzHAVjjqNo3q0P
	vRsEIYQHdlXv9ULyhr3lOiQTKQPwNZoGhZJ+7tMN6666QlYvIeRZG67QI1Pjo5i5KbVOSJWNW5/
	NKDqI+RXxLL6fPLIz0Ff7wF+yS9EbvpZaq/C0erb35vEjRLVKCpB4aPXAIZAOO605k69bGDszs5
	14aR3yL6Q0u0sK0GkE788T/Oot+ngxEOXEd0XetQRQ6sUu4tdBW/6I+G4qd9J3y7IdOA3FkCYC8
	dXuNNCrhd9yVi5V9EeoLhi+fAkAKoMEOItI17QVwlwaPEWuVsGDDxk98TPJM10HzlvTEE6q7RZ9
	TUO4L8nNWgYGNAzshtZmxbU6+cigVo5WRmpI=
X-Received: by 2002:a17:90b:198c:b0:341:8c15:959e with SMTP id 98e67ed59e1d1-341a6dd6981mr7910663a91.17.1762443148937;
        Thu, 06 Nov 2025 07:32:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXcCOwxhywFFmIqy4/If8FuyWQ+DC4C3swH4/tyjEm7gs+eBSnZVs5l2xisqNftHNSyFuzuQ==
X-Received: by 2002:a17:90b:198c:b0:341:8c15:959e with SMTP id 98e67ed59e1d1-341a6dd6981mr7910641a91.17.1762443148373;
        Thu, 06 Nov 2025 07:32:28 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a696f15asm6619916a91.12.2025.11.06.07.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 07:32:28 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath11k@lists.infradead.org, Nicolas Escande <nico.escande@gmail.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20251104083957.717825-1-nico.escande@gmail.com>
References: <20251104083957.717825-1-nico.escande@gmail.com>
Subject: Re: [PATCH ath-next] wifi: ath11k: zero init info->status in
 wmi_process_mgmt_tx_comp()
Message-Id: <176244314778.1820261.5998504841196098963.b4-ty@oss.qualcomm.com>
Date: Thu, 06 Nov 2025 07:32:27 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=AYu83nXG c=1 sm=1 tr=0 ts=690cbf8e cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=HIa3pkW2VRZaOz2dKSoA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDEyMyBTYWx0ZWRfX63NJG6PaCLQF
 UWQdULmGpiR+o1Dq4PxAOLN1862TMuhUe+wkzQtH/iMWAjzXIT6R2NgFt+5E6fjcAACe018pcz9
 tQB4bmNi/eYxFL87BU+3nH09MFZYzP9FN1gRsAVwZhOxGBgU5HxIepsBk+CjhOAwt5jQYB/4Vhx
 JNG2d5s93ZDM70jTEOKqI3ZfAe8nJBi3aQuCcTq7nHPocBUPGts0pU08YUqVKy6ZWcN93TFuNkc
 Uh19+HuLHj/wb1D36a0S7iUWg/s+QAFPCLApnJy8BGyZ7KeeRv8JyFyoPZf6Jl3qSBt+rgErM2Z
 U8KrD7Nd5Rjo4NMyvK9i6lsOgVZvFUV+ATVhX63g8U5Vo7XiRhfPQLUh3xg6h5Z9v+JPmAGByNo
 kJXeAWxQTOT3PhvVzUcWD7ja93y45g==
X-Proofpoint-ORIG-GUID: X4trPzDxnfnQuzx_zFNqoB8gemrPsE-m
X-Proofpoint-GUID: X4trPzDxnfnQuzx_zFNqoB8gemrPsE-m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060123


On Tue, 04 Nov 2025 09:39:57 +0100, Nicolas Escande wrote:
> When reporting tx completion using ieee80211_tx_status_xxx() familly of
> functions, the status part of the struct ieee80211_tx_info nested in the
> skb is used to report things like transmit rates & retry count to mac80211
> 
> On the TX data path, this is correctly memset to 0 before calling
> ieee80211_tx_status_ext(), but on the tx mgmt path this was not done.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: zero init info->status in wmi_process_mgmt_tx_comp()
      commit: 9065b968752334f972e0d48e50c4463a172fc2a7

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


