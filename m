Return-Path: <linux-wireless+bounces-21326-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9877A827B0
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 16:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA3274A3A61
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 14:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A63B25EFBD;
	Wed,  9 Apr 2025 14:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cDxA8fIn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CE42561CE
	for <linux-wireless@vger.kernel.org>; Wed,  9 Apr 2025 14:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744208694; cv=none; b=mhWQ0XnGIUAcADhaefZE82+zYPThZrY3+CB47sUE4OPIio6KsJOsipX3t06wR+bfnRXPQqzkyf46qce9G4lw+VmbIcpUhNnWdP6ridOKf9YVkkeVmxg2uQc22ny/8JhdK8egD5xSzlEo5ngEAGtVHdaRV7MwVGGjimAK+YpeUuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744208694; c=relaxed/simple;
	bh=qqfRiACLVaSel6XUMGHYN2vsKG2sGkrjReAg/G/QEPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=echO/MxXWNpMXe4hghqcj4aXvwXsQts53p6wHNa8ipLCKdrEwDdgFwGobSPX/zIFp++bPRW0W+DETqzX2IHMgaS2I1bm+XQuI5yxhC9rRU9GqA9mRvvAV63yKaqL642YBLuzexsrqGluRNBjuf0tzoojmkx+/iUMeKt7LXVolsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cDxA8fIn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53985FjB014998
	for <linux-wireless@vger.kernel.org>; Wed, 9 Apr 2025 14:24:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	92+zPAheUU83RIgUZculZ52msaVJUfLERxqhAO6Aa1g=; b=cDxA8fIn+/uQSnGr
	gj7lQkRGo89vLW08HN4YxsRdx8/JrbKRnwN9UK4hHJXAT1s0N+t647mwfg80Bikq
	q+wfQQ+NpjEEWkV3CVSoxSf40C/7/UdggcZIdSl0O2jbTJioV4QQ4P3dUOdZbOLT
	mAkgJmpsHcvIPvlQ3vFKdrhqswNYmCdDEe1eBCP010d8FfFDoezRG9+awqu39g2C
	z+ZJxJ/wdVvgvO0uhmxnYzYKlHWwMjQD959uMzZaJq8b455ifSh35D6Et5c1xShd
	Ta0aOXE2dEHYlIYGm03jcxyHEzCLsKkSTbzgN70XMOcWW/lh255SkFY03ArUexXC
	xlKz1g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twbukn7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 09 Apr 2025 14:24:51 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff7f9a0b9bso6328469a91.0
        for <linux-wireless@vger.kernel.org>; Wed, 09 Apr 2025 07:24:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744208690; x=1744813490;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=92+zPAheUU83RIgUZculZ52msaVJUfLERxqhAO6Aa1g=;
        b=LUIDwN3SpOehKkE6oXH6xrgOI/zjHKzHx8BYEyiJN8uZvvUzrIasB2NwaNNTxxHGIU
         YFDu+cDisiph8X/bqyJf2Nj3SGEY8SexbuoflvBFUdxWyjqiI8QWsWMwZBf8C1813VJa
         PFCQyumOGoKsXy75EBrDyknj0Kj3DWkopcQE1SFx1TuznOsa8wxg5W4UR8TPI3ED09Io
         /huDcqUc7rbdHNNkieggT+oiGxftoap1WeVXEafJgk+LVGZc/dCe0tC7YqaYe+83pIOB
         3xlaEAHzc8P3lAeBvdWjaX0Orh8epcpTaDlGe3OuD/lm3KUg36X6oG8ghtQNxWOES3U5
         Hp3A==
X-Gm-Message-State: AOJu0YzrydzFAK8lD+/+3EjGhxA59c791yjPBHo9hHCPZQnIYCshTajz
	HXn+7mrjC0uoHoxF/3c7DbQPQGWP/iosP7n/KVTw/254DL4mkbiAJKFDK/MWtmRQwBy5IgbpyLe
	CDN3ejvTOMkCPUWDfNsw5T0nNhYfY0sTcG9gC8Wojq27E59ys5tSqDGtorDn8jAtyVw==
