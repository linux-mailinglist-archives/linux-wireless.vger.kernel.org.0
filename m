Return-Path: <linux-wireless+bounces-28224-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60642C06C35
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 16:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE11D3AAC25
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 14:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D263239E7D;
	Fri, 24 Oct 2025 14:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hbn1D23M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C572233735
	for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 14:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761317231; cv=none; b=OYOpr43CO99rYRovd4ohdQqcwSXMJklyrQCpCLfYQKHHtFR8gM7AXMjstxXCGXHrotm5ZhrRy2mSTEdyRJsLn0Qezc0rTU8gkp4q9OFI+F/hAkchfKE+KtRolHGv2DJ/n+ffl+a66rAlUuEm46SKARpg9USv7AC/rFEveXNG/ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761317231; c=relaxed/simple;
	bh=Q3kJbMPvdApavpbhswcj1tidNTFQSr2bOCizTpLO8ag=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=G9GqXfSkf31eO95QJy9YRDosNDsUoNP/RWvhu9mRUIImrRf+50qJJ/7IcNx0fTF0vcB+oDSkXuoA27AU9oswOSXAqhb6Qjn+8Ht15kkb1//gLR3C/8CK8Ga0DzZ+OoMu6+boMMo1qL1a3XZGf+v8l4f4//v0Yq52detEz/KPyUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hbn1D23M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OBifux014912
	for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 14:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uBILhy27+2RI7SokS5+wrcGFJ/H7/tAsJKe5n8CCO5k=; b=hbn1D23M8vETQ/El
	9KPfOmwMO+OwWKqg6OSH0XGJ7aULkqoZsyJyhwb+FUL7ZqlSSG3/wqh+fQ84LRLS
	O4zLAYwz4bYNF0elGJIIFtM/rdN9yUKWfr2IjsxFlcfUbQZTiCXJhu/gq1UFc53j
	oiallWzkgmQPtGa+5DNRyYNg5JUS4nh9iQySCbB5C6oiKheOpxFD69ZD7Qb+mxb3
	qn6kkpP8q5zhNQMMMYvBN1bW8d/w0XJuR6uNMJ8db32oTFO00vNsJNrGO1Pm+rEH
	yqYfXb3ZEWD7Q+8OPKgl1mnITD5jTte5/LSVbespyy0v2kDrYOsGEUZ5/PjJABMP
	RVkTKA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v08pvjj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 14:47:08 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2909e6471a9so15752835ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 07:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761317225; x=1761922025;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBILhy27+2RI7SokS5+wrcGFJ/H7/tAsJKe5n8CCO5k=;
        b=X1EEUwISvk7Z7LSAGnk+4Jg8e0v1ZSeTJoZ3w119N3R8kcpndWGyOySpXVJ36ZpArw
         ezyqwRRKCiAPqvwjq1iJylZuLtc3JNfv+d/x1vpstlPfswmT1W5IGnJ+XAy6whDsAVCH
         Yf/kOVFsB0J/CrmIuK2PDW7jQRB5nIdrHlWEtr1dV8q55bbw6zWja2Yys5pJZJj3Tj9s
         XQVbNwBRhs8n2H4hqkZH0sw9WPBcO/ebg/XPs3x7AxrgFn2O1NiYZnb+BzcaDtDdpQS/
         F4VXdEA9WFAAdDzOdU2U05ZTP6pAJlUcoBH/pwVCVOYWpMp4+bBpUm5/JbcVayZydQy9
         XZHg==
X-Gm-Message-State: AOJu0YyhUbva9zIv6xNuooBDGDERfC6hM+s0fi+NyvKxisaDc0cPA3gu
	PEATnlJAjDXQcqz8jb/g5azEgbilkQPp6siSRzfYPssnZ3r9OF5uDn5KCp4/BUAd+f00yfIjoBw
	kMJ5XjK+LeDQs7GSQ7C0xJ6448np6TCIkX1S/nlOg0F+TtvCPTTrehg7lq2BrJRpa6j8RA96TM1
	1aDA==
