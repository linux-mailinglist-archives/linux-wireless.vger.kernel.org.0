Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B586B7278
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Mar 2023 10:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjCMJ0R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Mar 2023 05:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjCMJ0G (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Mar 2023 05:26:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15F826C2A
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 02:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678699519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4Z4sbrM85RhZj3MZHMb9W9CNcsypRoySuwLdTZHwkDg=;
        b=UOnI7eWQ6S6HV+xNnvg7bvPg7nrHmwQlaN54brI3bD5xDzhXJryYR8INCo8ZxAE7euKI2o
        qtE8+YgxCQRy0xuQROAqjRs3K1/s9OM8ULPGhnDD8ZIxbvBk77w4Mr0hIdlBp8rzcgA1Np
        kaz/6eWiYJW+8r6uiSW/R6FAzvEK4t4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-I4YBsY71P4GIo-eom_Axnw-1; Mon, 13 Mar 2023 05:25:18 -0400
X-MC-Unique: I4YBsY71P4GIo-eom_Axnw-1
Received: by mail-wr1-f72.google.com with SMTP id i11-20020a5d522b000000b002ceac3d4413so345727wra.11
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 02:25:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678699516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Z4sbrM85RhZj3MZHMb9W9CNcsypRoySuwLdTZHwkDg=;
        b=XeGU/kZ5WE005hnlyAxZ3Hbd+QdlJ2wkHzm5gidsPh/AG5DKB1LoBiDZL4r/f7HiIB
         N1Qfgc71v/p6GorwMbqKgGypcPudqts/V3XxgCMXuEgMaPyVWkPJkHf4extvz4j5+5Qz
         QzYV8OngpZW7c6VxtBWAZdH5NtZFDUNbKaizh4r+h0fir+ilafPR2gFAPOJfpKprYZm5
         uPfRO1NHHVJ009C8ChUibhnABi6lfv9p/hLyD3e3fdY/bL/GyyjKhXnafKWHE3IwzSMJ
         p1r89G/9MBnaD5U+e1vF+N9iWYmto82RYrJIbgMc1USczZ7RuJbKtDbYjTwUtlW9AG2H
         dv7A==
X-Gm-Message-State: AO0yUKVY9owdqzAwzyxLlPz3GV+hL6D7nfYnwkOrVFuncrVZrng8U79x
        kukJ8Zz80mtGG/Fd3sB9PCMpEZ6elTRPheAtRGvoZYz0dhNYTSSScRsbfrNqBpSlebT3RzhNRXk
        abRGatIcJ1S6akxnoAnu5TN4S7abqeqNc8VM=
X-Received: by 2002:a5d:5650:0:b0:2ce:98fc:f289 with SMTP id j16-20020a5d5650000000b002ce98fcf289mr5009679wrw.49.1678699516611;
        Mon, 13 Mar 2023 02:25:16 -0700 (PDT)
X-Google-Smtp-Source: AK7set9ZKb7e0E5yg1KDMBcVvmgqYpNZQ3XTBkvZwEsVgtv7op69kQlNAFuxg37kZKqlfROhvZpyAg==
X-Received: by 2002:a5d:5650:0:b0:2ce:98fc:f289 with SMTP id j16-20020a5d5650000000b002ce98fcf289mr5009666wrw.49.1678699516262;
        Mon, 13 Mar 2023 02:25:16 -0700 (PDT)
Received: from localhost (net-188-216-77-84.cust.vodafonedsl.it. [188.216.77.84])
        by smtp.gmail.com with ESMTPSA id c2-20020adffb42000000b002cefcac0c62sm2523735wrs.9.2023.03.13.02.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 02:25:15 -0700 (PDT)
Date:   Mon, 13 Mar 2023 10:25:13 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     kvalo@kernel.org, linux-wireless@vger.kernel.org, nbd@nbd.name
Subject: Re: [PATCH wireless] wifi: mt76: connac: do not check WED status for
 non-mmio devices
Message-ID: <ZA7r+a0J7LBsbDX+@lore-desk>
References: <c42168429453474213fa8244bf4b069de4531f40.1678124335.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7yM+QguNgU57CjVu"
Content-Disposition: inline
In-Reply-To: <c42168429453474213fa8244bf4b069de4531f40.1678124335.git.lorenzo@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--7yM+QguNgU57CjVu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> WED is supported just for mmio devices, so do not check it for usb or
> sdio devices. This patch fixes the crash reported below:

I would say this one can be applied to wireless tree.

@Felix: do you agree?

Regards,
Lorenzo

>=20
> [   21.946627] wlp0s3u1i3: authenticate with c4:41:1e:f5:2b:1d
> [   22.525298] wlp0s3u1i3: send auth to c4:41:1e:f5:2b:1d (try 1/3)
> [   22.548274] wlp0s3u1i3: authenticate with c4:41:1e:f5:2b:1d
> [   22.557694] wlp0s3u1i3: send auth to c4:41:1e:f5:2b:1d (try 1/3)
> [   22.565885] wlp0s3u1i3: authenticated
> [   22.569502] wlp0s3u1i3: associate with c4:41:1e:f5:2b:1d (try 1/3)
> [   22.578966] wlp0s3u1i3: RX AssocResp from c4:41:1e:f5:2b:1d (capab=3D0=
x11 status=3D30 aid=3D3)
> [   22.579113] wlp0s3u1i3: c4:41:1e:f5:2b:1d rejected association tempora=
rily; comeback duration 1000 TU (1024 ms)
> [   23.649518] wlp0s3u1i3: associate with c4:41:1e:f5:2b:1d (try 2/3)
> [   23.752528] wlp0s3u1i3: RX AssocResp from c4:41:1e:f5:2b:1d (capab=3D0=
x11 status=3D0 aid=3D3)
> [   23.797450] wlp0s3u1i3: associated
> [   24.959527] kernel tried to execute NX-protected page - exploit attemp=
t? (uid: 0)
> [   24.959640] BUG: unable to handle page fault for address: ffff88800c22=
3200
> [   24.959706] #PF: supervisor instruction fetch in kernel mode
> [   24.959788] #PF: error_code(0x0011) - permissions violation
> [   24.959846] PGD 2c01067 P4D 2c01067 PUD 2c02067 PMD c2a8063 PTE 800000=
000c223163
> [   24.959957] Oops: 0011 [#1] PREEMPT SMP
> [   24.960009] CPU: 0 PID: 391 Comm: wpa_supplicant Not tainted 6.2.0-kvm=
 #18
> [   24.960089] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1=
=2E16.1-2.fc37 04/01/2014
> [   24.960191] RIP: 0010:0xffff88800c223200
> [   24.960446] RSP: 0018:ffffc90000ff7698 EFLAGS: 00010282
> [   24.960513] RAX: ffff888028397010 RBX: ffff88800c26e630 RCX: 000000000=
0000058
> [   24.960598] RDX: ffff88800c26f844 RSI: 0000000000000006 RDI: ffff88802=
8397010
> [   24.960682] RBP: ffff88800ea72f00 R08: 18b873fbab2b964c R09: be06b3823=
5f3c63c
> [   24.960766] R10: 18b873fbab2b964c R11: be06b38235f3c63c R12: 000000000=
0000001
> [   24.960853] R13: ffff88800c26f84c R14: ffff8880063f0ff8 R15: ffff88800=
c26e644
> [   24.960950] FS:  00007effcea327c0(0000) GS:ffff88807dc00000(0000) knlG=
S:0000000000000000
> [   24.961036] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   24.961106] CR2: ffff88800c223200 CR3: 000000000eaa2000 CR4: 000000000=
00006b0
> [   24.961190] Call Trace:
> [   24.961219]  <TASK>
> [   24.961245]  ? mt76_connac_mcu_add_key+0x2cf/0x310
> [   24.961313]  ? mt7921_set_key+0x150/0x200
> [   24.961365]  ? drv_set_key+0xa9/0x1b0
> [   24.961418]  ? ieee80211_key_enable_hw_accel+0xd9/0x240
> [   24.961485]  ? ieee80211_key_replace+0x3f3/0x730
> [   24.961541]  ? crypto_shash_setkey+0x89/0xd0
> [   24.961597]  ? ieee80211_key_link+0x2d7/0x3a0
> [   24.961664]  ? crypto_aead_setauthsize+0x31/0x50
> [   24.961730]  ? sta_info_hash_lookup+0xa6/0xf0
> [   24.961785]  ? ieee80211_add_key+0x1fc/0x250
> [   24.961842]  ? rdev_add_key+0x41/0x140
> [   24.961882]  ? nl80211_parse_key+0x6c/0x2f0
> [   24.961940]  ? nl80211_new_key+0x24a/0x290
> [   24.961984]  ? genl_rcv_msg+0x36c/0x3a0
> [   24.962036]  ? rdev_mod_link_station+0xe0/0xe0
> [   24.962102]  ? nl80211_set_key+0x410/0x410
> [   24.962143]  ? nl80211_pre_doit+0x200/0x200
> [   24.962187]  ? genl_bind+0xc0/0xc0
> [   24.962217]  ? netlink_rcv_skb+0xaa/0xd0
> [   24.962259]  ? genl_rcv+0x24/0x40
> [   24.962300]  ? netlink_unicast+0x224/0x2f0
> [   24.962345]  ? netlink_sendmsg+0x30b/0x3d0
> [   24.962388]  ? ____sys_sendmsg+0x109/0x1b0
> [   24.962388]  ? ____sys_sendmsg+0x109/0x1b0
> [   24.962440]  ? __import_iovec+0x2e/0x110
> [   24.962482]  ? ___sys_sendmsg+0xbe/0xe0
> [   24.962525]  ? mod_objcg_state+0x25c/0x330
> [   24.962576]  ? __dentry_kill+0x19e/0x1d0
> [   24.962618]  ? call_rcu+0x18f/0x270
> [   24.962660]  ? __dentry_kill+0x19e/0x1d0
> [   24.962702]  ? __x64_sys_sendmsg+0x70/0x90
> [   24.962744]  ? do_syscall_64+0x3d/0x80
> [   24.962796]  ? exit_to_user_mode_prepare+0x1b/0x70
> [   24.962852]  ? entry_SYSCALL_64_after_hwframe+0x46/0xb0
> [   24.962913]  </TASK>
> [   24.962939] Modules linked in:
> [   24.962981] CR2: ffff88800c223200
> [   24.963022] ---[ end trace 0000000000000000 ]---
> [   24.963087] RIP: 0010:0xffff88800c223200
> [   24.963323] RSP: 0018:ffffc90000ff7698 EFLAGS: 00010282
> [   24.963376] RAX: ffff888028397010 RBX: ffff88800c26e630 RCX: 000000000=
0000058
> [   24.963458] RDX: ffff88800c26f844 RSI: 0000000000000006 RDI: ffff88802=
8397010
> [   24.963538] RBP: ffff88800ea72f00 R08: 18b873fbab2b964c R09: be06b3823=
5f3c63c
> [   24.963622] R10: 18b873fbab2b964c R11: be06b38235f3c63c R12: 000000000=
0000001
> [   24.963705] R13: ffff88800c26f84c R14: ffff8880063f0ff8 R15: ffff88800=
c26e644
> [   24.963788] FS:  00007effcea327c0(0000) GS:ffff88807dc00000(0000) knlG=
S:0000000000000000
> [   24.963871] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   24.963941] CR2: ffff88800c223200 CR3: 000000000eaa2000 CR4: 000000000=
00006b0
> [   24.964018] note: wpa_supplicant[391] exited with irqs disabled
>=20
> Fixes: d1369e515efe ("wifi: mt76: connac: introduce mt76_connac_mcu_sta_w=
ed_update utility routine")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drive=
rs/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> index efb9bfaa187f..008ece1b16f8 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> @@ -1221,6 +1221,9 @@ EXPORT_SYMBOL_GPL(mt76_connac_mcu_sta_ba_tlv);
> =20
>  int mt76_connac_mcu_sta_wed_update(struct mt76_dev *dev, struct sk_buff =
*skb)
>  {
> +	if (!mt76_is_mmio(dev))
> +		return 0;
> +
>  	if (!mtk_wed_device_active(&dev->mmio.wed))
>  		return 0;
> =20
> --=20
> 2.39.2
>=20

--7yM+QguNgU57CjVu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZA7r+QAKCRA6cBh0uS2t
rHDsAQDv/2IvMgcy+bbDE3Rc96hoSbhFM3jhj+Idhm/J+F70xgD+L28RFWR8wqo2
UKz8sh16KRMYESf4trgFr4adVhBmfgw=
=VlzS
-----END PGP SIGNATURE-----

--7yM+QguNgU57CjVu--

