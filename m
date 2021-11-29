Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256D1461555
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Nov 2021 13:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245412AbhK2MpO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Nov 2021 07:45:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31971 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239990AbhK2MnO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Nov 2021 07:43:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638189596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jyALCcPT1VgS5kIAZ50eZvk726msN9pFaKZtuEHZV6Q=;
        b=dRsZW1Hlb1GtVhNRAM+eZOYo1Q5ollhDtlOprsudnkbC/Tq9zOxcoa83G4+lCxSeG0cPjZ
        r8s/vYejNpe8c9WPk8W7aVr+O5f3Htp93xXnNRk7Jl0LKpVqLQLCTPcmLlAZJyI1KAh2tI
        /sLpAvnfkVQ/BwlDTVlqq/No25rZAfM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-390-xKR3GYQBMn-aUrMLKcSOtw-1; Mon, 29 Nov 2021 07:39:55 -0500
X-MC-Unique: xKR3GYQBMn-aUrMLKcSOtw-1
Received: by mail-ed1-f69.google.com with SMTP id i19-20020a05640242d300b003e7d13ebeedso13580787edc.7
        for <linux-wireless@vger.kernel.org>; Mon, 29 Nov 2021 04:39:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:in-reply-to
         :content-transfer-encoding;
        bh=jyALCcPT1VgS5kIAZ50eZvk726msN9pFaKZtuEHZV6Q=;
        b=231lZhWthTrwDaW9DpkGBstzuPJUkr5ll2xfgTjxjXQHv5HWwS11o+xZJGUOCY46Fx
         z7yr8HviCPh32YzZwR3jRdpOiSDKvT64+HkZsvH1bpvC11cXyNE/a4KhUekfIc7ciL/9
         BdxCaepTc60Czqkes2OppDGpSwZC/5Xw1YXhFz7hXUD5CED+oBlGGxXa2C2Qyi3rj9SJ
         cqa3bKk4FKVoPzuBL2sbnkZ7hpOgRWsPh4bw6VYEq7Tp0cRIDumMt8S3RHX/0Eu8EAHj
         mlYqoSu0Nobp8YeSXAnZrxmC3UtWDViqLhZiyVoN9XKJ5W6zz+dbmKcfK7dSK9yYSMWL
         1Hsg==
X-Gm-Message-State: AOAM531O2cemmT2r8V/LnJv6R1DNsFsklvbGR4UNFgAzTH/HV7Cxw4bV
        hMhudm9e8NkGUBwYTFL5RTIjzp2T9FAPHt94lLQ/B0MhgQadrYe9uRmG5V7l9x2WwAOwUSM59Ve
        pAoO4F8Qj0/m72FwGjL3ZwNXQkxM=
X-Received: by 2002:a05:6402:544:: with SMTP id i4mr74234288edx.9.1638189593608;
        Mon, 29 Nov 2021 04:39:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwPqxR1UNlum9Hfopby5H8GeCEmN7M/yaBSKOydO2KSWiWrREaSkScAZXPozzacgKYWsHPnuQ==
X-Received: by 2002:a05:6402:544:: with SMTP id i4mr74234260edx.9.1638189593398;
        Mon, 29 Nov 2021 04:39:53 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id y17sm9981304edd.31.2021.11.29.04.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 04:39:53 -0800 (PST)
Message-ID: <39c64d10-7fda-67c1-25a3-1b0fcdd86b6b@redhat.com>
Date:   Mon, 29 Nov 2021 13:39:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: iwlwifi suspicous RCU usage warnings with kernel 5.15 and
 5.16-rc3
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
To:     Luca Coelho <luciano.coelho@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <348f1b9c-f1b4-8a01-873f-9749f1070808@redhat.com>
In-Reply-To: <348f1b9c-f1b4-8a01-873f-9749f1070808@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On 11/29/21 13:37, Hans de Goede wrote:
> Hi All,
>=20
> Since kernel 5.15 (IIRC) I've been getting a suspicous RCU usage warnin=
g
> from the iwlwifi driver when running a kernel with checks for this enab=
led.
>=20
> Note this is the 2nd or 3th time this happens now, can we please get
> some CI checks for these (assuming there is some iwlwifi CI already) ?
>=20
> Here is the warning which I'm getting:

