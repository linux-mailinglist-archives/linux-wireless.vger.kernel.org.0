Return-Path: <linux-wireless+bounces-21007-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA780A77050
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 23:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E1C03A8B38
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 21:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F320821660F;
	Mon, 31 Mar 2025 21:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GXeqDmld"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE4A1DB12C
	for <linux-wireless@vger.kernel.org>; Mon, 31 Mar 2025 21:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743457623; cv=none; b=aWPlIWLtxxZRnAxZhb4E5DTuHe+Fl3oZirCKcPYx7z4sioFnhtxDf1brAqXqMNQ2Eb8msiuPZDHR/GWmrmFxnL07e3TwSYjaIhbQm1NXsZdIPFts57ENzL7PEtbvPgjKA1qYbwJIB1m9np5HbfwbKNXGj2FTuZkn5jcqnuzAahw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743457623; c=relaxed/simple;
	bh=0W8Yhf56VLA+zLbZceUmvUaPvdsvvqd7uiFVijCU4ho=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kOm4XynDxuwum7nt7QXyQCyA0oV3bbWGBcqn2s0IITOrfB3R7aovghzbrmwgKGdeO7UXxOshEyahewpaD+RTYsiz+et45EvyJEMcYdoShC9Fjp3acBjHYqfbIp8xTTCfTH+dCHpCaUcFrM/KU4L/l0aDoc3pGW7diIE/Ld1sGw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GXeqDmld; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52VKGQnE008414
	for <linux-wireless@vger.kernel.org>; Mon, 31 Mar 2025 21:47:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NS2zcXptxcgcU0tPvmrUCO30qFIX1zPhS7qEmUqi3zU=; b=GXeqDmldmketFn1n
	5ygpr8H2o8Lt2ywjHkHaf4PWtDpwiIavmK31LWe9vNRtgKJF7i5k1BamQb+L7CtW
	F17QVAxNjHNJYwaCRYRxwcXBJB5vZhqgyAMYqry7xpGTcBQruPCXNLtl3KJOX+ci
	ddKbaX+fUnUnLOdGYR5hZow7t6n8lsmFXKPT8saDkC4oE7Ls1ExXlgswTVCeWguQ
	WfuXVMmHaVO0S5rV3ENbtL07FMzc3XXEI5lzEmqRDReh6lieNhxt8Iu0ucAIbdz6
	Jn6sg+ySihX30vBNtRK+jGlOY6Lf5sTYfERIHH+WTRRts97rXrzqxnFlk1xsuMKa
	c1OO9g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45r1xng57y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 31 Mar 2025 21:47:00 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-225974c6272so75779005ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 31 Mar 2025 14:47:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743457619; x=1744062419;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NS2zcXptxcgcU0tPvmrUCO30qFIX1zPhS7qEmUqi3zU=;
        b=xK2iXA3K9MllHpgsc0ClraRf8iLdtiNC9hBtOdoX8Q7nAwATRb0mMvxM6+HfYdHr67
         QDOQu016GVjYs3jPpFjJ33deQiz2JG2XV80wOPnCpmQ9YdbhmEbSgvvvI4Jv179la7Rr
         HzGX0FAKzdv/q1npcXPrXaL1Ld/U0a4Dig3ijU40tC+/SWAY0XdwIPM1TVnf2uEMENFa
         Q0aoTDpYDJukpjmnJ1QADSB9rZG4RfH1Nql2HGXhn75GDBnqN2y1ki3TDoi9zAW2GXfn
         ctZvqzMOAsYpI5FvLXxFz2Whi9XnZSfP+QAlMXL4bnQ291IrwuF9QEUb0mw+neKHza+K
         e7IA==
X-Gm-Message-State: AOJu0YxsP2C+1UcSpl7FmbgEQfEPcaEihmrlUv/KjyCZKd5wjpb6xoQA
	8dFxJNVhAN5ildKWW7EWkhZFKw+VQkiyXeSYW4UaN+P0ISQHtOzB7WNtCpNxFgY3mHmegk9UKTt
	IMsaW/Q7Ej8uV0GfTzRrOHuuTA0xfI/v8fOX/HkF3ddJg5MOJA273jJWQN1PxTIqlGQ==
