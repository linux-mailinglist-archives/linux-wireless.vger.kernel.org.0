Return-Path: <linux-wireless+bounces-24332-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEF6AE343E
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 06:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8244416431E
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 04:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAED13C8EA;
	Mon, 23 Jun 2025 04:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QYqG3oFV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E8A24B28
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 04:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750652280; cv=none; b=DXagXmpswjJzpZj7uyNUPItF2Q8JuL+mHmLOxMDLZAntDEysKBAV+tJbirg0ctyj7/RaADQxThd12sB0oA6SoxTSdAwReEqHRMPjBZQVFFMoUI/QBUdh+Vgzp0a3sAGQ1KIqIZxVZbw8tk19D9Sfww1UfImtRWLzF6c6i5E5SMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750652280; c=relaxed/simple;
	bh=yziwBVPz3aq1bgHORQxhcI1wKWH3z9qt01tRhwYo7wU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=paYp7kVkCu+dBM2DfCRF7gzDdYG44+UIcHT6Yu93nbTpqJ1GFI28FuhfZMoWHMY4W24l6mPbtS6D56McmdbeqeeBf6FJTekF1xYPN8XpwQSE1sbQ7hpHbTgErZ6VnCBjKLQ55GXJinTnipPxhgy3Dl87wUxOOu4GU3OyZs971+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QYqG3oFV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N29BEg021739;
	Mon, 23 Jun 2025 04:17:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1X+5oS7cexX+bxXLJeAB2eaYu59G2fHCkaLDIk3njgs=; b=QYqG3oFVfxCco0t6
	0vHvPsVr8dYh5Av2ztNFVFqZ1PF59C6kTOFzxvDr8dYeKkfTOxO+FkgFkoe1xMfx
	jLq70BavBA0M1X6BbwNEwemmJHHHjQcZoMK8G821Ph8SApVzZuH1dz8SFil0DSiB
	sAvIRKQl+uiWppa6gyqAJwDXQLimjTDZZ9mqqQHILUs/UVOTjv2YmrceDKiXMePQ
	nLqdCaQqA4PauQoPGL7yNUC4QzN0K/vYQAUZrtc6yfGMbnt+cikFY3/f47ZArfxf
	ABrE31j+alFwaCuExoW/BycrCRk36y6ukR8caeIjzs4DuSmX10jnkHE+e3h7I1F8
	ZlXicg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ewv787j6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jun 2025 04:17:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55N4HrPQ027137
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jun 2025 04:17:53 GMT
Received: from [10.216.31.112] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 22 Jun
 2025 21:17:52 -0700
Message-ID: <405d254c-9a92-e269-b819-b14d0485da00@quicinc.com>
Date: Mon, 23 Jun 2025 09:47:49 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next] wifi: ath12k: Avoid accessing uninitialized
 arvif->ar during beacon miss
Content-Language: en-US
To: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250618185635.750470-1-rameshkumar.sundaram@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20250618185635.750470-1-rameshkumar.sundaram@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: emgimUg36FjeOfj0YR97EXtekqzDavo9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDAyMiBTYWx0ZWRfX6fss7J/JN+sd
 pMtrHQ8r2W8W8x0d7EvHk/A3VGo80NcTKiQb4PGTy82dfNK9dBJa+h//NbSNY+bjPVEkMNO6LiH
 Yw6jod13uOLCyKKuhqhnQxxA/27E2wd/OG9AAncf2DswmlWW5k3IqCJOMObht3/8Y7+BqVj0NcJ
 NOp1XijJ+K91+uD0gDhCEkQfAd0Km3QSHqXj4P3RDYNfXuGa3q+wWcwLyoa0pyFa5V7wzEUmO8e
 gV5XSmLTajv5duLSYijhx5G39eDkw5ZObG31oNvsOqIUiHyFc4d0wbMPoh70JjM7+DPSnTKUHGa
 DWGYtSOKcV/Q+BMiPZYZo0gh2zLt1C82BHGbYF8LlEclH4FieD6gCipl1ba9TT+TCd16H91vG1h
 ZrllDR17kuXHdzrgEmunj/QPdtTMT7iLcNGKwUpJJEZ79+KvysJ7A1R86CKvurgeIa/29q88
X-Proofpoint-ORIG-GUID: emgimUg36FjeOfj0YR97EXtekqzDavo9
X-Authority-Analysis: v=2.4 cv=NtfRc9dJ c=1 sm=1 tr=0 ts=6858d572 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8
 a=ndFkImpZcDCW1Fv5VC8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_01,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230022



On 6/19/2025 12:26 AM, Rameshkumar Sundaram wrote:
> During beacon miss handling, ath12k driver iterates over active virtual
> interfaces (vifs) and attempts to access the radio object (ar) via
> arvif->deflink->ar.
> 
> However, after commit aa80f12f3bed ("wifi: ath12k: defer vdev creation for
> MLO"), arvif is linked to a radio only after vdev creation, typically when
> a channel is assigned or a scan is requested.
> For P2P capable devices, a default P2P interface is created by
> wpa_supplicant along with regular station interfaces, these serve as dummy
> interfaces for P2P-capable stations, lack an associated netdev and initiate
> frequent scans to discover neighbor p2p devices. When a scan is initiated
> on such P2P vifs, driver selects destination radio (ar) based on scan
> frequency, creates a scan vdev, and attaches arvif to the radio. Once the
> scan completes or is aborted, the scan vdev is deleted, detaching arvif
> from the radio and leaving arvif->ar uninitialized.
> 
> While handling beacon miss for station interfaces, P2P interface is also
> encountered in the vif iteration and ath12k_mac_handle_beacon_miss_iter()
> tries to dereference the uninitialized arvif->deflink->ar.
> 
> Fix this by verifying that vdev is created for the arvif before accessing
> its ar during beacon miss handling and similar vif iterator callbacks.
> 
> ==========================================================================
>   wlp6s0: detected beacon loss from AP (missed 7 beacons) - probing
>   KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
> 
>   CPU: 5 UID: 0 PID: 0 Comm: swapper/5 Not tainted 6.16.0-rc1-wt-ath+ #2 PREEMPT(full)
>   RIP: 0010:ath12k_mac_handle_beacon_miss_iter+0xb5/0x1a0 [ath12k]
>   Call Trace:
>    __iterate_interfaces+0x11a/0x410 [mac80211]
>    ieee80211_iterate_active_interfaces_atomic+0x61/0x140 [mac80211]
>    ath12k_mac_handle_beacon_miss+0xa1/0xf0 [ath12k]
>    ath12k_roam_event+0x393/0x560 [ath12k]
>    ath12k_wmi_op_rx+0x1486/0x28c0 [ath12k]
>    ath12k_htc_process_trailer.isra.0+0x2fb/0x620 [ath12k]
>    ath12k_htc_rx_completion_handler+0x448/0x830 [ath12k]
>    ath12k_ce_recv_process_cb+0x549/0x9e0 [ath12k]
>    ath12k_ce_per_engine_service+0xbe/0xf0 [ath12k]
>    ath12k_pci_ce_workqueue+0x69/0x120 [ath12k]
>    process_one_work+0xe3a/0x1430
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284.1-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Fixes: aa80f12f3bed ("wifi: ath12k: defer vdev creation for MLO")
> Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

