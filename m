Return-Path: <linux-wireless+bounces-24359-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB39AE4771
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 16:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B220D3A791A
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 14:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D4B27146F;
	Mon, 23 Jun 2025 14:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LokQaH8Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80E526FA4B
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750690130; cv=none; b=jA6FHwuTDJtdwwKWJos9BckxNHHXRgrMu7vmB8Qj6iJGFE9BpNHVuABeT1m9YG5qvOSKBBBjZx4oSsjRWFLjPC+rlZVBeQSSmzyynnh4CCMjaBbJzbr46/JDGGDEYCvWCySQYvq0PnCntQ2o3PpxYJg8H+JyblfkD2eiaa8/JdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750690130; c=relaxed/simple;
	bh=yvlYd4dbjSUjIBNRZzDKmMEHPbgxHrqQOaI3JWA+3Rg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ngjandx78pBwSoal9QKXkVyxONc2Z70Qjy66wATm/lAl7xT3FBZVDnVWRuGtZKSu7o+ggNtAKs2jx2sYQwnYyPersXBsWEbm32SYnaKgg0Zmj1vvmP78CazQZ1RTxT92HIcIj8TsYwSizhg7SGq2DuJ7K7rHmUdUiK+IbNhgn/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LokQaH8Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N9TZCc020990
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 14:48:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jL53GIzW1YQNgAFT0SEfQ3DPFkMmRybAJPTx5wu0aeg=; b=LokQaH8QqZi2vENR
	Ces2iAzH6yh4+iVrYszhyrIomYFqPep8nsbIgT/carlBBoiuhIo9736lt1QO+PYE
	KwNARHUp12hPLkS3s35kMMH6qWcnEKjKDqurKcDmOry4BdtVdSk/w+dIjnRzczgZ
	Z571Jhbt3qomssVMbvNllvtYry1d4ZGOc46/cGtHmI14Yv6yUC/Rq1AgyVWnq4VS
	OnBukJgvGmaqwrXohqS5BcXA1tmn0x0oYR1PPce/jzp3+4zx/Kj/L7H4Ytu4Tb+F
	Y3IUwNqyfvvmoU/Ndnxf9rImj0jV7AnnX6ChuDyfSF6jqml17Msra3WKdHSivfAY
	30Ikng==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f4b3rvx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 14:48:48 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-748e1e474f8so5942460b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 07:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750690127; x=1751294927;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jL53GIzW1YQNgAFT0SEfQ3DPFkMmRybAJPTx5wu0aeg=;
        b=ZWoTvKW7MWPaU0aOOlNgr2Cz4TcZ7G0+6kA4VEayXNWcSS6LrSzYKm3ZrMC2jAPcTp
         et8n0fhH0FjhPfDjwAmm6qDZ9/P+GUt4l9l5V/yUF+GU2Z1qXIkgibzk8QvTuQQWQYZd
         FwW1gpFuLesxkw7JUZpYNOmCwTrtQHOGg+juvuVL5oZjXFYKRPyKQrEoK1VIAfdp4Cex
         e55xYxkNd9HoiLrYxMs00LcecJoNyVLidfe2fTLfoXvrj5Z/VJ8xNXGhQH578whlOhEf
         4/4kP58CzOXW+ApTvJziexYdtYUGW3hyxlgIpjcCmAQqnb+ENEY7jl/ULPkWStxAyECm
         MP1A==
X-Gm-Message-State: AOJu0YyVzkhIfQCsLe5M22QwL6JBQpgqXf3W54QkgYW8K3TqUvODMCaQ
	MCw9YZwJw4Qqm8iiIiQpJFefKaOXb+Q//9wPIx0LAeC4nbm7f8y6+P0Bg2QSbecTHLS55461c9K
	ff/FDfX9x+f8llteEzi/swx8Yc3T/qRLgpniVaFu8KC0AshRKyVo/h2iGaaeju+UNYEDdTpWEmt
	PqjA==
