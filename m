Return-Path: <linux-wireless+bounces-24586-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C31F6AEAA62
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 01:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D624D1C26AD6
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 23:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145EF2264A6;
	Thu, 26 Jun 2025 23:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MSrSids7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7547B2405EB
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 23:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750979726; cv=none; b=Rp4p7hI2m8dZ7UUQp5/I1jaH5l1C+AZuOEqvm7izAULVYbM2Rf+XSc5A0awzi71R4OuB2QyOJafeBsO4wA5stwvnRkvbli5UPeXza/AAPco4jxz2jm16qBqYFLdDjoyf5EszEyFr76yOXHQJCW0OHZVC1jRZzbfDZKoV6iDYF2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750979726; c=relaxed/simple;
	bh=DPR8Kn3LD0GKokzUon71+ahZuEuM7HCui8M9PftCYsI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ktHPIh4yeN1C7qnv8yqBI1mcR1igBFUVtEOOkeO6gX3njUCU5mf+n2srhGE0/egUWEDQHfC9xIe6WrnF+Rwdjxtk8ZVX0ArqVGyWiXG4PKvW5uR1JR0lnme52YTWw5QWR+bOd38KsG0OPlNKcL5QmxOsNK0eJDPW4B4ntC6NuS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MSrSids7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QK6kcq013221
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 23:15:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	feBEAziDbBhk40XMqRH323WRC7gKriBS9CHHoFdAY/E=; b=MSrSids7WLT0YSRx
	1Txe6hc2hreOQvpvQfZBc1rS/zOrvpzF3DQ1lPnTN+5YLyvzBh5wlAXG1QRIza85
	kGexsAGIwDY4w/2rGhAifqrFqbepAsp1WJN1CvGxxwP6JpmTYpHAbRoo8d98WjU0
	1wUmPc8lTl0Pj0plvKh1zNIdobdUiOtSoiLs5Tf8U+Np2K/TSJW6ypPuCX2UlZ5E
	+BK2muFZGYVcxpTO2HKBWqeTbHEp3X2M9LufCeaMIIpNZeHuIn3kbv/dFz/IxcHj
	/m+a687XBVVDRTRZxiZiGFdVOP7tKv9j2mzUKtmMMWP9wWwHp4ocZ93GimRurpX5
	rBP+kQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47fbm23deh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 23:15:23 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3132c1942a1so2319693a91.2
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 16:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750979722; x=1751584522;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=feBEAziDbBhk40XMqRH323WRC7gKriBS9CHHoFdAY/E=;
        b=U2pphBjZ0V4bgFDih0NeWQEn6JR63jyF4UVGLg5aR9p6Wjs7dpCx317sEm2JLVV6RH
         tGFWJu7Hz1leeB1d6BU3Eu4ZJOu1Dsu2pplTdidH6GffjdUpDVajZGr1bT+YQDERK3uE
         lJy+8PcIwK9a8DvwigJUHYwzivlD1l2CM0LVNJNII2ybIq+4DvyitXvTz+bLUmTYKu7A
         QZSvgGjKljazpRx18IvYVLgImEnTc2/ANNl9i1Bw8Mz9JMSuTJOccOHQNe+/dyc4d/f1
         VwaUr3hu1uW1rMAhY66+YmnN1qFPscJcIDOQbKCX5vlYfTmJO2LB+nwwx0Fzobo8j3MZ
         rSLg==
X-Gm-Message-State: AOJu0YzU9hHnoQ6dWSUCmvhNDPtZxPrl7JH7Zbv+Kw5+1pZ/p+mhbfaQ
	/Y4l1gfK0m5hyHsMQPILH7mRPCDTau1+ytH5uT9euvEZbTEmB2Tzlll1RhuarQN7xW9H1Xjwofk
	zkp9kTtLZZRAjbF2nhxaH4bGHQZg3tek+vrUrE6nB0h5oji5UrEfyMG9x7dJs1vL8yRzN0Q==
