Return-Path: <linux-wireless+bounces-31203-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KzDJjVseGlSpwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31203-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 08:41:41 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BD490C95
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 08:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17A8B303077C
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 07:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B6B2DD60F;
	Tue, 27 Jan 2026 07:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p7ZNIXkx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NlhtrtUg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AB22D7392
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 07:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769499697; cv=none; b=bgEZTNvcBER7U8gyCLBAWVdR2XN1ktGMs7vuop/XcCjZkEpDCA9YENZYnoDTN3pAJ0gZKLM8p6nV8uFLkV1/Dk/8TtaDlblJLn/6FeEHKPErmzdt3BqEWloEUJ67eBi6s707esUhSInvIIAaVn0XbBb+1eG2RxsKhX5yZWYHfJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769499697; c=relaxed/simple;
	bh=+CV28QFbu/uolrPr+CZG8rlJSq9Kao3vVL4Rephxic0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LPYNCIz+PcP8RNaqaxdpo5KMXVzj4d96mskXe3TYiiWkZkDmF9kRxQe6TiCuz+d4OjpK2R8EXazTbsdxEKkQ3QLYa9A0q6iWSeGCEiXk3lyZzi+ZKww4BZgAhpKTMDPtlprR+dsIlPnAZmbXMvlHWR/quCuBqPCT7daKKHgS+t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p7ZNIXkx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NlhtrtUg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60R4UEkj496030
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 07:41:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7dprmke1Nl4vM405OVGCjKPKs6FWp844yoaeNutzCxs=; b=p7ZNIXkxpdRYNslr
	MwBulEeqrO+u6F7KQb7YU8ekbu5/oDkGtF++xjPMZWUB+p/nvgZ0EXDgVK6g2JTb
	714SaAxtHhX6vDdb5CSfqcPN3YEFRtYnY/0O62W0vmBvNRDC4eqiz8LIRFZQTbo2
	sln7+0b3q2gmfNnLJIoX9g+jNTL1cDpGRzrxIhjygesdaPFRCRAMrNGt3uV6ysdf
	3jLGkZKMBvmQ8jwjkK25tWMx3csdi9a+2xD05fU3d+YsFOGsX4zCtkwW6ueX6FOw
	Uq+bIzPiJz4sFdZlYF5lWnyGMaCeR1TyrNVFWYmtrVhu2op0+Oj1OeDR06VoULlt
	fizueA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxf3bhqsd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 07:41:35 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-352c7924ebcso4865552a91.3
        for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 23:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769499694; x=1770104494; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7dprmke1Nl4vM405OVGCjKPKs6FWp844yoaeNutzCxs=;
        b=NlhtrtUgStDzhl8rEi7m882/SajMlyxHSLGJuvf5LVAkIW9EbVEGcJxWkLIeNgg20Y
         o5xMNtwjqsAq79HA13nf1gFRaU5+6cvLA+swkwQku9GGMNmMI1VUVgxdlY1B5J184iDt
         WlciD0Ivg0fRJ7n3IX94QDQa8pMwMdxIo7jte0qNvngtH24XgiuYd7j+ZFO5JnGrflX3
         dNfL7v2yeUbszhh3KCFVqZQNhnPAPSJoeu3CAf6YjrIMQDGrtH21owcsnF8L79rt7yUH
         ej1Mwn13+N/BmQrHvEsXphS6gh5dZ+5fFqlv8HWSInt5AFgAYjihs2EomADO5PxgBCuq
         ejXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769499694; x=1770104494;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7dprmke1Nl4vM405OVGCjKPKs6FWp844yoaeNutzCxs=;
        b=gRf+zFF6amJdCom2Yp3GluuJjmxqARwyiTUFDMDg7KVHTX8lJDmE73F8btz/g24b12
         B8rOOLmJpXL2tkMIrSyWdwpKclu/c7S0rNiz2zK8HmqwAXTx2nJL6MsMyH+vZnlLewW8
         bm0E0aoOA81kfAt6vJ/pUjIH8NGF1/aGgs8+bzak3lX8gasrp+eVJk/LvHD+XrPTmDI1
         RczV/QHHyQezpG/lTlRVCdlez0eHh9NMA1Z7LaU2P2ssAIiYFHYu7pYAMNDIMvSv2EKw
         q8GgYsSi1qKhTGHKgx511BKyX58rzxPZU2rFu5IzJEnwzxMvhTKLYoHWNm68t6zfpQXF
         oPUA==
