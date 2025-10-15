Return-Path: <linux-wireless+bounces-27990-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10036BE10C4
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Oct 2025 01:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C97E189B84C
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Oct 2025 23:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FB131A569;
	Wed, 15 Oct 2025 23:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VtlVbtWF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F0F31984E
	for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 23:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760571634; cv=none; b=dVytkVZ8UtkAO5lqgARNM0jv44Rig1x/l8dBXvstw0yez3C3cTYoEUai5zdQT5CTgArJevwVNED1QBiMfE6kEbGTwfPGu1YGhYUmf4HtueOrVLMHD450IeYIPFDdkK/778Dr256WxWnyaph7nynY50TrWTIKEBWJC9iM+GkLt/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760571634; c=relaxed/simple;
	bh=CyFBIl6hNJpzBryItW2d1r0BB9NiTGWU1gmmRD/JvO4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=C2KzzWv1bb5AMc4bFZq3Ggl9SdJekbXM68X9dBTnORR4eO9TBRbPKuXS+XBllWd+DmIT+RupJ1CkT6yyXfXn2Hg4w8dB9H/IMa1tEUp7dNEVrKUVzLaN8l85QDk1FZ+bl5/RZ+Elulr+84cB9sQEOT4tHF6lb+3dh8NCIlhskPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VtlVbtWF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FJ5LGc003535
	for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 23:40:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b+b7fUgZwhhMaLQsGZ0tNXlB2cPB46PT3vVgnAlTc8A=; b=VtlVbtWFuiK/Px1f
	ZeTTrOJjRGBTNh6AaZyF232N4ZERwcKRkVFYmJqwz1XKFE6pd3jGxRr//FAL5D88
	vWSGUEuYNL2SlT2JiEbESMPeqaGHJFtogzT9MWd7sZ9Bb/HVRzWALktqYJZI9fns
	zClPWm7/RFhZHA5mYcD1TOrAm1ZqsSuu1u12mSvCS+QDsQGHZ5q7W+18/j2suFt8
	GKDRfNTxTj2wLfkmVbUKWPYqaR2pySgO+xknSqjN9eW0gwsD0sTbrLyKtVuBFgV3
	/p7dLhfrfW070xsYNb8yxBL5IRKk2lM7kw5KB8N6i4uaF0xvIukFk+dJs5fyw3xu
	3dYicg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49sua8mwmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 23:40:31 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-272b7bdf41fso1924135ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 16:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760571630; x=1761176430;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b+b7fUgZwhhMaLQsGZ0tNXlB2cPB46PT3vVgnAlTc8A=;
        b=rnjSITGIY0Og4qLnd5sPrvkeFcXaloauv7wXOVJEcXENIXSdH8DCzIn+oLbfcr599N
         hKbK2H5uH9vWr7xAFYCpKHj8uU8M34/l7qVUtU57WcbmZFfIN7sk1l6neRPdD5z9gVFz
         705gP1QazWhXjk6W8PQb+OxW5l+vwERPIRP3TL/YqJZeAw35BHe2/VHshHSFrFFQSES4
         rkHzdI2vfbE0hO1wWtevcl+KaUD/pGVWS2PSeZkCftF1+EZWOSJGzp8m03MeyjoXuZx3
         wpXbyf58g9yM79XIEzShHAeDeL4roWlulZmuqDNmoTtaBPlvFZDgdxyvf13K3l3I0OHK
         kvHQ==
X-Gm-Message-State: AOJu0Ywe4F+IRhJwe+oeAvU7bCYJYDsDzs8rt+I2nnX064j3XkGkDaKV
	ykRwoYheGCdudnWM024sJmXLeWbTHRUVsMvSLpoyy1bLLI0QlBFadC/mfZdCMx+FmKbp4hhAWTu
	xmZVczed5EI0j9iiMtZbQWXoqi21JOzvJMhQJSI7COmUVUg5Edy3JEgmamNsJEWASwi9zNk5dwt
	wAEA==
