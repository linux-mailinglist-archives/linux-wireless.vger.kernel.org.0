Return-Path: <linux-wireless+bounces-26979-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 574A2B42AE6
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Sep 2025 22:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F368D168019
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Sep 2025 20:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CEF2E1C79;
	Wed,  3 Sep 2025 20:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Udoje8NF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F704C9D
	for <linux-wireless@vger.kernel.org>; Wed,  3 Sep 2025 20:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756931370; cv=none; b=H2fxXbCCjDWPr6+JWM6x1b8VoRv0rKtSFGl26MFeaxnGDwznK32LB8vN2i+vtYvvh86eKguQvBdPZR7D+4FKYif/Wang0NWWVluwolDquGuDH+V7b1aaNdaYoP56SZWtP+e8/f7kOb1e6iTdinRyP8Egma506uXc4hApac8511w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756931370; c=relaxed/simple;
	bh=rcetew9JH+eLNRPG9DpIcxIXPhxEiPAnzeD4bX+mwVQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=hz2gl39XpCEBkYvcyMognoFrAmh9E0sDEB+BJvifL20+wlI/zKVyOTu1YGOSO5crJuvdk5d59d3FvjwOYCjwYwhqQfPq7+lKPYKii1/Jloy28tSeMaabOhc68WS5K+jNTds0ldFQyxVMXsJTVC2WzCN3P2L8u/1U+W0LmSQHvrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Udoje8NF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583Dx2Ki030111
	for <linux-wireless@vger.kernel.org>; Wed, 3 Sep 2025 20:29:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=LXrcTy7G0WcV6Osu/tYiTb
	Rx7MyQDw5VIaQZZFiljHU=; b=Udoje8NFvTCS7UJX7uZAMSr3ASXQgQs6wweMUu
	CD+tp4g3ULUA57kTcsHbkq4jKH1v5RkAUCMFdZXYcUCR/PV7Xe7RIHf9RjEElWTa
	cFUYdFWWIg9Rtm+3H8lUz6HTRIIha8nD0MgsB7JM3FyPkq3yDrEXGVg4WBTcGkrl
	4Vg2iQI8+JY4besC1fK+w3EXExsfkXI9TAXWD0T5NUWgXcZCt14NOfBMdmMzjqwS
	sVc7u7Pph3UqPvrgcbaqJYmFKvZl3849C1d18fYh4YD4P5PpeetymZqPtqiN5Tk3
	YvK/dOJSOmcZsoNYlUvTKNZ9NDS7ohBBhF8rLLBa7A5FEZbA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnpd83m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 03 Sep 2025 20:29:28 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b4d7b23ad44so152325a12.0
        for <linux-wireless@vger.kernel.org>; Wed, 03 Sep 2025 13:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756931367; x=1757536167;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LXrcTy7G0WcV6Osu/tYiTbRx7MyQDw5VIaQZZFiljHU=;
        b=nOIDx/XUY+2Wiy7q/HTmFEQ5T3tjmwi+AzuhZZrglfwOCC3V3JY8KMzj0t7MLwtoXW
         ENkDGuBmSAGWJjSOLBjZeDiNUXAdZP8YynOoak9hswjpoyHLkAM66O39qM40LC57/MlB
         8g4b/YWbPizBg3vJaoMz/CuajLBjFTVNSWvAxz5CCdu7IWbOA8DFB0UR6CvOQDdBxHnT
         LeKeTxFah3JzPgIb5IQA/FtN3QTCMzNwSIArHSL8R1q6NO5eCkjSHAfTke2nsVIDnNCf
         I6lbNfpMoSNs5L44iBYe9ivCekMozfu7ZsUBklbIAFCdaN2dUk4d4gRLqomt09hoL3S1
         tlVQ==
X-Gm-Message-State: AOJu0YzlwJvvxgeuFPWcK7r86EeV5owEsbn8GJ1UZ0Hy/EpAKKopeXoW
	zBBhQ3WXFXbg7vgWYavr1LhFsPADEZjtjn2T9CYWXfil09L4RndZ9q8pp2r6s/oAbthuCuP7fqh
	QOB3KjfsIU0kRWjOql0T3wO+nGP0V7W/RcUmhfsJzx7A9mlILPze9H4vr9VdcIHnnzDvKyQ==
