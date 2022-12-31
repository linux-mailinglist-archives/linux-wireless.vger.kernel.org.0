Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9D865A5D6
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Dec 2022 17:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiLaQ4v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 31 Dec 2022 11:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiLaQ4u (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 31 Dec 2022 11:56:50 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BE0EA1
        for <linux-wireless@vger.kernel.org>; Sat, 31 Dec 2022 08:56:49 -0800 (PST)
Received: from [192.168.1.139] ([37.4.248.41]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M42fG-1pBf9z0bIG-00013c; Sat, 31 Dec 2022 17:56:39 +0100
Message-ID: <a0eb448d-07b5-1b39-2bc5-7b804d78340d@i2se.com>
Date:   Sat, 31 Dec 2022 17:56:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: Regression in brcmfmac for 6.1/6.2-rc1 for SDIO devices
Content-Language: en-US
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
 <9229905f-e7a5-aa86-c3f6-887046b8e663@i2se.com>
 <CALeDE9OFbrf5x-3CRecXkYxb-2Z1YgH7d4Yk4RPv4Wn+zinhbw@mail.gmail.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <CALeDE9OFbrf5x-3CRecXkYxb-2Z1YgH7d4Yk4RPv4Wn+zinhbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3iDbC2LBuo+Q2WJlLOVSf8XVVaU1eHwA9XCQLpbKoanGBxHNLEY
 4tG41f3Iod1mHV7HfYOwj+XabTUCwAbEA6Ge+BNh3yLPrCKYWIL3UT49urcxBTP1Cmr4T56
 /BMoE0MTar1H7NA+xuNH1ll93hZgTUnVX19sQY8JBn32TeOWjtBCzlW4Di5qBb50GBmLPak
 ts8HJ6+gXrdHjsJXyehgw==
UI-OutboundReport: notjunk:1;M01:P0:BfCx6XawqTA=;TTNX1ZM6LxypurmXfMSvzwVftCO
 QZ9RQi+Gz7xhGTHm+J9bu3jjYVwsmwowjNEGjE9q01Xvv2BhSGYJWbxrC6rC1M0F2GsVw+3Rq
 mXOEhAbOi82dEpKd/Ht+0scICSXfhPmeJPXjNwo7sKx5NAQSJ6FGTppntT4uV+8iljlVGE8vw
 XnYCqmc31NJ8UQLWax0b/hrLaD9EwZdaeiXSWy8/5/UiaIqtZj3B17tGd+6Y6pvara3LgnaDw
 Q62g4if1/C+a2q2ye1YaFJ2wPSL6hsxd4JecZIzrzB5PbopJDj5vsPvSnfIbIftXdvbIqo01v
 tKomrdu6inIRwan7kO6zS9aU7cTAQw7SHhLDbKEA2VU8XpevKQzeUDTMSI6ZJMThx7yZqurfW
 u1Mnd7TGwD067kOqMCGs3J87ThF1eA1NGKHw/GHr/0y7kyQh2huRTMdnMDg4lGSJxgcO4XQcm
 GlrK+U6z4nqMDZTgqRRBMAaW19n8n2Yv+ABKfM1yxYh30daWhYVH5CU/aKgFTSmLgRGm+ihbr
 miRTPv1JOGqHYtzTlt5mJxkQugt/tLJweSTVjmdS83MIvQa8kMHEJAXVr/uSycC4XkB7wSnCX
 5cY+EmpAZIvs+/du79KPDR+KozeyTJQNcK9ckAQX4F1SlqUbuHT89O678o8DR/zdfRCCGzknF
 n/yOlyk4kSfWLuCXZITr3v1h3bSzU/X/735kG2EhYg==
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Peter,

Am 31.12.22 um 16:58 schrieb Peter Robinson:
> Hi Stefan,
>
>>>> could you please provide a "bad case" file list of all firmware files
>>>> for the Raspberry Pi 3 B+ which worked before Linux 6.1, so i can
>>>> reproduce it?
>>> What do you mean by the file list?
>> if you look into the firmware directory which files for
>> brcmfmac43455-sdio do you have? Just the bin file?
>>
>> I'm using the rootfs of Raspberry Pi OS which contains:
>>
>> $ ls brcmfmac43455-sdio*
>> brcmfmac43455-sdio.bin  brcmfmac43455-sdio.clm_blob brcmfmac43455-sdio.txt

i temporary moved the clm_blob and txt file from the directory and 
switched to Linux v6.0 (multi_v7_defconfig), but the driver doesn't probe:

[   25.943350] brcmfmac: brcmf_fw_alloc_request: using 
brcm/brcmfmac43455-sdio for chip BCM4345/6
[   25.943550] brcmfmac mmc1:0001:1: Direct firmware load for 
brcm/brcmfmac43455-sdio.raspberrypi,3-model-b-plus.bin failed with error -2
[   26.071070] brcmfmac mmc1:0001:1: Direct firmware load for 
brcm/brcmfmac43455-sdio.raspberrypi,3-model-b-plus.txt failed with error -2
[   26.071133] brcmfmac mmc1:0001:1: Direct firmware load for 
brcm/brcmfmac43455-sdio.txt failed with error -2
[   27.078481] brcmfmac: brcmf_sdio_htclk: HT Avail timeout (1000000): 
clkctl 0x50

>> [   25.943350] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43455-sdio for chip BCM4345/6
>> [   25.943550] brcmfmac mmc1:0001:1: Direct firmware load for brcm/brcmfmac43455-sdio.raspberrypi,3-model-b-plus.bin failed with error -2
>> [   26.071070] brcmfmac mmc1:0001:1: Direct firmware load for brcm/brcmfmac43455-sdio.raspberrypi,3-model-b-plus.txt failed with error -2
>> [   26.071133] brcmfmac mmc1:0001:1: Direct firmware load for brcm/brcmfmac43455-sdio.txt failed with error -2
>> [   27.078481] brcmfmac: brcmf_sdio_htclk: HT Avail timeout (1000000): clkctl 0x50
> As shipped in https://mirrors.edge.kernel.org/pub/linux/kernel/firmware/
> either the Nov or Dec releases
>
> The kernel supports compressing firmware with: xz -C crc32 "$f"
>
> Regards,
> Peter
>
>> I didn't say please add some files, i only need a test scenario :-)
>>
>>>    We're running the latest upstream
>>> firmware, we do used compressed firmware but that hasn't regressed
>>> with any of the other firmware, this is very much brcmfmac. With the
>>> same firmware it was working on 6.0.x and reboot into a 6.1+ kernel
>>> and it stops with nothing else changed.
>> Yes, i agree this is a regression and yes it's definitely brcmfmac, but
>> based on your bug report i wasn't able to reproduce.
>>
>> Regards
>>
>>>> Also OpenSuSE seems to be affected [1].
>>>>
>>>> [1] - https://bugzilla.suse.com/show_bug.cgi?id=1206697
>>>>
>>>> Regards
>>>> Stefan
>>>>
