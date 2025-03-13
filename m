Return-Path: <linux-wireless+bounces-20348-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6C5A5FE4B
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 18:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 242B13AA1EB
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 17:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82680376F1;
	Thu, 13 Mar 2025 17:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AVCB+8cE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A28155CBD
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 17:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741887713; cv=none; b=F0mwNsLHNYLX4e2ZcgVZpH6vTBf9V3CQzjeH/t21IGmhqsDI1WzBg0x01/WaK2irm5YSfR6n3XvXpsj+7cd4Uat3LSCRR4ZgE7ONBGukLOmiNzE0ZNVCqPUClnBbbFZPW/HPPNXw04L/LMy3++i4J6cpG4pNh2ggQO2NgQcM1N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741887713; c=relaxed/simple;
	bh=70SzPkHoV7Uf2QL7Lqohydf14G7FdUmLWh2TxjNVjDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VeaPL7DYk8c9dDtcBsnRLpwezKHkcNp5BYFWSbs1UZYFamz8K/jB1Yndz5KQTQ/tBc+ZQQX8ztU/uKPI5mpstxlQZ3Zp8JsTNk/CTOu6Ouh/u3HjyRjrVhymSl5Q4QeW4f6MlvMz2qMXAH0X+3hdoanZvFSvM/nfNv7XdfCVovI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AVCB+8cE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52D9A52B018566
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 17:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nTbGDkMG71Vja7DElwOL23J/vRzorTHUbqxSp3pihno=; b=AVCB+8cEkqpDM10r
	dJVFAf7dDVENY6tPE+JcBQFB3AhhQiGWIc3lTA4MRs1Uj1bKFxUoYo8kW8ntqtuE
	xTihgqsOjQnrO+AmNumpRzm0WkinO230sMbpXmNMNfL39ywNgrNOL1O+oQvcrg/q
	uOkZE2LCxA+AzhaYcKDyIgHt7+pojHXqKQbTYMSvM2oxQqCYf/w471uYszh0gDIo
	2iGSp+d75rCCoqnwkDxxn3HterEmk2PKxYREcAw5Y6l366o8/mcwXJ2JxZVlz7dx
	NllC2SVQLqaLRTlnpZihvyM1/3Ens9BFEZGURINm72fMZJpxMbq6l4C30mgAcG7C
	Rrj4Ug==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2nxr3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 17:41:50 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-224347aef79so6719575ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 10:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741887709; x=1742492509;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nTbGDkMG71Vja7DElwOL23J/vRzorTHUbqxSp3pihno=;
        b=TgdiEHLIaAKZzVFnx9CInWnPFfZbj1gbJUKk7P1QnPC7+Ek9pRjTPKf1UO3SeFpHqJ
         EuzQeZppf1u4vnoAFi8MjVX/I1IHEZMhZ/wH3IDTA6J3dHpAzjWhaHv1lKqMojcFV6ux
         LGkSP15+/V42fGcradLS+WzCvfHWZn4oBRpfbTE8KJ1626swLUj3pHqKRPjQ1R3WKHTD
         Hbr2SaY2oB2UjfGu+Seamaul9lwdYByJ3BMoHNNK/7ROrubR5BafBrgJiPrf7AHyhIPM
         TLok/89fi6sPuUfiSbbP2bbcfk+NUyALE42EPA0kneVVTnLIfTK/lj6lsEtxLLFVvCXO
         NW6Q==
X-Gm-Message-State: AOJu0YwuLkH12Ww9m9Loj69a4WkBTqM1WyayLKcntneyyF3J7CMFg4YX
	kjNMNOOF/TEpGtt+JBIDGAoNwGcXwX5N1uhs42xThjFSmhho/TYHdynu9ksUWhCsM8SKpYA1FIZ
	J/1OHLs/XsqisJwxv7V9ZhBoCh8mH3eZKyX/6YT/4PMRc4TKGMZ3R2381b/ka1msHy0CuUx1vpA
	==
X-Gm-Gg: ASbGncv5Vt2PNaPJG1K9kSVNrK9eUNemrhAg7nHjPoqoFWd740W5dR/C96li4KII1Qh
	zJ8FbE65eW6KXQxG6c+FMzqMCNo0IuuVyOmwb4BaVaMeOGUqDEFQT6lvyGcedX6nE25bHdquqVw
	rQRlC7K7OUadt5uedA1mv8ng1eggHsL7Fyodj0hIfi1fEWdBxCTyeYkTDYbbSRiebUQ6tZdiZ6V
	7FEnVc9YwZYBwRoGjWAB1D9Hlq0+7atNi01i/yCzRSf8IE8NVqv/XFmgJp4rONPafhiES57+zZV
	giUocHHC7Hol0QA9N9K77Auy34kjpiBOWfajQBq5KX8GCwESFNDeEHEmdF/Y09TR
X-Received: by 2002:a05:6a00:1c83:b0:736:6268:9ec9 with SMTP id d2e1a72fcca58-7371f1729a0mr531747b3a.16.1741887708763;
        Thu, 13 Mar 2025 10:41:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+uA3/wpnHTBfcMzXqUODV9pt19PlgNU43UkdbZDOtFYgif7SoOnZsveKAVGUHK18cyQ5hzA==
X-Received: by 2002:a05:6a00:1c83:b0:736:6268:9ec9 with SMTP id d2e1a72fcca58-7371f1729a0mr531724b3a.16.1741887708368;
        Thu, 13 Mar 2025 10:41:48 -0700 (PDT)
Received: from [192.168.225.142] ([157.51.162.105])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73711695a2esm1659613b3a.144.2025.03.13.10.41.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 10:41:48 -0700 (PDT)
Message-ID: <9e0082a6-ac19-6f34-efb1-b22df836eacf@oss.qualcomm.com>
Date: Thu, 13 Mar 2025 23:11:44 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v9 9/9] wifi: ath12k: add monitor interface support on
 QCN9274
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, P Praneesh <quic_ppranees@quicinc.com>
References: <20250313162100.2364049-1-quic_periyasa@quicinc.com>
 <20250313162100.2364049-10-quic_periyasa@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250313162100.2364049-10-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: yyqa5zpwzpedtsVfL21JLm6ZyWbnlTpX
X-Authority-Analysis: v=2.4 cv=Q4XS452a c=1 sm=1 tr=0 ts=67d318de cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=KnbpFunUQJgWYJTnieH9nw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=xH0xcr9_mYJ7sMi6Wl4A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: yyqa5zpwzpedtsVfL21JLm6ZyWbnlTpX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_08,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=892 adultscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130135



On 3/13/2025 9:51 PM, Karthikeyan Periyasamy wrote:
> From: P Praneesh <quic_ppranees@quicinc.com>
> 
> Currently, the monitor interface is not supported. To support the monitor
> interface, configure the monitor vdev state identifier, configure the HTT
> filter setup, subscribe the mac80211 NO_VIRTUAL_MONITOR feature, remove
> the mac80211 callback config handler functionality since align to
> NO_VIRTUAL_MONITOR feature and prevent monitor interface to transmit
> packet. Therefore, add these procedures to add monitor interface support
> and enable the monitor interface support on the QCN9274 platform through
> the hardware parameter.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

