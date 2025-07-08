Return-Path: <linux-wireless+bounces-24957-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B681AFD01E
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 18:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6AA37B030E
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 16:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2CB1E412A;
	Tue,  8 Jul 2025 16:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RbVvFPDM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106152E0929
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 16:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751990834; cv=none; b=HuIVLdOWYprcKm2i0Z4W/rK4A92CNNwgFp212zdx9POB722TOlXL2yHiGqaa+9HN7EAnNH8iUC7XYWAc7HtYFRcNA3UbPSeZstkjxdpqU4IZNrWGhC4zs1v4WDJ65MmlcbuWKswinGtqz9G0S1YRODdJ9ydLgATbUmWyfA1Yhhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751990834; c=relaxed/simple;
	bh=7zUogGr7WEUhjb8uITEWrdJjU+1Z8+9/0luuvHZHdwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=upZqE47PbMqX7uGZL9SHRm+qMyO2N85LpjgbaT9Skfh5Ou6Sy+Ewq2oppARd6ClaQVDeO00JAvjwNHJL1T4KKuKBrd4eg/bS3Wfnl1gyQv37Kgh0vXRa4Q5xd6pk2fNPA9eCNWpsYNRpk4JL/Fd4rqS5qftuWwlCur+3NqCdeK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RbVvFPDM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AAbLQ032690
	for <linux-wireless@vger.kernel.org>; Tue, 8 Jul 2025 16:07:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kZKxO51alpyn1NlycCB3zxkX7gnbPUeF4Q0Nj0s0YVk=; b=RbVvFPDMOPE9ksPr
	sjOU/ugL0hVAMuLwuyzK8OyXK3UJZ0kdvkNhuS6dJW2ASPGNc54C2Lq+/6hd1Mi7
	1uPPPZfeecwcQqJ7RFPP/hJwCnQnIvbWKjcK1D9a115sgwsKJIxMyjO2GEnWsDAE
	r23BnedSWpXvP1uB7TPfjNNr1DQB2Gv3dhlgxM4iTYQsvjbnLwzS7x3w/rgsKIpJ
	5ZWXmI4e3ur5bLvlZYPBZqCo5r5jgw6uhdpTsDQTqmSOHkZLHHMUtawnG+OXKxad
	O+yHV28u4wADOzezrjkqU15dAoln9eXS3P2/5DTZfpj2ym3NoH2GEjnKE6u3kwTO
	SyarcQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47rfq31yth-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 08 Jul 2025 16:07:11 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b3642ab4429so3130036a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 08 Jul 2025 09:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751990830; x=1752595630;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kZKxO51alpyn1NlycCB3zxkX7gnbPUeF4Q0Nj0s0YVk=;
        b=S264ske2cm5OhRu7bOiPOj/4pG6tJmiOnLIKzuoFjMYRGWS2jadn90iapALckDCph7
         pMBlpTFw5oLhTO8PS227SV73j9GiGgnrRvGs+5uBrq0oTJ+Ml2Pfc9efNGGYNRaA41Ct
         7w1Wkt8wQBIn8Dih0CXzFdrAiN281KmK8t2a2qVn9vAQJIDPNRq6IBcYcjYIOP0SIECD
         1HvtQA2fhBJ2dFvYaZQ4rGos8PWQ569D8ZjVAq1ngigPMSAkS7Kt3Tdt7ZEjHpoi4+Ni
         Onne6bm/KoV2djAETGygcLAJ6eYH+23uezvspZkmpn88VHGhUTy1E56+HH0974MbyfSk
         zIrg==
X-Gm-Message-State: AOJu0Yw/G6GszDxr66FsMUTzY3LlCEJdUzV5lVxsK/PcoXB50LY2C+4Z
	hVRanMKCuuCZzYcTuxSj/LDl18fcc/sP88WCYzec/nqtV9Qgz/Q562zjzeysaJiVMJFsJjEL8zT
	7G4Oo5o0b7WwFtdlIaxIEXvzVVVwpOXA5rMJIj6pi3TrVvTN+ZejV7/eUi7KyoSRCZbmGlg==
X-Gm-Gg: ASbGncvFToHHLDr7SoV+1kIW+z6USn9uSwTNg5uwxK97hmm2oEsPGk4CvqOroiHHrCU
	OY5Ty1T8MxsvxdcmoT/BltMTo07GtyYfoaktJtAHfPDerWJcbFlAAuFzxqnXnj1pCjG5tNiKKpr
	GopXRl0Dm1kB8+dK/2sl21E0wFFmQLpeJqjb0iYLhWLCeJGDlYcoiWYTANBk8aZUKrmV9YezoTm
	VovnJ3PTlp50NVGRLvJiorDJhRp3DHU/GByZrGTy9/RI5Mahc/YzY/jVDTF3xAzbTorabAHfb0+
	PTieS1yq1Rxm768XZIlNHI62JY2qOp9Mzx7am3XpsewIdrYW9gj3ZjFQVdLXY7cGsV2u4mpWng2
	52Q==