X-Gm-Gg: ASbGncsR+O8Sd4NHo7PlMkzU3TBHkKz1Egiao3wkCJUkZzx9hIGo1W1OH8PvQyzZsEl
	dqGYM9rDbjiuwgqwBvj3N36FuLgKimXdHivFRhF5vE1sA106gDCl5eitT8zkpOKmsAfrYu2NpRG
	SlAGd1hepxz30kFyq54vfOBSShx/q/FrDQ+xJdvEBKkaFyH61HgvEiOOyid6Tc2ndU3c06GqmiO
	FQAaNsOisSPFaZTM6egDdiY4OK9ck1Ee7GeNLbdYkDmMGZJMSZexRBDw4iVVYAnjeudgNsN5iNc
	TjV7J0PBxYz/p3+bIL1tI01Q7GD4Tvfq1dLbZce5HJs9lQZL/3VDE1Lx8XmK/TwlZPCmvVfTano
	cm14lc0/Y8nfDrxL4nMFzDSHdcz9IkDtyYyY=
X-Received: by 2002:a17:903:2947:b0:290:bd91:d81a with SMTP id d9443c01a7336-290ca1219femr287036505ad.39.1761317225035;
        Fri, 24 Oct 2025 07:47:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBgoxcbYSJM9TtndNQqy834Q05vrMbFb7CpwJlWsSb6yr/CF/SsVzCinG+iYcgSfkEfvyXyg==
X-Received: by 2002:a17:903:2947:b0:290:bd91:d81a with SMTP id d9443c01a7336-290ca1219femr287036315ad.39.1761317224551;
        Fri, 24 Oct 2025 07:47:04 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dda5771sm58169035ad.18.2025.10.24.07.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 07:47:04 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Sarika Sharma <sarika.sharma@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20251021112204.323242-1-sarika.sharma@oss.qualcomm.com>
References: <20251021112204.323242-1-sarika.sharma@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Assert base_lock is held before
 allocating REO update element
Message-Id: <176131722384.1606896.6032640514752173500.b4-ty@oss.qualcomm.com>
Date: Fri, 24 Oct 2025 07:47:03 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMCBTYWx0ZWRfX+aGehSeAHH8l
 pxQHAiGBQx7zXe6vOu9DcrXdB15qpAB9OELJSN73q8CqvUOE8xCqHhccYeClwaUihkExgYoh59Y
 KAGBzqwQK7pn0tgUk6DYvUL9utNMfPZby+7nZH0SnGLOO99H069R2ElXNfGUezOlpF2PUrVxtID
 YtbVf/hGJesaUT1wRkjsV20o+jUlmWG035yq/RZL0RpEjKG4FvZBDRVcEl02g55X2SWjCK4Y2Xd
 gJlH4pwPH+d6hAyeLnGo0u62epa56UxRFnMpJNtLkrjOJBPT6tH7yBu3z8lTy482UxOaZBVezVo
 7ynvWz0OZRgx928IkGcgTkeRoxoJ2FTEqqEm4awhHpr35edVSou8SDCp4GU2z2nx9OWRbgpsEjc
 xpZS70kd35w42Ob5hCRSvlKZI4eCEw==
X-Proofpoint-GUID: 1BoJlOjajU2ydRYTBdrtFWm5Z5ZqSEmU
X-Authority-Analysis: v=2.4 cv=Up1u9uwB c=1 sm=1 tr=0 ts=68fb916c cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=ynOTO_sPihNLyZ3iqyQA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: 1BoJlOjajU2ydRYTBdrtFWm5Z5ZqSEmU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180000


On Tue, 21 Oct 2025 16:52:04 +0530, Sarika Sharma wrote:
> Add a lockdep assertion to verify that ab->base_lock is held prior to
> allocating a REO update element in ath12k_dp_prepare_reo_update_elem().
> This helps detect potential concurrency issues during development and
> improves code robustness.
> Compiled tested only.
> 
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Assert base_lock is held before allocating REO update element
      commit: 197498315de711140bcc4722fdeb7c1761777100

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


