Return-Path: <linux-wireless+bounces-5991-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603A989D219
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 08:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8633D1C20E9D
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 06:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D506A00B;
	Tue,  9 Apr 2024 06:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eJM33OVR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7604C69
	for <linux-wireless@vger.kernel.org>; Tue,  9 Apr 2024 06:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712642544; cv=none; b=sdIhNk3k2jsTget80qSkTlO5xSkMC13i41RXZnj5yeC6RwgWuGnDBYOHTx7+3R4P/bo9hsbYekZjLcdsz9SVsD8v7qrfSYz7OEXzrToobg9ADa0h+jJhOIaT23GSzJK9BZBUUDilTMwhLUOL9b2gxKjmW5WFKozxo+gBhS8ufmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712642544; c=relaxed/simple;
	bh=uSSc3T/Z36VoXgzcHzPdWrqip6DGOHvJfiA1BuHf3pI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ppg6RILnMuOhvOosLb/Pn+PErOUdGsOauJoiLCU1opaWfVy0moCyN0xW/KapGpw+eisrdYYdIx+pgtazcBfItQaJSd678/Kcvbnm2iGOTJ4umf3GRHjzCxC76KPctUP8eYYvKekTHUKXNoGZM4DTsFRMG40fi8pDotKdmVkg90I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eJM33OVR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4395kaDe009685;
	Tue, 9 Apr 2024 06:02:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=gkAMR96SUwvntx11tVJ7L1gP8LVJISV8tZd9sah3VPc=; b=eJ
	M33OVR+3J12ZgcAl/gWPO66eIknlb3eNc3rQ65bC42cpHWouizNX3lo7kmRVvSZc
	QHMx4dDsf3g/grwfWKKaQ5qJEbfz6OWyGhScpJWo9UEE4N4Hr4F2con6AKSrvbo5
	Ka7weeocXf5sMEG1v/RF2XsnaeAKskHIL/+2iVqsjpF5kbpwhG6BZxmgI5YoaBTy
	3AfsDYYoxlQ/ulUtE6cnviEn7gtaIfnab61FSkqLn9884li31RsyB1Bm2bzLGLQA
	FfLrx5KzowA9Q/DL7THTwy2mY2zO0qWvrPbbzDlCLGSzNSAHfs084pDwKFpdIWs+
	8qQJ2fjYb9Am6AXUZUog==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xcvuf894x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 06:02:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43962G13020263
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Apr 2024 06:02:16 GMT
Received: from [10.216.45.2] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Apr 2024
 23:02:14 -0700
Message-ID: <0496fb7e-53cc-476f-8052-985d82fd8d01@quicinc.com>
Date: Tue, 9 Apr 2024 11:32:10 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: handle link ID during management Tx
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
References: <20240326045242.3190611-1-quic_adisi@quicinc.com>
 <930cc3514cd73b837b9e818061215773444f0ecd.camel@sipsolutions.net>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <930cc3514cd73b837b9e818061215773444f0ecd.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tJMQd1MXM41Zk-V3h_cqfnoWW4qCBR55
X-Proofpoint-ORIG-GUID: tJMQd1MXM41Zk-V3h_cqfnoWW4qCBR55
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_03,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=756
 impostorscore=0 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404090035

On 4/9/24 00:01, Johannes Berg wrote:
> On Tue, 2024-03-26 at 10:22 +0530, Aditya Kumar Singh wrote:
>> From: Sriram R <quic_srirrama@quicinc.com>
>>
>> During management Tx, when source address is same as the link conf's
>> address and even when userspace requested Tx on a specific link, link ID
>> is not set which leads to dropping of the frame later.
> 
> Sorry, don't understand. Please be more precise about the scenario and
> why it's dropped.

So here, as per existing code, link_id would be -1 still even when user 
space requested it and there is a channel to Tx on.

This -1 would be sent forward like this -

* ieee80211_tx_skb_tid()
    * __ieee80211_tx_skb_tid_band()       // band = 0
	Now, if your link address happen to be same as your MLD
	address, then mac80211 would put IEEE80211_LINK_UNSPECIFIED.
    	Looks like this results in mac80211 unable to set certain
	sta related fields in tx_control.

As a result when the packet arrives in driver, with various condition 
checks it fails and goes to either wrong path or dropped completely.

For example in mac80211_hw_sim driver,

Since link is unspecified, it goes in mac80211_hwsim_select_tx_link() 
but there this condition is hit -

if (WARN_ON_ONCE(!sta || !sta->valid_links))
	return &vif->bss_conf;

Following is the trace -
------------[ cut here ]------------
WARNING: CPU: 0 PID: 518 at 
drivers/net/wireless/virtual/mac80211_hwsim.c:1889 
mac80211_hwsim_tx+0x23e/0x7df
CPU: 0 PID: 518 Comm: hostapd Tainted: G        W 
6.8.0-rc7-g43e63eea1b51-dirty #140
Stack:
  6060f8e1 604af0ce 6003ba75 00000001
  6060f8e1 604c74ef 00000000 604cf3b0
  00000000 00000000 00000009 60044d6a