X-Gm-Gg: ASbGnct4lJIQUqshOCTAOnQavuYGS6Uezd/SCGXBMK/RB7PlfabjiS0OhTBP9T0IZ7A
	n8wapcszdQtCwPohl+Wxf+XuheBDXHIeC4PN8f3MgT2O4VBSn6TtJ0G7AUidwUtisMvVos7mqew
	6cGknh5FXMXmSH/p0f9RUrzCtoGtZyAmE9QL2EcKBnux76U6QSbyPTQkyWGPvJ+m+SirohPLcZ1
	vFY/2dC2pg+rqp/XcUMHZ39OH++xxztIWEOzkdQoPdKEVN+htKRAwFSixfhr54dS+a7nVpARgmp
	o4InE+jsRfWqPmnN3Qtr+79fgYwcG/y6fp6N/czuqmwWqLhKHN37Otqj9oQ=
X-Received: by 2002:a05:6a00:2441:b0:749:bb6:3a8e with SMTP id d2e1a72fcca58-7490d66362cmr15485870b3a.1.1750690127082;
        Mon, 23 Jun 2025 07:48:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHt+zgIJ645NaXccJiszRqJetvGZMio30LcEgL+EDMn/ttkXKdbZSgYKM0OLlfh6O2Kc0etRA==
X-Received: by 2002:a05:6a00:2441:b0:749:bb6:3a8e with SMTP id d2e1a72fcca58-7490d66362cmr15485841b3a.1.1750690126646;
        Mon, 23 Jun 2025 07:48:46 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a6d1eccsm8332894b3a.180.2025.06.23.07.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 07:48:46 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org,
        Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
In-Reply-To: <20250526034713.712592-1-quic_sarishar@quicinc.com>
References: <20250526034713.712592-1-quic_sarishar@quicinc.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Decrement TID on RX peer frag
 setup error handling
Message-Id: <175069012591.3758471.12085244120695537046.b4-ty@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA4OCBTYWx0ZWRfXxtq0vzm4iY2D
 R/PJyeIlfanfWUKBJxycj/xuIDYHn+8l8g6khx5ReVnC0NE3MzGFi+pbwMaUkMHpl9u/Iiamwdk
 rcayoBuxhrmmx1v0h3y9YV3Z2/+XHaQ7jXjlnkpfFg0J8uYjQCxjbsbNuCb3Sun6NB3JujdxN4F
 Beue2Uu+4xyKHESDPXym3hcF2j2W41LaV2Ufm4MJ2tMR3s7WTQCgTlcAiMMYb8I7Nb9E2ARE7bv
 cruF8uPo3fGhHq8O6AUmyOhyespGpDhok5FT2jCvWnetzgwd5rBKIuY4J1MolqjlJiSssUuHFTm
 sd+XytVp2b6ww2cM1PD3lcorI4ScYZeQ2NtBzDKulJh02k2e4SWRGkqmAgvjLUdOvE08xDR12xA
 fICBzwna2SYKcr6pT04nnFvNa5xrvGTpk11DWET7LY3/mKWcWAnGlhEKCo6+EWBBHwUSa7/v
X-Proofpoint-ORIG-GUID: KwDVwgR2vHxzbXMOdzrS4Bq47MOM84nS
X-Proofpoint-GUID: KwDVwgR2vHxzbXMOdzrS4Bq47MOM84nS
X-Authority-Analysis: v=2.4 cv=A8BsP7WG c=1 sm=1 tr=0 ts=68596950 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=BsdNM8JOicQgXtT25-8A:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_04,2025-06-23_06,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxlogscore=628 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506230088


On Mon, 26 May 2025 09:17:13 +0530, Sarika Sharma wrote:
> Currently, TID is not decremented before peer cleanup, during error
> handling path of ath12k_dp_rx_peer_frag_setup(). This could lead to
> out-of-bounds access in peer->rx_tid[].
> 
> Hence, add a decrement operation for TID, before peer cleanup to
> ensures proper cleanup and prevents out-of-bounds access issues when
> the RX peer frag setup fails.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Decrement TID on RX peer frag setup error handling
      commit: 7c0884fcd2ddde0544d2e77f297ae461e1f53f58

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


