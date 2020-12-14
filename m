Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9032D99F0
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Dec 2020 15:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408235AbgLNO1Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Dec 2020 09:27:16 -0500
Received: from 6.mo173.mail-out.ovh.net ([46.105.43.93]:60323 "EHLO
        6.mo173.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731677AbgLNO1P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Dec 2020 09:27:15 -0500
X-Greylist: delayed 4201 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Dec 2020 09:27:13 EST
Received: from player693.ha.ovh.net (unknown [10.108.57.139])
        by mo173.mail-out.ovh.net (Postfix) with ESMTP id 5CDCF154D2F
        for <linux-wireless@vger.kernel.org>; Mon, 14 Dec 2020 11:14:23 +0100 (CET)
Received: from milecki.pl (ip-194-187-74-233.konfederacka.maverick.com.pl [194.187.74.233])
        (Authenticated sender: rafal@milecki.pl)
        by player693.ha.ovh.net (Postfix) with ESMTPSA id A704C191BDB5D;
        Mon, 14 Dec 2020 10:14:10 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-99G0039eabc947-e82d-4a22-821d-8b256cb3d330,
                    9D4513A06938E8562C9FC8D5040FBB067C1A90C8) smtp.auth=rafal@milecki.pl
X-OVh-ClientIp: 194.187.74.233
Subject: Re: [PATCH] brcmfmac: support BCM4365E with 43666 ChipCommon chip ID
To:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        sha-cyfmac-dev-list@infineon.com
References: <20201210190819.10444-1-zajec5@gmail.com>
 <5c4de2d5-5738-12f2-9f2f-92c2f31376a7@broadcom.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Message-ID: <36fd504e-465b-05b9-2a60-1da0c31dd1fe@milecki.pl>
Date:   Mon, 14 Dec 2020 11:14:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <5c4de2d5-5738-12f2-9f2f-92c2f31376a7@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 4250835099627065044
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrudekkedgudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomheptfgrfhgrlhcuofhilhgvtghkihcuoehrrghfrghlsehmihhlvggtkhhirdhplheqnecuggftrfgrthhtvghrnhepkeduheejheffudefhffghfegjeejleetkeevueelveegkefhhfffieehleelgfevnecukfhppedtrddtrddtrddtpdduleegrddukeejrdejgedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheileefrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheprhgrfhgrlhesmhhilhgvtghkihdrphhlpdhrtghpthhtoheplhhinhhugidqfihirhgvlhgvshhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 14.12.2020 10:30, Arend van Spriel wrote:
> On 10-12-2020 20:08, Rafał Miłecki wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> This adds support for the BCM43666/4 which seems to be using the same
>> firmware as BCM4366 (4366c0). I found it in the Netgear R8000P router.
> 
> minor nit below...
> 
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>> ---
>>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c       | 1 +
>>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c       | 1 +
>>   drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h | 1 +
>>   3 files changed, 3 insertions(+)
> 
> [...]
> 
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
>> index 45bc502fcb34..ff3721b20a9f 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
>> @@ -77,6 +77,7 @@ static const struct brcmf_firmware_mapping brcmf_pcie_fwnames[] = {
>>       BRCMF_FW_ENTRY(BRCM_CC_4366_CHIP_ID, 0x0000000F, 4366B),
>>       BRCMF_FW_ENTRY(BRCM_CC_4366_CHIP_ID, 0xFFFFFFF0, 4366C),
>>       BRCMF_FW_ENTRY(BRCM_CC_43664_CHIP_ID, 0xFFFFFFF0, 4366C),
>> +    BRCMF_FW_ENTRY(BRCM_CC_43666_CHIP_ID, 0x00000010, 4366C),
> 
> Our default approach is to enable it for all future revisions as was done for the two entries before this one.
> 
>>       BRCMF_FW_ENTRY(BRCM_CC_4371_CHIP_ID, 0xFFFFFFFF, 4371),
>>   };

Thanks!



 > This electronic communication and the information and any files transmitted with it, or attached to it, are confidential and are intended solely for the use of the individual or entity to whom it is addressed and may contain information that is confidential, legally privileged, protected by privacy laws, or otherwise restricted from disclosure to anyone else. If you are not the intended recipient or the person responsible for delivering the e-mail to the intended recipient, you are hereby 
notified that any use, copying, distributing, dissemination, forwarding, printing, or copying of this e-mail is strictly prohibited. If you received this e-mail in error, please return the e-mail to the sender, delete it from your computer, and destroy any printed copy of it.

This is probably unintended for public mailing lists :)
