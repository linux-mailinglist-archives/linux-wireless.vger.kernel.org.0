Return-Path: <linux-wireless+bounces-24354-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1BDAE4768
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 16:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A896816A51B
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 14:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B8E26D4FC;
	Mon, 23 Jun 2025 14:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OHuLIHWn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451D926D4E4
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 14:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750690127; cv=none; b=m6NxdRWVLqlJj/KzGS2ScqUJJjnMHtJe574NaJoCtpOQcJHcrB5bShHHRki72HP15vHXU7KPEgw2i+evUkQWIZxgVYogQaA30JTXKGRYM4W6NdjcTLyzeJYUl46rCWRnlHo9PPwPdcWR6Wdv+ZZhSR8F6/QvlwEzJv8cok+iHqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750690127; c=relaxed/simple;
	bh=+VW3gS4uCeOEeg7I6QWeDNmbv/8Ah0zcgCC3H8XwmjE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tL7bgC3NnSVLKPFbkpklAj+2V8d50WnkLPSoj3lvF8w73yg1yKy96PznBxGzUmKaC0fkc1ObSgLVVq6wzECspBFDPGOoIx+RuCAlejNbikJMr/MJlZwzXm0ZxWS6R3GQ5R9xXWQGnQEy5E1kvAEOOPRNNCZctV/sAStY4C9PcOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OHuLIHWn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NBf2er029883
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 14:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C8PVwSPyQ0skiggn8tPu5UD8MYXZOpVsqOR/uAjnl0g=; b=OHuLIHWnpYNUCr5s
	HhMDABuIVOiO3uKeCt+Q7y2BH3oGmRvsPZ1Or7LVKeI1I/XhO9jE3lxfX2m1cCMk
	ltDHEcUVkaeUKifRRiGHaHBg1UMQGldpnLCGKB/tqTguJZQgScFGp2gUXwm5jZTD
	o4n+HZgbTO33/SnduzTM//a+4VqpZ8bYKyL2fQGgNpsqZtYG2F3T34c9xHiom5H5
	HJI9xAJUMZQIuyFyZmoOhUb7ENzJ/nmEdIN/0nBTPQomUPvEOx9oYP+d8CSqNozq
	T/EiqviFwehVkRrFDRUGE5mCYW55jHfIkaI/H6fbAkxSo1tEcx1z0rPwpGGCjP1b
	8lYV3g==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ey7k1sxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 14:48:44 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7425efba1a3so4594120b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 07:48:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750690123; x=1751294923;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C8PVwSPyQ0skiggn8tPu5UD8MYXZOpVsqOR/uAjnl0g=;
        b=a/LB/Uvi1jek/0ebV+dUWzPnqqX/9VPik3Iy76lLec9yMldH6nsGiIm85cKp8Z+XZ7
         OL6wYeBYqWaATaIJtbStzkqsPy17pq+OEbd6B3NyGHUO7cG/sYDzJzSUZJQu1GYmk4a5
         3IfnQj/5PyrxEV3WbXdJ2TpdjIQ6Tj9TEUn52HqyyadtxV5ka1Yg7J7uUR+nUO3M9rXE
         A33+l1/hLNHSBPTGXzr8ZQ1mJ1b3HjnhhmMlZqm+dU2qlZtvS1f0H0stncUd3nOCizig
         ObG2artzu3iGoUcLLMpd2N8rGbIlFoPJ7ry8CMuKh5dNs77+zEl8HsfbdCRVh3fB77Xi
         sNcA==
X-Gm-Message-State: AOJu0Yw+ARc6wq6dAWDt7dJ67+pltQPmmF6JEhW6hjYmQcZEcwU2TQV2
	VJSHcUvr4o78yhK8YfRKbBXLVFE0Pu48f7u0RYytePWwli208FGLZZQYpd+qqk0qQxYpZm0xW18
	m+WNtHOeLaFj5+ieVe6YkqXmVMiaqkvPw/FChNXrKDlDk9EEVI6/uQ7/Cvz+UQAtjtPr9r02HiQ
	GxRQ==
