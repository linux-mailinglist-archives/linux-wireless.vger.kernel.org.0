Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE2B59AE72
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Aug 2022 15:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347274AbiHTNMq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 20 Aug 2022 09:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346748AbiHTNMo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 20 Aug 2022 09:12:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C045517E03
        for <linux-wireless@vger.kernel.org>; Sat, 20 Aug 2022 06:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661001157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=91nALG5AfLhriIdk7WJzwKwaahhW489PlGbx2JMSjNY=;
        b=EQSH2VnktQadi2koPF4nsizkK2rVCBC5G4f32BADczHP0lOIaLNfeT1KI4OEa3Iffs4PSA
        roHZ5rQIgOOK8BYO06JV1VRYwJ7nDEHXsFOD0nfFaQMbcPNOPBKaBJu8j0DJQ1Aaqu9dmw
        uF20Zq1pmM0sCNX20tUqxRht2DxZiqc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-173-vF2RfZe0OR2yYQbYaONQWg-1; Sat, 20 Aug 2022 09:12:35 -0400
X-MC-Unique: vF2RfZe0OR2yYQbYaONQWg-1
Received: by mail-ed1-f70.google.com with SMTP id y14-20020a056402440e00b0044301c7ccd9so4237906eda.19
        for <linux-wireless@vger.kernel.org>; Sat, 20 Aug 2022 06:12:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=91nALG5AfLhriIdk7WJzwKwaahhW489PlGbx2JMSjNY=;
        b=V+ysWdane2rzWa1UY9OwWfIFsQD5/+69+OWwBpFvXYhMzsxoXm3xSF3KNYcGQcBmVm
         WzWNu+GXfm1Wrz6c70KbwURWtOo+JcA4/HK5sl2yNmzG/RGfFw0ldkwjlcNN2G8XA/lP
         QHrctUYS98ZRHeSttU84X/emG0zhJDKcKxbAXe5U+F3n3c8mh2xJPOEuHuytgwBj4XPA
         MI+d8YNkAaZofdHSeXePyOfS8s3hlbHa734ydHGLeKiu0GuXf4b2W2iI4ZaZ+2Ps0YGk
         G16wosAMrWpeIeUpenpXjd4dcPrS0BNWBn9TSPcIx+5l7DuxVO4beQyBQFhoptAzWk+s
         SGIg==
X-Gm-Message-State: ACgBeo0SG0rwmQqlSLO6a906KvDxU0j2J61iiS7QpdQWF4kG7tMRtbpg
        9d9SS8BaMdgmnzasgzBUBhRqjWB12ZtVOXCYxt3/8Xlj+LvoiADB4WRySvJ6XOr9kg2kh6v3v+h
        ITC9yf3QTu/h2RUO97bf3mKcflNo=
X-Received: by 2002:a17:907:2d8a:b0:730:6880:c396 with SMTP id gt10-20020a1709072d8a00b007306880c396mr7638974ejc.192.1661001154364;
        Sat, 20 Aug 2022 06:12:34 -0700 (PDT)
X-Google-Smtp-Source: AA6agR76ml7N9Lsh1/L2YB4QmKVzYMD64l3OR59sClDnMmuUbJNOjRY5/7e7Rpt4qc7m3NjPGk4kZQ==
X-Received: by 2002:a17:907:2d8a:b0:730:6880:c396 with SMTP id gt10-20020a1709072d8a00b007306880c396mr7638963ejc.192.1661001154108;
        Sat, 20 Aug 2022 06:12:34 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id ss2-20020a170907c00200b0072f42ca292bsm3476200ejc.129.2022.08.20.06.12.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Aug 2022 06:12:33 -0700 (PDT)
Message-ID: <498d714c-76be-9d04-26db-a1206878de5e@redhat.com>
Date:   Sat, 20 Aug 2022 15:12:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
To:     Gregory Greenman <gregory.greenman@intel.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: New 6.1 net/mac80211/rx.c warning with iwlwifi / Ultimate-N 6300 wifi
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi All,

While testing 6.0-rc1 on a Dell Latitude E6430 with:

03:00.0 Network controller: Intel Corporation Centrino Ultimate-N 6300 (r=
ev 35)

