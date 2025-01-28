Return-Path: <linux-wireless+bounces-18071-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA83A20C59
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 15:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 426D61889657
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 14:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7299E19AD48;
	Tue, 28 Jan 2025 14:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dDLjCMWH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0A5F9F8
	for <linux-wireless@vger.kernel.org>; Tue, 28 Jan 2025 14:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738075992; cv=none; b=MbhWdsx5QNJS6i9Zy0IHjjUt5fD43ogrc9D6b8/WIFWOq/cZT36qik8SERK+oK699Z1Va8q6lDEoOtyXMIZeFmyVhR4U6oiAuNTCX+3vJf6xsGDPbUTEuFEmnFTCHEIvDnzz5oS2KdhFZo1DyYRoEr0KDfPEuE6EqtQeHQK0+Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738075992; c=relaxed/simple;
	bh=0JEd27JctMKQdmgCBB5cVr3+Q94+juaCQeJWRk73Ddw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pod+Z1zITiSU93qjsLBeft+A4ZtJD92raQDbMNs0lvpmd9BLjvo3QLIo3acCh9t9cFPbedIr0RF2Vf777M70w4cHdQHhr0khyK5TiVPm33/Z4781THiNggUYvG1DWEe1LW/8mG6rnhuLND7fqLrJJoZ39Y+gD9rhhS1g4dSoR0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dDLjCMWH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50S9lmu5019036
	for <linux-wireless@vger.kernel.org>; Tue, 28 Jan 2025 14:53:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AroXVuyqk4ebuD7fOzoCQq+wPsBrvou1mnrYuKOiENo=; b=dDLjCMWHCyvqHHOX
	PShuUUnv1N+gapm8KpH3KDWJgrdDxDLp9qRYfzvj+5vYdNd2AcaZuhvaTEfCDM5+
	xYTATlBpUW45y7Ok7E+8fOsxUwvOvVVDatNQvVLn0UkWabD77ematgJde1LCQh0w
	XYFuuXvLhD5Qq3QIh26hJEt1qRRQI0uJfwFtROrDXnoLEfp4Ky5NuwnbQ+FEhQy+
	qSq93gclpFzznaAGiczSSw0bUkgKog+gBdgD2W4aD4aC3hTdsq3F2IWknQD83Lf/
	3JWaE7uBZijxVAml8vxdsfwkO2+gnHRFCiQrlOutoBbleiTw6eGF/+lZTGOV3frQ
	eIdHEg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44evwugpta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 28 Jan 2025 14:53:10 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-21638389f63so87765825ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 28 Jan 2025 06:53:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738075989; x=1738680789;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AroXVuyqk4ebuD7fOzoCQq+wPsBrvou1mnrYuKOiENo=;
        b=HHjZvI5B2BQs+slGT1MJPr87RYl5qjP59M4NkjquS7FMzczYKuwwYsTmPPSNinCmvn
         UGCOc3c/nGx1nJS+hwDrsu6OrP+j2kA4EUU4sOvHkd17bPboNGsLl8Gx+38yaU+LrK2N
         qVZdnva/LnK0t+eZvYyRYXBQZ7YTdEhZee5XkNgbpkNHliD/7zHLjUVfvHHy533V9FXz
         eXzHK81igIxtXsW7BNZNTCVL9G9Jv7fAPCsx5MkSEbaSxYp5gTMEnxG1daO1sHIcRIYi
         Ue3splgoVzuglN5N94rvMsZA0YbD7QitPGcDzZVHoiOMosfMp7cbhWWrRtZ69jGocmIO
         6cSg==
X-Gm-Message-State: AOJu0YxteSC/+FlpyOvgz359Wvuz7Tc4cms6Db0sfHQrIkOOAt5KoCAv
	16MNIIJZl2YL3xwYn1UXJzf2vm8LGBIs5mOYriAv8bKUuCzP9GIQOy8ba++RJ5wu3U9qmDdYX85
	dVxpN/KrgCUi4wzkJzRf4URh31VvvzPVc+C9ajJfMhV1HSQ4EyJl4Q1kaaLBEzwnxUw==
X-Gm-Gg: ASbGncsKPI8tORP7g+HBAHXSfNsVGIGEH1IOvqbRpz2wOKe0NqGQlQYMIDLA2U/+i4J
	Pgn0fYVGLtx4WhzH4EJkgAEZYcm0L+AQC7B3iBJ6X+Zz1rMd/HH1sTXCcgpRibS8v0Gqexex3f9
	hbPpAQcgpnKx9KQD06d6QXzRNs83bzKyvpWLVa0/Q5n7jCAeWJrDfZaJKGkriszwd1hqwzDgQlP
	gMtWP44tTzREv8cNJ/+IELmQhY3vWSf54EkNUoHXXPnjtIwdD2ICcY/CkbC80+6vqZ+or1G9GNU
	v/DBptuUNGLgnUm4C/bRrVSVeKieZVL7JqW2ovNLCw==
