Return-Path: <linux-wireless+bounces-27465-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCF7B833A9
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 08:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 982B9625D76
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 06:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69FB2DECA3;
	Thu, 18 Sep 2025 06:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="idYCm4t0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6D22DE6EE
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 06:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758178643; cv=none; b=MsA3v3LWjhR/FEvHVepSgRltije4dL6RrcG6nf6MtN/ZkoWTt/kw66I2QGrGwNni7PHP+pKDaGV4hoDjCEFIl3U0SRmiCHsiuMTfqwWRiDOVDIiwN/AE+f9uw/P7dDpTmsNVq0HN3WWZSR7xpGiez3pb0YVDdmbz3fI1xNGi0iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758178643; c=relaxed/simple;
	bh=3jcyUudN9w/dANiUt7a84TD4s/YyFm6IsN+T/R9wT0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ld/gqFDhGol5FrcL0Y1n83OYy16PF/QyQHlJnRZB1M1w1K5hphwHWllpK+f2qI4sgvjwOTF7o+vAS/dCNd7W1VJSeaiTJRautcR1VgLEqCGR7m3caCG4A5rFoSl1wo37z0ght6L0cCDDRVQglHzg7JXitYpo9V1PRR6ukM/Zm/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=idYCm4t0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I33KmI026798
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 06:57:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kP7bfGFdU/7o7BOcVSMb+JUezO30+s+j/x36Ohrw/po=; b=idYCm4t0dtfo1mNf
	B2Ols5/GhVrplFSi7idhch8X0MeJX9GJv32dde2Vo//5J9SR5HBV3nmAOIG4zioJ
	EAFpy5d1p0q+e6RZ1VdSzdfmWbmsaSXdeJ7eYOIoLKwYZFardky8jEsMkTr7X9Sk
	OURmuhvqcajlpHAQpec1C8aE98oBkVYFXf7C0PlYAjYooZ1HxHWViDX5Du/MOe/3
	+NQ+ic0AVwoLtoZR6b6pVqc2LPM60LLLD8gX6SaqSbgaImJQfL+PpNLKxthAgCgA
	4h44ZnSwGhANADnb9Qe0VmBMsALL4Gn5Z+EH8goW0S16w15y5qRkBNerYr6uQiKR
	z0ENmA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxt5a9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 06:57:20 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32e09eaf85dso747084a91.1
        for <linux-wireless@vger.kernel.org>; Wed, 17 Sep 2025 23:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758178640; x=1758783440;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kP7bfGFdU/7o7BOcVSMb+JUezO30+s+j/x36Ohrw/po=;
        b=QWkfV6qKEFMn7uA8IAm/WqxoaG3nGsw3vnBqCogWhH59tZIVaWmFZaiTG6Rw4SxxeI
         2U5aAaip/ZGDYx86loti9BgPrTxbVGapuExp0coj63SjeXcxWwH0W43GzpWXUIq/D/lB
         TbVD4bNt71r8LxO51sN6lZrwxBf/ddI3erQ7DpFOfly41wJRy0d0nDgajZDoyxmwODtO
         3p1mHJaLiN5j5C5qCwj6jco2XzQa63ruM06g4YhN5HN+8c2H5vrppEftbuYw28r7Ium5
         SajKERiDknDn3iSSdCr42xQnjYXgWfnDkXHNbR8IdhLgdJl6V4DZGdXRz+WNkaDbQ0jI
         a/iw==
X-Gm-Message-State: AOJu0YyDoWr7ncb6LtfQ/PgIxrp2KRXr3+GDNpM/bsuR/QnNFcFI0qoi
	cKaFRcjGU4jLt3JzVTRQiofZ1qx+z+gEnb/0+KdG+4JfRx9h8zY+MwJJiiu4GXpkh6Py95h4Hn/
	tvlTOFXK20Bnli32yrYudQD+kpkDaxDN52EDRA8DjV1pMKexoLEOB/Gzb40S5IrocalhEsenjte
	sxqQ==
