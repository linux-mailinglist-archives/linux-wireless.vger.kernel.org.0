Return-Path: <linux-wireless+bounces-24358-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2800BAE4770
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 16:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5DD93A740C
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 14:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFCE271467;
	Mon, 23 Jun 2025 14:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aY8alQPv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834C726F443
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750690130; cv=none; b=VWYJzVOLKUS/iCq8lZVT4anF/YkEYDxLySYYhjbDhdiC1OtiGR7Z8vyWFZN0GwAuVJ6bNLCKmH7oZS7rDWdVENyl1o5VYKqyRqY/Ng9Fdku4eI8oJSVvW7LqICsmQAQETbiDs4zLQVX9qu0UOaG6dmQdp0u5uGl3GfP+nyeM/5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750690130; c=relaxed/simple;
	bh=VlsUGmxf+pon5hDEC2z0lhmNAa+yAYyKo1KDeBwj06w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AygP88W+JgBjHad9YvFchYBvY4cNzVWLf3WUK+x63iPw0ODEKNTl4BDs56STI8padxB3jB2pUHM3YVnsuSqoIRSuxeaxUu2eqbo9zEhF6op9Gf6LjH+BXPpoD7yqVttpv8tY6s4MbUtlcxu5Wirc5fpwulIWDa47jGmnI44koJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aY8alQPv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N7xnQK012061
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 14:48:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sCgXSZ3a7Z3VMqyz622ohXltuI5TgPBPLHRciyIHeVU=; b=aY8alQPv0KeECGAF
	4Fv5+Hegg8s6H/0czZlVchP9Jwf2khowlOGYjTpdUj8YPDSLAzzPIxs39K6BZh2d
	cRbKzYv31ncCD61eXGA3hJAnr77fd2aUR9zKACUj9WGNjjHRs3og9KUMztBkvp63
	mUY/fjVYmip1EeMVPpXV7A3GT2l3YZSqZNEjmccej/yrMV3WsjveKV1jSgQlftOi
	Y6q4S+FX8+DT/E4j/2P16UeboED7Fiq70zRz9lRWR13SEluhtEkHtN7Djtfy4IHp
	D3TK0Mo/XSRz3HBLVdPJyYGSZflK20Pvwz69sM6K/iNw4GwBp90ncX50tnZ4VdZY
	HF98zA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47eah7u9mq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 14:48:47 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-74890390d17so3634293b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 07:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750690126; x=1751294926;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sCgXSZ3a7Z3VMqyz622ohXltuI5TgPBPLHRciyIHeVU=;
        b=XJOggWShh3/NOE33WEhKlzxF/acRk55HB+GgpVgAKNm5qhUQOOg6gcmgP958wdUicg
         oaEPKnScuSlpuya2lNhtdyVhBeyMz76IQA8+3knkWccD6+weVU/8b6+ZAezCiLD7QdVX
         e7biiLjMbRcFGVqDYcCa/vvJGXZOF8931sEnxEWamqtCIoNfI51ZCNblPOAbFMB6z6dE
         MshfDLjk87xR3T/jcO4nPpM24WeHInhxeciLmapVbNeM1pHtXMoxzIH2HNhG+lwPDBc1
         CRh/SHIiJFXwg1IJpIZaIKOxwDRYnybC94ejAcSlFZUvgglfspiei9UhtOLSHg4YaiM6
         WWVQ==
X-Gm-Message-State: AOJu0YxNSBMxGfnh8JBZAVuFIsSs5qMwuU0c+zRYHF0cucb5JVsc1akN
	s5Jts8/O/ABVje1uLGAXfns2xHrA56xRvjYhAHRvvv+bFUXw9qxKgmGEzCBxbRmYnHVr1k8LJKJ
	aTv8eTlSruRQMHSsbXasoXS0XidhIY3ylJgSDAlBaN9FidpE0hRrlN64lmzIdkRaBZttIMw==