X-Forwarded-Encrypted: i=1; AJvYcCVc/xxeIav5ilcjjKHScSA/Mx0vH/uWs9qUYp2uofuxhFbyUr9eUwDhEcHsS82gdTRJpsyTNgxMI1oDK9jqNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZeqUv78wKf7sdH777bvqFgN8QX0G5U2KVl4W+tDyIGU5anUon
	4CXbvkLEBXRLWIsjlsbJXXdQ+o1iQQlEMJ/6extMX6lSniqnwHdJIq7odujYpZbNSI3RVwHUlP6
	35Dg46yPdw1Snjog26LSxROMRFhp7RkK3N//8mG3imTVxmbA7h86IEehYyE5I5Bddl6JAIw==
X-Gm-Gg: AZuq6aIpeknbTkZahWp3ug+Gb/kMdgkd/3FaKffR8QmtkV3M+Zj47ggz8+uWdko1xFO
	U/hAeuFOhYfNn+Jd5gIjJR+k8pwN9yyQxMhHFoXuIR6YFg0/mt9BB6HOmOqcn5wNDIu6aIe1h47
	Tzz/VQqgplslGfqL3gHwYlNpn9srXNj23uuH+jp0AuIWe9mpHQrg3K3lpWN5FZ8r5sBmmdcbzrO
	ONvccMohDcfBNjCEJ6slyNkDpIjAHcg/ath9lmINbtKl5YQzbdMyG2uUsB36j/eU+fkzy8EUKtV
	GCKN3J/5NSpDDqFthNKlpBT7A6r0RuFl8E0BUjBoplULr9dBHIzoxUsW8PPZO3OCVp1Bf99dFYd
	vaz5H2jAwFsHPQtFDcB0sBxz3VYTAi7Qujz3rtuzrpyVxCluhFXyYl6Q78I5wO1buUQChGoI=
X-Received: by 2002:a17:90b:3b85:b0:340:2a3a:71b7 with SMTP id 98e67ed59e1d1-353fecd6236mr1040410a91.12.1769499694417;
        Mon, 26 Jan 2026 23:41:34 -0800 (PST)
X-Received: by 2002:a17:90b:3b85:b0:340:2a3a:71b7 with SMTP id 98e67ed59e1d1-353fecd6236mr1040396a91.12.1769499693931;
        Mon, 26 Jan 2026 23:41:33 -0800 (PST)
Received: from [10.133.33.215] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353f6102679sm1566430a91.3.2026.01.26.23.41.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 23:41:33 -0800 (PST)
Message-ID: <45061c9a-6f01-4228-9737-0222b4b49059@oss.qualcomm.com>
Date: Tue, 27 Jan 2026 15:41:09 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] wifi: ath12k: Remove frequency range filtering for
 single-phy devices
