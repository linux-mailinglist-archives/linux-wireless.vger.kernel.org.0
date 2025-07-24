Return-Path: <linux-wireless+bounces-25996-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C2EB10E06
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 16:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D4FE7B2A4A
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 14:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06A62E92A3;
	Thu, 24 Jul 2025 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iIxBNV7T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA74F2D6407
	for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 14:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753368627; cv=none; b=L4o5qAgy4c9ElRHBIyI6CrBkvFom9lpOC6HJ1ELo7Vf5GOTiXU8LXUHzR6oDcOLYlsYQ4KnvuonMS3aCuFIwpFyO+vx/X5gfP3IIC3NDgnoe/o3iFWnXcgdNy7a9ltawvWr/+6+DYeSh0DlPJklPM7qtIFOa5AITcDmt30bK6rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753368627; c=relaxed/simple;
	bh=ZrA15r1CTGqGK3u7rONsiaIHqyMl4k0ZXQ35MKucp/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sO6Mb9pPTnnGWzd/6X6PxDSN/w6jMIIzRMLnesLy6FKuitP2zvuqKMu/BtCaaTRewGH8QFRwnU3ZpVwHGuU4JyZ0b4j/vHjFyYGC+EpNRy4UAIs68qXXbSmo+7mN1tSNiy9k1M6FuLHL6zkPiT0D07+KUak/62nGez3vKEN8ZbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iIxBNV7T; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9XORi006573
	for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 14:50:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YUfuLEoIdnAariUu5FlxMQ5ppIVG+Q99o1Gqqtl6aus=; b=iIxBNV7TTRgMZYbz
	ll0LyL3FrTsl7y+RZxoH/nsd+LxeCofhyiMv6wYQ3vOeX81QTOk7JFd2avPhFlWI
	mECZ+xdhL7Y/ubeLdnCFzimKjveI145gPOUXYjVBzBnEe9bZTB/chZ6I6BASA0cL
	N3YcYz73aeDx3EFYFkBTppXsDgWHiBtkHNQZDZSUSEZ62CsDq2t/LN0ssm9+odpa
	JQ6OljuNj3BasXQ4n9cf2bzjU8iT7XxMQkkYtUmW/phj0WNwKbvNLgAhdNjSyKqy
	8q4T97p+nXzWCeZpF2W8WI+x4IH15khbBpkgGHhRJUuytwCckqOlTWqYylwVziLH
	9GOxGw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48047qh530-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 14:50:24 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-74d15d8dcd1so1045518b3a.2
        for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 07:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753368623; x=1753973423;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YUfuLEoIdnAariUu5FlxMQ5ppIVG+Q99o1Gqqtl6aus=;
        b=izAah0cbMHQPL/NHXMPP+GnqxZCky2vMmiZnjV5a1eydrdxbOO+8dIhaRIXtRfGW98
         KYyivukl1uSQR1Zroqe0BGya8nGBTBUz9xfeAeekXTz5VPCs+cG7HvrNiwkpEjhcZolZ
         +GklY2WZ+2jhq8YpKrAdZM8ocsBAbk+JFRZXKLhmCDprUROQLIJFZ6sfehW9rdQcWlBL
         L+kZ+uqFgaKcbt8FraUHC8tIe13kxPgYNnorLeLb/pyjMH18+b9VbWa7WUPbLupDORsy
         Q35bjFLkeN4w9EuUOCeYn8xIXwbIvhv0asoyh8Ff6eQEX3PPD6OoX7ubUgUcUef31A75
         OxIw==
X-Gm-Message-State: AOJu0Ywr7iB5qU42i49nn2ZQeecvY+OkAjg6UycBxwFs3Vz1LGohqrNm
	rhTpE1vqYjCqtcestxgI0B5029vYpRbU1FwZCjlnSUBp5ioJEiCh0LpPuiQ8FUPXIwx2ygvSjHY
	cj/FEwUv6We8Ytk0XalT7ljx9DawuCTUzIwmlJ9cpV58wNapp69K0oqIgAQHjzaZn7JLq6w==