X-Gm-Gg: ASbGncvUPTgVC/o9Rq9f4uC4uLh84ieDpI0ni4kiSnxQ7kpeXhQye8b7TIlSwV7IRDc
	vnfhFtgmuqGK8SlaA7/PrgO82LsSWsMb8GezKr8PyGF+uzXVVzQLpXyfyzVXW+roq5eucyyCCg1
	W2JyxSHIu5ZLovjCf2yxZFX4SfVSUeOYLT7PKFoXobSofAUU456LUO2Zlrkqxmu4lyU86Afe98c
	rV72yHh1lwQSfHGs4LRfgBkHfi3kYWfdESO/VPFqmNX6NVTFFZ55/SMUy6ClfPMLJprvDbAv1gB
	kvdvuvMIUnTP/K8MNC2ASc6Qq047ligZyrl/GvXJv2k2blZ9O8eYDSXAfOY2shHx5/lijrGi682
	guGTlTQ==
X-Received: by 2002:a17:903:19d0:b0:267:9a29:7800 with SMTP id d9443c01a7336-26813f1d000mr61188765ad.59.1758178639560;
        Wed, 17 Sep 2025 23:57:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEu+tO6Q57GSmftk1FgfAyqaDBz+rsymYzavH7+yrOI3zPLb0aE7EqBJflDWcrWlzsqxeR8vg==
X-Received: by 2002:a17:903:19d0:b0:267:9a29:7800 with SMTP id d9443c01a7336-26813f1d000mr61188465ad.59.1758178639021;
        Wed, 17 Sep 2025 23:57:19 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698030ee20sm15625335ad.109.2025.09.17.23.57.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 23:57:18 -0700 (PDT)
Message-ID: <7bb9c17f-34a9-2602-8bb5-d0d5f12f47d2@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 12:27:16 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next 0/3] wifi: ath12k: Add support to handle
 inactivity STA kickout event
Content-Language: en-US
To: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250812111708.3686-1-maharaja.kennadyrajan@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250812111708.3686-1-maharaja.kennadyrajan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 3oJAu6pDqaZ2_so00ydUVw0hZf_DSomv
X-Authority-Analysis: v=2.4 cv=bIMWIO+Z c=1 sm=1 tr=0 ts=68cbad50 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=o4nd2XIhPPp7Sg7KCEwA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX/jdV491k88MR
 mOgG3JxUiOUy37J8/PBdkx0QAdKKVItIxndu1SchdEad8LcdoBhMN06caACk55IuiA4Zsak9XdA
 JHEKb7gRHg0KTmINya7yvWaNKdy6Yj3ZfPyqojKOGTdJXYOL5sV5JPZLfBiV4sNy32KepBjOztX
 thdWP4FbFH67qYDV3EDB13K+7SyAOb2HQjdqiyisvZBM4cjNj8uDs45gSoCLQaRN3ISGjmkbTYl
 hu8ytt3F+aYehoip6qMfcSuwiMEGhBJJ5FhyCj3g18jb+sBK2L3BB6FPYDQwf7kdkpe1Dgb52P5
 XGs46fM309+FC4xb0z0asiQMlzmTnZ3/Xpo8xUJ3SsjZHjb5V/THAk93ZjpzisMMpmRri34wZiK
 bK1XpAGG
X-Proofpoint-ORIG-GUID: 3oJAu6pDqaZ2_so00ydUVw0hZf_DSomv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202



On 8/12/2025 4:47 PM, Maharaja Kennadyrajan wrote:
> In this patch series, enhance the WMI_PEER_STA_KICKOUT event by adding
> support for reporting the kickout reason and RSSI value.
> All reason codes are handled by reporting low ACKs, and will be leveraged
> in the future.
> 
> Add support to handle the peer non-AP STA kickout event for the reason
> inactivity.
> 
> Currently, the ath12k_mac_handle_beacon_miss() does not handle MLO non-AP
> STA. Hence, add support to handle the MLO non-AP support.
> 
> Arulanbu Balusamy (1):
>    wifi: ath12k: Add support to handle reason inactivity STA kickout
>      event for QCN9274/IPQ5332
> 
> Maharaja Kennadyrajan (2):
>    wifi: ath12k: enhance the WMI_PEER_STA_KICKOUT event with reasons and
>      RSSI reporting
>    wifi: ath12k: Extend beacon miss handling for MLO non-AP STA
> 
>   drivers/net/wireless/ath/ath12k/mac.c | 24 +++--------
>   drivers/net/wireless/ath/ath12k/mac.h |  3 +-
>   drivers/net/wireless/ath/ath12k/wmi.c | 60 ++++++++++++++++++++-------
>   drivers/net/wireless/ath/ath12k/wmi.h | 15 +++++++
>   4 files changed, 66 insertions(+), 36 deletions(-)

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

