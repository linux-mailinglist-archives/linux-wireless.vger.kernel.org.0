Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBB5623C52
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Nov 2022 08:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbiKJHGm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Nov 2022 02:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiKJHGl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Nov 2022 02:06:41 -0500
Received: from mog.warmcat.com (mog.warmcat.com [178.170.10.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A42014016
        for <linux-wireless@vger.kernel.org>; Wed,  9 Nov 2022 23:06:39 -0800 (PST)
Received: from mx.warmcat.com (host31-53-12-215.range31-53.btcentralplus.com [31.53.12.215])
        by mog.warmcat.com (Postfix) with ESMTPSA id 47070135602;
        Thu, 10 Nov 2022 07:06:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mog.warmcat.com 47070135602
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=warmcat.com;
        s=default; t=1668063998;
        bh=SfBt8l0StuIlhXHfiIXOhOe1e1OySq0YJvgq5p1+oRo=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=N8t2GGDzGibp2X9/KeBOQDype9iCnd51WISFaO87nNHz/hsdQ+66fusZ0y7ePrOYM
         QiL1n0SL2/tw+72DiH4DTRdmeKwCN2oRCKv6Kzumom5+w11/wXg05kAH+Lxl4wI8fe
         IQBLMuCSo3h4XzKTEdO6EYj/J3Z8wz6MMG5THGQM=
Received: from [192.168.4.115] (unknown [192.168.4.115])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by mx.warmcat.com (Postfix) with ESMTPSA id 4B8072A00DA;
        Thu, 10 Nov 2022 07:06:37 +0000 (GMT)
Message-ID: <258c07af-5ca1-dbaa-ac19-6c30459b5fca@warmcat.com>
Date:   Thu, 10 Nov 2022 07:06:35 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: AP6275 / bcm43752 pcie on mainline brcmf
From:   Andy Green <andy@warmcat.com>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        franky.lin@broadcom.com
Cc:     linux-wireless@vger.kernel.org
References: <1D540F2B-17E8-4992-BD06-4AA4A66B1964@warmcat.com>
 <1845da4b838.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <b5f564da-d0c1-4617-fef1-771ccdda18e4@warmcat.com>
Content-Language: en-US
In-Reply-To: <b5f564da-d0c1-4617-fef1-771ccdda18e4@warmcat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 11/9/22 19:35, Andy Green wrote:
> 
> On 11/9/22 18:26, Arend Van Spriel wrote:

>> Can you share any kernel logs preferably with debug=0x1416 passed 
>> during insmod.
>>
> I passed that in modprobe.d/ but the only logs are its usual ones and 
> the ones I added

It seems the debug logging needs a few additional config options 
additionally.

[    3.469000] brcmfmac: brcmfmac_module_init No platform data available.
[    3.469140] brcmfmac 0002:21:00.0: enabling device (0000 -> 0002)
[    3.469179] brcmfmac: brcmf_chip_recognition found AXI chip: BCM43752/2
[    3.470077] brcmfmac: brcmf_chip_cores_check  [1 ] core 0x800:65 
base 0x18000000 wrap 0x18100000
[    3.470079] brcmfmac: brcmf_chip_cores_check  [2 ] core 0x812:82 
base 0x18001000 wrap 0x18101000
[    3.470081] brcmfmac: brcmf_chip_cores_check  [3 ] core 0x83e:16 
base 0x18002000 wrap 0x18102000
[    3.470082] brcmfmac: brcmf_chip_cores_check  [4 ] core 0x83c:65 
base 0x18003000 wrap 0x18103000
[    3.470084] brcmfmac: brcmf_chip_cores_check  [5 ] core 0x829:26 
base 0x18004000 wrap 0x18104000
[    3.470085] brcmfmac: brcmf_chip_cores_check  [6 ] core 0x844:2 
base 0x18005000 wrap 0x18105000
[    3.470087] brcmfmac: brcmf_chip_cores_check  [7 ] core 0x840:15 
base 0x18010000 wrap 0x00000000
[    3.470088] brcmfmac: brcmf_chip_cores_check  [8 ] core 0x827:35 
base 0x18012000 wrap 0x00000000
[    3.470090] brcmfmac: brcmf_chip_cores_check  [9 ] core 0x240:0 
base 0x00000000 wrap 0x1810a000
[    3.470091] brcmfmac: brcmf_chip_cores_check  [10] core 0x135:0 
base 0x00000000 wrap 0x18112000
[    3.470092] brcmfmac: brcmf_chip_cores_check  [11] core 0x135:0 
base 0x00000000 wrap 0x18113000
[    3.470094] brcmfmac: brcmf_chip_set_passive Enter
[    3.579150] brcmfmac: brcmf_chip_set_passive Enter
[    3.579630] brcmfmac: brcmf_chip_tcm_rambase: 43752 OK
[    3.579631] brcmfmac: brcmf_chip_get_raminfo RAM: base=0x170000 
size=1310720 (0x140000) sr=0 (0x0)
[    3.579655] brcmfmac: brcmf_chip_setup ccrev=65, pmurev=35, 
pmucaps=0x84565f23
[    3.579657] brcmfmac: brcmf_get_module_param Enter, bus=2, 
chip=43752, rev=2
[    3.579663] brcmfmac: brcmf_alloc Enter
[    3.579675] brcmfmac: brcmf_fw_alloc_request: using 
brcm/fw_bcm43752a2_pcie for chip BCM43752/2
[    3.579678] brcmfmac: brcmf_fw_get_firmwares enter: dev=0002:21:00.0
[    3.579680] brcmfmac: brcm_alt_fw_path FW alt path: 
brcm/fw_bcm43752a2_pcie.rockchip,rk3588-evb1-v10.bin
[    3.583510] brcmfmac: brcmf_fw_complete_request firmware 
brcm/fw_bcm43752a2_pcie.bin found
[    3.583516] brcmfmac: brcm_alt_fw_path FW alt path: 
brcm/fw_bcm43752a2_pcie.rockchip,rk3588-evb1-v10.txt
[    3.583726] brcmfmac: brcmf_fw_complete_request firmware 
brcm/fw_bcm43752a2_pcie.txt found
[    3.583727] brcmfmac: brcmf_fw_request_nvram_done enter: dev=0002:21:00.0
[    3.583782] brcmfmac: brcmf_fw_request_nvram_done nvram 
000000001685ccfe len 6040
[    3.583784] brcmfmac: brcm_alt_fw_path FW alt path: 
brcm/fw_bcm43752a2_pcie.rockchip,rk3588-evb1-v10.clm_blob
[    3.584081] brcmfmac: brcmf_fw_complete_request firmware 
brcm/fw_bcm43752a2_pcie.clm_blob found
[    3.584278] brcmfmac: brcmf_chip_tcm_rambase: 43752 OK
[    3.584279] brcmfmac: brcmf_chip_get_raminfo RAM: base=0x170000 
size=1310720 (0x140000) sr=0 (0x0)
[    3.677816] brcmfmac: Download NVRAM brcm/fw_bcm43752a2_pcie.txt
[    3.678423] brcmfmac: brcmf_pcie_download_fw_nvram: sharedram_addr 
0xfa1a05e5
[    3.678425] brcmfmac: brcmf_chip_set_active Enter
[    9.707127] brcmfmac 0002:21:00.0: brcmf_pcie_download_fw_nvram: FW 
failed to initialize
[    9.707144] brcmfmac: brcmf_detach Enter
[    9.731123] brcmfmac: brcmf_bus_change_state 0 -> 0
[    9.731126] brcmfmac: brcmf_proto_detach Enter

-Andy