X-Gm-Gg: ASbGncuY6ApI5b5Kn4YIEz5C/q4Sdvh6Le12cwOVkvtUkEPDcahdxg6khtX6NKn8lKF
	w5fOr3s94lj9wOgkPIOu3ifEzluR4g7QdFXrAMT3UxhGttOcbguVQQlRbdhqj6ins/7fZdXoMvz
	vPY3F/mZE4mp9qTvDajT5rSrPg7+SdIgjRhy086lg4TcThc9aKZiNQK/3odEe+jOH+Ees3ikQPk
	0C/4V9YS1myzdf6OEwf3d9TnNHxWrj5T4zpctrr4mC6uPSdFuzcJsIxROiSVeYOB/y3XXABW7OX
	i05nskUs02UgM+SVcMzt2ag02rFGIGMCJEWx0K4mepAjdCy9HDGvjupDyABfyCvF4Q75YWFeO7I
	msc0JUevpMZL7
X-Received: by 2002:a05:6a21:a344:b0:237:b2ff:d1e9 with SMTP id adf61e73a8af0-23d48fe385bmr10442617637.5.1753368623380;
        Thu, 24 Jul 2025 07:50:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIx9fxxFZ30mC0lr5rlZjBmEUhtphZzqcrttRBZnGvl0JMReiDlPTpW0EzyJwjRUmfnr4q5g==
X-Received: by 2002:a05:6a21:a344:b0:237:b2ff:d1e9 with SMTP id adf61e73a8af0-23d48fe385bmr10442586637.5.1753368623011;
        Thu, 24 Jul 2025 07:50:23 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.197.167])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f6c0807aasm1611486a12.11.2025.07.24.07.50.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 07:50:22 -0700 (PDT)
Message-ID: <bb79687c-fa7b-4a7b-80e6-abace493cfe2@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 20:20:18 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next] wifi: ath12k: Fix peer lookup in
 ath12k_dp_mon_rx_deliver_msdu()
Content-Language: en-US
To: Aishwarya R <aishwarya.r@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Hari Chandrakanthan <quic_haric@quicinc.com>
References: <20250724040552.1170642-1-aishwarya.r@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250724040552.1170642-1-aishwarya.r@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDExMiBTYWx0ZWRfX4+4OgTkMVakY
 1RBRznuNuPieSS6sks2itc4b5ouLKV8i7CAnI0Zr1bNsza/WWNkUN4qi7T6FNatnFDw9hA87l0Y
 Md2hIKGJ2x7Sf7omRdt7/OQpA7Q12rScLJYX1SclVqXcui+5inGWCyUH0BrJ3L6TnqIYC3mBtao
 YYYYT5mpyCrDk4nko3p31ir57EB83//1O7E5h1cPbJbNr7GDmkU+paLE/1RyeDsrt1mePoLz/Nm
 225Rvc4P1zTbjtbfuBiK1tqvrny5VX37jg+zugxnhYGm8W2SO9hE/9kRkCHA48uYrdUEH9t++iC
 aYPZqnkz4nA/yIbOI2COM98pUYdgPp5H8oVKtBlCY5MOzl8ojShasdsOTslc4WjqOsvq+5cArOS
 bWKfvfOn+NzTORf7FF6nYw6LVFB1koLmjIStRtqxltURH7FOXQiGdtwbN9KVCl883E53b4VC
X-Proofpoint-ORIG-GUID: YUa2Yg3GKVKWsO7UJZ3qSsjbIu1_Whve
X-Proofpoint-GUID: YUa2Yg3GKVKWsO7UJZ3qSsjbIu1_Whve
X-Authority-Analysis: v=2.4 cv=IrMecK/g c=1 sm=1 tr=0 ts=68824830 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=CkStrBlBBtcNoDngQR/Gdw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=BhMcNSPQYusP4RIe-kMA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=731 phishscore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240112



On 7/24/2025 9:35 AM, Aishwarya R wrote:
> From: Hari Chandrakanthan <quic_haric@quicinc.com>
> 
> In ath12k_dp_mon_rx_deliver_msdu(), peer lookup fails because
> rxcb->peer_id is not updated with a valid value. This is expected
> in monitor mode, where RX frames bypass the regular RX
> descriptor path that typically sets rxcb->peer_id.
> As a result, the peer is NULL, and link_id and link_valid fields
> in the RX status are not populated. This leads to a WARN_ON in
> mac80211 when it receives data frame from an associated station
> with invalid link_id.
> 
> Fix this potential issue by using ppduinfo->peer_id, which holds
> the correct peer id for the received frame. This ensures that the
> peer is correctly found and the associated link metadata is updated
> accordingly.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> 
> Fixes: bd00cc7e8a4c ("wifi: ath12k: replace the usage of rx desc with rx_info")
> Signed-off-by: Hari Chandrakanthan <quic_haric@quicinc.com>
> Signed-off-by: Aishwarya R <aishwarya.r@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