X-Received: by 2002:a05:6a20:7291:b0:1f5:6c7b:8920 with SMTP id adf61e73a8af0-225b754f67dmr25160038637.9.1751990830416;
        Tue, 08 Jul 2025 09:07:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEx8uJvopcy0UStb0Kr7E+6JdjWAJz8Kx7laF5QwbNdq+bZKU1Tnx3KcDIOgUChw13iwetHww==
X-Received: by 2002:a05:6a20:7291:b0:1f5:6c7b:8920 with SMTP id adf61e73a8af0-225b754f67dmr25159987637.9.1751990829852;
        Tue, 08 Jul 2025 09:07:09 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee5f413fsm11432792a12.41.2025.07.08.09.07.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 09:07:09 -0700 (PDT)
Message-ID: <d2d8778d-a39f-445c-8d08-8759c1aee07f@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 09:07:08 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Add support to enqueue management
 frame at MLD level
To: Roopni Devanathan <quic_rdevanat@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Sriram R <quic_srirrama@quicinc.com>
References: <20250703051711.2839934-1-quic_rdevanat@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250703051711.2839934-1-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDEzNiBTYWx0ZWRfXx+/99CW0KZeg
 HnsuG9c02+mhVDoWS8EPHo/B1TLWjUKOFwV7M8lLZys/e+vH/9OczavWFmQiIlG9lyfi/+EGc4z
 c9Wsq/J0NAAYj0uaj6oAKfIlBhsV3fzkX+IQSJNzKP9yMC5wKC44L/mSXL/RKqD3Mi4sWsAkdSN
 3t9659eloR6N+fS5TRs0UInKtVHSUAE1kv0y5Q/8dYW+3LHRj38YStkWUNRzjI0mejS6e7AUudP
 Iko/aqlo88c3u0zj9HwMcjdmfi0MLBvWaGnLwOiPEub/Bk/RSww8x70Jo/LvDnIna2SJbXeNFKt
 /pnsm+GVR5OceyZHjXT1GkSzowYosikitIGNykqDJa5xfhKiwmya7PW1u0ue7Vf6CwdMaZajd+Q
 2ITwG9couvd1bJ7D6018w3UuppTfTEfF6Yr7IpOmry5UKdh9+rlLSLWp3r+p9Yn+CD18GllF
X-Proofpoint-ORIG-GUID: uN37B0HMOiJld4da3HX2alhcIX3glDWY
X-Proofpoint-GUID: uN37B0HMOiJld4da3HX2alhcIX3glDWY
X-Authority-Analysis: v=2.4 cv=SOBCVPvH c=1 sm=1 tr=0 ts=686d422f cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=51ZbUgjbVmGj9eICDkcA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_04,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0 priorityscore=1501
 adultscore=0 mlxlogscore=965 spamscore=0 impostorscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080136

On 7/2/2025 10:17 PM, Roopni Devanathan wrote:
> From: Sriram R <quic_srirrama@quicinc.com>
> 
> A multi-link client can use any link for transmissions. It can decide to
> put one link in power save mode for longer periods while listening on the
> other links as per MLD listen interval. Unicast management frames sent to
> that link station might get dropped if that link station is in power save
> mode or inactive. In such cases, firmware can take decision on which link
> to use.
> 
> Allow the firmware to decide on which link management frame should be
> sent on, by filling the hardware link with maximum value of u32, so that
> the firmware will not have a specific link to transmit data on and so
> the management frames will be link agnostic. For QCN devices, all action
> frames are marked as link agnostic. For WCN devices, if the device is
> configured as an AP, then all frames other than probe response frames,
> authentication frames, association response frames, re-association response
> frames and ADDBA request frames are marked as link agnostic and if the
> device is configured as a station, then all frames other than probe request
> frames, authentication frames and ADDBA request frames are marked as link
> agnostic.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Co-developed-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/core.h |  1 +
>  drivers/net/wireless/ath/ath12k/hw.c   | 55 +++++++++++++++++++++++++
>  drivers/net/wireless/ath/ath12k/hw.h   |  2 +
>  drivers/net/wireless/ath/ath12k/mac.c  |  5 ++-
>  drivers/net/wireless/ath/ath12k/peer.c |  2 +-
>  drivers/net/wireless/ath/ath12k/peer.h |  1 +
>  drivers/net/wireless/ath/ath12k/wmi.c  | 56 ++++++++++++++++++++++++--
>  drivers/net/wireless/ath/ath12k/wmi.h  | 16 +++++++-
>  8 files changed, 130 insertions(+), 8 deletions(-)

This no longer applies cleanly to ath/main, please rebase

Applying: wifi: ath12k: Add support to enqueue management frame at MLD level
Using index info to reconstruct a base tree...
M       drivers/net/wireless/ath/ath12k/core.h
M       drivers/net/wireless/ath/ath12k/mac.c
M       drivers/net/wireless/ath/ath12k/peer.h
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/wireless/ath/ath12k/peer.h
CONFLICT (content): Merge conflict in drivers/net/wireless/ath/ath12k/peer.h
Auto-merging drivers/net/wireless/ath/ath12k/mac.c
Auto-merging drivers/net/wireless/ath/ath12k/core.h
Recorded preimage for 'drivers/net/wireless/ath/ath12k/peer.h'
error: Failed to merge in the changes.
Patch failed at 0001 wifi: ath12k: Add support to enqueue management frame at MLD level


