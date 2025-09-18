Return-Path: <linux-wireless+bounces-27488-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 399CEB860B9
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 18:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05B9B16EC1B
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 16:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449DF314D29;
	Thu, 18 Sep 2025 16:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ES7HGXdQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F6928643D
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 16:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758213084; cv=none; b=l6HGOdqNvODGkQNaDKIjs/pe4I8DEjCX7wOy6e7KgNTdx//Q5uu8NapXzmVem7EvqWi3Jf7P5S4FEgDHFm4yQCAxmbRzNk3CA8F85Z1txfSpEbTE55xbVxRAnl/era7mZ8KS6g7LbGuTXG37aAi4mb0LfyjeNlLlSX6zdE+t2/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758213084; c=relaxed/simple;
	bh=qCwN4UWf/qO87rnIbDuNnYXQZL556aOSgTuDK2FYCBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BioM545p1SEdpHofEkZyVbu2HpLJIaYAHkj6h5l2ykXsz+403BzdgubMZ47E/MTUFBHznYc1Rz919MepgJ9CdKfZZlMPGGMaRmF0KDWE05kGmFDaF0Aa/s4blG52T/jMmKY2jPmHgQFP4fHqql346DJrfNtK130heAW42Ogv5xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ES7HGXdQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IBSiuW029741
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 16:31:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qCwN4UWf/qO87rnIbDuNnYXQZL556aOSgTuDK2FYCBc=; b=ES7HGXdQdiFxaJtg
	k2xDRMr62o8gqivC38tQpTwBe+ZOt1P2zvyqNsevxfkNhaIBpH4oc2G2/boJue72
	ijz11mbcgLUV+vnu22JUSDW0U2RbLYxVuu1aZm3sLJivpHUSz4t/ARsCpSUjIrN1
	DRqSzYpInBkK3E0aLzlcENMpSNE70PBX0tdVbFH2Gqq6fv4qzRw79kZ+c6I6BA1K
	7pDsUxQEMt90/FdLXUTxhcerWuyvAfd1dJv5fqMIZZqgD6hrFwi07SxJ/nZiKnuF
	M+4LSnv59bV5dlVuf15ToLzlfhcCmUiHWB30F+EnwZV7SpGW4l7yrE+S6s5CoGOb
	jpveqg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fy0y46e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 16:31:21 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32e0b001505so1149478a91.0
        for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 09:31:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758213081; x=1758817881;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qCwN4UWf/qO87rnIbDuNnYXQZL556aOSgTuDK2FYCBc=;
        b=L4ur9sqZDbbHHX1ujtRSuKkubvzcwC/NEwY7IYp0g1BYYx5zopdfm9Iq0e4lIGPz4Z
         tLgUXvKzs1pm5XreIw1N/9OrpA6+elZXbmjjJmgBsZn04iYCCFtW/YnaG/t1o4Kz0tJt
         ZhgJoGoU97wLFaFXXAkzXngNgF9gE6WuDIrywuDHm1JlvjoNiBv86Z7rAfvUtQrKc50i
         dVXljocvTxX1g4eXcUvdDAQiWFCIX/fPXC4AiUf7vb+2YTCwR0MXAyI1GI5Kc4jevDNy
         6O8lM+w0Fezt6sradGsub/Mo3+nAyEX6alW5nj4x5Ra2GwuZfmNExnrI+CH9gHWeRNxk
         GrXg==
X-Gm-Message-State: AOJu0Yw98M7772Z6BiUIut8jo5k5/mdPMaIRSLrvjPV0k0NbihilQ4R2
	GEI9m8uDeMWsWBCAUzMvClduHsjjWQI77uZMNVxr94i+5fcRVJ83yVDjD7dplPthXnrax8JHtBH
	ENCy+g+qLUrJoz7gdO4VBup/Gg1KPPgojFmSaGE6w3Ez0N2YFM1AuuTQWeCy/8znEnEmj7g==
