Return-Path: <linux-wireless+bounces-25994-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A48B10DF0
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 16:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AFC55A20B3
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 14:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B4023D287;
	Thu, 24 Jul 2025 14:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iefN6Tuz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64C32D1F7B
	for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 14:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753368279; cv=none; b=Ip2lgMCtwk6JSpVNRe7bHcvVOqM2vFzoohUgLox3KqmXIbog40/W7GN+HPI8XTgJKkSGu/k/MR1ctJaWbkxBnFJQHwKTixbG9z/s2938u/hJwoKFLkw18GWOGqAFAM79K93hprsr4dZndPHAa1Cad3Y0Yj3CGjw676VyTWxrLy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753368279; c=relaxed/simple;
	bh=SyL0W1Dh2vtbWyPsnkvXDGTLOSWtBYOcBWa4tawg0ns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j5v71s8HdHmBOr9OwcKFXmMjrm+fErWmaNuqSfMFD1NsINmg9u7ogzSmAe2/dI3IJDkD4kLM2HIPrEaOp3yUUQHQyo73ZCgQi0EdIXITEcJbB6AwFXGl0bL7Fzt2EuMeTMIlD4yzzlhWp8ox2cAU/nRhtzM4Uushu/jArTdvJ9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iefN6Tuz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9fBgm017698
	for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 14:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JwzErQioZu9PjMe/wnZaPsi/qS3bBF/GqYaLXaj1NYE=; b=iefN6TuzdS8G0OMw
	ego89JXDGCNo94qF0gO59QkZI8E+Fyk5uO6l28aFbXDrZKhyaKa1PP4t0c0ogb/L
	vyvDafjGkVVGCyhLm33GviULeO9C/OPf9k6xsoUqcSAewPbDmkE9ylXNixZ5eVZc
	9HTMGPNp1SPbxkAZE99wOng3WoY0TM9eb/pkwkvRJym2N/ntZhlwZ/CDhHliLah4
	1JqpOnaD4R0gxol3TXczx3UlEKjsNEWF6yR6kcXu85ebMGQlCFACFGKwIyXwtR+8
	MCCqQ5R/vaGLHLF1T9+YUeVo11KSmCjkW024iGgZMUCKUaStATtLNGTArD3C4Mk7
	o1qktA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481g3euxne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 14:44:36 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b3f657b4badso859330a12.0
        for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 07:44:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753368275; x=1753973075;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JwzErQioZu9PjMe/wnZaPsi/qS3bBF/GqYaLXaj1NYE=;
        b=vwir00pBJVu694J5TdaXqQShSsEFr7pnwTwujBwrbVVxVvDMMwUwDKzJvekecucX1R
         7D4IKL0AmZ8E6Dn3jkrQv76YqJwmP1T8XZWUd7NsGX8oEcZdrT3RW0jhjTuyrNa1rYdn
         H0wM16dA4b5+tWN3gYLNL7Ao++phH3esDmei01I4JcRdALV+LHATK1Glv/sJT/Y1x8Gr
         n0NXN/z3jdxewvfjOIK06Ej5cKbYNp+OzRYzmVWUdCsTqeXfE1a03QRlN7SgikVtCz23
         Iv2Xn3jVC+3KzKaOV8Ld/BB27kzgSlH98h5MrllGM5tCZmVAOlFJ29YywIEklklEE7hN
         deAw==
X-Gm-Message-State: AOJu0Yz8rvB1CcX1kZ7a7uXn57yGzYBYwsLTJBlEVd9GJiaJHoylRJYl
	uL+qq+vqSPUiY+i/5iVyFqaY5C2BrHp9Lv1Uc0RyuhB3VSwtpO5gb+DK03os9dMEZDM1I6B1ZgC
	Q1XUOpiErxbeE9QjV35HtprYMUTezaLN3GcFs27TCm4PG9kjxLRuCC7Iz8xZQS60bz7U5ctbhxG
	Lgxw==
