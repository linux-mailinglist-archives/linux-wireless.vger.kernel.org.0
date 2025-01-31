Return-Path: <linux-wireless+bounces-18250-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB0CA24367
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2025 20:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EDA77A1529
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2025 19:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB3A1547E4;
	Fri, 31 Jan 2025 19:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lRJkoUGC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143671369BB
	for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 19:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738352061; cv=none; b=le3ygwWOnVlUm0TAlOScV3jonUh4/m20CddmtjRSJFYQoOE6QUvbyMxx/E545iuhaEyLpXeDncC1GF9LnuzmEptw8Nq0Zeom6fN3rAkPcizXtlEBZUTJR7y/asQArXopC+F1/37nqtlyTDrZjlBBlK3TVnEKtBxX2PcdS5rRRn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738352061; c=relaxed/simple;
	bh=cd/T7m9o90TIl0RHVdLS+kN+pf5lpASgq25Xy3B+TCM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MSWZIdqGfRbKiwEXZGYQTTQbBJT4XwrnCtYd2zUpQ71XeeQrx1yQe/7dxn6hzS0gyNBbV0El9hF7bon89gPpCkSYAHxRH2oC0jz2k16oomaLKk83/wXU55u7pi/NBTJ5ISUqFBJ6Wj+8ZX6gitVXXKXG2h1039VN5JJvzwTAdgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lRJkoUGC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50VJKNJK025898
	for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 19:34:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	H8+dJdN9FZTAdyodaE8uUF6aIt7C/+lkLwdCf9e0Tx0=; b=lRJkoUGCo2xPR7f8
	Vrj8wj85Q3jHZVaFOAZP3hlz/kfAaGeVvReI1esY22kvueEuvj5sycBdQCJEl/P9
	ush4JQLt/kN842r0nBYZw+q7SzQr0iEh73iLG2QiGVNbZ+2JS59kgCmx/SRNfhNw
	oLFCDMSnQJGK/07UcT4L4Nyo5TUJqSjKejkEoPSaJvctVvIJoxuePrb73tCteebV
	/2ff4l7BhLa+OifDCBJh8IgxJ+o/MCXhNMh02HoNvqV+MsNr5amMsc54FXHEPc/M
	GYJnyAe1Z3mmsH8rtZoPczUafkdaeYvnlg5P/wOXPYgeif7exlgmPzkMgrTIv6cT
	D2Xt9A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44h4k2r1np-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 19:34:18 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-21648c8601cso42575225ad.2
        for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 11:34:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738352058; x=1738956858;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H8+dJdN9FZTAdyodaE8uUF6aIt7C/+lkLwdCf9e0Tx0=;
        b=mkLDmtiUtUDXq4oPtFrtKHmRishimaHnI9vFKKdBuwZka5XYlIuSPOIobYQ7kmE8Y9
         5QiWrTkZ8vFdEs2NuQJvq0XPTkGh0UZEWJUzGfHBG/RZu2zVEr+j0h2j0I2lyrd0pPj0
         q7mn5yXzyMyX3t42UHe3C637QNRfwaEJ/EcgGIlv2YK3tIC2hfCUlvTr32AXaJ8mzZwl
         2MOX8ew7S+IFrWj579OlbRNMs8GW6wHiCuHsaCOrjiFzpUH/I+5LCfvdDyvUf4RZMS+9
         MslBIVd4SWQ+VeaLC14aB7Zo2wHwQB788co/20EZ/gSwYOiZ24Hf+A76NEuDj1vtG5+/
         SQmA==
X-Gm-Message-State: AOJu0Yx3MoZPsf2U0eXKvu9cqfb0I4xhVij1Mq8Fv6cdwWTnMkuROhEa
	Kou6f50rXXsB2OgXJpPvfrKos8HpzBYAKGvZS6ZBOu71nddbQZtZVvkAwXgtnaJctxAAriuFues
	IfLcr1B+8mADkGDPcRT99NPNdE6Udn0v+73b9jcmfDiH8brmH1UZAiDMirSF7K883cDsHOlZxmw
	==
X-Gm-Gg: ASbGncvXfIz0kQEcxhT7Gl/fRyYtFUDXQaTWAZKTfNIJ9gTc7YzY8ad//zvknRL//Mq
	BohBD76kiqVcltok86+191z0GzB18nLVa5wtcj7u1p80S74h92B/SexcCfrBmMFWhxuXIS//7kB
	YoDCaTTnaAt8IJQQ+loxJIZAEmThw1ZWp4WMZBS0phLLvVznG0ITaxkYtel2sY5woOUKmvBOwlg
	E24szUBhARhP70ROImU3dyMBdCBhSu5URZGgvF4s1sm8ddtc+xYSRP9mmPrqoTPCa0WSYWI9DG5
	8MqbeaLocM6QGNOfBgkITBfMMN4CsleglnB7UAX8aw==
X-Received: by 2002:a17:902:ecc1:b0:216:55a1:369 with SMTP id d9443c01a7336-21dd7d7cc30mr164925995ad.18.1738352057790;
        Fri, 31 Jan 2025 11:34:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHq6IeAvZhmXuG587O8ro8aWl4Ca9E8QnUMVaWmBsB9QkKGADMv3cHVb+Q7fex/oRRlCVg3hA==
X-Received: by 2002:a17:902:ecc1:b0:216:55a1:369 with SMTP id d9443c01a7336-21dd7d7cc30mr164925725ad.18.1738352057425;
        Fri, 31 Jan 2025 11:34:17 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de3302a50sm33721995ad.188.2025.01.31.11.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 11:34:17 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Nicolas Escande <nico.escande@gmail.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250127071306.1454699-1-nico.escande@gmail.com>
References: <20250127071306.1454699-1-nico.escande@gmail.com>
Subject: Re: [PATCH v2] wifi: ath12k: fix
 ath12k_hal_tx_cmd_ext_desc_setup() info1 override
Message-Id: <173835205680.1098484.16094267850867670920.b4-ty@oss.qualcomm.com>
Date: Fri, 31 Jan 2025 11:34:16 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: GOl7VqRQeri-hvI3xsEEX2xa1urQqalT
X-Proofpoint-GUID: GOl7VqRQeri-hvI3xsEEX2xa1urQqalT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_07,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=917 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2501310148


On Mon, 27 Jan 2025 08:13:06 +0100, Nicolas Escande wrote:
> Since inception there is an obvious typo laying around in
> ath12k_hal_tx_cmd_ext_desc_setup(). Instead of intitializing + adding
> flags to tcl_ext_cmd->info1, we initialize + override. This will be needed
> in the future to make broadcast frames work with ethernet encapsulation.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: fix ath12k_hal_tx_cmd_ext_desc_setup() info1 override
      commit: df11edfba49e5fb69f4c9e7cb76082b89c417f78

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


