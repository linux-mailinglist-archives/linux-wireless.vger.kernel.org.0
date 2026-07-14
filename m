Return-Path: <linux-wireless+bounces-39007-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L6U7HN3QVWqKtwAAu9opvQ
	(envelope-from <linux-wireless+bounces-39007-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 08:02:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC817514D0
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 08:02:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=GO+l+c1T;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=LH+FPDia;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39007-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39007-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E92493027941
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 06:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FA2277007;
	Tue, 14 Jul 2026 06:02:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901EF32B9BB
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 06:02:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784008921; cv=none; b=VJN46S+Tm4PjkuJv+ZC9zBS/P7eG50wfo4uRqf60ZDRhllz2uEpQlkXxj9gw1ACGWl718laaaS98vafXR7EXLUnQZ7yRAN/ofWYg8QCcoU+BLqpob3Xse1YLYjOGUkij1aSINuNvH9rPiw1Riab57WpApEEStBvr8qTq9J5u9Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784008921; c=relaxed/simple;
	bh=wDWaai8yJCbTa/COBidR5btKs2lTR9S2ckjzWh/3fE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e7PxwxSWAnVGRIkhtwaTyapeHHawJ0tykVHW7QBPcr9BabrBTt4OEG80KEX3ZpxdHKZjIJvtUIyhh0BThAYhunr8UMXBQ6Wk64kBGuUfQ5/SK9fBIzTfs/pW69surkeEs2JIlfsbE1d7dUB+22rkWgCPkmdgohrgRhhu06J+fxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GO+l+c1T; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LH+FPDia; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E5DGh73455190
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 06:02:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uqdY7PSSSS4ZGhySIQZJ51G4ViXVIfD1CbsOVr1wluE=; b=GO+l+c1T/CIgHklN
	HZlTaPaYsRM7OP1t2yADVAw+6SgnDHC6cqKj/GCo4vjOxyQHDptt4UyuWgtJqvbF
	abKeAdyaNiC+kod9JCULvSvlMf03zrnna764U4ol1/yGBiEYLg99mGhY/LPod9Mo
	JpU+Eu3h39XUoKQUqS/ZZpuQ4wzlxEAWMQWB4Oq+4HQSl8um2Sz59ixiDEHtkeNU
	Aa2UBUoc2bPLnIxHwSAgZoDWtluyDHN9vfBoLcjPpfu9IUr6K4o4vbLY/TGWPvaO
	o9R86YNDlCKfevniRUFfU6gqDLlS6gz7nSziuZ0av7fEbU+cikU3jWvbCJDU00Hn
	HS579Q==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdesa85a3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 06:01:59 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c9151bf6ce7so4616696a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 23:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784008919; x=1784613719; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uqdY7PSSSS4ZGhySIQZJ51G4ViXVIfD1CbsOVr1wluE=;
        b=LH+FPDiapXrTdxAuCkFekLfVyvVhlhqBSH7vKoEOUIPH5TQdFsUG+BfDLDixIBsBhK
         NslBv/C5DnnViN7wNEOXlZil+GeYWA28NfnPqmaBuumoPNukzripTNA2KK37YSRIIBFZ
         RUI7UGbOz0sZWejWmOspct3usaIQkAoiobAQMK1VTHr/4gzltKWDzKMZgPrXn6hnEA+9
         v/wxIL1ldewnBG/jMGrx2JqrDILkeuX42yhW2b28jCL6WV+cEkmUuXFKVk4nZW6oXdRp
         EZU1+0TrZh2qoqFp6IGqAf/wWH0o5YsBeBxRxuthTXHVZZPbWBvVqMEu8WmgBWRKkUrk
         JuXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784008919; x=1784613719;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uqdY7PSSSS4ZGhySIQZJ51G4ViXVIfD1CbsOVr1wluE=;
        b=q1B+EFBxtTVGm13s5bqVOVL+AJTdHPMeZnmjqxMdiQ6IcpI1n3voMxQq+738m1VPci
         sfiOVdK9HaQmf3IAfeoRwWUqxdmlK5coZG5z5YoY381ofvaO2JPST6vGTN8sx/VrSuL3
         QgHrPejZWoKuxgicbGp9l/T6vv3SBKBtc9HnqHwoP6A0zjxUu81mmEzTsnFcmjPz3WQz
         Busu4l1zKm+24nUwaklXxQyLF4383DOMa8TT0HYyYEX9PSrGoYtJkxQI4cDdnAzGllDw
         F3yKDpToQWfcD8aIoknV0KJ2Bnzs4Wn20/szVzqiSJUxZvXWYMm9woIRuMwP7qkcLTuP
         zwwA==
X-Forwarded-Encrypted: i=1; AHgh+Rq4tuCY5UYCi2w2RZrg3Ey/mELZCMjkJ4eOyDu+GPRJC/QTL39r+6/kQezL3gxyu+20e7QoEMByiU6sP2Aw5A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8yt6hYFca6SArGE7u2BpZNsQmb9UO0PEu60UzSqGyE2mOTS2G
	AzU8Q/GkAmqUqB6bcMJ3XgzO5NZGVtJt8sX+LBOKOCYye64BaIpEzWvWUopSiu+kecwLEAZA1BU
	m4rp/wq+uphGIz8IG1W1POiGUcgk8gAq85cfSNUDBYMf1IcCcBljtT1Pu84GwGHnSQqiMuQ==
X-Gm-Gg: AfdE7cmHCS6mcWU2OldO+xtHXn9k0aHg8+cXY4fey6FI6/z5MYcjdFAfJ/JwTFFK3Ux
	0ekRRimbtOqwOof3SZGMIlNtmX9wTNBAKFtp9gQ2uQFE7AHNYHPdlaGzXfc0p+GVwWZFfM8orVE
	D73TFrbble9ROoEU3q5FlZNmus146ltRPSxrB4AcEDN9/jcTOwWIXCna0gXFJKnHvsjBZ8DdJ2D
	jA/VK2Gof5T57dCOU9OCJvDm1Iz9ZdLsf5ADsk/CftPCUgGPCA48l6gpfGj9E+AguFIw3LLUsuM
	VC9FzxRNOV7klbqAZTXhorrA/Iu95ewXk4Xwm7T3e/IqeAGjrFdXeWPR3BDGhAqN/p2PKYYj2TL
	USe300dd5cCVqZfQNs3SgCuB8SHOBQche87YbXNj1s10=
X-Received: by 2002:a05:6a20:4324:b0:3b4:b340:411d with SMTP id adf61e73a8af0-3c35738f69bmr1286702637.24.1784008918952;
        Mon, 13 Jul 2026 23:01:58 -0700 (PDT)
X-Received: by 2002:a05:6a20:4324:b0:3b4:b340:411d with SMTP id adf61e73a8af0-3c35738f69bmr1286651637.24.1784008918447;
        Mon, 13 Jul 2026 23:01:58 -0700 (PDT)
Received: from [10.206.105.147] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311935fd091sm54375078eec.24.2026.07.13.23.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 23:01:57 -0700 (PDT)
Message-ID: <5703dd0b-b2b8-4652-985b-a1034ef936d2@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 11:31:54 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v2] wifi: cfg80211: fix regulatory.db async
 firmware request blocking __usermodehelper_disable()
