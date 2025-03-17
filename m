Return-Path: <linux-wireless+bounces-20456-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 892C8A65B8B
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 18:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA5F117D61A
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 17:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267E11AF0C1;
	Mon, 17 Mar 2025 17:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="buuBIghO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A627E1B042E
	for <linux-wireless@vger.kernel.org>; Mon, 17 Mar 2025 17:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233959; cv=none; b=FBsu8ljLABuMn5sI5ptdjnbwZVF5d978nUbGze2zDh9t/W2k/0qtaFUWBJyqBQ9Mn94ZY3wmEnp1XLllg66MsOnCcKMsSnDwUG6pfi4lgtY8pIv32/zDRgP/Vlt7U/bAgneNvG0Q+NBIKPBZOmHeyL1rUf9xO8SQce752da1uqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233959; c=relaxed/simple;
	bh=kAof8Xa6t3ym8zKg7Wl6V3uRDF/rKinICf3otCDW1CE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rJnJN2EP2h94xq3kivgfBs5DAWHEbd9n4z5MrzEbc9Al24pVDorl7UJR2JgxIvvh6e9QubwimA1rS6n5UO3Mrmrnu9bJSkUTzjuxo0y6w7DhIlI8Egb/Gv4T/L/1KV1PHLL9Td7ck5NZvGTLp4jUifB+V2hmXIKwBODH0P4HkFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=buuBIghO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52HAUAgx011631
	for <linux-wireless@vger.kernel.org>; Mon, 17 Mar 2025 17:52:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bzs4HkHDebsqHMWUpcz0rQUHNmYl05+pZZwdg/tX83U=; b=buuBIghOja7w0aEd
	QynJrgCOXt0eicpdjrRD4m3b5moAMBpJtQejDHxTfVwk/ZwSOovxsZAfd5BXGNn2
	qdw2DNGRznFHCWnbWr897Qh0lZj5lQUtN4NEG/U/PwsX/eBVkEADye67ReVJjAFp
	eBT5VWcQOOm0Rr2ovggTvlJGzYUfzC0U2FE5XZ+gB3+hJlhon5mCniWdWLAVwXsG
	kdmxeSf+pP7cLb7jPHqTZoSJ9SyDjb7GVJ1S0hb+3gtLbFQibVgHxBpAF7VOc91y
	Vg8Oa4s/j0nK9hP3vKA1v5FaKPcTwdWVrNLwxE4kzCq2VsDIpEaxxSivcjYmp/Nv
	aYPGGg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1s3wkk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 17 Mar 2025 17:52:36 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-22403329f9eso72294055ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 17 Mar 2025 10:52:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742233943; x=1742838743;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzs4HkHDebsqHMWUpcz0rQUHNmYl05+pZZwdg/tX83U=;
        b=EUYvC80O8BruNT6AMMtXXOIfhOrs3Gkcno6NmaQIbx8u6WLa05aXBkrYiJ6df0jA0h
         fW+uhb65Ca6pyuuebM+zOEs/29Fsl1NBmErsRY5FfhIDrFQb2lfpzbmcdqZ7rnoFv1yf
         tBiFulSoh5/+SE6Aa4t2DwKyvgOPnVu38sKKTVSaDi2UfShMo3r7Qlj19k+SA7Npmtl3
         JiqOSpChfSQenPTUndu4CBNQUafXN/t3/QpKlcnhToLy5Oip+6JoMfRq1CdpYh51h9a1
         fvtBDBrHQ/vcPC51tCKwHraHR1h61jegeT0VVEz8XltUqaZRVUkhxomauMKCgvlYiLTs
         j4KA==
X-Gm-Message-State: AOJu0YzlnTVCCMuiT/iJnMmf0M7VugyETt5VadzZuHg1SgXglUUR3Oyr
	nCs/iQKFfl2H5A0eFt9Ix4g1H4J4/GkYbqEH8SKghQ5tl5pC8a56uj1KFxFwxsh0828IZazxh8n
	VmURu2YqohVLDHlLSsexsx5zWmK/lpFX36cPGKRPONaXYy7etLsqAP+Ad3jM9CHj1IA==
X-Gm-Gg: ASbGncsnx8eWb/D4GBnSAP1ZLk9hHdC1u5jSup46uHycU2/MVzvhVtFLrwD3tW35NIB
	JSEVGZsrQYpgFprlZOW8qeCnqzsgJ5qtuLSyafYZAuzl9NAP2dXoNQ1ZBuJHi0r3/WWx6Buj9W6
	ECsXFM5DLEYwl9b7iu5dm1oK3k3Fc1czv7sHfRHTPdHq7DENQJKEtp9jCE7gGnWfXecCriYZiPy
	o9dcqkSfGtqfpf+MJY9KoHEHI3BMRWCSfnBISxbb+FB1YqFwV1kxUTuFy2MYk2FRY+3S6VNFta5
	dHbjzPz5dJZfYbnPjhbOIsqg8FSEAqhhZcnHjTvcRcvKedmkbDxB
X-Received: by 2002:a17:902:cf0a:b0:220:e63c:5aff with SMTP id d9443c01a7336-225e0b119a2mr144224315ad.47.1742233943215;
        Mon, 17 Mar 2025 10:52:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLE9fpU3abqToMjpuz/msFYDLAmRBNr3lCiERmeH83aOffmIzWtQW9uD8stNDYwG44wRCqwA==
X-Received: by 2002:a17:902:cf0a:b0:220:e63c:5aff with SMTP id d9443c01a7336-225e0b119a2mr144224065ad.47.1742233942796;
        Mon, 17 Mar 2025 10:52:22 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd5ce5sm78291485ad.252.2025.03.17.10.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 10:52:22 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Suraj P Kizhakkethil <quic_surapk@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250304095315.3050325-1-quic_surapk@quicinc.com>
References: <20250304095315.3050325-1-quic_surapk@quicinc.com>
Subject: Re: [PATCH v2 0/2] wifi: ath12k: Pass correct channel frequency
 parameters
Message-Id: <174223394217.578193.5332056743902918287.b4-ty@oss.qualcomm.com>
Date: Mon, 17 Mar 2025 10:52:22 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Authority-Analysis: v=2.4 cv=WbQMa1hX c=1 sm=1 tr=0 ts=67d86164 cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=JAv06hZFyUe5PBVjgVcA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: YOzxh-T1YIB8X0qq_3kcF0Iv4AL4zzlq
X-Proofpoint-ORIG-GUID: YOzxh-T1YIB8X0qq_3kcF0Iv4AL4zzlq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_07,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=932 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503170129


On Tue, 04 Mar 2025 15:23:13 +0530, Suraj P Kizhakkethil wrote:
> For higher bandwidths, the channel frequency parameters passed to
> the firmware are incorrect. Pass correct values of channel
> frequency parameters.
> 
> v2:
>  - Replaced arg->band_center_freq1 to local variable center_freq1,
>    which is initialized to arg->band_center_freq1
>  - Rebased on ToT
> 
> [...]

Applied, thanks!

[1/2] wifi: ath12k: Pass correct values of center freq1 and center freq2 for 160 MHz
      commit: b1b01e46a3db5ad44d1e4691ba37c1e0832cd5cf
[2/2] wifi: ath12k: Pass correct values of center freq1 and center freq2 for 320 MHz
      commit: 5e44b181bec8e2fe3826033360fc1a42bb432191

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


