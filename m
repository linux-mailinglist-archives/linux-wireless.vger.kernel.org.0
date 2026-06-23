Return-Path: <linux-wireless+bounces-38001-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YY8ZIEpKOmqq5QcAu9opvQ
	(envelope-from <linux-wireless+bounces-38001-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 10:56:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA066B579A
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 10:56:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=n3ubBrYS;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=X63YfKoC;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38001-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38001-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A7653064058
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 08:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159893CFF68;
	Tue, 23 Jun 2026 08:55:50 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1063CF200
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 08:55:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782204949; cv=none; b=MmjhTpeOmWe6loqIwhuyP/ovfRrXNtAPVX9IqG2UsP8hbBXnGyFj/KWFvb9CAnVMHtX9KBUvSl8fJw9x8AmVt4B+02dZdMBcuFUjmcNQa8SPUZeAoaA73y8V4DAwSmjNHT4eDuhPxkGteV8BJF0BHkyDF3NURr/Qu1kArFh/WgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782204949; c=relaxed/simple;
	bh=qaPg/+DGuSfby7tE/0iKsjpJAJXizhpCe6b2itH015A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CQ+hg2Lzfs/+gPgWIRkI4KryjeBB4pTCvcicS4kDR4xggn0HxhyungVnfOJW0NhaHlWNwRtgdlJV9mzGtx1WU/1OQKN+Eezpqh15X3ipSCt+LIUSbfZPU9pwRin9v7A7mopJ5kWbn6r1XT/qKSNtqbfb3Y3jVNKQwFVHu6rjovI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n3ubBrYS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X63YfKoC; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N6ci413547187
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 08:55:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aE9n3ah0N3qa2cRR38jYXiCfe+bTuewMNN2Ot/1RK5o=; b=n3ubBrYSXQwWXHI+
	gn4nI/HCD2XOGpUVDc68k8FNLl8ckvJt4bupL2cd7rzU1Tin2PLb2rPXEosaEckO
	4G/0VFrJvimVOnmWviT/Szx0CzORjh7dT1ftcG4i6tl4+rD4E0DLG8m50AjpaXMg
	6QDM/OK3nBsZm2jalDsrHNDWxOqGfTbz4XYMUCRZka40YX3x67AEfBkWerBY6nds
	ZDELP9IcbVG2cHuwC53wFSF0RIy7k/vdXmDtkPfiyvYvt1/3+BtCDW/5fTI6Zyzq
	I0O/djCufRrhZ/Y/3VZjYYCatRvbDj4XeueKoJgV3jc5pcigEWnudrY5+w7Rp4DM
	u6gOjg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey3ebcakq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 08:55:47 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c856470fe9fso3644198a12.2
        for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 01:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782204947; x=1782809747; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aE9n3ah0N3qa2cRR38jYXiCfe+bTuewMNN2Ot/1RK5o=;
        b=X63YfKoC26WX2gYZtXzeWZiB6FitbHhltxPkTc2BAFZQdPrSFbC/ByVeoX00SHfRcp
         w6qIy258Rs78+Z4SLmi44HFzCSE/JTK8TeC9J0pVDSU+vv3Y3zV6DZGYlTcX9kEaoSMn
         IHqPAh9x5xPrlgCzNqvmOMcgoyEm+gB73XpRGjooi93Gt7TZx8AghqtsLUzM0YAOBRE2
         X4Itujys4lnFORwQ2hGDeUauEQ7SSAuHcH9NaqcQDKVlSqdUYlF44qQI92PzCR9v7RWC
         LIDmzx70BC7jOxYRLjKx42CRhZgCFy8ncB+CxA1DWtnvfjEhrXKai7qbywHLjLnBqop7
         Y9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782204947; x=1782809747;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aE9n3ah0N3qa2cRR38jYXiCfe+bTuewMNN2Ot/1RK5o=;
        b=DB0UDZuuVzoq9y8Q6it7GbsbTfddFKd93sTTj6KYrXyWUDe9J7rnbCLT4TNGfZwB+m
         44h+tw3w54gyKHPje9RrXM+JOjzWVG1hZ1w8iBv3Dm4cXQp6CuQdBXG44EmU47lzAziV
         3gvAMUv+DxOZtgFIPPwYSCkcVDyoRuA3AxZrbJgWtTO8EbbC9x9QtaPM6N0ExSuhsdcL
         95ybq5lpcVnjJ/PWTz5oeV3uiECSeBPzIR1kOVIaiSL1xSM+HU5nwO8xtqiLByP7hV3p
         6LqiItt0ZHnRnxw3FRjsVShoPrLkyFY9bLRNQCZJV/cz1hWptV9CAELeDGQGQoN/I79Z
         FbUQ==
X-Forwarded-Encrypted: i=1; AFNElJ+9qBH5BneqtDCHKX0p04XZKlgi9cBIIHAdMg0JiVzrugqIp0mS5ipUNRiP7pcg755PYTwtuIMNojSCAybPRg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa0LlOC01sQ8cVChJTrII/gQf/18eZRJ3W6lXSrm7SSJpZ69CS
	ZpJwlZCyahbrThupZeOE2cy8MYV4rMCxwSMeZz0yHWkI/T2DoiSDmPWppsr16vHgVlKcP35BlW1
	C70ZBSPzxVcAL+hDNId+fIbhINhqFJPlRhlM6NavyodGxc7bOhDitFgmmDf8OxD4EvCxeiw==
X-Gm-Gg: AfdE7cm0MGIf8fjHqeMW6l+LHAfqqWmsMKZvkCyDC2yCitwaBVJW4u9Ui4PbYwb3foK
	N1oPC/ULnYn8CeXKdBGPT/TFGyBxQFe8cuBaaRrdBooL4CMy7UY71MwO7ASRN5rH/KU7jDwk6pN
	0a9EpdtHB3a+f/MVOU8CPs9um9TeS9jnKuMQO+T+7n2dM4vvLoNp3h3BKJBAQ9jXeByD5SggRgl
	JeUqd9AgFjBVQsGtC8FnU/m+TXnMRd8jIAORon5aFVmB9LzAOao3+G2mgCKg4Dgkya7NXBAVSf4
	tA8NagyQs1PtTs7Ao6uq7wlhgQ5qCPwbMqcs2DM7Fq/2RlNYYREuD+CD1+t9NTkve4lO4zUOxmO
	pDScVO+H08JGnhTQZMF7uBexxghw0dnO0gaVgSNQPCym7EZWqAzAkB2aoGNnXrhZDcqXcMkQtcF
	3UtwEU2KF6
X-Received: by 2002:a05:6a21:4cc1:b0:3a2:bd1d:d684 with SMTP id adf61e73a8af0-3bb3404fba2mr20581548637.33.1782204946636;
        Tue, 23 Jun 2026 01:55:46 -0700 (PDT)
X-Received: by 2002:a05:6a21:4cc1:b0:3a2:bd1d:d684 with SMTP id adf61e73a8af0-3bb3404fba2mr20581523637.33.1782204946165;
        Tue, 23 Jun 2026 01:55:46 -0700 (PDT)
Received: from [10.133.33.165] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564ed3212sm10209394b3a.55.2026.06.23.01.55.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 01:55:45 -0700 (PDT)
Message-ID: <5abb5812-cdd8-47d4-b5a0-33f7351589ea@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 16:55:41 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9] PCI: Add device-specific reset for Qualcomm devices
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>, mani@kernel.org
Cc: alex@shazbot.org, ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        bhelgaas@google.com, jjohnson@kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-wireless@vger.kernel.org,
        mhi@lists.linux.dev
