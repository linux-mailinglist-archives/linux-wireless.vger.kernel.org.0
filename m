Return-Path: <linux-wireless+bounces-13966-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B2799F36B
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 18:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F6911C257D6
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 16:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E6B1F9EAC;
	Tue, 15 Oct 2024 16:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="b43pzfuN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8901F76D6;
	Tue, 15 Oct 2024 16:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729011234; cv=none; b=RvJVa9RSDDMYwFIoebfephhwdNQzBynZpCnzMtCuem/xvFVjtwKIaokc4waGjRl5S08KGoqchzEmuVIxg37hCW0HHQGpSsK6PlObv8fxWTuqL9Bo9w0h0USutCqMmNKfDCuOElGz/Eng4VFIDwVod4D8hfcxyJTCnS9NE892UbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729011234; c=relaxed/simple;
	bh=5foqDks7fNMexzcvxQAG4RCbzaR1m91Njym0FfsBHWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FS5W8vTOKSODlUHGTgVI+j0Qa2gC/BEOEyUrguZmKr7dV1wkWgXIHRyO4GkJ7GRBuNG5VPANEUAuMtP5n203R51JMYmF4nMcWD/ql1CFHgx1Y5B4fwZ1WCMc7vWmN+F830m3YKWeJDcxSxPxr/y+lHvQgLGpePnaXMq8ZJEt7Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=b43pzfuN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FEQivp025503;
	Tue, 15 Oct 2024 16:53:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sCcqLjmtyd0R/GKk2wrH0afTylOfcmr6+66Oyo7EANA=; b=b43pzfuNu6dd1v6l
	5/QhXbsTjLc0edj8xQmK3OBB5eUU9nO9lKp76KBMeAwR6XSAJgG92/ge0pLQs9ox
	GUO3eDVFi8bhKibhqjB10V3mrQiiBUwg7O15uDIGOFatien5bpggPvVhGJCt/Ryd
	Xl+jsr+JI4JW3AL4lbmrP371YMibDyflmMrz8n1+FzzFtRkpcSic3u2XC37R3vJW
	AetBB6MRHlpCiyrOrZGlsdjQ9bPGDdjrtS1fHWoZFl8TuJTDnWomC/o0Gmzrfy0B
	KV9feZFLMqMONLgeB4OmzLw3Ov+YUcEpoyljvbeqkW92ryJ1SN6PDyMudLS67JB5
	jca2ww==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 429t5kgfv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 16:53:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49FGrkIN002813
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 16:53:46 GMT
Received: from [10.48.240.238] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 15 Oct
 2024 09:53:45 -0700
Message-ID: <039e7ccb-adb2-4c36-bd5b-83b5965373d7@quicinc.com>
Date: Tue, 15 Oct 2024 09:53:44 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: ath12k: fix crash when unbinding
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>, <kvalo@kernel.org>,
        <jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
        <ath12k@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <stable@vger.kernel.org>
References: <20241010175102.207324-1-jtornosm@redhat.com>
 <20241010175102.207324-2-jtornosm@redhat.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241010175102.207324-2-jtornosm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CtKT2c5fo_UE6BI5iwvU9pUBOkoI0Xqb
X-Proofpoint-GUID: CtKT2c5fo_UE6BI5iwvU9pUBOkoI0Xqb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 bulkscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 clxscore=1015 suspectscore=0 mlxlogscore=776
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410150115

On 10/10/2024 10:48 AM, Jose Ignacio Tornos Martinez wrote:
> If there is an error during some initialization realated to firmware,
> the funcion ath12k_dp_cc_cleanup is already call to release resources.

s/funcion/function/

