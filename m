Return-Path: <linux-wireless+bounces-31217-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEW5BdaSeGmxrAEAu9opvQ
	(envelope-from <linux-wireless+bounces-31217-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 11:26:30 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6590192C49
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 11:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A89530692F0
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 10:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE12433CE91;
	Tue, 27 Jan 2026 10:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LCOHFv4s";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bpeLitmF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BAC33A9F5
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 10:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769509322; cv=none; b=Tz5uoE8k2xjd9ofnuTnrIOuuGU7gZjmg5j+XeTSgvBXpSs3SW3xPKkss6L5vUewe+LgUJTp4m5dMyJU7eIek37q2p37LeuMtmFqtfj5EfpRqpiGq6zlQL5ebb8jCMH8PvxLscl0FIdRpSo6Dm86pwpTHWp+JfvYHhBgAJub9/Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769509322; c=relaxed/simple;
	bh=Vj0rktrIFymbID/ps7+3WRw7Z8XGwO+Zh9i7OmGOrNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JPEr7iZeeD0g9GEm7FLqoPbh/vCzYphvotOPGB7wNwDDi5VCbRFyPkZ9GlBGRrPUWBezT0nfIU/bsGly0FEYeynFZdix+nUPlWm8QrpV8No8kld//ceIxG8fzFjQ9vfYnKPqrtUzld7nzRJA06DCJz6mhMTzjXcsCpDk0JWofYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LCOHFv4s; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bpeLitmF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60R4UPlX185217
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 10:22:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Qmsmh2t6G90Bz/lts6CDSJg+tdpDYEK6R8xt5FrdQIU=; b=LCOHFv4srlxzFGCE
	vfq3MABVaYWAnhVLCyqTWcwMNX3Ub9Y0Zo7JLTBvizvjVA+kNuitzdR3Jwd8KJxP
	4LHOZSdsq65XLv2vfkBxNpxxZuk+hD5NpmMzYyhKsv33BiLVfDyZQoE3/6KF5Qza
	OBf1rgMXqgefBVOXqyVEAyx5JLvwIm2tuKJmD02byY8y8RyTQPJ07JnXGe3HO8Dm
	uvnxphtVme1+u+2+btm2CJhydIgVXvJmDSocw+ENy5dPyz8dNEG4GVbWPBnAADkd
	2N5mdah+seniGiv4IcQ6ma38RWcVRjDmbzukhMmqtDU5gy5e5JgiHCxvREnuiQie
	g+W8dg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxdv9jng6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 10:21:59 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-352c7924ebcso4992868a91.3
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 02:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769509319; x=1770114119; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qmsmh2t6G90Bz/lts6CDSJg+tdpDYEK6R8xt5FrdQIU=;
        b=bpeLitmF1tRJrterSQiRjMyji0y68rF82i1mfhIg/br1hgHaHivZX8zTPqLXHV/e8k
         /94vwWqaYw7HLJvWyIDIKzHit5cBVcxpPEnQHTClSDvoLPqSM9w5D9jQAyLEHidCZyR2
         OSKHqFZG4m2w6uHnlyjU9soDd1itCxQkDl8j3j9oTd99OhXj824SfFWZ8WhzEPUTJ1xP
         iBNbFs83cHax4lubR2s0bshSTwLsDydq0/btYTL4+ySiX9mfTbKbyjyJIM5e1Lgc3p1W
         hCZkWsp1cXVdWESVqp0mMl0QYj3AvaGsHLC/xiAGD0MIvBK/ZsZCqKGX2N1UOjfDfRrs
         6UGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769509319; x=1770114119;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qmsmh2t6G90Bz/lts6CDSJg+tdpDYEK6R8xt5FrdQIU=;
        b=AmmHZYwvbX9WqIkDaRzsEvpZ1Mame/ky9Z35FMJGnCoylIaljQ8s/enMtA3NR1FdCg
         OyupvWqlrN9lCMaEkQDBs5JyMskx5ADMoZt39byVvaquEYBmuaywQlmo2cItC4Tmlh5N
         3VIfvFKHQ/bL7svG8E1g598E77GEMvB8aIvbZP5uF4iyoYKDE1TrjK/jPmEktYRBAkVx
         uw/Q7r59W6YYkyqZ63sRxCfIU0oznXUHpgw5M7EvHZU2OKurKVYwOjZRVh5D9MPkDthn
         g2GK920y0YwFVKpVV3G2JHmPxtyTzsIq2VWBaWGT0HbaSvLyyE6LJsQZFDAFzYnmOOc9
         DDgg==
X-Forwarded-Encrypted: i=1; AJvYcCXWnzQ9gvCwCNeq32YyjLwblEkEBs7SMOnGZByeWkmoAKY/W0RY/XXy7Yw9ZOUDMMFcJL7ar7g+oNLDoHDLTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3oBkyIqYkS1gopKmJayEL3VmDBNjCWKmv9Cf+swyaVrU59p7B
	svsEG2fB/QUj1TVc3wp24MJ9zQ3gc1jb0p2n9sPaOWB5OVwC0LNaYQzcviC8vxvnLjYKtjREUuI
	TEUcgoICbcgzisOdEFyq1hIpEoa2Q1YgEVI7cKO8UDgWVwSe9tXrjrjGNfuedGQn4HYW77A==
X-Gm-Gg: AZuq6aLX1yDaUsTxh/qtzPSLD4GuFUJKO0OiLUrC1H77//ue23L8Pn6kWwCIm2UhsEK
	tCLPxDBvgZy70Q+FVsOWmmH2vMuEY5kc+FhNcoGbr9+Eef2wgIdimB0a8VGJ2kWhutEAFQknnfA
	/CaLBBZ5cBEGA/u/iWgBDG26RHH55YyesUxAiNKSehHMuaJGxQa1vWCQ3zevHpXkSFqzjh2pjZf
	NZVO4JfpUWse5TPm53FgDyMOO6CwtUsAKajusV7xIgAx3BzrBacxwdbatkBD6TjCBledRv+RYhd
	MkcF4naY+bNiUcyh69Dhkyz2XxXsDwH1aYBJq8bpWlGvgTYknGaSYra09BR5quZbCNeCpy0lxdn
	EgEHcizfknhrRYVYhbpc9IWw5QYcPMMc/o/SrDZd5lwkIK3MJCM/Hg7BkRfXqgXHew6un0c8=
X-Received: by 2002:a17:90b:3b8c:b0:341:88ba:bdd9 with SMTP id 98e67ed59e1d1-353fed870c0mr1048654a91.25.1769509318580;
        Tue, 27 Jan 2026 02:21:58 -0800 (PST)
X-Received: by 2002:a17:90b:3b8c:b0:341:88ba:bdd9 with SMTP id 98e67ed59e1d1-353fed870c0mr1048635a91.25.1769509318046;
        Tue, 27 Jan 2026 02:21:58 -0800 (PST)
Received: from [10.133.33.215] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c635a4135e6sm10445191a12.25.2026.01.27.02.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 02:21:57 -0800 (PST)
Message-ID: <d6910fe4-cd35-4696-9a0e-13904f512ff8@oss.qualcomm.com>
Date: Tue, 27 Jan 2026 18:21:54 +0800
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
 <45061c9a-6f01-4228-9737-0222b4b49059@oss.qualcomm.com>
 <CAAFDt1sdE3Wpp5CByTZmBk=YnQxFhAwmbC5XpYaqYq0Wdx547A@mail.gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAAFDt1sdE3Wpp5CByTZmBk=YnQxFhAwmbC5XpYaqYq0Wdx547A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OYOVzxTY c=1 sm=1 tr=0 ts=697891c7 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=YKakg7jpQT0hG2YQ7QYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: MEW-02vnS8ht8iHacRPZYS_BLTIUPUlg
X-Proofpoint-ORIG-GUID: MEW-02vnS8ht8iHacRPZYS_BLTIUPUlg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDA4NCBTYWx0ZWRfX6vjVlrS9lVFj
 An1UO9hSRQc7oSMmSKzGJUc9S/iLBETQz71UAtL8jBWz3ddjBV9Fz8GqFy3HQ55N6n68wIKMv8X
 l+fzCOtaOltsqesXJN5HNNwNLR1ME9OkQliVV7GVHmKrd6YsPFOAspCinsl71beV86z7GOEtbkL
 6VChf+Zf/3ZNme7x9SCiTFoSutxQz+nmS/Wr1Vq9MzNfKBRuW1JgqtsON54B7MD59urmcNU/C/D
 MEjVduMG5k35tUFsEjQTivNQNqhwdDlGSxf6IMRSmsVMIRRnNrX534cdKLUaO3c6COuopF1C0Ux
 7tanDcengi9ungUTzUhiB/UTiNk7UNGxXACeXQCs/n4rR6Mu3ej2Y/Orzs02k6OHFC5nZZfZPJT
 Jg417Dfg+Tyylw2x4W0OxiB/or/Nq2vLp92V7DZ1gIBJhVJbkkWsLxuaAisAFAuv3DtCrJfiUvr
 e5SSwX/SqXVnkWg0fPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_02,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270084
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31217-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6590192C49
X-Rspamd-Action: no action



On 1/27/2026 4:58 PM, Saikiran B wrote:
> Hi Baochen,
> 
> 1. Here are the MD5 sums from my /lib/firmware/ath12k/WCN7850/hw2.0/
> (sourced from linux-firmware 20250901):

this is a bit old. Please try the latest board-2.bin from linux-firmware repo:


commit 1d588f106ceea113c4c650b43d948da5746e704c
Author: Jeff Johnson <jjohnson@qti.qualcomm.com>
Date:   Thu Sep 18 11:03:58 2025 -0700

    ath12k: WCN7850 hw2.0: update board-2.bin

    Signed-off-by: Jeff Johnson <jjohnson@qti.qualcomm.com>


$ md5sum board-2.bin
74878eeb4ea01b8ea6bd19b57c99d702  board-2.bin


> 
> 2fa9a691f199b25aafce48967d93c85b  amss.bin.zst
> 7cd6eb50e9a6ad98e658a53033214c9e  board-2.bin.zst
> 62c117046e52cb78c922635bea177afe  m3.bin.zst
> 953ba9719c55664a5d91d99b412caee1  Notice.txt.zst
> 
> 2. Logs: I realized CONFIG_ATH12K_DEBUG was disabled in my recent
> build. I am rebuilding the kernel now with the debug mask enabled and
> will provide the verbose logs in a follow-up email once tested.
> 
> 3. Regarding the Frequency Logic: While I gather the logs, I'd like to
> highlight that the issue likely persists regardless of the firmware
> behavior.
> 
> The freq_range filter assumes ar has a single contiguous range (e.g.,
> start=5150, end=5850). For a Single-PHY device like WCN7850 that
> supports disjoint bands (2.4GHz + 5GHz), a single start/end pair
> cannot correctly represent the capabilities.
> 
> If we set it to cover 2.4GHz, it filters 5GHz.
> 
> If we set it to cover both (e.g., 2.4GHz to 7GHz), the filter allows
> everything and becomes redundant.
> 
> I will get back to you shortly with the logs to confirm the firmware state.
> 
> Thanks & Regards,
> Saikiran
> 
> On Tue, Jan 27, 2026 at 1:11 PM Baochen Qiang
> <baochen.qiang@oss.qualcomm.com> wrote:
>>
>>
>>
>> On 1/27/2026 12:04 PM, Saikiran B wrote:
>>> Hi Baochen,
>>>
>>> I checked the logs again.
>>>
>>> The issue seems to be coming from how
>>> [ath12k_regd_update()](drivers/net/wireless/ath/ath12k/reg.c) handles
>>> frequency range updates for this device. WCN7850 is a single-phy
>>> device (single [ar](drivers/net/wireless/ath/ath12k/mac.c) that
>>> supports both 2.4GHz and 5GHz/6GHz.
>>>
>>> In ath12k_regd_update():
>>>
>>> 1. It updates the range for 2GHz capabilities (sets range to ~2.4GHz).
>>> 2. It then attempts to update for 5GHz capabilities.
>>> 3. Because `ar->supports_6ghz` is true, it uses the 6GHz path logic.
>>> 4. However, `ab->reg_freq_6ghz` appears to be uninitialized/invalid at
>>
>> Hmm, this seems like a known firmware bug. Are you using the latest board-2.bin? please
>> share md5sum of your firmware binaries under /lib/firmware/ath12k/WCN7850/hw2.0
>>
>> If you are using the latest, please help collect verbose ath12k dmesg log:
>>
>> modprobe ath12k debug_mask=0xffffffff
>> modprobe ath12k_wifi7
>>
>>> this stage (possibly due to regulatory init timing or country code
>>> issues, On Lenovo Yoga Slim 7x, SMBIOS does not seem to provide a
>>> valid country code. The driver attempts to set an invalid country code
>>> which the firmware rejects. This inturn triggers this issue. Fixing
>>> SMBIOS parsing/defaults is a separate, complex issue that varies by
>>> vendor.), causing the 5GHz range update to be skipped or invalid.
>>>
>>> [ 11.699027] ath12k_pci 0004:01:00.0: Failed to set the requested
>>> Country regulatory setting
>>> [ 31.111995] ath12k_pci 0004:01:00.0: Failed to set the requested
>>> Country regulatory setting
>>>
>>> As a result, `ar->freq_range` remains effectively set for only the 2.4GHz band.
>>>
>>> When ath12k_reg_update_chan_list() runs:
>>>
>>> It compares 5GHz channels (e.g., 5180 MHz) against a
>>> [freq_range](drivers/net/wireless/ath/ath12k/reg.c) that only covers
>>> 2.4GHz.
>>> Result: `center_freq > end_freq` is TRUE -> Channel is filtered out.
>>>
>>> The filtering logic added in acc152f9be20 works for split-phy topology
>>> where each host ar covers a specific range. For WCN7850, where a
>>> single host ar covers disjoint bands (2.4G + 5G), [freq_range] but
>>> [freq_range](drivers/net/wireless/ath/ath12k/reg.c) (start/end) cannot
>>> represent multiple disjoint bands at the same time.
>>>
>>> Removing this driver-level filter allows the firmware (which knows the
>>> true capabilities) to handle the channel list correctly.
>>>
>>> Thanks & Regards,
>>> Saikiran
>>>
>>> On Tue, Jan 27, 2026 at 8:52 AM Baochen Qiang
>>> <baochen.qiang@oss.qualcomm.com> wrote:
>>>>
>>>>
>>>>
>>>> On 1/26/2026 5:52 PM, Saikiran wrote:
>>>>> The frequency range filtering added in commit acc152f9be20 was designed
>>>>> for split-phy devices where multiple radios with overlapping frequency
>>>>> ranges within the same band are combined into a single wiphy. Each radio
>>>>> in such setups handles only a subset of channels within a band (e.g., two
>>>>> 5GHz radios covering 5GHz-low and 5GHz-high separately).
>>>>>
>>>>> However, this filtering breaks single-phy devices like WCN7850 that use
>>>>> a single radio to handle both 2.4GHz and 5GHz bands. On these devices,
>>>>
>>>> To be accurate, WCN7850 still gets two phys in hardware, it is just in host that we treat
>>>> it as single.
>>>>
>>>>> the freq_range is set to cover the entire supported spectrum, but the
>>>>
>>>> exactly
>>>>
>>>>> filtering logic incorrectly restricts channels, causing 5GHz to become
>>>>> completely unusable.
>>>>
>>>> how? what are the actual values of freq_range when you hit the issue and how are they
>>>> calculated?
>>>>
>>>>>
>>>>> The issue manifests as:
>>>>> - All 5GHz channels filtered out during channel list updates
>>>>> - No 5GHz SSIDs visible in scans
>>>>> - Only 2.4GHz networks functional
>>>>>
>>>>> Remove the frequency range filtering entirely and rely on the firmware
>>>>> to handle frequency restrictions based on actual hardware capabilities.
>>>>> This approach works correctly for both split-phy and single-phy devices,
>>>>> as the firmware has complete knowledge of what the hardware supports.
>>>>>
>>>>> Fixes: acc152f9be20 ("wifi: ath12k: combine channel list for split-phy devices in single-wiphy")
>>>>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302 (Lenovo Yoga Slim 7x)
>>>>> Signed-off-by: Saikiran <bjsaikiran@gmail.com>
>>>>> ---
>>>>>  drivers/net/wireless/ath/ath12k/reg.c | 13 -------------
>>>>>  1 file changed, 13 deletions(-)
>>>>>
>>>>> diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
>>>>> index 7898f6981e5a..48c362a86524 100644
>>>>> --- a/drivers/net/wireless/ath/ath12k/reg.c
>>>>> +++ b/drivers/net/wireless/ath/ath12k/reg.c
>>>>> @@ -153,12 +153,6 @@ int ath12k_reg_update_chan_list(struct ath12k *ar, bool wait)
>>>>>                       if (bands[band]->channels[i].flags &
>>>>>                           IEEE80211_CHAN_DISABLED)
>>>>>                               continue;
>>>>> -                     /* Skip Channels that are not in current radio's range */
>>>>> -                     if (bands[band]->channels[i].center_freq <
>>>>> -                         KHZ_TO_MHZ(ar->freq_range.start_freq) ||
>>>>> -                         bands[band]->channels[i].center_freq >
>>>>> -                         KHZ_TO_MHZ(ar->freq_range.end_freq))
>>>>> -                             continue;
>>>>>
>>>>>                       num_channels++;
>>>>>               }
>>>>> @@ -190,13 +184,6 @@ int ath12k_reg_update_chan_list(struct ath12k *ar, bool wait)
>>>>>                       if (channel->flags & IEEE80211_CHAN_DISABLED)
>>>>>                               continue;
>>>>>
>>>>> -                     /* Skip Channels that are not in current radio's range */
>>>>> -                     if (bands[band]->channels[i].center_freq <
>>>>> -                         KHZ_TO_MHZ(ar->freq_range.start_freq) ||
>>>>> -                         bands[band]->channels[i].center_freq >
>>>>> -                         KHZ_TO_MHZ(ar->freq_range.end_freq))
>>>>> -                             continue;
>>>>> -
>>>>>                       /* TODO: Set to true/false based on some condition? */
>>>>>                       ch->allow_ht = true;
>>>>>                       ch->allow_vht = true;
>>>>
>>


