Return-Path: <linux-wireless+bounces-35363-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDrLGH8372nV+QAAu9opvQ
	(envelope-from <linux-wireless+bounces-35363-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 12:16:31 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C016E470C20
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 12:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98FF23031031
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 10:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFDA3AC00;
	Mon, 27 Apr 2026 10:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dEVhJ9JH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LNTLHF1s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBA5303A07
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 10:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777284237; cv=none; b=fuLEx2q1HZGGnIr1TVo95RExHbpLaBuZcnMsW1McCLiEZckX6GOkMX20jYf2p+ht/+sB4JEUrtznqfaZPpSy36xI2QbVxqdS/P+DEvOZvCu63EQ8p4NUmf78ZZhKkA7TibI75XePl8ztM58cIsSn4/r2/qWlYAASsO6cPeZTZ04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777284237; c=relaxed/simple;
	bh=S6uxfQn2+otkRfAL1NAtiDrK7ArtBpvrNSaE1m6sZ0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TJns8ZpkFwKwr66hXgvot08p1IZ8w5pnFf+UuWT6C56s/oFMaV5AsCGFfO04w+5WoYapnvQe8GerHkFcQ9IiPYLHTAUaPUofLVBh61p4JNtT7M11lQltkxUXt/PoEbn9CMQYJhzKs1eQj8gQWq+S57u5AlBUoMWsdScMR8JHMDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dEVhJ9JH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LNTLHF1s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R9OcdQ3825222
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 10:03:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Kbkh1FNbNghjx7YSEVPr3LZXUM0UbtffMSfcjWSjjds=; b=dEVhJ9JHuuBfv0fV
	/SPqp77XYPlrEV83G8ORNJ1lVIk7qTxxZSXvMTLPtP0F0FuZKG+6C8uL6gf3iSLV
	sOngSZ9Ivue4/hrzO8aUBwX7IZBW7SF0x3ckIKZkMRE7wxIfWaqiFnkxBbkBZSZA
	qMyX1OmvHF0EeVujyLlx7gMnmAXsNy6a0/p1oVM4n7Wa5UnNcMF0Vr+gH2ADLnX6
	60T1oW9ekS26EFtPzZm3w67IRQNd7Nph0JBS8ED8F8quT5WK6E8GByfdK3lsUDC4
	KxaRH3PteZ2OBLjVeOxD1VI9qsFfow2Z4mR7PMnyb+aDuDzswPB6KNcTJI7//ij8
	42/qSw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt55506ep-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 10:03:55 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82fa1c94b37so7353938b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 03:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777284235; x=1777889035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kbkh1FNbNghjx7YSEVPr3LZXUM0UbtffMSfcjWSjjds=;
        b=LNTLHF1spRK2BVMEetAZR3LZc+LhEfo4WLGRr8ZZCYBoXth+6Wb2sgFastxez/nzZ1
         ZpZYQCfPUAyoTMR4Zh2ZUl1YcjVTzgQgN6wShWRRRnlCkEFAfFYeap2FKouP8opAgCQm
         UZi4bChRWQmqbwoR9wxv7hyMJXiZHV4pvPc+wzbnMSK1IvgTbNE5n/wGu9puw5iVMCuY
         80WnJOnYXVqFTUpMtetflu3CLWc8rsxLVjEmINlcJxYu5OxCUAYzFSmoMMwmajhRpefJ
         fQ+vQQcHLrArncOAMZtRRJrMTdIS6Dgg4IgHwDz/3Z5HShuDVNPGYvCZMlh09qStHVe5
         Epkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777284235; x=1777889035;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kbkh1FNbNghjx7YSEVPr3LZXUM0UbtffMSfcjWSjjds=;
        b=lFHD8JNJIhVz99L+g2Arlh/roW0mnMEU7yjJH6jZUbvFX/h0aHXyRf3dsJ4afovtIb
         wWQvPZNfW3DRDTe5pmuBWl30i3vkDWes7XA84ha8VkwQSijUOdTu2cYEOKlqV/CjL948
         B8zx+TMNgi/4Zc4V+oqay2VcAlAxseUC44OjY7/DuhqqkEM69TtEctDNL//tzWLL9K9r
         HyiNNA4C/fc8HHDmLc5i8lPJAkaYrzQta5XqeuAQW+qU4HhFcJQEmE8ST0M5s77BstSu
         pqFQkfPYZ5ScWuQzMohBXEXyHzIeNA7sSa6RegGIbHeRr8iZRMcRuGofsaoITrOkpNao
         tuxA==
X-Forwarded-Encrypted: i=1; AFNElJ+Ll908WY36zyBu0FEslRqpZ8aUHUJq56ynWfIYXf86EF1msyTjRXMnxEuNVWM7D4GPuAX18LE9xEs0y0h2Jw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzDnmW5sN7Vxza5AAENzYY2HNKfMAlEBOiZkieArfgZQFLsNnp
	1fdd2LkfZzjwedK0ugAZpuXGuPa+oNwDh9wQR8G4JcZe7yMTSWGkQF6AvhfiZRllQcojWGZT2lF
	pJOIWnahMIPLwEporVIJ+ZBqpUBTG3j0LZ1AaROla/i9Jfto68I86rKGc/2i9E6z9cNuoUg==
X-Gm-Gg: AeBDieu0Xo31i8fDzJ7aOYtLjCTC/j+GlXXxYHdK09xzv8caa/u6zpFyEo9sR4W1jHP
	alGvJxgKi0qWBJzTYHyyZYJKjvv2fNLSnRri8qqnJwUIG7sfeMzMbiZ9Af80wFu469AbsU07o02
	Aoxr74c8DzRXs6LJW5xkfPq7RCU9535I3+WpmfoFSqvwJBce0Cnkqse9h5ApeQWJc8tuA/Fss9D
	mHPHASr/ivIS2Q2mxbF3EeitGftgfsTobZ8oUuA7ORnPxdoBSnTsPxHb05WcGKHNl4hee06lWvh
	Hvou+s1IWSw8fV82vrR5TvTn+1GbpUdqKq6M17KjBTy8lDL3nKVcLotyHoYhMxtvP6FbJLlWwVA
	YJstXoroS5vQtjKmUOJR/2Aj2kC5qXzBuzDOhXziv1KgZ7UIOckfZN7RlCT1kK6HRbvoVGxM=
X-Received: by 2002:a05:6a00:17a6:b0:82f:7888:e2fa with SMTP id d2e1a72fcca58-82f8b542dbdmr37595320b3a.17.1777284234750;
        Mon, 27 Apr 2026 03:03:54 -0700 (PDT)
X-Received: by 2002:a05:6a00:17a6:b0:82f:7888:e2fa with SMTP id d2e1a72fcca58-82f8b542dbdmr37595257b3a.17.1777284234031;
        Mon, 27 Apr 2026 03:03:54 -0700 (PDT)
Received: from [10.152.200.247] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981c07sm38888517b3a.1.2026.04.27.03.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 03:03:53 -0700 (PDT)
Message-ID: <01295135-6bcf-4567-869b-75597649d11c@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 15:32:29 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/8] Adding NO_STA flag and reworking RX link
 resolution
