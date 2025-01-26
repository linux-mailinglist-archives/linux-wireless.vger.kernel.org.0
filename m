Return-Path: <linux-wireless+bounces-17977-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 999D6A1CD81
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 19:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 734F71883462
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 18:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BE3189B86;
	Sun, 26 Jan 2025 18:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MWR8koP6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57D2188CDB
	for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 18:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737917114; cv=none; b=VdABZYaucsMcLsT5oOYuMLSrNF1eoU6DX5VzjdXNT9SxXHhedUoSErpfjnMX8hFoGMONjIIGhDy3wF8iJqmw6rOZXsImga9QIfNr8/BGMGGyCqh8NdgglVlyQr0La+YN4qTQN31zWHlt3GF1UmXKQRwPEwrNOqOkYoppMc/DFk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737917114; c=relaxed/simple;
	bh=t4BBxlGC4r1kKAdXi/G/D8Xz9vgNvxMndb9dXl80BIU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aq+gRuS271OsTMOwIbeZwIYSPMI1hfHgrzYHH1KGNSGSIB7O8Waa5YbfcfsecgfNnjKkLk+lvb7MGBgGlQxP96ESbNVWU8A4Wo/qZUMyHyGstN0nPzCmzT7EKIvc5/ntzs9tQ/K+J+Q72AztKckX7h+FwuUkNQ8p5YMMGvMjar8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MWR8koP6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50QIh6UC013824
	for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 18:45:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Dn0jFjrouR/ya11gISh3+rftcCO9+ETAHrvxzo67oAw=; b=MWR8koP60H7PtoTX
	kiQxjIqmbssVuNLPbSmFKcbaTN7bmGfcjmNi14NsBgErUeSo+pTdfTM+L2QjwhwG
	c6lZTegoysYPAzxQ5nCKIHpCEB7ro09WogbS6jC2rvYtgr+IzCBPlhgIqCbpxrwS
	OCMEUcxqbGqmi0e9bRPHbkDgk4NPcGdgUlH1wFC/1+NK+lZf8q4xZ6GyoqUbQYls
	SeCDQBT2c3tvCb+4WbFj887wUzRIxB06uAf54Zh62SXWt9lr/IDSJCGfuJb63npm
	IGF6JviF/uHfRWNXkdt+BX4ciwfnMtCySINSmL3rX8JEpuw7vcHfnAi/vTuMg0/N
	K5OpQA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44dsav02d5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 18:45:05 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2f81a0d0a18so817779a91.3
        for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 10:45:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737917105; x=1738521905;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dn0jFjrouR/ya11gISh3+rftcCO9+ETAHrvxzo67oAw=;
        b=ViuAG/d6fpeevWHCE1VdqPNxTNjYzZFYGoI2HFq3FbX1DQLwd7/jv7p7mZ1mep7K5Y
         kln5ZxxNcI+BAlMmHH+/S/9eXKK9gqlPEDKKdTD4RTg8FHWSLxjMfUDRqRUfpF0dgH+v
         WQddPyUAxMz5OB2MBuOhWqR7pUgxthHETplBhmsfvmOFbuixNOryoKWi+CcnycF9gJxW
         huFliBqEegYewxxIkWRX1B4i1JQR95tYW8ZLaugDgU/XzO6FvdcvMC/vmki8/XkNrIh2
         i8X/Jtp+rCh0KWqfbX0iRfZkL0qTV4G36nxwIcV5fpu6RgRybZLzWSnARd+8D7uNgtyb
         YQ+A==
X-Gm-Message-State: AOJu0YzEhFFZvwvKzW+OwO23oFENK3R5b/NnIdiGI4LAKVv/LJr7dMKv
	xoyUDoiSbpHpE+79aR6ekQsafyp/1+zvi5okqsGmqlT3NEv5vYHuVYApONZiGfZiizdeHjVXKGW
	jb+8EivVpzah2RpUAxc5V7BhDubMkivaJP1A26lUPssU5D+l4Ck1vlWwZ8RTT1iwEkA==
X-Gm-Gg: ASbGncstabA9/aQLm20EY6P/Vp3zbAle8gbMfmBrcEsJxyxq7hpZ9Cmhwv6tnEXjNH+
	wIKiZPxWgm91lqVG9OeLQaj/2nToCfJ5mDMXgZ7tqeB1oMh5lKXmUuU7QR7kblBDssqeBu6HZ0E
	ZSRYNqzJTlDG1GkMghXh17EoXulhRqOUQJJ/7zx4fTjLUtEReURZGYT9TYiz4QPTsNjZuDhWZtZ
	BsgL23Vc56J8DitJQw3UwaoGLrAkhyUoMrNZ1HX0M0HEaRYZkWkJJcsJkGmnUi9AFVOFmbc0m7s
	bGqWWIjNtFbvI4h5Kp58VIFPtJPsc6TfdJ8VBUr42w==
X-Received: by 2002:a17:90b:4b8c:b0:2f4:9e8b:6aad with SMTP id 98e67ed59e1d1-2f782b11be1mr67062025a91.0.1737917105028;
        Sun, 26 Jan 2025 10:45:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXcIMC4aCvxan8QhmlF/x3CxGbHreVjmfuO8nC98S1aft3IPSQrxrTtva8rIx5fLZ0yhQtVg==
X-Received: by 2002:a17:90b:4b8c:b0:2f4:9e8b:6aad with SMTP id 98e67ed59e1d1-2f782b11be1mr67062011a91.0.1737917104654;
        Sun, 26 Jan 2025 10:45:04 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa44cb8sm5414795a91.6.2025.01.26.10.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 10:45:04 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250124185330.1244585-1-ramya.gnanasekar@oss.qualcomm.com>
References: <20250124185330.1244585-1-ramya.gnanasekar@oss.qualcomm.com>
Subject: Re: [PATCH ath-pending 0/3] Support to request pdev, vdev and
 beacon stats
Message-Id: <173791710409.2935553.12305963585380635854.b4-ty@oss.qualcomm.com>
Date: Sun, 26 Jan 2025 10:45:04 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: obn41MxZlgTA4e5xNx9QhmiGel_z2rY9
X-Proofpoint-ORIG-GUID: obn41MxZlgTA4e5xNx9QhmiGel_z2rY9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-26_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxlogscore=876 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501260152


On Sat, 25 Jan 2025 00:23:27 +0530, Ramya Gnanasekar wrote:
> PDEV, VDEV and beacon stats will be maintained in firmware by
> stats module. These stats can be requested by host through
> WMI cmd on demand and can be used for debugging.
> 
> This patch creates debugfs file for each stats which sends
> request to firmware upon read and print the corresponding information.
> 
> [...]

Applied, thanks!

[1/3] wifi: ath12k: Request vdev stats from firmware
      commit: e367c924768b11d28727efbf2a6426c7aef66f0f
[2/3] wifi: ath12k: Request beacon stats from firmware
      commit: 9fe4669ae9193b27d1d4add9a26c82dca9d59da0
[3/3] wifi: ath12k: Request pdev stats from firmware
      commit: b826ad94d89615e222a3682b02adcbe45ecbde0e

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