X-Gm-Gg: ASbGncvJmfy6o18jBOTMNvO52x7PLlsb681D2R38pit0RRwJxCW1+LDsslJnIR4eCiz
	tFR8OVPXO9qpIDYTcMOEQGTVBq5s0ILjvlgc7yOvVakao2skmM7BwlJGQo1KpOUOfyxdVs7YewW
	/FX9PTle9dlSV2Yup3iDQqQKWBRlkTljGBpf5WNx5I3o8kmDijlnSn+uKaoUZl9EucfIKnme4ST
	5z44Q2F0FswJXF3Ahkwv7P2Ssx2DwfW4OtcTrkVkIpv+OIv+ri8PebdnB6PyoeTdqlbuScJIPBw
	TT8Ydrz3SOmXYTvDusGnOBGJF14vhHBucV4IR3tBx071Pev9AxAE
X-Received: by 2002:a17:903:98b:b0:224:7a4:b31 with SMTP id d9443c01a7336-2292ee06c99mr163911545ad.6.1743457619429;
        Mon, 31 Mar 2025 14:46:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtOEsVjvWiGJctpJPUZiJwd6njJX7AeXk869duUJ/FtkKLtpSuBHJ8GhZpYHgaGaLnzk8gTg==
X-Received: by 2002:a17:903:98b:b0:224:7a4:b31 with SMTP id d9443c01a7336-2292ee06c99mr163911265ad.6.1743457618981;
        Mon, 31 Mar 2025 14:46:58 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1f7dcdsm74092055ad.216.2025.03.31.14.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 14:46:58 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Takashi Iwai <tiwai@suse.de>
In-Reply-To: <20250328-ath11k-bring-hibernation-back-v3-0-23405ae23431@quicinc.com>
References: <20250328-ath11k-bring-hibernation-back-v3-0-23405ae23431@quicinc.com>
Subject: Re: [PATCH ath-next v3 0/6] wifi: ath11k: bring hibernation
 support back
Message-Id: <174345761819.1161294.6011866628558951179.b4-ty@oss.qualcomm.com>
Date: Mon, 31 Mar 2025 14:46:58 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: JT94GZg2cexptFFOlxvRSsTdcuHMJoRM
X-Proofpoint-ORIG-GUID: JT94GZg2cexptFFOlxvRSsTdcuHMJoRM
X-Authority-Analysis: v=2.4 cv=Qv1e3Uyd c=1 sm=1 tr=0 ts=67eb0d54 cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=EgwDjV4hzmH0pz7qutYA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_10,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=794 lowpriorityscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503310149


On Fri, 28 Mar 2025 13:32:23 +0800, Baochen Qiang wrote:
> To handle the Lenovo unexpected wakeup issue [1], previously we revert
> commit 166a490f59ac ("wifi: ath11k: support hibernation"). However we
> need to bring it back, of course with additional changes such that Lenovo
> machines would not break.
> 
> For suspend (S3), as those machines work well in WoWLAN mode, the thought
> here is that we put WLAN target into WoWLAN mode on those machines while
> into non-WoWLAN mode (which is done in the reverted commit) on other
> machines. This requires us to identify Lenovo machines from others. For
> that purpose, read machine info from DMI interface, match it against all
> known affected machines. If there is a match, choose WoWLAN suspend mode,
> else choose non-WoWLAN mode. This is done in patches [1 - 4/6]
> 
> [...]

Applied, thanks!

[1/6] wifi: ath11k: determine PM policy based on machine model
      commit: ce8669a27016354dfa8bf3c954255cb9f3583bae
[2/6] wifi: ath11k: introduce ath11k_core_continue_suspend_resume()
      commit: 3d2ce6ad9126b96a721542c6299a2f0967b5a63f
[3/6] wifi: ath11k: refactor ath11k_core_suspend/_resume()
      commit: 662cc5b92c327e94587a959d7ed75862eda4b059
[4/6] wifi: ath11k: support non-WoWLAN mode suspend as well
      commit: 88fd03cf51a7d67dac976ecce079ccfc79376966
[5/6] wifi: ath11k: choose default PM policy for hibernation
      commit: 32d93b51bc7e2e557771abe4a88da69c609e3d52
[6/6] Reapply "wifi: ath11k: restore country code during resume"
      commit: 3b199a58cc585f423a85af2e57045c9a783361bb

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


