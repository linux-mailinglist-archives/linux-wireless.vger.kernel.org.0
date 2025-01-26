Return-Path: <linux-wireless+bounces-17972-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC28A1CD7A
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 19:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECC55164F92
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 18:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F8B1662E9;
	Sun, 26 Jan 2025 18:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CRVzeh5A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDC817ADF8
	for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 18:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737917107; cv=none; b=q1NZfUVjoh+K6fGloHvj3veUjq3dsJWTgPcM4JdTwu9wRUYX91+Iqr8jC8rHAtJMNMX156cTOBEWR3wlr6RezlbUg9eNJMjbbNu38syyOpqnp2kjBVU7Fz2F1dbJa/JYxCMLk1M90N4VoU0kbrW62GhOUkleZsdtoG7JkaAksqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737917107; c=relaxed/simple;
	bh=G+BBRRWVEv5Jkpfqap6p0EeEepHV148HEb4d/qXLG6s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CK5uivpx4+UVk8AP3qW9hT1etWOOdlIXMFk0XJE+u7GT86tstLX6bRvnuXgmcMOfrIod+PUa9J+ypfgCjLXs6U86Ldmf4wiPn6LNjePIO1UW0tjxQ13+w019e+oKBSyHFkI3uxTo/xBxYE6x1qIe5a1UV+CNtY4VEjKea+3H8QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CRVzeh5A; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50QGNpIR031742
	for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 18:45:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Qjzal2VIOLOUxu2o2XRhtZzepAUsS41r+vnYJ3dxxdk=; b=CRVzeh5AUa0THa80
	MMf1c6u3Wh/nEIVPAAq6P70X/ZVgxnY9mq/9uyesq+wb0fWdOoo6X2bgvFNCfj8S
	SWx4rSnhYVmxYb/NnruE/t2h0JhSpScf1r8gZUklrWVCPHI0YRerU6rjHJN1hvFk
	anyPZ+mE4rkBm/Xweo+b+BT86dBopgF/ABnm5iTuIbSrhuhy/PAEV2qQU1VRcEJb
	gVmZeJgHPDhb+1PaeCfseIhX4RiFmII3981TEt9k4xJ2EwvFLWNRhKDqQV7dZKtT
	WOYp3ZKGeo6KbCE6A8qd2+wDblUXBrZnx0KrpK4zb12ZU0NHAZXvCB0n+CjeASju
	Fkn2XA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44cs1pt5t3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 18:45:04 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ef9da03117so10651432a91.1
        for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 10:45:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737917103; x=1738521903;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qjzal2VIOLOUxu2o2XRhtZzepAUsS41r+vnYJ3dxxdk=;
        b=pu1xxuEWf8ujT/wdTIPGhoyc2fW5O69hsjVCCnX2Stw4rETtAcCSLI/7Lp9MlzTqZQ
         OHQl5+uIKZ9YreykR/0/KhXFUB4jvuKmjUGtxEvcLzJNZj5Yps4g3JT90bAPFlQku85q
         ExRvfQPIrTG1Oc0626RV/xSOEo+Iwyd6j8kKN4Gv7eqiS+ZD2ZckP8O8Do554cTVV+BM
         A4nUxwjC7xZ1/NraSRk3YDjqBxpdXvAVmD4+myQqce0Yy76nCZeaxN3En8Jja3WhzhhO
         H1Ydq3OG4vEPuJsPsOsS7tE3VSkLRjvar3j00Wxk24FLqWsiiMM9Zrd2qLosWh2ak9W0
         lWDA==
X-Forwarded-Encrypted: i=1; AJvYcCWGHbTATCTCDEV45VnKQu4L5ch7wHPmIlSVHP6whSEiNREfTElPaWKWqhNamqfKbj79+tveHXK7V256NxXRdg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+0+7J/HfS/iT415ito8GUlIfRQnvgYrKuahvEo0U7kO1SMND/
	CZdA2SEJEVVdZL9MYK13EfOzYRvmXU7XQMxEib3/LIqkPK5yt6q9gmwT+t3s863ZGcgd2s2MRcn
	nav4WEbGk/L9sAMOSXvxif2LOtauIjs3jVjOz+y7p2+sIR07IsWQ6wY/jKosPywv7ag==
X-Gm-Gg: ASbGncvViUmEeGOs9easuJ1PRiWr+Ykbp4OlUn9Jb24WGUkmIiJFVgwnyZMk8MYrRA8
	ZiCF7TRNoK9OVmBy5ChqswSQp/gHF59+2ZYhN4inrPgWhhxIKtuc0HPvP09rH2ON+/Lz2MWZCKD
	/YlSN3uqI5uXaNoRwM29C/W2ns+gXkfaXL56EAzN9/qMYdU9X/S4lBN8dXi1BU5sgmjiLuMlBLe
	8zyACAEvTdBCmd1iNqgu3QaD7i/1muMph5f4JNUpado1TlhePBlmKc1zm5TESd0zRtFdUnZ32d+
	KgwM+XMwDDOanyLvpF0YqiIJ/XJifPPgW1k56ji8mw==
X-Received: by 2002:a17:90b:5244:b0:2ef:2f49:7d7f with SMTP id 98e67ed59e1d1-2f782cb58c3mr63741844a91.18.1737917102961;
        Sun, 26 Jan 2025 10:45:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVDOJEal9qItKa852YUinKUBKEPgqodT6CK191Nxz1C3J8NiQdSjFfGQ7fvaGxYTmh6kkv1Q==
X-Received: by 2002:a17:90b:5244:b0:2ef:2f49:7d7f with SMTP id 98e67ed59e1d1-2f782cb58c3mr63741810a91.18.1737917102649;
        Sun, 26 Jan 2025 10:45:02 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa44cb8sm5414795a91.6.2025.01.26.10.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 10:45:01 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
        Bhagavathi Perumal S <quic_bperumal@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: Kalle Valo <quic_kvalo@quicinc.com>,
        Balamurugan Selvarajan <quic_bselvara@quicinc.com>,
        Carl Huang <quic_cjhuang@quicinc.com>,
        Wen Gong <quic_wgong@quicinc.com>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sathishkumar Muruganandam <quic_murugana@quicinc.com>
In-Reply-To: <20250107-add_max_reg_pwr_in_scan_ch_list_cmd-v1-1-70d9963a21e4@quicinc.com>
References: <20250107-add_max_reg_pwr_in_scan_ch_list_cmd-v1-1-70d9963a21e4@quicinc.com>
Subject: Re: [PATCH] wifi: ath12k: encode max Tx power in scan channel list
 command
Message-Id: <173791710099.2935553.14215933138966631965.b4-ty@oss.qualcomm.com>
Date: Sun, 26 Jan 2025 10:45:00 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: CaMFzGVxGOcjCRtNI5LSoaxsJvVaKKiZ
X-Proofpoint-ORIG-GUID: CaMFzGVxGOcjCRtNI5LSoaxsJvVaKKiZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-26_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501260152


On Tue, 07 Jan 2025 09:31:39 +0530, Aditya Kumar Singh wrote:
> Currently, when sending the scan channel list command to the firmware, the
> maximum Tx power is not encoded in the reg2 member. This omission causes
> the firmware to be unaware of the host's maximum Tx power, leading to
> incorrect Tx power derivation at firmware level.
> 
> To resolve this issue, encode the maximum Tx power in the scan channel list
> command before sending it to firmware.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: encode max Tx power in scan channel list command
      commit: 07c34cad10ab0ac8b06ede8a7fbc55ecf2efa3e6

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