X-Gm-Gg: ASbGncv07PTGMaanHoL0HN5Qa3j7hDvVRnafkkW9mTfoXzBBlLfyOPVnknWq3DVqBAV
	aY++4iqttJtPv+jSbVLdET2JOLoMzbd5wrYQWMCwjRK4e52Vne9BFYmT6pOduQ12MI0+M7DOTx/
	5bjNWDVKktw/TLNuQ7W+uSMOO/rZHW7HhUfccx8hHLAVvGiKWrp78Bh31qKYixEquwmvIZq6mYe
	p70Mj5nvv/z4ZnzpPeliIsJMf+Ev/slInxWYa4aaoKt1+z3Asx0olQepM1ZmyZ8ZKGahms/HGjO
	UcXZLqvbANvwz5fwdVkmx+51Et4pmWW2AOBTOYaediFn1eym2gOqlv8migS2e7QslmXAe9pFeMk
	EFUcMEJfbf6T3M8Vsq4SE+Dh/bv8xukEg7zI=
X-Received: by 2002:a17:903:1b30:b0:27e:ef27:1e47 with SMTP id d9443c01a7336-290272b553fmr383878755ad.31.1760571630037;
        Wed, 15 Oct 2025 16:40:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtnl8Z3lrpsvoHLdyFpof73aobDtGKw5VSBB4MvACNrnYCN9HTDw4RMMR9B9Aki4eEXmU1CQ==
X-Received: by 2002:a17:903:1b30:b0:27e:ef27:1e47 with SMTP id d9443c01a7336-290272b553fmr383878415ad.31.1760571629557;
        Wed, 15 Oct 2025 16:40:29 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099a7c255sm8055635ad.70.2025.10.15.16.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 16:40:29 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
In-Reply-To: <20250924134336.888-1-maharaja.kennadyrajan@oss.qualcomm.com>
References: <20250924134336.888-1-maharaja.kennadyrajan@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Defer vdev bring-up until CSA
 finalize to avoid stale beacon
Message-Id: <176057162888.260563.18352558949798033216.b4-ty@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 16:40:28 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: sB4yQ_yWbJCWIOBjAlfSVKcT5EuZHRUD
X-Authority-Analysis: v=2.4 cv=e5MLiKp/ c=1 sm=1 tr=0 ts=68f030ef cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=LBCZ_CLYCgsH68C2wnUA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDEzNCBTYWx0ZWRfX64jil2ttlsqp
 /jBJlb3m++mP8sg4/ChxTnHJ586hcuxQNti9NQsVy2ZgN58E2WJo/byHiiAElvAnPxBADfh59EL
 a1FHEhtqRL4Uo3dYuYSJmot+kXGwaQcwdIug6zqBatXookSnOGe272benktGRs5SFhyd/bcHjW0
 Iqx0UzDm6113bEu+CTcYuqRuiQ6DibeeJAUSZzBVcCX1j+caf7cwbUYM/AAzhMiRrfBmQ+p2tQw
 EFnMz5lDertnWnQITDMsReyklhAYZIZ+tmFZVJxHA8QwMtwgaUs8jYcs1PIsvYfhUqll9aXGDyC
 qqWi6Nut5fueF12bnCnOH6AsjTtJm/lLKIY8MBc4xalkV3AyCgdmNlOa547F684PJPrTNlRtApP
 6JG5vhHFR2HtMFfHBm5lFUdixg9WNg==
X-Proofpoint-ORIG-GUID: sB4yQ_yWbJCWIOBjAlfSVKcT5EuZHRUD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510140134


On Wed, 24 Sep 2025 19:13:36 +0530, Maharaja Kennadyrajan wrote:
> Mac80211 schedules CSA finalize work twice during a channel switch: first
> during the reserved switch phase and again during the finalize phase.
> The beacon content is updated only during the second schedule, which occurs
> after the reserved switch completes. However, the ath12k driver attempts to
> bring up the VDEV during the channel switch callback
> (ath12k_mac_update_vif_chan()), which leads to premature installation of
> stale beacon templates before the updated content is available.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Defer vdev bring-up until CSA finalize to avoid stale beacon
      commit: 6917e268c4338ceb5916c8695423597ed8c8b38e

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


