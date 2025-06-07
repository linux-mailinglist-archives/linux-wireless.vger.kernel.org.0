Return-Path: <linux-wireless+bounces-23818-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E552AAD0DFA
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Jun 2025 16:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AC61188FD1B
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Jun 2025 14:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A57D1C6FFA;
	Sat,  7 Jun 2025 14:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z4cPxXT6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CCA1B040B
	for <linux-wireless@vger.kernel.org>; Sat,  7 Jun 2025 14:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749307441; cv=none; b=IbPrrVqXz38zzbD4hzSGmG6OsWx4PrK2XYONXhmuBh+7n5PIs9oaInjJP8TPNFQt/MJprQ5TXJr5g/JfjoYt0nM1pEuqSZxlA26lvUlHlcu4xV4caIA7j8X0OiygNFxscgNRSl8DdyQCH4osmcRaOkVsmyELIqeK8cWs7XUsJqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749307441; c=relaxed/simple;
	bh=vV05sCeFpR0egI97lciX4iSzeYjP9TGXqiwcwA73mk4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XxJhP36EotIRx/Z2FvKb8Ll2p/QJxY2sPbYjZAOtmiOoxAXgWCd/fthJ5FjZcGGpvL5toyNG915ILC66iTDaeXVUIEqPTn0IUFdYf61qiec7saNAEZ3pAWXakuTqCjBaOFf3b7T1DhYBD4deVH0LKgGfWUSYOIligauxXmE6UPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z4cPxXT6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 557Afb3P021164
	for <linux-wireless@vger.kernel.org>; Sat, 7 Jun 2025 14:43:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pzcxmCnV5pYzfiX15guSgFMIxLrLb3NYj+Ra6xjgQnA=; b=Z4cPxXT6LBUkradC
	N9MnJk/8zLs8BDAqAUwa15Raw53GHEYgEBxhGfnZLYZdG4hrpKPO0bMALOQU9teC
	pfB221wfUtBfYsOHMxzF39Q2zlLaCZZkwYxBq9dfQ/qp/A8Tqk9l69Ebx8BPE/lP
	kFzHV0dLaX1gjRl3BK8/j0Cl7DelMUwiDDijvRCIL9q/YL7wMTv8sGwXw6DnOyCc
	6CpsHZ9J1mqDS/Xdt0ZBzELZBXVEvsc8nNtACH1y274ZXk6c+Yl9ZT3VigDeL5lE
	TQxWvFmQB4AcNyJB2mt8toylswPCx32x8zyIaGmBgDDVJO9LOPZocjz+FtfBlKLk
	uMUB1g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474d11rr7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 07 Jun 2025 14:43:58 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-23495f5924aso23661565ad.0
        for <linux-wireless@vger.kernel.org>; Sat, 07 Jun 2025 07:43:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749307437; x=1749912237;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pzcxmCnV5pYzfiX15guSgFMIxLrLb3NYj+Ra6xjgQnA=;
        b=t86ipVbvpslIQOTn/yqj3bUE2DK2Z2V3p+/sDALSWf2bW52uPA/j/jc73bgTN+afGq
         rgtFNHzOIqglaibfWcNcM/w3TBFyjttjwihJBh2Yv02vLOmv6LESEw+DfcJEGKHxqBaV
         Q667xopJ2CRLA+VGoyC1SYSl77pqmM0RkBYy416jdBVCU4se86qKk2MFbEEdoIMUJFSJ
         bc8Qdf8wXN1fHvWgrvlwVaWiOZ+YJw7ZmE0RJFpLurc6XnyPGqdWPJgQ9C4k7tAZaSB9
         0U3Wdeccvk5QdYb1YFhEdHFiuJbjSbQtkf+ACdbmUeloDmNQkotzejZEnn0USC9JdrGl
         +X8w==
X-Forwarded-Encrypted: i=1; AJvYcCVuP4SDS0zvl3h47TqChYJ9l+bAukZR/h3rMeB5Mc6MwtPGEITJDkCwKZk9Pr6AEDxS/YdfbuM52a6Oy83N5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOlVEa+4VA2zi+CkTrl3i+XMZnzU+tA/NA/7xbi5IyyfulPRPL
	c3FB0ILzLNiIWdFUpp5HonLu8ddGiEDXnJtsMrehSp+lt2wJwDJQQoLUVaJql/jf74wtteTCCUN
	9aplhd33RmIOVhqPYaVytzDLxHzOs1TycogJWUHYaUG6W9UiOxTSi5hgyie2RyO5RkAy1lA==
