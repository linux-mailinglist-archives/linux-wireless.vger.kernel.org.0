Return-Path: <linux-wireless+bounces-26246-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D796CB206BB
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 13:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAB8F18887BC
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 11:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F028158DAC;
	Mon, 11 Aug 2025 11:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kD5B9S0E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C413287274
	for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 11:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754910018; cv=none; b=ds+XsQbY3FRQnFbJEzRzvdm6xK0LlE6BGS3tsdLVsiZw85mt7SAjgL/RE9UfQjKtY/5tX192DU/EsvRIEoWuqVdvBarxMYraOblQheyL0pWk5a5W1NDi/f/79j44qR3v7uW04J0ssPYgKH8dlgU13mMSzNY2OjWIIMaRF0wdi8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754910018; c=relaxed/simple;
	bh=csFkcwiFTnN4toxznl6KRR9OwJuMIQk7+TN/r/TMPDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AtKnKRWy0tncU0V6jEj6h/iEja7eP0vZIaDDfAD+SfMIT32WDE5vutciYw4nBCb4TE05+S3FnB+2SahOW0kp3o/JiblmBsQVgZLXlHAV6ngHmzmMYj08dE6oOr+q9RIAMtqlKSTvzUeeUdnzlnW2o5uxP9kLQT0K5Td+jKY24Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kD5B9S0E; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9dHHf005235
	for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 11:00:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HS/ta4yBGkpVoS3ngifx4E5rBvLp+figUU3W3HlrwZ0=; b=kD5B9S0EjM4VQRHk
	ciGdsW+LVK1WruIeIYDRqPvMIEQpjfo7mWRNOdXXSTWK+2eRAmvDc20vZ7Jc2lzo
	QkJKn/CtzCIAx+3jFcegENAG9MCJtfefGBHh8LDVcqzwlWyHkfneOxfqbODNQg/d
	imY5aLCYg8N2N/quPkzCVMgLItHlB7Ji05cn8eFs4Cnfy03jbJFxjW8O48D9jebA
	ccsvKqAA7ZSHw9a7vujQ5ojwSOTS5DdlVIQeKv9FdSHiGJ7VUOgqUwlXmJZ8DqJ6
	wZUU847EDkI36/XFWrbKYyHkRnWHywBur+2pybExoJnBcHcM5LEdtTbz/t8kUfge
	0QmIbg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48eqhx2akj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 11:00:14 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3217ba6843cso3403220a91.2
        for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 04:00:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754910013; x=1755514813;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HS/ta4yBGkpVoS3ngifx4E5rBvLp+figUU3W3HlrwZ0=;
        b=Fg6WgAnCU10ljc/1iIM8zeQeqIG8eLz4HaZW3JFHvjg+7o017JZqcRsghkGue+MmAQ
         EUgnUHwA3kwhL0hxxVdEJETMWojV8efVbiJ5XAnBZTDHpTI9rc/RRuiBYWNa8o1KJ3kY
         IVgxoQ4HH49rrCX5g3mqyapy6Fp3DxDRPbMW9Fhd1t1A6rkmwpedIBL5+u2VPAYrbCjP
         nJaajko77csb3BLWRTx/rqneZAeMkdcdnW1syOfRpSseN4UuRT8Ix99FUyB/KJODx4sz
         HNFgoH5mjLs1M8jZ4CjsyXlFBotn8IRecKOmw9UZq/A1DuyhO5uw5O/BbCnhP1xzYpxP
         ob2w==
X-Gm-Message-State: AOJu0YyEUyGt3Y1XXcHhTQlv6d6XiCG0WHgYfcWZRqLpf5MJRa/UQUPA
	5gagfA9MuDktLdyfda3vgYJIml3DY8LlG3srByppUNcly5LOBrPBNkTfCUQCprKyrKWLgD2hYJv
	5wjQ0xFK7CfM1NFR+ryy8A83W4XI+fJWNIgPiSLjiNQrg5vwyHN0Ky6wAqVSfPsdGrJtF2A==
