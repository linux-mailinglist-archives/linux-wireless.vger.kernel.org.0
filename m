Return-Path: <linux-wireless+bounces-25292-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C45BB021E4
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 18:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B1481CA37F1
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 16:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03072EBDD4;
	Fri, 11 Jul 2025 16:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EedEff1z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DE41A4F12
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 16:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251670; cv=none; b=LTqpfDWJy6T0yxMW9cvBd4z+hm/7PM+TUejJ/42Yw9GkoFlqphsxVDkK+98hXjzlWMfMV06TuGsAtQwR5v/lRLWXE96zZVqf7g+NSAOLIoN0s0v7Rr7jHT1Ly8CSs+FS5HJTOZZ6i6OeMFb8L+QtFqriz2rt+gm/n6vBA5iWGVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251670; c=relaxed/simple;
	bh=rgF/TFyv4Pl8DwVaIcAXlI9+4x59QHsNZo0oneh8/FQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=D1eO2FOL4m20LUFOZFJ/eV43hOEGNSZigp4sO1+u7ETM8+Yt49inSazBYqaDrfcgVUelWbl92EPWTA/dKt8oYLeMbsfFx7joEPTPCr89oSvoJoWbOYQ4EWvUUpdBIZ5Ikmel5gkybETVdwvsxJfFRYt03ZULgeOTuHTw79FEEzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EedEff1z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BB86a9012023
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 16:34:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C+XjgGLjtznAuIEJDzg76KN65IBzwTNlS/qHyQ/AlO4=; b=EedEff1zYv4QKour
	pSEpl/hZBatMlvJgCgWStqiQWNhCs+7V/FeKEffo1zAD0pHSk5gGl0KUnoqbn7IY
	0Fq8yzgL3ULZxESGSMy4mH7RJ3V+bEEjuvB1Z62RG6R94HF4zTcPzZtWUYiNVdxq
	YWNR62F4YsZRRg3NIIWxnlQ+P4C6K+5RcYoY5KwX+4t8jiYBxeU6BqkaCKwOO8Jc
	AiNUxAbpGTagogY6KSMjov47igN8pG5Ccb+gmcmPJpGxri232Cn39kyfPcCBIhQn
	VQH8y+Q5yzY5Nm9f2BmexLCtog8en9K1dkq5zxh9CmDpzklGxL7yDK5KTKcpsn82
	g/Vtdg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47sm9e17ax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 16:34:27 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-235e1d66fa6so21127005ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 09:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752251666; x=1752856466;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+XjgGLjtznAuIEJDzg76KN65IBzwTNlS/qHyQ/AlO4=;
        b=n6eTS1n/J1ldxehv1NDnRVXjPTYeKLqcarvXcdPd7RkS9bffKwv/mNSVu0l2ZcDes2
         YzYIHe3BRkkL3H78DMgsk3oMYdJDvoUt7Nd77IpkVjcHBVHrYwuVlDtLzNSFRqA7IJ3Q
         5q6HRWJg98axjrqFt2zJcwkOHcjpJeT1eXQywrmpyHfwzTDYAxt3b28uc8pLZDrIrNfN
         R8Nrxj6chKBnVFqwNht0llA3ROchNC2oJfqLbpc6cpHifvQYTdvxX5141DURoXf/prqi
         04dtsZTSd8Q9v3UUFTkZqjqI3ylk5zQVxK3AUGhB0a9kFAjHq5DfROeVGJ+2TSrRjF/Q
         +K6w==
X-Gm-Message-State: AOJu0YwTrkIK6vJz4Kl0V+pnBsVTIVC1ZRKr8oY37lfubIg1ncAjjVPJ
	LEqo/V9WtUKovqTi+fg4vRB4gn3RUMhNmbenuDTKmZ7XMUsL3ktfI80t+0VboGuW38eupiNBpMc
	EeKxz45tTIaFPlZCGb7POQ/bXa1yTCGcB4FZeQMLRxsnJBZ1lck27N3WV3beRLjmRO5aLgA==
