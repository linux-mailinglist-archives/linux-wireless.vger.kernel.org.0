Return-Path: <linux-wireless+bounces-23544-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF6FACC356
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 11:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25B091884FC8
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 09:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F84F281530;
	Tue,  3 Jun 2025 09:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q1swABAK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621AE2820B5
	for <linux-wireless@vger.kernel.org>; Tue,  3 Jun 2025 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748943684; cv=none; b=WTfYXTuDsPazHtOmO5onWQBNPHTxl1Bhv2oY7ogQ5FKENz8Wpyne7/wOeu6ieY/LYbK8FNEHXN5+IgVyWw4qopVizl7lMuiGYTkkh400JJEsWUqpDkvDaDB+jo0PfJyHzQleAWrYEvOLtSa4AXQHXqXr84ytCLYWYX829N6Iz5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748943684; c=relaxed/simple;
	bh=a2U4FmurpsjLDQRzuqVxLuBHAisBaXSQsZ12Hk8wsqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EiP317zwcZNb8naeU8vKKqm3IhZrJAyV3fJgrwKB+kJPdfEHNvt6ANXYceWoUnuh5e2isLnnQQ1dSk0qtcB7ON1yNKa9B7JJIh/8NN1JqdRbK8y7LjxGBHEjiX1xw2XWIa3tsgkipnddrLg1Aer4zqAPsDVeF7pa0r+cfJYU0bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q1swABAK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5539JK8q032470
	for <linux-wireless@vger.kernel.org>; Tue, 3 Jun 2025 09:41:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rZgFxUUH1qzOZLDH/W0RuvDMG333L7//fcnO2XCla+8=; b=Q1swABAK/2ZNP0Q8
	/nuDkvmVfVLlVLWps8geL7fOvX/MENbAixSJPB7igYd22p4juByHEgeVwf5V99fA
	9oHqUNM6ACNrXQn5KRIHMgVYcL4QGhyqbUTQVc5OBgPOSy4XuN7BmmIovg7q8FGg
	t7IVMjSy51dEEbpXN1zmCB/yMH8zx4GEv9X8ypJ6dixIaueX7TmxVWZxr4iSrk1M
	OBpEG6TqM70dhEsKUgdFRO8HlhA/4l+CvndBiwBdQQbTrIFXf+gPPpBEWD5eX8sJ
	33ixZOBR6uF+vVOLxXCO/JSA1RZEIDX7QDnpMDt3ba6EmCvJoKr8IL4agllJsoMs
	gsYKFA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471sfurw63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 03 Jun 2025 09:41:20 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-742a969a4d0so4733649b3a.2
        for <linux-wireless@vger.kernel.org>; Tue, 03 Jun 2025 02:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748943680; x=1749548480;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rZgFxUUH1qzOZLDH/W0RuvDMG333L7//fcnO2XCla+8=;
        b=KJdAFOqUDk54MDq4nAZ3u1Mcr640WguXO+z56UJwtsymLlsvsZoPnLw9zToT5E/cZ1
         tGa9GacVhl8clYUPdAHZQyoQq01rGcB776ACZGcKoyPM81whCM3u6jnHaRvpFQ7iIqHl
         yyk2aGAM3+kgqvKb/CDA9DqknFv6mnrTkfy2hS4iCfHDCLtI6srNulxPxFlNRL3aX907
         oQmrhpAdLeRf7o+/T0pZxsDXLcheSmwWE5BFyEGZdW8QYmatCJrh8k0KqOsjvjouKjtA
         MqwVN8zVTMCR65yrGd5SU/p3NQAWY7COXP4HAVk0hsjE1nj4Vz64qvao4Xwc6kd07Sum
         kDfg==
X-Gm-Message-State: AOJu0YxM9/JRdcIrRL76h+NJVn+kn+iBpBjqjHB2HloYZ2zjmTlNFhRG
	V5Hxye4mIH10wm/VUGWuGwcZqJw0uN55t+7vW1eBLSkx+GARlpAb4B8tTLDsPastrAlcEYi2SPK
	FRmCgDXgr18VT9Cj2ySlcJbtf9AgeBLXWEYJXLDklL/qpPU44i+KU5l2AyahhCJQZ0sOd1A==
X-Gm-Gg: ASbGncstX46dmlfOFSIlecnocKtZjI5cQC6rbRcxUpciyKxpkjEtIcUKDpBl38BhvUw
	sE7jaXIPPRxHa/KT587M8XskMRs/7Ah3VRHvgqj6QdwMLZCOALWWaWA4gy6oXCcm3v9BY8LPGMc
	eCFrk+Gv9SdvGpm9k4YZXL3zyKv63gt+jGgeFW/OXbD1j4ZIZ4FRoWOIfPHVbSS3IEKGlTbHRtc
	YDAduneEJbwy86giWVZO1Vifwj7gdTX1zaD8spO7PynkVgYbzH5jGHdzI/7qAa4lxg2phJXVqqX
	JXJMYP99dsfZKPPbGC+l7JoCOAVBRkHKR8bkSuQ/DlQOskmqQvWekw==
