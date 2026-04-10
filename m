Return-Path: <linux-wireless+bounces-34570-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EM5pF/yo2Gm3gggAu9opvQ
	(envelope-from <linux-wireless+bounces-34570-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 09:38:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E1C3D36EA
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 09:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 979B1301876A
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 07:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5AF39657C;
	Fri, 10 Apr 2026 07:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bu7ooWtV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zalmj4fo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43C2389101
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 07:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775806712; cv=none; b=S9uVhbChuC0lzWZ7h428tp9m3xu4KjfDt6a4fpRm4i/KJn+hZhe9T4wD2UGg9gSVtYTjul94WIUew7SCzCnYf0wKZNo0wMg+u2HCYYtjUSb8r+d0ynF1Em0EbSJBrhXul98ORz+esO7T31vvo/TAFm7NauKZShtSTvj2GtD17MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775806712; c=relaxed/simple;
	bh=v38s9Qq2+kaM2Yj7sNv9VKvKSebxXIEm1GSi9tLA3PI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZbjAEX7eSpCbyYkHmRzIq8x94Nmaxd5PCErHqQXQdhO0rzzxEgV2senPxUlCjdtgT5uS1NNkd3lNqjR8tpxks8RnXX+DY3VH/qtmcI7psfhiub8n7FMCQBmfW7hpOHj+4KseB2j/Q7DcsuJdxQRiuYSgnIk0QKIMa/de2h8NGzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bu7ooWtV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zalmj4fo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63A7FLEa2624749
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 07:38:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zshsTI/Jmmz4I2BWB938l40pUvO87SUUsOPhsEdr1Ps=; b=bu7ooWtVBGLG38tC
	KAC5A1z77h52iSoI260/VV7EGVXzUsu+hLn4kos/b+A1I17rPujg8tIOvLG++l0X
	495NcvuU5+2+XnL/hi9lO+i1uyXYLiGzYYWSfcDEYCwqlpNx6UVY4eFAbxGTU/Ne
	ZbO4sLsWd8aYz2EaSoA+H6Z4kTkV6piDl61mNyfSxVrs5z0xwxbr0vU6ZVB0K1B1
	WHqcvXkEDzHW1rLlxSRXBSHgoBZjD55k5MFD0VaiJsqPLPzRicBvhVHRzobB7mBW
	RGfckMN0eyfjIXrxDPnxQz/9YZLk2+R97mct2RaxLRFXjJ8iElgDyOjIt0bkCkdN
	CUEx1Q==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4decmu37a1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 07:38:29 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82c613194caso1006257b3a.1
        for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 00:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775806708; x=1776411508; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zshsTI/Jmmz4I2BWB938l40pUvO87SUUsOPhsEdr1Ps=;
        b=Zalmj4fo/Xlh8tf6tG/Cj26PXv1N9Exya44HJmxtvdgeQDHcucuCk0/6H6clY1q0sQ
         sDBiia9ouQFSq/I8AE7f1BrD6kdWC54bwRX9FdPL08XxN26P8r5aK7t8RiLhC2EW3gyb
         BoFVnUwvqN77MkD7XK++hoZOlTjmG5SPD0XuUaAPp0yV69LgbNIlr2a0s707ErLBnj4n
         KOiO2yxJY44mT+59Ubqw/W8wigLQS0YCChGYcp43szJGZ4jYX2R5PnTbTeSLZjcL74Qo
         e2fAMqcavgPPa1rqmqW8OLjRaLd46AJ3AQJZkJyLOaTz1apJ2XkBAnFg7ZeNcptQPtif
         jqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775806708; x=1776411508;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zshsTI/Jmmz4I2BWB938l40pUvO87SUUsOPhsEdr1Ps=;
        b=rmBcTvJXH01XC9tO4a+kNdC5YoA7Hz6Kvgme1TPZcaI6q1zVAPtHAXrGrF5OUE0WDr
         sklfJA+zspnyRlXBaLjjkZ6JBP5NWGOwswfCb2hr5Zfl7eFMnLn3SKzHwxTqqbmdaEtE
         d8KkjoYhjE6TVuLu78CWC07DcadsMvcA4X1DVrhe688c2n7D1v5FH61JiAVdzYb8Prab
         KJooVsr+1QanP6MwdNKbFG9gBewfsCtdwiOwxn/s+K6JiCe2+nWYHzubWAMKCMTzsAwc
         8PgiQ0lL7dW0a/fFFo+51gsQd9PoaG2ibqNHhdEG/XtP60zNGkZ+6mdxnWokWtWbUBJf
         HT2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUhvZAJcsMf4IpqtEeLShcOm2FxDtkdmMJUXQB/h05ZncUT0vvR6dpyFvALRvsjPp752xmdngmf1coJIXaqyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6hKUCLC/vV7SQqoxHry5upmqgKUggvb6yOBxQHaDKTyqldQIJ
	0aiInWoEYvQxKYiiZKDFFP3JE/VLzQ9+b58Ic+rbaLyiCfxmDK4UjEFCldNzNmciPOhkhpqeFv/
	Lqw9xA9tTfzRxXrM5d0uM1thufyOrrtn+3PuBABZYw/icANcO+ZonUUr4aDq7jiuGQM+8Cw==
X-Gm-Gg: AeBDievo/1b/BxAAMCn8jBO0B6WtVoVZlQBTvthwcrBjHX+0koRwjApwTUnrMX63RP0
	RIoAiJJvkGN3g23USOlFVECNEqTvhBLMtEowWPvSJa73KaP2xpPR+ocPLWoISSEaFd/euccpJ1g
	CsJN2D2XHuYgVVD9gahJxk2tLOEXmm6AaIjzAKyNSS8g6yoR3Bj0npYqL903d6xMX6Wg2R8eTJm
	OEUFM5dLi4S7vjIQmAYutx/yFjQqbZ+TtZpdq15nEqJgLbKQkZw63goxCtok08SIW0Tg8hg1l5B
	XMkXIN2EXPALrUh1qdq6BVNVhu+O5xoDQdhSz9nqBi3dZykLEc/iIc8WOgMrPV52jZgnAGq+WcM
	JNKUF0D+66xU23IFBfHZ7siSfLz89OAAGoz37oFY3B3k+pYX1GZWO/Nl3SoGT2quJGtcXktM1B1
	45eGYicbSIZpIWCJPMPxY=
X-Received: by 2002:a05:6a00:4b0b:b0:81f:3fbd:ccf with SMTP id d2e1a72fcca58-82f0c2278e7mr2426294b3a.23.1775806708355;
        Fri, 10 Apr 2026 00:38:28 -0700 (PDT)
X-Received: by 2002:a05:6a00:4b0b:b0:81f:3fbd:ccf with SMTP id d2e1a72fcca58-82f0c2278e7mr2426266b3a.23.1775806707825;
        Fri, 10 Apr 2026 00:38:27 -0700 (PDT)
Received: from [10.133.33.254] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c34f7d0sm1946707b3a.14.2026.04.10.00.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 00:38:27 -0700 (PDT)
Message-ID: <fcebc2a2-4478-41fa-8071-18dfcc2dffe1@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 15:38:24 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ath10k: skip quiet mode for WCN3990 to prevent firmware
 crash
To: Malte Schababerle <m.schababerle@gmail.com>
Cc: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
References: <323b5222-a105-4701-8342-9131660fe803@oss.qualcomm.com>
 <20260406221405.201848-1-m.schababerle@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260406221405.201848-1-m.schababerle@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: wlEhxvFXhSKy4P6EAvD7I4awBITHG2BO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA2OSBTYWx0ZWRfX3IuS3RuRN8j4
 Um9JTTTBgtHQy85Bj2lOoPJGbQpGP5rOud1J+YDB59I847nMct+pOs75dCM1M8CDXKgR57vfeil
 A7czhef+oo509mDxT5H49vKGNFumZsXYZSxkGvwp35IBG4pab9hafCxvmkp4xJDZmSjhzeFgmEX
 RsYSiyqyGxlGAyhdj8arkyMn1r9mTC80A6vhBfvMCrcItuFxTuuY7utewFFKpPn9slKxBJIvY2Z
 sqZk30w58yNRFqgIbWX1VwTfjoZ8/Tlns24caBo3dvlWiaqECgwUbCuEorqdX+rq2zA7H/0CjCb
 +0nRS2L0j3zqQ9t2t7sh/UdrwaEta0WVgv0jQsazbbuy043zCqaFXOz+zHfYkoNuP8zAzXSheQ6
 32cntAJ8EtO0j3kZX8dSpukSa2ZHLW3SwdqpWFpzvN+K1SHSt0U/ggIjxPLzWbGqgsaSRYLX1y1
 lqkxve5cloQyh+qVnMw==
X-Proofpoint-ORIG-GUID: wlEhxvFXhSKy4P6EAvD7I4awBITHG2BO
X-Authority-Analysis: v=2.4 cv=DslmPm/+ c=1 sm=1 tr=0 ts=69d8a8f5 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=rxAmHljU2xxGwqvv-XQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100069
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34570-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
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
X-Rspamd-Queue-Id: C3E1C3D36EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/7/2026 6:14 AM, Malte Schababerle wrote:
> On 3/22/2026, Baochen Qiang wrote:
>> Malte, the firmware team needs firmware dump to understand this issue,
>> would you be able to help collect it?
> 
> Sure. Attaching the full dmesg from a reproducible test run (kernel
> without the patch, upstream 6.17, postmarketOS on OnePlus 7T / SM8150).
> 
> Firmware: WLAN.HL.3.2.0.c2-00006
> 
> The crash triggers deterministically on every boot. Key lines:
> 
>   [25.122098] PDM: service 'wlan_process' crash:
>                'EX:wlan_process:0x1:WLAN RT:0x2076:PC=0xb0008e20'
>   [25.283364] ath10k_snoc 18800000.wifi: firmware crashed!
> 
> Full crash sequence repeats across subsequent recovery attempts at the
> same PC=0xb0008e20 (see attached dmesg.txt).
> 
> Note: I'm running an upstream kernel (6.17) on postmarketOS.
> CONFIG_QCOM_RAMDUMP and WCSS coredump tooling are not available here.
> If the firmware team needs a full Hexagon register dump, please advise
> how to collect it in this environment.

please follow below steps to collect firmware dump:

1. sudo modprobe -r ath10k_pci
2. sudo modprobe ath10k_core coredump_mask=7
3. sudo modprobe ath10k_pci
4. reproduce the crash issue
5. collect dump using a similar way to Intel chip [1]:

	You can now get the data from the devcoredump device and dump to a file:

	cat /sys/devices/virtual/devcoredump/devcdY/data > iwl.dump
	echo 1 > /sys/devices/virtual/devcoredump/devcdY/data
	(Y is incremented each time)

	The easiest is to define a udev rule to dump the data automatically as soon as
	dump is created:

	SUBSYSTEM=="devcoredump", ACTION=="add", RUN+="/sbin/iwlfwdump.sh"
	You’ll typically have to paste this into a new file called /etc/udev/rules.d/85-
	iwl-dump.rules. This location can vary between distributions.

	/sbin/iwlfwdump.sh can simply be:

	#!/bin/bash

	timestamp=$(date +%F_%H-%M-%S)
	filename=/var/log/iwl-fw-error_${timestamp}.dump
	cat /sys/${DEVPATH}/data > ${filename}
	echo 1 > /sys/${DEVPATH}/data

	This way, each time a dump is created it will automatically land on your file
	system. Remember to make the /sbin/iwlfwdump.sh file executable (i.e. chmod a+x
	/sbin/iwlfwdump.sh), so that the udev rule can execute it, otherwise it won’t
	work.

[1]
https://wireless.docs.kernel.org/en/latest/en/users/drivers/iwlwifi/debugging.html#how-to-provide-information-to-debug-the-firmware

> 
> Tested-by: Malte Schababerle <m.schababerle@gmail.com>
>   on OnePlus 7T (SM8150/WCN3990), kernel 6.17, FW WLAN.HL.3.2.0.c2-00006


