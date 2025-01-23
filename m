Return-Path: <linux-wireless+bounces-17869-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E230A1A9E6
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 20:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F38F188771B
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 19:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A495F146593;
	Thu, 23 Jan 2025 19:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P+Zo3Y3I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88B884A30
	for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 19:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737658945; cv=none; b=ExuqUZ3aSlXHres234TwzOkfd1VJT4syGPMbUgCZ9y2OTIm0pHK0k7ZhB5Qi/c7hEFJKpLhXbE3xefqHNRMzlitYoM0V+ytsONTmAse8TAkLQygTrueT7YGdCaK0kjx4oARTTiu/uiedWwBJoIcwXVOWMRo1c4o2aLDWtLvqRa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737658945; c=relaxed/simple;
	bh=YI+f4QR+l6rjeIvT27vqZI6jn1a28NDEveWspZ0z834=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S6ipTIwRYo1Z0WgeyXam+vsAjDToVZ8y8znsSMvomOkzzts8DmLmby1JPZCCjpoaVHxe/2UwKwVA7LNTTTj5XdABBoX2ssleeyMDa3Jcea7X7CljvO/lz0F58ZqWaoNHek0pbRZVol8IPqQl/hSdonXs0rKRNpFphoVgRkmFTw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P+Zo3Y3I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NDsqZV032535
	for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 19:02:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rp+WoVb4Ir2FS5YckET275G6b9qljQCT2IocqP9kwdc=; b=P+Zo3Y3Ismdxxl5a
	wba/RuENpw0bCuKVYsQ3flfi0SClsBTBA1kW+hdQzQzHMz8jnMX7v5AtmcbXSE9L
	YcXNaFxNGZo3uAapPpfo9NJ8501AdH7eKmRAurQ9yBV49goO0qVERFnEGslKlZnG
	IDV7iARKx8RPQlC5/DaM/2XvhhMZOZXVhGdBUmz9i7HqwZa3yBWM0/8/OG9ED3y4
	SRtUlRWPZwSiEabSpK6BWBZ9bCc5G4D+6RfnARAmYNe1JWh5Ag4xK/fg+wboFplH
	Nkbj+DEx9ZcHhZpgUlpD09EKE/Z+G80QEzMGWaun9UIudIOC8jRd0kXwUCsVnc0u
	0Wg25A==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44bq2crqdq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 19:02:22 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-218ad674181so49281355ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 11:02:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737658941; x=1738263741;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rp+WoVb4Ir2FS5YckET275G6b9qljQCT2IocqP9kwdc=;
        b=a+JWAmlSlxVOox1NGkq+ftu+DvgMt6CCnizqEGoI7XUvJZuTs0qQp1Zo5SWMqVj9L0
         zWEYzCE02NhL6b2dnRvWj9fmwl68gGGlsBNRtSOQkaNEuTLSRFXcHMIyn8s9z5fGV/La
         ZGzmOr0XnLtdxO8crtXHhR1tbcyvXKL3Rea6UY8eHXwakTd8x64qzhz5dWVo8nEUvupA
         CAAokMnG2qPUklZUv38roDMeUW+t3mcg5RvFzY4h7NdBDvHsiknW66fL3mtJ09e2B3Hd
         JZGNo0JtT5AqBGC4FC768COgBQQsjKN5PK8k92TajoPLHK5xhYZAn3PKHs0fsI6NtZ/G
         EGoA==
X-Gm-Message-State: AOJu0Yw7IfQqE99kXmDIHlMCM934ru5EZLXWsz3BbbdEjAZXsY8bQpDM
	a+t68F24KQWt6H7ZVG/2JTLa6xNMv3R1e8VxnXG+q67GIMleFNT3xBu0pjsnTErH7beQ9MiiXDF
	Jf9NBePU4iG2fXIsG4tzcqVIOwmOqo0sjWdZLNJBdCf3Lm4uNm7eF9nsWBzsmgxWrp+K+reCVbA
	==
X-Gm-Gg: ASbGnctK3tHHlMUiwzy2ua2xDw02x5FKoSyaI7K9uUMQPBNbCBLuHXMvxJgFLh4/WXo
	MrixNd5gPoVoj+Ycx49sthrrbsqvKjtpfE7tVCOpp1/JGipWp0oo5LXkgjolTNoaSqXQEllAWLG
	pKb+ywXm+Idf/AQiOMINc01WNWqjWu9q+JgJ51VSCdZ30mSIapcLLzcf07eOwTQRQ8c/BSeMEfV
	WbO+psWXdYm97HyJWwa4TW0OomolT9OPUO3kgtAZhhSIlX1TW5FmPLAT8AVshq+osPhECAHGUP5
	cSBKJgj/zY0wjkOgjEKHlvakBMmLVv0k/9+Kaah9Gi89pChkQ8Pqi6W0wh40tJY=
