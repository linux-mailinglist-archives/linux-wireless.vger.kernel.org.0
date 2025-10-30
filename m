Return-Path: <linux-wireless+bounces-28421-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8F8C227C9
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 22:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D7FBF4F1B2E
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 21:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD3733892F;
	Thu, 30 Oct 2025 21:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZcvOFKz5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iv/bzNwj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327693358DD
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 21:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761861466; cv=none; b=nBNJowOFfZmF3Xrkjacy2i2V37rcTUBwiHqI+mZt27OTVOgL6XGyALuIqn/i+jgZduRQNuK7igt+s3X3v41ku7NKYEgR1lovIySTHxie39A+QPtl6WkHYs+PMgnbB1Zp5Bhycb7bB+TmNc5cQEszLk8yTWt6RIuGRCbh63Zpup0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761861466; c=relaxed/simple;
	bh=Uw+vx4WG7Le2g6sPWEPtWOyhZhMd5RoIlGYg4IIcWtM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=knWPqaaho6Knn7nafRmfp7fHy5mxBYW+LbqYz3g7Q9dUxGks2/v2h8AwqkFAJ8yxZn3aEaY3bllW4xDRaSo8DXWI4pBPSLSet8q1z6eIbNXp5Uzx6nstGg1du749IGB8978zf6ObmW8JF8mXqrmlu7Wy/o5XZZw8iembL/mDx7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZcvOFKz5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iv/bzNwj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59ULru7e899094
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 21:57:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hV4TJnZy003p01qOwxjpTM5eHNGSq6i1ulLjp3JllxU=; b=ZcvOFKz5DgW4X33D
	1G57y47VWGpoFFxeChP6uIbp6+2zi8NxOHLHEmLEIqqjr5EOA+1uFqBEoXLoY0RQ
	taYBclHIDGHCGFA4hrLvXxImutPnlgv77YNN56gSyPj+mkb19j9f7oHoSU/KN80M
	baya2XTKBcTRKjfME6JSPZReYquWr8RhTVV4cgwf7UsYr6ok8llAUSn9nlIO/8aO
	5N0yXIQsj6o5P6OEeqTlnuFylFBRQy56O0FXGd8Ko6pDS5k39MT7hO0L2Gd7HkpO
	a9OEuAB0+0/qRN81m81uwTMd5vIhekpsQDw4XcXEE0UgiU9X5uwV+6rK5WpLWqga
	ziPO3w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4gb20075-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 21:57:44 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2909daa65f2so26867765ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 14:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761861464; x=1762466264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hV4TJnZy003p01qOwxjpTM5eHNGSq6i1ulLjp3JllxU=;
        b=iv/bzNwjHPCZ28MvSQLUlXmSMPYid6Eo2dC/xe07/fEMR8T3cst+PgoAsiLO/kCnU1
         88OIZ0+lLqa6mEyxNmPIE5MpyJPz+nZPQ6yJNh31sUyoLnZBh4AR0K5Cn4o9fS4kr5Hf
         Pkvtf/8n7GZn4564k3jEZiQwKUPYCeDNyZPHi5JcLMBUrp9lMHvX+Jlzp5EZPdwVFQ6V
         heKtBz2XcUc8PlsJXpM51TkkVMhCKVGK2wNLSrojCp1WO8DiZ2rIz/PXUHg5zj/nPVh5
         cXz9hzFUEnAMCzmIO++bc1SiYo9NynmrxWddBYv5pQyhxKRVZOA/jRy3kmAoffjRFS/l
         4+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761861464; x=1762466264;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hV4TJnZy003p01qOwxjpTM5eHNGSq6i1ulLjp3JllxU=;
        b=cJwdb8JI785/q4353ddi1/HdQSvPPdA26R7vY8n2StkwN4PeuURYh0Il67dRCTj7q/
         dqnK5xaiTLn73NYlBBHfmKhadwTGLsqweFfFzH83PeKPX6eFgSPZX1tsrsBHEdGd7lAo
         bDGlj5woPQeA6nOnCWCVovaVDzqTUYFFjDJQE4E4gKB/NNDQInJ00RaJLnmJpLZhKt22
         Pye4sBiNJ6xtsn81vPrLoOHfbfoQOMDlNUxHDe9hWHSiDIgV5w+nFvxAHT/QOhPhZMbz
         tzCf2upJIT9z+d+Uc8g+f99ihVDsn6R9pZ8/ic0sNUg/UtPojfTpMosd+9wJGl5DMv6l
         ZRbw==
X-Gm-Message-State: AOJu0YwjgfO5WH6w+8hV3E/QrKnaEmUG4ysb5NmwAK3ntmYHjRkhAK/Q
	1zbZazdSs367YZ3T3qWiXCaZfWpAT+5bQOZL09xIuQlwtW29bP5SdDjcGxL1MBCSVd+fUIZyHZt
	Mu+jUIzvimNC1iLje313U/kPa1DRbcKpS/Wpu2LaR1G+drMeDEAtoKb/0AvGVQVSAFxVD5A==
