Return-Path: <linux-wireless+bounces-26114-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B318CB19A57
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 05:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDE1D174403
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 03:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED5C218EB1;
	Mon,  4 Aug 2025 03:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N9SJJ5ET"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9511FE47C
	for <linux-wireless@vger.kernel.org>; Mon,  4 Aug 2025 03:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754276610; cv=none; b=K2Y63sNq87n18kmc4GGyr1rBw4jRpdIu6ixSOfY9NZ2xjp0hKWxH4WcgqtZQkXc9UwpBNPNtRyKtAx2S+XllFPHdRmR4t8vapySUVXf5Lli8AqSAGI7kQoixnG/xfavAO+wXxyjtVeN8JU001ZcVKg7LGu+M9M5zEKgNFXu+rr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754276610; c=relaxed/simple;
	bh=jQ6Cvrtue83tSPEngot30qNW8YbInIfCiq3W0BOsXyA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hh+fXorWpQvhvygH9EVzYdRi2tcGK3D8ewU/f07W/t9z/D+SvLidNp1wURwj9xdtL5jCDqxei3E9TPAKv5seJuqFv5ByEO0/k2xNaGXGm8S/g+iUJBE4deUj8BxsMKbuDD9ePHdEvtL+0msZWUrNvvWEpFqY2DPekimA6nygI6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N9SJJ5ET; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 573NFASM028976
	for <linux-wireless@vger.kernel.org>; Mon, 4 Aug 2025 03:03:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=jWjl2/LsT3uqPipUgEyDmG
	kvO/8Fme3N41mIfB3Febc=; b=N9SJJ5ETd4G6rz5uzn091+6lFKx7ezo/L5flPw
	cu9gX9/Rv3wmCZJp7dLAh2LFreL3Zg3l1IjIjZFUYuLY+TjgnrAipyn77LpeqJ0m
	dREznokarCkF+MCd/M31r8XblQmKBjXG8mqONk+m6gP/TcY3sGLZvTIlS8oJr50s
	8KT7NbOy41bxp80oMhO3d/OV52qPmYOzKsZqG8kaH/wqfNb+qeRrctm3Qlw18EbV
	Be2rVJy5pHvM3P1Cczkr0xmxcfpBUiq9nqT5dFjY4qqYDSWiEnJVjglP6Pq6DD6L
	HbW4lc1LQWi+KsFDd/jXC9X9VmX+0sD/+b5pKLKxFOGdItCA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48a2ke1c5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 04 Aug 2025 03:03:27 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b3f71e509d6so5502435a12.0
        for <linux-wireless@vger.kernel.org>; Sun, 03 Aug 2025 20:03:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754276607; x=1754881407;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jWjl2/LsT3uqPipUgEyDmGkvO/8Fme3N41mIfB3Febc=;
        b=RbbDtN0TRy1CTk7yjv7TXvWhVLGJmmmDLlEQ1C0JCHboZdFQuZHSWwT5CJxdZGeBTX
         y/mx5rclGMpfeNatAfwaJQo8dv3hBdmiyenD1w+kldvM5U4seCEVukUC8fZvnO5WJcH4
         T4dwYyuVMl0nCoFoyVPZELysX6wVztTjdCf77BcE41gZ5jwRvjVq/fARLaKL+cTCwAAy
         KTG/trKzA7A5rw+3kWGt+O4wttTFjed7ooWP8pg03iWlP0F2w72WjyYiQWhG6IqOKGLP
         y9MrS4p3QnFUzzkjbTi0WOrQ2KoqnFqbP60IaI+abFRED5Xc54Oags8znvm7JMtWOxM2
         V07w==
X-Forwarded-Encrypted: i=1; AJvYcCVZ7F1nWw8b0e4sMu5LObLR0CDzbGkta/d69R3NTQD0hp4EOQR7q9dzIninaEVHq3ByACMLy6Z3camdYnqWsA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt8O0/3FEKakHliTO3pKHcM1kWZEJmbPipumwMIVA1j0No7t16
	5ytqSOYOO/o2Dy6EcxIerPpgEkz99KwLvg5hdpks+0e1jjaDATpbcEiGazGp1RHpgw5876M4mNh
	gjLWCt7AW8R7fWvEk/jynllH2M76qLZxoBjswHSCMRddODqE91TZjByJI7hnz3pW8Rt7POA==
X-Gm-Gg: ASbGncuiWj1qr6WEKC4gOsM+azJ5EwRE70IY/GDC72wmSi42C14en4dt6FcWAQsAVoc
	asMvMnntjktV03T0LrgklTlEYxK+t/kRH/J6YogxX8qqUy4nI9eywuQ+7jwau3z+hQNfllQ33Pk
	UuymXITC8znZHsqkmekARTPIDZBep++5T6KUjJQQ4mFDST4CfvMzxHtHlAbJyYvJFUJjs1SKHZR
	q9XqhUJrMaoVMFCJEBcxpdRvoUpH8luO2FFFoF+vNYH84yDbtc/YhybCZskeg9wi8yTtG+WhP6o
	Zid6YhgWN725yp7ac+bPo746o45PAbvQd5jd/DSwQCYPSEh2ueFyb77jFEG4n54csGL835klln5
	r3jMGULf5hEMr7PSYmw==