Note, also see: https://bugzilla.redhat.com/show_bug.cgi?id=3D2009750

Regards,

Hans

>=20
> [   71.769680] iwlwifi 0000:00:14.3: base HW address: 34:13:e8:dd:0f:63=

>=20
> [   71.769708] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   71.769710] WARNING: suspicious RCU usage
> [   71.769711] 5.16.0-rc2+ #632 Tainted: G            E   =20
> [   71.769713] -----------------------------
> [   71.769715] drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c:264 su=
spicious rcu_dereference_protected() usage!
> [   71.769717]=20
>                other info that might help us debug this:
>=20
> [   71.769719]=20
>                rcu_scheduler_active =3D 2, debug_locks =3D 1
> [   71.769721] 3 locks held by modprobe/1712:
> [   71.769723]  #0: ffffffffc0d6e0e8 (iwlwifi_opmode_table_mtx){+.+.}-{=
3:3}, at: iwl_opmode_register+0x2c/0xe0 [iwlwifi]
> [   71.769744]  #1: ffffffffa9bc2248 (rtnl_mutex){+.+.}-{3:3}, at: iwl_=
op_mode_mvm_start+0x9e7/0xc90 [iwlmvm]
> [   71.769771]  #2: ffff8a9d0884b3a0 (&mvm->mutex){+.+.}-{3:3}, at: iwl=
_op_mode_mvm_start+0x9f3/0xc90 [iwlmvm]
> [   71.769789]=20
>                stack backtrace:
> [   71.769791] CPU: 3 PID: 1712 Comm: modprobe Tainted: G            E =
    5.16.0-rc2+ #632
> [   71.769794] Hardware name: LENOVO 20U90SIT19/20U90SIT19, BIOS N2WET3=
0W (1.20 ) 08/26/2021
> [   71.769795] Call Trace:
> [   71.769797]  <TASK>
> [   71.769799]  dump_stack_lvl+0x59/0x73
> [   71.769805]  iwl_mvm_init_fw_regd+0x110/0x170 [iwlmvm]
> [   71.769822]  iwl_mvm_init_mcc+0x42/0x1b0 [iwlmvm]
> [   71.769837]  iwl_op_mode_mvm_start+0xc32/0xc90 [iwlmvm]
> [   71.769859]  _iwl_op_mode_start.isra.0+0x3f/0x80 [iwlwifi]
> [   71.769871]  iwl_opmode_register+0x6f/0xe0 [iwlwifi]
> [   71.769881]  ? 0xffffffffc0ef1000
> [   71.769885]  iwl_mvm_init+0x36/0x1000 [iwlmvm]
> [   71.769900]  do_one_initcall+0x58/0x300
> [   71.769904]  ? rcu_read_lock_sched_held+0x3f/0x70
> [   71.769908]  ? trace_kmalloc+0x2c/0xd0
> [   71.769912]  ? kmem_cache_alloc_trace+0x1e8/0x3a0
> [   71.769919]  do_init_module+0x5c/0x260
> [   71.769925]  __do_sys_init_module+0x130/0x190
> [   71.769942]  do_syscall_64+0x38/0x90
> [   71.769947]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [   71.769950] RIP: 0033:0x7fa9255f599e
> [   71.769954] Code: 48 8b 0d 8d 74 0e 00 f7 d8 64 89 01 48 83 c8 ff c3=
 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f =
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 5a 74 0e 00 f7 d8 64 89 01 48
> [   71.769956] RSP: 002b:00007ffd859069e8 EFLAGS: 00000246 ORIG_RAX: 00=
000000000000af
> [   71.769960] RAX: ffffffffffffffda RBX: 000055796d7dbe40 RCX: 00007fa=
9255f599e
> [   71.769962] RDX: 000055796d167a2a RSI: 00000000000fcf09 RDI: 0000557=
96e264bf0
> [   71.769963] RBP: 000055796e264bf0 R08: 000055796d7dbd90 R09: 0000000=
0000fc010
> [   71.769965] R10: 0000000000000005 R11: 0000000000000246 R12: 0000557=
96d167a2a
> [   71.769967] R13: 000055796d7dbf70 R14: 000055796d7dbe40 R15: 0000557=
96d7df170
> [   71.769982]  </TASK>
> [   71.773112] ------------[ cut here ]------------
> [   71.773115] WARNING: CPU: 5 PID: 1712 at net/wireless/reg.c:3107 reg=
_process_self_managed_hint+0x198/0x1e0 [cfg80211]
> [   71.773157] Modules linked in: intel_uncore(+) snd_compress ac97_bus=
 snd_pcm_dmaengine snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi cdc_=