To: Saikiran B <bjsaikiran@gmail.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        kvalo@kernel.org
References: <20260126095244.113301-1-bjsaikiran@gmail.com>
 <20260126095244.113301-2-bjsaikiran@gmail.com>
 <776ae681-9db7-4051-abe1-07530f87d485@oss.qualcomm.com>
 <CAAFDt1sgAC6bHOVtELmcQVx=L1dTXDsQFtO+N3R_C2C35VOxhA@mail.gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAAFDt1sgAC6bHOVtELmcQVx=L1dTXDsQFtO+N3R_C2C35VOxhA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ljhZillU7Acs_9KHH3M5gyuN7ysG_15A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDA2MSBTYWx0ZWRfX3FvelPsN0qcJ
 UZ0SlHHsYqn289UcqVY1doDqtbcQyzgPbPw9ZaTgXYvHD3iYoYMSM82sxaDcLecFAl3bZvfKD3M
 o9s9yXXJfFVSlEHr4iZWJCkPmvb+MjCnYmnpdtLNSJwkbA/BFAxYYxTYcNC6io0hh9wlFX7bFDs
 dITYnYBJMEna2TXjzhX6hbZfJas8gQetUOkKmwzk2YSmVLpQiQgwj4QJGhS/jo6G3vtno0PQH1+
 aM9fcVIMHgRnKoPLQCLjrvcWf37nOBs/Q4WG0D/ftn/uH/snDf1R7meKfnKRNm3bdT0zlnHrlw7
 pKYc++ZRXc75HD2lGLfflLcRPBAN+AKYkm7OZ/qxs0A3s27xD47yJSI2fQ8T6cf2JajyAozdFQI
 /bOcJ2/uIYWxCqPL/98HUAkphbM/IkLART/vJDb5jxskQFaBIZFviOd3zZmXaujXC6xrPCu4OuN
 AXAoPwgIxhefD69U65Q==
X-Proofpoint-GUID: ljhZillU7Acs_9KHH3M5gyuN7ysG_15A
X-Authority-Analysis: v=2.4 cv=AOFXvqQI c=1 sm=1 tr=0 ts=69786c2f cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=yaoEV0eubIWe5B8FoUsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_01,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270061
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31203-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 16BD490C95
X-Rspamd-Action: no action