wifi, I noticed the following WARN()/backtrace:

[  563.888583] ------------[ cut here ]------------
[  563.889447] WARNING: CPU: 0 PID: 0 at net/mac80211/rx.c:3993 ieee80211=
_rx_handlers+0x230/0x2a70 [mac80211]
[  563.890463] Modules linked in: snd_seq_dummy snd_hrtimer rfcomm btusb =
bnep intel_rapl_msr ppdev at24 mei_wdt mei_pxp mei_hdcp iTCO_wdt intel_pm=
c_bxt iTCO_vendor_support dell_laptop intel_rapl_common dell_smm_hwmon x8=
6_pkg_temp_thermal intel_powerclamp coretemp kvm_intel vfat fat kvm irqby=
pass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel rapl intel_cstate =
intel_uncore btrtl btbcm btintel btmtk uvcvideo bluetooth dell_wmi videob=
uf2_vmalloc videobuf2_memops dell_smbios videobuf2_v4l2 dcdbas option joy=
dev videobuf2_common usb_wwan iwldvm dell_wmi_descriptor sparse_keymap wm=
i_bmof ecdh_generic videodev mac80211 mc pcspkr libarc4 iwlwifi iwlmei cf=
g80211 snd_hda_codec_idt snd_hda_codec_generic ledtrig_audio snd_hda_code=
c_hdmi snd_hda_intel parport_pc parport snd_intel_dspcfg dell_smo8800 snd=
_intel_sdw_acpi i915 snd_hda_codec dell_rbtn snd_seq rfkill snd_hda_core =
snd_seq_device snd_hwdep snd_pcm i2c_i801 i2c_smbus lpc_ich e1000e snd_ti=
mer snd drm_buddy mei_me soundcore mei ip_tables
[  563.890692]  nouveau crc32c_intel usb_storage sdhci_pci cqhci sdhci mm=
c_core serio_raw drm_ttm_helper ttm mxm_wmi drm_display_helper cec video =
wmi i2c_dev fuse [last unloaded: btusb]
[  563.893158] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         =
 6.0.0-rc1+ #99
[  563.893633] Hardware name: Dell Inc. Latitude E6430/0H3MT5, BIOS A21 0=
5/08/2017
[  563.894099] RIP: 0010:ieee80211_rx_handlers+0x230/0x2a70 [mac80211]
[  563.894620] Code: 00 00 84 c0 0f 84 a4 05 00 00 48 8b 43 18 41 8b 57 7=
0 49 8b b7 d0 00 00 00 48 8b b8 08 09 00 00 e8 e5 e3 ed ff e9 12 06 00 00=
 <0f> 0b 44 89 f6 48 89 df e8 83 f1 ff ff 48 8b 45 00 48 39 c5 74 09
