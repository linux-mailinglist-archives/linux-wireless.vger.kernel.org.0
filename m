Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5621D63761B
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Nov 2022 11:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiKXKUT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Nov 2022 05:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiKXKUI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Nov 2022 05:20:08 -0500
Received: from mog.warmcat.com (mog.warmcat.com [178.170.10.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC301C052A
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 02:20:05 -0800 (PST)
Received: from mx.warmcat.com (host31-53-12-215.range31-53.btcentralplus.com [31.53.12.215])
        by mog.warmcat.com (Postfix) with ESMTPSA id 77185135628;
        Thu, 24 Nov 2022 10:20:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mog.warmcat.com 77185135628
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=warmcat.com;
        s=default; t=1669285204;
        bh=ZqOJc/UDlomnGtFE9uQ7jGasCWvdopzWmvUIyEyQYnw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JBzJ71rLusjSYuyofNE0AfdYhiQKu/aR1fALC3MiltmkZq+vvHaauMlWUU2ytPqEp
         rJtHg3VX0s1YISPFL5ZIU7kaQfda2VBsOnp6hepJmM3hp5LvijlGKpYowg1yboW8PO
         ImZKxFI7/MD995/MdAdVtd2F5zXseEeSGcgN7cJU=
Received: from [192.168.4.115] (unknown [192.168.4.115])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by mx.warmcat.com (Postfix) with ESMTPSA id 2A7912A00EB;
        Thu, 24 Nov 2022 10:20:03 +0000 (GMT)
Message-ID: <bea00730-5411-a3c4-0ead-bb73889c25f6@warmcat.com>
Date:   Thu, 24 Nov 2022 10:20:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: AP6275 / bcm43752 pcie on mainline brcmf
Content-Language: en-US
To:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Shengyu Qu <wiagn233@outlook.com>
Cc:     franky.lin@broadcom.com, linux-wireless@vger.kernel.org
References: <TY3P286MB26114DD461F50814980453E598029@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <08416710-655a-c87c-a599-3fe2563f7de4@warmcat.com>
 <18470a1e910.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <TY3P286MB26115A58795F264893CCB40198029@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <184720fc920.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <TY3P286MB26118BD94839F752CADCCF5298079@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <625f1d5d-e137-7ad7-96b9-92035e87df8b@broadcom.com>
 <638afa8e-a393-410c-3182-0d8e9b6da17d@warmcat.com>
 <1848793db88.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <3a562a50-0cef-4879-3691-3258596f5213@warmcat.com>
 <1cbb3bf5-fd70-e9db-2405-640178862857@broadcom.com>
From:   Andy Green <andy@warmcat.com>
In-Reply-To: <1cbb3bf5-fd70-e9db-2405-640178862857@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 11/24/22 09:42, Arend van Spriel wrote:
> On 11/18/2022 6:41 AM, Andy Green wrote:
>>
>>
>> On 11/17/22 21:52, Arend Van Spriel wrote:
>>
>>> I see. So could you load bcmdhd and provide log. Preferably with 
>>> higher debug level. It also has a module parameter for it. I think it 
>>> is called dhd_msg_level and please set it to 0x817.
>>
>> It's here:
>>
>> https://warmcat.com/ap6275p-dhd-log1.txt
> 
> Hi Andy,
> 
> Thanks for the log. Together with the dhd driver sources I could make 
> some sense of it. Perhaps you can try the following hack and see if we 
> make it over the first hurdle.

Thanks, I tried it, but although it looks necessary, there's evidently 
something else since the result was the same.

> +
> +    entropy_info.signture = cpu_to_le32(BRCMF_SEED_SIGNATURE);

This should be ... .signature = ...

The debug logs

[    3.487772] brcmfmac: brcmfmac_module_init No platform data available.
[    3.487858] brcmfmac 0002:21:00.0: enabling device (0000 -> 0002)
[    3.487896] brcmfmac: brcmf_chip_recognition found AXI chip: BCM43752/2
[    3.488799] brcmfmac: brcmf_chip_cores_check  [1 ] core 0x800:65 
base 0x18000000 wrap 0x18100000
[    3.488801] brcmfmac: brcmf_chip_cores_check  [2 ] core 0x812:82 
base 0x18001000 wrap 0x18101000
[    3.488803] brcmfmac: brcmf_chip_cores_check  [3 ] core 0x83e:16 
base 0x18002000 wrap 0x18102000
[    3.488804] brcmfmac: brcmf_chip_cores_check  [4 ] core 0x83c:65 
base 0x18003000 wrap 0x18103000
[    3.488805] brcmfmac: brcmf_chip_cores_check  [5 ] core 0x829:26 
base 0x18004000 wrap 0x18104000
[    3.488807] brcmfmac: brcmf_chip_cores_check  [6 ] core 0x844:2 
base 0x18005000 wrap 0x18105000
[    3.488808] brcmfmac: brcmf_chip_cores_check  [7 ] core 0x840:15 
base 0x18010000 wrap 0x00000000
[    3.488810] brcmfmac: brcmf_chip_cores_check  [8 ] core 0x827:35 
base 0x18012000 wrap 0x00000000
[    3.488811] brcmfmac: brcmf_chip_cores_check  [9 ] core 0x240:0 
base 0x00000000 wrap 0x1810a000
[    3.488813] brcmfmac: brcmf_chip_cores_check  [10] core 0x135:0 
base 0x00000000 wrap 0x18112000
[    3.488814] brcmfmac: brcmf_chip_cores_check  [11] core 0x135:0 
base 0x00000000 wrap 0x18113000
[    3.488815] brcmfmac: brcmf_chip_set_passive Enter
[    3.594733] brcmfmac: brcmf_chip_set_passive Enter
[    3.595214] brcmfmac: brcmf_chip_tcm_rambase: 43752 OK
[    3.595215] brcmfmac: brcmf_chip_get_raminfo RAM: base=0x170000 
size=1310720 (0x140000) sr=0 (0x0)
[    3.595238] brcmfmac: brcmf_chip_setup ccrev=65, pmurev=35, 
pmucaps=0x84565f23
[    3.595241] brcmfmac: brcmf_get_module_param Enter, bus=2, 
chip=43752, rev=2
[    3.595246] brcmfmac: brcmf_alloc Enter
[    3.595254] brcmfmac: brcmf_fw_alloc_request: using 
brcm/fw_bcm43752a2_pcie for chip BCM43752/2
[    3.595257] brcmfmac: brcmf_fw_get_firmwares enter: dev=0002:21:00.0
[    3.595259] brcmfmac: brcm_alt_fw_path FW alt path: 
brcm/fw_bcm43752a2_pcie.rockchip,rk3588-evb1-v10.bin
[    3.595555] brcmfmac 0002:21:00.0: Direct firmware load for 
brcm/fw_bcm43752a2_pcie.rockchip,rk3588-evb1-v10.bin failed with error -2
[    3.600006] brcmfmac: brcmf_fw_complete_request firmware 
brcm/fw_bcm43752a2_pcie.bin found
[    3.600010] brcmfmac: brcm_alt_fw_path FW alt path: 
brcm/fw_bcm43752a2_pcie.rockchip,rk3588-evb1-v10.txt
[    3.600323] brcmfmac: brcmf_fw_complete_request firmware 
brcm/fw_bcm43752a2_pcie.txt found
[    3.600324] brcmfmac: brcmf_fw_request_nvram_done enter: dev=0002:21:00.0
[    3.600378] brcmfmac: brcmf_fw_request_nvram_done nvram 
00000000eea1e0fd len 6040
[    3.600381] brcmfmac: brcm_alt_fw_path FW alt path: 
brcm/fw_bcm43752a2_pcie.rockchip,rk3588-evb1-v10.clm_blob
[    3.600641] brcmfmac: brcmf_fw_complete_request firmware 
brcm/fw_bcm43752a2_pcie.clm_blob found
[    3.600836] brcmfmac: brcmf_chip_tcm_rambase: 43752 OK
[    3.600837] brcmfmac: brcmf_chip_get_raminfo RAM: base=0x170000 
size=1310720 (0x140000) sr=0 (0x0)
[    3.694272] brcmfmac: Download NVRAM brcm/fw_bcm43752a2_pcie.txt
[    3.694895] brcmfmac: brcmf_pcie_write_entropy_bytes: written 6040 
entropy bytes
[    3.694910] brcmfmac: brcmf_pcie_download_fw_nvram: sharedram_addr 
0xfa1a05e5
[    3.694911] brcmfmac: brcmf_chip_set_active Enter
[    9.774716] brcmfmac 0002:21:00.0: brcmf_pcie_download_fw_nvram: FW 
failed to initialize: 0xfa1a05e5
[    9.774733] brcmfmac: brcmf_detach Enter
[    9.798714] brcmfmac: brcmf_bus_change_state 0 -> 0
[    9.798716] brcmfmac: brcmf_proto_detach Enter

I added a log showing it sending the entropy bytes.

Firmware situation

# ls -l /lib/firmware/brcm/
total 956
-rw-r--r-- 1 root root  30993 Nov 16 12:31 clm_bcm43752a2_pcie_ag.blob
lrwxrwxrwx 1 root root     44 Nov 24 10:00 fw_bcm43752a2_pcie.bin -> 
/lib/firmware/brcm/fw_bcm43752a2_pcie_ag.bin
lrwxrwxrwx 1 root root     46 Nov 24 10:02 fw_bcm43752a2_pcie.clm_blob 
-> /lib/firmware/brcm/clm_bcm43752a2_pcie_ag.blob
lrwxrwxrwx 1 root root     36 Nov 24 10:02 fw_bcm43752a2_pcie.txt -> 
/lib/firmware/brcm/nvram_AP6275P.txt
-rw-r--r-- 1 root root 936074 Nov 16 12:31 fw_bcm43752a2_pcie_ag.bin
-rw-r--r-- 1 root root   7458 Nov 16 12:31 nvram_AP6275P.txt

-Andy
