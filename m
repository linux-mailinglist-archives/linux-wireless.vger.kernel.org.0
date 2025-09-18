Return-Path: <linux-wireless+bounces-27493-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D71A2B87664
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 01:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89E681CC08C0
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 23:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C260208A7;
	Thu, 18 Sep 2025 23:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ADzNdYSN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C1734BA5A
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 23:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758239243; cv=none; b=dkjZ96kkpIOJ36Yncfi0JN55odpGiIaOyt+Xq/9bzkOuFPtSk0pXFBfroGtTxJIYqh0Gni87u4+B0Kyq7g+XcVqu/FhymHlopqisqTFUhMHghUL45TQXSskrJHz0/Ja7/8Gzy0A/Az7qP/PuQCbn9XqJE4cTjSvZkVqM3JB25vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758239243; c=relaxed/simple;
	bh=Pq2rpqDxwoTk6V+36ropQRFEMsic1JeXwdhKIYEltEs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NENprUmjgS9mlu2TtFtIvsfRmO3Gs8SFqsPkm61RcZcsK89wpCi41NMlRspLMlqJLe3SdvqW0IVgYVAdVhBwN9PfziFjH8Q6NjBDKPJLaiiyvHPRp1M8CUFjzn77WKCWaEe0kgy1eeN9C3ojed6tDWmu6h+Tmdi8BKcjpGH6fd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ADzNdYSN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IILEEo032429
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 23:47:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nLDrKlFQ+TyQOjCDaTNIvkV0oUkgBFPymnp+deo0dNw=; b=ADzNdYSN8RLPCcdD
	B5kCrmrqnuQqUWi++ZZN1eby5awGlOWD3XqW0abC1ffuangQnvN7d7jYEJpIZ23b
	WQK+W2a6NyNpN/RjxSRDSBjduW0jjoa2TWFUY1gJgWOJpoI9Mk0aNAxF5hWNz4km
	VmhugCJPDSqnJgOJ5G4jW18wo8U/aomK6Fdn4fIaJO75fjsPiyc8uTyKj5Y/K3Ss
	E/BPocum5EPWK5rqaMOP/IXhJv1yaedqtGaut2tgZplFZaofUHrLTotjKYBvYg2B
	g7P/h7bbRQg7EUvD5kZ5/3ieDIUcYdIrhc/NX1LYPJ5YgFWwkhhXyIg98LliEYE9
	VIzVqw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxyrd2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 23:47:21 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-268141f759aso15257025ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 16:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758239240; x=1758844040;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLDrKlFQ+TyQOjCDaTNIvkV0oUkgBFPymnp+deo0dNw=;
        b=iQxsZtH4urlZ0MXQ3XZ8ogxMu2dG4XmxSONCdkEZDXTbTOTp1+3TPwf93Iu5cB2ee9
         30nj1WYHurhH9EJ5IkW5pEwz0bGErYEsB9HXJyQFB8GuB2nvtgd76wL+NuV2z9ILuQTB
         0OGE61SQi7i39Tr2jmM7SbnL3PYoBDcCHUBCwTn3ZBBu9WhsEs5x/4E50YO3s/ejQ5MC
         VaXJLyW154iLyKt6/2aSB/ru0cQi4aGuWJu1uBhUKpE2AW9q0I4etJ2stc0RIe/c0OmV
         U3xRkSiRnzkFwvuLZ/Fvx5rivCtmJvI/wFCoMnuTiqhG/rQhZ0TbR1TwmpbDCAyAp1s6
         bq2Q==
X-Gm-Message-State: AOJu0Yz8AUfxOI8b5+0MfAmYfQPKNw4vP0SWWvsdj1mim7gO0JEL1kXE
	uP2FsQxeAnh555cXi739rPicjejSVBwChwr73YbONW18f4WxhZru0jM4zw2U4jPhFyE5/BDExyf
	YsQOP5fGlHDO3PSCWf5Yc6FxCjAre9NdlSd+vOCjOcCL7x0M6hwjnPHhXcmsJLGmgmJSGfw==
