Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A794B231B
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Feb 2022 11:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbiBKK3m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Feb 2022 05:29:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346555AbiBKK3l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Feb 2022 05:29:41 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F86FEA8
        for <linux-wireless@vger.kernel.org>; Fri, 11 Feb 2022 02:29:40 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id A5B0C838AF;
        Fri, 11 Feb 2022 11:29:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1644575378;
        bh=UjEzIMuj+GSKIK7GbZIi3bWkBundRspm/k9XQGWxGsQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=wA8MOEXMB5gATUAaBSxfkoU77UYbP+onp0epezuGl37JiMjZv3RRbFL8JmfQ4xY59
         kq5xSz5dcfcF3R5FajUV3D0Ns1kMFqL+ajbI9MSQBnJupQH6vkXVZ8JuK9aN2ph5sM
         FxgELIHs21paL7C6EBSfduoXIJcNCcj2xXuCgtd3sDx1gsGVW9UpjK1zCv2MFenRsV
         RPMVh0+590hZ4JysSy7s6zzPRiORVZmAc3wErB9d4Eb1883/8AmoBhlHQj7X2iK8wi
         NAlAhl0CxzyVrKlK14AHIGf+Sh5CKgFUEuPHbKZq+sXxGNp3Ht20eE4dLzxfIYmQHz
         1GtMxlxpxKB4Q==
Message-ID: <b58861b9-86c4-3319-a183-fab637f79e08@denx.de>
Date:   Fri, 11 Feb 2022 11:29:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: Possible bug on wilc1000 [Klartext]
Content-Language: en-US
To:     Ajay.Kathat@microchip.com, cniedermaier@dh-electronics.com,
        linux-wireless@vger.kernel.org
Cc:     Claudiu.Beznea@microchip.com, Tudor.Ambarus@microchip.com,
        ageisreiter@dh-electronics.com
References: <3994a34bb0d84e9d8181ec490a3f71d2@dh-electronics.com>
 <97d9da81-f15b-33dd-a66e-9f6dbe2c3b0c@microchip.com>
 <14d8dbd0f9de4bcdb50bd1983b2e4f31@dh-electronics.com>
 <74d9191d-7bf6-2beb-2d3b-700b6a355f68@microchip.com>
 <786b6ca3-1377-fc3d-8c74-d6625a9b4ee4@denx.de>
 <10841d61-e939-6703-e195-c382ca6cebc2@microchip.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <10841d61-e939-6703-e195-c382ca6cebc2@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2/11/22 11:15, Ajay.Kathat@microchip.com wrote:
