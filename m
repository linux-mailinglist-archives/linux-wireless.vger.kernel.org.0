Return-Path: <linux-wireless+bounces-36352-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4R44J5brA2ruAgIAu9opvQ
	(envelope-from <linux-wireless+bounces-36352-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 05:10:14 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B3D52CA78
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 05:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DAD563002E21
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 03:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C4C3911DD;
	Wed, 13 May 2026 03:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KgX/5LDH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ChryHIMm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F89938E8CB
	for <linux-wireless@vger.kernel.org>; Wed, 13 May 2026 03:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778641514; cv=none; b=QXACOUV5k/F4X/jEFapvKquZyl04hTEdyzO0EADfN4edzK9LPBVrBJ3A5eO7ZUcboJMZQYmfrVxFgVdMayiLjTWxbEa6Ds70Ade9wjq0XNxaNJeCpqOX8ELv0GDzspxUW0O7JCMnKl4jZGBvDlWATWxU5vh7IVJSt490ybsVjds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778641514; c=relaxed/simple;
	bh=R6pEUHcJ8IFBjJuNXvw7AAhpNEZZTdl8vP4QPGHEtYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZsv7+gteNvKQ+D12GCkEVLP6OxwbQrtW+SZhClGKLSBLzrUDVk1JOrpfEUrqUOjO3rpft3ZTF4JzyUMTXr/PBGVgCqGSVaiBldqIoTDdr1Q2CdbK9bGN7ip0kaxY5aeJcfp3FzgnvxWKV91GofABdoDcs1VGTN6yIruW1t+fA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KgX/5LDH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ChryHIMm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D09GqN2525460
	for <linux-wireless@vger.kernel.org>; Wed, 13 May 2026 03:05:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fzFQPURAJd/FHEBgzmUHm+L4cK+hA3UTd6FrIYLfDuc=; b=KgX/5LDHykwivH5q
	RAK/sEIK2SqAJM7TiUXRl8BTN9qXQIkLCaShfmWwpFpoB63R3LsEtl5asoeBoKlQ
	cviN+4FJqCsopMzmMi/+v4OHCLWLMpb0bxZGDta57mrhGLPCFirKRoe10fwI+buf
	d3ueh6w1+Z1Xv+ahR3vUkcfqa7vzUWkV9y/JvxsRYT8nDdQ51XVFtDr26qbd/RvY
	Hkm1ZdmEYEpWAKDOp3N0hiNFhMcc/pps1ag3s/E8GzvP34BVaMe3jelTXmEEj664
	igLFSaRWLk7OfyxU8c9D5I/mnR1PkaQlRExC45LsTu3BftObwqPelVw6NsfmyNCx
	OCjPxA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e42rhuen4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 13 May 2026 03:05:11 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82f74f0e3c6so4217876b3a.0
        for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 20:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778641511; x=1779246311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fzFQPURAJd/FHEBgzmUHm+L4cK+hA3UTd6FrIYLfDuc=;
        b=ChryHIMmPdf65pVIJCsZOypxq2k5h8K4Qm7jDm7SgNqE3F5f+/XNRVA99nHUy/k8vD
         KSwMka2QR1BfkBQfqjMdxG6AMm8Q4jvIpO7NEOyg1lcu2c4x5mgEITuKzmknLPrhj0jD
         1Lwzos0Y8RC1BoVKHHhxRV+YxlV6HaoI0Bg2rxvCVvb4SqzvLdo7StLxyVyjxWcupMsb
         AUPQ4GYQo9qCvz2iB+yxlR+Zxbw7jSkFYSQET5UXNsAgoP9h4gj6+pxPfh3ZM7tQQ7pO
         PX5xj+tFWfSB6Cu4cjjs0RRjKc18qCtZspIjd2w9T4dqRvs3PirGfAsTA8Bwx/YwuoD5
         zNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778641511; x=1779246311;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fzFQPURAJd/FHEBgzmUHm+L4cK+hA3UTd6FrIYLfDuc=;
        b=XGnsrbUbaRSwIstUVQFybmvk7tnvIveLKm6n/kKxUy47tWrtZuii9mix795QyrTWV+
         lnQOmmlfzBkpQUvyTsIJEkQWmf2aNOY8QJIoYDrbmLCa8eN6GuQyh1+rRmTQy+QEv2s1
         a8uEQHMHd0JXn1jd1UYLfhlw3rOEIs7GrvZukxdjrhMne2wSP+Vo0fYxtwmCR8SzKSb0
         UpWkbTIOphEF/D7cxCFiHlX2v7U0aA4l4NlI/OyR42Qt+6jSDZp2KRVQqJmKxtOa5xLJ
         eqUpwxACOvPRCrEzFvq9/fOhGJgg7FGRS1muAxQ+U9AghnCtupusYpVlVF776Ypatd6g
         dQeQ==
X-Forwarded-Encrypted: i=1; AFNElJ+bcwE7qIABIon0Qv6psKncB6+ZFTsuQUQZfCyoSD1GUc3V2BLMmwBnpXS97A7z84PLvT7sozx8Y55zPUtsRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDDyQSnYkZBEZ5o2ISFqELl79q6yYM3D2qVgbnGv3qhkQJLykR
	d1J+aB8fHKGaI/qzFPGt2iow79vDPMORApy5vSAqp03H+wBxe5FV46YBiA/S7HJT5dHFMH1qY8X
	au2MHt/VuNStAVHmQopCdwCqwT51OdWInynsofb4d3jMvz7KdoAtcG1ZDct1sBELOsrxouw==
X-Gm-Gg: Acq92OErB2ep86GZPNCvUKK9YPjhOsDqXBDfg7+kaF44YEdtUA7vAu32CtdsKOhAUAR
	8Db2CG9OapbHdJqriG7Uj19f+pM8gLmwvRwUFf3AHAKHxQoKVHQmUEIMOqHRtW/mjDJ1fs9jHVi
	9ihHsmxSW0XKx3bQPc4r/02eNMb9aM9TWokm+ou6wJZ5ii3zQhIMaz9ZLm0FJiQFyZi7MxKBjJA
	fHufkwBrndQFzg4RulcyXe1rHqTXMKzcW9OHu38T5ZD8PJg90T00MZPE88P5NxLXMg5ZdcabmD4
	DBrY1EB+4tqSDEYsNGGMEihPi05HH17zlxsSZaJXYMWQvZS4J24hYDb+MOj6PBRj19i6HiRbRo4
	XSHgKo1GTnpK1zUHuE5P4embRj77IuC4Ey2YuqBDiG6WyRnVitSGc6TgDBNueycvOu+P/gJFloK
	iIDQG4XFYOTFOOl6iOTww=
X-Received: by 2002:a05:6a00:f0a:b0:83a:4846:90bc with SMTP id d2e1a72fcca58-83f05d755e9mr1009015b3a.48.1778641510852;
        Tue, 12 May 2026 20:05:10 -0700 (PDT)
X-Received: by 2002:a05:6a00:f0a:b0:83a:4846:90bc with SMTP id d2e1a72fcca58-83f05d755e9mr1008961b3a.48.1778641510236;
        Tue, 12 May 2026 20:05:10 -0700 (PDT)
Received: from [10.133.33.178] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839685a8125sm24830728b3a.61.2026.05.12.20.05.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 20:05:09 -0700 (PDT)
Message-ID: <92ace4b9-143e-4962-90fa-215a22e24796@oss.qualcomm.com>
Date: Wed, 13 May 2026 11:05:05 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath12k WCN7850: Q6 Hexagon fault at WLAON region 0x1792000 ~2s
 post-AUTHORIZE on X1E80100
To: Marcus Glocker <marcus@nazgul.ch>, Maxim Storetvedt <m.tvedt@tutanota.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        jjohnson@kernel.org, kvalo@kernel.org,
        manivannan.sadhasivam@linaro.org,
        Mark Kettenis <mark.kettenis@xs4all.nl>
References: <g7dkeq3uwg7eby57zcuu5eysf4tqomh5civlvkpnlziipn6xis@45eevyzgfmaq>
 <0b450204-9afc-4ba1-b9c5-1876b5a7078a@oss.qualcomm.com>
 <tzkh5t3bmiqff67g72rihapizz2u2dlj4xfrr324d6yg4rtltt@3qrsymzw7c2c>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <tzkh5t3bmiqff67g72rihapizz2u2dlj4xfrr324d6yg4rtltt@3qrsymzw7c2c>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDAyNyBTYWx0ZWRfX5FJGaD/RwAgN
 M2yZXml84VgICEKTt3CND5CXdcYbLJ7SSsa4uCEGz2y47OfxmSrR64rMtcZTHJ0zlX9mK4uT9/z
 ehwy85SVUjukuPFFsOYzyG6dkdB525l3/jDiYU4oPPaFs11sxbDXgX5cUNta4cadTgCkXnn0oSc
 2+VHvlXf8uJMONBskGfS/wkX/xRGXRkfWlghAeAIkDWSPfhsnprUOc4zIxOhTM8RL3Fn0YoER7D
 eDdfGp4BR+EqZjc55e7cdFM9rlLKRXq5HX7Jkdvo3zkeBYs8EeitdNmdLUIQwhJ6MdhZKWGFYes
 4S3LP56D+MWbF7UZhqhmbRFBUyDRyqkroCOfSdsLw/QiWurDgwSMC5bFBTWzDobKeFIUYbvr5un
 wCht0cqrTwxJOp0sCp+C3PUm5Utlm2BHnsv4Gucz5UMXN4+MPEPfWeG1casi1/Ao8BwWvq5fPbb
 TsSJJ1VUN0ZLnsLj6Hw==
X-Proofpoint-GUID: zcAaUcRTFRjMXswguHgLdE2EVf8CWW1n
X-Authority-Analysis: v=2.4 cv=GbMnWwXL c=1 sm=1 tr=0 ts=6a03ea67 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=E_MRXsYlAAAA:8 a=uAqAdB2uIG4wdVJIxSAA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=486ROa2Zizi0ivMXnIml:22
X-Proofpoint-ORIG-GUID: zcAaUcRTFRjMXswguHgLdE2EVf8CWW1n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130027
X-Rspamd-Queue-Id: 06B3D52CA78
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nazgul.ch:url,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,kernel.org,linaro.org,xs4all.nl];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36352-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action



