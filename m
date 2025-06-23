Return-Path: <linux-wireless+bounces-24352-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59344AE4766
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 16:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 282CA17B107
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 14:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03EE26B2D2;
	Mon, 23 Jun 2025 14:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GwJg196s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BBA5FDA7
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750690124; cv=none; b=SFer1pXHSt2LEUEv81jKjH3gcOELqjA/XOLw14wu0i/eKJZSUBYZ4wQVALqRn3HwtPn4sZU/R4CYv/7euwIo5C3ZDOTXe6LbLfvjt0g+yCWVniZQBdE8I79gmruzFtKjozIA0cAaE8CTRMlvj5iprFYUjNeaxiJZUPqk8e7rOus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750690124; c=relaxed/simple;
	bh=XWhV3KFAuvmgJIT1pKPP4YbiFDCX8brqbZPZP1fD6DY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BrOybjNFs5GdFD6Y0zMLbuDUo0ImQ73AY2kMgiEGVYqieusRCI+Ey5Hadp068m3ULywITxxJ2/g6IcAyL5lwRlXGBCwAQwXKW/jDfvYLYQIwxIwRghd1BBwnQ11y/styfqgkwHKGoB7/i2wy4qPMJ2v+ExlERdR4s9/hkm7hw7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GwJg196s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N9TLMD020776
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 14:48:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4QQcF4KijTnmo4CAM7plMQGmmxLSWUgfBXkZWIawFLk=; b=GwJg196s+F4qMl1G
	95aN6f7bEFG3a9QjHF8SIpH3BPTqHhLD7ej1eQRcA14enlOFTdT4OCXf/MnH2ZPb
	6PLwxdC9YLDuGvpMFpSLpELfkhNF13p4DWqAuI+IG4pXBmi7AVwY1nAf9QdArbhi
	qT31TFHP7HwqJ1I7T7vKaspJEEGGcCArH2DXb3w8s5ia7DNqKtM51cBCFjuPZC3i
	R6M99PBmtwYLszua/YJenxbSVUBi62fXqSStVVHaEK6eDzatoSVgq45vqeSNtw/+
	FJcMk0AvdV1qN1od0jVht6g5oNcqOGojw78X5hsIzisYiU/TXJGYeT39HI15uhvZ
	VW7x8A==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f4b3rvwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 14:48:42 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-748f13ef248so3457355b3a.3
        for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 07:48:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750690121; x=1751294921;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4QQcF4KijTnmo4CAM7plMQGmmxLSWUgfBXkZWIawFLk=;
        b=aXRBrdwRr+umxgU4p1XFpuW930SjgMspKc5FxEoSLkSml4lPnHyIjSMO7C2gStnnGs
         E+rP7a/Pcang0KJH7pYjxfP8xiwbSX0fQiLl+vrX/1tRstVmUwZkZDi8nyslFyoMcLig
         rFzCPvcDHA3DYNoLI5ARO9Rr3d87kmTRbLSpZtl1IBBxNS5wSbHwNvaReTSAb6lyBZSg
         Ap7ccqcAWXSxmj9uTekVzuX/c4CZSwBaaBd8UWECFc8bAjSqV7//A4X0/2Del4SUjk+l
         YVHakt2x5CsVcOQqzh7IEXJC+sl4K7hFdxLE80P2Z2doJqytE5Z3DumVjaxJCxKMsi9/
         ylrg==
X-Gm-Message-State: AOJu0YxfghlEHEwpE2hrkXsLAGEu+hStPNt+AemYhq6lNpGq3M2q3AYO
	AX/PhiFxOYm2Ybz0be7u+sywyaWzWxWpOMjgxCodRN4WTFZmNehpiLjZT9/T0uVbch53VRmHETk
	eFIJJBCHpAyL0CMVeJxSMyDUJ4uooyJ88okGhCn1GceVvb3+vL0+tUJzQt/Fz3+e9pKpoVOMF//
	p6Tw==
