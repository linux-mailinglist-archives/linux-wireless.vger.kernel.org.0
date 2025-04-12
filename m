Return-Path: <linux-wireless+bounces-21466-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE221A86AD0
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Apr 2025 06:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5AED9A7DB7
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Apr 2025 04:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95871662E9;
	Sat, 12 Apr 2025 04:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MgCxZjSM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B90F18DB10
	for <linux-wireless@vger.kernel.org>; Sat, 12 Apr 2025 04:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744431857; cv=none; b=C9mzYaSi8Pj6HKC1bPUXJsKQQsM/jR+1l1gHyvBsKp2C9MJBoayl43ceX6ffW5xbFM85iV0PzePrQO5E10vnoRPLMHPXntZAA8vGuFu4aKKggsXKisOqFwPVo12RS7Y/AoYt4Ev54xLk9sQWmt22EH4j7yDnoI7jECg8u6MBX20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744431857; c=relaxed/simple;
	bh=Yj6vLAghIl9hgFKLcSqkN5ChCX2Rcmh+ckIl0ZLDWj0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XKcI/WjeikpVF8xmW1SyxA4vbE3s1tz13Qcz5jVnLlOQnrWVpRsNehFLKQIuWWbyrjRDyYewEsLGN+yaWxH5a01hORiWF/DoWQu05ZFE/BS6/814Zt7CMM/Dv562Yiqur0U+ipC4+n1K+cTu6WkAhwkgi6yBhGXis84bKd1kM+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MgCxZjSM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53C3jnnh018904
	for <linux-wireless@vger.kernel.org>; Sat, 12 Apr 2025 04:24:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y6c+VvP2BLTiwbJsNHMC/15PFH6qteRzoX5JMy9RgRs=; b=MgCxZjSMPZWyGEUa
	iQZhwJx3i736vBATTTWnSetpe9NCFPZy5N7N7onaSof1Ixe8ejb0mRuJrXj5D3Z0
	G/24FoC0sjMTpiz5/1mA6Q3ie5HSzbiwoD+kliJpL4FzcPK2fy1V880pFbUhVl0v
	dfO/SCQ/xh5+9JFMFHGMo9T5kb0XsTb2wo5ojo4EN9SSXWHnK0Gs4H5747NjLV4t
	hrwzfr/yphVU4XCdf1+Vrdw/SaO76jl0+P76Oy1nG6z9hFsTinILbpMJ0mraSShu
	6AimK4zuUtxPTm4NNmk8vPdFPVCatPUqKFaPZI25J14cYvNgQFKq7ST/2qQ/PxYV
	D3/XkQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygd681u8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 12 Apr 2025 04:24:15 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff7f9a0b9bso2191187a91.0
        for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 21:24:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744431854; x=1745036654;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6c+VvP2BLTiwbJsNHMC/15PFH6qteRzoX5JMy9RgRs=;
        b=iFYag0ptOVzaXjg3VDsXyD7Re0uEPO924DYvRX3WJ5MfsIv2I5Qf3WcffsR4pV/2SV
         dv5QM/ngseSnk0LXKyMh4B0UFYX0fTnIUX3HBvzRWdOZc8NGsmaivfQY+gt3EmSUkt/9
         djXQTQ4rzz1NG5hywWA1p6EGju47lxxzX52hdJqzN5ZQEMmUd6khHNrTUEnpgcamsjvx
         5MJqzzbGUM0XLZP213Zb6ZdT7Abch8QlUusyVcP4jRamKJr+NDR1MWVOxVQm/1Au3Y/c
         0hr8O8ZazXnjygRI6cE+IZnsYwca3Hi+0lRDTI4WJRkqxaxm6POXB2wxht1Sd4hMKl8i
         o2Tw==
X-Forwarded-Encrypted: i=1; AJvYcCVPjlrbk1sFkr+/iKyNQSbwNxwCS6XOTXUFChsxbgQ5fpUW2ix4Hialv5Be7fYbN8oUJdxw6y1hkGG6u+gkXg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhuhq2lCXdrAjahdLy/EYbNYTbngc/7kjmsWtt7musKZy1w2nw
	a3/UV4IW8H47GqPyLKMyhWQHPyuXGDaCgnMgPxTRhp12Uqsx0cGD7q+ZD5tLHXZUVXZXV8DaYr4
	Hn1TaEQKDL77b9Sj+e+0MR9++xzLMUIcjj+wb3a1fkemjkCY28TSJCQOtnyclZ2j6Ww==
X-Gm-Gg: ASbGncsMz9PFCFpCCPTp4B980RDDzwXANx1DaS65x7IsF+OTaqIce5DPGCKfwzyznS8
	873ECc+WBBkTN8U+NcR6JNbMRwRjAQ2nmR7TZubPzJ2cEklW0yaAKu+gb9Oj+VlZ4d6fVcSXP+m
	97Ky88e2GvBLtimbvsRGALuaDFtw2LIpT8umzfljwAyx+FvflszmUP5/NFQPg6fXQHCuTchxLYt
	DJXeMkfvo+8V9R0WWgXNIbtdVjemFgyxQ7EcUpsITP5UmWJkStkXpLaT4/hBffXhhMCQpm8hI7H
	SIWWi8wuHAlcWrvXc/xCkCuY+3avH1ogBzGAaiQyTwdL2fPf
X-Received: by 2002:a17:90b:2752:b0:2ff:5e4e:861 with SMTP id 98e67ed59e1d1-308237b52c1mr7682571a91.24.1744431854209;
        Fri, 11 Apr 2025 21:24:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3bEjufM8uvzXi2R+XKSYAounBYRf966QbZ07aJvDs1jVqVY+2eE0x4NE/tknOoj+yN8R4Qw==
X-Received: by 2002:a17:90b:2752:b0:2ff:5e4e:861 with SMTP id 98e67ed59e1d1-308237b52c1mr7682536a91.24.1744431853719;
        Fri, 11 Apr 2025 21:24:13 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd11e643sm6829912a91.12.2025.04.11.21.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 21:24:13 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jeff Johnson <jjohnson@kernel.org>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        Balamurugan S <quic_bselvara@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
In-Reply-To: <937abc74-9648-4c05-a2c3-8db408b3ed9e@stanley.mountain>
References: <937abc74-9648-4c05-a2c3-8db408b3ed9e@stanley.mountain>
Subject: Re: [PATCH next] wifi: ath12k: Fix a couple NULL vs IS_ERR() bugs
Message-Id: <174443185268.2972989.9053090958982417610.b4-ty@oss.qualcomm.com>
Date: Fri, 11 Apr 2025 21:24:12 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: A9s4Lfg_U5F_6hI3sWPbAOikGpeI2wlc
X-Proofpoint-GUID: A9s4Lfg_U5F_6hI3sWPbAOikGpeI2wlc
X-Authority-Analysis: v=2.4 cv=ANaQCy7k c=1 sm=1 tr=0 ts=67f9eaef cx=c_pps a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=0MIO4mkLTHUyxov_fOkA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-12_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=728 suspectscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504120029


On Thu, 10 Apr 2025 19:26:16 +0300, Dan Carpenter wrote:
> The devm_memremap() function returns error pointers on error and the
> ioremap() function returns NULL on error.  The error checking here got
> those flipped around.
> 
> 

Applied, thanks!

[1/1] wifi: ath12k: Fix a couple NULL vs IS_ERR() bugs
      commit: 4703416d0fb993f7505025667f868f6981a5f7ab

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


