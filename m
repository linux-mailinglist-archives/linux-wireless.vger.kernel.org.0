Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D80C637966
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Nov 2022 13:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiKXMz2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Nov 2022 07:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiKXMzI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Nov 2022 07:55:08 -0500
Received: from mog.warmcat.com (mog.warmcat.com [178.170.10.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C39971F03
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 04:54:38 -0800 (PST)
Received: from mx.warmcat.com (host31-53-12-215.range31-53.btcentralplus.com [31.53.12.215])
        by mog.warmcat.com (Postfix) with ESMTPSA id 277F913562B;
        Thu, 24 Nov 2022 12:54:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mog.warmcat.com 277F913562B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=warmcat.com;
        s=default; t=1669294466;
        bh=fqPDNBS4jdkdAfyuoruLMvJDhF5fNMfPU2JlfGj91qY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pq7VfbNgV/eeVjNfMgzooX8/QRN/huBkue04jUHt+b0/ttxEWHU7E/bpfvxbEtjkm
         Jq9g+N9y2kEE+CvRWe17JPPfi2rVMkYOGDWCuzCIv672ylneBrWqAobNAGwE+CkLgs
         ZyKJhYc32jXPifJQ6ZV6ErNFASukmzPAxxU3cor8=
Received: from [192.168.4.115] (unknown [192.168.4.115])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by mx.warmcat.com (Postfix) with ESMTPSA id 9F34A2A00EB;
        Thu, 24 Nov 2022 12:54:25 +0000 (GMT)
Message-ID: <d04547d3-4081-4047-3206-6d7c750720dc@warmcat.com>
Date:   Thu, 24 Nov 2022 12:54:23 +0000
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
 <6c3f592e-3e20-edef-ce7a-cde8988eef2d@warmcat.com>
 <9fe8caec-453a-28c1-04d3-5966200b8db1@broadcom.com>
 <f80c4a64-d987-0f59-418d-adf419fcb054@warmcat.com>
 <56fbcc03-b5dc-34b2-f15a-13c46447ffa0@broadcom.com>
From:   Andy Green <andy@warmcat.com>
In-Reply-To: <56fbcc03-b5dc-34b2-f15a-13c46447ffa0@broadcom.com>
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



On 11/24/22 12:44, Arend van Spriel wrote:

>> 52 is EBADE, I recall you mentioned that the scan api had been changed 
>> recently... is this possibly related to that?  Grepping around for 
>> EBADE near the function it mentions, it tries to take evasive action 
>> if it sees one in some places already.
> 
> EBADE is a generic error message indicating something went wrong 
> communicating with firmware. Not very informative. Were you using any 
> debug level? Anyway, please load the driver with module parameter 
> debug=0x5416 and try scanning using iw utility.

My kernel crashed on boot while I was trying things earlier 
necessitating a rootfs reflash, I lost the /etc/modprobe.d entry for the 
debug.

Adding it back in, it's a lot more informative

[    3.569646] brcmfmac: brcmfmac_module_init No platform data available.
[    3.569832] brcmfmac 0002:21:00.0: enabling device (0000 -> 0002)
[    3.569888] brcmfmac: brcmf_chip_recognition found AXI chip: BCM43752/2
[    3.570843] brcmfmac: brcmf_chip_cores_check  [1 ] core 0x800:65 
base 0x18000000 wrap 0x18100000
[    3.570848] brcmfmac: brcmf_chip_cores_check  [2 ] core 0x812:82 
base 0x18001000 wrap 0x18101000
[    3.570853] brcmfmac: brcmf_chip_cores_check  [3 ] core 0x83e:16 
base 0x18002000 wrap 0x18102000
[    3.570857] brcmfmac: brcmf_chip_cores_check  [4 ] core 0x83c:65 
base 0x18003000 wrap 0x18103000
[    3.570860] brcmfmac: brcmf_chip_cores_check  [5 ] core 0x829:26 
base 0x18004000 wrap 0x18104000
[    3.570864] brcmfmac: brcmf_chip_cores_check  [6 ] core 0x844:2 
base 0x18005000 wrap 0x18105000
[    3.570868] brcmfmac: brcmf_chip_cores_check  [7 ] core 0x840:15 
base 0x18010000 wrap 0x00000000
[    3.570872] brcmfmac: brcmf_chip_cores_check  [8 ] core 0x827:35 
base 0x18012000 wrap 0x00000000
[    3.570876] brcmfmac: brcmf_chip_cores_check  [9 ] core 0x240:0 
base 0x00000000 wrap 0x1810a000
[    3.570880] brcmfmac: brcmf_chip_cores_check  [10] core 0x135:0 
base 0x00000000 wrap 0x18112000
[    3.570884] brcmfmac: brcmf_chip_cores_check  [11] core 0x135:0 
base 0x00000000 wrap 0x18113000
[    3.570888] brcmfmac: brcmf_chip_set_passive Enter
[    3.678925] brcmfmac: brcmf_chip_set_passive Enter
[    3.679441] brcmfmac: brcmf_chip_tcm_rambase: 43752 OK
[    3.679443] brcmfmac: brcmf_chip_get_raminfo RAM: base=0x170000 
size=1310720 (0x140000) sr=0 (0x0)
[    3.679471] brcmfmac: brcmf_chip_setup ccrev=65, pmurev=35, 
pmucaps=0x84565f23
[    3.679477] brcmfmac: brcmf_get_module_param Enter, bus=2, 
chip=43752, rev=2
[    3.679495] brcmfmac: brcmf_alloc Enter
[    3.679512] brcmfmac: brcmf_fw_alloc_request: using 
brcm/fw_bcm43752a2_pcie for chip BCM43752/2
[    3.679517] brcmfmac: brcmf_fw_get_firmwares enter: dev=0002:21:00.0
[    3.679522] brcmfmac: brcm_alt_fw_path FW alt path: 
brcm/fw_bcm43752a2_pcie.rockchip,rk3588-evb1-v10.bin
[    3.679826] brcmfmac 0002:21:00.0: Direct firmware load for 
brcm/fw_bcm43752a2_pcie.rockchip,rk3588-evb1-v10.bin failed with error -2
[    3.684423] brcmfmac: brcmf_fw_complete_request firmware 
brcm/fw_bcm43752a2_pcie.bin found
[    3.684433] brcmfmac: brcm_alt_fw_path FW alt path: 
brcm/fw_bcm43752a2_pcie.rockchip,rk3588-evb1-v10.txt
[    3.684768] brcmfmac: brcmf_fw_complete_request firmware 
brcm/fw_bcm43752a2_pcie.txt found
[    3.684772] brcmfmac: brcmf_fw_request_nvram_done enter: dev=0002:21:00.0
[    3.684947] brcmfmac: brcmf_fw_request_nvram_done nvram 
000000007fae8cbc len 6040
[    3.684955] brcmfmac: brcm_alt_fw_path FW alt path: 
brcm/fw_bcm43752a2_pcie.rockchip,rk3588-evb1-v10.clm_blob
[    3.685347] brcmfmac: brcmf_fw_complete_request firmware 
brcm/fw_bcm43752a2_pcie.clm_blob found
[    3.685625] brcmfmac: brcmf_chip_tcm_rambase: 43752 OK
[    3.685627] brcmfmac: brcmf_chip_get_raminfo RAM: base=0x170000 
size=1310720 (0x140000) sr=0 (0x0)
[    3.779392] brcmfmac: Download NVRAM brcm/fw_bcm43752a2_pcie.txt
[    3.780001] brcmfmac: brcmf_pcie_write_entropy_bytes: written 128 
entropy bytes
[    3.780016] brcmfmac: Bring ARM in running state
[    3.780018] brcmfmac: brcmf_chip_set_active Enter
[    3.780229] brcmfmac: Wait for FW init (0xfa1a05e5)
[    3.995343] brcmfmac: brcmf_attach Enter
[    3.995348] brcmfmac: brcmf_proto_attach Enter
[    3.997068] brcmfmac: brcmf_fweh_register event handler registered 
for PSM_WATCHDOG
[    3.997073] brcmfmac: brcmf_bus_started
[    3.997076] brcmfmac: brcmf_add_if Enter, bsscfgidx=0, ifidx=0
[    3.997080] brcmfmac: brcmf_add_if allocate netdev interface
[    3.997096] brcmfmac: brcmf_add_if  ==== pid:bf, if:wlan%d 
(00:00:00:00:00:00) created ===
[    3.997100] brcmfmac: brcmf_bus_change_state 0 -> 1
[    3.999755] brcmfmac: brcmf_fil_iovar_data_get ifidx=0, 
name=cur_etheraddr, len=6, err=0
[    4.000059] brcmfmac: brcmf_fil_cmd_data_get ifidx=0, cmd=98, len=68, 
err=0
[    4.000077] brcmfmac: brcmf_c_process_clm_blob Enter
[    4.000083] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, name=clmload, 
len=1415
[    4.000583] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, name=clmload, 
len=1415
[    4.001002] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, name=clmload, 
len=1415
[    4.001432] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, name=clmload, 
len=1415
[    4.001852] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, name=clmload, 
len=1415
[    4.002282] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, name=clmload, 
len=1415
[    4.002713] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, name=clmload, 
len=1415
[    4.003137] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, name=clmload, 
len=1415
[    4.003569] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, name=clmload, 
len=1415
[    4.003989] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, name=clmload, 
len=1415
[    4.004420] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, name=clmload, 
len=1415
[    4.004883] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, name=clmload, 
len=1415
[    4.005163] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, name=clmload, 
len=1415
[    4.005583] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, name=clmload, 
len=1415
[    4.006008] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, name=clmload, 
len=1415
[    4.006479] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, name=clmload, 
len=1415
[    4.006864] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, name=clmload, 
len=1415
[    4.007286] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, name=clmload, 
len=1415
[    4.007718] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, name=clmload, 
len=1415
[    4.008138] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, name=clmload, 
len=1415
[    4.008568] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, name=clmload, 
len=1415
[    4.008999] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, name=clmload, 
len=1415
[    4.009417] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, name=clmload, 
len=208
[    4.012350] brcmfmac: brcmf_fil_iovar_data_get ifidx=0, name=ver, 
len=256, err=0
[    4.012368] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM43752/2 
wl0: Jul 12 2022 18:54:54 version 18.35.387.23.146 (g412cc5ec) FWID 
01-93c53be6
[    4.012791] brcmfmac: brcmf_fil_iovar_data_get ifidx=0, name=clmver, 
len=256, err=0
[    4.012807] brcmfmac: brcmf_c_preinit_dcmds CLM version = API: 20.0 
Data: 9.9.12_SS Compiler: 1.53.0 ClmImport: 1.52.0 Customization: 
V15_190709 Creation: 2021-10-12 17:03:28
[    4.012810] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, name=mpc, len=4
[    4.013199] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, 
name=join_pref, len=8
[    4.013759] brcmfmac: brcmf_fil_iovar_data_get ifidx=0, 
name=event_msgs, len=18, err=0
[    4.013770] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, 
name=event_msgs, len=18
[    4.014108] brcmfmac: brcmf_fil_cmd_int_set ifidx=0, cmd=185, value=40
[    4.014506] brcmfmac: brcmf_fil_cmd_int_set ifidx=0, cmd=187, value=40
[    4.014930] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, name=txbf, len=4
[    4.015732] brcmfmac: brcmf_fil_iovar_data_get ifidx=0, name=cap, 
len=768, err=0
[    4.015749] brcmfmac: brcmf_feat_firmware_capabilities [ ap sta wme 
802.11d 802.11h cqa cac dualband ampdu ampdu_tx ampdu_rx amsdurx amsdutx 
tdls radio_pwrsave p2p proptxstatus mchan vht-prop-rates 
single-user-beamformer multi-user-beamformee single-user-beamformee 
dfrts txpwrcache stbc-tx stbc-rx-1ss mfp ndoe wnm bsstrans txcap epno 
scanmac cptlv-4 ve fbtoverds fbt_adpt ecounters event_log cdef txcap ocl 
hchk logtrace d11status scancache apf ifver idauth ifst fie tvpm 
lpr_scan bkoff_evt etd_infoclm_restrict evt_ext btc_wifi_prot monitor 
mbo estm d3cbuf sae extsae wrxf0ovfl ]
[    4.015765] brcmfmac: brcmf_feat_firmware_capabilities enabling 
feature: MCHAN
[    4.015768] brcmfmac: brcmf_feat_firmware_capabilities enabling 
feature: P2P
[    4.015775] brcmfmac: brcmf_feat_firmware_capabilities enabling 
feature: MONITOR
[    4.015794] brcmfmac: brcmf_feat_firmware_capabilities enabling 
feature: DOT11H
[    4.015802] brcmfmac: brcmf_feat_firmware_capabilities enabling 
feature: SAE
[    4.015808] brcmfmac: brcmf_feat_firmware_capabilities enabling 
feature: FWAUTH
[    4.015810] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, 
name=pfn_gscan_cfg, len=18
[    4.016360] brcmfmac: brcmf_fil_cmd_data Firmware error: BCME_VERSION 
(-37)
[    4.016364] brcmfmac: brcmf_feat_iovar_data_set enabling feature: GSCAN
[    4.016731] brcmfmac: brcmf_fil_iovar_data_get ifidx=0, name=pfn, 
len=4, err=0
[    4.016739] brcmfmac: brcmf_feat_iovar_int_get enabling feature: PNO
[    4.017167] brcmfmac: brcmf_fil_cmd_data Firmware error: 
BCME_UNSUPPORTED (-23)
[    4.017170] brcmfmac: brcmf_fil_iovar_data_get ifidx=0, name=wowl, 
len=4, err=-23
[    4.017177] brcmfmac: brcmf_feat_iovar_int_get WOWL feature check 
failed: -23
[    4.017456] brcmfmac: brcmf_fil_cmd_data Firmware error: 
BCME_UNSUPPORTED (-23)
[    4.017459] brcmfmac: brcmf_fil_iovar_data_get ifidx=0, 
name=rsdb_mode, len=4, err=-23
[    4.017467] brcmfmac: brcmf_feat_iovar_int_get RSDB feature check 
failed: -23
[    4.017823] brcmfmac: brcmf_fil_iovar_data_get ifidx=0, 
name=tdls_enable, len=4, err=0
[    4.017831] brcmfmac: brcmf_feat_iovar_int_get enabling feature: TDLS
[    4.018220] brcmfmac: brcmf_fil_iovar_data_get ifidx=0, name=mfp, 
len=4, err=0
[    4.018228] brcmfmac: brcmf_feat_iovar_int_get enabling feature: MFP
[    4.018611] brcmfmac: brcmf_fil_iovar_data_get ifidx=0, 
name=pfn_macaddr, len=8, err=0
[    4.018933] brcmfmac: brcmf_fil_iovar_data_get ifidx=0, name=sup_wpa, 
len=4, err=0
[    4.018942] brcmfmac: brcmf_feat_iovar_int_get enabling feature: FWSUP
[    4.018947] brcmfmac: brcmf_alloc_vif allocating virtual interface 
(size=4864)
[    4.018961] brcmfmac: brcmf_fweh_register event handler registered 
for LINK
[    4.018964] brcmfmac: brcmf_fweh_register event handler registered 
for DEAUTH_IND
[    4.018966] brcmfmac: brcmf_fweh_register event handler registered 
for DEAUTH
[    4.018968] brcmfmac: brcmf_fweh_register event handler registered 
for DISASSOC_IND
[    4.018970] brcmfmac: brcmf_fweh_register event handler registered 
for ASSOC_IND
[    4.018972] brcmfmac: brcmf_fweh_register event handler registered 
for REASSOC_IND
[    4.018974] brcmfmac: brcmf_fweh_register event handler registered 
for ROAM
[    4.018976] brcmfmac: brcmf_fweh_register event handler registered 
for MIC_ERROR
[    4.018979] brcmfmac: brcmf_fweh_register event handler registered 
for SET_SSID
[    4.018981] brcmfmac: brcmf_fweh_register event handler registered 
for PFN_NET_FOUND
[    4.018983] brcmfmac: brcmf_fweh_register event handler registered for IF
[    4.018986] brcmfmac: brcmf_fweh_register event handler registered 
for P2P_PROBEREQ_MSG
[    4.018988] brcmfmac: brcmf_fweh_register event handler registered 
for P2P_DISC_LISTEN_COMPLETE
[    4.018990] brcmfmac: brcmf_fweh_register event handler registered 
for ACTION_FRAME_RX
[    4.018993] brcmfmac: brcmf_fweh_register event handler registered 
for ACTION_FRAME_COMPLETE
[    4.018995] brcmfmac: brcmf_fweh_register event handler registered 
for ACTION_FRAME_OFF_CHAN_COMPLETE
[    4.018997] brcmfmac: brcmf_fweh_register event handler registered 
for PSK_SUP
[    4.019000] brcmfmac: brcmf_fweh_register event handler registered 
for RSSI
[    4.019002] brcmfmac: brcmf_fweh_register event handler registered 
for ESCAN_RESULT
[    4.019441] brcmfmac: brcmf_fil_cmd_int_get ifidx=0, cmd=1, value=2
[    4.019748] brcmfmac: brcmf_fil_cmd_data_get ifidx=0, cmd=140, 
len=12, err=0
[    4.019763] brcmfmac: brcmf_cfg80211_attach Registering custom regulatory
[    4.021256] brcmfmac: brcmf_fil_iovar_data_get ifidx=0, name=vhtmode, 
len=4, err=0
[    4.021585] brcmfmac: brcmf_fil_iovar_data_get ifidx=0, name=nmode, 
len=4, err=0
[    4.021915] brcmfmac: brcmf_fil_iovar_data_get ifidx=0, name=bw_cap, 
len=4, err=0
[    4.022278] brcmfmac: brcmf_fil_iovar_data_get ifidx=0, name=bw_cap, 
len=4, err=0
[    4.022286] brcmfmac: brcmf_setup_wiphybands nmode=1, vhtmode=1, 
bw_cap=(1, 7)
[    4.022530] brcmfmac: brcmf_fil_iovar_data_get ifidx=0, name=rxchain, 
len=4, err=0
[    4.022538] brcmfmac: brcmf_setup_wiphybands nchain=2
[    4.024274] brcmfmac: brcmf_fil_iovar_data_get ifidx=0, 
name=chanspecs, len=1536, err=0
[    4.024793] brcmfmac: brcmf_fil_bsscfg_data_get ifidx=0, bsscfgidx=0, 
name=per_chan_info, len=4, err=0
[    4.025312] brcmfmac: brcmf_fil_bsscfg_data_get ifidx=0, bsscfgidx=0, 
name=per_chan_info, len=4, err=0
[    4.025832] brcmfmac: brcmf_fil_bsscfg_data_get ifidx=0, bsscfgidx=0, 
name=per_chan_info, len=4, err=0
[    4.026188] brcmfmac: brcmf_fil_bsscfg_data_get ifidx=0, bsscfgidx=0, 
name=per_chan_info, len=4, err=0
[    4.026718] brcmfmac: brcmf_fil_bsscfg_data_get ifidx=0, bsscfgidx=0, 
name=per_chan_info, len=4, err=0
[    4.027264] brcmfmac: brcmf_fil_bsscfg_data_get ifidx=0, bsscfgidx=0, 
name=per_chan_info, len=4, err=0
[    4.027782] brcmfmac: brcmf_fil_bsscfg_data_get ifidx=0, bsscfgidx=0, 
name=per_chan_info, len=4, err=0
[    4.028302] brcmfmac: brcmf_fil_bsscfg_data_get ifidx=0, bsscfgidx=0, 
name=per_chan_info, len=4, err=0
[    4.028822] brcmfmac: brcmf_fil_bsscfg_data_get ifidx=0, bsscfgidx=0, 
name=per_chan_info, len=4, err=0
[    4.029341] brcmfmac: brcmf_fil_bsscfg_data_get ifidx=0, bsscfgidx=0, 
name=per_chan_info, len=4, err=0
[    4.029698] brcmfmac: brcmf_fil_bsscfg_data_get ifidx=0, bsscfgidx=0, 
name=per_chan_info, len=4, err=0
[    4.030232] brcmfmac: brcmf_fil_bsscfg_data_get ifidx=0, bsscfgidx=0, 
name=per_chan_info, len=4, err=0
[    4.030589] brcmfmac: brcmf_fil_bsscfg_data_get ifidx=0, bsscfgidx=0, 
name=per_chan_info, len=4, err=0
[    4.031116] brcmfmac: brcmf_fil_bsscfg_data_get ifidx=0, bsscfgidx=0, 
name=per_chan_info, len=4, err=0
[    4.031660] brcmfmac: brcmf_fil_bsscfg_data_get ifidx=0, bsscfgidx=0, 
name=per_chan_info, len=4, err=0
[    4.032185] brcmfmac: brcmf_fil_bsscfg_data_get ifidx=0, bsscfgidx=0, 
name=per_chan_info, len=4, err=0
[    4.032575] brcmfmac: brcmf_fil_bsscfg_data_get ifidx=0, bsscfgidx=0, 
name=per_chan_info, len=4, err=0
[    4.032937] brcmfmac: brcmf_fil_bsscfg_data_get ifidx=0, bsscfgidx=0, 
name=per_chan_info, len=4, err=0
[    4.033462] brcmfmac: brcmf_fil_bsscfg_data_get ifidx=0, bsscfgidx=0, 
name=per_chan_info, len=4, err=0
[    4.033823] brcmfmac: brcmf_fil_bsscfg_data_get ifidx=0, bsscfgidx=0, 
name=per_chan_info, len=4, err=0
[    4.034358] brcmfmac: brcmf_fil_bsscfg_data_get ifidx=0, bsscfgidx=0, 
name=per_chan_info, len=4, err=0
[    4.034930] brcmfmac: brcmf_fil_bsscfg_data_get ifidx=0, bsscfgidx=0, 
name=per_chan_info, len=4, err=0
[    4.035455] brcmfmac: brcmf_fil_bsscfg_data_get ifidx=0, bsscfgidx=0, 
name=per_chan_info, len=4, err=0
[    4.036001] brcmfmac: brcmf_fil_bsscfg_data_get ifidx=0, bsscfgidx=0, 
name=per_chan_info, len=4, err=0
[    4.036368] brcmfmac: brcmf_fil_bsscfg_data_get ifidx=0, bsscfgidx=0, 
name=per_chan_info, len=4, err=0
[    4.036885] brcmfmac: brcmf_fil_bsscfg_data_get ifidx=0, bsscfgidx=0, 
name=per_chan_info, len=4, err=0
[    4.037242] brcmfmac: brcmf_fil_bsscfg_data_get ifidx=0, bsscfgidx=0, 
name=per_chan_info, len=4, err=0
[    4.037799] brcmfmac: brcmf_fil_bsscfg_data_get ifidx=0, bsscfgidx=0, 
name=per_chan_info, len=4, err=0
[    4.038161] brcmfmac: brcmf_fil_bsscfg_data_get ifidx=0, bsscfgidx=0, 
name=per_chan_info, len=4, err=0
[    4.038521] brcmfmac: brcmf_fil_bsscfg_data_get ifidx=0, bsscfgidx=0, 
name=per_chan_info, len=4, err=0
[    4.039049] brcmfmac: brcmf_fil_bsscfg_data_get ifidx=0, bsscfgidx=0, 
name=per_chan_info, len=4, err=0
[    4.039405] brcmfmac: brcmf_fil_bsscfg_data_get ifidx=0, bsscfgidx=0, 
name=per_chan_info, len=4, err=0
[    4.039931] brcmfmac: brcmf_fil_bsscfg_data_get ifidx=0, bsscfgidx=0, 
name=per_chan_info, len=4, err=0
[    4.040291] brcmfmac: brcmf_fil_bsscfg_data_get ifidx=0, bsscfgidx=0, 
name=per_chan_info, len=4, err=0
[    4.040816] brcmfmac: brcmf_fil_bsscfg_data_get ifidx=0, bsscfgidx=0, 
name=per_chan_info, len=4, err=0
[    4.041175] brcmfmac: brcmf_fil_bsscfg_data_get ifidx=0, bsscfgidx=0, 
name=per_chan_info, len=4, err=0
[    4.041578] brcmfmac: brcmf_fil_iovar_data_get ifidx=0, 
name=txstreams, len=4, err=0
[    4.041956] brcmfmac: brcmf_fil_iovar_data_get ifidx=0, 
name=txbf_bfe_cap, len=4, err=0
[    4.042320] brcmfmac: brcmf_fil_iovar_data_get ifidx=0, 
name=txbf_bfr_cap, len=4, err=0
[    4.042670] brcmfmac: brcmf_fil_iovar_data_get ifidx=0, name=bw_cap, 
len=4, err=0
[    4.042678] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, name=bw_cap, 
len=8
[    4.043445] brcmfmac: brcmf_fil_iovar_data_get ifidx=0, 
name=chanspecs, len=1536, err=0
[    4.043464] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, 
name=obss_coex, len=4
[    4.043822] brcmfmac: brcmf_fweh_activate_events enable event SET_SSID
[    4.043825] brcmfmac: brcmf_fweh_activate_events enable event DEAUTH
[    4.043827] brcmfmac: brcmf_fweh_activate_events enable event DEAUTH_IND
[    4.043829] brcmfmac: brcmf_fweh_activate_events enable event ASSOC_IND
[    4.043831] brcmfmac: brcmf_fweh_activate_events enable event REASSOC_IND
[    4.043833] brcmfmac: brcmf_fweh_activate_events enable event 
DISASSOC_IND
[    4.043836] brcmfmac: brcmf_fweh_activate_events enable event LINK
[    4.043838] brcmfmac: brcmf_fweh_activate_events enable event MIC_ERROR
[    4.043840] brcmfmac: brcmf_fweh_activate_events enable event ROAM
[    4.043842] brcmfmac: brcmf_fweh_activate_events enable event 
PFN_NET_FOUND
[    4.043845] brcmfmac: brcmf_fweh_activate_events enable event 
PSM_WATCHDOG
[    4.043847] brcmfmac: brcmf_fweh_activate_events enable event PSK_SUP
[    4.043849] brcmfmac: brcmf_fweh_activate_events enable event IF
[    4.043851] brcmfmac: brcmf_fweh_activate_events enable event 
P2P_DISC_LISTEN_COMPLETE
[    4.043853] brcmfmac: brcmf_fweh_activate_events enable event RSSI
[    4.043856] brcmfmac: brcmf_fweh_activate_events enable event 
ACTION_FRAME_COMPLETE
[    4.043858] brcmfmac: brcmf_fweh_activate_events enable event 
ESCAN_RESULT
[    4.043860] brcmfmac: brcmf_fweh_activate_events enable event 
ACTION_FRAME_OFF_CHAN_COMPLETE
[    4.043862] brcmfmac: brcmf_fweh_activate_events enable event 
P2P_PROBEREQ_MSG
[    4.043864] brcmfmac: brcmf_fweh_activate_events enable event 
ACTION_FRAME_RX
[    4.043867] brcmfmac: brcmf_fweh_activate_events enable event IF
[    4.043869] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, 
name=event_msgs, len=18
[    4.044164] brcmfmac: brcmf_btcoex_attach enter
[    4.044167] brcmfmac: brcmf_pno_attach enter
[    4.044171] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, 
name=tdls_enable, len=4
[    4.044520] brcmfmac: brcmf_fweh_register event handler registered 
for TDLS_PEER_EVENT
[    4.044523] brcmfmac: brcmf_fweh_activate_events enable event SET_SSID
[    4.044525] brcmfmac: brcmf_fweh_activate_events enable event DEAUTH
[    4.044527] brcmfmac: brcmf_fweh_activate_events enable event DEAUTH_IND
[    4.044529] brcmfmac: brcmf_fweh_activate_events enable event ASSOC_IND
[    4.044531] brcmfmac: brcmf_fweh_activate_events enable event REASSOC_IND
[    4.044533] brcmfmac: brcmf_fweh_activate_events enable event 
DISASSOC_IND
[    4.044536] brcmfmac: brcmf_fweh_activate_events enable event LINK
[    4.044537] brcmfmac: brcmf_fweh_activate_events enable event MIC_ERROR
[    4.044540] brcmfmac: brcmf_fweh_activate_events enable event ROAM
[    4.044542] brcmfmac: brcmf_fweh_activate_events enable event 
PFN_NET_FOUND
[    4.044544] brcmfmac: brcmf_fweh_activate_events enable event 
PSM_WATCHDOG
[    4.044546] brcmfmac: brcmf_fweh_activate_events enable event PSK_SUP
[    4.044548] brcmfmac: brcmf_fweh_activate_events enable event IF
[    4.044550] brcmfmac: brcmf_fweh_activate_events enable event 
P2P_DISC_LISTEN_COMPLETE
[    4.044552] brcmfmac: brcmf_fweh_activate_events enable event RSSI
[    4.044554] brcmfmac: brcmf_fweh_activate_events enable event 
ACTION_FRAME_COMPLETE
[    4.044557] brcmfmac: brcmf_fweh_activate_events enable event 
ESCAN_RESULT
[    4.044559] brcmfmac: brcmf_fweh_activate_events enable event 
ACTION_FRAME_OFF_CHAN_COMPLETE
[    4.044561] brcmfmac: brcmf_fweh_activate_events enable event 
P2P_PROBEREQ_MSG
[    4.044564] brcmfmac: brcmf_fweh_activate_events enable event 
ACTION_FRAME_RX
[    4.044566] brcmfmac: brcmf_fweh_activate_events enable event 
TDLS_PEER_EVENT
[    4.044568] brcmfmac: brcmf_fweh_activate_events enable event IF
[    4.044570] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, 
name=event_msgs, len=18
[    4.044864] brcmfmac: brcmf_net_attach Enter, bsscfgidx=0 
mac=d4:9c:dd:f5:bf:7e
[    4.046336] brcmfmac: brcmf_fil_iovar_data_get ifidx=0, 
name=chanspec, len=4, err=0
[    4.046350] brcmfmac: brcmf_cfg80211_get_tx_power Enter
[    4.046352] brcmfmac: check_vif_up device is not ready : status (0)
[    4.046386] brcmfmac: brcmf_net_attach wlan0: Broadcom Dongle Host Driver
[    4.052221] brcmfmac 0002:21:00.0 wlP2p33s0: renamed from wlan0
[    4.629677] brcmfmac: brcmf_fil_iovar_data_get ifidx=0, 
name=chanspec, len=4, err=0
[    4.629688] brcmfmac: brcmf_cfg80211_get_tx_power Enter
[    4.629689] brcmfmac: check_vif_up device is not ready : status (0)
[    4.629733] brcmfmac: brcmf_cfg80211_dump_station Enter, idx 0
[    4.630174] brcmfmac: brcmf_fil_cmd_data_get ifidx=0, cmd=159, 
len=772, err=0
[    4.970573] brcmfmac: brcmf_netdev_open Enter, bsscfgidx=0
[    4.972550] brcmfmac: brcmf_fil_cmd_data Firmware error: 
BCME_UNSUPPORTED (-23)
[    4.972552] brcmfmac: brcmf_fil_iovar_data_get ifidx=0, name=toe_ol, 
len=4, err=-52
[    4.972558] brcmfmac: brcmf_fil_cmd_int_set ifidx=0, cmd=2, value=0
[    4.999772] brcmfmac: brcmf_fil_cmd_int_set ifidx=0, cmd=185, value=40
[    4.999812] brcmfmac: brcmf_fweh_event_worker event IF (54) ifidx 0 
bsscfg 0 addr d4:9c:dd:f5:bf:7e
[    4.999819] brcmfmac: brcmf_fweh_event_worker   version 2 flags 0 
status 0 reason 0
[    4.999829] brcmfmac: brcmf_fweh_handle_if_event action: 1 ifidx: 0 
bsscfgidx: 0 flags: 0 role: 0
[    4.999832] brcmfmac: brcmf_fweh_handle_if_event adding wl0 
(d4:9c:dd:f5:bf:7e)
[    4.999835] brcmfmac: brcmf_add_if Enter, bsscfgidx=0, ifidx=0
[    4.999838] brcmfmac: brcmf_add_if netdev:wlP2p33s0 ignore IF event
[    5.000315] brcmfmac: brcmf_fil_cmd_int_set ifidx=0, cmd=187, value=40
[    5.000563] brcmfmac: brcmf_fil_cmd_int_set ifidx=0, cmd=258, value=120
[    5.000922] brcmfmac: brcmf_fil_cmd_int_set ifidx=0, cmd=86, value=2
[    5.001170] brcmfmac: brcmf_config_dongle power save set to enabled
[    5.001172] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, 
name=bcn_timeout, len=4
[    5.001399] brcmfmac: brcmf_dongle_roam Internal Roaming = On
[    5.001401] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, 
name=roam_off, len=4
[    5.001737] brcmfmac: brcmf_fil_cmd_data_set ifidx=0, cmd=55, len=8
[    5.001866] brcmfmac: brcmf_fil_cmd_data_set ifidx=0, cmd=57, len=8
[    5.002110] brcmfmac: brcmf_cfg80211_change_iface Enter, bsscfgidx=0, 
type=2
[    5.002112] brcmfmac: brcmf_fil_cmd_int_set ifidx=0, cmd=20, value=1
[    5.002512] brcmfmac: brcmf_cfg80211_change_iface IF Type = Infra
[    5.002514] brcmfmac: brcmf_cfg80211_change_iface Exit
[    5.002515] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, name=arp_ol, 
len=4
[    5.002722] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, name=arpoe, len=4
[    5.003040] brcmfmac: brcmf_configure_arp_nd_offload successfully 
configured (1) ARP offload to 0x9
[    5.003042] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, name=ndoe, len=4
[    5.003358] brcmfmac: brcmf_configure_arp_nd_offload successfully 
configured (1) ND offload to 0x9
[    5.003360] brcmfmac: brcmf_fil_cmd_int_set ifidx=0, cmd=219, value=1
[    5.003606] brcmfmac: _brcmf_set_multicast_list Enter, bsscfgidx=0
[    5.003608] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, 
name=mcast_list, len=10
[    5.003659] brcmfmac: brcmf_cfg80211_set_power_mgmt Enter
[    5.003660] brcmfmac: brcmf_cfg80211_set_power_mgmt power save enabled
[    5.003992] brcmfmac: brcmf_fil_cmd_int_set ifidx=0, cmd=86, value=2
[    5.004224] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, 
name=allmulti, len=4
[    5.004614] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, 
name=pm2_sleep_ret, len=4
[    5.004824] brcmfmac: brcmf_fil_cmd_int_set ifidx=0, cmd=10, value=0
[    5.004827] brcmfmac: brcmf_cfg80211_set_power_mgmt Exit
[    5.004954] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, name=arp_ol, 
len=4
[    5.005270] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, name=arpoe, len=4
[    5.005474] brcmfmac: brcmf_configure_arp_nd_offload successfully 
configured (1) ARP offload to 0x9
[    5.005475] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, name=ndoe, len=4
[    5.005788] brcmfmac: brcmf_configure_arp_nd_offload successfully 
configured (1) ND offload to 0x9
[    5.005790] brcmfmac: _brcmf_set_multicast_list Enter, bsscfgidx=0
[    5.005792] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, 
name=mcast_list, len=16
[    5.006050] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, 
name=allmulti, len=4
[    5.006293] brcmfmac: brcmf_fil_cmd_int_set ifidx=0, cmd=10, value=0
[    5.006420] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, name=arp_ol, 
len=4
[    5.006626] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, name=arpoe, len=4
[    5.006835] brcmfmac: brcmf_configure_arp_nd_offload successfully 
configured (1) ARP offload to 0x9
[    5.006837] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, name=ndoe, len=4
[    5.007148] brcmfmac: brcmf_configure_arp_nd_offload successfully 
configured (1) ND offload to 0x9
[    5.008354] brcmfmac: brcmf_fil_iovar_data_get ifidx=0, 
name=chanspec, len=4, err=0
[    5.008362] brcmfmac: brcmf_cfg80211_get_tx_power Enter
[    5.008607] brcmfmac: brcmf_fil_iovar_data_get ifidx=0, 
name=qtxpower, len=4, err=0
[    5.008610] brcmfmac: brcmf_cfg80211_get_tx_power Exit (0x7f 31)
[    5.008859] brcmfmac: brcmf_fil_iovar_data_get ifidx=0, 
name=chanspec, len=4, err=0
[    5.008862] brcmfmac: brcmf_cfg80211_get_tx_power Enter
[    5.009112] brcmfmac: brcmf_fil_iovar_data_get ifidx=0, 
name=qtxpower, len=4, err=0
[    5.009114] brcmfmac: brcmf_cfg80211_get_tx_power Exit (0x7f 31)
[    5.009404] brcmfmac: brcmf_fil_iovar_data_get ifidx=0, 
name=chanspec, len=4, err=0
[    5.009408] brcmfmac: brcmf_cfg80211_get_tx_power Enter
[    5.009693] brcmfmac: brcmf_fil_iovar_data_get ifidx=0, 
name=qtxpower, len=4, err=0
[    5.009695] brcmfmac: brcmf_cfg80211_get_tx_power Exit (0x7f 31)
[    5.009851] brcmfmac: brcmf_fil_iovar_data_get ifidx=0, 
name=chanspec, len=4, err=0
[    5.009855] brcmfmac: brcmf_cfg80211_get_tx_power Enter
[    5.010102] brcmfmac: brcmf_fil_iovar_data_get ifidx=0, 
name=qtxpower, len=4, err=0
[    5.010105] brcmfmac: brcmf_cfg80211_get_tx_power Exit (0x7f 31)
[    5.010732] brcmfmac: brcmf_fil_iovar_data_get ifidx=0, 
name=chanspec, len=4, err=0
[    5.010737] brcmfmac: brcmf_cfg80211_get_tx_power Enter
[    5.010984] brcmfmac: brcmf_fil_iovar_data_get ifidx=0, 
name=qtxpower, len=4, err=0
[    5.010987] brcmfmac: brcmf_cfg80211_get_tx_power Exit (0x7f 31)
[    5.035480] brcmfmac: brcmf_cfg80211_flush_pmksa Enter
[    5.035489] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, 
name=pmkid_info, len=356
[    5.035999] brcmfmac: brcmf_cfg80211_flush_pmksa Exit
[    5.083266] brcmfmac: brcmf_cfg80211_scan Enter
[    5.083271] brcmfmac: brcmf_cfg80211_scan START ESCAN
[    5.083272] brcmfmac: brcmf_vif_set_mgmt_ie bsscfgidx 0, pktflag : 0x10
[    5.083275] brcmfmac: brcmf_do_escan Enter
[    5.083277] brcmfmac: brcmf_run_escan E-SCAN START
[    5.083278] brcmfmac: brcmf_escan_prep ### List of channelspecs to 
scan ### 36
[    5.083280] brcmfmac: brcmf_escan_prep Chan : 1, Channel spec: 1001
[    5.083281] brcmfmac: brcmf_escan_prep Chan : 2, Channel spec: 1002
[    5.083282] brcmfmac: brcmf_escan_prep Chan : 3, Channel spec: 1003
[    5.083283] brcmfmac: brcmf_escan_prep Chan : 4, Channel spec: 1004
[    5.083284] brcmfmac: brcmf_escan_prep Chan : 5, Channel spec: 1005
[    5.083285] brcmfmac: brcmf_escan_prep Chan : 6, Channel spec: 1006
[    5.083286] brcmfmac: brcmf_escan_prep Chan : 7, Channel spec: 1007
[    5.083287] brcmfmac: brcmf_escan_prep Chan : 8, Channel spec: 1008
[    5.083287] brcmfmac: brcmf_escan_prep Chan : 9, Channel spec: 1009
[    5.083288] brcmfmac: brcmf_escan_prep Chan : 10, Channel spec: 100a
[    5.083289] brcmfmac: brcmf_escan_prep Chan : 11, Channel spec: 100b
[    5.083290] brcmfmac: brcmf_escan_prep Chan : 36, Channel spec: d024
[    5.083291] brcmfmac: brcmf_escan_prep Chan : 40, Channel spec: d028
[    5.083292] brcmfmac: brcmf_escan_prep Chan : 44, Channel spec: d02c
[    5.083293] brcmfmac: brcmf_escan_prep Chan : 48, Channel spec: d030
[    5.083294] brcmfmac: brcmf_escan_prep Chan : 52, Channel spec: d034
[    5.083294] brcmfmac: brcmf_escan_prep Chan : 56, Channel spec: d038
[    5.083295] brcmfmac: brcmf_escan_prep Chan : 60, Channel spec: d03c
[    5.083296] brcmfmac: brcmf_escan_prep Chan : 64, Channel spec: d040
[    5.083297] brcmfmac: brcmf_escan_prep Chan : 100, Channel spec: d064
[    5.083298] brcmfmac: brcmf_escan_prep Chan : 104, Channel spec: d068
[    5.083299] brcmfmac: brcmf_escan_prep Chan : 108, Channel spec: d06c
[    5.083300] brcmfmac: brcmf_escan_prep Chan : 112, Channel spec: d070
[    5.083301] brcmfmac: brcmf_escan_prep Chan : 116, Channel spec: d074
[    5.083301] brcmfmac: brcmf_escan_prep Chan : 120, Channel spec: d078
[    5.083303] brcmfmac: brcmf_escan_prep Chan : 124, Channel spec: d07c
[    5.083303] brcmfmac: brcmf_escan_prep Chan : 128, Channel spec: d080
[    5.083304] brcmfmac: brcmf_escan_prep Chan : 132, Channel spec: d084
[    5.083305] brcmfmac: brcmf_escan_prep Chan : 136, Channel spec: d088
[    5.083306] brcmfmac: brcmf_escan_prep Chan : 140, Channel spec: d08c
[    5.083307] brcmfmac: brcmf_escan_prep Chan : 144, Channel spec: d090
[    5.083308] brcmfmac: brcmf_escan_prep Chan : 149, Channel spec: d095
[    5.083309] brcmfmac: brcmf_escan_prep Chan : 153, Channel spec: d099
[    5.083310] brcmfmac: brcmf_escan_prep Chan : 157, Channel spec: d09d
[    5.083310] brcmfmac: brcmf_escan_prep Chan : 161, Channel spec: d0a1
[    5.083311] brcmfmac: brcmf_escan_prep Chan : 165, Channel spec: d0a5
[    5.083312] brcmfmac: brcmf_escan_prep ### List of SSIDs to scan ### 1
[    5.083313] brcmfmac: brcmf_escan_prep 0: Broadcast scan
[    5.083314] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, name=escan, 
len=180
[    5.083722] brcmfmac: brcmf_fil_cmd_data Firmware error: BCME_VERSION 
(-37)
[    8.316080] brcmfmac: brcmf_cfg80211_scan Enter
[    8.316085] brcmfmac: brcmf_cfg80211_scan START ESCAN
[    8.316087] brcmfmac: brcmf_vif_set_mgmt_ie bsscfgidx 0, pktflag : 0x10
[    8.316091] brcmfmac: brcmf_do_escan Enter
[    8.316092] brcmfmac: brcmf_run_escan E-SCAN START
[    8.316093] brcmfmac: brcmf_escan_prep ### List of channelspecs to 
scan ### 36
[    8.316095] brcmfmac: brcmf_escan_prep Chan : 1, Channel spec: 1001
[    8.316096] brcmfmac: brcmf_escan_prep Chan : 2, Channel spec: 1002
[    8.316097] brcmfmac: brcmf_escan_prep Chan : 3, Channel spec: 1003
[    8.316098] brcmfmac: brcmf_escan_prep Chan : 4, Channel spec: 1004
[    8.316099] brcmfmac: brcmf_escan_prep Chan : 5, Channel spec: 1005
[    8.316100] brcmfmac: brcmf_escan_prep Chan : 6, Channel spec: 1006
[    8.316101] brcmfmac: brcmf_escan_prep Chan : 7, Channel spec: 1007
[    8.316102] brcmfmac: brcmf_escan_prep Chan : 8, Channel spec: 1008
[    8.316103] brcmfmac: brcmf_escan_prep Chan : 9, Channel spec: 1009
[    8.316104] brcmfmac: brcmf_escan_prep Chan : 10, Channel spec: 100a
[    8.316104] brcmfmac: brcmf_escan_prep Chan : 11, Channel spec: 100b
[    8.316105] brcmfmac: brcmf_escan_prep Chan : 36, Channel spec: d024
[    8.316106] brcmfmac: brcmf_escan_prep Chan : 40, Channel spec: d028
[    8.316107] brcmfmac: brcmf_escan_prep Chan : 44, Channel spec: d02c
[    8.316108] brcmfmac: brcmf_escan_prep Chan : 48, Channel spec: d030
[    8.316109] brcmfmac: brcmf_escan_prep Chan : 52, Channel spec: d034
[    8.316110] brcmfmac: brcmf_escan_prep Chan : 56, Channel spec: d038
[    8.316111] brcmfmac: brcmf_escan_prep Chan : 60, Channel spec: d03c
[    8.316112] brcmfmac: brcmf_escan_prep Chan : 64, Channel spec: d040
[    8.316113] brcmfmac: brcmf_escan_prep Chan : 100, Channel spec: d064
[    8.316114] brcmfmac: brcmf_escan_prep Chan : 104, Channel spec: d068
[    8.316115] brcmfmac: brcmf_escan_prep Chan : 108, Channel spec: d06c
[    8.316115] brcmfmac: brcmf_escan_prep Chan : 112, Channel spec: d070
[    8.316116] brcmfmac: brcmf_escan_prep Chan : 116, Channel spec: d074
[    8.316117] brcmfmac: brcmf_escan_prep Chan : 120, Channel spec: d078
[    8.316118] brcmfmac: brcmf_escan_prep Chan : 124, Channel spec: d07c
[    8.316119] brcmfmac: brcmf_escan_prep Chan : 128, Channel spec: d080
[    8.316120] brcmfmac: brcmf_escan_prep Chan : 132, Channel spec: d084
[    8.316121] brcmfmac: brcmf_escan_prep Chan : 136, Channel spec: d088
[    8.316122] brcmfmac: brcmf_escan_prep Chan : 140, Channel spec: d08c
[    8.316123] brcmfmac: brcmf_escan_prep Chan : 144, Channel spec: d090
[    8.316124] brcmfmac: brcmf_escan_prep Chan : 149, Channel spec: d095
[    8.316125] brcmfmac: brcmf_escan_prep Chan : 153, Channel spec: d099
[    8.316125] brcmfmac: brcmf_escan_prep Chan : 157, Channel spec: d09d
[    8.316126] brcmfmac: brcmf_escan_prep Chan : 161, Channel spec: d0a1
[    8.316127] brcmfmac: brcmf_escan_prep Chan : 165, Channel spec: d0a5
[    8.316128] brcmfmac: brcmf_escan_prep ### List of SSIDs to scan ### 1
[    8.316129] brcmfmac: brcmf_escan_prep 0: Broadcast scan
[    8.316130] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, name=escan, 
len=180
[    8.317949] brcmfmac: brcmf_fil_cmd_data Firmware error: BCME_VERSION 
(-37)
[   17.202228] brcmfmac: brcmf_cfg80211_scan Enter
[   17.202237] brcmfmac: brcmf_cfg80211_scan START ESCAN
[   17.202240] brcmfmac: brcmf_vif_set_mgmt_ie bsscfgidx 0, pktflag : 0x10
[   17.202247] brcmfmac: brcmf_do_escan Enter
[   17.202250] brcmfmac: brcmf_run_escan E-SCAN START
[   17.202253] brcmfmac: brcmf_escan_prep ### List of channelspecs to 
scan ### 36
[   17.202257] brcmfmac: brcmf_escan_prep Chan : 1, Channel spec: 1001
[   17.202260] brcmfmac: brcmf_escan_prep Chan : 2, Channel spec: 1002
[   17.202263] brcmfmac: brcmf_escan_prep Chan : 3, Channel spec: 1003
[   17.202265] brcmfmac: brcmf_escan_prep Chan : 4, Channel spec: 1004
[   17.202267] brcmfmac: brcmf_escan_prep Chan : 5, Channel spec: 1005
[   17.202270] brcmfmac: brcmf_escan_prep Chan : 6, Channel spec: 1006
[   17.202272] brcmfmac: brcmf_escan_prep Chan : 7, Channel spec: 1007
[   17.202275] brcmfmac: brcmf_escan_prep Chan : 8, Channel spec: 1008
[   17.202277] brcmfmac: brcmf_escan_prep Chan : 9, Channel spec: 1009
[   17.202280] brcmfmac: brcmf_escan_prep Chan : 10, Channel spec: 100a
[   17.202283] brcmfmac: brcmf_escan_prep Chan : 11, Channel spec: 100b
[   17.202285] brcmfmac: brcmf_escan_prep Chan : 36, Channel spec: d024
[   17.202288] brcmfmac: brcmf_escan_prep Chan : 40, Channel spec: d028
[   17.202290] brcmfmac: brcmf_escan_prep Chan : 44, Channel spec: d02c
[   17.202293] brcmfmac: brcmf_escan_prep Chan : 48, Channel spec: d030
[   17.202295] brcmfmac: brcmf_escan_prep Chan : 52, Channel spec: d034
[   17.202298] brcmfmac: brcmf_escan_prep Chan : 56, Channel spec: d038
[   17.202300] brcmfmac: brcmf_escan_prep Chan : 60, Channel spec: d03c
[   17.202303] brcmfmac: brcmf_escan_prep Chan : 64, Channel spec: d040
[   17.202305] brcmfmac: brcmf_escan_prep Chan : 100, Channel spec: d064
[   17.202308] brcmfmac: brcmf_escan_prep Chan : 104, Channel spec: d068
[   17.202311] brcmfmac: brcmf_escan_prep Chan : 108, Channel spec: d06c
[   17.202313] brcmfmac: brcmf_escan_prep Chan : 112, Channel spec: d070
[   17.202316] brcmfmac: brcmf_escan_prep Chan : 116, Channel spec: d074
[   17.202318] brcmfmac: brcmf_escan_prep Chan : 120, Channel spec: d078
[   17.202321] brcmfmac: brcmf_escan_prep Chan : 124, Channel spec: d07c
[   17.202323] brcmfmac: brcmf_escan_prep Chan : 128, Channel spec: d080
[   17.202326] brcmfmac: brcmf_escan_prep Chan : 132, Channel spec: d084
[   17.202328] brcmfmac: brcmf_escan_prep Chan : 136, Channel spec: d088
[   17.202330] brcmfmac: brcmf_escan_prep Chan : 140, Channel spec: d08c
[   17.202333] brcmfmac: brcmf_escan_prep Chan : 144, Channel spec: d090
[   17.202335] brcmfmac: brcmf_escan_prep Chan : 149, Channel spec: d095
[   17.202338] brcmfmac: brcmf_escan_prep Chan : 153, Channel spec: d099
[   17.202340] brcmfmac: brcmf_escan_prep Chan : 157, Channel spec: d09d
[   17.202343] brcmfmac: brcmf_escan_prep Chan : 161, Channel spec: d0a1
[   17.202345] brcmfmac: brcmf_escan_prep Chan : 165, Channel spec: d0a5
[   17.202348] brcmfmac: brcmf_escan_prep ### List of SSIDs to scan ### 1
[   17.202350] brcmfmac: brcmf_escan_prep 0: Broadcast scan
[   17.202352] brcmfmac: brcmf_fil_iovar_data_set ifidx=0, name=escan, 
len=180
[   17.204223] brcmfmac: brcmf_fil_cmd_data Firmware error: BCME_VERSION 
(-37)
root@inmusic-az04-mpc:~# [   44.202645] ieee80211 phy0: brcmf_run_escan: 
error (-52)
[   44.202649] ieee80211 phy0: brcmf_cfg80211_scan: scan error (-52)

-Andy


> Regards,
> Arend