To: Carlos Llamas <cmllamas@google.com>
Cc: johannes@sipsolutions.net, linux-wireless@vger.kernel.org
References: <20260629063159.3288957-1-kavita.kavita@oss.qualcomm.com>
 <akP0mRFucE7p_P-S@google.com> <akQDnwSpBb-yTuLA@google.com>
Content-Language: en-US
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
In-Reply-To: <akQDnwSpBb-yTuLA@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA2MCBTYWx0ZWRfX+oapBOVPP1J0
 IS1lKocTlhpPnmy4HO/blxisdSA3CUbZGFJFVMA3GheZF9ZwyrEpVq7YS1diptYku+lbIdulOqp
 FxO65xAYznGJ0wPAW/DCCk06ESAyIQQ=
X-Proofpoint-GUID: M2lnzDeFn0XPoI4woe7JYrsLn-kdWNYI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA2MCBTYWx0ZWRfX3R5ej2aqHCWU
 DziVimcQ/pdIfQid+lOxqism9Z+TTO3/hFMdNfyzL8aSgrgTxSSrd+xMvW7h8XgnNmBnt39yEcj
 SHTzNnk/MEC6jvgcdY0x083/lpHgc7PyZnvdfzoydX6ki1UW1LiMyNx/xJ80E324m+kYg66CJba
 hraNkjEeg1Rf2717olKTU9UcWY2DkiUm0xDsT6W5VpoXCGxEFadYUdoC00jCgW3Vc+0F3vuofEg
 +XaK8BE/U8sdW/Uz6NoqaCcRrWOwGcwoLXRrRYeMF4bvu+U3cufbDxw5c28I0btVwsyd5T624RI
 tBjKV5nOK/CGRzQtR4XH9vjkmP3GdvYOuT1TKqB/GoxrwbtcSCTM3KAUXnO/93aGYSnJPjIIwLx
 efV8UZI1+ucJSOX4Ad9eIktqiClY7vemUWEvYd/8SWJ2D9NlGBs/6IIWb/GnQTx0f3q9uxuM0ei
 KYGqDlgC4xRZMherG7Q==
X-Authority-Analysis: v=2.4 cv=PZLPQChd c=1 sm=1 tr=0 ts=6a55d0d7 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=CfLPBamFCx2JcwExTSoA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: M2lnzDeFn0XPoI4woe7JYrsLn-kdWNYI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140060
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-39007-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kavita.kavita@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:cmllamas@google.com,m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kavita.kavita@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DCC817514D0