X-Received: by 2002:a17:903:11cd:b0:215:b5c6:9ee8 with SMTP id d9443c01a7336-21c351d3065mr599704605ad.7.1738075988828;
        Tue, 28 Jan 2025 06:53:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDcEM2Qm5bG+KZ4ryMMgVAQ+hzP7QUPCz3RjLizBOlvoq8EQ2pMKpui4TFDRtskPfJJooU7g==
X-Received: by 2002:a17:903:11cd:b0:215:b5c6:9ee8 with SMTP id d9443c01a7336-21c351d3065mr599704265ad.7.1738075988459;
        Tue, 28 Jan 2025 06:53:08 -0800 (PST)
Received: from [192.168.29.221] ([49.37.208.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414cb74sm82366515ad.161.2025.01.28.06.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2025 06:53:08 -0800 (PST)
Message-ID: <cdbdfc44-849d-449b-8c27-c175344440b6@oss.qualcomm.com>
Date: Tue, 28 Jan 2025 20:23:05 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] wifi: ath12k: Add Support to Calculate and Display
 TPC Values
To: Roopni Devanathan <quic_rdevanat@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>
References: <20250128111059.1690113-1-quic_rdevanat@quicinc.com>
 <20250128111059.1690113-3-quic_rdevanat@quicinc.com>
Content-Language: en-US
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
In-Reply-To: <20250128111059.1690113-3-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 8WsVqlCkP12eZ1tG1ssHTB_xQ6qi99d-
X-Proofpoint-ORIG-GUID: 8WsVqlCkP12eZ1tG1ssHTB_xQ6qi99d-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=957
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280110

On 1/28/25 16:40, Roopni Devanathan wrote:
> From: Sowmiya Sree Elavalagan<quic_ssreeela@quicinc.com>
> 
> Transmit Power Control(TPC) stats should display per chain TPC value per
> radio. Add debugfs support to read and display TPC stats type and TPC
> stats. Take power values for each preamble type, rate and NSS combination
> from a particular index from each power arrays based on number of chains,
> NSS, modes, MCS and tx beamforming enabled/disabled parameters. Minimum
> of the values taken from reg power table, rates and Conformance Test
> Limit(CTL) array table should give the TPC which is in 0.25 dBm steps.
> 
> Sample Output:
> -------------
> echo 1 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/tpc_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/tpc_stats
> 
> *************** TPC config **************
> * powers are in 0.25 dBm steps
> reg domain-22           chan freq-5955
> power limit-126         max reg-domain Power-252
> No.of tx chain-4        No.of rates-1164
> **************** SU WITH TXBF ****************
>                                  TPC values for Active chains
> Rate idx Preamble Rate code     1-Chain 2-Chain 3-Chain 4-Chain
> 4        OFDM    0x000          39      15      1       -9
> 5        OFDM    0x001          39      15      1       -9
> .....
> 12       HT20    0x200          40      16      2       -8
> 13       HT20    0x201          40      16      2       -8
> .....
> 44       HT40    0x200          88      88      88      88
> 45       HT40    0x201          88      88      88      88
> .....
> 76       VHT20   0x300          40      16      2       -8
> 77       VHT20   0x301          40      16      2       -8
> .....
> 172      VHT40   0x300          88      88      88      88
> 173      VHT40   0x301          88      88      88      88
> .....
> 412      HE20    0x400          88      88      88      88
> 413      HE20    0x401          88      88      88      88
> .....
> 508      HE40    0x400          76      76      76      76
> 509      HE40    0x401          76      76      76      76
> .....
> 748      EHT20   0x50e          88      88      88      88
> 749      EHT20   0x50f          88      88      88      88
> .....
> 812      EHT40   0x50e          88      88      88      88
> 813      EHT40   0x50f          88      88      88      88
> .....
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00214-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Sowmiya Sree Elavalagan<quic_ssreeela@quicinc.com>
> Co-developed-by: Ramya Gnanasekar<quic_rgnanase@quicinc.com>
> Signed-off-by: Ramya Gnanasekar<quic_rgnanase@quicinc.com>
> Co-developed-by: Roopni Devanathan<quic_rdevanat@quicinc.com>
> Signed-off-by: Roopni Devanathan<quic_rdevanat@quicinc.com>
> ---

Reviewed-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

-- 
Aditya

