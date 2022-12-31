Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD27B65A588
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Dec 2022 16:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiLaPaK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 31 Dec 2022 10:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiLaPaJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 31 Dec 2022 10:30:09 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CFA2654
        for <linux-wireless@vger.kernel.org>; Sat, 31 Dec 2022 07:30:07 -0800 (PST)
Received: from [192.168.1.139] ([37.4.248.41]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N7RDn-1okVUy3vTh-017m4O; Sat, 31 Dec 2022 16:29:54 +0100
Message-ID: <9229905f-e7a5-aa86-c3f6-887046b8e663@i2se.com>
Date:   Sat, 31 Dec 2022 16:29:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: Regression in brcmfmac for 6.1/6.2-rc1 for SDIO devices
To:     Peter Robinson <pbrobinson@gmail.com>
Cc:     Justin Forbes <jforbes@fedoraproject.org>,
        regressions@lists.linux.dev, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Arend van Spriel <aspriel@gmail.com>,
        "Ivan T. Ivanov" <iivanov@suse.de>
References: <CALeDE9O1+qgn_9z=zTVKbWx3FphEa4y8Dn9f5ORoQgW_gL1dqg@mail.gmail.com>
 <d88f4aff-45ad-db10-ada3-f7f5b34a6620@i2se.com>
 <CALeDE9O_qX_Gu1vwCLW_PbMdgnSoHTA5LhxYQrsUqwGHRwv-Eg@mail.gmail.com>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <CALeDE9O_qX_Gu1vwCLW_PbMdgnSoHTA5LhxYQrsUqwGHRwv-Eg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:vQEiGX7l7+mEyKlwRl7Ar70SIEAhyIYDiKrKNpoolUwJX7LiSIp
 MKb+iMl+hw81MUJXITCEPBUe52/06bFE9yfJGKrqD9dP86WZtzqHxQo362JoLJAOtn/T82w
 h4ehfDGyKSzxKBp+5/y7gxFZkBwpGgNlQCzNUmmo6LSzvBebn4Axp5DSEi43tj4mH4t31uP
 c9ARu3CLeVIusD+UCoxow==
UI-OutboundReport: notjunk:1;M01:P0:DgEjIdWOqIs=;V+6wT5sMQEbRqKhpJl2oAYAt7YC
 Xkicen7UL5VE4+jdVK+KRYrbiqqacSSZ5tuNJUyE+fM/hzQ3XSU514AQ/LJ8ibhAeRsReHE3v
 RCAPDJReH+YUzb1zuSqjy30/v2Sh7Henli7LZOjejv30KhPOgWz8pRUSUuiptLIhbiRb50b9u
 gFfUW1eVKO1cb9wrEKyo+vP8uWVFOMzijSwrvOyjT+4wWYFxQK0xCa3/Iz+ozSDiw6FI9RxZp
 K8AL6sM3roKPNjCVH7fbu82iGZrB7+/0B7wtPQZCyARL/DkW3oDhJo3t5GohWUEYeYDmpMaui
 WELlyaisRttZutGE63/dt7CaZkt/X5lbv7o0BYdfQek+SyVvBaqa+Gg58ZQDHiI7G2fKRsfpd
 9H8sXVFUuWLmfOzjnOc87fGoTtT6N+h5WrhzKIhF9mwSxWyzcFAMbK87FaSLUXVomjGpLdgnZ
 535CyFJyfPaq7RgsA31eIFoHI6qu2ym7DFy1N9RWl56zcwaQywuOngao2eG8ozpOFABFNUR++
 TFkbgxUjGuw0bUtgbPATkRX4K1XXu5iZ9zMyDcGPHTSFN6tNC5aBQNz1r5nmUZbwYYxjubqb8
 dN9y9eBYwZDUobZuWjeej6ZYgR6+VoPq12L2Uom3QXDTDuJAYzWwVuzi/6HNx8GbSFK6NzR7B
 d+ZsZQzcj1zkH9UH1fVrau+ITV31BqpB6iwcxSp6eg==
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Peter,

Am 31.12.22 um 15:33 schrieb Peter Robinson:
> Hi Stefan,
>
>> could you please provide a "bad case" file list of all firmware files
>> for the Raspberry Pi 3 B+ which worked before Linux 6.1, so i can
>> reproduce it?
> What do you mean by the file list?

if you look into the firmware directory which files for 
brcmfmac43455-sdio do you have? Just the bin file?

I'm using the rootfs of Raspberry Pi OS which contains:

$ ls brcmfmac43455-sdio*
brcmfmac43455-sdio.bin  brcmfmac43455-sdio.clm_blob brcmfmac43455-sdio.txt

I didn't say please add some files, i only need a test scenario :-)

>   We're running the latest upstream
> firmware, we do used compressed firmware but that hasn't regressed
> with any of the other firmware, this is very much brcmfmac. With the
> same firmware it was working on 6.0.x and reboot into a 6.1+ kernel
> and it stops with nothing else changed.

Yes, i agree this is a regression and yes it's definitely brcmfmac, but 
based on your bug report i wasn't able to reproduce.

Regards

>
>> Also OpenSuSE seems to be affected [1].
>>
>> [1] - https://bugzilla.suse.com/show_bug.cgi?id=1206697
>>
>> Regards
>> Stefan
>>