X-Gm-Gg: ASbGncvQ4aP07EKJtVncfR1yxknUbFS9VBLM3Vku6gAQOhwp18nFgaLfA4cI3EA1Ks4
	FipovNACHUrd3dQupFmpiPqi5ujWBZeFocuMThtPddvwOLex1UiVOY5gJ2112OsnVi/NVaZHSx4
	f7pZJkviBYd2yO1VJQ5KtTDv7X1tgk2OqAplvBZ76U/1TTZJ40wfy8hh3NYBrM4DfoHfZir8fhV
	nN6vbkVjR9uacj28nHD0qtmDAMqoqqw9FrutiMI6RnPOm41ES8/94y3mP8/AfCKaclKmzpIa3Gv
	Y20SydUJdFXLwetkxqDC4TE+gNCtnSNioXudMktrRSKda8zLFZG11uFq+4o=
X-Received: by 2002:a17:90a:d443:b0:313:bf67:b354 with SMTP id 98e67ed59e1d1-318c8cfa54emr1535777a91.0.1750979721819;
        Thu, 26 Jun 2025 16:15:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEU7HL9zI+40GnbkCI4yRMz79dFM+dBPlbb34Lvze0KHCOxzHg3vI3JvtxVzgSVp5cCpBD1oQ==
X-Received: by 2002:a17:90a:d443:b0:313:bf67:b354 with SMTP id 98e67ed59e1d1-318c8cfa54emr1535751a91.0.1750979721439;
        Thu, 26 Jun 2025 16:15:21 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3adeeasm1548105ad.156.2025.06.26.16.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 16:15:21 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250617051136.264193-1-quic_rdevanat@quicinc.com>
References: <20250617051136.264193-1-quic_rdevanat@quicinc.com>
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: Support TDMA, MLO, RTT
 stats
Message-Id: <175097972093.153431.14008414767992768742.b4-ty@oss.qualcomm.com>
Date: Thu, 26 Jun 2025 16:15:20 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=YYu95xRf c=1 sm=1 tr=0 ts=685dd48b cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=WD2RVSGR4ZOmZR8fVjQA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: AqhCTUhTSt6Dmb1ciHFkTCaJMrE4MU6f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDE5OSBTYWx0ZWRfX7JtGlfpo4H/B
 5Bls0MSPAlE17kBs1PI+ZpnUaemz/tSqPpwbcV2o4XNc4ND+KUenzN77GeRuhz8A5ZnItRqatuG
 jVUeSw15hq3HGzBuNyVV7VWzxmHri0ybA9E9ms6R8R/SMOL8+4Jxwn4zmiaFMplhatZX1Ml3Pd8
 KRHBgIcoyreQj3RDWluAzsHdWVGiv6f430t3B1AFaje0lc0PyIOmmnQZKEmccLC3u9XxdVwr/gj
 j0Tn5ZhziI+aJqG/p/g5OElZH1hoj2r/na09WqsLnXYZdqqfeLuLggECGBmblMbdb+3ULnjHPFf
 vYlHEa6BV3DifEIgO+byK3boqA0IDCdJZw31Ajg2Oeyj1yHb+xoUbKbBKUoeVHLI2b6STtD2iRL
 Nw9UiRZ1xdx6RVKrSoBtlw4qVWKrXPIy5WsV3XO9UAVjB+Lm4h7ZQYqSlZKrd2ZE/UKK2wvE
X-Proofpoint-ORIG-GUID: AqhCTUhTSt6Dmb1ciHFkTCaJMrE4MU6f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_07,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 mlxlogscore=803
 clxscore=1015 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506260199


On Tue, 17 Jun 2025 10:41:34 +0530, Roopni Devanathan wrote:
> Add support to request HTT stats type 57, 63, 64, 65 and 66 from
> firmware. These stats give TDMA stats, MLO scheduled stats, MLO IPC
> stats, RTT response stats and RTT initiator stats, respectively.
> 
> Maharaja Kennadyrajan (2):
>   wifi: ath12k: Add support to TDMA and MLO stats
>   wifi: ath12k: Add support to RTT stats
> 
> [...]

Applied, thanks!

[1/2] wifi: ath12k: Add support to TDMA and MLO stats
      commit: a7f74e782e274e8255808c165cb2cf63ee0876cc
[2/2] wifi: ath12k: Add support to RTT stats
      commit: 81a0286cefe6f81744160d3524d70e67479b314b

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


