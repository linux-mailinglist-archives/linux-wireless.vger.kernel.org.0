Return-Path: <linux-wireless+bounces-24619-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1005FAEBA25
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 16:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88B6F188F70F
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 14:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBAB2E888D;
	Fri, 27 Jun 2025 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ex35FR+X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321F92DAFB0
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 14:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035428; cv=none; b=KFuO8TXz513nfRT3ijFVyRhRh6VHT3zP7QruAL1CUvAVKE8aHf8abBZdOXX5uM0DJT+SQunfXYsYfli62aZWqE1tjLe8d5b3cdJ35DqjRa+s+OYmTak43YH4cU96qrfmN5OCwDXpTSXQmKL7XNPE7Msphr3UC5v3X8zGMpSeuiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035428; c=relaxed/simple;
	bh=urXZsPHNkhY8Rac6oVuHg2L5aQRzeDUs5jJpbuU1/zc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SHbHNxkGmtjOYbqXMDj9ze0dPa6P4JJGsTRhmNrLaHrQprNsYN3pHMI/oYeVjxBvtqbuHDKRh/UoiL+PIbtXK6AOvzxSmezLa5zo87RVBWsp1KggDLsjPoS0frLC7CpY0QWtwyIokXeRP1MyvbBDmnqAPjDTKAtCNunHNZB1u+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ex35FR+X; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55RBmJup027894
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 14:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t9EFRwZP1e36itfZHTjQBQ0grKUjgQyq/PCcoTAa6Ww=; b=Ex35FR+XA0pz48RA
	3sun/WwGlbfnJ5QDtzyS8xzJ7rRDztcCs0iprOxPlBhXpNkaNvLHN2yxtlvDDZ2q
	ub5VD6yNtccsAIFt0n54dH7WO6i0tBbgons1DLV+azRyT8VmBRGJNoOkXtofiYmP
	2SaaC5aT0Ec7Qje7R9K/iQvZjDDkrEO8ibdI9OZs1ir+vS3k4V5vsKi61+04Jz8z
	RkvPZPmr5UAkIUUQoVOL2YwV3UW0VIuD5RUgUk3BDIZmP2o4SArEY+sigmmvMwoc
	hHa7cgnG+7MslJ/U5I2+udHeXJmNp9gpsYr4ExQVXuuKETk8FrNC26CA9ofKpFGS
	i2Ct+g==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ec26hjum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 14:43:46 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-74913385dd8so3341087b3a.0
        for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 07:43:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751035425; x=1751640225;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t9EFRwZP1e36itfZHTjQBQ0grKUjgQyq/PCcoTAa6Ww=;
        b=aEJ4eQNiJ2uF5LvtLG2rGN1oAjSPKMmwWX9D+ktskNb/zJQQQtSZDs815bkT/mN/zk
         f7UybS7wuJpJJyB8bm/EbfgJZW41sIOIFJhJ/zJFdBWpEPrF5ySKtQXxNqExWgG33S40
         enMdJZmY3ftxDNIwccwC6CygEIyQ6TdSuzbJ/HN3Dlzt7C9C/SCaUofRpmPwL7DER3Vg
         BZHLYTKHuiFkhQexUc83frkWAqnosF0hqfrxkp7nU4PvCv396brsTqU8O4pGjOFUJx0o
         jfAX60JdD2u25KeVWLt0JJZwivOrPjz88LhrofJkRHMtt5zBnRCfrMFm5+ddp1xQFYht
         00Gw==
X-Gm-Message-State: AOJu0Yyv2gQAfmWbBJk5OUBENZNQlVbVRi6FRKdWUrb6PKIrjIGHmH5m
	O751GSXFoEmFOHBEBuwol8HgkgdwCwYZh/Brj9py+AB0/GcaYeInBXZVFrSvbHSJ39ocLzUvGVi
	kBzYNQhq6IerFqmlO0NStVATiTDlrQjqWgRsIh5RawMeAs0RkojwZ+TvGvpHvgNxF111JwTNu2/
	Xf3g==
