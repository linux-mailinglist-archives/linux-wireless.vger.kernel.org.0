Return-Path: <linux-wireless+bounces-17343-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C4DA09C4A
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 21:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C4AE188F74E
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 20:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5DF222576;
	Fri, 10 Jan 2025 20:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VBJJE77p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A460222587
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 20:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736540267; cv=none; b=A/CGV/v/FQhrWu1R/dsV36936nRWzx1xMebur4q47AHWiKqG2qJSgOtTlgBcnf6Doq4vV/+L/Pz9gFBqnS2y/GCJotDuFaeSmONvBh3WnlZYJtuEl+BTPk8NyPkjvrAQHMH7bU7Zfbouau0PMnGxBRyYoY8Vdm+HxM9KBmGADRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736540267; c=relaxed/simple;
	bh=N/ZbXOKJS7JnTGTbXILexRKaBodXlaSFUWYkTBZllSY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FG4SHAWRbEZp46aF82dnRChH3m6PMZd69UlbpY5Fy4Zd3WKrjniBPklrwguZO78kNg/SWL6dEaJa+0VmCjXT5SnfSNPUE3nOP7O1jT+PyPMzd2TkNXabmbG9Mu59Xxg0mOOb1cWOz4Pnu1zMqn+GehXmU8BE43WCWzlvyPrWtwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VBJJE77p; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A8f2iB005844
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 20:17:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hhR//cb/O3hgA+LuYaOWAbog2GV7hLvtiZo870lzarg=; b=VBJJE77pk56C7zkv
	/yoaJTK7iSbG1PbEpAk/zWgfN27Oj9DFZNzXDZLzFWxFStywXy1GO4Dsyr/g46Z2
	XoJXgbJjp0E6GYEjaFpqDUjv6jXvVS4y9EJNhaqyKxaZXpUyLDtqmpKzbxXongUv
	RfpKsoeBOsjyYGFPwQPuNeTXIZqDSt41SVgb1wWohOG2ldh95JqXH5xgZRtTdB/K
	+AiGeuhz6gRaW1TuaiX4sjeIvQmnlEgAgd2n8xadsW4PCCVmRlVfmv5j+iT5jRpe
	v1cxGQCS1bSKGhwdgafeeCdj5j6XpChbU46hcNAouO/cMJZWL6rIQEZtDA2P8KbA
	zFCa+w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44308f9s1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 20:17:44 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ef9e4c5343so6276748a91.0
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 12:17:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736540263; x=1737145063;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhR//cb/O3hgA+LuYaOWAbog2GV7hLvtiZo870lzarg=;
        b=kaecxtgfUoP0JVz6A3LQ4ksVNToAgTe5g5sVqr5hRzqz/1Rivmp/hQqVO25Cthurbr
         Wqwc1hP6kfAnU5BrP5+ZDDzzQPRF51IZ82Ohg1O+cmvJev3Dgx5oSwLICHLKCuRBo8Yh
         bmn/iQJSKmSAhrfklC5S5YX9O32U34/FymyXSru/Fe2Ttod0U2/tHixZ+0RXQ/dxuqdl
         IPR8olBXIglx/T/fWhBdmCT5hfZ1zWO+I6sbKbM4IB1I1qQbzU4fqq7BP8BmlOg3Bd4i
         MsCaWHFiK144IlhRleQAlKVXQktAjlTM9nhfiFK2CYD9a1m32teOESWDv6y4e2gwTZXb
         EPLQ==
X-Gm-Message-State: AOJu0YzK6FUa69rdK11Bnle8Zre+4KiT3sPn2wbxdJAhDuqM5+rbVJAA
	9s1WOkkvEelnxJ7TAK3fiIoth14UtxsYDD7PuR8PFLjoKwNWvj9X/EpVLSJCHOMsk6GFGtdQnvy
	737iuHq3V7m6jZaZyXwVN+eM+0trD1TyMuHihPP3r7okhM/WgravWAW26CoGcqA+WYgWyslccCA
	==
X-Gm-Gg: ASbGncuPBiyjdgCGqif4lzXrad84B8bu1of1xytU312oIMPdhPu7E0El0Q5Nx0yzw6g
	SiVTlV9cxy9dAhwHR24ncTslFgck7ov98ZeLwCPeXGxaAkM118c8FoQa5tC8Sk/TqC1XAldBInp
	CBqr0cAzcAgZ7vgmLFV7ozUFRI6DOqXYUBWZBaAixDDnZgN3dFzZIvkojyhTY1EDbamsEyXP9bH
	XmNMHIA7mRPR9/n6kzK6x7d6bivt2A+v0vEEntWa82rziqb6DZTgymLI5yeMtLx8wN5b+7LlLT7
	USSnJHhP9bq83lX5Cw==
X-Received: by 2002:a17:90b:3bc3:b0:2ee:74a1:fba2 with SMTP id 98e67ed59e1d1-2f548f6ab77mr17574457a91.20.1736540263251;
        Fri, 10 Jan 2025 12:17:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKipf/Bwzm7nvQv17NJQKJJDSW8l/ZmdcMDhpnoJ/QHfe1gV44HXEhppGR/6sXggp8TIA8bQ==
X-Received: by 2002:a17:90b:3bc3:b0:2ee:74a1:fba2 with SMTP id 98e67ed59e1d1-2f548f6ab77mr17574432a91.20.1736540262858;
        Fri, 10 Jan 2025 12:17:42 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10f97csm17208985ad.16.2025.01.10.12.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 12:17:42 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20241128110949.3672364-1-quic_rdevanat@quicinc.com>
References: <20241128110949.3672364-1-quic_rdevanat@quicinc.com>
Subject: Re: [PATCH 0/2] wifi: ath12k: Support Rate and OFDMA Stats
Message-Id: <173654026220.2979765.15903710932436060785.b4-ty@oss.qualcomm.com>
Date: Fri, 10 Jan 2025 12:17:42 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: 0Y1QVp9aLKINAuT9r56r1w9sWbbVjXBC
X-Proofpoint-GUID: 0Y1QVp9aLKINAuT9r56r1w9sWbbVjXBC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015
 mlxlogscore=828 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100156


On Thu, 28 Nov 2024 16:39:47 +0530, Roopni Devanathan wrote:
> Add support to request HTT stats type 31 and 32 from firmware,
> respectively. These stat types give transmit rate buffer stats and
> transmit buffer OFDMA stats, respectively.
> 
> Pradeep Kumar Chitrapu (2):
>   wifi: ath12k: Support Transmit Rate Buffer Stats
>   wifi: ath12k: Support Transmit Buffer OFDMA Stats
> 
> [...]

Applied, thanks!

[1/2] wifi: ath12k: Support Transmit Rate Buffer Stats
      commit: c9f6ee2701d798c2b79b8557b842da7b106fcd5c
[2/2] wifi: ath12k: Support Transmit Buffer OFDMA Stats
      commit: 3f482f2434753a0647dc8753a127f86878348458

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