X-Gm-Gg: ASbGnctzEetUzAjcPIhLY8d73dvh8/eJjF0nDpkEKjuTVNZ4DsXHyI1JFnRSHKJOR2F
	5g7CyaaU8dsseJLyPQ2GiapFB97BqeygSv4Jza1b9Jy47QYUsfGpUUuaHFmaPnNfShTpzuG8ZrP
	pUd0cIYyOBiLQ/FHc467HFqLJ8DXlhHnQPgcruyY8gekPbeWanUQtl26sLgV0rIBKE1FW5JbWh5
	BuWmoSu72Q8CPVITt/UYxhm3lskmIA9H1yofx8w8PJt6IsJbmNtLUeCn4T46UVtXNVt/fPt+Mne
	j27aDTdKChfm4kPXLewCx3eSX6HTVaFEb1wKd7yeM9E5HhSbrwntookdvmTucIJhbbhQVpZsIhQ
	Ysu562qDPRynV
X-Received: by 2002:a05:6a20:6a04:b0:20a:bde0:beb9 with SMTP id adf61e73a8af0-23d48fad420mr11333809637.1.1753368275509;
        Thu, 24 Jul 2025 07:44:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQOrMTwwzN5SF29A4r3KiC/tGD4pAdUICJFLJoLiMcgay7qH2V4ueKJZw6tBpSm2mEBFj9bA==
X-Received: by 2002:a05:6a20:6a04:b0:20a:bde0:beb9 with SMTP id adf61e73a8af0-23d48fad420mr11333777637.1.1753368275042;
        Thu, 24 Jul 2025 07:44:35 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.197.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761b04b350bsm1848119b3a.67.2025.07.24.07.44.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 07:44:34 -0700 (PDT)
Message-ID: <4ac18b01-96b5-240a-d098-ffdace7a4a73@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 20:14:30 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next 0/3] wifi: ath12k: monitor mode fixes
Content-Language: en-US
To: Kang Yang <kang.yang@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250722095934.67-1-kang.yang@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250722095934.67-1-kang.yang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: A-KJGOrr_zQ5caSGoYKtwV6p2NIkgsXU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDExMSBTYWx0ZWRfX65+uI9s9kqXS
 QRlT6ctUEH/wC/NxKLsrLVXHdnWi0PmBo5JnxTGAD6a6JNZPy/Ha4f7L6Se5M/HS+I9aCfl5Gic
 iLaiBO+QaAJ24jEP5mUPTYeV+UEQ+kRjrsqgE+Lp5nx5Fkgr9nZbBu50vKTzGDDOr2f/7dFbsz0
 D0ojIvs92iSEGl9yAITT/4Rdr36kFvin5i2U1/OpcUvxJ1UaWJQQJObuwJdMq4KVVBvS0p6dtAw
 Njar0ibH0s7HCWYZaOP85ZYUKNJGfSa+6VetnTcYqk0U39n5IIbDeFp7lOv1buG9QcAQ9pjg1VQ
 KFoyVsLXvXX5zmkVyH0z8LAnYs6XGr+kXmtQnovXjXPeVoGZR/8P96HSbeUADclYvllgIcOIGUv
 ywZ0MZSTQkHhKPXgshF/QFJQ9W/puIsP7Sj7ZjK6n0aDqg86mDRWGg2FWvBksjerExhvJoN6
X-Authority-Analysis: v=2.4 cv=Q+fS452a c=1 sm=1 tr=0 ts=688246d5 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=CkStrBlBBtcNoDngQR/Gdw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=OnG7L_fJdXhSwPoSXesA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: A-KJGOrr_zQ5caSGoYKtwV6p2NIkgsXU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=747 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240111



On 7/22/2025 3:29 PM, Kang Yang wrote:
> This patch-set includes three nit fixes for monitor mode.
> 
> Kang Yang (3):
>    wifi: ath12k: fix signal in radiotap for WCN7850
>    wifi: ath12k: fix HAL_PHYRX_COMMON_USER_INFO handling in monitor mode
>    wifi: ath12k: fix the fetching of combined rssi
> 
>   drivers/net/wireless/ath/ath12k/dp_mon.c | 49 +++++++++++++++++++-----
>   drivers/net/wireless/ath/ath12k/hal_rx.h | 12 +++---
>   2 files changed, 46 insertions(+), 15 deletions(-)
> 

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

