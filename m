Return-Path: <linux-wireless+bounces-19116-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFAAA3B06E
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 05:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B41FC3A77D2
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 04:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400591ADC82;
	Wed, 19 Feb 2025 04:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MC5xWV/c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769EF1A9B5D
	for <linux-wireless@vger.kernel.org>; Wed, 19 Feb 2025 04:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739939880; cv=none; b=bYjAEySUFv6vwMnxuUdmkMwMS55IeXsVRzRsXDOkrZNKfvXmpk6HvIIFb/bCLaSkfmwkU4iLR8+2Ki+0rR3KhkLTYDE9rEin8Qfiwlllko37NGw/MDF7V0ldMsehm4pJkzLzTuH8t53b4gLp/yBV9mH7XJEsR0rt9snKdubGl04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739939880; c=relaxed/simple;
	bh=XmOLvaqNRn23MdXeplg9lIrLalW/IxO0/ipc6ATj/9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T4XjMbUkVXQEgS8vNU3fmj0e4yR2nw546Rz48Oz4oEC9lOuHCT+VIHAxUsj/t5/jHR2VKBgdCS+baEC0f/3ecD9G95BTJ+DSG6pRH2kJaBCue7pbGWQPkGVeWhKAzpBz4OrCDX5Km+vOqj5zIYHLSI8EZiZtrsmdZLvwtXzFia0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MC5xWV/c; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IIwI4G012173
	for <linux-wireless@vger.kernel.org>; Wed, 19 Feb 2025 04:37:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L1hJHeRdvrxN7D7bAQ1tkQSoXz5lkTgiTdXGO3DQAd4=; b=MC5xWV/c6h9XIZyO
	erb7BNBUkKTbAAPUt8kvA+ivsejwqaJhOp755jMZBUhVoduBC7ONaccgkWjBfFlb
	eOrIVT6/Dft9To4p4G7sCVCJBzKVpWwcdCTyRJ8SbNg3auJstDnYGYBfZjUOedKO
	IhZtAJSJ9NO8SlhTvKj/6/husW/Ixh4Ya+VARxvWeuL8uNxrXQ6yP3XQLBIsYclI
	jtC21yw+JQ2N/UkEyBkAWg1LneAsk6snzzKrR4QNOg2zD0b0doQ95CGxWKiLT4wu
	cClzBbBzZ0N1JFSfsNdeyIagGxOKmB5S61HOaphPMkuDSZrFM5El1S47u81Rnbrt
	cDqs4Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy1h771-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 19 Feb 2025 04:37:57 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fc2e648da3so9560074a91.3
        for <linux-wireless@vger.kernel.org>; Tue, 18 Feb 2025 20:37:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739939877; x=1740544677;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L1hJHeRdvrxN7D7bAQ1tkQSoXz5lkTgiTdXGO3DQAd4=;
        b=Lhs1I9/Riber2QyJYVzIp+5dZwPY2S4KVNzb1x6rB4mdeSc9QEVEvBT5ZuSG/NZmda
         Cn5bGXs8eohrw/V3gkqhajPeFO0NBxcZSOFiED8o2vzzxP5gzZ18T/jfusw08yBeGhET
         ThFaWtgZ1ad3gf8ZwsWIv+FQoQgjgWkR93ZWhpPrBAkJoE4YZf7wSFg6+Uj3lQuegl5c
         itHTVQ2/L1Xkajjv2UaAQ5CiJOeppRNycRpsXxjvZtSk6GEbR7CW+G+qaj3PTZy/d5U7
         Y33Mc4q9Gq/0EUaA6+qP1Y9ZiKppnh6pmYOSbW3xwXpEtfzevJpMoVsGYJAa8FITvdhd
         xvMQ==
X-Gm-Message-State: AOJu0YymmMfn18US3H19bIkIrYg7/kPdZ2ft28LFSfQpTiReX5bg5hZD
	nwXgRxjIRfjt1NbUN+cBUQIfLmbzvlQAKpl+HXyzBhjDRCIwAARh/BPbSZY4ZhHQ2BV/J3Q7/GL
	qLAwyZeRMuWLJ2wd9MgnA22YTbT/xdRRt8HSUGEQ64WdtZxXycPBrTjxtkKWYnByp0A==
X-Gm-Gg: ASbGncvTsM4KgeELZmAx8bTiBGSKNkjAl0xFpXbTbVQzIFrkYBeTqzu+XYD/vOecLCR
	MaOTMK8aCgfgcFqUYVp7dCi7+NqPX6c2IwJyucpwzIqfiSYkcHkzOUP1cCuI/hZQwWC69GqIP5E
	1OOkPL4NovuxMinjYM5Ko39uBBVBvJeDjsbGCMlIyu8Tndz9RON1c4ME7BkMG1LkOahMHZk6K0n
	Z2LaEca4bVeTvBVIMaVwheT0eiC/H0vhM0TMiKuEsaZt2jmXZZU1BE7LOtaZ1aKhPNJeChlPbky
	uJlHWWnCtra41PIKzkA2DbVoi5GAGozcWAWs8OZ2zzFfT3I=
X-Received: by 2002:a17:90b:4c:b0:2ee:d63f:d8f with SMTP id 98e67ed59e1d1-2fcb5a17ce5mr3349356a91.13.1739939876672;
        Tue, 18 Feb 2025 20:37:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFle3lmxHIw+H2gI+gxquxoRm9z5kso3AjZ+ApAGN89RR8ZZNSCaMoSvlE2f4M0BrrspurJcA==
X-Received: by 2002:a17:90b:4c:b0:2ee:d63f:d8f with SMTP id 98e67ed59e1d1-2fcb5a17ce5mr3349329a91.13.1739939876270;
        Tue, 18 Feb 2025 20:37:56 -0800 (PST)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf98b4c52sm12915647a91.4.2025.02.18.20.37.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 20:37:55 -0800 (PST)
Message-ID: <617b8162-863b-1512-9b62-9c49ee07c54d@oss.qualcomm.com>
Date: Wed, 19 Feb 2025 10:07:52 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v10 1/4] wifi: ath12k: add configure country code for
 WCN7850
Content-Language: en-US
To: Kang Yang <quic_kangyang@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250212063200.1631-1-quic_kangyang@quicinc.com>
 <20250212063200.1631-2-quic_kangyang@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250212063200.1631-2-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: QZkOt362_1myHifaqKmxxRGiwfoeE39g
X-Proofpoint-ORIG-GUID: QZkOt362_1myHifaqKmxxRGiwfoeE39g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_01,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 adultscore=0 malwarescore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=856 suspectscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502190033



On 2/12/2025 12:01 PM, Kang Yang wrote:
> From: Wen Gong <quic_wgong@quicinc.com>
> 
> Currently, WMI_SET_INIT_COUNTRY_CMDID is used to set country code for
> WCN7850 and QCN9274.
> 
> But WMI_SET_INIT_COUNTRY_CMDID is not the correct command for WCN7850.
> 
> Add handler to send WMI_SET_CURRENT_COUNTRY_CMDID to firmware, which
> is used for WCN7850 to update country code.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>


Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

