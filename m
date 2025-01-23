Return-Path: <linux-wireless+bounces-17864-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E29A1A787
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 17:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E4E416A141
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 16:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107C043151;
	Thu, 23 Jan 2025 16:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LojMsnYS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536F323CB
	for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 16:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737648321; cv=none; b=YxlkP9LOP9jJT7FhlKprz98vBLxQB6XQVG2I6xSyhtTgFVRCAW4k0GfG0yADuh/OcLhAAGQ3+n08KMW15hsRp/bGLoSaQZiJiIgRuy8hPd3f68k3l8zWf5ZFeylRs3bETWMSxf2G/AJ3PX73NnAndA6A13cRFtxcOiB1LPabDdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737648321; c=relaxed/simple;
	bh=XziUO+Ynk1/5iv9BpX9ZGLFx3mBZPfGquw1XFrapAQU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KL9B+j4zrtyZYoP9gDrSN8So3oMYQ1/nGsaoFn+eN93omv71jY1Ju19rL4++TnYBEAVKgZrLuK8qdQVlBsJErzaxiY3vLQ6hmg6SQT8udqvbAbvuAiOrUHjmiFWl2WI1DsAJvjhDEIG+zlofz7v1BBwePJFN4pKjd7ZEX97LcyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LojMsnYS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NCsg2H001041
	for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 16:05:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5Uv6cs99HiemR8V9/EwDXZ5/vBIcxjSGZn2hCS6ayd8=; b=LojMsnYSxSN4EwmI
	7crfh754L0owWMTvoKELzHBzGgJA9kNYnSDZWaF0q53gqyD1S2IT/9xRg/zihlz1
	HY/2M1ZlVXQT0TyMd7vns98oY5wvp4oaxF/1q1f1MzrAw/aLHgK24uMo2zfaMjTr
	lJiSNT6IjZKsEGKDs5lpYGYSYrMb10kZ9naJoYMNF/rgMZuCLUSmpniMMuq4E6s4
	niosR8QGwTjkjjndie5fhXTCCmz9oG2B2W9iqbMHxizopgZht0XsuH4Qx/0xkwS4
	wvQIu17LbvjrPKJcRUtgC2NzjVjbL7emz4VF1/QW3pZKMdLa4xzZeOg7/qY6tYri
	ETWf6w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44bp6grey8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 16:05:17 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2163d9a730aso23475205ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 08:05:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737648316; x=1738253116;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Uv6cs99HiemR8V9/EwDXZ5/vBIcxjSGZn2hCS6ayd8=;
        b=PhSw8a/SPKWHu+0aF+lTa25uyjtjDFoEPDc0a4P1d+Q1zE1qLa3xsM6CmL5tPyL0q5
         yD4Zw3H7/EdHbwlHO1OslzbAI7qejxkJxhvBT2EgutAbwAbY1g/AbN5C2Q2MEBXo03mK
         y7EwvygsY+D5PZ20keZqvRnNvEeYCa7Tw4Tf0IHV377KcYS1kQE3kIFYPtmtkGCYIflE
         +hzn0PB8Gnrk1c6aAhaiSwjcuusCz58TdOfBqOCUqO4/fDCrLEOER9+b4ph1dFP90M7d
         Je4zSMOb8wfXKBZ/E2Lm19DatMsxqxAMmDTxmUy/0mBzuM6ugm26Z3Lcdb7/NrTUmQ4H
         //7w==
X-Gm-Message-State: AOJu0Yxg32DYZD7fYyQPG85ONl16nlJaMoTckzjiFmDeLOgpl+M/ZSq+
	EaMuLnf4YDEoXn05a1CxjcH1HY/dkXvgHsdzTQdOUjpd7V76qmyfnk8e3fKwJyvRGhcEsF/oXP7
	WSlDYsp7tne5EvZ8I5oHS7wz/8nWBl/o5b3pAV06VNbI1Rbc6+oDdquOeMX9zSAoPUtXGwjfIFg
	==
X-Gm-Gg: ASbGncuea9f5/eGOEBVc1QyHAJcLbA/2oS2srv+VRDR/FMyjMhRg2dcGxbQQFKqBt2N
	yidYVYIqfx3/wya8gdSAcYi3eC9ESt0x9ha71Lu7dxecbDrBTxiy6ZKLRFO/Tnz95XbbLe/Qm07
	v/8kSi5+1yy1spXBcL50R8hLO09N5emy+E8v/vxF76cr1FpQe/9/SKZT6qxo6D0wLlIhPSYgpLS
	JEjHgcBM51H5ZbAMsMsM2ezeeCYA66fmbfw3irR+QNTAk6niRucLBRz41arwcaMxY7KwY3xXctw
	aI7ngmnbKpESk0aG9M0hfb62qQ4cdmI=
X-Received: by 2002:a17:902:cec4:b0:216:2aec:2d54 with SMTP id d9443c01a7336-21d993758f9mr58707985ad.8.1737648315965;
        Thu, 23 Jan 2025 08:05:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/w3ECZuU9XMGE7OTNVjAzf93wcIjLnJUXCGoMTHsAgAo56Wg2skOEaSKmhSQGyueIEnxQgQ==
X-Received: by 2002:a17:902:cec4:b0:216:2aec:2d54 with SMTP id d9443c01a7336-21d993758f9mr58707595ad.8.1737648315574;
        Thu, 23 Jan 2025 08:05:15 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ac490ad020asm36924a12.39.2025.01.23.08.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 08:05:15 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Nicolas Escande <nico.escande@gmail.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250122160112.3234558-1-nico.escande@gmail.com>
References: <20250122160112.3234558-1-nico.escande@gmail.com>
Subject: Re: [PATCH] wifi: ath12k: fix skb_ext_desc leak in ath12k_dp_tx
 error path
Message-Id: <173764831493.2737165.16515667223221319089.b4-ty@oss.qualcomm.com>
Date: Thu, 23 Jan 2025 08:05:14 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: gnrgzRbLrbOvMmufaYTLlurHzZMWE2lU
X-Proofpoint-ORIG-GUID: gnrgzRbLrbOvMmufaYTLlurHzZMWE2lU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_06,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=832 mlxscore=0
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230119


On Wed, 22 Jan 2025 17:01:12 +0100, Nicolas Escande wrote:
> When vlan support was added, we missed that when
> ath12k_dp_prepare_htt_metadata returns an error we also need to free the
> skb holding the metadata before going on with the cleanup process.
> Compile tested only.
> 
> 

Applied, thanks!

[1/1] wifi: ath12k: fix skb_ext_desc leak in ath12k_dp_tx error path
      commit: 28a9972e0f0693cd4d08f431c992fa6be39c788c

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


