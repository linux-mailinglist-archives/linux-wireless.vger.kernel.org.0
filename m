Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0971F7A9B6F
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 21:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjIUTBX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Sep 2023 15:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjIUTBG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Sep 2023 15:01:06 -0400
X-Greylist: delayed 607 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 21 Sep 2023 10:35:07 PDT
Received: from marcos.anarc.at (marcos.anarc.at [64.18.183.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F5E7A117
        for <linux-wireless@vger.kernel.org>; Thu, 21 Sep 2023 10:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=debian.org;
        s=marcos-debian.anarcat.user; t=1695317096;
        bh=tFHkUSajED9o71dWuB8T9QkWTSwhuWCrYccMeMft0Hk=;
        h=From:To:Cc:Subject:Date:From;
        b=d4lgL/KGoivPdNodoKKmAZv/kQcyRoO8cimz8ZTvPmg3Q52JptmuGNk2vpEr/VrnJ
         SfzgDn3fYqS4g39kyzjZufCcjFb15BcGHwxnjpcqYIrrc88KgBDReD2Q/+YZcwzjGV
         fPLgP5HZx7X1SKDcVk0hUMvt7wl1nzLWx7p37BJ3sr4o04M0WuK/MWsnKnAPASyJpD
         4qBNtNpIUwEeGCYOYCvSvFA4WfOU0p6WfArFkoxgcfprKvbm2x326lVwUFIOytLERd
         E+eEigtjG6uvbMZvORT7HLPzQA4Vmrs1pFH96R8KcP4c6IQxRYtwTyam853VJX0oFe
         jxDwZdozMMuhA==
Received: by marcos.anarc.at (Postfix, from userid 1000)
        id 4407810E0F3; Thu, 21 Sep 2023 13:24:56 -0400 (EDT)
Received: by angela.localdomain (Postfix, from userid 1000)
        id AF5D1E0466; Thu, 21 Sep 2023 13:24:55 -0400 (EDT)
From:   =?utf-8?Q?Antoine_Beaupr=C3=A9?= <anarcat@debian.org>
To:     linux-wireless@vger.kernel.org
Cc:     Gregory Greenman <gregory.greenman@intel.com>
Subject: Microcode SW error since Linux 6.5
Organization: Debian
Autocrypt: addr=anarcat@debian.org; prefer-encrypt=nopreference;
 keydata=xjMEZHZPzhYJKwYBBAHaRw8BAQdAWdVzOFRW6FYVpeVaDo3sC4aJ2kUW4ukdEZ36UJLAHd7NJUFudG9pbmUgQmVhdXByw6kgPGFuYXJjYXRAZGViaWFuLm9yZz7ClgQTFggAPhYhBLu2zUyY104TWKdSpgIpOm+k5TRzBQJkdmCVAhsDBQkB4TOABQsJCAcDBRUKCQgLBRYCAwEAAh4BAheAAAoJEAIpOm+k5TRz+w8BANbRA+AMH0LN7trugVhaWe4wDpg94UVJloHPL+adJMK/AQCh39hyQXk3ivS2cK7xKZUgK0dBsbtJ2I2XBXvL9dS3Cc44BGR2UM4SCisGAQQBl1UBBQEBB0CYZha2IMY54WFXMG4S9/Smef54Pgon99LJ/hJ885p0ZAMBCAfCdwQYFggAIBYhBLu2zUyY104TWKdSpgIpOm+k5TRzBQJkdlDOAhsMAAoJEAIpOm+k5TRzBg0A+IbcsZhLx6FRIqBJCdfYMo7qovEo+vX0HZsUPRlq4HkBAIctCzmH3WyfOD/aUTeOF3tY+tIGUxxjQLGsNQZeGrQI
Date:   Thu, 21 Sep 2023 13:24:55 -0400
Message-ID: <87ttrncuc8.fsf@angela.anarc.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I've found what I feel might be a regression between Linux 6.1 and
6.5. For other reasons, I upgraded the kernel on my Debian 12
("bookworm", stale) laptop from the distribution 6.1.52 to the unstable
("sid") version, 6.5.3.

After the upgrade, I started to notice stuttering in my audio player, I
tracked it down and managed to correlate it with some kernel errors
related to the iwlwifi driver.

What's interesting is that this happens regardless of whether or not the
NIC is connected to a network. In at least one of the traces, the
computer was connected over a wire and wireless was not associated in
Network Manager.

Here's an example of the problem:

sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: Microcode SW error det=
ected. Restarting 0x0.
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: Start IWL Error Log Du=
mp:
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: Transport status: 0x00=
00004B, valid: 6
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: Loaded firmware versio=
n: 73.35c0a2c6.0 ty-a0-gf-a0-73.ucode
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x00000071 | NMI_INTER=
RUPT_UMAC_FATAL=20=20=20=20
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x000002F0 | trm_hw_st=
atus0
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x00000000 | trm_hw_st=
atus1
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x004DB676 | branchlin=
k2
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x004DAFCA | interrupt=
link1
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x004DAFCA | interrupt=
link2
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x00016B8A | data1
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x00000010 | data2
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x00000000 | data3
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x003CF2BA | beacon ti=
me
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x01AF1EAD | tsf low
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x00000000 | tsf hi
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x00000000 | time gp1
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x01B06739 | time gp2
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x00000001 | uCode rev=
ision type
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x00000049 | uCode ver=
sion major
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x35C0A2C6 | uCode ver=
sion minor
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x00000420 | hw version
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x00C80002 | board ver=
sion
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x80BBFF00 | hcmd
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x00020000 | isr0
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x00000000 | isr1
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x48F04002 | isr2
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x00C3000C | isr3
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x00000000 | isr4
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x00220103 | last cmd =
Id
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x00016B8A | wait_event
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x00000000 | l2p_contr=
ol
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x00000000 | l2p_durat=
ion
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x00000000 | l2p_mhval=
id
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x00000000 | l2p_addr_=
match
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x00000018 | lmpm_pmg_=
sel
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x00000000 | timestamp
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x0000284C | flow_hand=
ler
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: Start IWL Error Log Du=
mp:
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: Transport status: 0x00=
00004B, valid: 7
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x20103600 | ADVANCED_=
SYSASSERT
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x00000000 | umac bran=
chlink1
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x8045F174 | umac bran=
chlink2
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x8047A13C | umac inte=
rruptlink1
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x00000000 | umac inte=
rruptlink2
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x000000FF | umac data1
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0xDEADBEEF | umac data2
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0xDEADBEEF | umac data3
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x00000049 | umac major
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x35C0A2C6 | umac minor
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x01B06733 | frame poi=
nter
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0xC0886C0C | stack poi=
nter
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x002B010D | last host=
 cmd
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x00000000 | isr statu=
s reg
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: IML/ROM dump:
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x00000B03 | IML/ROM e=
rror/state
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x00008510 | IML/ROM d=
ata1
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x00000080 | IML/ROM W=
FPM_AUTH_KEY_0
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: Fseq Registers:
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x60000100 | FSEQ_ERRO=
R_CODE
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x00440007 | FSEQ_TOP_=
INIT_VERSION
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x00080009 | FSEQ_CNVI=
O_INIT_VERSION
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x0000A652 | FSEQ_OTP_=
VERSION
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x00000002 | FSEQ_TOP_=
CONTENT_VERSION
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x4552414E | FSEQ_ALIV=
E_TOKEN
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x00400410 | FSEQ_CNVI=
_ID
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x00400410 | FSEQ_CNVR=
_ID
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x00400410 | CNVI_AUX_=
MISC_CHIP
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x00400410 | CNVR_AUX_=
MISC_CHIP
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x00009061 | CNVR_SCU_=
SD_REGS_SD_REG_DIG_DCDC_VTRIM
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x00000061 | CNVR_SCU_=
SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x00080009 | FSEQ_PREV=
_CNVIO_INIT_VERSION
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x00440005 | FSEQ_WIFI=
_FSEQ_VERSION
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x00440007 | FSEQ_BT_F=
SEQ_VERSION
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x000000DC | FSEQ_CLAS=
S_TP_VERSION
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: WRT: Collecting data: =
ini trigger 4 fired (delay=3D0ms).
sep 21 09:33:14 angela kernel: ieee80211 phy0: Hardware restart was request=
ed
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: FW error in SYNC CMD S=
CAN_REQ_UMAC
sep 21 09:33:14 angela kernel: CPU: 7 PID: 1563 Comm: wpa_supplicant Tainte=
d: G        W          6.5.0-1-amd64 #1  Debian 6.5.3-1
sep 21 09:33:14 angela kernel: Hardware name: Framework Laptop (12th Gen In=
tel Core)/FRANMACP04, BIOS 03.06 11/10/2022
sep 21 09:33:14 angela kernel: Call Trace:
sep 21 09:33:14 angela kernel:  <TASK>
sep 21 09:33:14 angela kernel:  dump_stack_lvl+0x47/0x60
sep 21 09:33:14 angela kernel:  iwl_trans_txq_send_hcmd+0x33d/0x450 [iwlwif=
i]
sep 21 09:33:14 angela kernel:  ? __pfx_autoremove_wake_function+0x10/0x10
sep 21 09:33:14 angela kernel:  iwl_trans_send_cmd+0x66/0x100 [iwlwifi]
sep 21 09:33:14 angela kernel:  iwl_mvm_send_cmd+0x16/0x40 [iwlmvm]
sep 21 09:33:14 angela kernel:  iwl_mvm_reg_scan_start+0x3f0/0x610 [iwlmvm]
sep 21 09:33:14 angela kernel:  iwl_mvm_mac_hw_scan+0x4e/0x70 [iwlmvm]
sep 21 09:33:14 angela kernel:  drv_hw_scan+0x98/0x150 [mac80211]
sep 21 09:33:14 angela kernel:  __ieee80211_start_scan+0x255/0x6f0 [mac8021=
1]
sep 21 09:33:14 angela kernel:  ieee80211_request_scan+0x2f/0x50 [mac80211]
sep 21 09:33:14 angela kernel:  rdev_scan+0x25/0xd0 [cfg80211]
sep 21 09:33:14 angela kernel:  nl80211_trigger_scan+0x409/0x7e0 [cfg80211]
sep 21 09:33:14 angela kernel:  genl_family_rcv_msg_doit.isra.0+0xe3/0x140
sep 21 09:33:14 angela kernel:  genl_rcv_msg+0x1b1/0x2c0
sep 21 09:33:14 angela kernel:  ? __pfx_nl80211_pre_doit+0x10/0x10 [cfg8021=
1]
sep 21 09:33:14 angela kernel:  ? __pfx_nl80211_trigger_scan+0x10/0x10 [cfg=
80211]
sep 21 09:33:14 angela kernel:  ? __pfx_nl80211_post_doit+0x10/0x10 [cfg802=
11]
sep 21 09:33:14 angela kernel:  ? __pfx_genl_rcv_msg+0x10/0x10
sep 21 09:33:14 angela kernel:  netlink_rcv_skb+0x58/0x110
sep 21 09:33:14 angela kernel:  genl_rcv+0x28/0x40
sep 21 09:33:14 angela kernel:  netlink_unicast+0x19e/0x290
sep 21 09:33:14 angela kernel:  netlink_sendmsg+0x254/0x4d0
sep 21 09:33:14 angela kernel:  sock_sendmsg+0x93/0xa0
sep 21 09:33:14 angela kernel:  ____sys_sendmsg+0x278/0x300
sep 21 09:33:14 angela kernel:  ? copy_msghdr_from_user+0x7d/0xc0
sep 21 09:33:14 angela kernel:  ___sys_sendmsg+0x9a/0xe0
sep 21 09:33:14 angela kernel:  __sys_sendmsg+0x7a/0xd0
sep 21 09:33:14 angela kernel:  do_syscall_64+0x5d/0xc0
sep 21 09:33:14 angela kernel:  ? do_syscall_64+0x6c/0xc0
sep 21 09:33:14 angela kernel:  ? do_syscall_64+0x6c/0xc0
sep 21 09:33:14 angela kernel:  ? fpregs_assert_state_consistent+0x26/0x50
sep 21 09:33:14 angela kernel:  ? exit_to_user_mode_prepare+0x40/0x1d0
sep 21 09:33:14 angela kernel:  ? syscall_exit_to_user_mode+0x2b/0x40
sep 21 09:33:14 angela kernel:  ? do_syscall_64+0x6c/0xc0
sep 21 09:33:14 angela kernel:  ? do_syscall_64+0x6c/0xc0
sep 21 09:33:14 angela kernel:  ? do_syscall_64+0x6c/0xc0
sep 21 09:33:14 angela kernel:  ? do_syscall_64+0x6c/0xc0
sep 21 09:33:14 angela kernel:  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
sep 21 09:33:14 angela kernel: RIP: 0033:0x7fdbfbf29910
sep 21 09:33:14 angela kernel: Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff=
 eb b7 66 2e 0f 1f 84 00 00 00 00 00 90 80 3d d1 fc 0c 00 00 74 17 b8 2e 00=
 00 00>
sep 21 09:33:14 angela kernel: RSP: 002b:00007ffedc261e78 EFLAGS: 00000202 =
ORIG_RAX: 000000000000002e
sep 21 09:33:14 angela kernel: RAX: ffffffffffffffda RBX: 00005568b18cf900 =
RCX: 00007fdbfbf29910
sep 21 09:33:14 angela kernel: RDX: 0000000000000000 RSI: 00007ffedc261eb0 =
RDI: 0000000000000006
sep 21 09:33:14 angela kernel: RBP: 00005568b1949360 R08: 0000000000000004 =
R09: 0000000000000000
sep 21 09:33:14 angela kernel: R10: 00007ffedc261f94 R11: 0000000000000202 =
R12: 00005568b18cfbe0
sep 21 09:33:14 angela kernel: R13: 00007ffedc261eb0 R14: 0000000000000000 =
R15: 00007ffedc261f94
sep 21 09:33:14 angela kernel:  </TASK>
sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: Scan failed! ret -5
sep 21 09:33:14 angela kernel: ------------[ cut here ]------------
sep 21 09:33:14 angela kernel: WARNING: CPU: 15 PID: 133361 at net/mac80211=
/scan.c:423 __ieee80211_scan_completed+0x308/0x320 [mac80211]
sep 21 09:33:14 angela kernel: Modules linked in: cdc_mbim cdc_wdm xfrm_use=
r xfrm_algo nvme_fabrics ctr ccm rfcomm cmac algif_hash algif_skcipher af_a=
lg tls>
sep 21 09:33:14 angela kernel:  nf_reject_ipv4 intel_uncore_frequency_commo=
n snd_hda_codec_idt snd_soc_acpi nf_reject_ipv6 x86_pkg_temp_thermal snd_hd=
a_code>
sep 21 09:33:14 angela kernel:  configfs ip_tables x_tables autofs4 ext4 cr=
c16 mbcache jbd2 btrfs blake2b_generic dm_crypt dm_mod efivarfs raid10 raid=
456 as>
sep 21 09:33:14 angela kernel: CPU: 15 PID: 133361 Comm: kworker/u32:22 Tai=
nted: G        W          6.5.0-1-amd64 #1  Debian 6.5.3-1
sep 21 09:33:14 angela kernel: Hardware name: Framework Laptop (12th Gen In=
tel Core)/FRANMACP04, BIOS 03.06 11/10/2022
sep 21 09:33:14 angela kernel: Workqueue: phy0 ieee80211_scan_work [mac8021=
1]
sep 21 09:33:14 angela kernel: RIP: 0010:__ieee80211_scan_completed+0x308/0=
x320 [mac80211]
sep 21 09:33:14 angela kernel: Code: 0a 00 48 85 c0 74 0c 48 8b 78 08 48 89=
 ee e8 6f 49 04 00 65 ff 0d 10 49 2a 3e 0f 85 b1 fe ff ff 0f 1f 44 00 00 e9=
 a7 fe>
sep 21 09:33:14 angela kernel: RSP: 0018:ffffb42640ab7dc8 EFLAGS: 00010246
sep 21 09:33:14 angela kernel: RAX: 0000000000000000 RBX: 0000000000000000 =
RCX: 0000000000000000
sep 21 09:33:14 angela kernel: RDX: 0000000000000000 RSI: 0000000000000001 =
RDI: ffff9399481e8900
sep 21 09:33:14 angela kernel: RBP: ffff9399481e8900 R08: 0000000000000000 =
R09: 0000000000000000
sep 21 09:33:14 angela kernel: R10: 0000000000000001 R11: 0000000000000000 =
R12: ffff9399481e9b00
sep 21 09:33:14 angela kernel: R13: 0000000000000000 R14: ffff9399634ff335 =
R15: 0000000000000001
sep 21 09:33:14 angela kernel: FS:  0000000000000000(0000) GS:ffff93a0ef9c0=
000(0000) knlGS:0000000000000000
sep 21 09:33:14 angela kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800=
50033
sep 21 09:33:14 angela kernel: CR2: 00005614e1215588 CR3: 00000008a8020000 =
CR4: 0000000000f50ee0
sep 21 09:33:14 angela kernel: PKRU: 55555554
sep 21 09:33:14 angela kernel: Call Trace:
sep 21 09:33:14 angela kernel:  <TASK>
sep 21 09:33:14 angela kernel:  ? __ieee80211_scan_completed+0x308/0x320 [m=
ac80211]
sep 21 09:33:14 angela kernel:  ? __warn+0x81/0x130
sep 21 09:33:14 angela kernel:  ? __ieee80211_scan_completed+0x308/0x320 [m=
ac80211]
sep 21 09:33:14 angela kernel:  ? report_bug+0x191/0x1c0
sep 21 09:33:14 angela kernel:  ? handle_bug+0x3c/0x80
sep 21 09:33:14 angela kernel:  ? exc_invalid_op+0x17/0x70
sep 21 09:33:14 angela kernel:  ? asm_exc_invalid_op+0x1a/0x20
sep 21 09:33:14 angela kernel:  ? __ieee80211_scan_completed+0x308/0x320 [m=
ac80211]
sep 21 09:33:14 angela kernel:  ieee80211_scan_work+0x127/0x5d0 [mac80211]
sep 21 09:33:14 angela kernel:  ? __schedule+0x3e7/0xb80
sep 21 09:33:14 angela kernel:  process_one_work+0x1de/0x3f0
sep 21 09:33:14 angela kernel:  worker_thread+0x51/0x390
sep 21 09:33:14 angela kernel:  ? __pfx_worker_thread+0x10/0x10
sep 21 09:33:14 angela kernel:  kthread+0xf4/0x130
sep 21 09:33:14 angela kernel:  ? __pfx_kthread+0x10/0x10
sep 21 09:33:14 angela kernel:  ret_from_fork+0x31/0x50
sep 21 09:33:14 angela kernel:  ? __pfx_kthread+0x10/0x10
sep 21 09:33:14 angela kernel:  ret_from_fork_asm+0x1b/0x30
sep 21 09:33:14 angela kernel:  </TASK>
sep 21 09:33:14 angela kernel: ---[ end trace 0000000000000000 ]---
sep 21 09:33:14 angela wpa_supplicant[1563]: wlan0: CTRL-EVENT-SCAN-FAILED =
ret=3D-5
sep 21 09:33:15 angela kernel: iwlwifi 0000:a6:00.0: WFPM_UMAC_PD_NOTIFICAT=
ION: 0x1f
sep 21 09:33:15 angela kernel: iwlwifi 0000:a6:00.0: WFPM_LMAC2_PD_NOTIFICA=
TION: 0x1f
sep 21 09:33:15 angela kernel: iwlwifi 0000:a6:00.0: WFPM_AUTH_KEY_0: 0x80
sep 21 09:33:15 angela kernel: iwlwifi 0000:a6:00.0: CNVI_SCU_SEQ_DATA_DW9:=
 0x0
sep 21 09:33:15 angela wpa_supplicant[1563]: wlan0: CTRL-EVENT-REGDOM-CHANG=
E init=3DDRIVER type=3DWORLD


Thanks for any ideas!

--=20
La d=C3=A9mocratie r=C3=A9elle se d=C3=A9finit d'abord et avant tout par la
participation massive des citoyens =C3=A0 la gestion des affaires de la cit=
=C3=A9.
Elle est directe et participative. Elle trouve son expression la plus
authentique dans l'assembl=C3=A9e populaire et le dialogue permanent sur
l'organisation de la vie en commun.  - De la servitude moderne
