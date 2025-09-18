Return-Path: <linux-wireless+bounces-27494-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE6BB8766A
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 01:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8949D1CC08DC
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 23:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0170528B407;
	Thu, 18 Sep 2025 23:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jHgo85CJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4F29443
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 23:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758239244; cv=none; b=AzRXcm/GLjZOJ/Noi4X0EwvaJVnfToYgyIZ9wqGjHSQ2lq2TQMbCrHs/I4qlHVXH+QvXqIBKPIRullGPL833w5FyLmgZRw3M6tOrQCJJ9HO6jAoM2y1P0IW44LC99ousvZth4EhD5yTOMKrvUx3/NQMY59jw3wt9hA0oURq/X80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758239244; c=relaxed/simple;
	bh=ZMsEImO1T2AKhLy8LXR65XHN1soqAQOAMmoxtwMjags=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RzG646StdSsP8J41iW6c4CicenKJM6yJoIIAUa9JP8Xm5k3nrupgvq898PCAhdNQmnwy35twjdw6itCrMt9Wgw1aM8TE43dzEGbO0n9KBgpRWW1GOyx6cXQyEMVef9bdqVhsQ6ceP6QWzEEvBUykaJAFNfNq7b4PwGdSJUe7iW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jHgo85CJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IIP2m7027424
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 23:47:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I9VvUPUVQh+BuTqJ8FxkvH9ic5yM2CzEkTeOHa83Du4=; b=jHgo85CJAuDE+xRl
	LYA+0DUvHuZp45NF1axF/vcwjqXqCs6SS0meJnajA1ivgMM3QOWPALTvbkAfiED+
	jh1noXn0NQcp8OW4hS19Yh4DblrLCoaP0wzbXhKOLCp1VbPBYRXQBgWIzwd7Az0D
	6E6d5jIa9ZcAOQwqBNGZqzuQmEG6eg9ECrlhmUKSY5KJ4aQr6+HwjCh2ujWKqK3v
	/KmFb+Vj+TmjuV1CT6xhBru2ujImFW+bLo7sUSN4bi35F3X7znyB5z+90c9SjF4F
	dKyt+Kj/Z/3N5tjgc+gznYXT1wXrrMUH5578mSWvOf15cYb2geZ6KsAiVr5s3g09
	nL8uJw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxt8ea6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 23:47:22 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2641084fb5aso16004035ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 16:47:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758239241; x=1758844041;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I9VvUPUVQh+BuTqJ8FxkvH9ic5yM2CzEkTeOHa83Du4=;
        b=Ds234sONEMEcJttrHHwfT3Xo9GRkkTlQ4IHRTpwB4Yc29yjixJl4btG5N6Cmg4L8wW
         7Ju7C63/dCJl06brfofbZQu9brhQ+OC+J5zanlhVwG8UBvHFSjSeUp9r11y/bAlYmX4q
         F5OIDKS5pK9dDQXqZh85Z7MjyIojLDAWvO9GV9X07GaODEMT4/KpJFZTqzcFDfE74Zqo
         dNhu9W3CcdS6aykH2ZFNLf9AmasxT+XSWBPOQYhgc7E9zJS6N7KIfSbD///+tT5dhdv8
         5QOoOyxZue63lUds7udgO8JITLrkJDT/6ILU77olsWI7akJf5hIkyos7tla4XobtAtiP
         aYAg==
X-Gm-Message-State: AOJu0YwCwOFhViWaAnioGljAA37T1QXCoz6JFTA0cgHO79J9yxvItaKL
	Nsk5zOsIEDPJZVD25ouotFkgcEROC4IBtyLOlgKPARqhRwHuFPuGhRyU0TkfoQwzkyT4d9pSNS0
	V0LJqPvn/Eip7/YXUoXUzoPcghL20X+NuX3+uLysckwvO6SDk6TlucDQq16Kq+YayPJFQe7Qt2B
	26sQ==
