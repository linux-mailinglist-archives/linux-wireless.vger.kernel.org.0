Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6B46C9F1D
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Mar 2023 11:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbjC0JN2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Mar 2023 05:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbjC0JN0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Mar 2023 05:13:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576F34EFB
        for <linux-wireless@vger.kernel.org>; Mon, 27 Mar 2023 02:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679908348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=23G6mYw9qdkQ2fxYQ9oJJmeTuWyp8r7ND7kHZMak36o=;
        b=MinhjlZuOuocEZlUEC/eSIX182HhaGV668vR9+CxBkuV/n/jcB8w162PK/zKLDSb4kv4gf
        LvWpYb1Leo7CASDGrBVszO52VwwtGyZ2XULKORjuDqCDGW91wwojs87b5W4Q/O2b9ZcIuI
        uSir7n7lvuekKK2Aex4hq7JIG0GG9eo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-D5zuyt6uOi6J67-vb8dWig-1; Mon, 27 Mar 2023 05:12:27 -0400
X-MC-Unique: D5zuyt6uOi6J67-vb8dWig-1
Received: by mail-ed1-f70.google.com with SMTP id f15-20020a50a6cf000000b0050050d2326aso11510833edc.18
        for <linux-wireless@vger.kernel.org>; Mon, 27 Mar 2023 02:12:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679908345;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=23G6mYw9qdkQ2fxYQ9oJJmeTuWyp8r7ND7kHZMak36o=;
        b=a+Sd7ugs6IbnJgbclI4Ju05QC+UE8v30oBjeu/O80NX/GHKGQfIZNnJFtNbx7Os68n
         09qXDt3Ao+jwn6/m/shL7V/99JNxyNDdT4woUGlH9xNYDneZ7ntOYEp7Mtv+ZrbqYAio
         2+31jeAMUv6mMv4/CwD3Rvco8bQmkaNcTIM/8ZE1GOQ7lHa1+Ab0Yr8JKGADmG7tPC9b
         rYvE67dzUL6RHIxp//MW6L+nWIxuB4XItQMWu2llfYq5u1i/9tF5jU9Omwfc9DUfZtNj
         vV1lG67FEZ3bjtx0NFrbeDHlF+Jvr5q8NOm+suq2CBHmHbbqAweIHRgFZvGLlS4pMCCp
         /8iw==
X-Gm-Message-State: AAQBX9cNL4vSdb+DQWvXECMnWKB4y/6iPUzRJyUSaowypuW5PJFwzl3V
        JmDpGwSMj96TIefxMj2UJ/y6gixJktWo7EvmYegnTr3adKVEeaYjeQuA0tfs8nenK0XPg18oMfZ
        rCoUiz74Oe/EYApAEVS+zWPwUKdg=
X-Received: by 2002:aa7:d584:0:b0:4fa:ba60:8188 with SMTP id r4-20020aa7d584000000b004faba608188mr11131359edq.8.1679908344959;
        Mon, 27 Mar 2023 02:12:24 -0700 (PDT)
X-Google-Smtp-Source: AKy350ag74sTONRcOR0jhkVT/dKsQW7TXIQjvInJjoZaszXFzosrOazxnp99JtKpTlZvSTSU6fbOHw==
X-Received: by 2002:aa7:d584:0:b0:4fa:ba60:8188 with SMTP id r4-20020aa7d584000000b004faba608188mr11131349edq.8.1679908344700;
        Mon, 27 Mar 2023 02:12:24 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id s19-20020a170906285300b009316e0b610csm13889296ejc.34.2023.03.27.02.12.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 02:12:24 -0700 (PDT)
Message-ID: <68760035-7f75-1b23-e355-bfb758a87d83@redhat.com>
Date:   Mon, 27 Mar 2023 11:12:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     Gregory Greenman <gregory.greenman@intel.com>,
        Benjamin Berg <benjamin.berg@intel.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Subject: iwlwifi "memcpy: detected field-spanning write" kernel oops
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi All,

I have noticed the following iwlwifi oops with kernel 6.2.0 and newer (1)=
:

[   13.178780] ------------[ cut here ]------------
[   13.178785] memcpy: detected field-spanning write (size 32) of single =
field "sta_cmd.key.key" at drivers/net/wireless/intel/iwlwifi/dvm/sta.c:1=
103 (size 16)
[   13.178823] WARNING: CPU: 0 PID: 945 at drivers/net/wireless/intel/iwl=
wifi/dvm/sta.c:1103 iwlagn_send_sta_key+0x375/0x390 [iwldvm]
[   13.178850] Modules linked in: snd_seq_dummy snd_hrtimer qrtr bnep int=
el_rapl_msr at24 iTCO_wdt mei_wdt intel_rapl_common x86_pkg_temp_thermal =
dell_laptop intel_powerclamp coretemp intel_pmc_bxt mei_pxp btusb kvm_int=
el mei_hdcp ppdev iwldvm iTCO_vendor_support btrtl mac80211 dell_smm_hwmo=
n btbcm kvm snd_hda_codec_idt libarc4 snd_hda_codec_generic snd_hda_codec=
_hdmi btintel btmtk snd_hda_intel snd_intel_dspcfg bluetooth snd_intel_sd=
w_acpi uvcvideo irqbypass videobuf2_vmalloc rapl snd_hda_codec uvc intel_=
cstate iwlwifi snd_hda_core intel_uncore snd_hwdep ecdh_generic videobuf2=
_memops videobuf2_v4l2 dell_wmi dell_smbios videodev dcdbas snd_seq optio=
n ledtrig_audio usb_wwan sparse_keymap snd_seq_device dell_wmi_descriptor=
 wmi_bmof videobuf2_common i2c_i801 snd_pcm cfg80211 joydev mc pcspkr i2c=
_smbus lpc_ich snd_timer snd mei_me e1000e mei soundcore parport_pc parpo=
rt dell_rbtn rfkill dell_smo8800 vfat fat nouveau(E) crct10dif_pclmul crc=
32_pclmul crc32c_intel ghash_clmulni_intel sha512_ssse3 sdhci_pci cqhci s=
erio_raw sdhci
[   13.178941]  drm_ttm_helper mmc_core ttm i2c_algo_bit usb_storage mxm_=
wmi drm_display_helper cec video wmi ip6_tables ip_tables i2c_dev fuse
[   13.178957] CPU: 0 PID: 945 Comm: wpa_supplicant Tainted: G           =
 E      6.3.0-rc3+ #169
[   13.178960] Hardware name: Dell Inc. Latitude E6430/0H3MT5, BIOS A21 0=
5/08/2017
[   13.178962] RIP: 0010:iwlagn_send_sta_key+0x375/0x390 [iwldvm]
[   13.178983] Code: 00 00 0f 85 ea fd ff ff b9 10 00 00 00 48 c7 c2 68 e=
a e8 c0 4c 89 ee 48 c7 c7 c0 e7 e8 c0 c6 05 27 cb 02 00 01 e8 ab 1b 29 d3=
 <0f> 0b e9 c1 fd ff ff e8 ff 89 07 d4 66 66 2e 0f 1f 84 00 00 00 00