X-Gm-Gg: ASbGncuL55CIPJPfW1mzUuSwvMx16taF6mDaS50OVO5waHsskdNkawo8neWz5Ef86Ao
	WmXiUNTH2qu50G22BkOAHZqdIxWlm1wCfPeW+Hcwx9BLknoyCRwhfPeQf4FQ6m2+8DcD8ng36rd
	243MjFyplGHX3A4kjD4hQYJdvZGMS/bn/7YUUgU6kY05yL2gufW//Rchd4abY6y20/9Ry0qR1V0
	hB+TDiWIptGXgXurfNc0ej2FRrFdtCisruWc3JnDhxgKTiqJ/fzcMid48zfKezpeWGXjqdKodv0
	pQr4YVIihXUIEsAkXWF64gHxZCmrlJxejK6G9C752fUtdKB/6P4eApnggjObwdKdOJ8RQ5x1vrk
	qqSh01g+0c2nWVtsgdC7ozU2HipOxwUA=
X-Received: by 2002:a17:90b:3941:b0:31f:2fed:7867 with SMTP id 98e67ed59e1d1-32183e56240mr15994639a91.34.1754910011235;
        Mon, 11 Aug 2025 04:00:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsLCOX4Ei5OrlcZWraE/0NqWIq2ts/bbBOVsc0SwETdejjjh/qiCjX+YWrOY5C8hc/ZvW/Ig==
X-Received: by 2002:a17:90b:3941:b0:31f:2fed:7867 with SMTP id 98e67ed59e1d1-32183e56240mr15994561a91.34.1754910010413;
        Mon, 11 Aug 2025 04:00:10 -0700 (PDT)
Received: from [10.133.33.19] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32161282ab6sm14756303a91.26.2025.08.11.04.00.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 04:00:10 -0700 (PDT)
Message-ID: <ecab2156-b234-4fba-a2ad-13a2d9b4693f@oss.qualcomm.com>
Date: Mon, 11 Aug 2025 19:00:06 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ath11k: pci: avoid unsafe register access during shutdown
To: Balsam Chihi <balsam.chihi@moment.tech>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        jjohnson@kernel.org
References: <20250611164004.38580-1-balsam.chihi@moment.tech>
 <91fa8b1d-7bd0-4beb-80ef-eb65d2562f17@oss.qualcomm.com>
 <CAONkfw5Xyk8CGmVDpWZfkWnuCcFq6400jUkqyeMDtS0UNSh9vg@mail.gmail.com>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <CAONkfw5Xyk8CGmVDpWZfkWnuCcFq6400jUkqyeMDtS0UNSh9vg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA1NyBTYWx0ZWRfX2VLM1Ux3z61c
 EAKtXHKllvtA1xbaZip6c/HKyxpj/P04EKgOWYrulXCBTRATNHUlPzHN/ZmXOktbjgvJrYYWK8b
 MFe87PMGGnxBG1+kugQ8UJwTifjbKGd1HfjsgKtHCErSaeONxe7hB6Yi5UWSJFJdtkijjeyDiVR
 t/Up0Pd/HVdqxenSvHK9I5pWnetRHD938FiNt+vs8l/lj3XmA6ljpkDf1yB3QT4UnHw9AHKy664
 OfjmAhAYMLHiEDNkccB21tB+R127IY5bWSCe2hB0MB+eSa9m39oigTITpW5bhFPkt1wohOueaO/
 +osHKGyleMxJrjCJGjS+0+kIlzHKyj0hYVbolSAgVAZ09at/5BmTKxbch7l08KBuLgBCko4/oSn
 BHUxMrcf
X-Proofpoint-GUID: Z0HC9aqmcH-x5pGGVuXwhhmZIg_tr0fc
X-Authority-Analysis: v=2.4 cv=aYNhnQot c=1 sm=1 tr=0 ts=6899cd3e cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=0tQjBkgDMsDxDV5ERwMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: Z0HC9aqmcH-x5pGGVuXwhhmZIg_tr0fc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508100057



On 8/11/2025 5:08 PM, Balsam Chihi wrote:
> On Fri, Jul 25, 2025 at 5:25 AM Baochen Qiang
> <baochen.qiang@oss.qualcomm.com> wrote:
>>
>>
>>
>> On 6/12/2025 12:40 AM, balsam.chihi@moment.tech wrote:
>>> From: Balsam CHIHI <balsam.chihi@moment.tech>
>>>
> 
> Hello, sorry for the delay. I was OoO.
> 
>>> During system reboot or module removal (rmmod), a crash was observed
>>> due to a synchronous external abort caused by invalid register access
>>> in ath11k_pci_clear_dbg_registers(). This happens when the device is
>>> already powered off and the driver attempts to read debug registers.
>>
>> What does 'powered off' mean exactly here? is WLAN powered by an internal/external supply
>> that will be removed during rmmod/reboot?
> 
> The "powered off" means that the wlan card is rmmod or reboot.
> It is not powered by external supply.