X-Gm-Gg: ASbGnctrZhg0h4zpFjz9Qk3OQIXSe1l1tEwj02f7/eMW7XvX311Mzofk0Tq4CxKMP5Y
	GIAgS4ksjRAA/7wwy3EM91+NQwgvuQZw8hiaE1y1ziKG8/6iBOORhUr6BL41SOzXOI9VYKFmr28
	2kLWS0k6CD/uP0LJuxCs7vix5bvVbtBTxmpZYRupNG3beffxHgRtcaka4RYZXhSk2q+BKrXApHx
	7QrHXYGM+h/zrCMeohW+GgmiGN9LWlUfVse+SBO0AuTIeRFMv9oT0z6t0AbG3EV9qBZWYGV8SkC
	K0FQ8wVg6NTZvfUO1PtH4EVitK9vyriYOhlFFaC8T9qUpjKGLKe5erPK5Im/hqDPL7Aut4lZ1Z2
	C
X-Received: by 2002:a17:902:ecd1:b0:267:af07:6528 with SMTP id d9443c01a7336-269ba50848bmr18339815ad.35.1758239241388;
        Thu, 18 Sep 2025 16:47:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmDrSiEHLdRTJZ8d//te6Sl23OAe9Ed7ZGshB9Ih1576AsbgyQ4dbjzo3oY6Isu1jHsx8rAw==
X-Received: by 2002:a17:902:ecd1:b0:267:af07:6528 with SMTP id d9443c01a7336-269ba50848bmr18339615ad.35.1758239240965;
        Thu, 18 Sep 2025 16:47:20 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269aa71c928sm16474705ad.107.2025.09.18.16.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 16:47:20 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Kang Yang <kang.yang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250722095934.67-1-kang.yang@oss.qualcomm.com>
References: <20250722095934.67-1-kang.yang@oss.qualcomm.com>
Subject: Re: [PATCH ath-next 0/3] wifi: ath12k: monitor mode fixes
Message-Id: <175823923998.3217488.6011123637670407753.b4-ty@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 16:47:19 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: 6yZZkXpCzGyYMQrYltpWvcE0YBDBTfvY
X-Authority-Analysis: v=2.4 cv=bIMWIO+Z c=1 sm=1 tr=0 ts=68cc9a0a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=-ZAtyTsNoej9e0GDpi0A:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX58dubPUDCiMV
 I87iY1MYLRieBX7guN3igkBd+nKigC10EEqRn6Zv2LK1/9fNRgIG8gbpQivqEEav3OJCldRYxjM
 2v3dEMMLIMlU9O1t1EX3Dir04pnmxPfiPWZtTRhmgMEAkNmCvKTJcBTHBv/6hOQjrFLYGVuIsUu
 w058Vj2mdmM8E3fOfh6rvtlObQ8DSBjBhnik1xJ2ruCITrUFvRyHExSyEB6t1Lq1yDsFQDSqj8c
 uRB6uSGMSFJ/U2IvMnnQCaxqBIrPKN8QMR8nszvTZP6IBBIbfAkz6NB244VPInX4oK82oxeae3s
 7gcN6iU9y+jArrZSAAk1Xj7Nb4lvKKJ8G81E5J4qyxxejeixUDURY2JWsyqgBt0Yd4qF0W9iH55
 KmE/aqVu
X-Proofpoint-ORIG-GUID: 6yZZkXpCzGyYMQrYltpWvcE0YBDBTfvY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202


On Tue, 22 Jul 2025 17:59:31 +0800, Kang Yang wrote:
> This patch-set includes three nit fixes for monitor mode.
> 
> Kang Yang (3):
>   wifi: ath12k: fix signal in radiotap for WCN7850
>   wifi: ath12k: fix HAL_PHYRX_COMMON_USER_INFO handling in monitor mode
>   wifi: ath12k: fix the fetching of combined rssi
> 
> [...]

Applied, thanks!

[1/3] wifi: ath12k: fix signal in radiotap for WCN7850
      commit: cf412ae7b7124e2b3bfe472616ec24b117b6008a
[2/3] wifi: ath12k: fix HAL_PHYRX_COMMON_USER_INFO handling in monitor mode
      commit: 6b46e85129185ec076f9c3bd2813dfd2f968522b
[3/3] wifi: ath12k: fix the fetching of combined rssi
      commit: 7695fa71c1d50a375e54426421acbc8d457bc5a3

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


