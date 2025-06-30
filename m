Return-Path: <linux-wireless+bounces-24670-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 710F3AEE302
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 17:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60534189C667
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 15:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DF31487E9;
	Mon, 30 Jun 2025 15:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DZdEV6c1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0345433A4
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 15:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751298448; cv=none; b=GB0fBY08BoIneeuXcGodZ82YugwFdFFbz6DlaNX6xF3jj0zjLpx0vYkhrIeAuebEserIE1AVSzt1Dq0LC+KRjTyypdb1RAvkgEs4LJsajaCx4XijVmWXlGSMmhWa6NVsMmMGMCFIX4lkrWCKClGRaUTWprUJ3fsOMUWn1Z5PYQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751298448; c=relaxed/simple;
	bh=M1lNVq9FznRopMOP/bvretKJSGUoEUbLrKXGsptul6U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=e0j7algTFOqP6uU6I2FEKLyBCzZLMrIqtSZN70AT3ptoOSLKLa+9xGcEVILF+icdM5wAHVvoLQPJW0IsunquYhDKtdD4evbMFvxlafBQt96gNRy+HBuy0NrOgTjTDBKHMn3lqwbRgM0+6Srg2AuD/2ZottIw0zcXPskFrlj4AJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DZdEV6c1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UFXV9k007049
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 15:47:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t9ouCzDY/WuWEbj4mNDqbb1KZNAy+OKQpnGLkm2sttw=; b=DZdEV6c1JrYWjwK9
	txac6mlwMKdb4nAl9Jod4ma9XO+HkKHYG/mqhkxTUjFH8mwXbjxrXxavF7bHukz3
	2XP2nIWo9qpU1wc4G4WNPvN0AP5IwIZtXt3PHXOW7VZhsL1SqJh0KB2tGchiUZL1
	WevNo01RUMjhPFDP3vcFtpPmiTKlVa0VitrYkaL2udtWX+bbVI5jBHh6Ww+UbC2g
	Apio5Wql3Hhj+6wCdx9R/6oWp34E2pEEgAA6hWjWz7gA/SKKOC525nXWLOwVlMh7
	ZTKHACa0gi7KhwlZWqaYqsC2os+Qo5LAL4tNPTbrIHEhdfyJm9jVUEVFx2xQ+Tqw
	RK8EEQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47kn5j9qa9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 15:47:20 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-74927be2ec0so3834634b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 08:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751298439; x=1751903239;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t9ouCzDY/WuWEbj4mNDqbb1KZNAy+OKQpnGLkm2sttw=;
        b=iN1J5Cz4vXkZXIEPIwfV2UZTItMy+GjjwbppHc3LCms6IHHxHaDZhNTV39XYqsPlrv
         usAGpsxM4rqYnJ/1VVZmkp49HO2JrOZ3E1Gt6NG4r59FYF3JbHNQia1cC15xCKtcpPSJ
         1G/wYePSq72FIPTIGEWr9Ga0xOxQ4P1oTeCDB/FqmX3QMBeeXEYXBmNC/kazmsc48odR
         yNKeDFWe0s1SFjAIuSWpvohpRPuq4KupHwVlnIEhue+EwRd0J5GmHtyQZRoW7B3f+IZt
         GUpe4CZtXSnivYM4DR1RnJXTp4oLoK++L8ALQNuCR2TIs/yQ5jMaOONcI+sz7nNBkfSd
         yjOw==
X-Gm-Message-State: AOJu0YzOyJZboFexeFS0cqosXs437ZCYEU54mmIVtFS46bHPs+QH5IWV
	9Ky0Q5gXcvvMcoDW+QVswFXwuCp/o69y6ayhuStWYaXoVoRLq+K4VeSxazUmraERDvp6V0uq+8N
	oN4gCLJ2cDDkFbkUw7/6ESfPgTNrMAMpkW5fSFCYyvqso3647M3b0Q3freryoV0eFb+vGgrFxlI
	ju/A==