OK.

> 
>>
>>>
>>> The crash log shows:
>>> root@OpenWrt:~# reboot
>>> [  343.663492] Internal error: synchronous external abort:
>>> 0000000096000210 [#1] SMP
>>> [  343.670992] Modules linked in: [...]
>>> [  343.842432] CPU: 7 PID: 9435 Comm: procd Tainted: G O 6.6.86 #0
>>> [  343.849746] Hardware name: LS1088A
>>> [  343.856969] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>> [  343.863933] pc : ath11k_pci_get_msi_irq+0x18a0/0x1900 [ath11k_pci]
>>
>> I don't see any relationship between ath11k_pci_clear_dbg_registers() and this PC pointer.
>> So how did you locate the problematic register access then?
> 
> I tyied to look for the problem based the PC pointer but I was not
> abled to find it.
> So, I added prints in ath11k driver to find out where it stucks,
> classical debug method.

Yeah, classical and always work.

> Then I found out that any "ath11k_pcic_read32()" call fails on rmmod
> ath11k_pci or reboot,

I worry PCIe link is not stable on your platform when rmmod/reboot. Can you try with ASPM
disabled?

--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -605,11 +605,13 @@ static void ath11k_pci_aspm_disable(struct ath11k_pci *ab_pci)

 static void ath11k_pci_aspm_restore(struct ath11k_pci *ab_pci)
 {
+#if 0
        if (test_and_clear_bit(ATH11K_PCI_ASPM_RESTORE, &ab_pci->flags))
                pcie_capability_clear_and_set_word(ab_pci->pdev, PCI_EXP_LNKCTL,
                                                   PCI_EXP_LNKCTL_ASPMC,
                                                   ab_pci->link_ctl &
                                                   PCI_EXP_LNKCTL_ASPMC);
+#endif
 }

 #ifdef CONFIG_DEV_COREDUMP


> but they work fine when insmod/boot ath11k_pci.
> 
>>
>>> [  343.870125] lr : ath11k_pcic_init_msi_config+0x98/0xc4 [ath11k]
>>> [...]
>>> [  343.950800] Call trace:
>>> [  343.953241]  ath11k_pci_get_msi_irq+0x18a0/0x1900 [ath11k_pci]
>>> [  343.959080]  ath11k_pcic_init_msi_config+0x98/0xc4 [ath11k]
>>> [  343.964671]  ath11k_pcic_read32+0x30/0xb4 [ath11k]
>>> [  343.969477]  ath11k_pci_get_msi_irq+0x528/0x1900 [ath11k_pci]
>>> [  343.975230]  ath11k_pci_get_msi_irq+0x1460/0x1900 [ath11k_pci]
>>> [  343.981068]  ath11k_pci_get_msi_irq+0x1750/0x1900 [ath11k_pci]
>>> [  343.986906]  pci_device_shutdown+0x34/0x44
>>> [  343.991004]  device_shutdown+0x160/0x268
>>> [  343.994928]  kernel_restart+0x40/0xc0
>>> [  343.998594]  __do_sys_reboot+0x104/0x23c
>>> [  344.002518]  __arm64_sys_reboot+0x24/0x30
>>> [  344.006529]  do_el0_svc+0x6c/0x100
>>> [  344.009931]  el0_svc+0x28/0x9c
>>> [  344.012986]  el0t_64_sync_handler+0x120/0x12c
>>> [  344.017344]  el0t_64_sync+0x178/0x17c
>>> [  344.021009] Code: f94e0a80 92404a73 91420273 8b130013 (b9400273)
>>> [  344.027102] ---[ end trace 0000000000000000 ]---
>>>
>>> This patch adds a `power_on` flag to conditionally skip debug register
>>> reads when the device is not powered, preventing invalid memory access.
>>
>> why is only 'read' concerned here?
> 
> Good question, I can't explain why only the reading fails but not the writing.
> 
>>
>> You are skipping several 'read' in this change, could you help narrow down which
>> individual read instance causes this?
>>
> 
> All read calls fail on rmmod/reboot, when
> ath11k_pci_clear_dbg_registers() is called.
> But they all succeed when insmod/boot ath11k_pci.
> 
>>>
>>> With this change, the system no longer crashes on reboot or rmmod,
>>> and the driver continues to function correctly when reloaded.
>>>
>>> Tested-on: QCN9074 hw2.0 PCIe on LS1088A
>>> Tested-on: OpenWrt 24.10.1
>>> Fixes: crash on reboot/rmmod due to invalid register access
>>> Signed-off-by: Balsam CHIHI <balsam.chihi@moment.tech>
>>> ---
>>>  drivers/net/wireless/ath/ath11k/pci.c | 36 ++++++++++++++++-----------
>>>  1 file changed, 21 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
>>> index 78444f8ea153..0c1b55957557 100644
>>> --- a/drivers/net/wireless/ath/ath11k/pci.c
>>> +++ b/drivers/net/wireless/ath/ath11k/pci.c
>>> @@ -203,16 +203,18 @@ static void ath11k_pci_soc_global_reset(struct ath11k_base *ab)
>>>               ath11k_warn(ab, "link down error during global reset\n");
>>>  }
>>>
>>> -static void ath11k_pci_clear_dbg_registers(struct ath11k_base *ab)
>>> +static void ath11k_pci_clear_dbg_registers(struct ath11k_base *ab, bool power_on)
>>>  {
>>> -     u32 val;
>>> +     if (power_on) {
>>> +             u32 val;
>>>
>>> -     /* read cookie */
>>> -     val = ath11k_pcic_read32(ab, PCIE_Q6_COOKIE_ADDR);
>>> -     ath11k_dbg(ab, ATH11K_DBG_PCI, "pcie_q6_cookie_addr 0x%x\n", val);
>>> +             /* read cookie */
>>> +             val = ath11k_pcic_read32(ab, PCIE_Q6_COOKIE_ADDR);
>>> +             ath11k_dbg(ab, ATH11K_DBG_PCI, "pcie_q6_cookie_addr 0x%x\n", val);
>>>
>>> -     val = ath11k_pcic_read32(ab, WLAON_WARM_SW_ENTRY);
>>> -     ath11k_dbg(ab, ATH11K_DBG_PCI, "wlaon_warm_sw_entry 0x%x\n", val);
>>> +             val = ath11k_pcic_read32(ab, WLAON_WARM_SW_ENTRY);
>>> +             ath11k_dbg(ab, ATH11K_DBG_PCI, "wlaon_warm_sw_entry 0x%x\n", val);
>>> +     }
>>>
>>>       /* TODO: exact time to sleep is uncertain */
>>>       mdelay(10);
>>> @@ -223,14 +225,18 @@ static void ath11k_pci_clear_dbg_registers(struct ath11k_base *ab)
>>>       ath11k_pcic_write32(ab, WLAON_WARM_SW_ENTRY, 0);
>>>       mdelay(10);
>>>
>>> -     val = ath11k_pcic_read32(ab, WLAON_WARM_SW_ENTRY);
>>> -     ath11k_dbg(ab, ATH11K_DBG_PCI, "wlaon_warm_sw_entry 0x%x\n", val);
>>> +     if (power_on) {
>>> +             u32 val;
>>>
>>> -     /* A read clear register. clear the register to prevent
>>> -      * Q6 from entering wrong code path.
>>> -      */
>>> -     val = ath11k_pcic_read32(ab, WLAON_SOC_RESET_CAUSE_REG);
>>> -     ath11k_dbg(ab, ATH11K_DBG_PCI, "soc reset cause %d\n", val);
>>> +             val = ath11k_pcic_read32(ab, WLAON_WARM_SW_ENTRY);
>>> +             ath11k_dbg(ab, ATH11K_DBG_PCI, "wlaon_warm_sw_entry 0x%x\n", val);
>>> +
>>> +             /* A read clear register. clear the register to prevent
>>> +             * Q6 from entering wrong code path.
>>> +             */
>>> +             val = ath11k_pcic_read32(ab, WLAON_SOC_RESET_CAUSE_REG);
>>> +             ath11k_dbg(ab, ATH11K_DBG_PCI, "soc reset cause %d\n", val);
>>> +     }
>>>  }
>>>
>>>  static int ath11k_pci_set_link_reg(struct ath11k_base *ab,
>>> @@ -368,7 +374,7 @@ static void ath11k_pci_sw_reset(struct ath11k_base *ab, bool power_on)
>>>       }
>>>
>>>       ath11k_mhi_clear_vector(ab);
>>> -     ath11k_pci_clear_dbg_registers(ab);
>>> +     ath11k_pci_clear_dbg_registers(ab, power_on);
>>>       ath11k_pci_soc_global_reset(ab);
>>>       ath11k_mhi_set_mhictrl_reset(ab);
>>>  }
>>
> 