X-Gm-Gg: ASbGnctKWZDKJA9aqVB+FaJ42CbfA0aYWgubmJlAfbd9080R/o0Nk/S3ozXFZv5OnGy
	yrnY2y7K/KZ+91n6lF1yPcIpUMz07T61phAsx6DLYF/zVmsWB8EOiudDdnTdeocjlvSCJASL6+D
	Zr1MDgbcCjSLa+H2ITaVkK0GbfCHsnr2cBmVF2A97y201XiJL6B0eQcuBllioyNSsAaMkI0EFc3
	50jWrRoYucpFcxvk9h6UyTKVyvU7+NXFCQ0Yi/Ddd8VCO/0tWhC7xFzdu+Rr6MWKeTDiDNiBUbc
	YfGyn0O0pl5C36WLye221vs5oxjetRRoNaSkdc2HmjtzXJ3hZFydbXR8ZBHAvkt8TDZYJZuOPAK
	3cM6j1VK/+EfW3y1E8YXPxD1x
X-Received: by 2002:a17:90b:1f84:b0:32e:64ca:e84e with SMTP id 98e67ed59e1d1-32ee3ef7071mr9571432a91.15.1758213080967;
        Thu, 18 Sep 2025 09:31:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5Bzu9IzjWAIb1ykdrkuMpLZlLBm0S0xGZhC2cExjcG46jsKIRUC4NyJocWI+6wpsHTHQ7Yg==
X-Received: by 2002:a17:90b:1f84:b0:32e:64ca:e84e with SMTP id 98e67ed59e1d1-32ee3ef7071mr9571379a91.15.1758213080410;
        Thu, 18 Sep 2025 09:31:20 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff447060sm2685889a12.53.2025.09.18.09.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 09:31:19 -0700 (PDT)
Message-ID: <e8d283aa-fb73-45d6-a89a-54ff31f205c8@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 09:31:18 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] wifi: ath12k: enforce CPU-endian format for all
 QMI
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20250918085406.2049559-1-alexander.wilhelm@westermo.com>
 <20250918085406.2049559-5-alexander.wilhelm@westermo.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250918085406.2049559-5-alexander.wilhelm@westermo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: RBoA4ZajBYC_eRb07YF7M5KFrWg8PofC
X-Authority-Analysis: v=2.4 cv=btZMBFai c=1 sm=1 tr=0 ts=68cc33d9 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=msdzb5vn4zVyWyR8mUoA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: RBoA4ZajBYC_eRb07YF7M5KFrWg8PofC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX+xeiLOWZk+gr
 JWxu63NQ3GXIIkjcKtWUDxW109a5SQyCPiKTlHzUP/v4qxyiM+wrfakBEhUFMjKXEbRXZnd2S9V
 3AVAQKEna944bnUae5GBxjSRirevOP7z60O+MoSMk6xpb7UdXxa9i8G9VnXTGkGUmfcYeHVqx+I
 1zJsmM9BHOp5cehL9cIi3t4hT/8qbCH6NjBeM8h5ivZ4NlJTVemqMyu7mRw2RVlZsiMPL86upJ/
 kq9Ptv4iJs36qpxz7t4Wpo0v2LE2/cVgkSOfYKhtFjWRgk5dtuV9UCktlS0NKvaGVDix8JSmsM9
 7PtBGQtt/GlmIF4bUQ3ZicLp3YFyiVFJNmj/4SWp4wAJkMFbLt66at2FFEe/Z18CoOcwz+f1Tav
 kuzXItgG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202

On 9/18/2025 1:53 AM, Alexander Wilhelm wrote:
> Due to internal endianness handling within the QMI subsystem, all QMI
> requests and responses must now be provided in CPU byte order. Replace all
> QMI-related data types with CPU-endian types and add the necessary
> conversions to ensure correct interpretation across architectures.

I think you can break this out into a separate patch, but reword in a manner
that doesn't indicate any dependency upon your series (it can be a predecessor)

You can do that by noting:
1) currently (before your series) the QMI interface only works on LE systems
because of how it encodes and decodes the data
2) however almost all QMI data structures did NOT use endianess-specific types
for the data structures
3) the ath12k structs being modified are exceptions
4) the QMI interfaces are being modified to support BE, and that modification
requires the QMI data structures to actually be in CPU order
5) So change the two ath12k QMI struct which currently use endianess-specific
types
6) This change will work correctly with existing kernels (which only support
LE) and will also work on future kernels where BE support is added.

Then I can take this patch separately from the QMI changes.

/jeff


