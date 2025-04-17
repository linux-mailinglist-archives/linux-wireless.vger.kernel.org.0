Return-Path: <linux-wireless+bounces-21689-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF49DA92D6F
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 00:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 522DE1B64CB1
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 22:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48489221726;
	Thu, 17 Apr 2025 22:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FhiTwbvy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B263522154D
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 22:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744930664; cv=none; b=o6twYN/+yFFpU1GOwE8Ns72InnXWHcHTvib/POxkEHDBwf7Oa3Iwe2nZZuLNNhyXSFWZZ6qwJhVK9CfhS4AhvVSFr0CX/3Ssf+2XAluqC5LifeBH4lp960dHDt32T6zwttM2H55x1gzh7fNQP/5dEUWxFzJUpC3z2mnqcksAQGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744930664; c=relaxed/simple;
	bh=eLC7KTHAjQn4rk71+jVQOb3ATXDR0wTfqikqccUfpU8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jkZsKapP95rSK1mSNQtJQsoFc5LuBv+LXfqMYf4dWp6UAXi4UvGMRDLZ0uKRaFxcuDkJlJo44Ro3BjLOwMUkLdAopQJD82wS/2aitfiqm78WFws+8qWk+jDqKjxV44PR8CD9KsZw/Elm+u9XCJBE8n8SqjwC4VgOAZBE0eejo+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FhiTwbvy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HClQ48023395
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 22:57:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0WkJj55ckMkZWRebTctgmjjLQ0yNC9NwyhJauRBTO9A=; b=FhiTwbvyn/c9WFdY
	ZlQSMVBxHo5g0B9pUGUrNzK6d7IREXiqmVg1eyZ1BE3PXDhDz+RlL+s9yvdlLRU4
	L2vphNxBc6mVND1wwAyQ8Bj7jfoaTzD5c8LtSjMXFaQxo9wjbOZ6fIHME7z7GQnk
	Kp/smCah4MiO6GXWR3JeWiIzybKmni46ziYvb45mvvFD+akUzFeWKdRRzubiiYJk
	SSsDN1vAO12Y/dQ9jS1LbBDggzl83VZyrqFunPLIRgh7hcu/5hn3/DoEEHujen+H
	zw8YrgOV53jVqdvXH0ApahUxZGsRGdKWbWs9TsanDr8Q7YxR8Gl8s8SGbU8g4eVk
	IbaChw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yhbq05tg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 22:57:41 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-72f3b4c0305so1475595b3a.0
        for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 15:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744930661; x=1745535461;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WkJj55ckMkZWRebTctgmjjLQ0yNC9NwyhJauRBTO9A=;
        b=BLhV0d2P6kQBsAkoBEJTONWhrXyO1Tc5AAgUqjTF2f42ZuCBLI5LkkCtBGLRaQgQNF
         vEouUPBMhsAPoRU392EPAaO4mwFEOKtxR2KQu80M2nzYvk/YzVfw9Evr9FhRxHo3TT5z
         MRUM9fT8smKhJM7pAG9IfIY7DKYxWtTh5pMr2s3+Aju44rmLXtXrFHSHcGUG56NK34o/
         uTZiOdcS5vX5eymlyRsT59CAc6jmq5V6bZsh9LG6K6Dq8K+B3RW5mktfOmS4SlYq5PiV
         i2fpeDsfxLD+1kz+TazzZfLRyNodtjnyfZsh2TiOwnEJjIwLVNSYOF37mXI95g3Vz1kb
         T9Tg==
X-Gm-Message-State: AOJu0YxIwEKzBM0MW2Ees6tmttNiM/ylHWp1uzGlj+YeGQwkWFEyzFAQ
	LrtlZg8ibEUgGz4gPgDNePhyrNqc1jN9/1dOhL7ANQEhFIBzF6M23yZ6W9mmsensjIaOpF1S+me
	OgqE5y3+ez4KH6vciLVOhqPYmdmAVNMxuHpU83EsJvnWsDQNwLHqJiUQxvHa3uVzA8zN6nnkGEg
	==
X-Gm-Gg: ASbGncsnbPwrx7hDZfadZuccKqFFwPQq45+nBxcY43Phmw/aKptx5TXSxeEnsNrNRe6
	4wcwi63K1dGn+PPTVrz+HZw+TV+dzAqMrg0qmn0XDM/XxBvmBmLMotpAr4IdTELrybgcZwTPyfA
	udgQ4UqTy6AKElPLV0egnMTTDJvfFxTNityZLo3ckfTpvbEr2qoOsz7GVtKZyAr2FKanJkC00XC
	1JnL/7Wu07Ms7Pdsis5Qv5tMsELG0qu58daXpZRM1JWX9XS/GyRUDiLEy0hjtxaCo3ai0PMsykw
	K6vMAAX3MUbwa4BPoxgH8yBMYEz4/jllBSeEiWypglcWOS7R
X-Received: by 2002:a05:6a21:9186:b0:1f5:889c:3cbd with SMTP id adf61e73a8af0-203cbd23855mr1333902637.35.1744930660781;
        Thu, 17 Apr 2025 15:57:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYDbzyzQ4441nOFlGbZPBvia6ZjBBUvo5HhRIXaGmnKFkpUhiOGQBk+8HrYB1pPWXxScFyMQ==
X-Received: by 2002:a05:6a21:9186:b0:1f5:889c:3cbd with SMTP id adf61e73a8af0-203cbd23855mr1333879637.35.1744930660364;
        Thu, 17 Apr 2025 15:57:40 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf901187sm426468b3a.76.2025.04.17.15.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 15:57:40 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250416020414.2161545-1-maharaja.kennadyrajan@oss.qualcomm.com>
References: <20250416020414.2161545-1-maharaja.kennadyrajan@oss.qualcomm.com>
Subject: Re: [PATCH ath-next v2] wifi: ath12k: Prevent sending WMI commands
 to firmware during firmware crash
Message-Id: <174493065977.1347382.5338707577981536248.b4-ty@oss.qualcomm.com>
Date: Thu, 17 Apr 2025 15:57:39 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: 6K2YrAWwphgM1YPIQbWsy9XyZa7l584J
X-Proofpoint-GUID: 6K2YrAWwphgM1YPIQbWsy9XyZa7l584J
X-Authority-Analysis: v=2.4 cv=I+plRMgg c=1 sm=1 tr=0 ts=68018765 cx=c_pps a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=JeHNsM41ab7HFODXWO8A:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_07,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=847 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170169


On Wed, 16 Apr 2025 07:34:14 +0530, Maharaja Kennadyrajan wrote:
> Currently, we encounter the following kernel call trace when a firmware
> crash occurs. This happens because the host sends WMI commands to the
> firmware while it is in recovery, causing the commands to fail and
> resulting in the kernel call trace.
> 
> Set the ATH12K_FLAG_CRASH_FLUSH and ATH12K_FLAG_RECOVERY flags when the
> host driver receives the firmware crash notification from MHI. This
> prevents sending WMI commands to the firmware during recovery.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Prevent sending WMI commands to firmware during firmware crash
      commit: e9e094a9734ea3bd4d4d117c915ccf129ac61ba1

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


