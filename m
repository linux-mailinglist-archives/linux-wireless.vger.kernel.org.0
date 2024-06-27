Return-Path: <linux-wireless+bounces-9666-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9748B91AD33
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 18:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C1F21F260CF
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 16:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950841990C4;
	Thu, 27 Jun 2024 16:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cY4Nf4hb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7093E56A
	for <linux-wireless@vger.kernel.org>; Thu, 27 Jun 2024 16:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719507046; cv=none; b=YP+TMERZIwVnVIWUgE3XFvZSNvau+hQ08QLbW/rbF1uT1r1YeMtn3RceloXw1xqHO+fQknDAWPRtCNYbCkJ6dykRhnUX4jUmIVBRkfC6gaAFV7hfX7Iq3GaX304eRspCbKBUktF4/EN5qpS9IQEgVU/O/NoZckCMIhb/J6zTA8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719507046; c=relaxed/simple;
	bh=DVjT5whT+5revSuocvYC8x6klYFcuGbOnMbw/Y/x1f8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FtkN39oZxeANGupnCDOYNCmI3tnBQrE/wLYX1fUngeYMEtJiI0LygbH2lujBmMoRMQgZFn11EuBU63wnxiBGaF11ASJD+0hQGGxeXejIuQkJllNiojMbWr54BBYxJr9TNd961et5BqQRo2qoDGIYLBEpvrkrSb6rLrroO/6KMkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cY4Nf4hb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45RAoYEh025153;
	Thu, 27 Jun 2024 16:50:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h85ZTJxWquN/922qfSh5grDxytiEhjvIc5ozFIpbq1A=; b=cY4Nf4hbIWZlJXB+
	P2McO0DobXrfY2VSgdIBLlqb6J7+zoE6yGjntf5Hw4k1SOTBxcL5i6LKA0Fv4tG6
	l/4k5sZrfnOAfji5CXy1m+A5VmYfmSyxlt2MxwFdtmnCjtK1QDIAbPiTUdMQm5SJ
	9r6yiNaQKEmwo7lmayNWGX8D778uFthDki6Db3ba03eGSkFsGj+lrn57q62JCDBY
	n60IGTt2ctrpHVeQPs8ktCwgFMR8FPUfrMJNeTk4bgs9G+vfY5VjpDyf28aVOl/g
	3VEIKMtWgbodrlSzIvIjxROtxyOwg10TgPP+z/JtMVPobBhu/K14iqkHAorVpmnQ
	sK5h9Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywp6yw180-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 16:50:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45RGoH9S020001
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 16:50:18 GMT
Received: from [10.48.244.230] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 27 Jun
 2024 09:50:16 -0700
Message-ID: <c8b27726-db5b-45b0-8821-4aece5868fe2@quicinc.com>
Date: Thu, 27 Jun 2024 09:50:16 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Add WMI control path stats infra
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>,
        Ramya Gnanasekar
	<quic_rgnanase@quicinc.com>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Rajat Soni
	<quic_rajson@quicinc.com>
References: <20240529180920.1472003-1-quic_rgnanase@quicinc.com>
 <8d3fc6d4-abcc-4551-9837-afe7dc482cbe@quicinc.com>
 <87ed8igxez.fsf@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <87ed8igxez.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KYTahvVS3GcKorVsJUOSfTARiw6jCy1R
X-Proofpoint-ORIG-GUID: KYTahvVS3GcKorVsJUOSfTARiw6jCy1R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_12,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406270128

On 6/27/2024 9:31 AM, Kalle Valo wrote:
> Ramya Gnanasekar <quic_rgnanase@quicinc.com> writes:
> 
>> On 5/29/2024 11:39 PM, Ramya Gnanasekar wrote:
>>> From: Rajat Soni <quic_rajson@quicinc.com>
>>>
>>> Currently, firmware stats is requested by host through HTT interface.
>>> Since HTT interface is already overloaded for data path stats,
>>> leveraging control path to request other stats through WMI interface.
>>>
>>> Add debugfs to request the stats and dump the stats forwarded by firmware.
>>>
>>> ath12k
>>> `-- pci-0000:06:00.0
>>>     |-- mac0
>>>         `-- wmi_ctrl_stats
>>>
>>> This patch also adds support to request PDEV Tx stats, parse and dump
>>> the data sent from firmware.
>>>
>>> Usage:
>>> echo <stats id> <action> > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/wmi_ctrl_stats
>>>
>>> Sample:
>>> echo 1 1 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/wmi_ctrl_stats
>>> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/wmi_ctrl_stats
>>> WMI_CTRL_PATH_PDEV_TX_STATS:
>>> fw_tx_mgmt_subtype =  0:0, 1:2, 2:0, 3:0, 4:0, 5:37, 6:0, 7:0, 8:908, 9:0, 10:0, 11:18, 12:2, 13:3, 14:0, 15:0,
>>> fw_rx_mgmt_subtype =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0,
>>> scan_fail_dfs_violation_time_ms = 0
>>> nol_chk_fail_last_chan_freq = 0
>>> nol_chk_fail_time_stamp_ms = 0
>>> tot_peer_create_cnt = 7
>>> tot_peer_del_cnt = 7
>>> tot_peer_del_resp_cnt = 7
>>> vdev_pause_fail_rt_to_sched_algo_fifo_full_cnt = 0
>>>
>>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>>
>>> Signed-off-by: Rajat Soni <quic_rajson@quicinc.com>
>>> Co-developed-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
>>> Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
>>> ---
>>> Depends-On: [PATCH v2 3/5] wifi: ath12k: Fix Pdev id in HTT stats request for WCN7850
>>> Link: https://lore.kernel.org/linux-wireless/20240510050806.514126-1-quic_rgnanase@quicinc.com
> 
> [removing over 600 lines unnecessary quotes]
> 
>> Please drop this patch. I'll send a re-based version
> 
> Dropped, thanks for letting us know. But please edit your quotes,
> including the full patch in the reply makes the use of patchwork
> practically unusable:
> 
> https://patchwork.kernel.org/project/linux-wireless/patch/20240529180920.1472003-1-quic_rgnanase@quicinc.com/
> 

Also FYI I acked it because it applied to my work branch with minimal
conflicts which i was able to easily resolve, but of course it is always
appreciated when patches are rebased to apply cleanly.

/jeff