On 6/30/2026 11:27 PM, Carlos Llamas wrote:
> On Tue, Jun 30, 2026 at 04:53:45PM +0000, Carlos Llamas wrote:
>> On Mon, Jun 29, 2026 at 12:01:59PM +0530, Kavita Kavita wrote:
>>> cfg80211 schedules an asynchronous request_firmware() work item for
>>> regulatory.db via request_firmware_work_func(). When the direct
>>> firmware load fails, _request_firmware() falls back to the sysfs
>>> fallback path via firmware_fallback_sysfs(), which blocks indefinitely
>>> in wait_for_completion_killable_timeout() waiting for userspace to
>>> supply the firmware through the sysfs interface.
>>>
>>> While this work item is pending, any caller of
>>> __usermodehelper_disable() will deadlock attempting to acquire the
>>> usermodehelper rwsem for writing, since the sysfs firmware fallback
>>> path holds the rwsem for reading and is blocked waiting for userspace
>>> response that can never arrive while usermode helpers are being
>>> disabled.
>>>
>>> Observed call traces where system suspend blocked due to regulatory.db
>>> async firmware request:
>>>
>>>   kworker/6:3 (pid 194) holding usermodehelper rwsem read lock, blocked
>>>    waiting for userspace firmware response:
>>>      wait_for_completion_killable_timeout+0x48
>>>      firmware_fallback_sysfs+0x270
>>>      _request_firmware+0x790
>>>      request_firmware_work_func+0x44
>>>      process_one_work[jt]+0x59c
>>>      worker_thread+0x260
>>>      kthread+0x150
>>>      ret_from_fork+0x10
>>>
>>>   Caller blocked in __usermodehelper_disable() during system suspend:
>>>      rwsem_down_write_slowpath+0x768
>>>      down_write+0x98
>>>      __usermodehelper_disable+0x3c
>>>      freeze_processes+0x18
>>>      pm_suspend+0x320
>>>      state_store+0x104
>>>      kernfs_fop_write_iter[jt]+0x168
>>>      vfs_write+0x270
>>>      ksys_write+0x78
>>>
>>> Any service or kernel subsystem invoking __usermodehelper_disable() is
>>> susceptible to this hang as long as the regulatory.db sysfs fallback
>>> request remains outstanding.
>>>
>>> Fix this by replacing the unconditional uevent-based load with a
>>> two-step approach. First, attempt a synchronous load via
>>> request_firmware_direct() at init time. This is fast and
>>> non-blocking, if the file is present in standard paths it is loaded
>>> immediately with no delay. If not found, the load is deferred to
>>> wiphy_regulatory_register() and triggered via
>>> firmware_request_nowait_nowarn() only when the first non-self-managed
>>> wiphy registers.
>>>
>>> For self-managed drivers (REGULATORY_WIPHY_SELF_MANAGED), the hang is
>>> avoided because wiphy_regulatory_register() handles them separately
>>> and the deferred load path is never reached, so the file load is not
>>> attempted at all. For this case, regulatory information is obtained
>>> from driver/firmware during wiphy registration. For non-self-managed
>>> drivers, the file is required and is expected to be present. The
>>> deferred load via firmware_request_nowait_nowarn() is triggered only
>>> when the first such wiphy registers. This ensures the database is
>>> loaded only when it is actually needed, avoiding the sysfs fallback
>>> path on systems where the file is absent at init time.
>>>
>>> Also refactor regdb_fw_cb() into two functions: regdb_load() which
>>> validates and stores the firmware image, and regdb_fw_cb_restore()
>>> which is the async callback that calls restore_regulatory_settings()
>>> to replay all pending regulatory requests (country hints from core,
>>> user, driver and country IE) that arrived while the database was not
>>> yet available.
>>>
>>> NOTE:
>>> This issue was observed on Android platforms where regulatory.db is
>>> absent.
>>> Steps to reproduce on Android platforms:
>>>   1. Power off the device completely.
>>>   2. Connect the charger; the device enters off-mode charging.
>>>   3. While in off-mode charging, short press the power key.
>>
>> Can you confirm that you see this with !FW_LOADER_USER_HELPER_FALLBACK?
>> IIUC, this is disabled in Android and shouldn't trigger this path?



Yes, FW_LOADER_USER_HELPER_FALLBACK is disabled by default. However, on our
platforms, force_sysfs_fallback is explicitly set to 1 through a vendor init script,
which causes the udev fallback path to be used.


> 
> Also, you mentioned this happend while on "off-mode charging". So maybe
> don't set force_sysfs_fallback and attempt to load cfg8011 module here?




Well, this is one workaround. However, we cannot simply disable force_sysfs_fallback.
It is required for our firmware loading use cases in both off-mode charging and
normal boot modes.

The main purpose of this patch is to avoid attempting to load regulatory.db when
it is not needed.


> 
> Anyway, this is orthogonal to this patch. It seems that holding the lock
> (read) with a long timeout (60sec?) _and_ trigger a suspend right after
> will fall under this trap as you mentioned. It seems a fairly easy thing
> to reproduce on vanilla distros I would think?



Yes, the issue is easy to reproduce. However, we have not tested it on vanilla
distros.



> 
> --
> Carlos Llamas


