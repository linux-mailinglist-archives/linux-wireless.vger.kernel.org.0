Return-Path: <linux-wireless+bounces-27502-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8012B8769A
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 01:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47C351CC0AAC
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 23:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE37A3002A0;
	Thu, 18 Sep 2025 23:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bvjwd8I8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3523E2FE573
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 23:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758239253; cv=none; b=gyiuvQMAeP/qCOTFJHNgF1tLqVU9Tjm0acSTPNLqUldDhjpyT11fL/B3p8xvzjIOpmQOVk1GamU9KRsAva5c3au5h+mG+hzha6ZGZ3hsY1MKuf+Iq2KJ/tIrra85X4Oe7gFESHk2ZjOIzSkEUqQby9AY3Wye1SAOSdp6vDtjNZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758239253; c=relaxed/simple;
	bh=FE9WKDnStzQmEVyyf74wLnX9LdG0gSdCMIk2mR/QV+M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Pij45TAXt7RWc9v6TbJopIr1T1uqetdByww7Wk7gxw+i7BKdI8BezFKnmSZfnJtOyRw25r20E7FjQLAhN76kyrqoIZJnhkBSDq7/1GaH77RF47uZRsVC3q5LgAT/VVPCCbSEJL40KV6UffSEBWTgmC56eDMMxXkj5+tsy/JuXww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bvjwd8I8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IIEELu032419
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 23:47:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k7BUL5WFGP2YT/N3fY2hMgyQNzXJsvjtuAs66ZMXNm0=; b=Bvjwd8I85dPXOiIu
	/gbVvDC4mNGSSCNLAzSv8Zb0yaTXCyiN++J+zuTcGN60FdO/CMbjrl77LW/5tifu
	K+K7CwSRksKKKsozWy0Va0aaRhtAaQtn1EvQmo1wehP+0WcwBAoPcBXgunjuRasq
	Cq1HQddTtZcAGvRKEhV99fb3FmPLgkillJR37dOYtKU8s9kYXg9IvoHsrs0+SDJe
	+6Zy5necO5wTiWzgHzhzzwVcuQRAoWJ2EGbPS4pMNkD8E/GkpNZrYwopKRPpeTe8
	nxqytdRq8oEEOLKiqnE+48wNuXJCMzgbyWGkxjbAe0SIXy9KRtqq+Uc+xSBoBM59
	07uLBg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxyrd3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 23:47:31 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-269af520712so8275915ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 16:47:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758239251; x=1758844051;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k7BUL5WFGP2YT/N3fY2hMgyQNzXJsvjtuAs66ZMXNm0=;
        b=UxAhwix1e+IvzTEZL4UzH5iaXFVZKL+ngEE59sMZWintNlyVCpWssiX0Kwj/rFoQl1
         T+47wzu6WRtp/NgEjxlKlI1No84rYW7DtUQBMOAPjHiS6UgFoEkqt4o2oL4PGtYTgO0l
         lFCzh1y1jYzT0Fcmvx0CoumrgCn9MaR19e5hu4foV2rV1p2IZS7Cdfr+VS4HsUqEZ6uM
         bVOsFM0QbZpDjiY7NN9uvObR6BKZhAdaEkgvXm2RY9wtvSSQZqsOi3YItHkC6NpaYMAz
         x4+MJFX13ZglFS0VFnGRA1eqoUyPU4c5nAPTOjbtuc56OQpdb/Xv7eYoe2p5ZP2tE7ZO
         lSig==
X-Gm-Message-State: AOJu0YzkdoWqpsbTa2OMfDgXMoOEUVuR7m7K0+gC/s2PIBkjVBn6n5Dq
	7Y7cZ6BuK8tf95LsPiagw/bXZiUuaU3+esq9nFB6Y+RfVsUEYrUnEgyix9g5x7m24geqGoIN/CK
	MwHPYYajcPIIOZF5cAPfoVpL/Lf0SpBRZPN+1yV7qhrkYJy0Lj6ZFl3IJMXVNzqOXI8g0Sxrl5J
	GaHw==
