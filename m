Return-Path: <linux-wireless+bounces-23164-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E24ABC5E1
	for <lists+linux-wireless@lfdr.de>; Mon, 19 May 2025 19:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 379F57A230E
	for <lists+linux-wireless@lfdr.de>; Mon, 19 May 2025 17:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAFC288C32;
	Mon, 19 May 2025 17:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jXS7LIQs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AE8289370
	for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 17:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747676901; cv=none; b=mrladc2OyVkOJsfCobJAPBplAA2PlzCrJtq0v+pixBKGAFr/XwRv3GQ0n66pUHftVdPZURHK720wgmxgiPokF8GBPLUADCu0punbZK9RVLK3U/h9s9+dSV3zK/QzbwXNb/4P5cl+4lWljQpcXfmt1mlMsGx8r2cl9r1J8MW3xM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747676901; c=relaxed/simple;
	bh=1enVCSSIT9LK8WIatbZ7cLOVu2OeIMBB0c9pCWghc+I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XC6Jn4+JgYIRXBRJ9jhP1goflThwdA/mBd8+zq+9xEljE7sScnuHlWeWU4WGe1KmJjgTekxhTBd0z7t0i7KYjMSvQ/i4FRAV66hL8QCaM8uGJjwN9pYEN1q69Ey3Zy5r2zwDVwnHxnHqZWKma8kHF9Or/Ta6xWLA2xi45EILnBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jXS7LIQs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JHfpdc003036
	for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 17:48:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4dz0N8OJiFEnN3TXI/UlAKcDSuvFXRmS2jiRZoeBQsc=; b=jXS7LIQsr0VdQtv5
	jfEhw919kwTiW3pLjwkB1xXMuYUs0jEtlQCKAdsuiEMbSXA2XdOKWYB1X57jtrU7
	ySkjsgrNXoXQqD5+sBviUtIJXAv1tPuZ61SNLCXMNRtyfioIAvHXVuF93AVykhDs
	5brRGrf+jqLIMRZVJJknx1SOoEun90yO/GmHQTMBEfSNZ5qyTjF8WUYbDYtMGs9c
	jTUI+pNTuukX5fimufmXUc0fLhutjLLAXD3ORJ2Q5kUCouY8fMlIqiCC/2zCGfTU
	V6/nU8KfIq60psdkyS7wiA04fQ9U8BDToFTEUvAcZZ06AfrAUp8Xx8+sBkZnF3S4
	VZv0kQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46r1athgqv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 17:48:14 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-232054aa634so17987975ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 10:48:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747676893; x=1748281693;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4dz0N8OJiFEnN3TXI/UlAKcDSuvFXRmS2jiRZoeBQsc=;
        b=lUuLEAqDc7+vBKW/F3eFkCeKQ+DvL3N2e8WJCEJjQr7FCWVHn/72nt/QhfL7XnuUg9
         k9/QY94UiaXN+OAKc910sLvaaYNeayQ9ND/a0XUFhvQpCjfavunaM3atefJeSynzV9Nk
         C3EwX+OrFop1/ezQ7c7+k9lu98Ri2VptZTYCR/0S9nnRbkD8v+ctM7UnGeJY/iUIm6OZ
         eyGpbHfy5rn+8rOTWXGveMshunHV1Ew7g9AsSIJtKdggVYzmENT6Ig5lYaoJoind0RcP
         A338hDV2/ds6AsrFaoj6SqioVn5sEfIpTTff/6bXfKmCKBsYqtxeIslVOrJgNBQjTJ9Y
         IZ2A==
X-Gm-Message-State: AOJu0YwYjX8oXNGrIi37f/9wwe1Rt/RHDXjGJ9K2KOGNJsjdu7z3gZwi
	wlRE4o63eHBxK+Hlcf99pUvJIQQs/Krznc6uHTC6GxMLpI1zSETpomj+brb+niNSPiGjSdP46sT
	SmBNNKDe+3IOzywhwB8MpMaaakKi7PWXWotCFg0mvEgYuC9E6Z8MnJy1bQGqHEuVjDT7sow==
