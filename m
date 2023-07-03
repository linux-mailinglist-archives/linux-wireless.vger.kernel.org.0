Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79AFB74567D
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jul 2023 09:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjGCHym (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Jul 2023 03:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjGCHyl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Jul 2023 03:54:41 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFD9BA;
        Mon,  3 Jul 2023 00:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1688370872;
        bh=m2Dy62S45LeV/Nzz8GqTl/9j3vHyQ7Q7zgsP/xNoTZ8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UFC+FosVLGklvMtA0GfoORIIuikpOC/oTZPna2OYbPXL6VzRj5qBEb27PgbqNepZc
         yNhxfWHdw3quMSaJST9AGBQNrkm7ClBDVsbOMpt4G7p3CUijA90pi1Mdr7bh61u8+f
         PgeD71CzJB59WT1rALLg/7pVru6IppnJAtjXsQsA=
Received: from [IPv6:240e:358:110a:4b00:dc73:854d:832e:4] (unknown [IPv6:240e:358:110a:4b00:dc73:854d:832e:4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 1CE0C66015;
        Mon,  3 Jul 2023 03:54:26 -0400 (EDT)
Message-ID: <9274d9bd3d080a457649ff5addcc1726f08ef5b2.camel@xry111.site>
Subject: Re: Fwd: iwlwifi causes dma-iommu.c:693 __iommu_dma_unmap since
 commit 19898ce9cf8a
From:   Xi Ruoyao <xry111@xry111.site>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        =?gb2312?Q?Nikl=A8=A1vs_Ko=810=914es=810=923ikovs?= 
        <pinkflames.linux@gmail.com>,
        Nate Watterson <nwatters@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Linux IO Memory Management Unit <iommu@lists.linux.dev>
Cc:     Linux Wireless <linux-wireless@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>
Date:   Mon, 03 Jul 2023 15:54:17 +0800
In-Reply-To: <a5cdc7f8-b340-d372-2971-0d24b01de217@gmail.com>
References: <a5cdc7f8-b340-d372-2971-0d24b01de217@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 2023-07-02 at 19:13 +0700, Bagas Sanjaya wrote:
> Hi,
>=20
> I notice a regression report on Bugzilla [1]: Quoting from it:
>=20
> > Since commit 19898ce9cf8a the iwlwifi has generated three possibly
> > identical kernel stack traces for me. Because I only use the
> > Bluetooth but not the Wi-Fi functionality, this is not a big deal
> > for me but I thought such an issue is worth reporting nontheless.
> >=20
> > All three traces point at **drivers/iommu/dma-iommu.c:693
> > __iommu_dma_unmap+0x150/0x160**.
> >=20
> > I'm attaching to this bug report the three stack traces along with
> > other possibly relevant dmesg parts. Sorry in advance for not
> > cutting at the cut here markers which resulted in considerably
> > longer text but I suspected that the PCI, ACPI, memory and possibly
> > iwlwifi related messages may be of importance, too. If I should cut
> > the stack traces out and attach them as three distinct files (and
> > diff to see if there's any change between them) let me know. I can
> > provide a full (but redacted) dmesg output of a git master build, if
> > required as well.
> >=20
> > I did try booting a much more recent git master build with
> > *iommu.passthrough=3D0 iommu.strict=3D0* on the kernel command line but
> > that did not seem to make any difference.
> >=20
> > ```
> > 19898ce9cf8a33e0ac35cb4c7f68de297cc93cb2 is the first bad commit
> > commit 19898ce9cf8a33e0ac35cb4c7f68de297cc93cb2
> > Author: Johannes Berg <johannes.berg@intel.com>
> > Date:=C2=A0=C2=A0 Wed Jun 21 13:12:07 2023 +0300
> >=20
> > =C2=A0=C2=A0=C2=A0 wifi: iwlwifi: split 22000.c into multiple files
> > =C2=A0=C2=A0=C2=A0=20
> > =C2=A0=C2=A0=C2=A0 Split the configuration list in 22000.c into four ne=
w files,
> > =C2=A0=C2=A0=C2=A0 per new device family, so we don't have this huge un=
usable
> > =C2=A0=C2=A0=C2=A0 file. Yes, this duplicates a few small things, but t=
hat's
> > =C2=A0=C2=A0=C2=A0 still much better than what we have now.
> > =C2=A0=C2=A0=C2=A0=20
> > =C2=A0=C2=A0=C2=A0 Signed-off-by: Johannes Berg <johannes.berg@intel.co=
m>
> > =C2=A0=C2=A0=C2=A0 Signed-off-by: Gregory Greenman <gregory.greenman@in=
tel.com>
> > =C2=A0=C2=A0=C2=A0 Link:
> > https://lore.kernel.org/r/20230621130443.7543603b2ee7.Ia8dd54216d341ef1=
ddc0531f2c9aa30d30536a5d@changeid
> > =C2=A0=C2=A0=C2=A0 Signed-off-by: Johannes Berg <johannes.berg@intel.co=
m>
> >=20
> > =C2=A0drivers/net/wireless/intel/iwlwifi/Makefile=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 1 +
> > =C2=A0drivers/net/wireless/intel/iwlwifi/cfg/22000.c=C2=A0 | 939 +-----=
-------
> > -----------
> > =C2=A0drivers/net/wireless/intel/iwlwifi/cfg/ax210.c=C2=A0 | 452 ++++++=
++++++
> > =C2=A0drivers/net/wireless/intel/iwlwifi/cfg/bz.c=C2=A0=C2=A0=C2=A0=C2=
=A0 | 523 +++++++++++++
> > =C2=A0drivers/net/wireless/intel/iwlwifi/cfg/sc.c=C2=A0=C2=A0=C2=A0=C2=
=A0 | 214 ++++++
> > =C2=A0drivers/net/wireless/intel/iwlwifi/iwl-config.h |=C2=A0=C2=A0 2 +
> > =C2=A0drivers/net/wireless/intel/iwlwifi/pcie/drv.c=C2=A0=C2=A0 |=C2=A0=
=C2=A0 3 +
> > =C2=A07 files changed, 1206 insertions(+), 928 deletions(-)
> > =C2=A0create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
> > =C2=A0create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/bz.c
> > =C2=A0create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/sc.c
> > ```
> >=20
>=20
> See Bugzilla for the full thread and attached dmesg.

I can reproduce the issue with an AX210 (the firmware is named iwlwifi-
ty-a0-gf-a0-81.ucode).  Reverting
19898ce9cf8a33e0ac35cb4c7f68de297cc93cb2 (and all following commits in
the same series) fixes the issue.

I guess some error messages might be useful:

[    4.058873] iwlwifi 0000:2b:00.0: Error sending NVM_ACCESS_COMPLETE: tim=
e out after 2000ms.
[    4.060263] iwlwifi 0000:2b:00.0: Current CMD queue read_ptr 1 write_ptr=
 2
[    4.062814] iwlwifi 0000:2b:00.0: Start IWL Error Log Dump:
[    4.064440] iwlwifi 0000:2b:00.0: Transport status: 0x0000004A, valid: 6
[    4.065481] iwlwifi 0000:2b:00.0: Loaded firmware version: 81.31fc9ae6.0=
 ty-a0-gf-a0-81.ucode
[    4.066655] iwlwifi 0000:2b:00.0: 0x00000084 | NMI_INTERRUPT_UNKNOWN    =
  =20
[    4.067725] iwlwifi 0000:2b:00.0: 0x002002F0 | trm_hw_status0
[    4.068799] iwlwifi 0000:2b:00.0: 0x00000000 | trm_hw_status1
[    4.069777] iwlwifi 0000:2b:00.0: 0x004DBEE0 | branchlink2
[    4.070828] iwlwifi 0000:2b:00.0: 0x004D1DEA | interruptlink1
[    4.071823] iwlwifi 0000:2b:00.0: 0x004D1DEA | interruptlink2
[    4.072774] iwlwifi 0000:2b:00.0: 0x00016582 | data1
[    4.073714] iwlwifi 0000:2b:00.0: 0x01000000 | data2
[    4.074748] iwlwifi 0000:2b:00.0: 0x00000000 | data3
[    4.075681] iwlwifi 0000:2b:00.0: 0x00000000 | beacon time
[    4.076695] iwlwifi 0000:2b:00.0: 0x002097F1 | tsf low
[    4.077721] iwlwifi 0000:2b:00.0: 0x00000000 | tsf hi
[    4.078660] iwlwifi 0000:2b:00.0: 0x00000000 | time gp1
[    4.079680] iwlwifi 0000:2b:00.0: 0x0021B671 | time gp2
[    4.080678] iwlwifi 0000:2b:00.0: 0x00000001 | uCode revision type
[    4.081667] iwlwifi 0000:2b:00.0: 0x00000051 | uCode version major
[    4.082653] iwlwifi 0000:2b:00.0: 0x31FC9AE6 | uCode version minor
[    4.083655] iwlwifi 0000:2b:00.0: 0x00000420 | hw version
[    4.084636] iwlwifi 0000:2b:00.0: 0x18C80002 | board version
[    4.085613] iwlwifi 0000:2b:00.0: 0x8005FF00 | hcmd
[    4.086578] iwlwifi 0000:2b:00.0: 0x00020000 | isr0
[    4.087527] iwlwifi 0000:2b:00.0: 0x00000000 | isr1
[    4.088469] iwlwifi 0000:2b:00.0: 0x48F00002 | isr2
[    4.089390] iwlwifi 0000:2b:00.0: 0x00C0001C | isr3
[    4.090307] iwlwifi 0000:2b:00.0: 0x00000000 | isr4
[    4.091202] iwlwifi 0000:2b:00.0: 0x00000000 | last cmd Id
[    4.092083] iwlwifi 0000:2b:00.0: 0x00016582 | wait_event
[    4.092943] iwlwifi 0000:2b:00.0: 0x00000000 | l2p_control
[    4.093801] iwlwifi 0000:2b:00.0: 0x00000000 | l2p_duration
[    4.094639] iwlwifi 0000:2b:00.0: 0x00000000 | l2p_mhvalid
[    4.095525] iwlwifi 0000:2b:00.0: 0x00000000 | l2p_addr_match
[    4.097449] iwlwifi 0000:2b:00.0: 0x00000009 | lmpm_pmg_sel
[    4.098323] iwlwifi 0000:2b:00.0: 0x00000000 | timestamp
[    4.099165] iwlwifi 0000:2b:00.0: 0x00000024 | flow_handler
[    4.100024] iwlwifi 0000:2b:00.0: Start IWL Error Log Dump:
[    4.100832] iwlwifi 0000:2b:00.0: Transport status: 0x0000004A, valid: 7
[    4.101641] iwlwifi 0000:2b:00.0: 0x20000066 | NMI_INTERRUPT_HOST
[    4.102522] iwlwifi 0000:2b:00.0: 0x00000000 | umac branchlink1
[    4.103379] iwlwifi 0000:2b:00.0: 0x8046DA88 | umac branchlink2
[    4.104210] iwlwifi 0000:2b:00.0: 0x8048DB3A | umac interruptlink1
[    4.105014] iwlwifi 0000:2b:00.0: 0x8048DB3A | umac interruptlink2
[    4.105790] iwlwifi 0000:2b:00.0: 0x01000000 | umac data1
[    4.106544] iwlwifi 0000:2b:00.0: 0x8048DB3A | umac data2
[    4.107338] iwlwifi 0000:2b:00.0: 0x00000000 | umac data3
[    4.108109] iwlwifi 0000:2b:00.0: 0x00000051 | umac major
[    4.108855] iwlwifi 0000:2b:00.0: 0x31FC9AE6 | umac minor
[    4.109581] iwlwifi 0000:2b:00.0: 0x0021B66F | frame pointer
[    4.110349] iwlwifi 0000:2b:00.0: 0xC0886258 | stack pointer
[    4.111099] iwlwifi 0000:2b:00.0: 0x00000203 | last host cmd
[    4.111815] iwlwifi 0000:2b:00.0: 0x00000400 | isr status reg
[    4.112530] iwlwifi 0000:2b:00.0: IML/ROM dump:
[    4.113265] iwlwifi 0000:2b:00.0: 0x00000B03 | IML/ROM error/state
[    4.113982] iwlwifi 0000:2b:00.0: 0x000076E7 | IML/ROM data1
[    4.114689] iwlwifi 0000:2b:00.0: 0x00000090 | IML/ROM WFPM_AUTH_KEY_0
[    4.115447] iwlwifi 0000:2b:00.0: Fseq Registers:
[    4.116168] iwlwifi 0000:2b:00.0: 0x60000100 | FSEQ_ERROR_CODE
[    4.116867] iwlwifi 0000:2b:00.0: 0x80440007 | FSEQ_TOP_INIT_VERSION
[    4.117548] iwlwifi 0000:2b:00.0: 0x00080009 | FSEQ_CNVIO_INIT_VERSION
[    4.118265] iwlwifi 0000:2b:00.0: 0x0000A652 | FSEQ_OTP_VERSION
[    4.118946] iwlwifi 0000:2b:00.0: 0x00000002 | FSEQ_TOP_CONTENT_VERSION
[    4.119624] iwlwifi 0000:2b:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
[    4.121025] iwlwifi 0000:2b:00.0: 0x00400410 | FSEQ_CNVR_ID
[    4.121675] iwlwifi 0000:2b:00.0: 0x00400410 | CNVI_AUX_MISC_CHIP
[    4.122377] iwlwifi 0000:2b:00.0: 0x00400410 | CNVR_AUX_MISC_CHIP
[    4.123048] iwlwifi 0000:2b:00.0: 0x00009061 | CNVR_SCU_SD_REGS_SD_REG_D=
IG_DCDC_VTRIM
[    4.123693] iwlwifi 0000:2b:00.0: 0x00000061 | CNVR_SCU_SD_REGS_SD_REG_A=
CTIVE_VDIG_MIRROR
[    4.124383] iwlwifi 0000:2b:00.0: 0x00080009 | FSEQ_PREV_CNVIO_INIT_VERS=
ION
[    4.125055] iwlwifi 0000:2b:00.0: 0x00440005 | FSEQ_WIFI_FSEQ_VERSION
[    4.125703] iwlwifi 0000:2b:00.0: 0x00440005 | FSEQ_BT_FSEQ_VERSION
[    4.126407] iwlwifi 0000:2b:00.0: 0x000000D2 | FSEQ_CLASS_TP_VERSION
[    4.127103] iwlwifi 0000:2b:00.0: UMAC CURRENT PC: 0x8048d640
[    4.127769] iwlwifi 0000:2b:00.0: LMAC1 CURRENT PC: 0xd0
[    4.128437] iwlwifi 0000:2b:00.0: Failed to run complete NVM access: -11=
0
[    4.129134] iwlwifi 0000:2b:00.0: WRT: Collecting data: ini trigger 13 f=
ired (delay=3D0ms).

And (part of) the stack trace:

[    5.071954]  iommu_dma_free+0x17/0x30
[    5.073232]  iwl_txq_gen2_free_memory+0x39/0x90 [iwlwifi]
[    5.074572]  iwl_txq_gen2_free+0x53/0xe0 [iwlwifi]
[    5.075954]  iwl_txq_gen2_tx_free+0x34/0x50 [iwlwifi]
[    5.077244]  _iwl_trans_pcie_gen2_stop_device+0x2f6/0x470 [iwlwifi]
[    5.078589]  iwl_trans_pcie_gen2_stop_device+0x50/0x70 [iwlwifi]
[    5.079993]  iwl_mvm_stop_device+0x35/0x50 [iwlmvm]
[    5.081307]  iwl_mvm_start_get_nvm+0x151/0x1d0 [iwlmvm]
[    5.082664]  iwl_op_mode_mvm_start+0x7b8/0x970 [iwlmvm]
[    5.084066]  _iwl_op_mode_start.isra.0+0x58/0x70 [iwlwifi]
[    5.085387]  iwl_opmode_register+0x68/0xd0 [iwlwifi]
[    5.086746]  ? 0xffffffffc0cf3000
[    5.088013]  iwl_mvm_init+0x21/0x1000 [iwlmvm]

I compared the iwlax210_2ax_cfg_ty_gf_a0 struct in the preprocessed
source before and after 19898ce9cf8a33e0ac35cb4c7f68de297cc93cb2 change.
The only suspicious change is the removal of ".trans.use_tfh =3D true,",
but adding this line into iwlax210_2ax_cfg_ty_gf_a0 does not fix the
issue.


--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
