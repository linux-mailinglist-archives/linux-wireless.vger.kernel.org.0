Return-Path: <linux-wireless+bounces-25389-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F24B041D3
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 16:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42B721A65E0F
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 14:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258BC23F26A;
	Mon, 14 Jul 2025 14:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M+bVfy5z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7602E370A
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 14:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752503724; cv=none; b=p0A6y63oxnRmnBrtXormR1wSG4qKJe9KyN/do9CFjyht9MsXcYTl5RFIwN6v7Hdomgfwym9yspkjOqXvNWs/KjNW0Kur/te1HBGC3SC5Vp4n7m9zgyraFKFtuQU9+rinzHID7GNujFp2XKnqhhEDs+/AkN2otPWFWPwUx2ZLe5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752503724; c=relaxed/simple;
	bh=gdz8C+8s2FfSnEmpCgJQcE6oyQIJGKAkK9uDndJCuxg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=k6mAcSsEM2ziV4jUOGfN+fumONTghQWOdjf3SvYJ/7FBfMNwBvUgfHLY2rCw5+NEiu/Gr5KA0+xT11G/11mEUEZ1+YMgEXCn/pdAHXOKJvxKV4Pvd415c4GX5j3elG9/4BakS+bCrlb7gKcGpztNV5wvj1gi3ViIwcAwcZeKl7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M+bVfy5z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EEVGiQ008347
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 14:35:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FLctuXiHSBcuYBm1XwBnz0H12VzIyMQ+L/Z0NIan27c=; b=M+bVfy5zH0j69J8P
	kb+WY9NvEx5KHa3YNLzkHFCDXiHv61PdArn4AUMn9sbsm6AQSFknt9lZd2LPiPHX
	Xy6cMbFllE8Q8V7ngi4DeEUhBEk6lY3IF5LG7rrAi9wmeiJ2PqvJPSSQC8DNI4Mz
	fuFulOPbKPvg7PGG9LkjxsEo05MlqoSND4oKGZRRRtHdTEkPzZN1R4oOyuZ3bsdD
	QDNTJlekMh+Nir0aGOofpVfX7g98m7XUfsQULRO+DQl4oaPtwEH5TCQoLnIH4A7v
	zmWg/cGvzIyfciNFns9NYhXJRutRIFK3Lsfeuth27pSUlH5zApS3CWyUJESF+tJg
	TsOGDw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47vwghh8uv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 14:35:21 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b34abbcdcf3so3297967a12.1
        for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 07:35:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752503715; x=1753108515;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FLctuXiHSBcuYBm1XwBnz0H12VzIyMQ+L/Z0NIan27c=;
        b=B46Ryfm+XCmIofaGs6TGvzMtkcwmGnqThMpPQ1wSXt1jjk9xCzL2ZH2qMPLMQtgJqv
         /WhNcujL5qevIM4yfMjRIdIs6TkBKNnFAHnWJWHF2NQbHa8CS6W4t0nXiP8ywT2NCdJT
         SBNTOd0bSfjOyaFk0Veng5sfCnaBio20PhxbejoSWljw580BKRqvioIr7p3S3ZR09XkP
         t8s1aSLNXhGyuKPKFEdDdpn+9tXAdy0MjmvSdmNq4qw/8Nu9mcSy+CxuFk0z8T2x9d7V
         6e9hozch2rVEN1iTaWaiO4t4n9obEQYMMka0H7ZGqMADUCGu3MGgSdsejgv9QPMZxxPL
         4t7A==
X-Gm-Message-State: AOJu0YwJiG2JOtZ2L3eQzKM97DxAM/51ODD5G7YWcyEabXLostWa66ho
	PlYxNX9w735Xophs/5b4TotB9Yevyi0jv02pCjrKbW88OIQ2i+uFW6hUcPgVFCXq138a09IbCnH
	d3Pm2009OJf1iCNhPdjpYR9NWl9J3SXi3bJtXTtQw8JrUX0BzXMMMt/UHnMabFSHaXGg7Q62KNs
	9uFw==
