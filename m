Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A55626EC8
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Nov 2022 10:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbiKMJl1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 13 Nov 2022 04:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiKMJlZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 13 Nov 2022 04:41:25 -0500
Received: from mog.warmcat.com (mog.warmcat.com [178.170.10.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AAF3BCE1F
        for <linux-wireless@vger.kernel.org>; Sun, 13 Nov 2022 01:41:23 -0800 (PST)
Received: from mx.warmcat.com (host31-53-12-215.range31-53.btcentralplus.com [31.53.12.215])
        by mog.warmcat.com (Postfix) with ESMTPSA id 879F813562B;
        Sun, 13 Nov 2022 09:41:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mog.warmcat.com 879F813562B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=warmcat.com;
        s=default; t=1668332482;
        bh=iolhJre7Sgpo6gG5Vr7FnHtUorUQv9pex7rG7/dMs3A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ihPSeEAxrfMW/nhQUToLDtiV3n0ZHnEywh0oL/I8qTGtmM0BOl8p8nHE+AWp99l+4
         j0V5h8JKyd68ydZmJYhhNVFlhNgPQ2QXE8TanjyH6kNbATGGAS4tpviC2xTBHSSqMk
         dT/q17sx7OFZJl/ypw1imDvNA6zeW+xEeBms7fZs=
Received: from [192.168.4.115] (unknown [192.168.4.115])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by mx.warmcat.com (Postfix) with ESMTPSA id 00C9F2A0079;
        Sun, 13 Nov 2022 09:41:21 +0000 (GMT)
Message-ID: <de7f4df1-54b0-db2e-3d40-3caeda020924@warmcat.com>
Date:   Sun, 13 Nov 2022 09:41:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: AP6275 / bcm43752 pcie on mainline brcmf
Content-Language: en-US
To:     Shengyu Qu <wiagn233@outlook.com>, arend.vanspriel@broadcom.com
Cc:     franky.lin@broadcom.com, linux-wireless@vger.kernel.org
References: <TY3P286MB26114DD461F50814980453E598029@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <08416710-655a-c87c-a599-3fe2563f7de4@warmcat.com>
 <TY3P286MB26116261C165BD4B0B249EB098029@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
From:   Andy Green <andy@warmcat.com>
In-Reply-To: <TY3P286MB26116261C165BD4B0B249EB098029@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
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



On 11/13/22 09:10, Shengyu Qu wrote:
> Actually you can use any other clm info blob with this firmware as I tried. I also uploaded this to armbian's firmware repo. Hope we could get the proper firmware uploaded by Broadcom soon.

Thank, I tried this, it did accept to download the clm part from the 
Rockchip SDK firmware.

# ls -l /lib/firmware/brcm
-rw-r--r-- 1 root root  30993 Oct  3 08:40 clm_bcm43752a2_pcie_ag.blob
-rw-r--r-- 1 root root 743607 Nov 13 08:45 fw_bcm43752a2_ag.bin
lrwxrwxrwx 1 root root     46 Nov 13 09:19 fw_bcm43752a2_pcie.clm_blob 
-> /lib/firmware/brcm/clm_bcm43752a2_pcie_ag.blob
lrwxrwxrwx 1 root root     20 Nov 13 08:38 
fw_bcm43752a2_pcie.rockchip,rk3588-evb1-v10.bin -> fw_bcm43752a2_ag.bin
lrwxrwxrwx 1 root root     36 Nov 13 08:47 fw_bcm43752a2_pcie.txt -> 
/lib/firmware/brcm/nvram_ap6275s.txt
-rw-r--r-- 1 root root   8709 Nov 13 08:44 nvram_ap6275s.txt

But it's no happier after the NVRAM download part.

# dmesg | grep brcm
[    3.530116] brcmfmac: brcmfmac_module_init No platform data available.
[    3.530303] brcmfmac 0002:21:00.0: enabling device (0000 -> 0002)
[    3.530362] brcmfmac: brcmf_chip_recognition found AXI chip: BCM43752/2
[    3.531325] brcmfmac: brcmf_chip_cores_check  [1 ] core 0x800:65 
base 0x18000000 wrap 0x18100000
[    3.531329] brcmfmac: brcmf_chip_cores_check  [2 ] core 0x812:82 
base 0x18001000 wrap 0x18101000
[    3.531334] brcmfmac: brcmf_chip_cores_check  [3 ] core 0x83e:16 
base 0x18002000 wrap 0x18102000
[    3.531338] brcmfmac: brcmf_chip_cores_check  [4 ] core 0x83c:65 
base 0x18003000 wrap 0x18103000
[    3.531342] brcmfmac: brcmf_chip_cores_check  [5 ] core 0x829:26 
base 0x18004000 wrap 0x18104000
[    3.531346] brcmfmac: brcmf_chip_cores_check  [6 ] core 0x844:2 
base 0x18005000 wrap 0x18105000
[    3.531350] brcmfmac: brcmf_chip_cores_check  [7 ] core 0x840:15 
base 0x18010000 wrap 0x00000000
[    3.531354] brcmfmac: brcmf_chip_cores_check  [8 ] core 0x827:35 
base 0x18012000 wrap 0x00000000
[    3.531358] brcmfmac: brcmf_chip_cores_check  [9 ] core 0x240:0 
base 0x00000000 wrap 0x1810a000
[    3.531362] brcmfmac: brcmf_chip_cores_check  [10] core 0x135:0 
base 0x00000000 wrap 0x18112000
[    3.531365] brcmfmac: brcmf_chip_cores_check  [11] core 0x135:0 
base 0x00000000 wrap 0x18113000
[    3.531369] brcmfmac: brcmf_chip_set_passive Enter
[    3.641635] brcmfmac: brcmf_chip_set_passive Enter
[    3.642156] brcmfmac: brcmf_chip_tcm_rambase: 43752 OK
[    3.642159] brcmfmac: brcmf_chip_get_raminfo RAM: base=0x170000 
size=1310720 (0x140000) sr=0 (0x0)
[    3.642187] brcmfmac: brcmf_chip_setup ccrev=65, pmurev=35, 
pmucaps=0x84565f23
[    3.642193] brcmfmac: brcmf_get_module_param Enter, bus=2, 
chip=43752, rev=2
[    3.642207] brcmfmac: brcmf_alloc Enter
[    3.642231] brcmfmac: brcmf_fw_alloc_request: using 
brcm/fw_bcm43752a2_pcie for chip BCM43752/2
[    3.642235] brcmfmac: brcmf_fw_get_firmwares enter: dev=0002:21:00.0
[    3.642241] brcmfmac: brcm_alt_fw_path FW alt path: 
brcm/fw_bcm43752a2_pcie.rockchip,rk3588-evb1-v10.bin
[    3.646995] brcmfmac: brcmf_fw_complete_request firmware 
brcm/fw_bcm43752a2_pcie.bin found
[    3.647006] brcmfmac: brcm_alt_fw_path FW alt path: 
brcm/fw_bcm43752a2_pcie.rockchip,rk3588-evb1-v10.txt
[    3.647308] brcmfmac: brcmf_fw_complete_request firmware 
brcm/fw_bcm43752a2_pcie.txt found
[    3.647312] brcmfmac: brcmf_fw_request_nvram_done enter: dev=0002:21:00.0
[    3.647484] brcmfmac: brcmf_fw_request_nvram_done nvram 
00000000c4269a30 len 5968
[    3.647491] brcmfmac: brcm_alt_fw_path FW alt path: 
brcm/fw_bcm43752a2_pcie.rockchip,rk3588-evb1-v10.clm_blob
[    3.647911] brcmfmac: brcmf_fw_complete_request firmware 
brcm/fw_bcm43752a2_pcie.clm_blob found
[    3.648197] brcmfmac: brcmf_chip_tcm_rambase: 43752 OK
[    3.648200] brcmfmac: brcmf_chip_get_raminfo RAM: base=0x170000 
size=1310720 (0x140000) sr=0 (0x0)
[    3.723260] brcmfmac: Download NVRAM brcm/fw_bcm43752a2_pcie.txt
[    3.723895] brcmfmac: brcmf_pcie_download_fw_nvram: sharedram_addr 
0xfa2c05d3
[    3.723899] brcmfmac: brcmf_chip_set_active Enter
[    9.721628] brcmfmac 0002:21:00.0: brcmf_pcie_download_fw_nvram: FW 
failed to initialize: 0xfa2c05d3
[    9.721657] brcmfmac: brcmf_detach Enter
[    9.745615] brcmfmac: brcmf_bus_change_state 0 -> 0
[    9.745623] brcmfmac: brcmf_proto_detach Enter

CONFIG_BRCMUTIL=m
# CONFIG_BRCMSMAC is not set
CONFIG_BRCMFMAC=m
# CONFIG_BRCMFMAC_PROTO_MSGBUF is not set
# CONFIG_BRCMFMAC_SDIO is not set
# CONFIG_BRCMFMAC_USB is not set
CONFIG_BRCMFMAC_PCIE=y
CONFIG_BRCM_TRACING=y
CONFIG_BRCMDBG=y

I have the AP6275 module EN signal with the gpio wired to it as an 
"always-on" gpio regulator in DT, and don't use the hacky rfkill thing 
the rockchip SDK came with.

It's on top of 6.1.0-rc4.

Does your setup differ from this?

-Andy

> Shengyu
> 
> 于 2022年11月13日 GMT+08:00 下午5:03:06, Andy Green <andy@warmcat.com> 写到:
>>
>>
>> On 11/13/22 08:26, Shengyu Qu wrote:
>>
>>> Hello, I'm facing the same problem on sdio version of AP6275 module in mainline kernel. But I found a very old version from here could work with mainline brcmfmac driver.
>>> Link: https://bbs.t-firefly.com/forum.php?mod=viewthread&tid=3107
>>
>> Thanks for the info.
>>
>> The firmware on the firefly thread doesn't seem to have a CLM blob that the mainline driver wants, just two types of the ~900KB main firmware for AP mode support or not.
>>
>> It also doesn't have _sdio or _pcie in the filenames... I tried it but although it's different in what it read after downloading NVRAM
>>
>> [    3.775602] brcmfmac: brcmf_pcie_download_fw_nvram: sharedram_addr 0xfa2c05d3
>>
>> (the rockchip SDK firmware says 0xfa1a05e5)
>>
>> it still times it out a few seconds later as unresponsive after the fw load... maybe it is for SDIO only, or the lack of CLM, present in the Rockchip fw, means it won't get anywhere.
>>
>>> Besides who I should ask to make proper firmware for it into linux-firmware repo?
>>
>> It would also be great to hear if the PCIe firmware from Rockchip aimed at the OOT driver was definitively incompatible with the mainline driver and we have to find a solution for that from Broadcom, or it is expected to basically work.  I realize it might not be easy to get an answer internally but this chipset is likely to appear in more RK3588 SBCs soon since it's the one on the evb.
>>
>> -Andy
>>
>>> Shengyu
