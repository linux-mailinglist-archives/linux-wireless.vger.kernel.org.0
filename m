Return-Path: <linux-wireless+bounces-23821-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B760CAD0DFD
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Jun 2025 16:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71CF516FFE3
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Jun 2025 14:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7B51B4247;
	Sat,  7 Jun 2025 14:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eWzanx+y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3041D63E1
	for <linux-wireless@vger.kernel.org>; Sat,  7 Jun 2025 14:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749307444; cv=none; b=HU2O/eJC7+WtF8EzdhcFkmlvzIXSV0OFwWyC5z4KnHXVAuTri8564fT0en8eeCjGHj+5pKFcwOz1XvxABGhZAye43L06KkWuWzt8DHYYBfVbuJVXhMUH3OVOxZgl1/KMEwU7ganjyj3rTqVJkYwGg7D4GQuNRKI5l5nCHaw69nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749307444; c=relaxed/simple;
	bh=ewzZF0J7/DZonwursmCEtm0RHlCVFvNmgFtZqsj8nyU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ciZoE/Y+7CMOuLg9RlowaP3qRaKVS78M7EgcaUczhMXB1AU3Mzq+pRPwC/ktSIW+2M7EnKY1FKeZZzr7gBNS65NgjsrwE9IqPUcuzAny97mbbOZROCAKQjGWjsn7rKKKG167HjKJP4+UinBl12qz81JkgYhB6EwhwA8VJ694M7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eWzanx+y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 557AjtoO008022
	for <linux-wireless@vger.kernel.org>; Sat, 7 Jun 2025 14:44:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hXtbf2FReKIjetqhu5D3Z6E7g4OFjvzRCOjUzDZ67dE=; b=eWzanx+ySU3YOt3B
	IDM62QVglaMWYaxUAU4Ym8ggXg7FwIuz2UowZW76Dwf9HAlUD4GKf6E/3sdrDnuV
	l5zROR0iS7KYtokyRf9casQP82Wu6wQlF6jmxyUqUGSfSkYSlxR21bgXMsL2N/ug
	iPaphVxV8H9zKjJLkQmMTWP1kaz6qQ0D+uPxngSo4gLOUlIPoovrsaOx1SU2lxT9
	9PuP2pHsZA4N203tIUue3XxAiTmWPMpVjaKuGSHB3PxDwFGPxZJmqM1u2rUpPix4
	PCIg5mc5uHWJ33uGpmvMt6Iwde7nQFx7x+8IMxxyK9xU9llymZWhXzXwxrGFEfpP
	zaTEaw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474crkrrs7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 07 Jun 2025 14:44:01 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b2c36951518so2504701a12.2
        for <linux-wireless@vger.kernel.org>; Sat, 07 Jun 2025 07:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749307440; x=1749912240;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hXtbf2FReKIjetqhu5D3Z6E7g4OFjvzRCOjUzDZ67dE=;
        b=fDjikdvSC41FVzThshUFpjAs1U4+g7dFTEfkqzf1TN3fm224GW+r5Pzb+YgG4VXDf4
         sPFsCUTs9zgTUDMy+P/qHoh1aG+P6+40hjlikPOgwP+7PfdkJmSGooSHl2UTJGHqutOs
         gWRdoNvhgSGlH86CIcyuIUaNbDiiPTz6m4AfBZ1ro6tcDWmUp7J4MneBU+6/t3/V/Xmn
         J9Gg6gO6OjaMO3rT7EsEUP2IAHauXHE+i0qwx+SlKZPy97i1cn719HeD57OaKPYoXLcS
         ZKDGGpVX9GhT5Q1xlWAX6dCos5BO4GF44DUHtt87aL9TaKJ6QvAmVxkGNUrcvk8a2pl2
         oqyw==
X-Gm-Message-State: AOJu0YyYILZ2fUgZk9TGfxRab+kEA0YAp/iSCF/0LWwsC+wIioC1bDdc
	CPPI4fX8JWV996aI4lmW+v2RagJxfLqZhPGLOLvcZnkrYp3ftDp1ul7bbwZ5Y0U9jK/mLCWTLJe
	N7mgao7B79sJ6YoYjvwecizpj/pSiKiXSddmKhQCNhp80h2Y0a+NoWr6MGfVMbG6jsV6VM+WRnj
	DRtg==
X-Gm-Gg: ASbGncshhMyVi+bvIoQz3wPL8+QorJa80rCjSilJgdzi2+8vd3W4AK3D2OxTgMLRF0/
	PzbNcZI5blaNIgNdGfYL8yYqLikjOyVTapExH/a2j/G/CIuHFZcpfZ1wwhwQBiwp76zM4YKr2lD
	1lQFdSF53BNpZNjOPkW1snTcpEvqs+0fwDcGKwcvCZ/lYXThfjTNX3fqSK7D+YfHMODv/PtzuvH
	r61HzRxHU85Ngiss6A8se440bkxPeWqxR17FbLSW5DIoKGpqzeP/66AQgR2cEko4A9J47kLVxRb
	MkfzWWjaI7uMnqqFwko0D5jaYIydXj9+94BBtOJLnDfm4RmqCjU8MHbW9lA=
