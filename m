Return-Path: <linux-wireless+bounces-27501-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3A7B8768E
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 01:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28D5C1CC0A59
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 23:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA082FE05A;
	Thu, 18 Sep 2025 23:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RgKoZmHI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5856E2F5307
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 23:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758239251; cv=none; b=OxbO0g19TcUYqztfjpBwAXl9sOTcV6VpzGcDoV1WuYgT+eEPx6mMJPgEIZSXTsXLHX6EVXLVluXPznb4a5HPuVbAO2GrgsrIOu3euGl6BejIqybicvEWddwYjYpLtfRmuR9gLSUT5xM+vx9M1rHSMJKM/8tbytW7Y/0VsipwciE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758239251; c=relaxed/simple;
	bh=KIjI1RO8mAvB0xu/RUl6nnERV2ejU8oSY1onvNolHV0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DjnxH/9SAiJ80Erq+eHalAy9hrE3EJaNol9B4swdC58EAl6KRrSSYuVonzlsLyejklRBylekT35J9o1g9iJbFh21kdbOm30g0Cmqib06D8fNvI7NVRQFslKJI1xVNiG2hdF4eXSeSNur5/DB+mBBL4jNnQFhNyI3KekF2Akffm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RgKoZmHI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IFDK31007556
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 23:47:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kqH34T9ABP4xJGwUQgNeZtZ1hEP1XtvVs9vYhgoytOQ=; b=RgKoZmHIz5CSMrfi
	RbMcBs9Ln9BAt1IzebjazW6puUjSfAwl33VRXOllBsVjsmooXGGEOd4R2V/5almS
	uEyRyNvqRT4B6hLAzTjG2gOzHrdGTV4jSV+VsBs3rKG7bSvFym7/qfE6z2b0Y/b9
	nR6pl20K/Z5eI1nR9BOtDag/hmDgohntnDmuHDfGtTwN8nFsDaT7x6yxAVxiC+7w
	n+xtQJr0yEGyligBWnLSU9T2NildDhpjVc366y5OsOU/3VZz+2g3GgSMPBvSUmTC
	tNOGwBfj/VHFPcynLINI8t4UjAG9Fcf5A86NPYndm1nNpEB5We2NPbCbNzydoCSJ
	D/+EyA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 498ebetwfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 23:47:29 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2665df2e24aso26320565ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 16:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758239249; x=1758844049;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqH34T9ABP4xJGwUQgNeZtZ1hEP1XtvVs9vYhgoytOQ=;
        b=rx4l+B7W39DGJZHo5CxM6y5c9ebHxInb1Zh+khf5t0RISDCdk1a0AO8/oXm68ghJKO
         4KcxQSYH8Ldy9IP6LdNF6jx+1hf7Z46afDGy8fycFFbX4Csk4nUDBAoXy9OCOAwDLdsS
         Y63mNBRF7WL+TdVhB0x7ryoMVkWNJiPi6Zh4jvkUGC3YHqLWTWt/LJkX2VVnvtW/dHg8
         hwJArgts+D5Y9J8e3qcIOzv6wxqcZ3xS8sfJR+mTlZW4a6FVgtgJrOodZlgqE2uS1C05
         sI1n3QFVGYAwjYfBBBN4lIuqVgcrZmbfr7K56UIQrawqs0TuZKgewwuyUiA+V92gtvX7
         0YUw==
X-Gm-Message-State: AOJu0YyDISCem2QEGaNFTxacmOcVrA9VkKvUDLVlrOZ+wIt+dNCQmcvW
	QZjGOduC5L/Z+43YPLRHHB4pm5NhwUp+/Z3WbEMEgfJWQJVqwpjTvYU4me2Wze3sq5080u9hUUK
	jH60xcmYPqwrq0hqxOftInewgV99T7mS2QXdR9J4kEj39OL9VGA94LT6Oum6KHqeXDdY7Ng==
