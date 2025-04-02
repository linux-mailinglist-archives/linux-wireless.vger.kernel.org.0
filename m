Return-Path: <linux-wireless+bounces-21080-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B968CA791DA
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 17:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7191117096D
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 15:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B74123BD1D;
	Wed,  2 Apr 2025 15:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kLfb7yIo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C006323770B
	for <linux-wireless@vger.kernel.org>; Wed,  2 Apr 2025 15:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743606487; cv=none; b=rNpiP89pcLUpHonGUtKmIBxjR8fFUBIgoucFVUt+GkUvbCX9N2NoBmzxoX8Q2utFZcxUkyN4Uoxt1YNfdgsrtWdJa3VFI0LGiiK25hUwkE1lhUt0abE54gTpSxjknSCRBdSCymX1SR6m8Xnmjm2aPoyqNp+JaNZR6cuS2qAuAEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743606487; c=relaxed/simple;
	bh=CbjWuFIkoSMgZYeEo/rL10lHsGjLyOpwQa7qrn/zZdo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=V4sdqZwhoML5dGvOyX3x7huwzC85OGvXRnL89KDxlaHbBlQ6GhmVf5wDhByfCnKwnXmAzo8anIsqa8hpjGExmf2mUrAgqQbfCeyxWJalyJxTopIfxHC+GXtPHI7sHiA673OtCXIJAO0quGXbi63SK/I/SaQ0pe+drNuLQtFFXr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kLfb7yIo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532AgeZ2023639
	for <linux-wireless@vger.kernel.org>; Wed, 2 Apr 2025 15:08:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R3KglQ1aLC+QdVQpNSXDKg3Gam5Qq7kqz6z83UiaQ7M=; b=kLfb7yIoGASg8Q+F
	BNQ5y2Svir2Zr0IyOUt4XRssX7QGAy57Gb+B7+3VWO4gRTZtkEcxtbF5iT45MPj2
	hYoTsCvqJEvgphnT6WnJrG15GNfeuzofrDtwlXDY9yMMHZPL2T2yzxyEeygISwDL
	CuNVOWaV2ldOsqpbNy53GR2fhqjSRf3CgAbXKl5tKq+7QdipAb7wFjZcbmGI/9UC
	Jal4KlPF95tcnXpR53gPVOV7sWLnEswtWuXLzFwM5+O8sz7WIqJMVkJhtwF9dmZp
	5rF+kQpjhw96LvJqBiYPsCPM2+s+GijbsbeiwYUeLKDJ49KclK3KoRs5bHAzwtOT
	B8/CPA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ruadt584-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 15:08:04 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-22410b910b0so96740205ad.2
        for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 08:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743606484; x=1744211284;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R3KglQ1aLC+QdVQpNSXDKg3Gam5Qq7kqz6z83UiaQ7M=;
        b=ZopWaajr5bjUArr8OLxvXfL5HLjjeer1lsIF+BVqsOhfMys0DX0TR26o92ATkhBdHZ
         /4VXqUX+7SB75UmXoo5IeTuFtzuOEy1zy6vTXC1FrjuiUmEESo83T4BGB93/Woqwn+ut
         oDQduXHqsaYtbhz3f46kqId7dIErPoCDyG+JTqYJq5XYb5UZqpaAyIVLhUWsM8qQyNOb
         m55i3rrEz1P5wv+6G70XcuHRtjhq25unUyCL42pTv9qDNiID343KslcSNz0A6ThypO1i
         apLuFUmlwf899grgpTos3CXbiwAGKOQcgmGWKiujPo3vjemwy1s+pEA5fGQrlSdPbMRZ
         NuJg==
X-Gm-Message-State: AOJu0Yy37zeyvX03A5/BwKumthMc3gd/MbcmTkepRJ9mdtSfxxu9P3Us
	aJuwQeFJMJ5EdC/yb2oDSrbnG9tTaF9/7+iFlca4A3b0gDLqpwEcZ3zlnvVjIy/mNiq+ujcJxRH
	7zznGeoyRLYdzNCqHDbm7CpLJQQtDDPVObLYOqHL3H4y58GiIJimVWhL2/1TMi3p9YmaWl7bwUg
	==
