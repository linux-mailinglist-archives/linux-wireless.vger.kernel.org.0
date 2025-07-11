Return-Path: <linux-wireless+bounces-25247-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65376B0129C
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 07:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E9D0172479
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 05:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3526382899;
	Fri, 11 Jul 2025 05:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JNpyjg+O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EA02AE8B
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 05:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752211098; cv=none; b=UhlpH/BNR2IA3u63x353HYFbWvY8xCera5r0pXZy9fl9M3m83ALruxVhMtjGZNcaqYstGz9Jb6Rc2blyK3MoBZxTfkuO2RPYHlSTwEgL2WTVGnG+CngOk2O4d/FM8GlJ2HoNoNr7T2XXq2kRlKO1HpkwcaWhwzFjWdydgUkv0GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752211098; c=relaxed/simple;
	bh=srG8FVjwMLeXtKqmWbJqtIwMIx765r6H9CIk8R+5Av8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LJMamTxjS0oPd/7Dj/2BhKAdBGKe0YunlAiAsbIQKXDYdq0Q8wCwJnyN+gMbBGTertGVpaz/CO+WyZzcNsQ39jRHu0OWG05W1aNWg3Ad93pdRWpcJz/fl55hMXEH2iu0JqNdo7KW447Lqac5ITjMd0Bjg9HgOFUULOmLQPwClqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JNpyjg+O; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B1XBmm016805
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 05:18:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EGHcxbwT/9I+U/jB4ylFh35biB4VoYk5uup5pUh3fjA=; b=JNpyjg+Oa0LltzKv
	VAvja8aU+XaeEndqVCypMSttgjzWNkEDaDODVFzOVUdWbLuYKQlzP3Tg/wqPXMI/
	41WivN0dsXAG6UOcsftIvmpOBoky1puxXdKBEHBxULBVIG4hfe7RLS2YsBBiVQ8w
	l5GmOJyynY1rHulnehfHrQiI5ExSnMaSiP51qtBhOMVNKLQZFwCMZ495EQVro+tZ
	9Ua04UcpdTGCD6WenbsygWrqklvP1xxDsmtuBgKgJ9O188xgjFMHOB+jUD+pljOZ
	F6l9ebt0oCxY2rBU8TNZ4soTt0Pn0Ye6g9pfi1TnVUzNSEEd8RG9I6y6AC7S3E3f
	vnlJow==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smap7bwa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 05:18:15 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-235e1d70d67so17389175ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 22:18:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752211094; x=1752815894;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EGHcxbwT/9I+U/jB4ylFh35biB4VoYk5uup5pUh3fjA=;
        b=MhxKv6FMI3T2G/ugXgRoo1ZrKdJuaMEQxJZ9YsguOFU0DtTXwCQPsIWZayG1oxdBTC
         arRYAL+gLA9umdniin9oQn80e+098UPv/owRYWRn3/0Kso/Zl8FG75AgmKjHDqyFFnIU
         EaBE+tm2fdkoe5wDSCoOAQajfvN9DWspBktGBpeCK7VHrIafP2J5rD1ILAZaN7ZBKE9q
         AsOFpKkxIlgxZvnWnuINc8EVD846JSY5LIGMiTbJGH7mmZbp0Ov4Fd8qKGE62Y9/RQBK
         AssFNHy+wui19xEOCqKKPXg+wRiQrOpCf2Go2rWgjvR/hJH8afZGK2mJOqVPuCW/j4tU
         rxEw==
X-Gm-Message-State: AOJu0Ywl3xsYYW12YZt3INOGfIN2gBtuiTT2iN9kv37QIAGzLlSrdcbR
	Uwr+0Y1zUPSJLYusHfMpXs+CNxZiyRPwtDpuNBu7v/PajMc2if/wSN2v3JavaobxoIorYBlJTrA
	L3I7WiAcp1N7DFw2QhlWliF7ROZUKCACnWvEPcrqMbIOb24ZYDAzJdZlMJwAS9RB4DxCt7kX0fV
	mRlA==
X-Gm-Gg: ASbGnctHPwqfR8HDG8V2IIiArn7M97XGNYWDbKcGFjMlc8smsQhhqrMxda2JbrKpaJS
	tFOc/waAcvDxFLMH6WWwY+KMJXiHItgCjm6Cf69uaHiUkDNP0u3y4JI6NzjjAtU/NZgs3L8wfiY
	zj7t603/Ed36PZFAvPwUbqz9XA0auMJEJPrDYKnq6/0n9WK0BuwI75vz4VLuOGWZxGmZzkHspGe
	Z7WPlJ/HY3hSSmbiIFaOb9KvIS2b5tDz4rWGd5SRajbKyOFS+DDOA0ifn1dgDbrdqaftATL6DBz
	H8VGkhB0SXJdgk0cWFGIHbYVR1KribZ+FsHbZkeLk0JKzTH+5qU2OMUmsL+HupSgjzJIsgfxwfM
	QvS4rvoljfLw=