On 5/13/2026 3:59 AM, Marcus Glocker wrote:
> On Tue, May 12, 2026 at 11:38:06AM +0800, Baochen Qiang wrote:
> 
>>
>>
>> On 5/5/2026 5:08 AM, Marcus Glocker wrote:
>>> Hi,
>>>
>>> We're porting ath12k to OpenBSD as the qwz(4) driver, targeting Samsung
>>> Galaxy Book4 Edge (X1E80100 SoC, WCN7850 hw2.0).  Scan, auth, 4-way
>>> handshake all complete; ~2 seconds after WPA2 AUTHORIZE the WCN7850
>>> firmware crashes deterministically with:
>>>
>>> 	dlpager_main.c:147 Non Page Fault Exception cause code 0x 23
>>> 	at Address: 0x 1792000
>>>
>>> Cause code 0x23 isn't a valid arm64 exception -- the fault is on the
>>> WCN7850's on-die Hexagon Q6 DSP, with QURT's generic exception handler
>>> (which happens to live in dlpager_main.c) printing it.  So this is not
>>> a host CPU fault.
>>>
>>> Per the RDDM segment table (at the start of the dump), VA 0x01792000
>>> is the start of the chip's WLAON_DUMP region (size 0x820).  The Q6 is
>>> trying to read its own always-on hardware state region and the chip
>>> refuses the access.
>>>
>>> (Samsung, Asus, Honor) with multiple FW builds.  Currently testing
>>> with WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3
>>> (fw 0x110cffff, 2025-06-25) -- the exact blob a Linux ath12k user
>>> runs successfully on the identical Samsung hardware.  Same board-2.bin,
>>> same compiled DTB (upstream hamoa.dtsi based).
>>>
>>> We've field-compared qwz against ath12k and ruled out (byte-level or
>>> wire-level):
>>>
>>>   * QMI host_cap, m3_info, wlan_cfg, wlan_ini, bdf_download (all
>>>     fields including ce_config, svc_to_ce_map, shadow_reg_v3,
>>>     feature_list, m3 paddr/size, nm_modem)
>>>   * MHI bringup ordering (BHI -> wait SBL EE -> wait M0 -> BHIE)
>>>   * BHI/BHIE DMA coherency
>>>   * ASPM disable before MHI start
>>>   * WLAON_WARM_SW_ENTRY zeroing + QFPROM_PWR_CTRL VDD4BLOW clear
>>>   * static_window_map=false + window-bank register init
>>>   * Per-chunk vs monolithic respond_mem allocation
>>>   * WMI_PEER_MIMO_PS_STATE = WMI_PEER_SMPS_PS_NONE (added matching
>>>     ath12k_setup_peer_smps; doesn't help)
>>>   * FW image variation (c5 and c7 both fail identically)
>>>
>>> Specifically NOT involved (we have evidence either way):
>>>
>>>   * Gunyah -- X1E80100 is reportedly run in EL2 without Gunyah by
>>>     users where ath12k works; so Gunyah isn't programming WLAON
>>>     access for the Q6.
>>>   * SMMU / pcie_smmu -- pcie_smmu is status="reserved" upstream,
>>>     pcie4 has no iommus property; PCIe DMA bypasses SMMU.
>>>   * SCM/PAS -- ath12k's PCIe path makes no qcom_scm_* calls.
>>>
>>> Question: what subsystem inside the WCN7850 firmware touches the
>>> WLAON region at 0x01792000 around 2 seconds after the host sends
>>> WMI_PEER_AUTHORIZE?  And what host-side configuration (WMI command,
>>> HTT message, MHI state, etc.) primes that path so the access
>>> succeeds on Linux?
>>>
>>> Even a pointer at the right Linux code path or the right FW-side
>>> component would unblock us.  We have full RDDM dumps and dmesg
>>> captures available; happy to share off-list or as attachments.
>>
>> please help collect ath12k successful dmesg log and qwz failed dmesg log for compare.
>>
>> Please enable verbose ath12k log when loading ath12k driver:
>>
>> If you are using the latest upstream ath12k:
>>
>> 	sudo modprobe ath12k debug_mask=0xffffffff
>> 	sudo modprobe ath12k_wifi7
>>
>> If you are using an old ath12k:
>>
>> 	sudo modprobe ath12k debug_mask=0xffffffff
>>
>>>
>>> Thanks,
>>> Marcus
>>>
>>
> 
> Hi Baochen,
>                                         
> Thanks for coming back on this topic.
>                                         
> Attached the OpenBSD dmesg, with full ath12k driver debug logging

the dmesg shows several WMI_INIT cmd instances which is not expected, because in normal
operation this command should be sent only once.

cat dmesg |grep -w 'sending WMI command 0x1'
May 12 19:35:46 x1e /bsd: qwz_wmi_cmd_send_nowait: sending WMI command 0x1
May 12 19:37:20 x1e /bsd: qwz_wmi_cmd_send_nowait: sending WMI command 0x1
May 12 19:37:41 x1e /bsd: qwz_wmi_cmd_send_nowait: sending WMI command 0x1
May 12 19:37:46 x1e /bsd: qwz_wmi_cmd_send_nowait: sending WMI command 0x1
May 12 19:37:50 x1e /bsd: qwz_wmi_cmd_send_nowait: sending WMI command 0x1

other than that I don't find any other clues.

> enabled, plus the resulting RDDM binary after the firmware crash:

how did you collect the RDDM binary, seems not in the right format, my tool can not parse
it correctly. Looking into the binary, at least the magic 'ATH12K-FW-DUMP' is not present
at the very beginning.

And from which Linux version you take the ath12k codebase?

> 
> https://nazgul.ch/pub/qwz0-rddm.bin.gz
>                                         
> The command sequence on OpenBSD to re-produce that was:
>                                         
> ifconfig qwz0 up                        # Bring the ath12k device up
> ifconfig qwz0 scan                      # Scan for networks
> ifconfig qwz0 nwid nazgul wpakey xxx    # Start association
>                                         
> Hi Max,
>                                         
> Since you have Linux running on exactly the same Samsung Galaxy Book4
> Edge 14" laptop, where ath12k works, would you be so kind and also
> provide the dmesg output showing an successful association with the
> ath12k driver debug logging enabled?  See above how to enable that.
> That would be very helpful!
>                                         
> Thanks and Regards,
> Marcus