> On 10/02/22 21:55, Marek Vasut wrote:
>>
>> On 2/10/22 17:19, Ajay.Kathat@microchip.com wrote:
>>
>> Hi,
>>
>>> On 10/02/22 14:10, Christoph Niedermaier wrote:
>>>> From: Ajay.Kathat@microchip.com [mailto:Ajay.Kathat@microchip.com]
>>>> Sent: Wednesday, February 9, 2022 3:37 PM
>>>>> On 08/02/22 21:56, Christoph Niedermaier wrote:
>>>>>> Hello,
>>>>>>
>>>>>> I tested the wireless chip wilc1000 with the 5.16.5 Kernel and the
>>>>>> firmware v15.4.1
>>>>>> (https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/atmel/wilc1000_wifi_firmware-1.bin)
>>>>>>
>>>>>> on an i.MX6 QUAD with iperf3:
>>>>>>
>>>>>> # iperf3 -c IP_ADDR -P 16 -t 0
>>>>>>
>>>>>> After a while the test gets stuck and I got the following kernel
>>>>>> messages:
>>>>>> mmc0: Timeout waiting for hardware interrupt.
>>>>>> mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
>>>>>> mmc0: sdhci: Sys addr:  0x138f0200 | Version:  0x00000002
>>>>>> mmc0: sdhci: Blk size:  0x00000158 | Blk cnt:  0x00000001
>>>>>> mmc0: sdhci: Argument:  0x14000158 | Trn mode: 0x00000013
>>>>>> mmc0: sdhci: Present:   0x01d88a0a | Host ctl: 0x00000013
>>>>>> mmc0: sdhci: Power:     0x00000002 | Blk gap:  0x00000080
>>>>>> mmc0: sdhci: Wake-up:   0x00000008 | Clock:    0x0000009f
>>>>>> mmc0: sdhci: Timeout:   0x0000008f | Int stat: 0x00000000
>>>>>> mmc0: sdhci: Int enab:  0x107f100b | Sig enab: 0x107f100b
>>>>>> mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000003
>>>>>> mmc0: sdhci: Caps:      0x07eb0000 | Caps_1:   0x0000a000
>>>>>> mmc0: sdhci: Cmd:       0x0000353a | Max curr: 0x00ffffff
>>>>>> mmc0: sdhci: Resp[0]:   0x00001000 | Resp[1]:  0x00000000
>>>>>> mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
>>>>>> mmc0: sdhci: Host ctl2: 0x00000000
>>>>>> mmc0: sdhci: ADMA Err:  0x00000007 | ADMA Ptr: 0x4c041200
>>>>>> mmc0: sdhci-esdhc-imx: ========= ESDHC IMX DEBUG STATUS DUMP
>>>>>> =========
>>>>>> mmc0: sdhci-esdhc-imx: cmd debug status:  0x2100
>>>>>> mmc0: sdhci-esdhc-imx: data debug status:  0x2200
>>>>>> mmc0: sdhci-esdhc-imx: trans debug status:  0x2300
>>>>>> mmc0: sdhci-esdhc-imx: dma debug status:  0x2402
>>>>>> mmc0: sdhci-esdhc-imx: adma debug status:  0x25b4
>>>>>> mmc0: sdhci-esdhc-imx: fifo debug status:  0x2610
>>>>>> mmc0: sdhci-esdhc-imx: async fifo debug status:  0x2751
>>>>>> mmc0: sdhci: ============================================
>>>>>> wilc1000_sdio mmc0:0001:1: wilc_sdio_cmd53..failed, err(-110)
>>>>>> wilc1000_sdio mmc0:0001:1: Failed cmd53 [0], bytes read...
>>>>>>
>>>>>> I tried to reduce the clock speed to 20MHz in the devicetree with
>>>>>> max-frequency = <20000000>;
>>>>>> but the problem then also occurs.
>>>>>>
>>>>>> Is this a possible bug?
>>>>>>
>>>>>>
>>>> Hi Ajay,
>>>> Thanks for the answer.
>>>>
>>>>> The bus error seems to be specific to the host during the SDIO
>>>>> transfer.
>>>>> How long does it take to reproduce it? Does the issue also happen
>>>>> without "-P 16" iPerf3 option?
>>>> It takes about 10s (something a bit longer) till I got this kernel
>>>> error
>>>> messages and it doesn't matter if I use it with "-P 16" or without.
>>>
>>>
>>> I did not observe the issue with my setup(SAMA5D4 XPLAINED + WILC1000
>>> SDIO) when tested iPerf for a longer duration(~1000sec). I suspect the
>>> issue could be related to the SDHCI host controller.
>>> Try to debug the host controller side for the possible cause of timeout.
>>
>> It seems the timeout happens because the card fails to respond to SDIO
>> command 53, right ?
>>
> 
> Yes, the timeout could be for any reason like either the CMD53 has not
> reached to chip or response not received correctly at host end.

The problem happens seconds or tens of seconds into the test, so there 
must've been CMD53 which reached the card before the problem occurred, 
and there must have been a lot of those CMD53 before the problem 
happened too, since CMD53 seems to be some data transfer CMD ?

>> Is there some error logging/tracing functionality in the WILC1000
>> firmware which can provide further information why the card did not
>> respond ?
> 
> 
> WILC1000 SD module has UART serial debug port for firmware logs but I
> don't think it would be useful here because it needs to be debug/probe
> at SDIO bus level.

Is there some other kind of logging which can tell us more details on 
where to look for this problem ?

Maybe we can try monitoring the SDIO traffic with ftrace ?

Any other options, short of taking the hardware apart ?

>> Could it be the card suffered some sort of FIFO overflow ? The MX6Q is a
>> bit more performant than the CA7 (I think?) SAMA5D4, so maybe that plays
>> some role ?
> 
> As I understand, the issue is observed with basic iPerf testing(less
> throughput) so not sure if the host performance will have such an
> impact. IIRC few of the customers are using the same host(i.MX6) though
> I am not sure if it's over SPI or SDIO bus. Till now, I have not come
> across such limitations with the specific host.

That iperf -P 16 hammers the chip with a lot of short packets, the 
problem does not occur during iperf3 -P 1 run or UDP iperf3 run (that's 
the one with low traffic). Here the interface is saturated, that's why I 
speculate some sort of FIFO overrun is happening.

I have also noticed there are some wilc1000 downstream drivers with huge 
stacks of patches, but I never really figured out whether those are 
still relevant or whether the upstream wilc1000 driver is perfectly 
fine. I would like to believe it is the later, is it ?