X-Gm-Gg: ASbGncvyPAmyMpYrHuVEFGkXKYraM+9NQmY3VDhaWBFBKkck5U3kVN3/v31q40tJjMA
	yaoyUmQ49SWP88RFUDcYmynNWH5KW0jTHbmJZCuuT0reI1PZORHf8pK/8wJYvzSrIT0F2No3P6r
	oYSnqvmnpWoIKYiBXaR1xpBaCfT52haCafSMsR111hdhmH1K+SkF06XxVsGs4niiQXbwpjLMWXc
	XegDPExfT5gW7qCD6BSZ0AWO2HAEEa1OyIbiyJMXo5ci+xY/4ktHnKM/44bKb//c6S+CrTR3+sX
	jGZuH4S6ymuJW5KFoIBub+QjJr3OvtoMa/nQvGl3PtJ8QfONskKUmJ0bIHU=
X-Received: by 2002:a05:6a21:a44:b0:21f:53a9:b73a with SMTP id adf61e73a8af0-220a16c9babmr5592248637.39.1751035425416;
        Fri, 27 Jun 2025 07:43:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJBal1ZslfDL0W1aI95Q+gUhSBqQCx9NdcvLWnqtVxfiL77OjhxkDFG4YUtNERsvAyDfMSIw==
X-Received: by 2002:a05:6a21:a44:b0:21f:53a9:b73a with SMTP id adf61e73a8af0-220a16c9babmr5592211637.39.1751035425031;
        Fri, 27 Jun 2025 07:43:45 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af57ef4ccsm2458956b3a.156.2025.06.27.07.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 07:43:44 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: viro@zeniv.linux.org.uk, mingo@kernel.org, tglx@linutronix.de,
        kvalo@kernel.org, algonell@gmail.com,
        Sumanth Gavini <sumanth.gavini@yahoo.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250522205701.393612-1-sumanth.gavini@yahoo.com>
References: <20250522205701.393612-1-sumanth.gavini.ref@yahoo.com>
 <20250522205701.393612-1-sumanth.gavini@yahoo.com>
Subject: Re: [PATCH] wifi: ath6kl: Fix spellings
Message-Id: <175103542398.3295854.3644708485845243274.b4-ty@oss.qualcomm.com>
Date: Fri, 27 Jun 2025 07:43:43 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDEyMCBTYWx0ZWRfX7Rfm5LhteZyW
 AocvUEk9XEOSlYypjL7dYCNc/QbSid5KgdE2ml5VDBif8dgj/fKfLYI8ywD4RkVqy6f/bk5Nf7r
 inLkRJJqsR6EN1T0CtaPyPcg2AYLD/nokjeZjY9ZwVDBW/MU7Jioi882to919QA+KWH+2auT4a8
 Pd6XQH+oqyf4h2ONDua6pCYNC6iz3xvuxz77vhMuIzFHu3sMYQrQUYhL2QxF7WCz+cAUoesoehx
 O39WPlTKfs4GkjU8g7bogHxRe2VPl6LDuElSbQCJeYwdt1X1mXjBXk28ktBnbewLnSNlgtkHVeY
 Md0iyT2tqxHpsF298Z7ztGpAYnaDSvQ3eJG/gExeeze1dMDtv/MiVswdAiG3RVKDvrqLgfg8fwl
 HARM6UHy7Jj66lh2BjX5w6HZJvf/wX5XJ40PkXa2UG0IGYerq5Nqjexco5i35DlHDMCWqw/2
X-Authority-Analysis: v=2.4 cv=XPQwSRhE c=1 sm=1 tr=0 ts=685eae22 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=04a6cyt-vfZyN51_R3gA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: NyNdfsKvRbL8Wd1bpOY9L_a4K3-w40jD
X-Proofpoint-ORIG-GUID: NyNdfsKvRbL8Wd1bpOY9L_a4K3-w40jD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_04,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 suspectscore=0 mlxscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=654 bulkscore=0
 priorityscore=1501 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506270120


On Thu, 22 May 2025 13:56:53 -0700, Sumanth Gavini wrote:
> Fix misspelling reported by codespell.
> 
> 

Applied, thanks!

[1/1] wifi: ath6kl: Fix spellings
      commit: cb6dcabdfd0e3b608969d1cab71d8658495f9c4f

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


