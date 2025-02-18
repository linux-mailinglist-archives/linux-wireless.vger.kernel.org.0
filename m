Return-Path: <linux-wireless+bounces-19102-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD47A3A4B2
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2025 18:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F0451889054
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2025 17:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C445226F45E;
	Tue, 18 Feb 2025 17:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pYd3IMp/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411AA26E171
	for <linux-wireless@vger.kernel.org>; Tue, 18 Feb 2025 17:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739901376; cv=none; b=c1rvDRkvunHSsPh7UQgU6NeA2ucqibC18ytmrczzm3R12soRzSM6kaLKfXyf1Lxcnra5KKJ4TQafUoIP90O+BZ+hRyfDsLSoudzo+o4qemXIatXREBISLr1HJ55uvWcSoJUSyfntr4bw4drAtwLrI8kfm4mV/OV37zVL8L8PWzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739901376; c=relaxed/simple;
	bh=EoL0pDLy2DkCjkV1TBGLg/GfD2hh7V6cTIMkI9PGTn4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fMqBSEXrOaQWLf62z+Lqb7oAtpySy3MzZIDK4PiZ5DagDN4eiBo7bbn3qddSUZFOI0OnLdHUJ9o8kIFWqFiLdB5t//iyBEbBHo9IQQfIC1OIGXojHmLlOjAtRa1ed7nOHv9KYKS8mgRqtZhoQcE01bJqEtNLQU2w4XzWOZ+TXOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pYd3IMp/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IBoFaq026153
	for <linux-wireless@vger.kernel.org>; Tue, 18 Feb 2025 17:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SlnSOaDSXn0NtKzNz9APdxJBO8zlTW6fZC1nNG2pCBc=; b=pYd3IMp/N46/Iqyl
	LElfUDDxjujyHi9BnaalR4e9KrCaqLUj3xunFcDMx76wysvMfmTZnEYwVKZhDIny
	kRVl5dkpUB3s44JL2qH2VQq/z/MAjg1b9TfkPaNDgCSwaRz+W1iR5bWj+BQy5Ty8
	yoCHt8BAnHpkqPKciZ0/AOLZ7ufZjT8pnuoMmi/2wjxZPyG8aidseUlqRBe54ubE
	psWnboQFIrToBNYZ5ZMPsJgf+J2+KmNNr0fSpNIuLfpwfZmtzhIYrnsZ77PiX5S1
	L/qHMCewfWDoaABaTvfFsgYec0iBgpU63z9+XYfyVrcl0BJOAXAD68dMutdT7bs7
	eJ83lw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ut7snr9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 18 Feb 2025 17:56:14 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fc404aaed5so11245906a91.3
        for <linux-wireless@vger.kernel.org>; Tue, 18 Feb 2025 09:56:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739901373; x=1740506173;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SlnSOaDSXn0NtKzNz9APdxJBO8zlTW6fZC1nNG2pCBc=;
        b=TNxNVFVAiBp/ics2FQSaFKJIwUBcz/5nj8ml5DbxyH0R44qakjjXx7oXOqEgZT6udS
         IwVRQ0vbZbPVmEJRY7gS2A5kpc2JJH0grD9vxRMYg8HKdoViFCWX10JSSVBW0aMCB/05
         4kRIc5Rk6Phj3kKj7uu7U72Nwce9vw+29lA7soWI8b0AeCa7sE3c5W6fwHvGJAkj+Yl+
         1Rw9CVTseKCrfzaap8NU1HeDgX+m6QAWpKH8hGg+hKchB7B2HYeuaNQp8zSRXh7mqO4X
         cZA4Y69mtn5zrQbAnErNIIN883M0TNbs2B872LGaCo+djvUnNRxVm7xrpmhUrdHhfLcV
         rcsA==
X-Forwarded-Encrypted: i=1; AJvYcCWaBgcpbDdmUpYah4vyaLt3PuxuqHlxyvgUGaz5qib3XUZrq1jKb/i98bXV15gLnojn9NIQ/w0LwHS6VbE3ag==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfSewANLa+/Bg8rT2FyjyNVWfAXC0iweqKED2LbUdyiozCyZbO
	LGQU2HA3soXfJ0b6A/iUI0ehR5Nh5uYcE+iUYQVisqprMfy6X3Ljx00xjov3xcbzuDnKHtJf2Fa
	VWUNQHK9mzv63boJchZu+hGLjneAKMNOaGNzWJmTcLvz2or6AYwQm1I7255iCZJz+WBIuCBAokg
	==
X-Gm-Gg: ASbGncsSjhmgpuIYiM9adCvrmlW59v6sWH4dL8IdWSoCHl7C+iUITff1p3XjwTB75FJ
	e/s+80E9l7aCPLghF0j7/4N7UyD2Juadd4hbt/skW1j8kYwItV1KWtjrhjWRfXBmk5EAXEaE4kx
	KgUEqtouBXxmnjvpmlB2iwO14gtLREccWFeir4+npaiZe+6VQZ9TOwD82ZQSYIRX1hRdtAHxU4V
	tFJOQXaKcRTMp4NgKr4vPFR3/L+SeYKYiPEVL1qg6pzw1MA/dnbWGH7NzvkRfPiWIiDflx7gJ4R
	1d6SKN5SLiDtmnjh21ErYDAdDLoXomDkzkKJq5c7dQ==
X-Received: by 2002:a17:90b:1a88:b0:2fc:b40:339a with SMTP id 98e67ed59e1d1-2fcb5a14827mr566133a91.10.1739901373169;
        Tue, 18 Feb 2025 09:56:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGM5rwFrhFmpIpr4cmPu76+PjEvtmbwtIZiH1h/ZeETkoM1xFjOrBES+zW45GQ2op51TGo1Ww==
X-Received: by 2002:a17:90b:1a88:b0:2fc:b40:339a with SMTP id 98e67ed59e1d1-2fcb5a14827mr566101a91.10.1739901372819;
        Tue, 18 Feb 2025 09:56:12 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf98f698dsm12342252a91.28.2025.02.18.09.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 09:56:12 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: kvalo@kernel.org, Miaoqing Pan <quic_miaoqing@quicinc.com>
Cc: quic_jjohnson@quicinc.com, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
In-Reply-To: <20240813013028.2708111-1-quic_miaoqing@quicinc.com>
References: <20240813013028.2708111-1-quic_miaoqing@quicinc.com>
Subject: Re: [PATCH v6 1/2] wifi: ath11k: use union for vaddr and iaddr in
 target_mem_chunk
Message-Id: <173990137209.1304166.16158310748083634336.b4-ty@oss.qualcomm.com>
Date: Tue, 18 Feb 2025 09:56:12 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: EA8Ci1YRbGkXpNCfOtwGIPunIEWWBau9
X-Proofpoint-ORIG-GUID: EA8Ci1YRbGkXpNCfOtwGIPunIEWWBau9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_08,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=791
 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502180126


On Tue, 13 Aug 2024 09:30:27 +0800, Miaoqing Pan wrote:
> The value of 'ab->hw_params.fixed_mem_region' determines that
> only one variable 'vaddr' or 'iaddr' is used in target_mem_chunk.
> So use an anonymous union instead, easy to check whether the
> memory is set or not.
> 
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04358-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> 
> [...]

Applied, thanks!

[1/2] wifi: ath11k: use union for vaddr and iaddr in target_mem_chunk
      commit: 9ee2578c343a2c8b6cf6c43f2f385cdb56a25250
[2/2] wifi: ath11k: Add firmware coredump collection support
      commit: 5edbb148bc57295a6abbb31b832878c0725ed10a

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