X-Received: by 2002:a05:6a20:7492:b0:1e0:c166:18ba with SMTP id adf61e73a8af0-1eb69731123mr6251859637.12.1737658941509;
        Thu, 23 Jan 2025 11:02:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFsxRN1zIKOddGbZZ3gkr0+K9prBCVrNuMXjlsd75VaNlfXAy9k4RP0v2eUsb7d6SR3hhwrg==
X-Received: by 2002:a05:6a20:7492:b0:1e0:c166:18ba with SMTP id adf61e73a8af0-1eb69731123mr6251816637.12.1737658941020;
        Thu, 23 Jan 2025 11:02:21 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a6b31besm295407b3a.54.2025.01.23.11.02.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 11:02:20 -0800 (PST)
Message-ID: <a889082f-67eb-45d1-bef9-dc6b9486ff29@oss.qualcomm.com>
Date: Thu, 23 Jan 2025 11:02:19 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Add support for link specific datapath
 stats
To: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250110205912.2585850-1-quic_bmahalin@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250110205912.2585850-1-quic_bmahalin@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: zyt1BylcpbsH6MpVhiQdseHzGHVqaBAr
X-Proofpoint-ORIG-GUID: zyt1BylcpbsH6MpVhiQdseHzGHVqaBAr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_08,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501230138

On 1/10/2025 12:59 PM, Balamurugan Mahalingam wrote:
> Add support to record the number of frames enqueued, hardware
> descriptor type, encapsulation/encryption types used, frames
> dropped and completed. This is useful for understanding the
> datapath performance and tune the peak throughput.
> 
> The link specific stats can be viewed through the below debugfs file
> 
> cat /sys/kernel/debug/ieee80211/phy0/netdev:wlan1/link_stats
> link[0] Tx Unicast Frames Enqueued  = 9
> link[0] Tx Broadcast Frames Enqueued = 78689
> link[0] Tx Frames Completed = 78698
> link[0] Tx Frames Dropped = 0
> link[0] Tx Frame descriptor Encap Type =  raw:0 native wifi:78698 ethernet:0
> link[0] Tx Frame descriptor Encrypt Type =  0:78698 1:0 2:0 3:0 4:0 5:0 6:0 7:0 8:0 9:0 10:0 11:0
> link[0] Tx Frame descriptor Type = buffer:78698 extension:0
> ------------------------------------------------------
> link[1] Tx Unicast Frames Enqueued  = 0
> link[1] Tx Broadcast Frames Enqueued = 78689
> link[1] Tx Frames Completed = 78689
> link[1] Tx Frames Dropped = 0
> link[1] Tx Frame descriptor Encap Type =  raw:0 native wifi:78689 ethernet:0
> link[1] Tx Frame descriptor Encrypt Type =  0:78689 1:0 2:0 3:0 4:0 5:0 6:0 7:0 8:0 9:0 10:0 11:0
> link[1] Tx Frame descriptor Type = buffer:78689 extension:0
> ------------------------------------------------------
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>
> ---
> 
> Depends-on : 
> [PATCH 0/2] wifi: ath12k: Add support for MLO Multicast Handling
> Link: https://lore.kernel.org/all/20250109184932.1593157-1-quic_bmahalin@quicinc.com/ 

The dependent patch still applies cleanly to ath/main and is now in pending.
However this patch doesn't apply cleanly on top of that, so please rebase.

* Applying 20250110_quic_bmahalin_wifi_ath12k_add_support_for_link_specific_datapath_stats.mbx 
Applying: wifi: ath12k: Add support for link specific datapath stats
Using index info to reconstruct a base tree...
M       drivers/net/wireless/ath/ath12k/core.h
M       drivers/net/wireless/ath/ath12k/dp.h
M       drivers/net/wireless/ath/ath12k/dp_tx.c
M       drivers/net/wireless/ath/ath12k/mac.c
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/wireless/ath/ath12k/mac.c
CONFLICT (content): Merge conflict in drivers/net/wireless/ath/ath12k/mac.c
Auto-merging drivers/net/wireless/ath/ath12k/dp_tx.c
Auto-merging drivers/net/wireless/ath/ath12k/dp.h
Auto-merging drivers/net/wireless/ath/ath12k/core.h
Recorded preimage for 'drivers/net/wireless/ath/ath12k/mac.c'
error: Failed to merge in the changes.
Patch failed at 0001 wifi: ath12k: Add support for link specific datapath stats