X-Gm-Gg: ASbGncsPN6MpKoYi9XmT9oOjysKxPHg/A1IAhbO1DL4DV2csaBscxcURrGqBh260lrD
	TqaaYk3dVW0zhOLZEofa8o7IkaHxRq3euiZVf15rA9YWhBnyvPIyiidnR6m98uajLQyunz4ziIK
	hIlP6iP4kfuSOTD3bs78yqNROsThObFZUlOoZftOaP2Hx+3IdR74dKcETGb9JVR3zmDdapzlp+W
	0n8v+QbKpxf6u7so0X/T7+5ENTHTnOcQliZsw1nYA18WUy917P5r2ym4Q9LbDRchK+TOKGgko9d
	3tonPUroLtuJa3SdTclNBN0C4wI/G0HtH6CrMFFDaC5GYF2c
X-Received: by 2002:a17:902:e54e:b0:224:2175:b0cd with SMTP id d9443c01a7336-231de31b382mr174721865ad.26.1747676893047;
        Mon, 19 May 2025 10:48:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFC6Mpowamzp+QxaCqDYjIUpxCyCKIrN9vFMzM6IHGdfyj2qCxwrETMdoWifD1OzFmgcE+Yig==
X-Received: by 2002:a17:902:e54e:b0:224:2175:b0cd with SMTP id d9443c01a7336-231de31b382mr174721675ad.26.1747676892667;
        Mon, 19 May 2025 10:48:12 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4afe8b0sm62651425ad.89.2025.05.19.10.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 10:48:12 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Vignesh C <quic_vignc@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250512065849.2833232-1-quic_vignc@quicinc.com>
References: <20250512065849.2833232-1-quic_vignc@quicinc.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Fix scan initiation failure
 handling
Message-Id: <174767689195.2567051.16233007909568567148.b4-ty@oss.qualcomm.com>
Date: Mon, 19 May 2025 10:48:11 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Authority-Analysis: v=2.4 cv=OfqYDgTY c=1 sm=1 tr=0 ts=682b6ede cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=sXF4B24Cz5WW0EW5pLQA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: mcsZPYl1GLWORLSSqus7PPiJvwub4opq
X-Proofpoint-GUID: mcsZPYl1GLWORLSSqus7PPiJvwub4opq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE2NSBTYWx0ZWRfX5Zo8SPSgbHrs
 veL58s1BhFU/5PCq0vyKz+fp8RRwvF9ctPNmRu+70+VwSKylbCv5C3aRm2p5ilGYq/eQawRkj4L
 bhOWATqa9DLFMXP1J4UgXGXnajV8iO9z2jWzywVBXR2Sp89DHBr6HPGrJlCGfqskcrUewLQl2mQ
 o7IrmJjiRxFzg/gFqc1GFb//nNSwCqdjFWQyNImFOqZVnTXLBa1ATbJ9tplp6B/x5Vs0BrtsJ+q
 NUI701adWPxnEwERfjtSP3BXhfn/0vCDb7/B8RK/hZ+3N/6hx461aXF/GCee+Oi6oisXDDl0yyN
 LUd6z1d3kEYHzCLD5o5mjgtJnCxN1+PLdU6XqcvVxqLlB9e/eh4+xxpgwlr5wovOwpZU7rGlMGa
 pVUaM1Q1GAw9OsD+Z8t9lTC+7qTfvA7GIZ6ozVec/lZ+KDuZqIbMG9MbsD8wzqkgMqQ5i+ij
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_07,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 spamscore=0 mlxlogscore=968
 clxscore=1015 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505190165


On Mon, 12 May 2025 12:28:49 +0530, Vignesh C wrote:
> During a code review, it is observed that in the scenario
> where scan initiation fails, the current code schedules the
> ar->scan.timeout workqueue which is not necessary.
> 
> In the scan initiation failure scenario, exit the code instead
> of scheduling the ar->scan.timeout workqueue.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Fix scan initiation failure handling
      commit: 241dfac96279ce9de47a6d4478dd3d41f262835f

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