ether usbnet snd_hda_codec iwlmvm(+) snd_usb_audio(+) pcspkr r8152 snd_hd=
a_core snd_usbmidi_lib snd_rawmidi snd_hwdep mii mac80211 snd_seq uvcvide=
o snd_seq_device think_lmi(E+) videobuf2_vmalloc videobuf2_memops videobu=
f2_v4l2 firmware_attributes_class(E) wmi_bmof(E) i2c_i801(E) snd_pcm e100=
0e(+) intel_wmi_thunderbolt(E) libarc4 btusb videobuf2_common btrtl i2c_s=
mbus snd_timer btbcm videodev btintel bluetooth mc iwlwifi mei_me ecdh_ge=
neric thunderbolt(+) processor_thermal_device_pci_legacy mei processor_th=
ermal_device cfg80211 joydev processor_thermal_rfim processor_thermal_mbo=
x processor_thermal_rapl nxp_nci_i2c idma64 intel_rapl_common nxp_nci int=
el_pch_thermal nci intel_soc_dts_iosf nfc thinkpad_acpi(E) ledtrig_audio =
platform_profile rfkill snd soundcore int3403_thermal int340x_thermal_zon=
e soc_button_array acpi_pad int3400_thermal
> [   71.773280]  acpi_thermal_rel intel_hid(E) sparse_keymap binfmt_misc=
 zram ip_tables dm_crypt trusted asn1_encoder hid_logitech_hidpp hid_logi=
tech_dj hid_lg_g15 uas usb_storage crct10dif_pclmul crc32_pclmul crc32c_i=
ntel i915 ghash_clmulni_intel serio_raw i2c_algo_bit ttm nvme drm_kms_hel=
per nvme_core cec hid_multitouch ucsi_acpi drm typec_ucsi typec wmi i2c_h=
id_acpi i2c_hid video pinctrl_cannonlake i2c_dev ipmi_devintf ipmi_msghan=
dler fuse
> [   71.773346] CPU: 5 PID: 1712 Comm: modprobe Tainted: G            E =
    5.16.0-rc2+ #632
> [   71.773349] Hardware name: LENOVO 20U90SIT19/20U90SIT19, BIOS N2WET3=
0W (1.20 ) 08/26/2021
> [   71.773351] RIP: 0010:reg_process_self_managed_hint+0x198/0x1e0 [cfg=
80211]
> [   71.773384] Code: 0e f1 02 00 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f=
 5d c3 49 8d 7c 24 68 be ff ff ff ff e8 f0 3f 22 e8 85 c0 0f 85 b8 fe ff =