X-Received: by 2002:a17:902:d58c:b0:235:f298:cbb3 with SMTP id d9443c01a7336-23dee1e84c4mr22439925ad.18.1752211093794;
        Thu, 10 Jul 2025 22:18:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNM1UCCN6V5HaVT3VWAkl0FVjpS09lDHurvmnwOG9vjCFN9loWh1c9GnjU16BqrmEgVdM8DA==
X-Received: by 2002:a17:902:d58c:b0:235:f298:cbb3 with SMTP id d9443c01a7336-23dee1e84c4mr22439745ad.18.1752211093338;
        Thu, 10 Jul 2025 22:18:13 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.235.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4322b17sm40608995ad.103.2025.07.10.22.18.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 22:18:13 -0700 (PDT)
Message-ID: <802c5ac0-0d63-a165-86ca-d7f449fbc787@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 10:48:09 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next v3] wifi: ath12k: support average ack rssi in
 station dump
Content-Language: en-US
To: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Sivashankari Madhavan <quic_sivamadh@quicinc.com>
References: <20250709133554.622463-1-quic_ssreeela@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250709133554.622463-1-quic_ssreeela@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ar7u3P9P c=1 sm=1 tr=0 ts=68709e97 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=qj7j/dCbgmX8y5u3oU6Y8g==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=B8JhYHFz760a8drxLFIA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: WC_UwT5Xj-xOdhBZfPmYHbzfS2-GKuDo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDAzNCBTYWx0ZWRfX3XVQU6BaPPsZ
 CZqIykl1792m0ZE2nY/O5he8iAfJKfaXKvQFNbCJwrQ6UwpI6p1dUDodChyfE2mzPWvPU4CLtQl
 alTxns2IBZWV/Ab1hRPSBlQgZwcmbiTjsjXD5DPYM3anAxUC9e0yDLrHo6zPwjP4tjftZ5MHQ/Q
 k2zHgn6k8YwDi8reXdbgMjxFLvczv1r5ungXACX5q0+rvbKhyHqph5NVqg0lkhBrPQNXLe4bLe8
 9FIJ4iVbI2PjVF2d6jRgehNuf0EZ9GDSNF27Yf+UC48O3DN0fkQvH7eo3uNmT41bUf4Ke/hueAC
 dr033RcxRnPRhNWfkjhDyRqFBmCE0rau8tmQfRd3MpjWstgIOO3guGbUDP1tWSnB/VeEMbQVoAN
 4anPWfejZTGC4/HqkcTZ9R9z0bBRzwgNNMl3iJW8kgkdv/9FDd1wmPM2SWh2bKJ+ORZ1ysrn
X-Proofpoint-GUID: WC_UwT5Xj-xOdhBZfPmYHbzfS2-GKuDo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=843 clxscore=1015 adultscore=0
 phishscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507110034



On 7/9/2025 7:05 PM, Sowmiya Sree Elavalagan wrote:
> From: Sivashankari Madhavan <quic_sivamadh@quicinc.com>
> 
> Currently, the ACK RSSI value is not shown in station dump. Enable WMI
> resource flag for ACK RSSI in WMI INIT command to add ACK RSSI value in
> management TX completion event from WMI. Update ACK RSSI value obtained
> in management and data frame completion path to ieee80211_tx_info. Also
> advertise NL80211_EXT_FEATURE_ACK_SIGNAL_SUPPORT flag during hardware
> register to mac80211 layer so that ACK RSSI is added to station dump
> message.
> 
> Example output :
> Station 00:03:7f:01:5c:4b (on wlp88s0)
>          inactive time:  46584 ms
>          rx bytes:       955
>          rx packets:     10
>          tx bytes:       769
>          tx packets:     6
>          tx retries:     81
>          tx failed:      0
>          rx drop misc:   0
>          signal:         -39 dBm
>          signal avg:     -40 dBm
>          tx bitrate:     6.0 MBit/s
>          tx duration:    1185 us
>          rx bitrate:     309.7 MBit/s 40MHz HE-MCS 6 HE-NSS 2 HE-GI 0 HE-DCM 0
>          rx duration:    0 us
>          last ack signal:-41 dBm
>          avg ack signal: -40 dBm
>          authorized:     yes
>          authenticated:  yes
>          .......
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Sivashankari Madhavan <quic_sivamadh@quicinc.com>
> Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