X-Gm-Gg: ASbGncuJ00ODjNaMfWBVDqOw6oO5h/7FECHhUt0pocGpOWisd2TXrg8NV6trfp3PQH6
	xN5snqoKaAzDd6t9NihsqVSrgMzYyZxDmoW7YPWuo/6RECsk2JArI/fgWxxW+dtOmX3C9EoABlH
	LN5/x4G6XiRT+ORHjhHXJ+IKCd7j+vCRwPwnBfKQgBGHcGT4D5/Ft6ToQIsvf8C+tQJRweRYsZB
	q31Rh2sERnlHWVQE4Tnj1PkjwKB1CbGS/5Ule62zDB99XJuKVmck2Ua+/8tH255TaB5DGq4t3q1
	Bl5vA4kCoFtVZ02QkvikexO46W5dhA9vRzsjMKPNLcgjd8s/fFxmW7h3iRXjPTMpGukBxbiKIU6
	C
X-Received: by 2002:a17:903:a8f:b0:223:7006:4db2 with SMTP id d9443c01a7336-23df08e5749mr158408165ad.31.1752503714749;
        Mon, 14 Jul 2025 07:35:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFi5rD+uOGDiBjwM/aLthago/gBGI6moarVWfChK08r17vdvcrpihfhmsyUMHK8aZkVLWP7pg==
X-Received: by 2002:a17:903:a8f:b0:223:7006:4db2 with SMTP id d9443c01a7336-23df08e5749mr158407845ad.31.1752503714301;
        Mon, 14 Jul 2025 07:35:14 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4331900sm92953295ad.150.2025.07.14.07.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 07:35:13 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250708181102.4111054-1-aaradhana.sahu@oss.qualcomm.com>
References: <20250708181102.4111054-1-aaradhana.sahu@oss.qualcomm.com>
Subject: Re: [PATCH ath-next 0/4] wifi: ath12k: Add low-memory profile
 support for QCN9274
Message-Id: <175250371354.2067518.12210451739869139013.b4-ty@oss.qualcomm.com>
Date: Mon, 14 Jul 2025 07:35:13 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=EbLIQOmC c=1 sm=1 tr=0 ts=687515a9 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=RSy2FYVPLGd-QfB_Y74A:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: rhhPT9gZdF6FnD74wSzTmDFQKSMDI30l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA4NiBTYWx0ZWRfX9qiaCO1sBYQT
 qb9L5UFm6WDTn2a2pxLiA/dZCbI2cxCYytXnDbN3kH7mdQ3N/pk0xZxajdNO7/h9Unke9M/Ylt9
 4bDu25YmuVzvVHs+dFYdQCNYsvloQ7GqGQsI59HIsC6ViNW7IBtkyXe17R0pBnvjCkKkccL+Q0c
 UY6SPoLCy0H6g2MYaCqxmnRqytpMA4uOC7YeG1DCQ21Ajd3+Dk69pVtZPbTH9HkcsgYWzdTqLgT
 CSMPax0/ePpMotJBDuu8P2fMRat9axdxldWX8JGsGs54KtPfFa9p906AULpAFZMzboTQhjIttlR
 vsaZ+CkD/IX8oIxlEQF6ggVIUVMF+yPy9f0Q4lnOXWVv3TJQaHCIRVFlbyA+vM4f7zCDkVAJts7
 DAWsLg3oCMwz7KgsWWjBzKipjiIkGeM+C9qnhoEK7PJ7CSbwouREr5Q/+gxO8ZAPBGdgeQgs
X-Proofpoint-ORIG-GUID: rhhPT9gZdF6FnD74wSzTmDFQKSMDI30l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0 impostorscore=0
 adultscore=0 phishscore=0 mlxlogscore=779 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140086


On Tue, 08 Jul 2025 23:40:58 +0530, Aaradhana Sahu wrote:
> The ath12k driver currently assumes availability of ample DDR memory
> and configures internal buffers and descriptors accordingly.
> 
> Introduce support for a low-memory profile to optimize memory usage in
> constrained environments. This mode is useful in scenarios where
> memory constraints are a concern.
> 
> [...]

Applied, thanks!

[1/4] wifi: ath12k: Add a table of parameters entries impacting memory consumption
      commit: defae535dd63b1eb78ba87d5b8c0b4fb5418fe0c
[2/4] wifi: ath12k: Remove redundant TID calculation for QCN9274
      commit: d11d81c46987720e022dd4008d4d1f1f63312e3e
[3/4] wifi: ath12k: Refactor macros to use memory profile-based values
      commit: 6397b92bbb00f7cda024056c8c8a10594a27ccaa
[4/4] wifi: ath12k: Enable memory profile selection for QCN9274
      commit: 545b669403d72cc4a1cf5d93b3fce0b6a85833f7

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