X-Gm-Gg: ASbGncujG1MMGQZgA4d7f8oVT3cGEw3KdkR+7pSDPz6L5QXER8MwVI97VTaklMq6gnp
	A5zaRSYlh4Wqg0kHEn5Wt4AgGtHpRNYapICLtMM5S7qtT2M2C0J1kedvlt6DRPUjMXfvCoiKmpS
	zBDXkTwahFuZIOirjA2Jpd7EQr9HB1GND3uVqR5fiqe4MdQdIa7hkgVFi1GjB124vM3c7VZrKD7
	z13ZqXq8CM3W33gZVWVdnxvl9PmIZHmXw+X+EiqGQEK9cc2fhjygOU92cE/amAL+41ev1G8iyRB
	L5AqVm7Gx5F8NVFEXZ7fScFmdB8S4kh7o+ZsHDV1qxGTkBqgvnzRVW+tLoTPv9drDqKY8Xj3HTu
	x
X-Received: by 2002:a17:902:db05:b0:25c:19b4:7ae3 with SMTP id d9443c01a7336-269ba476d87mr19514375ad.24.1758239240290;
        Thu, 18 Sep 2025 16:47:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGD9ekDQzPxbJSmIN93i1sbgAAD3PPG0qDLK6MmIW/8S8pKCsKu6izoBYxkpA5iLsl7JaGyZg==
X-Received: by 2002:a17:902:db05:b0:25c:19b4:7ae3 with SMTP id d9443c01a7336-269ba476d87mr19514155ad.24.1758239239836;
        Thu, 18 Sep 2025 16:47:19 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269aa71c928sm16474705ad.107.2025.09.18.16.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 16:47:19 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
In-Reply-To: <20250804-ath12k-fix-smatch-warning-on-6g-vlp-v1-0-56f1e54152ab@oss.qualcomm.com>
References: <20250804-ath12k-fix-smatch-warning-on-6g-vlp-v1-0-56f1e54152ab@oss.qualcomm.com>
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: fix 2 instances of Smatch
 warnings
Message-Id: <175823923890.3217488.17674946008340249630.b4-ty@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 16:47:18 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=e50GSbp/ c=1 sm=1 tr=0 ts=68cc9a09 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=3oxmQQPd3Vm5LX_vkI8A:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: -WGVEmIeHroUje8-kdxMEEAqVbjGCNMk
X-Proofpoint-ORIG-GUID: -WGVEmIeHroUje8-kdxMEEAqVbjGCNMk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXyACDe1Bd2ALP
 AttVGpLhwOzzSHtQ2QzmtuJXsmhnEqEODg5N0h9XCUNJDx59UUoM1c9nY0quL9t8V4t8AtYsvlA
 4aVyCMIWUkqy8uGHMGquEE/bD1QfiFo6CFf+rU4p0FBn7+DV9xGzF1Kl3WVEikVnz354tJlUN45
 XgyA2PwDvbY13mo2BkE6KVv2YvGJioxa2sSzFley8A4zAyVeFcVAp7ecjg6dI7OZYO5NhHQe+Ej
 RFpXyKC5sPhi0HtTeox1XOQBNrfoBpw4Ew2wd5st7Aki3+OQVdHzz8HjzfTRTfhqI/XnmEIp0La
 0Ahz29O4A1/So7Bek3v92lRLy/kdwpu8zgvGR+otzlhBEy6Hqf1OaWBt3GgPnlSVy2gAIZT2yLK
 OaClDbTP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202


On Mon, 04 Aug 2025 11:03:09 +0800, Baochen Qiang wrote:
> Fix below two Smatch warnings:
> 
> 1#
> drivers/net/wireless/ath/ath12k/mac.c:10069
> ath12k_mac_fill_reg_tpc_info() error: uninitialized symbol 'eirp_power'.
> 
> 2#
> drivers/net/wireless/ath/ath12k/mac.c:9812
> ath12k_mac_parse_tx_pwr_env() error: buffer overflow 'local_non_psd->power' 5 <= 15
> drivers/net/wireless/ath/ath12k/mac.c:9812
> ath12k_mac_parse_tx_pwr_env() error: buffer overflow 'reg_non_psd->power' 5 <= 15
> 
> [...]

Applied, thanks!

[1/2] wifi: ath12k: initialize eirp_power before use
      commit: bba2f9faf41ee9607c78fcd669527b7654543cfe
[2/2] wifi: ath12k: fix overflow warning on num_pwr_levels
      commit: ea2b0af4c9e3f7187b5be4b7fc1511ea239046c0

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


