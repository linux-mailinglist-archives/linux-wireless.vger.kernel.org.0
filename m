Return-Path: <linux-wireless+bounces-27458-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B89CFB83028
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 07:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED6BA620307
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 05:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C34329E113;
	Thu, 18 Sep 2025 05:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WL9KdHv7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7184A29C326
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 05:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758173169; cv=none; b=sQKlhLVjx5OkWR9O53eN0SNOVbiLbVjw6tMV4AtzzMGgX6MJOGjmq7FSJoT3RMh31YbhGvVTIJRziGTHDHRAHKEcpQwxhwf3uk6x0Exfa+ok2glP2vcYQGeX7k52JXKzcugZwMrTp6yHz8L2DGFfGuda/OP2xtqy66heZ8KLtMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758173169; c=relaxed/simple;
	bh=4QtD3PPTO8FXZFLGpokMAo9A/yPWm/TWfx9Z+Fa1zRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sq32sPKEm5HsK5vX8nmEPoh+4/P9WMjH9F/awXEACitPJCl1wJfKQKWpQHBz1Ue7/4tx6p3zAu6Tvy1+X9fI7qglkoKP5Mr0PRwzRxVNayXftkb/lb1lygWUO0EAmMuod9NBulMoK/G7QqqPdL6afc8hzLd6BfYE1jrph8685gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WL9KdHv7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I2wcrJ019524
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 05:26:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TxLEQ1yAcsKflfwl/4WqUC9+qcQ3v/8QuoGR2gXv2U0=; b=WL9KdHv7HW9HW90u
	d+7MCah+mYm9FJJHBOJ4+Nra6vgICv7wWVTvka5SuO6C6vzuEvjpQEH7NJSGv+vZ
	0DMSF6G47Xc8nYoQ9k1rw5eW6+onbyyzU0zJXeZQpRNhZeETgp0T3DTwOrFl4HA1
	4FhiON6lHwfCP5vjmk4uDxAE5eLPTkQUznyNhtL3PMeAY7lDUJoK8v+eWa568lGp
	Cx8pAJBOIbyCTsX0+/ru2BNGm1gjlmHLIPTB2vU4XaLtmWUJrHAXvc9pE1eRD7nc
	Zu6gNNeoWBZ656GGX1TEVJxipOH7N+7WAMqgUKC9sh3ssOLgtfgvnJ3mr8AQqgi6
	h2W38g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fy1w49h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 05:26:04 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2445806b18aso7424175ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 17 Sep 2025 22:26:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758173163; x=1758777963;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TxLEQ1yAcsKflfwl/4WqUC9+qcQ3v/8QuoGR2gXv2U0=;
        b=PgAPrFeSvJs5KnJqr1ZzKS1Ztw8hazCalsKVL3jFIVgZ2Kk6bMeBrKZfO7/Hg+W3G1
         35UC4hPwHu+x/TKTmpfJ/5mAGvEmR5+su63vYNRSJIwR8uaHjxBrYJF+T68YIEmonqg1
         8QxcEFH/XSc3IEpSRcZ9uS3c4kDG5/4Yxzf4JuECGEPY7JC+PXSVcDn7252S5DhLBcWh
         mMyYjiBOwOGPnJmvONOpcuK0AW0UuGrHMKiK4DPY/InFE5nR0p+ttDekwih0KvqtPEcv
         YqmKqL/MHUFpKuh2uGlODPf2L5FB5PENnBNtH0KTqDj1Aw9CSJ7P4+SNcZy4kY0fGo18
         S89g==
X-Gm-Message-State: AOJu0YxUKkInhHG6uOVu5x8cPBHpVc+cyZl39uqtkrwlCBMvvfT+AZad
	/453L1ASEKPVICMmcYpUQfZhxzhEB9CYS7B8E/ZqXwyKPKCnTDIPiNIjIy/sn2Qdwq+GSj0k7OO
	Ik78f6HvmpQVUUIvULolZ7d/bgdfk+JtzoIC/1L04cO6LPRg8J74XEeQhb9DcOB/KDTxoq4nLfa
	7XGw==