References: <n3maiuu5cctivlal4fozysz37ir6ecdfws5u2xxw2neclsfdfj@nsvwvlh7b4j5>
 <20260618063309.9536-1-jtornosm@redhat.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260618063309.9536-1-jtornosm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA3MSBTYWx0ZWRfXzZagJOsOb90R
 MjTz9rzhwdF7xjDUXO5gRZYSJdxNfAuGRPE9Nj8fUl/Le58ElteD5BISEZtvJCsEHBdIC/Ytdcj
 hBC0j/sJGRrKyqfD8wBW6WYl7j/MaeY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA3MSBTYWx0ZWRfX4F6sOh1cJRss
 UeL+KGLJXnokYhweS+ulRQvbn6ghbHH/CE5RuKM0luqwkcOiDJnbhi/ZxF6saZ5TEbGBIvSTK2c
 +vx6+wB0Hed/GJdYOIEHCMAH0fPHSlmaO7UQnom9vPAoc9FSsrRN6z4CVsweGXX8PxtXgJ3oE7p
 QaHBxiooy8f8YwYdEYpChcWRTe+MlbMFHXuYX//Ff1WOnun4/lLpAELVBU7EE7PlkPC3HAnu0yN
 beFry5cj/67ADJrOwkqV8GMboiaLn7zw2k7Vx9jxMY9zf9ZBzPuzZz9dQ1qByEGC6AYJtVxosst
 uQHfeBhtRHdaZmuHlKeYD2rmT4U7WoQoXuJleqOE8vUjqpdW3YeblGLUwblWGnv7/HAZyH7KTXI
 Lx4b/JJXjtrV1DusytG8+HtYaegvyRBsTwcK7cMQQRnemMGSLBQTt5wuoQk7zZjVO8yynY5tWAL
 5Ap4TrnW1F5VVnLuICQ==
