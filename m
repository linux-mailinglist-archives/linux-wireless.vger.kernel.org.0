Return-Path: <linux-wireless+bounces-36453-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFYsOaiEBmr0kQIAu9opvQ
	(envelope-from <linux-wireless+bounces-36453-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 04:27:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC04548B80
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 04:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1184D302D900
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 02:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4D53BA236;
	Fri, 15 May 2026 02:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HVpdbuqq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EqbZfbVp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170D03BA220
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 02:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778812069; cv=none; b=FHPWn1vdJTRR/w1M3buhB/SOgUv5PYZtRhVMhb3aVJ+1vm6fJjrA77iv26QMHwWDzTtn3kSGZqyVfGvqN+u6AyoXJQBHn1ZtFDdcMujnS5jyaqLdQ6C45/ok3/cPscFCDMS44PvXSoUK70gi9f12qa5uzrECm7GGjxEt3TE0KGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778812069; c=relaxed/simple;
	bh=ZGLrgcKzSMYLUuc3NYqgkyKk39yYXLvWcx1OoQhBENY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hWfGy+huc2l9bcGJbcEdu3W27HiQ7+tTO4z2/vDuvoo/Ai6aZt9ZAxAavcPLsW6h5VstlC2uB3EoHqC56EBPowVi0g0byZj5QxMU3nqkBhLCgB9xDaw+5zPSI9FXEFFXIPbYOqT/L9l/SAdvhr2l3KB4wpt/bgn6xbk+7HF3oXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HVpdbuqq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EqbZfbVp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64EIpN1v655391
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 02:27:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GG4jPt4PsiOv78ZDySQX+4PT9DNiaDGHP2Yb7bOsOys=; b=HVpdbuqq6AIg0+Cc
	DdYjfeJU5dVxaT1HZfXj+0xOOuRgc2blLDzJNnE7u0XVk/RQuaHS7xdBoqJTf1fY
	DTNL4n6bCIjaWpeP12UmoI9Ik44nf+JhXkRGp5MpoPHfYlXkFQyOsiuKGFUCnOC/
	seQroQ68j4hP9+Ze4idscchpY9iIJt5Zi4O9JP0mS4et9EPj5Er4x0kK+dMksAZd
	9xXR22Zp8ZKG2YdjVT8xEnruzKvO0GpnakQUL7iswRaNkIhAGApfvC+7iX49a4js
	YAYG9YrCKUvFcU/oA7K45eSdM1UJI0byXliZC/qTsJ6Ch5s9rq59AGHhED5iDYd4
	da2rZQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1ps767-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 02:27:47 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b9a3c3c4eeso92707745ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 19:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778812066; x=1779416866; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GG4jPt4PsiOv78ZDySQX+4PT9DNiaDGHP2Yb7bOsOys=;
        b=EqbZfbVp42ycigYxUdgsKgTxMLQzId63tvDQmcG8ihZ532eDsAhBl+VHxGb2bTezXh
         fvoMQMvOZ/2ulF0AdKXPBDKlfuHdfztSZZtN9IiZ5/EpQEulja2XNCRNwkzZI0Pz85Q7
         MWeYoC3kBfDs3309q3SFvkev+b5v1nr9HLMx5tnueIWkEwO5vTw9lFwCG2qI1HcJ1JBC
         6VlJfO11DO6sO4wZfDx5E2L3ZMpGnikKojfkAoNYpzmn0/B43pRK4HcwYrZ060qznRAD
         u0pbqfJE6MXbzbjq0hCf00pntJiWphQfsFEEl8KCT+cS95OmwSKIosB6W/hdgg5XbTT5
         u6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778812066; x=1779416866;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GG4jPt4PsiOv78ZDySQX+4PT9DNiaDGHP2Yb7bOsOys=;
        b=JdmrXp9JmEWbwQATFJFd+0F6kFY/s/imSkOZuQ+RmNJUrz2D1XYXMxya8HacCQARr+
         U+i7PwyY+ODg0xLpyk0TSdhYLedLO4u12p9Ub8vTSL+3CdtFNeM0qfdSzRgBDBadMp2N
         MYHAo3KJWU1xXEuHD9Cf5Tlbe6/ezwOwWwVktramCqI+sOulNumw4D130UKkm5VgbKJ2
         svnDiaf9trC6ZiEsewed8zZSN8e6GbrBOkXVKyt6aflav4F5SijIFOoeHz94i9wVMmSx
         +VRwvXJC93e100evK0vsgjB6BC9nZUt7X+O7IEuM2Tl0abaBW1pPssPRXFKoz89NHkzu
         z5GQ==
X-Forwarded-Encrypted: i=1; AFNElJ9cdY/R85pY3UwYn/GkkXVVYkExyaQC9hxzELjzrhZTAECY7JHPd6KIglS3Z2u0lNG1CqJOfOdIMMtU+o7z9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVtxPbBdiGD9FZbzF64/IUctl40K+vryXyyLxkqccUfctgsEyE
	U1xJ/FTvU3Gy+cxzKRrpTcsMM5yODHihh4QfuV1+Wu/q06weW7SpmoGuHJzc7r2ZW0GtuKl/NXt
	SdkS8zYET9cjqEFlahUC+vwvZG9Mg9XpdMfUD14APURVUxCGxJKBvQEiQUH+tQ0a71btRCw==
X-Gm-Gg: Acq92OGPglbNP632832xnBhOCFIS3UjyA2VXzY7VPIObYKdsCBj1Q2M+9BOw/syocFr
	4SEBExjaofl70g5g2315p72DU/G5WKxMrKJnWwqBBzgo5X8JTqUeqC1T8O4Y7YGHYt6mKteff4U
	ZYxU4B+lQ0TBi8V4mPto83ewYuyRzeZ4Dy8xO+4iMSDcFdpwYsyyGqlzafDdO7cMswLfT9x3F/h
	ICTun0UYSA6EdJq2EOE9tuwfETteM3lV3nkZeB6VDYg2FyzfeKTZyVh+SrSIxPieW8mHCNUnA4F
	/8VkmVxGrfQqDktdW3IZRFfxnNGUjzWXXd3cR7CDpaj3bHA7yd4X0m8l6B0zjBMoS5PfCktfOd7
	qTQGeXAIMxnztA+79/e6TUGQR3oVCuLThbEn9T3GrHqL8JQ4YfwBBdKmpOOXtIgWLSY1G
X-Received: by 2002:a17:903:240c:b0:2bd:2439:25e9 with SMTP id d9443c01a7336-2bd7e9e263emr21145085ad.40.1778812066412;
        Thu, 14 May 2026 19:27:46 -0700 (PDT)
X-Received: by 2002:a17:903:240c:b0:2bd:2439:25e9 with SMTP id d9443c01a7336-2bd7e9e263emr21144885ad.40.1778812065866;
        Thu, 14 May 2026 19:27:45 -0700 (PDT)
Received: from [192.168.58.30] ([152.57.206.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5fe44sm41884845ad.11.2026.05.14.19.27.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 19:27:45 -0700 (PDT)
Message-ID: <fdff6264-9c35-4c77-bab2-6db9125d77af@oss.qualcomm.com>
Date: Fri, 15 May 2026 07:57:34 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix warning when unbinding
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: ath11k@lists.infradead.org, jjohnson@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        stable@vger.kernel.org
References: <20260507070808.367442-1-jtornosm@redhat.com>
 <20260514061841.9517-1-jtornosm@redhat.com>
 <95bff017-3554-425f-ad8e-767f9cbe1277@oss.qualcomm.com>
 <c2523379-ab12-47e1-a0d0-ef6073deaf11@oss.qualcomm.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <c2523379-ab12-47e1-a0d0-ef6073deaf11@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: llM9gjSU9MXnlBKdxZvr2CjgbyzugtLz
X-Proofpoint-ORIG-GUID: llM9gjSU9MXnlBKdxZvr2CjgbyzugtLz
X-Authority-Analysis: v=2.4 cv=GrhyPE1C c=1 sm=1 tr=0 ts=6a0684a3 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=YxPPAu78v9FaI4eag4rAcQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=eGHVyj3czf8DJk7V1mEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDAyMiBTYWx0ZWRfX0UPuR0yQHEj1
 BYFkoaAdLq3In9Ax2GCoS/2+qNN5BxFJjdpq8t9/wuzH4HdI1kyvp0E1TQtcW5/YB1ozaTz0kur
 MvkXBEkqubZmkDmGm2cObjnzNfn1bvs9OYKzz2WzV9Aob687JgwpUwMAk6UC+5JkrU+WzJZIU/Y
 l8zGtffG/phC3QOX1jupx4lPVXiZFhbx0HRkBHAcIJbDWC5lT39T74HP23/KEWTROv20ozoKUFk
 CAF6hG4zy+jX/lNi0wJOqCpE6Exty35eWAOct+3mi/b+qxaIzsQD7j216y/I2sEBxVhH1376mmn
 KCAgpqnlaGtqNQSBu7GTKqHd6NcwSLIvBI7qla7AWKnaPw642x1+tFAt0IcETr0rAN0Mfowpl/Q
 P66ogsZYxvZ4/nVZfGmLPq5pJlRO8OcMlOGUcXNsNaqbwr0olakMyBC8rTEtd3ICuPYdJ6IXR+O
 pv1rsVANQ8x26TD0tJA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_06,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 spamscore=0 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150022
X-Rspamd-Queue-Id: 8DC04548B80
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36453-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 5/14/2026 1:45 PM, Baochen Qiang wrote:
> 
> 
> On 5/14/2026 2:55 PM, Rameshkumar Sundaram wrote:
>> On 5/14/2026 11:48 AM, Jose Ignacio Tornos Martinez wrote:
>>> Hello Rameshkumar,
>>>
>>>> I agree that setting tx_status to NULL makes ath11k_dp_free() more
>>>> defensive, and it matches the ath12k fix.
>>> Ok, I agree too.
>>>
>>>> However, i am still wondering how the second ath11k_dp_free() is reached
>>>> if ATH11K_FLAG_QMI_FAIL is set.
>>>>
>>>> In ath11k_pci_remove(), when ATH11K_FLAG_QMI_FAIL is set, we take the
>>>> qmi_fail path and skip ath11k_core_deinit(). So the normal remove path:
>>>>
>>>>       ath11k_pci_remove()
>>>>         ath11k_core_deinit()
>>>>           ath11k_core_soc_destroy()
>>>>             ath11k_dp_free()
>>>>
>>>> should not run.
>>>>
>>>> So if the double free is still reproducible with QMI_FAIL set (with the
>>>> change i proposed), either the flag is not actually set in this failure
>>>> case, or there is another path calling ath11k_dp_free() ?
>>> Let me try to clarify the issue more.
>>> There are two error actions:
>>> - First the previous error. I reproduce the situation as I commented: running
>>> in a VM the default upstream kernel (with this card using PCI passthrough),
>>> since this is always failing. Let me show the logs in this situation:
>>> [   15.906564] ath11k_pci 0000:07:00.0: BAR 0 [mem 0xfdc00000-0xfddfffff 64bit]: assigned
>>> [   15.926520] ath11k_pci 0000:07:00.0: MSI vectors: 32
>>> [   15.928572] ath11k_pci 0000:07:00.0: wcn6855 hw2.0
>>> [   16.984192] ath11k_pci 0000:07:00.0: chip_id 0x2 chip_family 0xb board_id 0xff soc_id
>>> 0x400c0200
>>> [   16.984351] ath11k_pci 0000:07:00.0: fw_version 0x11088c35 fw_build_timestamp
>>> 2024-04-17 08:34 fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
>>> [   18.186971] ath11k_pci 0000:07:00.0: failed to receive control response completion,
>>> polling..
>>> [   19.211036] ath11k_pci 0000:07:00.0: Service connect timeout
>>> [   19.211815] ath11k_pci 0000:07:00.0: failed to connect to HTT: -110
>>> [   19.214181] ath11k_pci 0000:07:00.0: failed to start core: -110
>>> [   19.531989] ath11k_pci 0000:07:00.0: firmware crashed: MHI_CB_EE_RDDM
>>> [   19.532930] ath11k_pci 0000:07:00.0: ignore reset dev flags 0xc000
>>> [   29.259157] ath11k_pci 0000:07:00.0: failed to wait wlan mode request (mode 4): -110
>>> [   29.259229] ath11k_pci 0000:07:00.0: qmi failed to send wlan mode off: -110
>>> - Second after this, I commanded the unbinded (ath11_pci) and I get the
>>> warning. Let extend here the stack trace:
>>> [   24.238198]  ? free_large_kmalloc+0x57/0x90
>>> [   24.238199]  ? report_bug+0x16b/0x180
>>> [   24.238210]  ? handle_bug+0x3c/0x70
>>> [   24.238218]  ? exc_invalid_op+0x14/0x70
>>> [   24.238218]  ? asm_exc_invalid_op+0x16/0x20
>>> [   24.238224]  ? free_large_kmalloc+0x57/0x90
>>> [   24.238227]  ath11k_dp_free+0x99/0xb0 [ath11k]
>>> [   24.238275]  ath11k_core_deinit+0x12b/0x1a0 [ath11k]
>>> [   24.238287]  ath11k_pci_remove+0x7b/0x120 [ath11k_pci]
>>> [   24.238294]  pci_device_remove+0x3e/0xb0
>>> [   24.238304]  device_release_driver_internal+0x193/0x200
>>> [   24.238315]  unbind_store+0x9d/0xb0
>>> [   24.238320]  kernfs_fop_write_iter+0x13a/0x1d0
>>> [   24.238330]  vfs_write+0x32e/0x470
>>> [   24.238335]  ksys_write+0x5f/0xe0
>>> [   24.238336]  do_syscall_64+0x5f/0xe0
>>> Very easy to reproduce.
>>>
>>
>>
>> Thanks much for the logs, that makes sense. The timestamps explain why my earlier
>> reasoning did not match the trace: unbind reaches ath11k_pci_remove() before
>> ATH11K_FLAG_QMI_FAIL is set by the QMI event worker as it is held up on wlan mode off qmi
> 
> how could QMI worker set this flag? the first failure happens in
> ath12k_core_qmi_firmware_ready() and upon this failure the QMI worker just break out
> without setting any flag, no?
> 


you mean ath1*1*k_core_qmi_firmware_ready() ?. Yes in ToT it breaks out 
without setting any flags, so I proposed to set that on failure case 
ATH11K_QMI_EVENT_FW_READY: (similar to case 
ATH11K_QMI_EVENT_FW_INIT_DONE:) in this mail thread.


--
Ramesh