[  563.895665] RSP: 0018:ffffb7cc40003cd0 EFLAGS: 00010246
[  563.896203] RAX: ffff95ea229e0f00 RBX: ffffb7cc40003da0 RCX: ffff95e88=
6f5ab00
[  563.896759] RDX: ffffb7cc40003df0 RSI: 0000000000000028 RDI: ffff95e88=
4f61688
[  563.897312] RBP: ffffb7cc40003df0 R08: 0000000000000001 R09: 000000000=
0000000
[  563.897871] R10: ffff95e88396a580 R11: 0000000000000001 R12: 000000000=
0000000
[  563.898422] R13: ffffb7cc40003df0 R14: 0000000000000002 R15: ffff95e88=
9a17200
[  563.898975] FS:  0000000000000000(0000) GS:ffff95ea24200000(0000) knlG=
S:0000000000000000
[  563.899559] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  563.900132] CR2: 00007f27e270c000 CR3: 00000000b4c26003 CR4: 000000000=
01706f0
[  563.900731] Call Trace:
[  563.901319]  <IRQ>
[  563.901915]  ? rcu_read_lock_sched_held+0x10/0x80
[  563.902530]  ? lock_release+0x1ef/0x2d0
[  563.903128]  ? rcu_read_lock_sched_held+0x10/0x80
[  563.903755]  ? lock_acquire+0x255/0x2b0
[  563.904368]  ? rcu_read_lock_sched_held+0x10/0x80
[  563.904994]  ? lock_release+0x1ef/0x2d0
[  563.905637]  ? ieee80211_sta_reorder_release.isra.0+0x2ea/0x380 [mac80=
211]
[  563.906308]  ieee80211_release_reorder_timeout+0x129/0x1a0 [mac80211]
[  563.906997]  ? lock_acquire+0x255/0x2b0
[  563.907667]  ? lock_acquire+0x255/0x2b0
[  563.908318]  ? perf_event_task_tick+0x7d/0x430
[  563.908980]  ? sta_rx_agg_session_timer_expired+0x70/0x70 [mac80211]
[  563.909694]  ? sta_rx_agg_session_timer_expired+0x70/0x70 [mac80211]
[  563.910396]  sta_rx_agg_reorder_timer_expired+0x45/0xd0 [mac80211]
[  563.911107]  call_timer_fn+0x95/0x2a0
[  563.911810]  __run_timers.part.0+0x1cd/0x2b0
[  563.912507]  ? lock_release+0x1ef/0x2d0
[  563.913192]  ? sched_clock_cpu+0xb/0xc0
[  563.913904]  run_timer_softirq+0x31/0x70
[  563.914623]  __do_softirq+0xf5/0x54d
[  563.915317]  __irq_exit_rcu+0xed/0x160
[  563.916015]  irq_exit_rcu+0xa/0x30
[  563.916720]  sysvec_apic_timer_interrupt+0x9e/0xc0
[  563.917406]  </IRQ>
[  563.918084]  <TASK>
[  563.918766]  asm_sysvec_apic_timer_interrupt+0x16/0x20
[  563.919430] RIP: 0010:cpuidle_enter_state+0xeb/0x320
[  563.920091] Code: 1b e2 5e ff 45 84 ff 74 16 9c 58 0f 1f 40 00 f6 c4 0=
2 0f 85 05 02 00 00 31 ff e8 20 8a 66 ff e8 8b cc 6d ff fb 0f 1f 44 00 00=
 <45> 85 ed 0f 88 e2 00 00 00 49 63 cd 4c 89 f2 48 8d 04 49 48 8d 04
[  563.921504] RSP: 0018:ffffffffa3c03e50 EFLAGS: 00000246
[  563.922221] RAX: 0000000080000001 RBX: ffffd7cc3fc02d80 RCX: 000000000=
0000000
[  563.922963] RDX: 000000834a5f9154 RSI: ffffffffa38b0b6c RDI: ffffffffa=
2b689d5
[  563.923710] RBP: 0000000000000005 R08: 0000000000000000 R09: 000000000=
0000000
[  563.924422] R10: 0000000000000000 R11: 00000000000008ae R12: ffffffffa=
3ec8040
[  563.925125] R13: 0000000000000005 R14: 000000834a5f9154 R15: 000000000=
0000000
[  563.925836]  ? cpuidle_enter_state+0xe5/0x320
[  563.926526]  cpuidle_enter+0x29/0x40
[  563.927174]  do_idle+0x202/0x290
[  563.927836]  cpu_startup_entry+0x19/0x20
[  563.928466]  rest_init+0xeb/0x170
[  563.929080]  arch_call_rest_init+0xa/0x14
[  563.929708]  start_kernel+0x97f/0x993
[  563.930310]  secondary_startup_64_no_verify+0xe5/0xeb
[  563.930885]  </TASK>
[  563.931396] irq event stamp: 484676
[  563.931909] hardirqs last  enabled at (484675): [<ffffffffa21d4add>] t=
ick_nohz_idle_exit+0x6d/0x140
[  563.932430] hardirqs last disabled at (484676): [<ffffffffa2eb2123>] _=
_schedule+0xdd3/0x1670
[  563.932951] softirqs last  enabled at (484598): [<ffffffffa20fbcbd>] _=
_irq_exit_rcu+0xed/0x160
[  563.933474] softirqs last disabled at (484591): [<ffffffffa20fbcbd>] _=
_irq_exit_rcu+0xed/0x160
[  563.933996] ---[ end trace 0000000000000000 ]---

FWIW this happened some time after a suspend/resume, but I don't think it=

is actually suspend/resume related.

Regards,

Hans