Call Trace:
  [<6003bcc9>] ? os_is_signal_stack+0x1b/0x27
  [<604c74ef>] ? _printk+0x0/0x9f
  [<60025b3b>] ? show_stack+0x13a/0x147
  [<604af0ce>] ? dump_stack_print_info+0xe4/0xf0
  [<6003ba75>] ? um_set_signals+0x0/0x3c
  [<604c74ef>] ? _printk+0x0/0x9f
  [<604cf3b0>] ? dump_stack_lvl+0x47/0x52
  [<60044d6a>] ? __warn+0xd5/0x107
  [<604c64ac>] ? warn_slowpath_fmt+0xd6/0xe2
  [<604c7586>] ? _printk+0x97/0x9f
  [<604c63d6>] ? warn_slowpath_fmt+0x0/0xe2
  [<60078561>] ? find_held_lock+0x3b/0x82
  [<6046b953>] ? ieee80211_tx_frags+0x1d8/0x27f
  [<6007aa1d>] ? lock_release+0x239/0x248
  [<60241801>] ? mac80211_hwsim_tx+0x23e/0x7df
  [<6046b9a0>] ? ieee80211_tx_frags+0x225/0x27f
  [<6046cd82>] ? invoke_tx_handlers_late+0x2da/0x7a3
  [<604c74ef>] ? _printk+0x0/0x9f
  [<604bf08b>] ? memcmp+0x0/0x21
  [<6046baf9>] ? __ieee80211_tx+0xff/0x147
  [<6046f658>] ? ieee80211_tx+0x11a/0x128
  [<60471742>] ? __ieee80211_tx_skb_tid_band+0x20d/0x227
  [<60471888>] ? ieee80211_tx_skb_tid+0x12c/0x148
  [<6044439c>] ? ieee80211_mgmt_tx+0x528/0x5c7


Later in mac80211_hwsim_tx(), channel is selected as NULL ultimately due 
to this and hence this condition is hit -

if (WARN(!channel, "TX w/o channel - queue = %d\n", txi->hw_queue)) {
	ieee80211_free_txskb(hw, skb);
	return;
}

Trace-
------------[ cut here ]------------
WARNING: CPU: 0 PID: 518 at 
drivers/net/wireless/virtual/mac80211_hwsim.c:2005 
mac80211_hwsim_tx+0x54e/0x7df
TX w/o channel - queue = 0
CPU: 0 PID: 518 Comm: hostapd Tainted: G        W 
6.8.0-rc7-g43e63eea1b51-dirty #140
Stack:
  6060f8e1 604af0ce 6003ba75 00000001
  6060f8e1 604c74ef 00000000 604cf3b0
  00000000 826d7560 00000009 60044d6a
Call Trace:
  [<6003bcc9>] ? os_is_signal_stack+0x1b/0x27
  [<604c74ef>] ? _printk+0x0/0x9f
  [<60025b3b>] ? show_stack+0x13a/0x147
  [<604af0ce>] ? dump_stack_print_info+0xe4/0xf0
  [<6003ba75>] ? um_set_signals+0x0/0x3c
  [<604c74ef>] ? _printk+0x0/0x9f
  [<604cf3b0>] ? dump_stack_lvl+0x47/0x52
  [<60044d6a>] ? __warn+0xd5/0x107
  [<604c64ac>] ? warn_slowpath_fmt+0xd6/0xe2
  [<604c63d6>] ? warn_slowpath_fmt+0x0/0xe2
  [<60078561>] ? find_held_lock+0x3b/0x82
  [<6046b953>] ? ieee80211_tx_frags+0x1d8/0x27f
  [<6007aa1d>] ? lock_release+0x239/0x248
  [<60241b11>] ? mac80211_hwsim_tx+0x54e/0x7df
  [<6046b9a0>] ? ieee80211_tx_frags+0x225/0x27f
  [<6046cd82>] ? invoke_tx_handlers_late+0x2da/0x7a3
  [<604c74ef>] ? _printk+0x0/0x9f
  [<604bf08b>] ? memcmp+0x0/0x21
  [<6046baf9>] ? __ieee80211_tx+0xff/0x147
  [<6046f658>] ? ieee80211_tx+0x11a/0x128
  [<60471742>] ? __ieee80211_tx_skb_tid_band+0x20d/0x227
  [<60471888>] ? ieee80211_tx_skb_tid+0x12c/0x148
  [<6044439c>] ? ieee80211_mgmt_tx+0x528/0x5c7
  [<6041bf86>] ? nl80211_tx_mgmt+0x298/0x319



> 
> Also, client mode, so wpa_s is actually sending a link-specific action
> frame?

As per current supplicant code I don't see it sending. This change is 
agnostic to supplicant or hostapd sending link id or not in action frame.

If user space has requested in a particular link and if channel is set 
in that link then use that link. This is what this change is trying to 
do. And all this for management frames only.