X-Gm-Gg: ASbGncuiZ8EhL9z9w2RWC9h0UcIqY8Oh36zpyqaNO8lwfMyLiCCr+lwp7zD5/wxrhOI
	PuEEM9yCA6w56BD0+FOjcg0GnBB+9NF0uqX9CscaAScBZlo+SgdRmGm5JhgbUihxIxCxMHueCaN
	y+WB4mdLvAgTAFzFZh3U8YQ6cRBaTKISH6UtuSmOXR2Tgp1O1rVFVAy26StTYfeAEd+y8JilUCV
	k/m7t/6/caZCQbhjWNCKjH0HAe/IGyKaBtE3OztvpdGWQXSfcnbk+PQZLnB/TY2TpLBKxMWYk0R
	FR3QjbRQyXnRX6jcr408rnRmd8u1GXk7B6S1QrLCJvlowkh5/ZMTc61AAtA=
X-Received: by 2002:a05:6a20:7344:b0:21f:543f:f124 with SMTP id adf61e73a8af0-22026f59a3fmr23131379637.24.1750690126150;
        Mon, 23 Jun 2025 07:48:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFGqtCVjUZFXRcBM1U4nD9v12d4LME9X7ZOUw9dIyoCED9vqa/BJGKoM4PFDhC4Po49oe9gg==
X-Received: by 2002:a05:6a20:7344:b0:21f:543f:f124 with SMTP id adf61e73a8af0-22026f59a3fmr23131346637.24.1750690125761;
        Mon, 23 Jun 2025 07:48:45 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a6d1eccsm8332894b3a.180.2025.06.23.07.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 07:48:45 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, P Praneesh <praneesh.p@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250605054438.1855365-1-praneesh.p@oss.qualcomm.com>
References: <20250605054438.1855365-1-praneesh.p@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: remove monitor handling from
 ath12k_dp_rx_deliver_msdu()
Message-Id: <175069012523.3758471.17375985420748501661.b4-ty@oss.qualcomm.com>
Date: Mon, 23 Jun 2025 07:48:45 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: Peo-I5yZWIzsElEBSTHBPEu8L2FxsF-7
X-Authority-Analysis: v=2.4 cv=PpWTbxM3 c=1 sm=1 tr=0 ts=6859694f cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=NwdkJL6YhdxGdXyF1vkA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA4OCBTYWx0ZWRfX1yHI4sZFkTKo
 r9LfS6YKgLB796TpO1h+EdIsGqg2BBJOCZeRA1LTDnNrVKGBHfcDi1TXdtn22TTQC0Xg1eESl6L
 lsgGNug3muSFNLtoC29Cn0Ilpoxg76pM0VxZDth9H28Q4jJUoSdCO2Nhjz0YsYAWSWjMojzaode
 XVXUrCOKIHx5sEpcVVI5iIDbnqXKjplzCdP3oBIAAtTedveuc8KzuqZqJTWaWpnR5HFnxTLf2fv
 Ib3OiyFfgNUVI5DsrxstdRy6ieIHB75UU40RG4iYcHZSTxEF41eUMv7vQ70j4cwgdkT5aHxoepA
 yws1mlwrg9FrXYVFYxGDuL77eT13wJ1dZZow7g3MJN0Wu67IJrrD7YmUyCX1pzWUdRsG5YZlIx5
 MB6GMwK+GveNlbd6k2n/Fw40UOw5j7ZolU3zdA1jSZsXHL7hYXsA8U05V9lKVt0PKIGsRld4
X-Proofpoint-GUID: Peo-I5yZWIzsElEBSTHBPEu8L2FxsF-7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_04,2025-06-23_06,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=758 clxscore=1015 adultscore=0 mlxscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 spamscore=0
 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230088


On Thu, 05 Jun 2025 11:14:38 +0530, P Praneesh wrote:
> ath12k_dp_rx_deliver_msdu() currently includes logic related to
> monitor mode handling. This code was inherited from the ath11k driver,
> where a single rx handler was used for both regular and monitor mode
> packets. In ath12k, however, monitor mode packets are handled separately
> via ath12k_dp_mon_rx_deliver_msdu(), which contains all the necessary
> monitor-specific logic. Therefore, monitor-related checks and operations
> in ath12k_dp_rx_deliver_msdu() are no longer needed. Remove this dead code
> to simplify the rx path and avoid unnecessary per-packet checks.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: remove monitor handling from ath12k_dp_rx_deliver_msdu()
      commit: 359d69285adc4f4a6a4bdafac30f3bd917873bbc

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