X-Gm-Gg: ASbGnctBQs17rdns0b0jy0vNnZj4lf1ELnweBtdgXMQkyMOQm/ZqARb4y6Jpywjtxwm
	Pb4DpkujQYVeRqmiFSMkEDSDwqBSstRIpXb7bjocLis10wvSlSBOqad7P9wtms1ThXNaimYYMjV
	92QHeW5YVBxKyQq7mj2vPVcaZkTq6h9rRce5GnB3i/I0hmtb51eKh4/dfUEoBtrsB2HxAqyO1Of
	xpVCUXQ1vvvsljT6Hf1W6HiQynwR4jJMp3a7N2K9vKqZJMrwq3eH4rjOYho11pMMm8jlPnubBgu
	awkFuar39YSI48Ew7+jnXSrQuBU2Jlrn4X9alJ9E0S1MPxej9mGO
X-Received: by 2002:a17:903:120c:b0:21f:2a2:3c8b with SMTP id d9443c01a7336-2292f948bb7mr278396925ad.11.1743606483210;
        Wed, 02 Apr 2025 08:08:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTjdD7aVWLh2kVEEVM6LmX8FK1+ZPqAu8gYYTMClO1lUW7ahOqL9yVO9j9tK1semCNw50tAA==
X-Received: by 2002:a17:903:120c:b0:21f:2a2:3c8b with SMTP id d9443c01a7336-2292f948bb7mr278396345ad.11.1743606482451;
        Wed, 02 Apr 2025 08:08:02 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eedc988sm110193905ad.59.2025.04.02.08.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 08:08:02 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Kang Yang <quic_kangyang@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250401020840.357-1-quic_kangyang@quicinc.com>
References: <20250401020840.357-1-quic_kangyang@quicinc.com>
Subject: Re: [PATCH ath-next v15 0/4] wifi: ath12k: add 11d scan offload
 support and handle country code for WCN7850
Message-Id: <174360648187.2001642.16051086719382806496.b4-ty@oss.qualcomm.com>
Date: Wed, 02 Apr 2025 08:08:01 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Authority-Analysis: v=2.4 cv=VI/dn8PX c=1 sm=1 tr=0 ts=67ed52d4 cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=R2o3b0x2uHoVLtyVjMQA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: rX1LEPMbljkCiN9E4ck_UDDv7FELsBgH
X-Proofpoint-GUID: rX1LEPMbljkCiN9E4ck_UDDv7FELsBgH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_06,2025-04-02_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 adultscore=0 suspectscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=980 malwarescore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504020095


On Tue, 01 Apr 2025 10:08:36 +0800, Kang Yang wrote:
> This patch-set mainly does four things:
> 1. Add handler to send WMI_SET_CURRENT_COUNTRY_CMDID to firmware.
> 2. Use WMI_SET_CURRENT_COUNTRY_CMDID to set country code for WCN7850.
> 3. Implement 11d scan offload, and update new channel list to firmware
> when 11d scan finished.
> 4. Store country code, and update it to firmware after device recovery.
> 
> [...]

Applied, thanks!

[1/4] wifi: ath12k: add configure country code for WCN7850
      commit: 1b68481fc1d8fa89a3d974b64a15beed2326c5c7
[2/4] wifi: ath12k: use correct WMI command to set country code for WCN7850
      commit: 773ff9074a79117d830b9eb006f3058ca6a24a5f
[3/4] wifi: ath12k: add 11d scan offload support
      commit: 591de41d7008585f2e7c35dbcf5922fcb4d79e39
[4/4] wifi: ath12k: store and send country code to firmware after recovery
      commit: dcfebfd4c8dc0bec9b6649104cecc09f5978c4cb

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