[   13.178985] RSP: 0018:ffffa79440a3b6b0 EFLAGS: 00010286
[   13.178989] RAX: 0000000000000090 RBX: 000000000000010b RCX: 000000000=
0000000
[   13.178991] RDX: 0000000000000002 RSI: ffffffff957b6ba8 RDI: 00000000f=
fffffff
[   13.178993] RBP: ffff925f51eb2088 R08: 0000000000000000 R09: ffffa7944=
0a3b568
[   13.178995] R10: 0000000000000003 R11: ffffffff95b44168 R12: 000000000=
0000000
[   13.178996] R13: 0000000000000020 R14: ffff925e41aa1244 R15: ffff925e4=
1aa1230
[   13.178998] FS:  00007fcc0e82b7c0(0000) GS:ffff925f69c00000(0000) knlG=
S:0000000000000000
[   13.179001] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.179003] CR2: 0000560b6a52f898 CR3: 0000000116996006 CR4: 000000000=
01706f0
[   13.179006] Call Trace:
[   13.179009]  <TASK>
[   13.179014]  iwl_set_dynamic_key+0x1f0/0x220 [iwldvm]
[   13.179034]  iwlagn_mac_set_key+0x1e4/0x280 [iwldvm]
[   13.179053]  drv_set_key+0xa4/0x1b0 [mac80211]
[   13.179131]  ieee80211_key_enable_hw_accel+0xa8/0x2d0 [mac80211]
[   13.179212]  ieee80211_key_replace+0x22d/0x8e0 [mac80211]
[   13.179291]  ? synchronize_rcu+0xe0/0x100
[   13.179297]  ? __pfx_call_rcu_hurry+0x10/0x10
[   13.179303]  ieee80211_key_link+0x220/0x340 [mac80211]
[   13.179382]  ? __kmalloc+0x49/0x150
[   13.179386]  ? ieee80211_key_alloc+0x145/0x400 [mac80211]
[   13.179465]  ieee80211_add_key+0x185/0x310 [mac80211]
[   13.179540]  nl80211_new_key+0x1d8/0x350 [cfg80211]
[   13.179620]  genl_family_rcv_msg_doit.isra.0+0xbe/0x100
[   13.179630]  genl_rcv_msg+0x15a/0x280
[   13.179635]  ? __pfx_nl80211_pre_doit+0x10/0x10 [cfg80211]
[   13.179721]  ? __pfx_nl80211_new_key+0x10/0x10 [cfg80211]
[   13.179817]  ? __pfx_nl80211_post_doit+0x10/0x10 [cfg80211]
[   13.179894]  ? __pfx_genl_rcv_msg+0x10/0x10
[   13.179899]  netlink_rcv_skb+0x57/0x100
[   13.179906]  genl_rcv+0x24/0x40
[   13.179911]  netlink_unicast+0x171/0x260
[   13.179915]  netlink_sendmsg+0x242/0x4a0
[   13.179920]  sock_sendmsg+0x92/0xa0
[   13.179925]  ? __import_iovec+0x42/0x150
[   13.179930]  ____sys_sendmsg+0x244/0x2d0
[   13.179933]  ? import_iovec+0x17/0x20
[   13.179937]  ? copy_msghdr_from_user+0x5d/0x80
[   13.179942]  ___sys_sendmsg+0x86/0xd0
[   13.179947]  ? avc_has_perm+0x37/0xb0
[   13.179952]  ? refill_stock+0x31/0x50
[   13.179958]  ? sock_has_perm+0x82/0xa0
[   13.179962]  ? netlink_setsockopt+0x2fb/0x480
[   13.179966]  ? _copy_from_user+0x46/0x60
[   13.179971]  __sys_sendmsg+0x47/0x80
[   13.179976]  ? exit_to_user_mode_prepare+0x165/0x1f0
[   13.179981]  do_syscall_64+0x5b/0x80
[   13.179987]  ? do_syscall_64+0x67/0x80
[   13.179991]  ? syscall_exit_to_user_mode+0x17/0x40
[   13.179996]  ? do_syscall_64+0x67/0x80
[   13.180000]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   13.180004] RIP: 0033:0x7fcc0e1132b7
[   13.180009] Code: 0e 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1=
f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00 00 0f 05=
 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89 74 24 10
[   13.180011] RSP: 002b:00007ffdc37984b8 EFLAGS: 00000246 ORIG_RAX: 0000=
00000000002e
[   13.180015] RAX: ffffffffffffffda RBX: 0000559afa2cad70 RCX: 00007fcc0=
e1132b7
[   13.180017] RDX: 0000000000000000 RSI: 00007ffdc37984f0 RDI: 000000000=
0000006
[   13.180019] RBP: 0000559afa358000 R08: 0000000000000004 R09: 00007fcc0=
e1f9300
[   13.180021] R10: 00007ffdc37985d0 R11: 0000000000000246 R12: 0000559af=
a2cac80
[   13.180023] R13: 00007ffdc37984f0 R14: 0000000000000000 R15: 00007ffdc=
37985d0
[   13.180027]  </TASK>
[   13.180028] ---[ end trace 0000000000000000 ]---

Regards,

Hans






1) This might also happen with older kernels I did not check