X-Gm-Gg: ASbGncvxczPZzDuLQ06psejT3I5Myx31h5F+jxiFgJHqoyoch7tBU0toQWWIAu/vZ+T
	GdGO42GsnPQGWAzYcb1QZXE+GXNWEdoiULag7Uyy82NHXIFhXJ5qUZhrzXzD+xISjGcp/XCgN+I
	rmAOYQyLk3jBxFY2KaUMVtPZyEPG4vUyCnkVuy/vQmcjKs2Ia/XM8OTgFOUiooa7fqFvf024CuO
	t5lIjaT5Kf4FWpnXyxzm3d16/QwYFhYE7seAeS4NQabie+r4g0QUksYkAHLg1SpxgZr0DLSUi5g
	7O1VCkAEta1eHpAlF1AibnzN3s9Fc9Aw4dxGMJakKcY36fWTFvz1DP1XCf880AMaxhg=
X-Received: by 2002:a17:90b:51ca:b0:2ee:bc7b:9237 with SMTP id 98e67ed59e1d1-306dbc2d129mr4448091a91.27.1744208690215;
        Wed, 09 Apr 2025 07:24:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDnh2yvc3zc9qhOZk7VBH/rYTuTmOSKdjklRkpjCrCyppSRzIqmm7v5R+XjgQ5imdS+ebrHQ==
X-Received: by 2002:a17:90b:51ca:b0:2ee:bc7b:9237 with SMTP id 98e67ed59e1d1-306dbc2d129mr4448029a91.27.1744208689506;
        Wed, 09 Apr 2025 07:24:49 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd1717c3sm1665833a91.30.2025.04.09.07.24.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 07:24:49 -0700 (PDT)
Message-ID: <03cb17ec-3dad-4037-ae0a-4c3646d7a836@oss.qualcomm.com>
Date: Wed, 9 Apr 2025 07:24:48 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] wifi: ath12k: Add support for link specific datapath
 stats
To: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250203213237.2695131-1-quic_bmahalin@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250203213237.2695131-1-quic_bmahalin@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: iGYZ7ulGxUmA46JPMuSjfrvQu72mI3Qb
X-Proofpoint-ORIG-GUID: iGYZ7ulGxUmA46JPMuSjfrvQu72mI3Qb
X-Authority-Analysis: v=2.4 cv=dbeA3WXe c=1 sm=1 tr=0 ts=67f68333 cx=c_pps a=RP+M6JBNLl+fLTcSJhASfg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=6abM9aXEu75qKuWjdXoA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504090089

On 2/3/2025 1:32 PM, Balamurugan Mahalingam wrote:
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

This no longer applies to ath/main, so please rebase and post v5

Applying: wifi: ath12k: Add support for link specific datapath stats
error: patch failed: drivers/net/wireless/ath/ath12k/core.h:301
error: drivers/net/wireless/ath/ath12k/core.h: patch does not apply
error: patch failed: drivers/net/wireless/ath/ath12k/debugfs.c:32
error: drivers/net/wireless/ath/ath12k/debugfs.c: patch does not apply
error: patch failed: drivers/net/wireless/ath/ath12k/debugfs.h:15
error: drivers/net/wireless/ath/ath12k/debugfs.h: patch does not apply
error: patch failed: drivers/net/wireless/ath/ath12k/dp.h:313
error: drivers/net/wireless/ath/ath12k/dp.h: patch does not apply
error: patch failed: drivers/net/wireless/ath/ath12k/hal_desc.h:1
error: drivers/net/wireless/ath/ath12k/hal_desc.h: patch does not apply
error: patch failed: drivers/net/wireless/ath/ath12k/mac.c:3980
error: drivers/net/wireless/ath/ath12k/mac.c: patch does not apply
Patch failed at 0001 wifi: ath12k: Add support for link specific datapath stats


