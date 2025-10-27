Return-Path: <linux-wireless+bounces-28316-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6078DC0E464
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 15:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7644C4F63A7
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 14:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2245C25DD0B;
	Mon, 27 Oct 2025 14:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Op1+Q5kZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882731F4161
	for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 14:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761573845; cv=none; b=tZ42a5lLXREgWyZY/Qf3SYe/fVAWmmFoQM5Zjrc6BSslEZhKZNNPIFHjwj+5K1c6Ij+ewALzcRVQ1vjGvE01RCLCwpP0eZsOY7g+M8kG8lt+UDp8xUqHPAFcfKanriI2mI4s+COBe/P/SIuaDh2pqmegncrcgZpJWZ0fGzHuZ1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761573845; c=relaxed/simple;
	bh=rS1fOXfMqQXvPa6hGYgImNOsoSSvwfxjEAGQpgmDOB4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VJCVD1PqYXZXxTrELdvt9oLAwxJiJ4PR8uUTIVD6FqjO4qKzuTW7s5VoO1FjJkq1MOSIBOoeA267tmdvdVS2uLWHhLvjtYylxjYaA5e5yMdUvn/zJDC5sucRSseiV6bHO4g3SANiUdBREf1BnjWDeOIHsArUSIu9E4vdSJOtFrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Op1+Q5kZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59RDhS0b2963114
	for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 14:04:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hu24l8t8X8f/xJJ8OqbvDIHaP5xTZrki9rKkEnx7h5o=; b=Op1+Q5kZjHd+4sar
	Hj/ViJYFgGJ3GZN+kL0EfzO0+q5NMQo5NPSr4lOCuOJwz9ZMBM3THcX5D9cH49RR
	/zCdrLqDWZzRBKBrziM7o9/v0Z1MT9UE82F1aod6wpro13Iq/B10zqJDKsdEz569
	ATLZs+g4NFfXdtlsmuiDwYWFJnMvX/lHKiKY2E63GXbPP2G7TP4PKB9jgSYoKaCj
	6qb1QdukswguwmmApRnwMCu/tjm+hgMz02lyzAzeT215PP4ZD4oZQgVDxEtNQNNe
	6Gyw6KSp34L1xcG6mty34sX5JGrGhEC4NP8QDQXKbrtFXYjsQT+JMTA3ysqcWi2H
	aUYB0A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a29v9r1uq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 14:04:02 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-33bdd0479a9so4844102a91.2
        for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 07:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761573841; x=1762178641;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hu24l8t8X8f/xJJ8OqbvDIHaP5xTZrki9rKkEnx7h5o=;
        b=CsW/ZjaLPezLlNoCCSHJ4D3jddNs5662x6RKKzhyjjxjboMhMqRdi1VgbGB80xM8EU
         ek50DKGTmNnUFjlG+tDzYiZq5xofZm1mAxWn79qOBdInT3+k5++oXMVzPlCn7HEYuQAA
         1tuGDtpBppvJdnZbdt2divDF/29cgpOr55159UbvaJpmmajrjuH5+711T9xqce3KOZWC
         bdqMqibTE3j6EITF3xsMUqR0daX9/LtTn0imJMhfHY0zqe8x6i2KtpJq6EQFyvi0Xsbd
         I0B2+32CDBZjwcvqudfLI5XqPSaR1vddy7AWpPPVdhba0cuXWrcLgQNlQ8Ox3mlb3GdE
         Wyuw==
X-Gm-Message-State: AOJu0YxZ4NcxeP+vDceLYXSh1JKjrgCudQ+IMRfgQfC77p/ryP7o/VIH
	d+I3nCTF6Sqf4OKLllXHtuEPoIRKqRcMMuphAwC+UG0H4lm8bZHFnHJLDqJGC/BYMmtUkaVrYla
	iQ2YN5QiFsbmIsdg6PU1nw7KkaDjQCXuIYdRQzZgmXP/f3F1qUrUZjNjran3kORhYHWbo7g==
X-Gm-Gg: ASbGncseFgofhU2gchCavtamq5bYX7GRosgwTNqUFrxKRLhx0CsUlnYe0GSbgZWIfy0
	vurQba9oLOQ7xDRSfcUGSMQWq1E4OdnUm38+jaov0oKZWtXIZ1ZD2gM3Ch9THBKua1f9oxEu/J+
	556cmHJnW/MccX0hKyInqat5SycM8BaeXKIDY4dcwixslKsVJ6w8hi43qq29xRMfSu7lPDEjpxA
	9WQLZV1crdSpdpdBJsOqjtQBWvOfrceuja3ChfLOO/s0WRYZDeUpsXQR/NVwEA2m4VzI639rWb8
	yJG4SHBilttdMUdokC7gcvXo20Gv5ExHaxtW1doYPr/gpj2cB9knhpvVASx2/+be+xI0p1mGHOZ
	sAD248V+3AOoevGp/yQ4uCFs9t2oqUlQnwbM=