ff <0f> 0b e9 b1 fe ff ff 0f 0b 80 3d 9f 7d 0b 00 00 0f 85 94 fe ff ff
> [   71.773387] RSP: 0018:ffff9c284154bc50 EFLAGS: 00010246
> [   71.773392] RAX: 0000000000000000 RBX: ffff8a9d0884b308 RCX: 0000000=
000000001
> [   71.773394] RDX: 0000000000000000 RSI: ffff8a9d08848628 RDI: ffff8a9=
d07cd8ea0
> [   71.773398] RBP: ffff9c284154bcc8 R08: 0000000000000000 R09: 0000000=
000000001
> [   71.773400] R10: ffffffffaac17c80 R11: 000000000000e000 R12: ffff8a9=
d088485c0
> [   71.773402] R13: ffff8a9d0884b308 R14: ffff9c284154bd30 R15: ffff8a9=
d0884b300
> [   71.773405] FS:  00007fa9254de740(0000) GS:ffff8aa05a540000(0000) kn=
lGS:0000000000000000
> [   71.773408] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   71.773411] CR2: 000055fd1b31c350 CR3: 00000001078d2002 CR4: 0000000=
0003706e0
> [   71.773413] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
> [   71.773416] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000=
000000400
> [   71.773418] Call Trace:
> [   71.773420]  <TASK>
> [   71.773422]  ? rcu_read_lock_sched_held+0x3f/0x70
> [   71.773440]  regulatory_set_wiphy_regd_sync+0x31/0x90 [cfg80211]
> [   71.773485]  iwl_mvm_init_mcc+0xa9/0x1b0 [iwlmvm]
> [   71.773510]  iwl_op_mode_mvm_start+0xc32/0xc90 [iwlmvm]
> [   71.773538]  _iwl_op_mode_start.isra.0+0x3f/0x80 [iwlwifi]
> [   71.773554]  iwl_opmode_register+0x6f/0xe0 [iwlwifi]
> [   71.773566]  ? 0xffffffffc0ef1000
> [   71.773571]  iwl_mvm_init+0x36/0x1000 [iwlmvm]
> [   71.773589]  do_one_initcall+0x58/0x300
> [   71.773595]  ? rcu_read_lock_sched_held+0x3f/0x70
> [   71.773599]  ? trace_kmalloc+0x2c/0xd0
> [   71.773603]  ? kmem_cache_alloc_trace+0x1e8/0x3a0
> [   71.773613]  do_init_module+0x5c/0x260
> [   71.773620]  __do_sys_init_module+0x130/0x190
> [   71.773641]  do_syscall_64+0x38/0x90
> [   71.773646]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [   71.773651] RIP: 0033:0x7fa9255f599e
> [   71.773654] Code: 48 8b 0d 8d 74 0e 00 f7 d8 64 89 01 48 83 c8 ff c3=
 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f =
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 5a 74 0e 00 f7 d8 64 89 01 48
> [   71.773657] RSP: 002b:00007ffd859069e8 EFLAGS: 00000246 ORIG_RAX: 00=
000000000000af
> [   71.773674] RAX: ffffffffffffffda RBX: 000055796d7dbe40 RCX: 00007fa=
9255f599e
> [   71.773677] RDX: 000055796d167a2a RSI: 00000000000fcf09 RDI: 0000557=
96e264bf0
> [   71.773679] RBP: 000055796e264bf0 R08: 000055796d7dbd90 R09: 0000000=
0000fc010
> [   71.773681] R10: 0000000000000005 R11: 0000000000000246 R12: 0000557=
96d167a2a
> [   71.773683] R13: 000055796d7dbf70 R14: 000055796d7dbe40 R15: 0000557=
96d7df170
> [   71.773699]  </TASK>
> [   71.773700] irq event stamp: 166083
> [   71.773702] hardirqs last  enabled at (166089): [<ffffffffa816e5d0>]=
 __up_console_sem+0x60/0x70
> [   71.773705] hardirqs last disabled at (166094): [<ffffffffa816e5b5>]=
 __up_console_sem+0x45/0x70
> [   71.773708] softirqs last  enabled at (165934): [<ffffffffa80ec5f0>]=
 __irq_exit_rcu+0xd0/0x100
> [   71.773711] softirqs last disabled at (165929): [<ffffffffa80ec5f0>]=
 __irq_exit_rcu+0xd0/0x100
> [   71.773714] ---[ end trace ba8c4bf440db1ae1 ]---
>=20
> Regards,
>=20
> Hans
>=20