X-Received: by 2002:a05:6a20:12ce:b0:232:7628:9968 with SMTP id adf61e73a8af0-23df8f77df9mr10374386637.1.1754276606537;
        Sun, 03 Aug 2025 20:03:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExvnKIZdOLteWnTOv2UyQtya6X6UggYZ9wc54uFCIA0Mg9TiA8q3Xq6Gvkrj+kUO2e9aNNtg==
X-Received: by 2002:a05:6a20:12ce:b0:232:7628:9968 with SMTP id adf61e73a8af0-23df8f77df9mr10374347637.1.1754276606144;
        Sun, 03 Aug 2025 20:03:26 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3207ebc0e79sm10489000a91.10.2025.08.03.20.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 20:03:25 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Subject: [PATCH ath-next 0/2] wifi: ath12k: fix 2 instances of Smatch
 warnings
Date: Mon, 04 Aug 2025 11:03:09 +0800
Message-Id: <20250804-ath12k-fix-smatch-warning-on-6g-vlp-v1-0-56f1e54152ab@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO4ikGgC/52NQQ6CMBREr2K69hN+CS248h7GxacWaIQWW6wYw
 t1tWLvRzSSTmby3sqC90YGdDivzOppgnE0FjwemerKdBnNLnfGcl7lEATT3yO/QmgXCSLPq4UX
 eGtuBsyA6iMMEVEvVVKItCAVLpMnr9N8tF5YAYPUys2taehNm59+7PuK+/2SKCDlUotSoWk25a
 M4uhOzxpEG5ccxS7JrI/0DzhEZZy0YiEqfiC3rbtg/rqKPQQgEAAA==
X-Change-ID: 20250716-ath12k-fix-smatch-warning-on-6g-vlp-a97cb86f3a16
To: Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: w9P6gDuN_AF3fFjLuSzWODYNY9P99qs6
X-Authority-Analysis: v=2.4 cv=TMNFS0la c=1 sm=1 tr=0 ts=689022ff cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=2XfRbQ7RPn6m6gspCJgA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDAxNCBTYWx0ZWRfXzBLGAUOMjcks
 chn4XPS7eK2uZ1vFltHQJg/6HUG8y8EIaOYkCnVftlyRY2ruw5Nou+nEThnqXuAYfsF9RvCHUY3
 X33KJLF0cQpdTieDTZPjjLmuI4Fe2caWOLECs3XY1u+Fr4QRlK03WNnOITaXeIrj81rfHvvtc8o
 1sSoaBZhhzSlvDF6QWmDJoPoHXJ5o2bIzKE5dOf6F6X/PJlYIRmAJyxlARl96dwwG6usejXoUDi
 EFvHzHQAR+x+IbiOZ4NsYGnWTJzVwxzD9NwjrD5oosM8oQ2Etu7F7TGZniG5tHe2OAPd5hQDVvq
 fqn+xaPeqJ00dfSj8CVPfoMcnHuFeb1IuIjeQnmk2EsKDPhwquD+Qw9OPAqPzO9iE9moBW6cFDS
 YhWkhhrfDZI+BLTUz5JoP3ba826hhiP2n12YXsjqhoka5hYI9R6Rzyl/j2bMJZjEfnrZOOMA
X-Proofpoint-GUID: w9P6gDuN_AF3fFjLuSzWODYNY9P99qs6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_01,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=657 bulkscore=0
 priorityscore=1501 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040014

Fix below two Smatch warnings:

1#
drivers/net/wireless/ath/ath12k/mac.c:10069
ath12k_mac_fill_reg_tpc_info() error: uninitialized symbol 'eirp_power'.

2#
drivers/net/wireless/ath/ath12k/mac.c:9812
ath12k_mac_parse_tx_pwr_env() error: buffer overflow 'local_non_psd->power' 5 <= 15
drivers/net/wireless/ath/ath12k/mac.c:9812
ath12k_mac_parse_tx_pwr_env() error: buffer overflow 'reg_non_psd->power' 5 <= 15

Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
Baochen Qiang (2):
      wifi: ath12k: initialize eirp_power before use
      wifi: ath12k: fix overflow warning on num_pwr_levels

 drivers/net/wireless/ath/ath12k/mac.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)
---
base-commit: 4cedae6335644a5858e1bc2c367aedc10482b654
change-id: 20250716-ath12k-fix-smatch-warning-on-6g-vlp-a97cb86f3a16

Best regards,
-- 
Baochen Qiang <baochen.qiang@oss.qualcomm.com>


