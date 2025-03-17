Return-Path: <linux-wireless+bounces-20457-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE354A65B8D
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 18:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F22DF3B95E1
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 17:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F5B1AF0CE;
	Mon, 17 Mar 2025 17:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N2GX2AuS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA64F1B21B8
	for <linux-wireless@vger.kernel.org>; Mon, 17 Mar 2025 17:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233960; cv=none; b=uRRdOQmVYrSn0DOW7GzUEY0/IJYnRknmRJ7KYmaZOzeonbYNnG6OU/2hY6xahUh5vcIsHwU1S0urFpi2+ZKV8pEnxsiZ7izhsrulD0VSJ+nV9zMMcIXPcaPjDyVTlXP1Wj4nK2BFt2YHpQhKhO3c+XECOW/+hS6FGj19Ow4GQqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233960; c=relaxed/simple;
	bh=f62ojl+o4A2l90TEjbig1mzXjGY+K9lbk5ckJztb9fI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=glmcV3w8Xlg/DGWMQWZYrYlRte5J6McHNjeifNeCa2C+kEUEk9d1ZeslA1hApYAasRK6rEVv1Sr5NhyvCvx3y9ZA71v2T8NgajIsaUv1nQVhlyLM23FZhRcWr7u5+bpXmhArLo+clRf6BHm535dxU6zQNMVAs8yHDkBJ8IuRONA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N2GX2AuS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52HAFSZW003888
	for <linux-wireless@vger.kernel.org>; Mon, 17 Mar 2025 17:52:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W48kH/S0HGkEFujKBeAyySxmQc5Opn4Q4HURKwAUaJE=; b=N2GX2AuS7C7jtsmU
	utzBsgrhMK8REKcFP5qyJPfU6W0xRQVGyB7jErhersrg7uIA6emij9BKup7Fi/GV
	SV2G9K8a7KWDg/s4Fpl0Znty7O52uIp+KFrbpNUQfYdGLq6X+WiWuoKIyFEM7oTG
	CTpfv3hqXHPtE4W75+SRRAj8bkcSpHQx35FdXl+56M5dWJEzmrIOkFOnlq6KJEUw
	scw19AdC2K1nUu9TSGDl88efrTXo1AgPdMQs+tTKTvR/pzSshUXtzJKRNButHGVY
	eZVxQnqGg2L8Xn15dM0RyZjjTv4P2E83wb/02nCsfKpqV8JEFpwJmagKJCKEV3mZ
	hV/dRg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1rdnm0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 17 Mar 2025 17:52:38 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2233b764fc8so81378095ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 17 Mar 2025 10:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742233945; x=1742838745;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W48kH/S0HGkEFujKBeAyySxmQc5Opn4Q4HURKwAUaJE=;
        b=e3DCevvxslSOOGycx9ucyurr2x1vOnpFfVnc/7sD4OuPUVaaQJ60qu8Eg2fOJb4cbZ
         a5PKN1DIqKLyjH+ZAcBgwVIMnyWE87HvKomxD42MvpxB0ISX0uFXzlLVs2uzcnBj881+
         xPSW/OnkTgJf7iEpnpf/+55Sg1EDypyN4ZeyYHWI/IgO62c2Y+qh1Z3wsNsQstPcvlin
         UFJtYzMIo7LCCyJcj1GII3cnjwFndEo7S9bpvgT+h0kmvn0Nw9tH1hoeUXgDHL5EQ1hC
         /iu5sFfCk3s+ndMm3LaphaplM4Bu/n5wqoTGdfhRhByIwI9GdehULXRBDIXl/nTsCEmU
         GBpw==
X-Forwarded-Encrypted: i=1; AJvYcCUKqaV7zJaPsVhQaTgZBKhZUxJ9R0QsvN3SBsjodkOBSSvLZecze+CkTNBX8W/FDBSSEGHuppu65fLTNPZg7w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1G0pn83IJqEp2z1HnpQWGfUhd0LTu3SjUeC4EbV0XsqCPOuiX
	fEFPyBLe5TFhWtsF7euRuteJcV51LtMuOK/9N3xeKheLSNLnjA4WFQcBj+no4j3rJp7rLzO/CmG
	p3zTvrvja19RiwWknvnrbq1YOZtdqyc7R5Hs1fVmLuZlN4mwOgN5XifndBCE77wMqDg==
X-Gm-Gg: ASbGncuXcWCyaHvehHBGiq8EAPubjhoj8YGExe94G1aaAvNakQeflJGgJSBAKinK5DH
	3ClDAe0JbA4F+PsiSVnMVWG7AIe0M60x2Qxp3J7ElDiYE452Gg34iA2ZelFgNwtzKi+wsXp95GQ
	InCJ362zMun35ibaRdYP0XCcVQx5fi2sjThDVoGZ4eWu3UK31lI+LxASNxEFjZkfDVo9a1sHYkc
	Izj4dUi0SqqxpF6zKxbdK0KL2PmiEq1KFUI6OpeHB7+9jN6EtMQVMXuSlnZhvk9D81LEpY9K6Oa
	vMh/vdseDJ2X1RR7ghuH09YUGKdwDL1rWf2zfI3G9FjeJs07wcxd
X-Received: by 2002:a17:903:22c8:b0:21f:136a:a374 with SMTP id d9443c01a7336-225e0b098a2mr184232375ad.43.1742233945104;
        Mon, 17 Mar 2025 10:52:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoIwZ/XaW2xB5u/EDFQEQhDMqg39v0rU7Oq0/roBytKAynLPkZcvcV3MFWkdWN+E2yf8FxAg==
X-Received: by 2002:a17:903:22c8:b0:21f:136a:a374 with SMTP id d9443c01a7336-225e0b098a2mr184231995ad.43.1742233944697;
        Mon, 17 Mar 2025 10:52:24 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd5ce5sm78291485ad.252.2025.03.17.10.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 10:52:24 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Christian Lamparter <chunkeey@googlemail.com>, Kees Cook <kees@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20250310222339.work.654-kees@kernel.org>
References: <20250310222339.work.654-kees@kernel.org>
Subject: Re: [PATCH] wifi: carl9170: Add __nonstring annotations for
 unterminated strings
Message-Id: <174223394380.578193.6449253449477522706.b4-ty@oss.qualcomm.com>
Date: Mon, 17 Mar 2025 10:52:23 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Authority-Analysis: v=2.4 cv=Fe83xI+6 c=1 sm=1 tr=0 ts=67d86166 cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=a8UXU1FYSwnUjzW3zpYA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: 6iGa1bqYFK7V_cdcVynbVlk9kahH3haa
X-Proofpoint-GUID: 6iGa1bqYFK7V_cdcVynbVlk9kahH3haa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_07,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 mlxlogscore=588 spamscore=0
 clxscore=1015 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503170129


On Mon, 10 Mar 2025 15:23:40 -0700, Kees Cook wrote:
> When a character array without a terminating NUL character has a static
> initializer, GCC 15's -Wunterminated-string-initialization will only
> warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
> with __nonstring to and correctly identify the char array as "not a C
> string" and thereby eliminate the warning.
> 
> 
> [...]

Applied, thanks!

[1/1] wifi: carl9170: Add __nonstring annotations for unterminated strings
      commit: 9a1cf85c9c7cca15bfc452f207818977621dedf8

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