X-Gm-Gg: ASbGncuplV/f7IJtYRihGwzypheZ1fY92UC08Q3p2q7pDWvL+84c4uolo21yqQqCazf
	F/006tIZfzpgg9LE0OYm8VOaeLXnMdGmA6G2BrQQyWMBRuM1io93FR1B9VYBPveu2gLggI6bUFr
	axsyoHj8SGGXtRzl9IP9Cr2sK6iDHazH5w75EPZBulIRF9k4hdyUNbs5G2Q4hqv2ApSmFoxjd4t
	WfuEYmHjr9lWRsL2s3+0m/aqqFsilt0oFlq3+PeyRkR80HSSk41GkgWhbnCSFS9AihaU41OChJi
	IPXwT+5TzY2oqGjeCovxWdy+xkxzy8tfUxnz5xZu3593zW/vTs3S7wU7cpaeeWBa5BXgk1bbQVT
	K
X-Received: by 2002:a17:902:e946:b0:24b:4a9a:703a with SMTP id d9443c01a7336-269ba42b2a8mr20343255ad.17.1758239248789;
        Thu, 18 Sep 2025 16:47:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/6dTbkLUp3A7b22kFC4mdhZ/7BtHqoap1xG7tY7v/Dt0BYlzLBuVlVJrxzIJMbJOcsmXrug==
X-Received: by 2002:a17:902:e946:b0:24b:4a9a:703a with SMTP id d9443c01a7336-269ba42b2a8mr20342975ad.17.1758239248362;
        Thu, 18 Sep 2025 16:47:28 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269aa71c928sm16474705ad.107.2025.09.18.16.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 16:47:28 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Matvey Kovalev <matvey.kovalev@ispras.ru>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        stable@vger.kernel.org
In-Reply-To: <20250917192020.1340-1-matvey.kovalev@ispras.ru>
References: <20250917192020.1340-1-matvey.kovalev@ispras.ru>
Subject: Re: [PATCH] wifi: ath11k: fix NULL derefence in
 ath11k_qmi_m3_load()
Message-Id: <175823924766.3217488.6109469666821383356.b4-ty@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 16:47:27 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: ReoSuQL1rUKuc7ImTyrzWqM3KSGOuLHL
X-Authority-Analysis: v=2.4 cv=H6/bw/Yi c=1 sm=1 tr=0 ts=68cc9a11 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=HH5vDtPzAAAA:8 a=EUspDBNiAAAA:8
 a=nfJR6hy_ZLdhEb8FW4cA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=QM_-zKB-Ew0MsOlNKMB5:22
X-Proofpoint-GUID: ReoSuQL1rUKuc7ImTyrzWqM3KSGOuLHL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE4MDA3NCBTYWx0ZWRfX87XyqYH778dv
 UeGkkpNa4AwKPO/9KGfICv8sydcSzMuLkLTOhEsu8rQ/WBs/CmTZ9NSkGdkt0w7LgkXkJvtU9tz
 mJzhakiW9lmoNwepXI5fMs+vQ9ixY+BQjgSHZ8Lb7n8CRcwQwwnK5D2jzhSbXou/a43kw5UP9B9
 4ihkNRloN0tsrRg+wpqzrgxR98Bx1Vbog8VxCVJ8k9doJ3uWMYGd+7iFy4yu36K/Zf2JpwIIcaV
 h2IokrbqOf5WbgqAeOEisVshP8lWzupB5LZAfMsAs/wBEfTIqjWDuKGAIYbYJtDkj5NBUiffU+o
 R7YtUM1K5RVAsi8M6/96ptGThxxviqpyp0Ipzwig/+HajbnA5D1QvqnDchPUkJRP6Wt5RiYsYa7
 vN0xIuSq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509180074


On Wed, 17 Sep 2025 22:20:01 +0300, Matvey Kovalev wrote:
> If ab->fw.m3_data points to data, then fw pointer remains null.
> Further, if m3_mem is not allocated, then fw is dereferenced to be
> passed to ath11k_err function.
> 
> Replace fw->size by m3_len.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: fix NULL derefence in ath11k_qmi_m3_load()
      commit: 3fd2ef2ae2b5c955584a3bee8e83ae7d7a98f782

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


