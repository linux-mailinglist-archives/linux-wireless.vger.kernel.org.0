Return-Path: <linux-wireless+bounces-17973-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E50A1CD7B
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 19:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A41EA18834B8
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 18:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0F01632DD;
	Sun, 26 Jan 2025 18:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H4d/JuRj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5015314D717
	for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 18:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737917108; cv=none; b=o425Ko9dDV0zFSN+sxSwc/pMm5aEIQFUkDviXBOYwksBpkRenozKnb46Lj/+yZPK8RhGuLYBGqX/eR9/lNva1PH7k51eyvD8kPBdFdbgIwFWeAQRoWfTkENP5UMIgpZaZer+2xw2HJro7UFQTN8hrM9Q+iuZTcrE6XmrM1VJ6fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737917108; c=relaxed/simple;
	bh=lOKnnBa42xeozjCWIr30hZB74ci74CkGa0zun1A3/YU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kOuOFXoZxbB15UVcDIP7FCUnB3Vg3PdR3GA5slerBN1gc7PJAY/5zP0RbVIoGPa5hYbe3/C2GDQIOCSq5WbkXq/nFc8SVDm9lrFXB3HljDX0cKYZe1tX19xOjv46+etDWrdOaMbJfEmBZCddL63+DqYXdl/xAZEJrb58fIv4s4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H4d/JuRj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50QIj6T6003391;
	Sun, 26 Jan 2025 18:45:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+vSa3nfXQM2xePYgrf7A8im9wXwMSfacRsv9VAHoB6w=; b=H4d/JuRjMC52Z/z/
	5ladWzJFEek1eviZg4w4bOJd0w1TVEDN+7vZFX9+0LNPO3miTI4NoKWg6vy535eS
	XgwXA/3fipNvIeX9qxm3ik/oUD7SiRY7TOv/GFSTQyETQYAkqg2giuPuiQn8OHdg
	FKRGzTJ8ncsmeuvCMS+jRXpLouLNhYiDCfBITlmnjkuPYVcAxkoEfcaFbBIuXOmq
	zgd+5JYrM+42e7JBopEqqUxSCX8jT21dVyy7RSIqHvls01NW0ruZXrVkpmcr2joa
	ZNbZVHuE0/mrBMcSaly6u57hlSN9DFW1gydjJVXlUlsPZzXwv4si2MK3mkhDziPW
	K55F5A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44cs2hj5cy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 18:45:05 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ef9204f898so7135356a91.2
        for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 10:45:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737917104; x=1738521904;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+vSa3nfXQM2xePYgrf7A8im9wXwMSfacRsv9VAHoB6w=;
        b=oX5dkh1nUogWV4XRvvFWM5rKUnUJr1LLdW+p1yusaRL6i4DgFxcsM92qDVYm/PEUdg
         56WNUysmmNCTGdkbj68Vv7I/s+wCXY2ap4CVwVDRI1Js5xaYp+KFpkqRn5P0JQP10LBB
         kQCpFEDwEjiQV1v/Y3NmVaaNh+Uwu7AcNUT5uGB41D5n0y7UvU+J66dFSIWZv9Sh0qYV
         MabdQ9GEWAhy3WyMi4BRd0KuaOMdYJ4I21ZfeeuuAkZnmfQoUd4KrnMKIGKX8Wd/GaDO
         ilXlforvnfkWPbn8qG4/JyVCjzrGPvozBfcfbKf3pqAmWX/Ma6CUKQr71Ig7Zy5PZywI
         TY1g==
X-Forwarded-Encrypted: i=1; AJvYcCViNKEM4rfJ18xQlQnOktiBWocddHLITgYjHmezdIC/kSQTs8rofk3NIXcRch7nwym1L5i7pZMViGJfUxiueg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbuF4UpsAt5aXb0ROkcvFJtIXmODIARtn33j4wNve/1id0lWtW
	eihYtIQpBOugZ12ItrW88+TiE1r4lfFpaSYaoXl+pseo1hWkOidH9xtVm9MsMCgtUUrjICXoV/4
	xNibjhO/jToSjO0KhMUsPNTvaKMwZoobY2udnFSmH088EoknHQcceYKyj2L0Ix3hroIGVV/KzmQ
	==
X-Gm-Gg: ASbGnct4nHQYQc68fXhfQP7IOI9UW8SGW5al0LN0SNkms+f9XAdBaj9rp3U0WpdbXHE
	6B/ok7CyXSBZhOSCozXqOT0hcI+2zqnK/vcyMY6Tam0QFqApaTgg+nG7SsThzhbrbtrvWzeAi7q
	7X0ujTnepRusqAwJ5P23LrK5UH6SkDE/yXfOqGFSZb/sC6q3CfAZp54rQiijIVFGgtWWBdRudLs
	3zCjq+RQHHvEResa0VRESzbSrhZI1UQzbiJ9lvUf8wXzKwE5YNgFpZ3gaDV0Cq6wMOytSfQZ2Jr
	QXjTUwiijaVT6+lQq3H8MgulowfNQcxmBCNA7aEONQ==
X-Received: by 2002:a17:90a:c890:b0:2ee:cd83:8fe7 with SMTP id 98e67ed59e1d1-2f782d9ee9amr53256513a91.35.1737917104281;
        Sun, 26 Jan 2025 10:45:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYp1/NPq7KY03nXtTrPdG1e7aXLBtD7LtLJ/4nRK00/X/uIr69KBAlpimtGYwVLGjFHWxiHA==
X-Received: by 2002:a17:90a:c890:b0:2ee:cd83:8fe7 with SMTP id 98e67ed59e1d1-2f782d9ee9amr53256492a91.35.1737917103922;
        Sun, 26 Jan 2025 10:45:03 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa44cb8sm5414795a91.6.2025.01.26.10.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 10:45:03 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: kvalo@kernel.org, quic_jjohnson@quicinc.com,
        Miaoqing Pan <quic_miaoqing@quicinc.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
In-Reply-To: <20250123080226.1116479-1-quic_miaoqing@quicinc.com>
References: <20250123080226.1116479-1-quic_miaoqing@quicinc.com>
Subject: Re: [PATCH v3] wifi: ath12k: fix memory leak in
 ath12k_pci_remove()
Message-Id: <173791710277.2935553.10215437137519428295.b4-ty@oss.qualcomm.com>
Date: Sun, 26 Jan 2025 10:45:02 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: OjwUNUl7FI7UnWgiFJBf55TeZdyqUt6y
X-Proofpoint-GUID: OjwUNUl7FI7UnWgiFJBf55TeZdyqUt6y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-26_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=692 lowpriorityscore=0 spamscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501260152


On Thu, 23 Jan 2025 16:02:26 +0800, Miaoqing Pan wrote:
> Kmemleak reported this error:
> 
>   unreferenced object 0xffff1c165cec3060 (size 32):
>     comm "insmod", pid 560, jiffies 4296964570 (age 235.596s)
>     backtrace:
>       [<000000005434db68>] __kmem_cache_alloc_node+0x1f4/0x2c0
>       [<000000001203b155>] kmalloc_trace+0x40/0x88
>       [<0000000028adc9c8>] _request_firmware+0xb8/0x608
>       [<00000000cad1aef7>] firmware_request_nowarn+0x50/0x80
>       [<000000005011a682>] local_pci_probe+0x48/0xd0
>       [<00000000077cd295>] pci_device_probe+0xb4/0x200
>       [<0000000087184c94>] really_probe+0x150/0x2c0
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: fix memory leak in ath12k_pci_remove()
      commit: 1b24394ed5c8a8d8f7b9e3aa9044c31495d46f2e

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


