Return-Path: <linux-wireless+bounces-2546-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7DD83D77F
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 11:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D8681C2F379
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 10:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929AF2230A;
	Fri, 26 Jan 2024 09:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a9Jom/c+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DCF22306
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jan 2024 09:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706261698; cv=none; b=PRZOOKtLoZ1PzD3lddC/qJHrAVLNR24uSxQCmSGofxDG5cUsE2+wlNkj+k1Yvhpbe5RXCg4Y8tfkaus2u3AOQGiWZpH+92kDVpZN6k2Irk/D6ACxunorQ8KRLtfeKcviAmAyCSJPU2xlpbJL4EOxBvdn4fwKiCFdeAlM7UrrYsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706261698; c=relaxed/simple;
	bh=SRv5HTHqVD4NiMvNHWM2MneV9rYYlzx2H2JeN6Ju0EU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=N995cVg6pQYT/0tuVyXpDakTTh582c55YlJb+yUpOi9sQFqC5+3pLg+JORoS9DGOtShfq7pVaWJJ0hQIZu4ryMzxhrmV/7GlzvfNgWwezhj9Cc6JxAGDDefljWBcb50PqHaQJVGg3OhG+Yga0GQpOl9AwvnRMU6AFpGHGt7WarY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a9Jom/c+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40Q6hGld031446;
	Fri, 26 Jan 2024 09:34:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=clgMcUDeubDuKEN2zaEmXabc2yUglnbhQAdTpK8mIAk=; b=a9
	Jom/c+Tu9No2XIDuyQWAnIY0virO4Lr/2TILk7HVlqRhBiMjKKz5Sdrn3XiLF0ER
	2UP66t+5rMZGWiAGAyQ9/FHwKr+83Jr1tURyWy4wX/CApJy8uKtImkwQMGh12uFQ
	cAQx3wLUslwFHBR8H58Gjqh3KIF73k9ThUhroC20qQ2yTVA8HWnwGGFiU4yWPW6t
	vYkvIyTM9hBP45m6lSEpP6iQQQqYkoWihYitHi8FUbenxGSDW+nRvB86/x7Mp79A
	8D67PiLDZndAjRZfD9UEiZyEXMRNX5fY/cguZNKgDtKNw9ZM25sqa6pv1Be61UVC
	AN9z6CU4v2Wc2WhSCZlg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vun5yk7cy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 09:34:48 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40Q9YluE015847
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 09:34:47 GMT
Received: from [10.253.37.249] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 26 Jan
 2024 01:34:46 -0800
Message-ID: <9a90fab6-18f1-4664-96f4-6795174d636f@quicinc.com>
Date: Fri, 26 Jan 2024 17:34:44 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] wifi: ath12k: P2P support for WCN7850
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240122113904.8938-1-quic_kangyang@quicinc.com>
 <87cytp1nhd.fsf@kernel.org>
Content-Language: en-US
From: Kang Yang <quic_kangyang@quicinc.com>
In-Reply-To: <87cytp1nhd.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: n8AmvD1RkSgBGlx_KeUePYsL9NlBhwvK
X-Proofpoint-ORIG-GUID: n8AmvD1RkSgBGlx_KeUePYsL9NlBhwvK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=906 adultscore=0 malwarescore=0
 priorityscore=1501 clxscore=1011 impostorscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401260068



On 1/25/2024 10:44 PM, Kalle Valo wrote:
> Kang Yang <quic_kangyang@quicinc.com> writes:
> 
>> Add P2P support for WCN7850.
>>
>> Kang Yang (10):
>>    wifi: ath12k: change interface combination for P2P mode
>>    wifi: ath12k: add P2P IE in beacon template
>>    wifi: ath12k: implement handling of P2P NoA event
>>    wifi: ath12k: implement remain on channel for P2P mode
>>    wifi: ath12k: change WLAN_SCAN_PARAMS_MAX_IE_LEN from 256 to 512
>>    wifi: ath12k: allow specific mgmt frame tx while vdev is not up
>>    wifi: ath12k: fix broken structure wmi_vdev_create_cmd
>>    wifi: ath12k: move peer delete after vdev stop of station for WCN7850
>>    wifi: ath12k: designating channel frequency for ROC scan
>>    wifi: ath12k: advertise P2P dev support for WCN7850
>>
>> v3: rebase on new ath-tag, use ath12k_ah_to_ar() get ar(Karthikeyan).
>> v2:
>>      1. add Tested-on tag of QCN9274.
>>      2. update copyright in patch #1, #2, #4 and #10.
> 
> I have not been able to run any p2p tests yet but during rmmod with
> WCN7850 I now see:
> 
> [  136.260660] ------------[ cut here ]------------
> [  136.260909] UBSAN: shift-out-of-bounds in drivers/net/wireless/ath/ath12k/mac.c:6005:38
> [  136.261008] shift exponent 255 is too large for 64-bit type 'long long int'