X-Received: by 2002:a17:903:244c:b0:235:866:9fac with SMTP id d9443c01a7336-23601cf0a49mr110758225ad.2.1749307440322;
        Sat, 07 Jun 2025 07:44:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/VLorjX5BRI7TPNkX+9tONq7W/NhEOTC641u+2FOWimaNRu3FAHD9MQK+1OaYFNYuD+yyEg==
X-Received: by 2002:a17:903:244c:b0:235:866:9fac with SMTP id d9443c01a7336-23601cf0a49mr110758015ad.2.1749307439948;
        Sat, 07 Jun 2025 07:43:59 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236030969ebsm27626415ad.72.2025.06.07.07.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jun 2025 07:43:59 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath11k@lists.infradead.org, Baochen Qiang <quic_bqiang@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250220082448.31039-1-quic_bqiang@quicinc.com>
References: <20250220082448.31039-1-quic_bqiang@quicinc.com>
Subject: Re: [PATCH v2 0/7] wifi: ath11k: fixes and refactor to firmware
 stats related functions
Message-Id: <174930743885.154748.16215131311907953495.b4-ty@oss.qualcomm.com>
Date: Sat, 07 Jun 2025 07:43:58 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=dsLbC0g4 c=1 sm=1 tr=0 ts=68445031 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=ZLGELXoPAAAA:8
 a=EUspDBNiAAAA:8 a=7-MSMrdUUGO4ovTuh0kA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=CFiPc5v16LZhaT-MVE1c:22
X-Proofpoint-GUID: pRirtuckh53O7z2B1uVcSQNAz2ADEM1A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA3MDEwNiBTYWx0ZWRfXxsNqUK0JONfs
 9qFlw2ZDFYmWiSoveqwYP4TQ4t57M+enPam2RaEpl0/H0KMGZsoAmZ4cwhDUWaQZg7jY+C3RhlT
 ckAzGgMj9dW8SmimbRbXlaiGTmv593BrF9GawyMIYrFZx5TtcgYI1WlhitvwwNUXDY6z4Z1VypC
 hYxZztWE9R0NiCd4ls/1bW2FZ2clScfjWDL/pNn9slEgZVmcWrvMt2M061QtqSGACho5tX0WOlF
 klDwXt6zJ3ZCbDsTsMuNHvQbnwiW/dJocc0RPdKzsiH1hQqO4WnPHwXMhYbew/n597IMJapRFal
 h1MAuARLSEspE2dcFP+vM92f1QZK/BpNu0l/DJSwa0E/UCzp/XFYLtdxK7OM8ZvFwdE/kXgLvJp
 v4RBmNsFoJZLiumE5O+oQMK6W88lrLgItwI7f4SfxUtbxfWzb9I5hwkjZZzponFfUrSz4jAZ
X-Proofpoint-ORIG-GUID: pRirtuckh53O7z2B1uVcSQNAz2ADEM1A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-07_06,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506070106


On Thu, 20 Feb 2025 16:24:41 +0800, Baochen Qiang wrote:
> We get report [1] that CPU is running in hot loop while requesting firmware stats,
> fix it in patch [1/6]. While at it, fix potential failures due to static variables
> in patch [2/6]. patch [3/6] fix potential issues in cases ath11k debugfs is not
> enabled. patch [4/6] fix lock symmetry issue. and the last two patches refactor
> firmware stats request helpers such that we can remove some redundant code.
> 
> [1] https://lore.kernel.org/all/7324ac7a-8b7a-42a5-aa19-de52138ff638@app.fastmail.com
> 
> [...]

Applied, thanks!

[1/7] wifi: ath11k: avoid burning CPU in ath11k_debugfs_fw_stats_request()
      commit: 9f6e82d11bb9692a90d20b10f87345598945c803
[2/7] wifi: ath11k: don't use static variables in ath11k_debugfs_fw_stats_process()
      commit: 2bcf73b2612dda7432f2c2eaad6679bd291791f2
[3/7] wifi: ath11k: don't wait when there is no vdev started
      commit: 3b6d00fa883075dcaf49221538230e038a9c0b43
[4/7] wifi: ath11k: move some firmware stats related functions outside of debugfs
      commit: 72610ed7d79da17ee09102534d6c696a4ea8a08e
[5/7] wifi: ath11k: adjust unlock sequence in ath11k_update_stats_event()
      commit: 81f64165c9dc2d9b070d8240dd369974ebe188d3
[6/7] wifi: ath11k: move locking outside of ath11k_mac_get_fw_stats()
      commit: c5b92a2c18938ebb08e8d4062408ab1524da31c3
[7/7] wifi: ath11k: consistently use ath11k_mac_get_fw_stats()
      commit: 29e2adf2ef2966379bd3fe002530b10dfc3030ba

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


