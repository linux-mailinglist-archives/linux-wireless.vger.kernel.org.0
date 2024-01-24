Return-Path: <linux-wireless+bounces-2425-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C62839E8E
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 03:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59A2E1F2460F
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 02:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A3915D2;
	Wed, 24 Jan 2024 02:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UsGn6uiz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A641842
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jan 2024 02:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706062186; cv=none; b=DscQW/U7C3OLoNnRywbh5bWoSnNuIDar9nGGjiRADFaJDKXfkL9Y9wE7/ae813gWVsAU/UxS+3GrV9C5Zj8ACEVrhn0t1ppetnakpxfFyGmjjuNMpFvVx/pA6PprPH0qSqYHFFz269RFkXdBhaTcY/CNxc2lIpSiESJy4AvF47E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706062186; c=relaxed/simple;
	bh=biyeFzyxm8JJymPac4SU7LVIwD9F9vRUUuOrUoXLuQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QqIqureAdfs72A3exiYiMTFL07Mh20BDeohSbWad+S2Anz1Jq0bOd775NFh+h8XhftkS3Tas6urGLaypjFCcnJ+Q14ap0PShECdbaham6ZLyh/DEpFjYOOyWppx1+H76gxYQA88VlgnoBdpnJW8Njz8QW/sYO776WuvHTRNpyH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UsGn6uiz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40O1GC18019027;
	Wed, 24 Jan 2024 02:09:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=tt60USMdObOoWT0BRjdt5td5wv/VD7xHByu/pxxELZI=; b=Us
	Gn6uiz5Redl8kjkZnOkTG42wExrJA7LzWwG8oonyUiELVhu5BT5hLKHrLiRKWR/l
	GUqnPb3bYBwRJzCFtKQd5C46RmF74BsXx5+hUS4YJoSBL7xeruz87dWoAB1dBpMW
	LXs4oa0zBt6tyFfuPe/eyJEXZLqgcwV+Wk4+pc9iSe0815/fTGpNkymUs++4GdKR
	hrvKFoF1bAiJooPRv8l+QaQBPoKe92nNeC3QmLeBnFBXrXvW9O8fZwd/jBfl1zr1
	UVgLa0QpK4jEOgxpzhgp+dEocjBiElL1kj1MSisV0NXMgRNno1hhI/vp4EvqlI6P
	S4276L23c3bS1KCWw2xA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vtmhrghhq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 02:09:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40O29e39026797
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 02:09:40 GMT
Received: from [10.110.18.75] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 23 Jan
 2024 18:09:39 -0800
Message-ID: <6e9080e4-fe61-4de9-989c-b3176cb6f744@quicinc.com>
Date: Tue, 23 Jan 2024 18:09:39 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] wifi: ath11k: fix connection failure due to
 unexpected peer delete
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240123025700.2929-1-quic_bqiang@quicinc.com>
 <20240123025700.2929-5-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240123025700.2929-5-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KQdQ1nr_WtmNhAhJNVGf9iQYe3vk0ito
X-Proofpoint-ORIG-GUID: KQdQ1nr_WtmNhAhJNVGf9iQYe3vk0ito
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_15,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 suspectscore=0 clxscore=1015 impostorscore=0 phishscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401240014

On 1/22/2024 6:57 PM, Baochen Qiang wrote:
> Currently ath11k_mac_op_unassign_vif_chanctx() deletes peer but
> ath11k_mac_op_assign_vif_chanctx() doesn't create it. This results in
> connection failure if MAC80211 calls drv_unassign_vif_chanctx() and
> drv_assign_vif_chanctx() during AUTH and ASSOC, see below log:
> 
> [  102.372431] wlan0: authenticated
> [  102.372585] ath11k_pci 0000:01:00.0: wlan0: disabling HT/VHT/HE as WMM/QoS is not supported by the AP
> [  102.372593] ath11k_pci 0000:01:00.0: mac chanctx unassign ptr ffff895084638598 vdev_id 0
> [  102.372808] ath11k_pci 0000:01:00.0: WMI vdev stop id 0x0
> [  102.383114] ath11k_pci 0000:01:00.0: vdev stopped for vdev id 0
> [  102.384689] ath11k_pci 0000:01:00.0: WMI peer delete vdev_id 0 peer_addr 20:e5:2a:21:c4:51
> [  102.396676] ath11k_pci 0000:01:00.0: htt peer unmap vdev 0 peer 20:e5:2a:21:c4:51 id 3
> [  102.396711] ath11k_pci 0000:01:00.0: peer delete resp for vdev id 0 addr 20:e5:2a:21:c4:51
> [  102.396722] ath11k_pci 0000:01:00.0: mac removed peer 20:e5:2a:21:c4:51  vdev 0 after vdev stop
> [  102.396780] ath11k_pci 0000:01:00.0: mac chanctx assign ptr ffff895084639c18 vdev_id 0
> [  102.400628] wlan0: associate with 20:e5:2a:21:c4:51 (try 1/3)
> [  102.508864] wlan0: associate with 20:e5:2a:21:c4:51 (try 2/3)
> [  102.612815] wlan0: associate with 20:e5:2a:21:c4:51 (try 3/3)
> [  102.720846] wlan0: association with 20:e5:2a:21:c4:51 timed out
> 
> The peer delete logic in ath11k_mac_op_unassign_vif_chanctx() is
> introduced by commit b4a0f54156ac ("ath11k: move peer delete after
> vdev stop of station for QCA6390 and WCN6855") to fix firmware
> crash issue caused by unexpected vdev stop/peer delete sequence.
> 
> Actually for a STA interface peer should be deleted in
> ath11k_mac_op_sta_state() when STA's state changes from
> IEEE80211_STA_NONE to IEEE80211_STA_NOTEXIST, which also coincides
> with current peer creation design that peer is created during
> IEEE80211_STA_NOTEXIST -> IEEE80211_STA_NONE transition. So move
> peer delete back to ath11k_mac_op_sta_state(), also stop vdev before
> deleting peer to fix the firmware crash issue mentioned there. In
> this way the connection failure mentioned here is also fixed.
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> 
> Fixes: b4a0f54156ac ("ath11k: move peer delete after vdev stop of station for QCA6390 and WCN6855")
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