It seems you enable CONFIG_UBSAN, CONFIG_UBSAN_SANITIZE_ALL and other 
CONFIG_UBSAN_XXX.

I will add them to my config file and debug this warning.

It's been a long time since the last update of kernel config. Can you 
share the new one if convenient?


> [  136.261096] CPU: 1 PID: 1993 Comm: rmmod Not tainted 6.8.0-rc1-wt-ath+ #1262
> [  136.261180] Hardware name: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0067.2021.0528.1339 05/28/2021
> [  136.261261] Call Trace:
> [  136.261343]  <TASK>
> [  136.261427]  dump_stack_lvl+0x82/0xc0
> [  136.261513]  dump_stack+0x10/0x20
> [  136.261597]  __ubsan_handle_shift_out_of_bounds+0x13f/0x300
> [  136.261711]  ath12k_mac_op_remove_interface.cold+0x17/0x86 [ath12k]
> [  136.261941]  drv_remove_interface+0x215/0x4a0 [mac80211]
> [  136.262102]  ieee80211_do_stop+0xfe4/0x2390 [mac80211]
> [  136.262258]  ? trace_contention_end+0xe2/0x110
> [  136.262359]  ? ieee80211_del_virtual_monitor+0x60/0x60 [mac80211]
> [  136.262507]  ? mutex_lock_io_nested+0x1260/0x1260
> [  136.262610]  ? debug_smp_processor_id+0x17/0x20
> [  136.262702]  ? trace_contention_end+0xe2/0x110
> [  136.262792]  ieee80211_sdata_stop+0x4d/0x70 [mac80211]
> [  136.262961]  ieee80211_stop_p2p_device+0xd/0x10 [mac80211]
> [  136.263127]  cfg80211_stop_p2p_device+0x18e/0x580 [cfg80211]
> [  136.263282]  cfg80211_shutdown_all_interfaces+0x10c/0x190 [cfg80211]
> [  136.263434]  ieee80211_remove_interfaces+0xc7/0x8f0 [mac80211]
> [  136.263611]  ? __wait_for_common+0x42f/0x6d0
> [  136.263702]  ? ieee80211_sdata_stop+0x70/0x70 [mac80211]
> [  136.263881]  ieee80211_unregister_hw+0x4f/0x380 [mac80211]
> [  136.264045]  ath12k_mac_hw_unregister+0x7a/0x250 [ath12k]
> [  136.264155]  ath12k_mac_unregister+0x7f/0xc0 [ath12k]
> [  136.264265]  ath12k_core_deinit+0x2e/0x130 [ath12k]
> [  136.264372]  ath12k_pci_remove+0xad/0x1a0 [ath12k]
> [  136.264478]  pci_device_remove+0x93/0x1b0
> [  136.264567]  device_remove+0xbf/0x150
> [  136.264662]  device_release_driver_internal+0x3c3/0x580
> [  136.264746]  ? __kasan_check_read+0x11/0x20
> [  136.264836]  driver_detach+0xc4/0x190
> [  136.264924]  bus_remove_driver+0x130/0x2a0
> [  136.265012]  driver_unregister+0x68/0x90
> [  136.265095]  pci_unregister_driver+0x24/0x240
> [  136.265177]  ? find_module_all+0x13e/0x1c0
> [  136.265267]  ath12k_pci_exit+0x10/0x20 [ath12k]
> [  136.265372]  __do_sys_delete_module+0x32d/0x540
> [  136.265454]  ? module_flags+0x300/0x300
> [  136.265708]  ? kmem_cache_free+0xea/0x3a0
> [  136.265795]  ? __fput+0x404/0xa50
> [  136.265887]  ? debug_smp_processor_id+0x17/0x20
> [  136.265983]  __x64_sys_delete_module+0x4f/0x70
> [  136.266064]  do_syscall_64+0x66/0x130
> [  136.266149]  entry_SYSCALL_64_after_hwframe+0x46/0x4e
> [  136.266256] RIP: 0033:0x7efe74591c8b
> [  136.266347] Code: 73 01 c3 48 8b 0d 05 c2 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d5 c1 0c 00 f7 d8 64 89 01 48
> [  136.266435] RSP: 002b:00007ffea9c34cb8 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
> [  136.266550] RAX: ffffffffffffffda RBX: 000055db95b4c7e0 RCX: 00007efe74591c8b
> [  136.266679] RDX: 000000000000000a RSI: 0000000000000800 RDI: 000055db95b4c848
> [  136.266808] RBP: 00007ffea9c34d18 R08: 0000000000000000 R09: 0000000000000000
> [  136.266934] R10: 00007efe7460dac0 R11: 0000000000000206 R12: 00007ffea9c34ef0
> [  136.267062] R13: 00007ffea9c36ebf R14: 000055db95b4b2a0 R15: 000055db95b4c7e0
> [  136.267221]  </TASK>
> [  136.267390] ---[ end trace ]---
> 

