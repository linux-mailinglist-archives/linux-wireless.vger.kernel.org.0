Return-Path: <linux-wireless+bounces-21610-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEADA9124B
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 06:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC2BD4446FD
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 04:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB771C3F30;
	Thu, 17 Apr 2025 04:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mmHpJdI7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D59A94A
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 04:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744864917; cv=none; b=N7DklfsuWFlu2dkdGJ4rRPDTCwJqIL8oCZDd3717XBBNqUi2gEumvOOTBFR9J0SANuXR4zg49KCt6gTaWZlOxuQKHkEV1m9eDxMexNqrEwhMlt69Wezlq8Qs3363pw48+ns+e9MyO30VMGbDnIIkyc5c8BTCZIztrQPjEZ9qBbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744864917; c=relaxed/simple;
	bh=wAF3H1vcJKIG6KpdNI5EMzsEx2QBuk1ovHFFapLTHrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k6Ayr0JqbyqjL+UdTcTsuj9Qgd2fA0GMofbMpOnKNXbInFTBraLKamJHa/29sJn+GO7WOdePXclNgh+1NTDl6c4PkLt/W73LP4Vtg/+H8i2dWsAU1SQXQ6IJ8MbmmzRyqw/YkMFMbPhXl8udF0ULZalliqZHb8FfoOQJOPcEE3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mmHpJdI7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GLfwf7020919
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 04:41:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pexxP1BldCAQGLWFjmCHmMyENzgBZNbzttjY9v6BE9c=; b=mmHpJdI7H1xnsZ41
	VATn+urJPX0vXBv/b/QCIfOCDsTUIux5iFrHd6yOvm8Ek2xbTDACU2BGulUay5lR
	aPj+kj31YbD/6i9eQFRvUl4kcdZE3Y3dIoXTniXnTgthZKqaF0LURN9qQHDOW3wG
	QYZ98RgZeS1zS54WP98TDUge/WWZOzvfezDqBUzT3vihO/3I45Nwg0Yh7rcsfMmQ
	rKuPdyTdnJwR9cOxUohqa1g7KtKqcWJMiq0GeK9QlnQ5lHUF4jXroX1bT/kWLPll
	JfmsmhUO9ERXgb9ukmQ1NUI6Lyw2Xv1InCsgwKHZBIOjDeTMLvt2xBm14/KfdF3g
	7KZDGQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yhbpwetu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 04:41:54 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-224347aef79so6942715ad.2
        for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 21:41:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744864914; x=1745469714;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pexxP1BldCAQGLWFjmCHmMyENzgBZNbzttjY9v6BE9c=;
        b=ND6VlqNh24HlrR8v3120EN/jIK/PF5SoqOMxQZDEp/KM+X37ENwcG6DhK6ugrqov/h
         3ygx4B9JSXcMESpq4rVAhVX1qZFO3gF51vyDQtgKgFqCFqzi160cnRuHmcBMb1SXQdvH
         /zi7lHC4ZTi8U2b7+shrPiMw//87kfnGR0qsyDxAxV6VUbt2hkHe+6a2Rtpxa1vdZanF
         lk+RMR4tkzMFOypasGUvizVPNO8iJi2aqeF1mBOUFBS3Bqy3j+P/02KNKWxDspyqUHk/
         Hp0QnQTH+6+KWBv9E0IgS8FWVvZ4O2rin2mNI0We/DDW3XXt8R28nfYhwrr19TI1szPz
         gnJA==
X-Gm-Message-State: AOJu0YyIzy6MYDeJCxP3mddyA6koIY0x+A6yIPBAl0OIPDrv0XRJLt8n
	hd3xBCbAz3GhB0Os7Nw6C5kfXR0NblSoXG2Hr/BJBqQPwDa5KcXU/F97fLGRO3SJlGMKspddMRO
	RdlzAoQ3vqbLKPK106g+E7VzYOqosxtJz6EUu9zI7Iz8PEsyRCWPvQ/duPEmZ/1sIMm16o33GWg
	==
X-Gm-Gg: ASbGncub2URrPsdD4nLLiGxHYsnz9VnemW8py3hW2un/PfggvckNKISnFD+25IlwqdS
	WwOiMuCnjz5UPSkEpGdGQYiIcSXmtVfv8KbNrTTaJm3uD4mhAcKcCQF843RF8eziVi2jEle3SUq
	RAzOh8N88Wb3Q1fLi3B6vNmkJxqi6bboNXcHLKh/GQ39OECaGiUPm1QvB2AdbaCfWsRnSVel57e
	UiINtBkMCYA3X0gb1hmm9Xx2DXNJRHW4UjfqNjPMqihH5TOo998/yHDwgUMj6YmLzbH2hk+33Me
	hEtc+xI9Ao8M9NozpgZL+i9X0ZgzHDNEtYsNf6mdf/4RhU+Gh8pkjQ==
X-Received: by 2002:a17:903:3d06:b0:220:c164:6ee1 with SMTP id d9443c01a7336-22c3596beebmr80397265ad.32.1744864913907;
        Wed, 16 Apr 2025 21:41:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnxgABVyQ+50teya7J1uDHzzYjq9CTMyzfTfNU4Iltl7W9rxvuxC8y27LNLZZzC36uigpoDQ==
X-Received: by 2002:a17:903:3d06:b0:220:c164:6ee1 with SMTP id d9443c01a7336-22c3596beebmr80396925ad.32.1744864913380;
        Wed, 16 Apr 2025 21:41:53 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33ef11c7sm23564205ad.37.2025.04.16.21.41.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 21:41:53 -0700 (PDT)
Message-ID: <9f619ba1-b29d-e1a3-b286-089047fd476e@oss.qualcomm.com>
Date: Thu, 17 Apr 2025 10:11:50 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next v2] wifi: ath12k: Add MSDU length validation for
 tkip mic error error
Content-Language: en-US
To: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, P Praneesh <quic_ppranees@quicinc.com>
References: <20250416021903.3178962-1-nithyanantham.paramasivam@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250416021903.3178962-1-nithyanantham.paramasivam@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: VvPIzvRgbfwj7fmDuouRixBGi-G9K9rR
X-Proofpoint-GUID: VvPIzvRgbfwj7fmDuouRixBGi-G9K9rR
X-Authority-Analysis: v=2.4 cv=I+plRMgg c=1 sm=1 tr=0 ts=68008693 cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=fAuNF8LVcKM9mBkeKYMA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_01,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=750 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170034



On 4/16/2025 7:49 AM, Nithyanantham Paramasivam wrote:
> From: P Praneesh <quic_ppranees@quicinc.com>
> 
> In the WBM error path, while processing TKIP MIC errors, MSDU length
> is fetched from the hal_rx_desc's msdu_end. This MSDU length is
> directly passed to skb_put without validation. In stress test
> scenarios, the WBM error ring may receive invalid descriptors, which
> could lead to an invalid MSDU length.
> 
> To fix this, add a check to drop the skb when the calculated MSDU
> length is greater than the skb size.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

