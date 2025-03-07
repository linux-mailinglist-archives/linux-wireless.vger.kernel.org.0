Return-Path: <linux-wireless+bounces-19972-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC6CA55D1F
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 02:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87A4F174A18
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 01:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A87125DF;
	Fri,  7 Mar 2025 01:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jtoXYqgN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAC5D517
	for <linux-wireless@vger.kernel.org>; Fri,  7 Mar 2025 01:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741311045; cv=none; b=EwYCpMHjltp1NJd4uOubURbs4Y2S98SSvNwo06f5yU5XNE3QYFo5pLW9/5/byjML2vhGu9ZwXzYfwEPN20INHOOaBagY3KEoaTppnlylpBdhfvq7gVOnzRGbslZukRzivH4kqJdIbF0Xj3ATs8GZnPWV4OymniaAu1oXtQQ4S8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741311045; c=relaxed/simple;
	bh=V56PrXtUNRYIEljKzJZlC8DhJVuzqTdT+f7zYaexx/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uhzl9lvZGMqVmJcjTf7mVAhdhkRBldvjQwUvuTOFUTBSCQye8OExJ9hP0DSBLWcp4w4fRrxiV2xVrk6gIiwa6YtYX8gG6uPyWsykuRwrmo8i3cYH0LO9+IpNbCvH9L13Ok3QMk9kVVOuBXcIkTDyPC7CEOMKtZG4PiourhMIlb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jtoXYqgN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526GubBP007711
	for <linux-wireless@vger.kernel.org>; Fri, 7 Mar 2025 01:30:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DmyfeEUHJXOQhM1UucPrAUkaXvcmqoU53NzFe4mDRR8=; b=jtoXYqgNh70XYZBh
	kxFa9bKTWA4lNYc8D6ngC6nWoW+ULsycT20RVCEo5qaXYGUATaeGUBFD8gLzyNBX
	xhWoljSAQBUPdIaFclrft5K9wUlFIMQ/wWoptc0jBy31tCHIlk4FwvU0R1/5+l+r
	TE0qbqleQOkOgGHiLPN6Z808H6g9DaH28xBxHqHfjWiXo2XJltiVTPIn7qyOZZz8
	eVLZABdruZmX1m2OqCUSuTcW2XzQ7iSa4SXgra1MOHxcpMJ3GMuKffeNbXHISmJp
	wJvSey05H1W58yrtkya64g64z589vd0yvdUUJ2sKh/0zqsEmNdmIu/AhG2OsPVaX
	bbgQHQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 457fns160b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 07 Mar 2025 01:30:42 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fecd603bb8so2441771a91.3
        for <linux-wireless@vger.kernel.org>; Thu, 06 Mar 2025 17:30:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741311041; x=1741915841;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DmyfeEUHJXOQhM1UucPrAUkaXvcmqoU53NzFe4mDRR8=;
        b=RfcVui3TNYO45qm1m9qco1WWX2SCBmVlLtmaiZCM5WJMLnLksP3BnSV/UjsDKQ2p5r
         zil9Kp6WKuu+OHS97tukqLha1ASt8ZsErzgvX9C4rOrNfMqFB/+6vwo4B01RtVQNa+Ta
         vdBEDSC4nkMDVmJkDRvB7J3iIECrnZVa2rAI02BOaxzpMEM4THFmO1kWN2nCeFwZeVu4
         McEfvgauV0u8a/cfv0w4eT0F3m2DYXP/vCf3otCTNuG93kSRE9W33Ion7UpRbzG+JxkZ
         yVC23YGWEST/oyq9zzP+5J7wuqeGkZPjdhj2mYE/7pU9kZNLYyIuGDbz9mBFB8tXnCJU
         +iZQ==
X-Gm-Message-State: AOJu0YzGWaTizxcTLPyQTs08J1bIq5Igmguio6OReFUnerK8v6fBq+Yl
	8TKRNj5qxPwoXdo4hWdpnnZjbfNsL5OmrFyJRwg/xIpaWFhTufoGVHgxi3lTkxXxM7KCtNgy15G
	lCURpTuL2lyBkfwmx1ZJP4P5qHjRh+dFAd/0VOgF4+XdlK23HCrGrHnS4uBs+9YdE/k2djjBAAQ
	==