> However this is released again when the device is unbinded (ath12k_pci),
> and we get:
> [  382.050650] BUG: kernel NULL pointer dereference, address: 0000000000000020
> [  382.050656] #PF: supervisor read access in kernel mode
> [  382.050657] #PF: error_code(0x0000) - not-present page
> [  382.050659] PGD 0 P4D 0
> [  382.050661] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
> [  382.050664] CPU: 0 UID: 0 PID: 6541 Comm: bash Kdump: loaded Not tainted 6.12.0-rc1+ #14
> [  382.050666] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-2.fc40 04/01/2014
> [  382.050667] RIP: 0010:ath12k_dp_cc_cleanup.part.0+0xb6/0x500 [ath12k]
> [  382.050688] Code: 8b 76 28 48 8b 7b 10 45 31 c0 b9 02 00 00 00 e8 30 3d 35 c2 be 02 00 00 00 4c 89 f7 e8 e3 00 fb c2 49 83 c7 28 49 39 ef 74 31 <41> f6 47 20 01 75 ab 4c 89 ff e8 2b de a2 c2 84 c0 74 0e 49 8b 17
> [  382.050689] RSP: 0018:ffffa3e3c0e83990 EFLAGS: 00010297
> [  382.050691] RAX: 0000000000000000 RBX: ffff90de08750000 RCX: 0000000000000000
> [  382.050692] RDX: 0000000000000001 RSI: ffff90de08751178 RDI: ffff90de08751970
> [  382.050693] RBP: 0000000000005000 R08: 0000000000000200 R09: 000000000040003f
> [  382.050694] R10: 000000000040003f R11: 0000000000000000 R12: dead000000000122
> [  382.050695] R13: dead000000000100 R14: ffffffffc0b6f948 R15: 0000000000000000
> [  382.050696] FS:  00007f216b1ab740(0000) GS:ffff90de5fc00000(0000) knlGS:0000000000000000
> [  382.050698] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  382.050699] CR2: 0000000000000020 CR3: 000000001a26c000 CR4: 0000000000752ef0
> [  382.050702] PKRU: 55555554
> [  382.050703] Call Trace:
> [  382.050705]  <TASK>
> [  382.050707]  ? __die_body.cold+0x19/0x27
> [  382.050719]  ? page_fault_oops+0x15a/0x2f0
> [  382.050723]  ? exc_page_fault+0x7e/0x180
> [  382.050724]  ? asm_exc_page_fault+0x26/0x30
> [  382.050729]  ? ath12k_dp_cc_cleanup.part.0+0xb6/0x500 [ath12k]
> [  382.050740]  ? delay_halt_tpause+0x1a/0x20
> [  382.050742]  ath12k_dp_free+0x67/0x110 [ath12k]
> [  382.050753]  ath12k_core_deinit+0x8d/0xb0 [ath12k]
> [  382.050762]  ath12k_pci_remove+0x50/0xf0 [ath12k]
> [  382.050771]  pci_device_remove+0x3f/0xb0
> [  382.050773]  device_release_driver_internal+0x19c/0x200
> [  382.050777]  unbind_store+0xa1/0xb0
> ...
> 
> The issue is always reproducible from a VM because the MSI addressing
> initialization is failing.
> 
> In order to fix the issue, just set to NULL the relaeased structure in
> ath12k_dp_cc_cleanup at the end.
> 
> cc: stable@vger.kernel.org
> Fixes: d889913205cf7 ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")

WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")' - ie: 'Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")'
#51: 
Fixes: d889913205cf7 ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")

same comment applies to the 2/2 patch

> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
>  drivers/net/wireless/ath/ath12k/dp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
> index 61aa78d8bd8c..789d430e4455 100644
> --- a/drivers/net/wireless/ath/ath12k/dp.c
> +++ b/drivers/net/wireless/ath/ath12k/dp.c
> @@ -1241,6 +1241,7 @@ static void ath12k_dp_cc_cleanup(struct ath12k_base *ab)
>  	}
>  
>  	kfree(dp->spt_info);
> +	dp->spt_info = NULL;
>  }
>  
>  static void ath12k_dp_reoq_lut_cleanup(struct ath12k_base *ab)