X-Received: by 2002:a17:90b:3fc5:b0:33e:2d0f:479c with SMTP id 98e67ed59e1d1-33fd66b42dbmr13564749a91.22.1761573839953;
        Mon, 27 Oct 2025 07:03:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVrhYFLGJrFEFxAjB79L3hU/gm394qy1xmuPF7hMFnkJhfGT7xIHgo7Bqqbr4CEcmUrFRhHA==
X-Received: by 2002:a17:90b:3fc5:b0:33e:2d0f:479c with SMTP id 98e67ed59e1d1-33fd66b42dbmr13564699a91.22.1761573839160;
        Mon, 27 Oct 2025 07:03:59 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7f3aeesm8620313a91.14.2025.10.27.07.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 07:03:57 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Ripan Deuri <quic_rdeuri@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20251024181548.3255166-1-quic_rdeuri@quicinc.com>
References: <20251024181548.3255166-1-quic_rdeuri@quicinc.com>
Subject: Re: [PATCH ath12k-ng 0/9] wifi: ath12k: Modularization of peer
 object
Message-Id: <176157383748.213109.7770176959041227936.b4-ty@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 07:03:57 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: IITJf1lonFJDwvhbcJlpYcZ0u4Ctja8y
X-Authority-Analysis: v=2.4 cv=D/VK6/Rj c=1 sm=1 tr=0 ts=68ff7bd2 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=xMiiiAbsooRf6sH7C_0A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: IITJf1lonFJDwvhbcJlpYcZ0u4Ctja8y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDEzMSBTYWx0ZWRfX7+p0NZwyA8E4
 wm8fEibHNU3YV8jfFRLzYSGlxBJFER9r7Gjh1fcbi/ByWO4+ktlaeNNf0v7xyFAQPWbJK1CgZ/D
 yiFyVB7Z75SPsQOY2eFJQzk9O9L2cBLTr9OgQd5QhoMy95KLszLvolGDeUcAiEHC9igyEEMq4tX
 n7uRZudxXXmdbiTqx1Sz2/Fty+lQA+qsBYeYfnTqm9JdcTVoeUzMQ2qHf4Md4n6bxlvB3vo83di
 2kYNcsnGCNnseK+M5RnMNKbTSo94X4NTh1FULpnwg7L4PlwuQydeWG0la2+4Jb061I8RyJx2TYf
 Q0qNywcz8xZ0SoA3fdbkvpxg2M6zYYo1bIn2uCyGWfy9zGIAG4bzk/cvWI2kceTP18Ef/PMWKY1
 GtgVtFdxDD1U092mcIUxwp+ePtd18w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270131


On Fri, 24 Oct 2025 23:45:39 +0530, Ripan Deuri wrote:
> struct ath12k_sta has an array of struct ath12k_link_sta wherein each index
> represents one link of the connected station.
> 
> For each ath12k_link_sta, there is a corresponding data path peer which is
> represented by struct ath12k_peer.
> 
> Diagrammatic view of the station is a below:
> 
> [...]

Applied, thanks!

[1/9] wifi: ath12k: Move DP related functions from peer.c to dp_peer.c file
      commit: 07174dc94269758e271cba01680a8fecf35169dd
[2/9] wifi: ath12k: Rename ath12k_peer to ath12k_dp_link_peer
      commit: 9e0b56a33384c670501632810634553a767912d5
[3/9] wifi: ath12k: Add hash table for ath12k_link_sta in ath12k_base
      commit: 57ccca410237285f8f25a988655e6910cadc63f2
[4/9] wifi: ath12k: Move ath12k_dp_link_peer list from ath12k_base to ath12k_dp
      commit: 0cafe8cc85665f29b28891f4b921bef1854c2e99
[5/9] wifi: ath12k: Add hash table for ath12k_dp_link_peer
      commit: a88cf5f71adfc5e7412a505ee0077628231c6d80
[6/9] wifi: ath12k: Define ath12k_dp_peer structure & APIs for create & delete
      commit: ee16dcf573d5e3283fda601dd4bca6bc52251017
[7/9] wifi: ath12k: Attach and detach ath12k_dp_link_peer to ath12k_dp_peer
      commit: 5525f12fa671a007c6c6044c861eee86de71b576
[8/9] wifi: ath12k: Use ath12k_dp_peer in per packet Tx & Rx paths
      commit: 11157e0910fdc9ab8077af69fd4496b80d7c39a0
[9/9] wifi: ath12k: Add lockdep warn for RCU
      commit: 6633dca572d8f599b0a1ead0f145a52049ec7709

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