X-Gm-Gg: ASbGncu4hYuYJuowexppB26rP3KgzOkz6hoHqeSE56R58nbPTH5XEp7NOho7sehsrhO
	O3M21XHvZjUS0nmFYOMMXIuXvTLv4P8SmVaza6XKADe+gXR07k50PbFvB85aGt9Mw70P+mDEPj9
	aynOlviBEqv5HnPIJpowPTCu7o1qz35b4Y2G5+7NmK+EIqhv57L0iRz7XM9z3yKfaWpHp+erL1F
	cLNRqCiYWv3y9w7Ve2ckIrgDwUhVV7geBqk8afX68TCZhEXrqug0BqaEVKSBIdyErahisvqPVWm
	EjHyzDttcTykkVZr4r0mj2pjPw2EzIJuNBAdVk1S3Da7n2f8zfWF1qch3LiYpO6DUPfBouIm89F
	u
X-Received: by 2002:a17:902:ccca:b0:269:9ee8:c266 with SMTP id d9443c01a7336-269ba42f618mr16652585ad.15.1758239250588;
        Thu, 18 Sep 2025 16:47:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6/OxCokP2hr0JAvIxfPj6tiliayLQbpd7ErGdUGe3FDYwtIAUDI8h4QWedI7XAZp9jBX0QA==
X-Received: by 2002:a17:902:ccca:b0:269:9ee8:c266 with SMTP id d9443c01a7336-269ba42f618mr16652315ad.15.1758239250124;
        Thu, 18 Sep 2025 16:47:30 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269aa71c928sm16474705ad.107.2025.09.18.16.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 16:47:29 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: jjohnson@kernel.org, Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        alexey.klimov@linaro.org, johannes@sipsolutions.net
In-Reply-To: <20250902143225.837487-1-loic.poulain@oss.qualcomm.com>
References: <20250902143225.837487-1-loic.poulain@oss.qualcomm.com>
Subject: Re: [PATCH ath-current v2] wifi: ath10k: Fix connection after GTK
 rekeying
Message-Id: <175823924944.3217488.582935299158112582.b4-ty@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 16:47:29 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=e50GSbp/ c=1 sm=1 tr=0 ts=68cc9a13 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=7VOeSdthuVJ_qekzPdAA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: DGS0KHf68ZTlKmYoeE5LJIhYDtYYxqSP
X-Proofpoint-ORIG-GUID: DGS0KHf68ZTlKmYoeE5LJIhYDtYYxqSP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX/W9HnBL98XIa
 ugNmuGoSZ/zu73MeZOQHrMYdY5a0sqJtFWEIlUs+4mB7OKgiXihsTeieRpGTT1cNR2mc9tZLpdO
 hmCKgEAW4RAzXQMp9KVHMR3Gflg1Rb5cukEMygCOHiAWURHotN9aXpXM+yuEq74YWQ6If/8/hhD
 LXOhlzKJ7JbDlxO5vW+nizjiMSWS2XKWxkGMZ/NCGZmC2rLeYNa5kE7W1ekrPwXlK6tuMRkfrPE
 ZPH1duL7iteRZ8TFy8wxDo10BZorPsIt6h0xv3rG5R2dUenzjQ9w2qx0GBjN4hCz4leTtpUCdEB
 3/Vc4zM0u7qMXP8A6AoIrKDkNBYo/k2DqL96yXaiIh5IQlr1yxHJgV7n4OBWr32rau2E6JZ4033
 WuKX8BQb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202


On Tue, 02 Sep 2025 16:32:25 +0200, Loic Poulain wrote:
> It appears that not all hardware/firmware implementations support
> group key deletion correctly, which can lead to connection hangs
> and deauthentication following GTK rekeying (delete and install).
> 
> To avoid this issue, instead of attempting to delete the key using
> the special WMI_CIPHER_NONE value, we now replace the key with an
> invalid (random) value.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath10k: Fix connection after GTK rekeying
      commit: 487e8a8c3421df0af3707e54c7e069f1d89cbda7

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