X-Received: by 2002:a05:6a00:218c:b0:742:a02e:dd8d with SMTP id d2e1a72fcca58-747d1ab07b7mr16015863b3a.20.1748943679688;
        Tue, 03 Jun 2025 02:41:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtJm0q9o9BMa2e0j0DqdXOZ+URVaEthN/FLWSl6c+aw1P36W3g4vD7j6XelFjFJRDKdtp/MQ==
X-Received: by 2002:a05:6a00:218c:b0:742:a02e:dd8d with SMTP id d2e1a72fcca58-747d1ab07b7mr16015833b3a.20.1748943679234;
        Tue, 03 Jun 2025 02:41:19 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2ecebb3efesm6767985a12.68.2025.06.03.02.41.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 02:41:18 -0700 (PDT)
Message-ID: <81a19e4f-525b-17d6-86e1-774d3132e610@oss.qualcomm.com>
Date: Tue, 3 Jun 2025 15:11:15 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next 0/6] wifi: ath12k: handle link select and
 inactivate
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250522-ath12k-sbs-dbs-v1-0-54a29e7a3a88@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250522-ath12k-sbs-dbs-v1-0-54a29e7a3a88@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=CY8I5Krl c=1 sm=1 tr=0 ts=683ec340 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=rSFznLUdu7_CRTz4a9oA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: FjsGXwXF7AhvSlPvhMGuKOHO7AlcAMRI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDA4NCBTYWx0ZWRfX1sh8GVZ2gW0V
 jgsGRoYaUHcxxUyeVvV51oNwSrR4lSfh0j2sXGONRMz5NtJtQPhZtOhIcZSd9Rgqc5xeuZujEp3
 c8v7T0XbaSdzfuHxLcmB6dn9yCGScRltk3DVDQsOjGTq6tIdwFpi2MRrdU4QshWfwdvOnGb6UKN
 3Acxljyd4T9cE76kVjSsbnKtZl3Q1ThrYBXRa5KNNyLUkSHowVp2Mx1MHMXssuBqRdDngNeiGMm
 BUC+l3HNJVxOlUfMCNx0OFOvXaa5JQuIpDuGhWEmIPyPQ57yb8ppDcAsEahlekviMT6dIOsimXB
 PMrTr2iLY2oII1a7vaOcs1T1CQlH01/HK0CZVHpE90nzEfX6/QHWYYiuwWY9q9QPRS+PIstGm+v
 w3IRyWaE7MmsGiblLJem08zl31tPruxXO/I9T0bfv3s+OzhyLo11x5/H5KaJvA/rxGIbpfS2
X-Proofpoint-GUID: FjsGXwXF7AhvSlPvhMGuKOHO7AlcAMRI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 impostorscore=0
 phishscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506030084



On 5/22/2025 2:24 PM, Baochen Qiang wrote:
> Currently host activate all useful links:
> 
> 	ieee80211_set_active_links(vif, ieee80211_vif_usable_links(vif))
> 
> this leads to 2 issues:
> 
> 1#: If 2 links are created/activated on the same device, and both channels
> used by them fall on the same hardware MAC, throughput would be lower
> compared with even one link due to MAC switching between them.
> 
> 2#: If there are more than 2 useful links, WCN7850 firmware crashes when
> host tries to bringup the 3rd link, because firmware supports at most 2
> links for a ML connection.
> 
> To address the first issue, host needs to send
> WMI_MLO_LINK_SET_ACTIVE_CMDID command to firmware such that firmware can
> deactivate one of the links. This is done in patches 4 and 5.
> 
> To address the second issue, host needs to make decision to select 2
> links out of the useful links to activate. This is done in patch 6.
> 
> The link select and inactivate are both based on the knowledge of hardware
> modes, which are advertised by firmware in WMI_SERVICE_READY_EXT_EVENTID
> and WMI_SERVICE_READY_EXT2_EVENTID events. Such preparation work is done
> in the first three patches.
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> ---
> Baochen Qiang (6):
>        wifi: ath12k: parse and save hardware mode info from WMI_SERVICE_READY_EXT_EVENTID event for later use
>        wifi: ath12k: parse and save sbs_lower_band_end_freq from WMI_SERVICE_READY_EXT2_EVENTID event
>        wifi: ath12k: update freq range for each hardware mode
>        wifi: ath12k: support WMI_MLO_LINK_SET_ACTIVE_CMDID command
>        wifi: ath12k: update link active in case two links fall on the same MAC
>        wifi: ath12k: don't activate more links than firmware supports
> 
>   drivers/net/wireless/ath/ath12k/core.h |   6 +
>   drivers/net/wireless/ath/ath12k/mac.c  | 364 +++++++++++++++-
>   drivers/net/wireless/ath/ath12k/mac.h  |   2 +
>   drivers/net/wireless/ath/ath12k/wmi.c  | 759 ++++++++++++++++++++++++++++++++-
>   drivers/net/wireless/ath/ath12k/wmi.h  | 180 +++++++-
>   5 files changed, 1305 insertions(+), 6 deletions(-)

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