X-Gm-Gg: ASbGncs/hxuosdExI64O3Avz/QEL5oZna/UY8OMGnHoI4ryUTIq2qdj9mq2cZAD/oGO
	ubNFDkUDQWkOhU3AeRH6ckURitDNwbxPS/NpCj1OEcMj8FugBBdZsH33vRvKuyNcHng/ihBdtSx
	Prz830HAM5uiAUpCgXSdMRK5OdhEloF5LBRGRSaSoJfAdpegccnDL1zQAd4ueRDw2xLu5mc+iUP
	U0VFHr5Ixn9tNgV+cJybeM4/SkHX/doM8HJ7c5qiFzMtIrhGcv+1KQ6diZ0Udp86i4HkKZM2+2a
	+2zTt1SCdIMiishM1+eDPZ9Vc3rIu4rMIjLLAryst7UueTB+XoHrivbti0vYxrwHdk1hZgwWVUT
	VBJEctBee5uvA3JcY/+Y5cU6DX9OnlLYXcyE=
X-Received: by 2002:a17:902:f68c:b0:294:f745:fe80 with SMTP id d9443c01a7336-2951997843fmr15578915ad.17.1761861463785;
        Thu, 30 Oct 2025 14:57:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+Dv8e1sndqFqNh4yuq4W3q3wAiuZCj/C/52iD727pttcwzGYHvSQGhVukGYCDgPFp+4MFsw==
X-Received: by 2002:a17:902:f68c:b0:294:f745:fe80 with SMTP id d9443c01a7336-2951997843fmr15578635ad.17.1761861463232;
        Thu, 30 Oct 2025 14:57:43 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf4a53sm201868405ad.6.2025.10.30.14.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 14:57:42 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20251026182254.1399650-1-rameshkumar.sundaram@oss.qualcomm.com>
References: <20251026182254.1399650-1-rameshkumar.sundaram@oss.qualcomm.com>
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: handle vdev create errors
 and ensure limit checks
Message-Id: <176186146262.3489476.15371664880131261602.b4-ty@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 14:57:42 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=efswvrEH c=1 sm=1 tr=0 ts=6903df58 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=gvBvQFtS0oAN2tB_OWIA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDE4NiBTYWx0ZWRfX0d206CY6jgqi
 80OpvN3M6ZvoMyLW07OmOmD3Su6UFoH/6kXm0ctxPreI81GkRyUFvnuwyHhp2LAHzgf9o2mXaLW
 8qcbobQvj72kVqoCAtqc5P/14ENt/jArbZwgN/2xWusCwxZZx2UBrYLZVuAVNB33SI5hyM6/IXy
 rSyR8icpof1mKBGPkTOLrVzkAMbaSJfB6f8G3JqPAaL5DZ9BgyzbjkOzwxqjFUj+eP0JxkQVVm2
 ozOMC099pcDxbaZ5DAMj4aErPx+cFSl/b2AXiNMHOF5f9p8zo4S0ec7dFBkGeuUOPhCPcrUP4Yy
 N4keXOXT1pOSzgMcnq+Vn2FAmht29Td8zJzMfTz6PP23Es5zYDhULtoJvuIeJJN2ZQDUJdMvaP4
 TaI6RcgXI6l8Vv+Nf9yEvEpZmVkVPQ==
X-Proofpoint-GUID: _dXk8TnVtzAxei86VF6EWkF3pAjSUjcP
X-Proofpoint-ORIG-GUID: _dXk8TnVtzAxei86VF6EWkF3pAjSUjcP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300186


On Sun, 26 Oct 2025 23:52:52 +0530, Rameshkumar Sundaram wrote:
> Centralize the vdev limit check in ath12k_mac_vdev_create() to prevent
> exceeding firmware constraints and triggering asserts. Ensure stale arvif
> is unassigned when scan vdev creation fails during scan and
> remain-on-channel operations. Return accurate error codes to
> improve error handling and cleanup.
> 
> Rameshkumar Sundaram (2):
>   wifi: ath12k: enforce vdev limit in ath12k_mac_vdev_create()
>   wifi: ath12k: unassign arvif on scan vdev create failure
> 
> [...]

Applied, thanks!

[1/2] wifi: ath12k: enforce vdev limit in ath12k_mac_vdev_create()
      commit: 448bf7b51426bcca54b5ac1ddd1045a36c9d1dea
[2/2] wifi: ath12k: unassign arvif on scan vdev create failure
      commit: e70515039d44be61b6a73aafb401d141b0034d12

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