X-Gm-Gg: ASbGncvqDprpfZBqzmi9owsaXditKGGajxuAT7wHG7/M2M+PvEXTKihT6ooQ8bmYhOE
	Uw7vjTXHkJ1gvmOWG0urorWEQRDMLaMR2DqknHZcQkYeXYKAEIV6/SyIHoR1e1/43gT4tZQ3AWJ
	H23UTdsGcklTSomB/rHqEnmS46eOCSeh7Pj2w7brx1vJRbVwAjQWNkl6HR68QoJ5Ewa7MBvZP0I
	o7E+Ztpp2f9eE/jhw3j2t+97dLwEsGKf/Nh6eDo0aVyyLzCj9+yhdUiyy1UXMRZ6eyZ5erw2M6F
	Hq8hl/VHtcFvlxrnpdVO5gb7Xx9ISevOeSfypshnEUnc5JUZEiy3lGz1uu02WLURB1fAW78MNRK
	/
X-Received: by 2002:a17:903:2f4c:b0:234:914b:3841 with SMTP id d9443c01a7336-23df093c81amr46007415ad.39.1752251666522;
        Fri, 11 Jul 2025 09:34:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFw2ZXlbPb/Wju5bIdxO/0mRpv+Egm80WbCzIegT6wJBUILlrd70XbCDTSCcFG2/i/JASC4rw==
X-Received: by 2002:a17:903:2f4c:b0:234:914b:3841 with SMTP id d9443c01a7336-23df093c81amr46006915ad.39.1752251666002;
        Fri, 11 Jul 2025 09:34:26 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4333b2esm48526975ad.156.2025.07.11.09.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 09:34:25 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
Cc: linux-wireless@vger.kernel.org,
        Sivashankari Madhavan <quic_sivamadh@quicinc.com>
In-Reply-To: <20250709133554.622463-1-quic_ssreeela@quicinc.com>
References: <20250709133554.622463-1-quic_ssreeela@quicinc.com>
Subject: Re: [PATCH ath-next v3] wifi: ath12k: support average ack rssi in
 station dump
Message-Id: <175225166504.4015349.7644408748902551706.b4-ty@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 09:34:25 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: 2ZsuzNfLToTQU_0FMFrpZ0OW07b1N98Z
X-Authority-Analysis: v=2.4 cv=W7k4VQWk c=1 sm=1 tr=0 ts=68713d13 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=qfKbl12Lvci_ajeHDSQA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: 2ZsuzNfLToTQU_0FMFrpZ0OW07b1N98Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDEyMCBTYWx0ZWRfXwnOKbiiEdWGD
 icVpzfWBfNbO6akpmfIKtxEQQT1Z6tgVJELM9DElWdCEPLO/VyjPUVY7slOA3Vbr7RTktZuZOMU
 zkrbEulk3wpGmqI4LTcMaPMBcS6ondI6bSc8MJm5mtsQG5I0Uh5n0inDjl05+FbM6oEWv4/XgaY
 kPHQtpRhfbU5uEpYKeI1Lic4pcfEyYPMA6SHRDH4hPNYkymrdloGumRYCChbZ10+dTbJY928rs3
 ImdZ0Juu4mD+mlFWNRO9D3CDRGk1U/o9i9n+9dOvpyIqCWXlT7iE6JaDvFHKh47H+Kfsyt97o7c
 sCG05o1ONAksoCb8SDBYuboaFvroRrHDLs72MXgEu3+UOWBqrCq3ix9aHojRTjJTvkI+SBVtQtx
 6sWMeufcvzkNeXpNE1KwFzgqRMFVD1jsY4bdnQCUH2DQgUN7lRz1HGzCEA7KBKo+n7csjTn1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 phishscore=0
 mlxlogscore=793 priorityscore=1501 impostorscore=0 malwarescore=0 mlxscore=0
 adultscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110120


On Wed, 09 Jul 2025 19:05:54 +0530, Sowmiya Sree Elavalagan wrote:
> Currently, the ACK RSSI value is not shown in station dump. Enable WMI
> resource flag for ACK RSSI in WMI INIT command to add ACK RSSI value in
> management TX completion event from WMI. Update ACK RSSI value obtained
> in management and data frame completion path to ieee80211_tx_info. Also
> advertise NL80211_EXT_FEATURE_ACK_SIGNAL_SUPPORT flag during hardware
> register to mac80211 layer so that ACK RSSI is added to station dump
> message.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: support average ack rssi in station dump
      commit: 979c5ce4a37680063d87fe13d662ed68e06e77c3

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