X-Gm-Gg: ASbGncskA3PcSpul6Zw5CJwWGI/VB3hzkEzWU+afeQrEj9uTcLdA6GiqAOMZHy3tFaz
	y2ZOPFLsIFSjVqqY+pL883TsilgFw0hs2Zxq8zEbMHxoG28I9GvYhDhO/XV02wMaZYaPKyMXsrW
	6DaBe98M189K/FfBukuUgAJKESfJZ/M0guG0+aU6OerwU4n2Fdya5Dr155cmTDfztDtq5XA7+O4
	Z7CgPJ0M2FSJvEI+8xt3frWt59sarSMSD7T7ZKag6xoujxXyF8/deIDHp7wlM8yl+UKLYl3eJt7
	+KeT94CsnqYWhLOjidYU73qTFt30mHO6yx+F75F+y3uxDKkyNMnXnxjDv4OqNXAwcXR2w6ROP94
	LLu5NzA==
X-Received: by 2002:a17:902:d2ca:b0:250:b622:c750 with SMTP id d9443c01a7336-26812382744mr59356145ad.27.1758173163188;
        Wed, 17 Sep 2025 22:26:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2eKaVeUCfIArMi6p8GZxEhLIWooff9a8Rntl8i99RgFCyRT1yLmP+U1U71pJsFcKLBylAJg==
X-Received: by 2002:a17:902:d2ca:b0:250:b622:c750 with SMTP id d9443c01a7336-26812382744mr59355985ad.27.1758173162768;
        Wed, 17 Sep 2025 22:26:02 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802de963sm12704935ad.77.2025.09.17.22.26.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 22:26:02 -0700 (PDT)
Message-ID: <36e9b150-fcf4-db45-54d8-a157201e516a@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 10:55:58 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] wifi: ath11k: fix NULL derefence in ath11k_qmi_m3_load()
Content-Language: en-US
To: Matvey Kovalev <matvey.kovalev@ispras.ru>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        stable@vger.kernel.org
References: <20250917192020.1340-1-matvey.kovalev@ispras.ru>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250917192020.1340-1-matvey.kovalev@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: vJvPQGocohU7XEY1WjtKKww3EREHtOIN
X-Proofpoint-ORIG-GUID: vJvPQGocohU7XEY1WjtKKww3EREHtOIN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX/a1wcGJ/bVTn
 1OkSmxePOn5i13m4DoaaYIwjMhU1QHcb6n6q3K/xNoL2w5DOlFI0ws1v31QKYIFRNQPRIOoNC6I
 gMvUVjRcEMNLtPxsxS+hAfzKFUyXB+fGuWW7JNNAfqPhX/K8aoEjuGa5M1gXCO7oXrIDzZlhoEx
 a2yhi8OZ+FhmuQecqit53lrVuPz8hQmYIPQ2PdWZi0YL3hVFMo08aOQtsZDU2+ntbNLLf69GglU
 lUSTs7IhD43zuIQ1k6bTfiwl0HvmKqoNiNs3d7QxhKp949oumUfNeDBiXWUVYC14GQ7dEdGbaIw
 1rEcJLU5qCYBoHDX06A8igFW8cLYe3CQidOT5YscQ6B+ICRUQC5ADfviP2hvi8ofZ/UyGsY2/DV
 7Ifp6m8n
X-Authority-Analysis: v=2.4 cv=cf7SrmDM c=1 sm=1 tr=0 ts=68cb97ec cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=HH5vDtPzAAAA:8 a=VwQbUJbxAAAA:8
 a=xjQjg--fAAAA:8 a=EUspDBNiAAAA:8 a=nfJR6hy_ZLdhEb8FW4cA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=324X-CrmTo6CU4MGRt3R:22 a=QM_-zKB-Ew0MsOlNKMB5:22
 a=L4vkcYpMSA5nFlNZ2tk3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 phishscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202



On 9/18/2025 12:50 AM, Matvey Kovalev wrote:
> If ab->fw.m3_data points to data, then fw pointer remains null.
> Further, if m3_mem is not allocated, then fw is dereferenced to be
> passed to ath11k_err function.
> 
> Replace fw->size by m3_len.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 7db88b962f06 ("wifi: ath11k: add firmware-2.bin support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matvey Kovalev <matvey.kovalev@ispras.ru>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