X-Gm-Gg: ASbGncuU2qigSOfFrmf/+BAyixcPtVsUuj/yfAoiCqKww0lx2GJAifgsirAj7MFjnCw
	AwFUGXssOxRbBIMl02+PelZNfJqUdURS5pb0HuFUKVSQtIO+Zx1Ct6EtaL3QC4J02W2AcZSr0HQ
	klCcxfrCMbbbTHJEn7T24Mpkp9U38R15579Paj+vaqIPNWj9u82DCxr8p9dyub68Q9Vw6KVY3Xb
	TgOHKlQXJ3ObvXeDdwWoXF2Y3Any4tu0zrCSVq7xBSRekcHWukTRDwez47rN/pldDG6MJufs7JX
	KztT/0RJfaYvw3GBR17cGVrdEZEWgQOm7gAxyhS0lxidixrHuPOuYCcAZLA9jBz6O91J
X-Received: by 2002:a05:6a00:2d90:b0:736:64b7:f104 with SMTP id d2e1a72fcca58-736aa9c1b0fmr2099404b3a.5.1741311041018;
        Thu, 06 Mar 2025 17:30:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLQjP+oYpzYP7ypCxOEUzdTZ4BT0mxZxGT7r2Ymt+Nl1rZUoSeaq2b1fN4JowsUODcXcq7tg==
X-Received: by 2002:a05:6a00:2d90:b0:736:64b7:f104 with SMTP id d2e1a72fcca58-736aa9c1b0fmr2099372b3a.5.1741311040610;
        Thu, 06 Mar 2025 17:30:40 -0800 (PST)
Received: from [10.227.106.66] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73698243ef6sm2113668b3a.61.2025.03.06.17.30.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 17:30:40 -0800 (PST)
Message-ID: <313b689d-8c68-4ad6-a50b-6dcd333c8b95@oss.qualcomm.com>
Date: Thu, 6 Mar 2025 17:30:39 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [wireless-next v2 0/2] wifi: mac80211: MLO handling for Dynamic
 VLAN
Content-Language: en-GB
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
References: <20250307003740.1329351-1-muna.sinada@oss.qualcomm.com>
From: Muna Sinada <muna.sinada@oss.qualcomm.com>
In-Reply-To: <20250307003740.1329351-1-muna.sinada@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=cccormDM c=1 sm=1 tr=0 ts=67ca4c42 cx=c_pps a=0uOsjrqzRL749jD1oC5vDA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=xrvUI6P9ODEOjF-5BWgA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: E4UPhtZBl9A4wia8rv7iemfIztbuHjsm
X-Proofpoint-GUID: E4UPhtZBl9A4wia8rv7iemfIztbuHjsm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_01,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 suspectscore=0 adultscore=0 mlxlogscore=771 bulkscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503070008



On 3/6/2025 4:37 PM, Muna Sinada wrote:
> Currently for AP_VLAN interfaces that are a part of a MLD master AP,
> links are not created for the interface. Additionally, mac80211
> handles duplicating multicast traffic on each link when a driver/hw
> is not handling such action.
> 
> With the introduction of MLO, there are two areas where additional
> handling is needed to enable Dynamic VLAN traffic: creating separate
> links for AP_VLAN interface and enabling mac80211 to send multicast
> Dynamic VLAN traffic on each link.
> 
> 4addr mode + MLO is not currently supported.
> 
> Muna Sinada (2):
>   wifi: mac80211: Create separate links for VLAN interfaces
>   wifi: mac80211: VLAN traffic in multicast path
> 
>  net/mac80211/chan.c        |  3 ++
>  net/mac80211/ieee80211_i.h |  3 ++
>  net/mac80211/iface.c       | 22 +++++++++-
>  net/mac80211/link.c        | 90 ++++++++++++++++++++++++++++++++++++--
>  net/mac80211/tx.c          |  6 ++-
>  5 files changed, 116 insertions(+), 8 deletions(-)
> 

Please ignore this patchset. New rebased version coming soon.

Muna

