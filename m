Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17B463779B
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Nov 2022 12:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiKXLYJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Nov 2022 06:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiKXLYI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Nov 2022 06:24:08 -0500
Received: from mog.warmcat.com (mog.warmcat.com [178.170.10.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D379167F4
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 03:24:04 -0800 (PST)
Received: from mx.warmcat.com (host31-53-12-215.range31-53.btcentralplus.com [31.53.12.215])
        by mog.warmcat.com (Postfix) with ESMTPSA id CCB82135628;
        Thu, 24 Nov 2022 11:24:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mog.warmcat.com CCB82135628
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=warmcat.com;
        s=default; t=1669289043;
        bh=XuJE5/fb75BqQZOfJ1Kia1tzHpMdbBfhwWXjQ+Wd+JU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=izq1dmKDmvRzBXlQp784VOvQneHANiRB2qOQkz9ShQoBbieD6G26h7xqAOciBDfUk
         43VKDufBiLMM26a7SIY6r962JFWkVoWhJCJden4AoIh5I6Wzx12UJR91m1TmtUNtW5
         E03ALC210DTKgJNNppuoM9qxoabMFHdOkypL1jG4=
Received: from [192.168.4.115] (unknown [192.168.4.115])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by mx.warmcat.com (Postfix) with ESMTPSA id 491102A00C0;
        Thu, 24 Nov 2022 11:24:03 +0000 (GMT)
Message-ID: <2db80338-c92d-b006-c281-dab943029168@warmcat.com>
Date:   Thu, 24 Nov 2022 11:24:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: AP6275 / bcm43752 pcie on mainline brcmf
Content-Language: en-US
To:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Shengyu Qu <wiagn233@outlook.com>
Cc:     franky.lin@broadcom.com, linux-wireless@vger.kernel.org
References: <TY3P286MB26114DD461F50814980453E598029@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <18470a1e910.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <TY3P286MB26115A58795F264893CCB40198029@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <184720fc920.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <TY3P286MB26118BD94839F752CADCCF5298079@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <625f1d5d-e137-7ad7-96b9-92035e87df8b@broadcom.com>
 <638afa8e-a393-410c-3182-0d8e9b6da17d@warmcat.com>
 <1848793db88.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <3a562a50-0cef-4879-3691-3258596f5213@warmcat.com>
 <1cbb3bf5-fd70-e9db-2405-640178862857@broadcom.com>
 <bea00730-5411-a3c4-0ead-bb73889c25f6@warmcat.com>
 <6774d660-eb2e-50be-0024-8faf9b3d4c4e@broadcom.com>
 <48b3ca0a-c7a8-d5ee-796c-a239a8ca5a41@warmcat.com>
 <f2d334c3-cce1-09c8-8585-f1e668b8d24e@broadcom.com>
 <e4bf8b7f-915e-5432-4a2d-c7467f64e1a4@warmcat.com>
 <16700dbc-4630-eb7a-3d67-6e5a47d36ad8@broadcom.com>
From:   Andy Green <andy@warmcat.com>
In-Reply-To: <16700dbc-4630-eb7a-3d67-6e5a47d36ad8@broadcom.com>
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



On 11/24/22 11:18, Arend van Spriel wrote:

> Could you try and modify the nvram file, ie. change value for 
> boardflags3 to 0x44002180.

Yes, it was  0x40002180 before, here's the modified file

# AP6275P_NVRAM_V1.2_20210918A
# AP6271P_V00 board, iPA version.
# nvram copied and edited from AP6271P_EVB_V02 EVB board //
# SSID generated using Alberto's boardssid.py script:
# ********************SUMMARY********************
# Board Name: AP6271P_V00
#SSID: 0x086d
#macmid: 0x02df
# Successfully made SSID entry in sromdefs.tcl.
# Successfully made macmid entry in sromdefs.tcl.
# Successfully made SSID entry in tblssid.py.
# *************************************************
# $ Copyright Broadcom $
#
#
# <<Broadcom-WL-IPTag/Proprietary:>>
NVRAMRev=$Rev: 874188 $
sromrev=11
boardrev=0x1213
boardtype=0x08ed
boardflags=0x00400201
boardflags2=0xc0800000
boardflags3=0x44002180
#boardnum=57410
macaddr=00:90:4c:12:d0:01
jtag_irw=38

#Regulatory specific
ccode=0
regrev=0

# Board specific
vendid=0x14e4
devid=0x449d
manfid=0x2d0
antswitch=0
pdgain5g=0
pdgain2g=0
aa2g=3
aa5g=3
agbg0=2
agbg1=2
aga0=2
aga1=2
extpagain2g=2
extpagain5g=2
rxgains2gelnagaina0=0
rxgains2gtrisoa0=0
rxgains2gtrelnabypa0=0
rxgains5gelnagaina0=0
rxgains5gtrisoa0=0
rxgains5gtrelnabypa0=0
rxgains5gmelnagaina0=0
rxgains5gmtrisoa0=0
rxgains5gmtrelnabypa0=0
rxgains5ghelnagaina0=0
rxgains5ghtrisoa0=0
rxgains5ghtrelnabypa0=0
rxgains2gelnagaina1=0
rxgains2gtrisoa1=0
rxgains2gtrelnabypa1=0
rxgains5gelnagaina1=0
rxgains5gtrisoa1=0
rxgains5gtrelnabypa1=0
rxgains5gmelnagaina1=0
rxgains5gmtrisoa1=0
rxgains5gmtrelnabypa1=0
rxgains5ghelnagaina1=0
rxgains5ghtrisoa1=0
rxgains5ghtrelnabypa1=0

#RSSI related
# 2G
rssicorrnorm_c0=4,4
rssicorrnorm_c1=4,4
# 5G
rssicorrnorm5g_c0=5,5,5,5,5,5,5,5,5,5,5,5
rssicorrnorm5g_c1=4,4,4,4,4,4,4,4,4,4,4,4


#Two range TSSI
tworangetssi2g=0
tworangetssi5g=0
lowpowerrange2g=0
lowpowerrange5g=0
low_adc_rate_en=1

nocrc=1
otpimagesize=502

xtalfreq=37400

txchain=3
rxchain=3

cckdigfilttype=2

#bit mask for slice capability bit 0:2G bit 1:5G
bandcap=3

#TXBF Related
rpcal2g=0
rpcal5gb0=0
rpcal5gb1=0
rpcal5gb2=0
rpcal5gb3=0


#FDSS Related
fdss_level_2g=4,4
fdss_interp_en=1
fdss_level_5g=3,3
fdss_level_11ax_2g=3,3
fdss_level_11ax_2g_ch1=3,3
fdss_level_11ax_2g_ch11=3,3
fdss_level_11ax_5g=3,3

#Tempsense Related
tempthresh=255
tempoffset=40
rawtempsense=0x1ff
phycal_tempdelta=15
temps_period=15
temps_hysteresis=15

#------------- TSSI Related -------------
tssipos2g=1
tssipos5g=1
AvVmid_c0=2,127,4,92,4,91,4,91,4,94
AvVmid_c1=2,127,4,93,4,93,4,95,3,110

# CCK in case of multi mode 2
pa2gccka0=-51,9141,-1039
pa2gccka1=-106,8172,-949
# OFDM in case of multi_mode 2

pa2ga0=-31,8047,-863
pa2ga1=-3,8006,-803

pa5ga0=-184,5375,-671,-174,5517,-677,-193,5122,-649,-177,5303,-666
pa5ga1=-207,5022,-635,-168,5741,-695,-169,5544,-687,-182,5435,-687


# Max power and offsets
maxp2ga0=88
maxp2ga1=88
maxp5ga0=68,68,68,68
maxp5ga1=69,69,66,66
subband5gver=0x4
paparambwver=3
cckpwroffset0=0
cckpwroffset1=0
pdoffset40ma0=0x4444
pdoffset80ma0=0x4444
pdoffset40ma1=0x4444
pdoffset80ma1=0x4444
cckbw202gpo=0x4444
cckbw20ul2gpo=0
mcsbw202gpo=0xBB977665
mcsbw402gpo=0xBB977665
dot11agofdmhrbw202gpo=0x7766
ofdmlrbw202gpo=0x0055
mcsbw205glpo=0x88331100
mcsbw405glpo=0xC8332200
mcsbw805glpo=0xCC443320
mcsbw1605glpo=0
mcsbw205gmpo=0x88331100
mcsbw405gmpo=0xC8332200
mcsbw805gmpo=0xCC443320
mcsbw1605gmpo=0
mcsbw205ghpo=0x88331100
mcsbw405ghpo=0xC8333300
mcsbw805ghpo=0xCC443320
powoffs2gtna0=0,0,0,0,0,0,0,0,0,0,0,0,0,0
powoffs2gtna1=0,0,0,0,0,0,0,0,0,0,0,0,0,0
mcs1024qam2gpo=0xEEEE
mcs1024qam5glpo=0xFFFFDD
mcs1024qam5gmpo=0xFFFFDD
mcs1024qam5ghpo=0xFFFFDD
mcs1024qam5gx1po=0xFFFFDD
mcs1024qam5gx2po=0xFFFFDD
mcs8poexp=0
mcs9poexp=0
mcs10poexp=0

# 5G power offset per channel for band edge channel
powoffs5g20mtna0=0,0,0,0,0,0,0
powoffs5g20mtna1=0,0,0,0,0,0,0
powoffs5g40mtna0=0,0,0,0,0
powoffs5g40mtna1=0,0,0,0,0
powoffs5g80mtna0=0,0,0,0,0
powoffs5g80mtna1=0,0,0,0,0
mcs11poexp=0

#LTE Coex Related
ltecxmux=0
ltecxpadnum=0x0504
ltecxfnsel=0x44
ltecxgcigpio=0x04
#OOB params
#device_wake_opt=1
host_wake_opt=0

# SWCTRL Related

swctrlmap_2g=0x10101010,0x06030401,0x04011010,0x000000,0x3FF
swctrlmapext_2g=0x00000000,0x00000000,0x00000000,0x000000,0x000
swctrlmap_5g=0x80408040,0x21240120,0x01208040,0x000000,0x3FF
swctrlmapext_5g=0x00000000,0x00000000,0x00000000,0x000000,0x000
clb2gslice0core0=0x01b
clb2gslice1core0=0x000
clb5gslice0core0=0x064
clb5gslice1core0=0x000
clb2gslice0core1=0x056
clb2gslice1core1=0x000
clb5gslice0core1=0x0a1
clb5gslice1core1=0x000
btc_prisel_ant_mask=0x2
clb_swctrl_smask_ant0=0x27f
clb_swctrl_smask_ant1=0x2f7
muxenab=1

#BT Coex 1:TDM
btc_mode=1

# --- PAPD Cal related params ----
txwbpapden=0 # 0:NBPAPD 1:WBPAPD
# NB PAPD Cal params
nb_eps_offset=470,470
nb_bbmult=66,66
nb_papdcalidx=6,6
nb_txattn=2,2
nb_rxattn=1,1
nb_eps_stopidx=63
epsilonoff_5g20_c0=0,0,0,0
epsilonoff_5g40_c0=0,0,0,0
epsilonoff_5g80_c0=0,0,0,0
epsilonoff_5g20_c1=0,0,-2,-3
epsilonoff_5g40_c1=0,0,-2,-3
epsilonoff_5g80_c1=0,0,-2,-3
epsilonoff_2g20_c0=0
epsilonoff_2g20_c1=0

# energy detect threshold
ed_thresh2g=-67
ed_thresh5g=-67
# energy detect threshold for EU
eu_edthresh2g=-67
eu_edthresh5g=-67

#rpcal coef for imptxbf
rpcal5gb0=238
rpcal5gb1=228
rpcal5gb2=222
rpcal5gb3=229
rpcal2g=15
ocl=1
bt_coex_chdep_div=1

# OLPC Related
disable_olpc=0
olpc_thresh5g=32
olpc_anchor5g=40
olpc_thresh2g=32
olpc_anchor2g=40

#PAPR related
paprdis=0
paprrmcsgamma2g=500,550,550,-1,-1,-1,-1,-1,-1,-1,-1,-1
paprrmcsgain2g=128,128,128,0,0,0,0,0,0,0,0,0
paprrmcsgamma2g_ch13=500,550,550,-1,-1,-1,-1,-1,-1,-1,-1,-1
paprrmcsgain2g_ch13=128,128,128,0,0,0,0,0,0,0,0,0
paprrmcsgamma2g_ch1=500,550,550,-1,-1,-1,-1,-1,-1,-1,-1,-1
paprrmcsgain2g_ch1=128,128,128,0,0,0,0,0,0,0,0,0
paprrmcsgamma5g20=500,500,500,-1,-1,-1,-1,-1,-1,-1,-1,-1
paprrmcsgain5g20=128,128,128,0,0,0,0,0,0,0,0,0
paprrmcsgamma5g40=600,600,600,-1,-1,-1,-1,-1,-1,-1,-1,-1
paprrmcsgain5g40=128,128,128,0,0,0,0,0,0,0,0,0
paprrmcsgamma5g80=-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
paprrmcsgain5g80=0,0,0,0,0,0,0,0,0,0,0,0

# Enable papd for cck when target pwr ge 16dBm
cckpapd_pwrthresh=64

## ULOFDMA Board limit PPRs for 2G20 ##
ruppr2g20bpska0=0x00021084
ruppr2g20bpska1=0x00021084
ruppr2g20qpska0=0x00021084
ruppr2g20qpska1=0x00021084
ruppr2g20qam16a0=0x000294A5
ruppr2g20qam16a1=0x000294A5
ruppr2g20qam64a0=0x00039CE7
ruppr2g20qam64a1=0x00039CE7
ruppr2g20qam256a0=0x0005AD6B
ruppr2g20qam256a1=0x0005AD6B
ruppr2g20qam1024a0=0x0005AD6B
ruppr2g20qam1024a1=0x0005AD6B
## ULOFDMA Board limit PPRs for 5G20 ##
ruppr5g20bpska0=0x00008421
ruppr5g20bpska1=0x00008421
ruppr5g20qpska0=0x00008421
ruppr5g20qpska1=0x00008421
ruppr5g20qam16a0=0x00010842
ruppr5g20qam16a1=0x00010842
ruppr5g20qam64a0=0x00021084
ruppr5g20qam64a1=0x00021084
ruppr5g20qam256a0=0x00042108
ruppr5g20qam256a1=0x00042108
ruppr5g20qam1024a0=0x0006318C
ruppr5g20qam1024a1=0x0006318C
## ULOFDMA Board limit PPRs for 5G40 ##
ruppr5g40bpska0=0x00108421
ruppr5g40bpska1=0x00108421
ruppr5g40qpska0=0x00108421
ruppr5g40qpska1=0x00108421
ruppr5g40qam16a0=0x00210842
ruppr5g40qam16a1=0x00210842
ruppr5g40qam64a0=0x00421084
ruppr5g40qam64a1=0x00421084
ruppr5g40qam256a0=0x00C6318C
ruppr5g40qam256a1=0x00C6318C
ruppr5g40qam1024a0=0x01084210
ruppr5g40qam1024a1=0x01084210
## ULOFDMA Board limit PPRs for 5G80 ##
ruppr5g80bpska0=0x04108421
ruppr5g80bpska1=0x04108421
ruppr5g80qpska0=0x04108421
ruppr5g80qpska1=0x04108421
ruppr5g80qam16a0=0x0C318C63
ruppr5g80qam16a1=0x0C318C63
ruppr5g80qam64a0=0x10421084
ruppr5g80qam64a1=0x10421084
ruppr5g80qam256a0=0x30C6318C
ruppr5g80qam256a1=0x30C6318C
ruppr5g80qam1024a0=0x41084210
ruppr5g80qam1024a1=0x41084210


It is the same result.  Logs from where it loads the NVRAM file

[    3.534708] brcmfmac: brcmf_fw_complete_request firmware 
brcm/fw_bcm43752a2_pcie.txt found
[    3.534709] brcmfmac: brcmf_fw_request_nvram_done enter: dev=0002:21:00.0
[    3.534771] brcmfmac: brcmf_fw_request_nvram_done nvram 
0000000007e422eb len 6040
[    3.534774] brcmfmac: brcm_alt_fw_path FW alt path: 
brcm/fw_bcm43752a2_pcie.rockchip,rk3588-evb1-v10.clm_blob
[    3.535350] brcmfmac: brcmf_fw_complete_request firmware 
brcm/fw_bcm43752a2_pcie.clm_blob found
[    3.535558] brcmfmac: brcmf_chip_tcm_rambase: 43752 OK
[    3.535559] brcmfmac: brcmf_chip_get_raminfo RAM: base=0x170000 
size=1310720 (0x140000) sr=0 (0x0)
[    3.628168] brcmfmac: Download NVRAM brcm/fw_bcm43752a2_pcie.txt
[    3.628767] brcmfmac: brcmf_pcie_write_entropy_bytes: written 128 
entropy bytes
[    3.628787] brcmfmac: brcmf_pcie_download_fw_nvram: sharedram_addr 
0xfa1a05e5
[    3.628789] brcmfmac: brcmf_chip_set_active Enter
[    9.689983] brcmfmac 0002:21:00.0: brcmf_pcie_download_fw_nvram: FW 
failed to initialize: 0xfa1a05e5

Since it mentions the vid:pid, here's the verbose lspci for it

0002:21:00.0 0280: 14e4:449d (rev 02)
	Subsystem: 14e4:aae8
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 47
	Region 0: Memory at f2200000 (64-bit, non-prefetchable) [size=64K]
	Region 2: Memory at f2400000 (64-bit, non-prefetchable) [size=4M]
	Capabilities: [48] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=2 PME-
	Capabilities: [58] MSI: Enable- Count=1/32 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [68] Vendor Specific Information: Len=38 <?>
	Capabilities: [ac] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 0.000W
		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+ FLReset-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L1, Exit Latency L1 <32us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s (ok), Width x1 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Via WAKE#, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
		LnkCap2: Supported Link Speeds: 2.5GT/s, Crosslink- Retimer- 
2Retimers- DRS-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- 
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- 
EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ 
MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ 
ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [13c v1] Device Serial Number 00-00-00-ff-ff-00-00-00
	Capabilities: [150 v1] Power Budgeting <?>
	Capabilities: [160 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [1b0 v1] Latency Tolerance Reporting
		Max snoop latency: 0ns
		Max no snoop latency: 0ns
	Capabilities: [220 v1] Physical Resizable BAR
		BAR 2: current size: 8MB, supported: 1MB 2MB 4MB
	Capabilities: [240 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=8us PortTPowerOnTime=50us
		L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
			   T_CommonMode=0us LTR1.2_Threshold=0ns
		L1SubCtl2: T_PwrOn=10us
	Kernel modules: brcmfmac


-Andy