X-Gm-Gg: ASbGncvIkudbWWkDxh4rtsKcnTksEiB405QEVwhjZC5EjA9ubE2ckJeKIUHpDg+EBiT
	o07ehwwoeteVToYNWNBSpwcx50vx0uVBmFiAuA9kMKWpJU7XNw+4tzvzzEQea7dSbRqLVmbykdv
	3+pqbyYuSwZJloA15BbjI9R4Evajs1p8ntB3osq7tARuhyCC7hwLwFdBk/sLmJYwKp+7xF0wEx7
	phlt4xPacGgddQN21PhMx492LM14rEG7IGooOti59ibWTnvwLk42Ou1USCxeEfGqXu+EYrhpJeM
	BWRUlgJeTybZdZUvOeH5pgkh0HNJCB5oGd/tSyK0Ema5gQ4jKy7EIDjCzWc=
X-Received: by 2002:a05:6a00:2289:b0:73b:ac3d:9d6b with SMTP id d2e1a72fcca58-7490f474fb8mr19925220b3a.4.1750690122864;
        Mon, 23 Jun 2025 07:48:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiDUbcCuweUNd6POV4Mu4A7JO9Pe70myaHyFh+DDkHtsxIJDLr9H/AUgdpPtj0vW+/9lD5iA==
X-Received: by 2002:a05:6a00:2289:b0:73b:ac3d:9d6b with SMTP id d2e1a72fcca58-7490f474fb8mr19925193b3a.4.1750690122431;
        Mon, 23 Jun 2025 07:48:42 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a6d1eccsm8332894b3a.180.2025.06.23.07.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 07:48:42 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250522111514.3735107-1-rameshkumar.sundaram@oss.qualcomm.com>
References: <20250522111514.3735107-1-rameshkumar.sundaram@oss.qualcomm.com>
Subject: Re: [PATCH ath-next v3] wifi: ath12k: combine channel list for
 split-phy devices in single-wiphy
Message-Id: <175069012182.3758471.11010293441396013758.b4-ty@oss.qualcomm.com>
Date: Mon, 23 Jun 2025 07:48:41 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=YoEPR5YX c=1 sm=1 tr=0 ts=6859694c cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=OA4D8QjaPUCl9yRW1QAA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: yG6dbzZ5CDRFf_Ke20T0eeVzPNcxOO_z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA4OCBTYWx0ZWRfX5z8spGCo3c+5
 hvomSggubVUT/YXGCTg4BrE95PbhwMwPW3btfCybHh9SPWuXVfMt42UFKBI9AqUDRYH0+tKDqVh
 Rf/w5vmYf1iu+vEBGY2PVCuZh8P9XwbvZ/8RbrnVMCbblaCcZr8z2Lt1MBEe2ZPpDrGXLMY0uOI
 Y8EG6JXOwArzyc7cx9s+jdXv6ytwGgsewU3Kj2x2unWp++FmFFMUJbPUR0QknKuBliLKI9SNoPw
 gK2TGJ510NjgCVlrJtIw/4D+hLMblxQo4gcr7UfRe82rKOu4qtgJgHt/OySmAnuvunQLldudTyn
 5qP1LffwhiN5E6I0ShGnpLFQizkNtY4zCBOlAN6fiSbrXPSKJCrsrDndn5cM5DxnH6AGVqnXJsB
 9Hn6CRb+TXTAC2acCzI3IJqWXSbi6dc+GOAIJbB5UtLAALefUj0K1DDaZR9M7c+66R/FXcIK
X-Proofpoint-GUID: yG6dbzZ5CDRFf_Ke20T0eeVzPNcxOO_z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_04,2025-06-23_06,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 mlxscore=0 adultscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=949 spamscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230088


On Thu, 22 May 2025 16:45:14 +0530, Rameshkumar Sundaram wrote:
> When two split-phy devices that support overlapping frequency ranges within
> the same band are grouped into an ath12k hardware (HW) setup, they share a
> common wiphy instance. Consequently, the channel list (wiphy->bands[])
> becomes unified across all associated radios (ar).
> 
> For reference, the devices are:
> 2.4 GHz + 5 GHz Low Band
> 5 GHz High Band + 6 GHz
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: combine channel list for split-phy devices in single-wiphy
      commit: acc152f9be205d76771f8156002d55c3fcd21252

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