To: Benjamin Berg <benjamin@sipsolutions.net>, linux-wireless@vger.kernel.org,
        Jouni Malinen <jouni.malinen@oss.qualcomm.com>
Cc: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        Benjamin Berg <benjamin.berg@intel.com>
References: <20260223123818.384184-10-benjamin@sipsolutions.net>
Content-Language: en-US
From: Ramasamy Kaliappan <ramasamy.kaliappan@oss.qualcomm.com>
In-Reply-To: <20260223123818.384184-10-benjamin@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9C6cZucGbd0xrR3-4X-HTUGsGTtBoFxI
X-Authority-Analysis: v=2.4 cv=CJEamxrD c=1 sm=1 tr=0 ts=69ef348b cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=QyXUC8HyAAAA:8 a=aP0UE0j1rqk7RjkCihsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEwNSBTYWx0ZWRfXwLGw1Qqj3L6F
 XxwPlt7p3pPm35qhyB8JePA+2WLEu1GkqPcVvek3LwpyrEBO4J7mGjs+61bKR6yXGkl2bXQ41Ti
 uYaR6+AU1kh7BbnmWGCmEE0h5GOJfs/ywgiE6P11NnZLAEjspKDbKvrFiAHGBps4IK9eM6lW6/1
 5hYd+s1cDY+vTIuL0wwKYzs7nEXY+hAEr6Biu9PLDpXIfssDBeBFo/JzYdH4s9QjwpxuxHO+i0k
 4R48RA8P6OMQP603wD5Sc2h1PeoFZtEgbREyirnGO/E8IwWDCGx+S6+iy8FOR5+tjxeBiRySY+9
 fzpoOgrqh2QD8nk8n9Iv0ZkLcdXhXmO6/PSgBE29Y7WRu5Oi0QkIAzAlovoCeo5LF1wzUkEVr/C
 8r/0+3LE06irQ8u5XQSsjfcWz8untt8fZqYnJ5hS1f/nVoKx/7z0UOJheb/Vs1cU+2YOunxOuQ9
 dSENUMSNmlvHWmDpQNg==
X-Proofpoint-ORIG-GUID: 9C6cZucGbd0xrR3-4X-HTUGsGTtBoFxI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270105
X-Rspamd-Queue-Id: C016E470C20
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-35363-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ramasamy.kaliappan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]