On 1/27/2026 12:04 PM, Saikiran B wrote:
> Hi Baochen,
> 
> I checked the logs again.
> 
> The issue seems to be coming from how
> [ath12k_regd_update()](drivers/net/wireless/ath/ath12k/reg.c) handles
> frequency range updates for this device. WCN7850 is a single-phy
> device (single [ar](drivers/net/wireless/ath/ath12k/mac.c) that
> supports both 2.4GHz and 5GHz/6GHz.
> 
> In ath12k_regd_update():
> 
> 1. It updates the range for 2GHz capabilities (sets range to ~2.4GHz).
> 2. It then attempts to update for 5GHz capabilities.
> 3. Because `ar->supports_6ghz` is true, it uses the 6GHz path logic.
> 4. However, `ab->reg_freq_6ghz` appears to be uninitialized/invalid at

Hmm, this seems like a known firmware bug. Are you using the latest board-2.bin? please
share md5sum of your firmware binaries under /lib/firmware/ath12k/WCN7850/hw2.0

If you are using the latest, please help collect verbose ath12k dmesg log:

modprobe ath12k debug_mask=0xffffffff
modprobe ath12k_wifi7

> this stage (possibly due to regulatory init timing or country code
> issues, On Lenovo Yoga Slim 7x, SMBIOS does not seem to provide a
> valid country code. The driver attempts to set an invalid country code
> which the firmware rejects. This inturn triggers this issue. Fixing
> SMBIOS parsing/defaults is a separate, complex issue that varies by
> vendor.), causing the 5GHz range update to be skipped or invalid.
> 
> [ 11.699027] ath12k_pci 0004:01:00.0: Failed to set the requested
> Country regulatory setting
> [ 31.111995] ath12k_pci 0004:01:00.0: Failed to set the requested
> Country regulatory setting
> 
> As a result, `ar->freq_range` remains effectively set for only the 2.4GHz band.
> 
> When ath12k_reg_update_chan_list() runs:
> 
> It compares 5GHz channels (e.g., 5180 MHz) against a
> [freq_range](drivers/net/wireless/ath/ath12k/reg.c) that only covers
> 2.4GHz.
> Result: `center_freq > end_freq` is TRUE -> Channel is filtered out.
> 
> The filtering logic added in acc152f9be20 works for split-phy topology
> where each host ar covers a specific range. For WCN7850, where a
> single host ar covers disjoint bands (2.4G + 5G), [freq_range] but
> [freq_range](drivers/net/wireless/ath/ath12k/reg.c) (start/end) cannot
> represent multiple disjoint bands at the same time.
> 
> Removing this driver-level filter allows the firmware (which knows the
> true capabilities) to handle the channel list correctly.
> 
> Thanks & Regards,
> Saikiran
> 
> On Tue, Jan 27, 2026 at 8:52 AM Baochen Qiang
> <baochen.qiang@oss.qualcomm.com> wrote:
>>
>>
>>
>> On 1/26/2026 5:52 PM, Saikiran wrote:
>>> The frequency range filtering added in commit acc152f9be20 was designed
>>> for split-phy devices where multiple radios with overlapping frequency
>>> ranges within the same band are combined into a single wiphy. Each radio
>>> in such setups handles only a subset of channels within a band (e.g., two
>>> 5GHz radios covering 5GHz-low and 5GHz-high separately).
>>>
>>> However, this filtering breaks single-phy devices like WCN7850 that use
>>> a single radio to handle both 2.4GHz and 5GHz bands. On these devices,
>>
>> To be accurate, WCN7850 still gets two phys in hardware, it is just in host that we treat
>> it as single.
>>
>>> the freq_range is set to cover the entire supported spectrum, but the
>>
>> exactly
>>
>>> filtering logic incorrectly restricts channels, causing 5GHz to become
>>> completely unusable.
>>
>> how? what are the actual values of freq_range when you hit the issue and how are they
>> calculated?
>>
>>>
>>> The issue manifests as:
>>> - All 5GHz channels filtered out during channel list updates
>>> - No 5GHz SSIDs visible in scans
>>> - Only 2.4GHz networks functional
>>>
>>> Remove the frequency range filtering entirely and rely on the firmware
>>> to handle frequency restrictions based on actual hardware capabilities.
>>> This approach works correctly for both split-phy and single-phy devices,
>>> as the firmware has complete knowledge of what the hardware supports.
>>>
>>> Fixes: acc152f9be20 ("wifi: ath12k: combine channel list for split-phy devices in single-wiphy")
>>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302 (Lenovo Yoga Slim 7x)
>>> Signed-off-by: Saikiran <bjsaikiran@gmail.com>
>>> ---
>>>  drivers/net/wireless/ath/ath12k/reg.c | 13 -------------
>>>  1 file changed, 13 deletions(-)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
>>> index 7898f6981e5a..48c362a86524 100644
>>> --- a/drivers/net/wireless/ath/ath12k/reg.c
>>> +++ b/drivers/net/wireless/ath/ath12k/reg.c
>>> @@ -153,12 +153,6 @@ int ath12k_reg_update_chan_list(struct ath12k *ar, bool wait)
>>>                       if (bands[band]->channels[i].flags &
>>>                           IEEE80211_CHAN_DISABLED)
>>>                               continue;
>>> -                     /* Skip Channels that are not in current radio's range */
>>> -                     if (bands[band]->channels[i].center_freq <
>>> -                         KHZ_TO_MHZ(ar->freq_range.start_freq) ||
>>> -                         bands[band]->channels[i].center_freq >
>>> -                         KHZ_TO_MHZ(ar->freq_range.end_freq))
>>> -                             continue;
>>>
>>>                       num_channels++;
>>>               }
>>> @@ -190,13 +184,6 @@ int ath12k_reg_update_chan_list(struct ath12k *ar, bool wait)
>>>                       if (channel->flags & IEEE80211_CHAN_DISABLED)
>>>                               continue;
>>>
>>> -                     /* Skip Channels that are not in current radio's range */
>>> -                     if (bands[band]->channels[i].center_freq <
>>> -                         KHZ_TO_MHZ(ar->freq_range.start_freq) ||
>>> -                         bands[band]->channels[i].center_freq >
>>> -                         KHZ_TO_MHZ(ar->freq_range.end_freq))
>>> -                             continue;
>>> -
>>>                       /* TODO: Set to true/false based on some condition? */
>>>                       ch->allow_ht = true;
>>>                       ch->allow_vht = true;
>>


