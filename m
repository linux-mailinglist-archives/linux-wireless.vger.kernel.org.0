Return-Path: <linux-wireless+bounces-19504-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BEAA46F03
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 00:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 669EF3AD4B7
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 23:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C5925E829;
	Wed, 26 Feb 2025 23:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="izyuXY87"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F322925E828
	for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 23:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740611325; cv=none; b=nSNXSqnjnop8NCj+3JWTgVT9hUUQvlauNcuWYU/SklkrV4WzSYKip20LMoSVz4HR/DWkXgO2BEHdxTbXHmg3vayednZRqbYFPuU89lx18LJ7zZ95WtbEU9n6ZnBGrfqTPu0wvBZLhlPTQiH+lbnGo+xOeBzLEzL8Oboh64SDwFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740611325; c=relaxed/simple;
	bh=POMMSzqvvjExgB9qehx/F7xnhMNm45UCVX/22J7A7lQ=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=YfrtJoVMUZl6Ozxn8TL52pj8DrayROby+MPE1LqRgAUWVWYW9xNAa6y2Kn68EvLR40k18BiC31GZmXmAgIo2LLdmAgfwWevQt6BNaiP184ai/RnIQBG6s/OTXhOY4g2M8k5j5zBhvd5Wnw22+U1/pm6nlYP8Unju3kkpjqbX5js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=izyuXY87; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QLgpa2013437
	for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 23:08:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=LTBZs9SF4fpm2lgn+jTmnQ
	7wDyI4IyFnmtDMU4kFjVg=; b=izyuXY8776lZXRZGYb+le/PtTC30f8Ensm5VI5
	mJvjWtXReWm2xUzkV2SEfSZFiLKznBWj6E/lp/m4PjdJoO3iFaXJIyNJg8F42iqa
	DyIRiqQB0sHzfj7AjtxSS18kIg/LYD6DqGJLHDuqy24oKlF41nop0apyYwgPCeL/
	xL9RVugCRksJIWQM7oMopws4Fx9B8Z/Lyo+aN9iS+2HzOuxu/80Q5aI0ro2FwrdH
	Paaz3h6IBanH5ibL0Oup7G4XNUhTLRz1YS4lnuzPvBfcYAI/Xi2241Q3XpltTQhT
	xJUuVcF3qp5RH4FbZWK1zYSENewpHi6zgtwAFd/qG9FH/LzQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prk3jbh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 23:08:42 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2f83e54432dso1055978a91.2
        for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 15:08:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740611321; x=1741216121;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LTBZs9SF4fpm2lgn+jTmnQ7wDyI4IyFnmtDMU4kFjVg=;
        b=YdPMjbUaDP3WCNe9LWbfd+XYxU2I1S1IBmZaS4yqCSwr+hJookeTyL16urjg7ZWt+2
         gIyR1yusH8XAHWenuZoYGgIDlqReRE6aRbFDITS6Ae5h1xrRJ5G2ddN9e84pN3ZjRSRk
         O0IRVslUQ24kVtxoTePOVzcD33KGSrTztggYLtoR8cn0hq+A4XVVfL/F+7O4VcYqoIlK
         OxenNO8B5G0i5bxiiXzwkupzbHe7s23V/vMrpw87SqpZig15m1RbLeU9BOUU/VRnsKca
         3M21doAglJccJynrvJV6ICbVmSqmu0bqOhl36m170XAHVp++HdkRYpUNmiY2cqluG+pU
         t4Fw==
X-Gm-Message-State: AOJu0YyHIuiPNYHfxIIwKRL9hbDKjIYnbFyEgP7eDWA3JOr0r70uPQca
	NzatcDzFuGqdrBK+WbTikebcEQTDdqFilMbzSUhesq/UzqRUYl7l9oCL3dBHp4QPk+6vTr855Ej
	/4oB7kVUjYwlDcoauSzfA8BG3SPeVwMwj+i+FRs4mSlpmGiy9mjbG3xAlNyp5qyyTZQ==