X-Gm-Gg: ASbGncts/tDp6qOQwC2tTM89aqqQKU8Fozjo6vS0MGe8nL9Zgt/gipvKPinTVqCdUGt
	mfyZr8gD+NNlTX6EBW8ITZ6lZJJwOOSAbtIefnyoF91WRYytx5rePBjccb06U07xp5ON4E8kzHv
	7fyw3Yi3rrltfjY1XNwAVKz/T6iY546zN/7/RuhEwyOBw4s+dqelFxXpody7iC5vgF6kx+UNeS1
	jAr+4U7x0mnOApyC5aFwGZDC3J5Sqec/51yKLRhtLR9nvyN7YspnQEMnXfBHPmwz5nctJTQ+qiJ
	WyhcUu9hOclOL8u4IMOtuO0TXu5aj1pG77hB1uC+9gRhsp22caf0/NcO1Yw=
X-Received: by 2002:a05:6a00:a1f:b0:73e:10ea:b1e9 with SMTP id d2e1a72fcca58-7490d6153b4mr17505886b3a.6.1750690121204;
        Mon, 23 Jun 2025 07:48:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGU7ljNy4RONsvNDpfzXhyhZVSUhd4ESFt12iIMNNY7ruvTPxrcr/Vw6kMsSFhGvh4gTnmOiw==
X-Received: by 2002:a05:6a00:a1f:b0:73e:10ea:b1e9 with SMTP id d2e1a72fcca58-7490d6153b4mr17505859b3a.6.1750690120762;
        Mon, 23 Jun 2025 07:48:40 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a6d1eccsm8332894b3a.180.2025.06.23.07.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 07:48:40 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Muna Sinada <muna.sinada@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, Karthik M <quic_karm@quicinc.com>
In-Reply-To: <20250506214930.3561348-1-muna.sinada@oss.qualcomm.com>
References: <20250506214930.3561348-1-muna.sinada@oss.qualcomm.com>
Subject: Re: [PATCH ath-next v2] wifi: ath12k: disable pdev for non
 supported country
Message-Id: <175069012002.3758471.9127694924471258296.b4-ty@oss.qualcomm.com>
Date: Mon, 23 Jun 2025 07:48:40 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA4OCBTYWx0ZWRfX5oAeNL9mnhxP
 oR1rnlFMk+6iEwR9fmCG+kCWn1q/ky4C5JfKG+DS2e9arY3R59O4oZVOxrvSzkIj+FdbFNcy2TN
 RqEJZ0nN3A5zKQAdaMHdzbqWjpQpkICY+USSUxu3PG54TpBIrM+pqus2fF1GaOMRrW5q/a0py8R
 xTtk1yCIipk4HULdN840Z26JADXxEeJuXTVXYNk80lTdlrvShRyI6KAyh6sITc0QfgBQHo/XT2r
 EFuMa80CMmqkORP7KLOIEbTo0abygYuJaNsKsuE+V+BzayvZvhUG5aOvbZXBzDd2j3IegT26sSF
 zLxq072Tjpr/mtvCLFm21cQDGuYUf/qR0eB2PiVcKkWuGqnbKCs75cVYMqCS8Afhvyjmdu0MEEA
 ql8E1wUQOz4vLnXm23jO4ydhafErw2yCddEZDFx/bw+HnItf/HjNdg05Nr/CIg7V9UOrpgrZ
X-Proofpoint-ORIG-GUID: N5y_NzjRLJ7jeB6nKzYgwVh_S-a97rl2
X-Proofpoint-GUID: N5y_NzjRLJ7jeB6nKzYgwVh_S-a97rl2
X-Authority-Analysis: v=2.4 cv=A8BsP7WG c=1 sm=1 tr=0 ts=6859694a cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=j1_G22Jgsno5ajverhEA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_04,2025-06-23_06,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxlogscore=471 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506230088


On Tue, 06 May 2025 14:49:30 -0700, Muna Sinada wrote:
> In MLO configuration, ath12k_mac_radio_start() iterates through all
> the radios and makes the ar state 'ON'. Even though some bands are
> not supported in certain countries, ath12k_reg_update_chan_list()
> tries to update the channel list for all the active pdevs and ends
> up in the warn_on for non-supported band.
> 
> To prevent this, disable the pdev when the number of channels across
> all bands supported by the pdev is zero for a particular country.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: disable pdev for non supported country
      commit: 0f9842b0b0e58173ae0d4f9838e4d9375b29a38b

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