On 2/23/2026 6:08 PM, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> Hi,
> 
> This patchset refactors the RX link resolution a bit to fix some issues
> where mac80211 might accept frames on the wrong link and incorrectly
> translate the address. It also adds a new NL80211_ATTR_FRAME_CMD_NO_STA
> flag so that userspace can know whether address translation was done by
> the kernel on RX and can also prevent address translation for management
> frames during TX.
> 
> This together should be enough to fix the existing issues in hostapd
> where stations that are still associated try to authenticate again but
> hostapd for example ends up sending the frame to an old link address.
> 
> I would appreciate if you test the patches and work on the hostapd side.
> Note that I have not properly verified the new nl80211 API, so it could
> well be that I missed something.
> 
> Benjamin
> 
> Changes in RFCv2:
>   * Port other drivers to new API (untested)
>   * Fix a checkpatch warning
> 
> Benjamin Berg (8):
>    wifi: iwlwifi: use link_sta internally to the driver
>    wifi: mac80211: change public RX API to use link stations
>    wifi: mac80211: refactor RX link_id and station handling
>    wifi: mac80211: rework RX packet handling
>    wifi: cfg80211: add attribute for TX/RX denoting there is no station
>    wifi: mac80211: report to cfg80211 when no STA is known for a frame
>    wifi: mac80211: pass station to ieee80211_tx_skb_tid
>    wifi: mac80211: pass error station if non-STA transmit was requested
> 
>   drivers/net/wireless/ath/ath11k/dp_rx.c       |   2 +-
>   drivers/net/wireless/ath/ath12k/dp_mon.c      |  18 +-
>   drivers/net/wireless/ath/ath12k/dp_rx.c       |  15 +-
>   drivers/net/wireless/intel/iwlwifi/mld/agg.c  |  21 +-
>   drivers/net/wireless/intel/iwlwifi/mld/agg.h  |   4 +-
>   drivers/net/wireless/intel/iwlwifi/mld/rx.c   |  50 +-
>   drivers/net/wireless/intel/iwlwifi/mld/rx.h   |   2 +-
>   .../wireless/intel/iwlwifi/mld/tests/agg.c    |   7 +-
>   drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |   2 +-
>   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |   6 +-
>   drivers/net/wireless/mediatek/mt76/mac80211.c |  22 +-
>   drivers/net/wireless/realtek/rtw89/core.c     |   6 -
>   drivers/net/wireless/virtual/mac80211_hwsim.c |   3 -
>   include/net/cfg80211.h                        |   4 +
>   include/net/mac80211.h                        |  25 +-
>   include/uapi/linux/nl80211.h                  |   7 +
>   net/mac80211/agg-tx.c                         |   6 +-
>   net/mac80211/eht.c                            |   3 -
>   net/mac80211/ht.c                             |   4 +-
>   net/mac80211/ieee80211_i.h                    |  14 +-
>   net/mac80211/iface.c                          |   7 +-
>   net/mac80211/mlme.c                           |   9 +-
>   net/mac80211/offchannel.c                     |  13 +-
>   net/mac80211/rx.c                             | 436 ++++++++++--------
>   net/mac80211/scan.c                           |  10 +-
>   net/mac80211/tdls.c                           |   4 +-
>   net/mac80211/tx.c                             |   8 +-
>   net/wireless/nl80211.c                        |   8 +-
>   28 files changed, 390 insertions(+), 326 deletions(-)
> 

The hostapd changes were made and validated against the relevant test 
cases. During testing, we observed some complexities in specific 
scenarios particularly when a Non‑AP STA first associates as L1 (M1)
and then reappears as L1 (M2) during the authentication/association phase.
In this case, on the RX path, when an authentication frame for L1 (M2 in 
the ML IE) is received, the driver finds the existing STA L1 (M1) and 
therefore does not add the NO_STA attribute.

As a result, the complexity of handling authentication and association 
frames increases within the user‑space hostapd application. While 
processing the authentication frame, hostapd parses the ML IE
but fails to create a new STA entry for L1 (M2) in the driver, 
especially in scenarios involving different MLD addresses.

To simplify this handling, we would like to explore an alternative 
approach that avoids address translation for management frames 
(authentication, association, and reassociation),
regardless of whether the STA already exists.

However, this approach may introduce backward compatibility concerns 
when either the driver or hostapd is not updated.
To address this, we propose introducing a capability indication 
mechanism between the driver and user space (driver ↔ hostapd).
Based on the advertised capabilities, mac80211 can then skip 
management‑frame address translation accordingly.

Benjamin and Jouni, Could you please help share your thoughts on this?

Thanks,
Ramasamy