X-Gm-Gg: ASbGnctquuD8Q4KLwTx8y7ta4t+LY9qSHIHJYMRqc6l0u1eVCvuvxEXHpdh/GqcvBlT
	hJZGjgeNfh4W8BHEhEIvW+vX7WIZV7MWnL4MjKV+wWatzGUjjgBCve46uuYYGzRYZP1KrUkrqWy
	4y35ROqFCGvpD87cvZrD6s7a/62F5AHIOOifY6JItGG6H+QPv39G/+b+GQnwP7/bwbHgTblG4mD
	ks6Eb4ULpQYr23VpUH/B81oEffRZ8KzGeMYnoTz6JK6o7j0rxlx7bfKs59AwuEtDzOX+xFRbIAO
	ukPtk/8XAOCcCcuu3dDFX1FRGMkH2D2LjHiAtucPneUbzB8/Gvq4VrQETDy+yETyfAeAopratUj
	Y9Ka5M6V2
X-Received: by 2002:a17:90b:2801:b0:2ee:45fd:34f2 with SMTP id 98e67ed59e1d1-2fe7e2e9383mr7619626a91.6.1740611321175;
        Wed, 26 Feb 2025 15:08:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHi7qZNiX0sKtWPTcuB/eIr8dt0T1qi6fJxqj6hhLa0VCjr9ZSHqkY938CIh8bXwMOThPw/zg==
X-Received: by 2002:a17:90b:2801:b0:2ee:45fd:34f2 with SMTP id 98e67ed59e1d1-2fe7e2e9383mr7619600a91.6.1740611320838;
        Wed, 26 Feb 2025 15:08:40 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fea6752095sm115827a91.1.2025.02.26.15.08.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 15:08:40 -0800 (PST)
Message-ID: <74b29af1-4024-4636-af8f-a95fa0f3601e@oss.qualcomm.com>
Date: Wed, 26 Feb 2025 15:08:39 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: linux-firmware@kernel.org
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org
Subject: [PULL linux-firmware] ath10k, ath11k and ath12k firmware 20250226
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 0djZpnz1wKBudSvDf0IEGvpZoZrbIsSI
X-Proofpoint-ORIG-GUID: 0djZpnz1wKBudSvDf0IEGvpZoZrbIsSI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_07,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 phishscore=0 spamscore=0 mlxscore=0 mlxlogscore=855 malwarescore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260180

Hi,
Here's a new pull request for ath10k, ath11k and ath12k.

This request only touches ath11k, and adds new firmware and board file for 
QCA6698AQ hw2.1 and new microcode for QCA6698AQ.

Please let me know if there are any problems.

/jeff


The following changes since commit 1a1470d90de2a25e5befadb2f1fa30758af682ca:

  Merge branch 'robot/pr-0-1740366711' into 'main' (2025-02-24 05:26:03 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/linux-firmware.git ath-20250226

for you to fetch changes up to 811bb52b1d293c3a9641c8747c8963ade18b7e81:

  ath11k: QCN9074 hw1.0: update to WLAN.HK.2.9.0.1-02175-QCAHKSWPL_SILICONZ-2 (2025-02-26 14:53:32 -0800)

----------------------------------------------------------------
Jeff Johnson (3):
      ath11k: QCA6698AQ hw2.1: update board-2.bin
      ath11k: QCA6698AQ hw2.1: update to WLAN.HSP.1.1-04604-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1
      ath11k: QCN9074 hw1.0: update to WLAN.HK.2.9.0.1-02175-QCAHKSWPL_SILICONZ-2

 WHENCE                             |   5 +++--
 ath11k/QCA6698AQ/hw2.1/amss.bin    | Bin 5132288 -> 5140480 bytes
 ath11k/QCA6698AQ/hw2.1/board-2.bin | Bin 866120 -> 986384 bytes
 ath11k/QCA6698AQ/hw2.1/m3.bin      | Bin 266684 -> 266684 bytes
 ath11k/QCN9074/hw1.0/.notice       |   4 ++++
 ath11k/QCN9074/hw1.0/m3.bin        | Bin 340108 -> 340108 bytes
 6 files changed, 7 insertions(+), 2 deletions(-)
 create mode 100644 ath11k/QCN9074/hw1.0/.notice