X-Gm-Gg: ASbGncusEfPiiJ1wyT0T9wNLtDKLiYcBserCy4CJFsYI9jU2UbEI9t7QteINW1/jVCq
	WKaevO7Rrq+L7WKnxEqwRipWiySa+afAkqUGq6LZ84dbHN50qfVIqVK4GTfY7oHRNY/DSfFEoZX
	kpMMpHfqeoKUZtUGe5d1jc5DeBV4zzctfAph+/CFebkv1ANshNKiZ5NdDiUlV/1MKXF9AP/q38d
	/kERnxB5horn4O4Hy4iWZI6TnMKhqMrA3zD4d18zSElnHSY2V3Dy4tcFkeP033ewp5tvfp53Y16
	v6fYTWDd+NQtYxCG4WZbIgneV4GGWMvxknNzmOqF16u0e5wY/u6rn6GuAsc=
X-Received: by 2002:a05:6a20:9153:b0:21f:eec5:85d2 with SMTP id adf61e73a8af0-220a1594f52mr24352792637.19.1751298439235;
        Mon, 30 Jun 2025 08:47:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFd2/Pr5WKrBLCW5Yvo00/DpfozlXkrS+yG88v9l2RbAF2vIqcxdAV5hFsOB1uFLKXnFntQBw==
X-Received: by 2002:a05:6a20:9153:b0:21f:eec5:85d2 with SMTP id adf61e73a8af0-220a1594f52mr24352744637.19.1751298438845;
        Mon, 30 Jun 2025 08:47:18 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af57dda03sm9726575b3a.147.2025.06.30.08.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 08:47:18 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath10k@lists.infradead.org, Kang Yang <kang.yang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250623022731.509-1-kang.yang@oss.qualcomm.com>
References: <20250623022731.509-1-kang.yang@oss.qualcomm.com>
Subject: Re: [PATCH ath-next v2] wifi: ath10k: shutdown driver when
 hardware is unreliable
Message-Id: <175129843814.1367731.13156897136860121984.b4-ty@oss.qualcomm.com>
Date: Mon, 30 Jun 2025 08:47:18 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=KtJN2XWN c=1 sm=1 tr=0 ts=6862b188 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=GDNJGlGECHCYOLTRVjEA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: ctly9Mvgwx5Mya2U5Vdsg1pobA4Sq0O4
X-Proofpoint-GUID: ctly9Mvgwx5Mya2U5Vdsg1pobA4Sq0O4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDEyOSBTYWx0ZWRfX24413OZH30tg
 Gm4jGSrpNKv5A139Yx/rbBpeZhpu4ok8PRGMpZOw3m79zx5TGGDvi8p32l8tR8Y1X56qaLAbwoy
 oCAL/ZEQ8Ghb2TVOLfIISvjEOjDioCPEG0ZvdMhvuyAWOxt8H42xv/XS4Jn0A15UcraRN81LOQe
 i34ScsulmOreVwyBdn4bQOsFPxxfFkakInUKMx494CKxclzBowDiUFgmHXRr1OLAaEnT7WYC6Lo
 i3pCuGuA5ENxoFK1A9WuzFRBiuFVyQ+KXDqXWT/6wMhzxXoypWFvoSwYU15CVre9ACy+rN8Vl0w
 a+KmFbNEr0AgUnr1rTcIQnL7ijAToLWMlroUM3mk9Voz2oEbCG0fgnYYBROmtyTPxX4xGvkFuvw
 hGoCTsNVhQvqlGKbBnTvFOsTDz4ynZRf/m1yIeztfMoCLC8x0fPb1UxK1V9HXEcunlOBOS1i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_04,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 mlxlogscore=765 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300129


On Mon, 23 Jun 2025 10:27:31 +0800, Kang Yang wrote:
> In rare cases, ath10k may lose connection with the PCIe bus due to
> some unknown reasons, which could further lead to system crashes during
> resuming due to watchdog timeout:
> 
> ath10k_pci 0000:01:00.0: wmi command 20486 timeout, restarting hardware
> ath10k_pci 0000:01:00.0: already restarting
> ath10k_pci 0000:01:00.0: failed to stop WMI vdev 0: -11
> ath10k_pci 0000:01:00.0: failed to stop vdev 0: -11
> ieee80211 phy0: PM: **** DPM device timeout ****
> Call Trace:
>  panic+0x125/0x315
>  dpm_watchdog_set+0x54/0x54
>  dpm_watchdog_handler+0x57/0x57
>  call_timer_fn+0x31/0x13c
> 
> [...]

Applied, thanks!

[1/1] wifi: ath10k: shutdown driver when hardware is unreliable
      commit: c256a94d1b1b15109740306f7f2a7c2173e12072

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