X-Gm-Gg: ASbGnctrPph5Z5L+ygAE12fdTgfu8EjDGhpqYAo8CJTMBiuyNQCEXavJjqURXQiwZy4
	MSLi0C4HyGBjLvwptuWRqrJtBiEzM1Al3lNwJXxx3oCZ94x56IaHjvi97Zk6U5k6VAnorf77JOh
	ZikyW1j9JhM2dJlCjeyMPCgy2m2od43T0vNGVAl2MdUX7VXpTiE9IG5rbvQJ8YxsqdltNkqGeA7
	CMuNLF3r8QhCmETQgWTEWWm7EmAbpdQZhXFDIRLW3xt0TJyJQq1Q+qbb4O5MenMBPg3rNuq5xV/
	70DZnbcIFEriGOnmHpHG6ZpuvzP60qYdiRnd81/VABl2PWbCfUebp3iTQbGCUxCQfFbzs/8RI3M
	r
X-Received: by 2002:a05:6a20:3c89:b0:243:9824:26f7 with SMTP id adf61e73a8af0-243d6f3b99dmr22327984637.43.1756931366776;
        Wed, 03 Sep 2025 13:29:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWLCFA4e3h2HULrJci/u2sRbtYBFqxTbsBEzYXySZPoSiJ1k5AIwMaAZVutQz8XDR/THEIsA==
X-Received: by 2002:a05:6a20:3c89:b0:243:9824:26f7 with SMTP id adf61e73a8af0-243d6f3b99dmr22327968637.43.1756931366275;
        Wed, 03 Sep 2025 13:29:26 -0700 (PDT)
Received: from [10.81.24.74] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772409e1e65sm13711254b3a.101.2025.09.03.13.29.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 13:29:25 -0700 (PDT)
Message-ID: <3d942fb1-e7dc-41cd-885e-a610bfcf856e@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 13:29:24 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-firmware@kernel.org
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        jjohnson@kernel.org
Subject: [PULL linux-firmware] ath12k firmware ath-20250903
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: T3A7vq_9F_xDJVnN-fjKyB5a0KiC0rmF
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b8a528 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=qVH1Mreu5pg5mNMOoWQA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: T3A7vq_9F_xDJVnN-fjKyB5a0KiC0rmF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfX3h1HLlzPaO0J
 jADiFhaU8vY3D+EOxECTNHTez4dIng4pQZoS7BxSZyuqd/Guj1u0T2s/URtPFkcJwaIzXZwufKH
 QMHSaE2HduYxWhntChtDhuRXRB1bGObu3K6C8DFb3sTpo1+ZYpqnkfU6yK52brDnPMsFmJ1dpiG
 8QvuyoxBbS2mNABB9zKcLO3hdvTvmGTgvbsKXC5RuIVIGu1T0bk79P4VOTQhVMDvOQBAimSIXW6
 1Xje6EKFP7WOZUqALLf9NV3MH2Xq22EkPWv5kQpcWc+U2anG+1IYNh88nTJGK8itqAdOXba09Bq
 Mh6yf4OfwLvcjfhFDw1dKW8hykYpVojh1Z+/cKbFgrMM4HheaXJcKRc/ItVVnqGS0p6vp1w1T21
 kZLMq1hi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_10,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001

The following changes since commit 7d59b255fba6e1c3a4b7814c028cb9f8e83e14e8:

  Merge branch 'mt7925' into 'main' (2025-09-03 15:36:06 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/linux-firmware.git ath-20250903

for you to fetch changes up to 1c44d84a08bf0dfec147db6637aff593d7195b0c:

  ath12k: WCN7850 hw2.0@ncm865: add to WLAN.IOE_HMT.1.1-00018-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1 (2025-09-03 13:23:20 -0700)

----------------------------------------------------------------
Jeff Johnson (1):
      ath12k: WCN7850 hw2.0@ncm865: add to WLAN.IOE_HMT.1.1-00018-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1

 WHENCE                                 |    4 +
 ath12k/WCN7850/hw2.0/ncm865/Notice.txt | 3386 ++++++++++++++++++++++++++++++++
 ath12k/WCN7850/hw2.0/ncm865/amss.bin   |  Bin 0 -> 6111296 bytes
 ath12k/WCN7850/hw2.0/ncm865/m3.bin     |  Bin 0 -> 299660 bytes
 4 files changed, 3390 insertions(+)
 create mode 100644 ath12k/WCN7850/hw2.0/ncm865/Notice.txt
 create mode 100644 ath12k/WCN7850/hw2.0/ncm865/amss.bin
 create mode 100644 ath12k/WCN7850/hw2.0/ncm865/m3.bin

