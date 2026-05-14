Return-Path: <linux-wireless+bounces-36414-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAd/HKqEBWqJXwIAu9opvQ
	(envelope-from <linux-wireless+bounces-36414-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 10:15:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F304D53F26F
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 10:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 619A83016022
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 08:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5E03A5441;
	Thu, 14 May 2026 08:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oY5nvkQ6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WgjAVfjP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2681395AD5
	for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 08:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778746536; cv=none; b=okzJg5WW32PwFYmeaI7XVU4Ajl2416eSG1buACT5fkGHeQPNRGnldlg2cwg86J5xIzEz8KUFyOWGOL4wlHyY08vvldycb05M2RgBZmEjh0afUF3su+V6RoMG6Qu2vnLZ1CTnKeHnco9Aa6q5s9iIg4XJNdNgbuQ+BI4tMxvX5J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778746536; c=relaxed/simple;
	bh=zEEkY2jSKxlfR3UMEU+YviVlz8guzzmOR/Pxg3hB5eU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hnaL6Lx3zEtGtYd7EhviDEcsZVzgHRrAZxOtqrrgPJR/TWKqVArH0zcI2saCEf0emJTfowm+IGCBhfLesk3NAWLmuIHwHmLeku5kUO3ELsMuQTfeoJCqdzRV/Z30qdjW3Yq2C3Th8T7RetB5OgL8quQdCYuYDHjhE9FsHsXvB/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oY5nvkQ6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WgjAVfjP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E4geK53014064
	for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 08:15:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2DQezXlwgxWUm8Dw+7AH5kOEuiqxY5oqs/GcaOSPTjw=; b=oY5nvkQ61UO6cd76
	a9nx/IFmAUAz+p9ecYcZD4lFCrftdX/zxXk8k1YZLMyqg+ZG1wSlVHgfDHOCmwin
	J+0ajIbPoC88+G3jJFbvwZN1N24+JErWJoTLM4CQ7mvtFl1vEoABE3/HmYdtZpcp
	gQ1/JH/vr2mKOz8WquChf3bGbo+7h88lNJZq2Jf/tIB+jVxINgUJnm1x4U6e6cDt
	l0N0ZY3q+kqUMvlG4U1/lCbnhbhTrGBcvEzs+haTtLHwmQvcBOI8EbA2oRmSLUjP
	tC++sDO1LtWv53L8+QZHxfxviolES6zgQLhb0CHs87/Bn2cnK4/gHDOuBLFdcZ55
	83NpDw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e57ksrnc0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 08:15:34 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-368f2d76b04so2246843a91.3
        for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 01:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778746533; x=1779351333; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2DQezXlwgxWUm8Dw+7AH5kOEuiqxY5oqs/GcaOSPTjw=;
        b=WgjAVfjPQxDoxcnRN4eUF8bqUVwcbOrzNGgoBnWMnCcqwNWo9PmamhkHBr1jAY/5sB
         Zn5+7RIjma3SvwFcp2PI+im/DfdnwXMCknv/wgBSL54TKrlnDRrkHjIwx7HTpTaQi1Rg
         0ihMDUy2kNek5g1QX2GrHqlmH3vYNR2t7HzQe2KbE2eyPfuaduTQerxqwoF5dwYFLjTP
         vvso4wWv5+LR2pG9C9kQnl58XAZ1bP150jLdiMN5YusLW0MH7b03QW9o7VH64pT43qN+
         JMFG8Fd+QF0IunB19G8yv2L2Em+xOPD0z6G9XgU/as66VjTS5o+4PSu0L0UMCkOJ983a
         Z/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778746533; x=1779351333;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2DQezXlwgxWUm8Dw+7AH5kOEuiqxY5oqs/GcaOSPTjw=;
        b=gIQMsuJTaYVbx1J3TXVNK7X7HrUVMaUk8wUpkLvqBE1Ncky5XZKflTm08LoVpdWwbz
         ArHbtFr2INWlqXV80Lj4P9k8F/Mso2r4ncpjxaZkYG+I6TSyel6zyN5tq/NN+rfp6IW0
         +4aRhzbse0YX+jl7PG5fI5otp60QPhzuLI5H7v2mYgX7m+l1W6I9/6ypdBnbuigxuh2C
         JtMxvSc7Rc/8PpB92Oxlg+K65Sv9sLQ7a+blZVqA7Nvx7XkQ3AcChb4wIZ3yHnKe5W4U
         en3IwK46yhrGnjZ89YMbo1EeDyFW591jqAVOr9cVCj6Bojnl07lbNRYpvH9FaWPSobF8
         pabg==
X-Forwarded-Encrypted: i=1; AFNElJ+k+vmVkR3D9dfZdwqERLHEvyphI/ze5lNSxIZ0Xkp6W1pBbA09c+ujs40iRIpZF8sOEBHkWDy+L5xsGD0KRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXSvCWyQPg04ZLrDBMY5gtlAGFymruA+fVTodqbdXEeoqRwW6t
	aFUPwq4b9k4cNGlWJufWPYYRc7iIynKVnAK2k0bvs7bFE0nS6CeuKmUug9dHgfWF9wUnVCDw8p6
	FuyHvjS+HfW9gxc7kpIOoEefJ4VLVkuwS1ZaB7Gdun36aPweYJQDGX3pW+zqbH4yoX6Omdg==
X-Gm-Gg: Acq92OEzSn7Br/sNUjmXq1jWU4+F4ch9U1Btukg4ayKZObgofjK6QIKn1Rcc16rNQ3y
	4D7kT5BzLZXhOcYCnun9yeL2+DzqXh1cZZrsqVh9RxGbErPSGW/OuQ341VYEGMiVZ625EKPiw94
	rdvZrReqvOKsz6saU6tOGPlaSb21KeC47xZVhwtCVIq3XFybItWSdN2ld0HTsiXcvZ6S6iFHn1m
	5mJ0o87IqDOygZOz2QuyecgclDAhgw5F8RqBLW7mC2pqfYl9MBxcG/Wad/Ll5o5wDzne+tfD1tg
	Duc4+SZB+V6sgaVhzCeJaVIGFOODVVp9F0LZGs6xJftueSq7Lx8NlPqlNx/G3A98+YM/1p0MJJp
	8dmpumUUTB5buiigR0McdPdSccqvToxDxFsRSCPNegxB65wlV5dgQxLzqnh5jBzDAUaSUSV4FFj
	F/+Ncwh6st0N6wYuak09g=
X-Received: by 2002:a17:90b:3c0e:b0:366:4f8a:9847 with SMTP id 98e67ed59e1d1-368f3e681bemr6821448a91.17.1778746533368;
        Thu, 14 May 2026 01:15:33 -0700 (PDT)
X-Received: by 2002:a17:90b:3c0e:b0:366:4f8a:9847 with SMTP id 98e67ed59e1d1-368f3e681bemr6821390a91.17.1778746532608;
        Thu, 14 May 2026 01:15:32 -0700 (PDT)
Received: from [10.133.33.178] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb100706sm1613791a12.17.2026.05.14.01.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 01:15:32 -0700 (PDT)
Message-ID: <c2523379-ab12-47e1-a0d0-ef6073deaf11@oss.qualcomm.com>
Date: Thu, 14 May 2026 16:15:27 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix warning when unbinding
To: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: ath11k@lists.infradead.org, jjohnson@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        stable@vger.kernel.org
References: <20260507070808.367442-1-jtornosm@redhat.com>
 <20260514061841.9517-1-jtornosm@redhat.com>
 <95bff017-3554-425f-ad8e-767f9cbe1277@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <95bff017-3554-425f-ad8e-767f9cbe1277@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Sn-35-8kTEKRqtaTYhPNQcrpLCM7JPrv
X-Authority-Analysis: v=2.4 cv=KZbidwYD c=1 sm=1 tr=0 ts=6a0584a6 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=kMbTGvAQcfItPFarCmoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDA4MCBTYWx0ZWRfXxrePQq/r1o8i
 UhPv2lG5cUIjpulRYozHW5sGRUDX6s1lkJFggeGzywx1U1H8YuDczpj6JhjRELIleLFMlp2oP1p
 X6clyl6gSXsYoxC6rzHHMuNVW3DXeq4Wpq8PooL4BPmxQRoskr9aDjUL61tMNvlyfIIuTM/Ga5n
 icYgzWfj9/18Ff+12fnpWi9pkxvHUUB+aUo23UulswYt6YQizBkDbEq4yQguU69NgPx9pILLNO/
 rOz3Tn3bzESO/iMo+ZqlCEyJa29S0fVxhjCF94nc5lPJA0vOsio/t2k4pI+vijt5X7upd6h6vff
 x4EKL5Nlh45XaFEaq5PHN+W5EJoT+PXOqmkb7kZhxjF5ACqKEBDwpxXeRB1eSWkA2OKYJm++GIL
 iGx1+3S+tLpFSi9XayYqiK1cWlhM40VYUd6zq4RT1Tqi091UP8nuUq7sGaDA0J8NJH7bhPG8TdT
 VqpB39lv/kHG6WV1/fQ==
X-Proofpoint-ORIG-GUID: Sn-35-8kTEKRqtaTYhPNQcrpLCM7JPrv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140080
X-Rspamd-Queue-Id: F304D53F26F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36414-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action



On 5/14/2026 2:55 PM, Rameshkumar Sundaram wrote:
> On 5/14/2026 11:48 AM, Jose Ignacio Tornos Martinez wrote:
>> Hello Rameshkumar,
>>
>>> I agree that setting tx_status to NULL makes ath11k_dp_free() more
>>> defensive, and it matches the ath12k fix.
>> Ok, I agree too.
>>
>>> However, i am still wondering how the second ath11k_dp_free() is reached
>>> if ATH11K_FLAG_QMI_FAIL is set.
>>>
>>> In ath11k_pci_remove(), when ATH11K_FLAG_QMI_FAIL is set, we take the
>>> qmi_fail path and skip ath11k_core_deinit(). So the normal remove path:
>>>
>>>      ath11k_pci_remove()
>>>        ath11k_core_deinit()
>>>          ath11k_core_soc_destroy()
>>>            ath11k_dp_free()
>>>
>>> should not run.
>>>
>>> So if the double free is still reproducible with QMI_FAIL set (with the
>>> change i proposed), either the flag is not actually set in this failure
>>> case, or there is another path calling ath11k_dp_free() ?
>> Let me try to clarify the issue more.
>> There are two error actions:
>> - First the previous error. I reproduce the situation as I commented: running
>> in a VM the default upstream kernel (with this card using PCI passthrough),
>> since this is always failing. Let me show the logs in this situation:
>> [   15.906564] ath11k_pci 0000:07:00.0: BAR 0 [mem 0xfdc00000-0xfddfffff 64bit]: assigned
>> [   15.926520] ath11k_pci 0000:07:00.0: MSI vectors: 32
>> [   15.928572] ath11k_pci 0000:07:00.0: wcn6855 hw2.0
>> [   16.984192] ath11k_pci 0000:07:00.0: chip_id 0x2 chip_family 0xb board_id 0xff soc_id
>> 0x400c0200
>> [   16.984351] ath11k_pci 0000:07:00.0: fw_version 0x11088c35 fw_build_timestamp
>> 2024-04-17 08:34 fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
>> [   18.186971] ath11k_pci 0000:07:00.0: failed to receive control response completion,
>> polling..
>> [   19.211036] ath11k_pci 0000:07:00.0: Service connect timeout
>> [   19.211815] ath11k_pci 0000:07:00.0: failed to connect to HTT: -110
>> [   19.214181] ath11k_pci 0000:07:00.0: failed to start core: -110
>> [   19.531989] ath11k_pci 0000:07:00.0: firmware crashed: MHI_CB_EE_RDDM
>> [   19.532930] ath11k_pci 0000:07:00.0: ignore reset dev flags 0xc000
>> [   29.259157] ath11k_pci 0000:07:00.0: failed to wait wlan mode request (mode 4): -110
>> [   29.259229] ath11k_pci 0000:07:00.0: qmi failed to send wlan mode off: -110
>> - Second after this, I commanded the unbinded (ath11_pci) and I get the
>> warning. Let extend here the stack trace:
>> [   24.238198]  ? free_large_kmalloc+0x57/0x90
>> [   24.238199]  ? report_bug+0x16b/0x180
>> [   24.238210]  ? handle_bug+0x3c/0x70
>> [   24.238218]  ? exc_invalid_op+0x14/0x70
>> [   24.238218]  ? asm_exc_invalid_op+0x16/0x20
>> [   24.238224]  ? free_large_kmalloc+0x57/0x90
>> [   24.238227]  ath11k_dp_free+0x99/0xb0 [ath11k]
>> [   24.238275]  ath11k_core_deinit+0x12b/0x1a0 [ath11k]
>> [   24.238287]  ath11k_pci_remove+0x7b/0x120 [ath11k_pci]
>> [   24.238294]  pci_device_remove+0x3e/0xb0
>> [   24.238304]  device_release_driver_internal+0x193/0x200
>> [   24.238315]  unbind_store+0x9d/0xb0
>> [   24.238320]  kernfs_fop_write_iter+0x13a/0x1d0
>> [   24.238330]  vfs_write+0x32e/0x470
>> [   24.238335]  ksys_write+0x5f/0xe0
>> [   24.238336]  do_syscall_64+0x5f/0xe0
>> Very easy to reproduce.
>>
> 
> 
> Thanks much for the logs, that makes sense. The timestamps explain why my earlier
> reasoning did not match the trace: unbind reaches ath11k_pci_remove() before
> ATH11K_FLAG_QMI_FAIL is set by the QMI event worker as it is held up on wlan mode off qmi

how could QMI worker set this flag? the first failure happens in
ath12k_core_qmi_firmware_ready() and upon this failure the QMI worker just break out
without setting any flag, no?

> transaction, so remove still takes the normal ath11k_core_deinit() path.
> 
> 
> -- 
> Ramesh
> 