X-Authority-Analysis: v=2.4 cv=ILIyzAvG c=1 sm=1 tr=0 ts=6a3a4a13 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=_kWzU8USZtXapjXelIsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: 3iI67IE6rwMvA7TUqL6BnNlLLP6lEW7r
X-Proofpoint-ORIG-GUID: 3iI67IE6rwMvA7TUqL6BnNlLLP6lEW7r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230071
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38001-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jtornosm@redhat.com,m:mani@kernel.org,m:alex@shazbot.org,m:ath11k@lists.infradead.org,m:ath12k@lists.infradead.org,m:bhelgaas@google.com,m:jjohnson@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:mhi@lists.linux.dev,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ECA066B579A



On 6/18/2026 2:33 PM, Jose Ignacio Tornos Martinez wrote:
> Hi Mani,
> 
> Let me clarify the exact scenario and where the reset is necessary:
> 
> * For the commented WiFi devices (WCN6855/WCN7850):
> 
> Standard VFIO passthrough flow (this works fine):
>   1. Unbind native driver (ath11k/ath12k/MHI)
>   2. Bind vfio-pci driver
>   3. Assign device to VM
>   4. VM boots, loads its own driver → device works perfectly
>   5. VM shuts down cleanly → device can be reassigned → works fine
> 
> The problem occurs with unclean VM termination:
>   1. VM crashes or is force-terminated
>   2. VFIO tries to reset the device before reassignment
>   3. Without a working PCI reset method, reset fails
>   4. Device stuck in undefined state → cannot be reassigned to another VM
>   
>      Unbinding the driver again doesn't help because the device hardware
>      itself is in a bad state. From hypervisor:
>      $ lspci -vvv -s 0000:03:00.0
>         03:00.0 Network controller: Qualcomm Technologies, Inc (rev ff) (prog-if ff)
>             !!! Unknown header type 7f
>      And a full host power-cycle is necessary to recover.
>      

what is the difference between a clean VM shutdown and an unclean termination?
specifically, will pci driver's .shutdown callback be triggered during the clean VM
shutdown, and not be triggered during a unclean termination?

> * For the commented modem devices (SDX62/SDX65): 
> 
> Even worse because it fails during the first VM boot without proper reset
> capability, standard VFIO passthrough flow:
>   1. Unbind native driver (MHI)
>   2. Bind vfio-pci driver
>   3. Assign device to VM
>   4. VM boots, loads its own driver and crashes:
>      [   24.024165] mhi mhi0: Device failed to enter MHI Ready
>      [   24.024168] mhi mhi0: MHI did not enter READY state
>      
>      Unbind/rebind attempts fail:
>      [  352.643601] mhi mhi0: Requested to power ON
>      [  352.643611] mhi mhi0: Power on setup success
>      [  373.442954] mhi mhi0: Device failed to clear MHI Reset
>      [  373.442970] mhi mhi0: MHI did not enter READY state
>      And requires a full host power cycle to recover,
>      even outside of VFIO scenarios.
> 
> * MHI Host driver's remove callback may handle clean software state
> teardown, but it doesn't provide a PCI reset capability that VFIO can
> invoke. VFIO needs a reset method registered in the PCI reset hierarchy
> (device_specific, pm, flr, bus, etc.). VFIO invokes this reset both during
> initial device binding (before the VM starts) and when reassigning the
> device between VMs - without a working reset method, the device cannot
> reach a clean state for initialization.
> 
> 
> 
> I hope this clarifies the scenario better. Please let me know if I can
> provide more information or run any specific tests to help investigate this
> further.
> 
> Thanks
> 
> Best regards
> José Ignacio
> 
> 