X-Gm-Gg: ASbGncvWAlRlutcS69o49o6NqCvoKEgIwEP/0OCL0YEWBwKxM4z074Vm69xcRJPxWJY
	OBV5Ksk/y/MpBxOGY9EifujzsdZe4XsdXwRsxTKSIcPnp9eEyGPK9sWpNXqYTg+fMEm7y+pWcvQ
	frxgoGU0fXBHS7ad0lY0Q563D4GBOX+aatxYbKAjb8e5dZUGIVvZhOqcbe7saywRodjdOg3I96R
	uQnyjyVv5F3pWDjfGDqEHxEpN6VqEho+nzUevjRdV9trGy4/VF/fdo5Cegs72Wj+rx4XXGkELgh
	Ly0DQLEsCwc+kc9DzJ9l3NZAtPCS6roBK2w3BbHB/bA+5s7X
X-Received: by 2002:a17:902:f688:b0:234:325:500b with SMTP id d9443c01a7336-236020e6e0fmr94478235ad.22.1749307437289;
        Sat, 07 Jun 2025 07:43:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtEwX+CYFF9tWBi8OSvwsaTfDq+qAz9M4ipDToqoJL56YkpTKX6fp9SV49PLNR9nRrd/51zQ==
X-Received: by 2002:a17:902:f688:b0:234:325:500b with SMTP id d9443c01a7336-236020e6e0fmr94477825ad.22.1749307436453;
        Sat, 07 Jun 2025 07:43:56 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236030969ebsm27626415ad.72.2025.06.07.07.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jun 2025 07:43:55 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@kernel.org>,
        Rakesh Pillai <quic_pillair@quicinc.com>,
        Surabhi Vishnoi <quic_svishnoi@quicinc.com>,
        Caleb Connolly <caleb.connolly@linaro.org>
Cc: phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
In-Reply-To: <20250318205043.1043148-1-caleb.connolly@linaro.org>
References: <20250318205043.1043148-1-caleb.connolly@linaro.org>
Subject: Re: [PATCH] ath10k: snoc: fix unbalanced IRQ enable in crash
 recovery
Message-Id: <174930743530.154748.10228995269580503920.b4-ty@oss.qualcomm.com>
Date: Sat, 07 Jun 2025 07:43:55 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: 0BwpuEh0ZnvmsrCkwDyU1MeyFKJ6pA-e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA3MDEwNiBTYWx0ZWRfXx4Pp5c4OlkgJ
 8RF3nwoV1XyvwtZukl+G23Inmyo737iz6FYdz1Q6l62Aq6gVaGrVJ8JVduCjeTKU4qK2Nlmhxqf
 m/+rT4xQvQHj/kimg1PrJr+b1AJnnd2AkI9y/5eSBDR9awTr1/9A47HtRqwwYAfzCKA0Qn0RrAN
 GflKeZHR9I54QGXKvFfYZrztQwyWhPsRKKnHGvI67WBbcY6EX1n7BosS+2SyxXXdZqy7pp3jQdL
 DnAHIR4dHsyTTykt0yhFNzpjd//2R2E9KEdP3TjBG6WtKIn63odYNMrnBQJ6XmkAs+roihxR9qg
 YIPwBMmQA64sxbHzUgYJEXb+YKCtyc/yXC9NQsYpaygBe3eC44uBzH3SQWXyVU5xzPgpbah8alI
 +me+jpgLbhHogi+nCUw93yZ8NCeiccoVfKeoS3rx9LUEYO9tasZ/QbZXuktLlK4kMcDH2neN
X-Authority-Analysis: v=2.4 cv=GYkXnRXL c=1 sm=1 tr=0 ts=6844502e cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=NluFblzGRrdN37FGmV8A:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: 0BwpuEh0ZnvmsrCkwDyU1MeyFKJ6pA-e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-07_06,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=492 bulkscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 mlxscore=0
 adultscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506070106


On Tue, 18 Mar 2025 20:50:27 +0000, Caleb Connolly wrote:
> In ath10k_snoc_hif_stop() we skip disabling the IRQs in the crash
> recovery flow, but we still unconditionally call enable again in
> ath10k_snoc_hif_start().
> 
> We can't check the ATH10K_FLAG_CRASH_FLUSH bit since it is cleared
> before hif_start() is called, so instead check the
> ATH10K_SNOC_FLAG_RECOVERY flag and skip enabling the IRQs during crash
> recovery.
> 
> [...]

Applied, thanks!

[1/1] ath10k: snoc: fix unbalanced IRQ enable in crash recovery
      commit: 1650d32b92b01db03a1a95d69ee74fcbc34d4b00

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


