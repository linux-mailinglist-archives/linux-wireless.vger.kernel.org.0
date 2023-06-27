Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C796E7405F2
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jun 2023 23:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjF0VzP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Jun 2023 17:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjF0VzM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Jun 2023 17:55:12 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F564198
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jun 2023 14:55:10 -0700 (PDT)
Date:   Tue, 27 Jun 2023 21:55:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1687902905; x=1688162105;
        bh=olCNpm/B/IOvQlREF6Q6bMkATyN3ia7EIKann4/rzPo=;
        h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=N9ND1TqW/SKzSrK+BTbnO6MUBahq+2vwv9OsCEBDnJ4/XphcvVrqTEKaMOZBrX64W
         fE5oADUVnXmnwEZYjCT7QlWuEbTFgnJxm+cv8IMipjyF08LMAppssFYeEUxrrsbb+8
         pizuVHEBPOeow9eT8AbUUM7VYrOPCX9oIYofFdaQEh13fCgM5YjF9iFSFgP1FJSkMN
         We4l89pKiVKhvztiR4lqKWp1Sw9u/EGL1UdQvYkSzgtTg2XrA+aj1kjaGyjk5hYIXW
         PGsK98nimGX9JvLMJUV5JohrueFgsKANSiA6v0rUXavpOm8pvtGQf/MqwC2Z0S1Dbm
         i+JIjlHDpHjxg==
To:     linux-wireless <linux-wireless@vger.kernel.org>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: iwlwifi: AX201 misdetected as AX101
Message-ID: <FFsiCdZPcJ2FItvpkX6E-0LT-gc1m-7JdRKTZ0NB9s7AmhtFt09wmR8fItdeT5xaYybsKsC_cjXuh5i_V97rgq4fJgKOmBmKytjCwSKlnAU=@protonmail.com>
In-Reply-To: <gAwMzXEPlQZUgbc6n3yYY2soROKl4-D_JfWwoHW8CMx-LDkDEeAlwcyjOMy767W3eEVxS-e7oEihVh1PNHT-_iznSKneJjW0vu0PN7aQ9K8=@protonmail.com>
References: <gAwMzXEPlQZUgbc6n3yYY2soROKl4-D_JfWwoHW8CMx-LDkDEeAlwcyjOMy767W3eEVxS-e7oEihVh1PNHT-_iznSKneJjW0vu0PN7aQ9K8=@protonmail.com>
Feedback-ID: 20568564:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi again,


2023. m=C3=A1jus 26., p=C3=A9ntek 19:55 keltez=C3=A9ssel, Barnab=C3=A1s P=
=C5=91cze <pobrn@protonmail.com> =C3=ADrta:

> Hi all,
>=20
> I have an Acer Aspire A315-58 laptop[0], which, according to lspci has th=
e following intel wireless chip:
>=20
>    Device:=0900:14.3
>     Class:=09Network controller [0280]
>    Vendor:=09Intel Corporation [8086]
>    Device:=09Wi-Fi 6 AX201 [a0f0]
>   SVendor:=09Intel Corporation [8086]
>   SDevice:=09Wi-Fi 6 AX201 [0244]
>       Rev:=0920
>    ProgIf:=0900
>    Driver:=09iwlwifi
>    Module:=09iwlwifi
>=20
> However, in the kernel message buffer, the following message is written:
>=20
>   [    3.633490] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6 AX101, R=
EV=3D0x351
>=20
> Also, this chip did not work with the 6.3.3 Arch Linux kernel, the driver=
 loaded the
> `QuZ-a0-hr-b0-74.ucode` firmware:
>=20
>   [    6.516505] iwlwifi 0000:00:14.3: WRT: Collecting data: ini trigger =
13 fired (delay=3D0ms).
>   [    6.517615] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
>   [    6.517616] iwlwifi 0000:00:14.3: Transport status: 0x0000004A, vali=
d: 6
>   [    6.517617] iwlwifi 0000:00:14.3: Loaded firmware version: 74.a5e958=
8b.0 QuZ-a0-hr-b0-74.ucode
>   [    6.517619] iwlwifi 0000:00:14.3: 0x00000084 | NMI_INTERRUPT_UNKNOWN
>   ...
>   [    6.861510] iwlwifi 0000:00:14.3: Failed to run INIT ucode: -110
>=20

For the record, I have done a git-bisect[1], and that turned up

  d2ccc5c1526396aef5196e4dd2ec8538994e5072
  wifi: iwlwifi: Update init sequence if tx diversity supported

as the first good commit[0].

Sadly, that patch (or even the series) does not appear to be easily backpor=
table,
so it seems likely that current stable kernels won't be able to support thi=
s device.


Regards,
Barnab=C3=A1s P=C5=91cze


[0]: https://lore.kernel.org/all/20230413102635.c2121c8694a7.Ibee3dd8765ef4=
b7504660fa228a7c7eff78920af@changeid/
[1]:
  git bisect start
  # status: waiting for both good and bad commits
  # new: [b6dad5178ceaf23f369c3711062ce1f2afc33644] Merge tag 'nios2_fix_v6=
.4' of git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux
  git bisect new b6dad5178ceaf23f369c3711062ce1f2afc33644
  # status: waiting for good commit(s), bad commit known
  # old: [457391b0380335d5e9a5babdec90ac53928b23b4] Linux 6.3
  git bisect old 457391b0380335d5e9a5babdec90ac53928b23b4
  # new: [6e98b09da931a00bf4e0477d0fa52748bf28fcce] Merge tag 'net-next-6.4=
' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
  git bisect new 6e98b09da931a00bf4e0477d0fa52748bf28fcce
  # old: [088e0c188513b58a0056a488cf5b7df094a8a48a] Merge tag 'platform-dri=
vers-x86-v6.4-1' of git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/pla=
tform-drivers-x86
  git bisect old 088e0c188513b58a0056a488cf5b7df094a8a48a
  # new: [ca288965801572fe41386560d4e6c5cc0e5cc56d] Merge tag 'wireless-nex=
t-2023-04-21' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wir=
eless-next
  git bisect new ca288965801572fe41386560d4e6c5cc0e5cc56d
  # old: [d56417ad1133fc41752bb9fe37da7ae3187395a4] net: phy: smsc: clear e=
dpd_enable if interrupt mode is used
  git bisect old d56417ad1133fc41752bb9fe37da7ae3187395a4
  # old: [c54876cd5961ce0f8e74807f79a6739cd6b35ddf] net/sched: pass netlink=
 extack to mqprio and taprio offload
  git bisect old c54876cd5961ce0f8e74807f79a6739cd6b35ddf
  # new: [3288ee5844b74cebb94ed15bc9b5b9d3223ae038] Merge ath-next from git=
://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
  git bisect new 3288ee5844b74cebb94ed15bc9b5b9d3223ae038
  # new: [d0b6f86fdbefa62fd4ad2acd1aea6c45f9b518ba] wifi: mt76: mt7996: let=
 non-bufferable MMPDUs use correct hw queue
  git bisect new d0b6f86fdbefa62fd4ad2acd1aea6c45f9b518ba
  # new: [a0e97ae3f3320a246a79db7372fc23a38556014e] wifi: rtw89: add ieee80=
211::remain_on_channel ops
  git bisect new a0e97ae3f3320a246a79db7372fc23a38556014e
  # new: [d00800a289c9349bb659a698cbd7bc04521dc927] wifi: mac80211: add flu=
sh_sta method
  git bisect new d00800a289c9349bb659a698cbd7bc04521dc927
  # old: [413be839bfca9a4f6b32b92807ecdc2c2c182d94] wifi: iwlwifi: add a va=
lidity check of queue_id in iwl_txq_reclaim
  git bisect old 413be839bfca9a4f6b32b92807ecdc2c2c182d94
  # old: [e305a408c5f9c8df06a58e09a23375fd257f081c] wifi: iwlwifi: mvm: mov=
e function sequence
  git bisect old e305a408c5f9c8df06a58e09a23375fd257f081c
  # new: [217f3c52f00d3419ecdd38a99a7eceecb11679b2] wifi: iwlwifi: mvm: don=
't set CHECKSUM_COMPLETE for unsupported protocols
  git bisect new 217f3c52f00d3419ecdd38a99a7eceecb11679b2
  # new: [5caa82529eabff044c5f3eb254f3a7ff00e9170d] wifi: iwlwifi: Update c=
onfigurations for Bnj-a0 and specific rf devices
  git bisect new 5caa82529eabff044c5f3eb254f3a7ff00e9170d
  # new: [d2ccc5c1526396aef5196e4dd2ec8538994e5072] wifi: iwlwifi: Update i=
nit sequence if tx diversity supported
  git bisect new d2ccc5c1526396aef5196e4dd2ec8538994e5072
  # first new commit: [d2ccc5c1526396aef5196e4dd2ec8538994e5072] wifi: iwlw=
ifi: Update init sequence if tx diversity supported


>=20
> I then noticed that firmwares 75-77 are available and that there were rec=
ent changes
> to the iwlwifi module that increased IWL_22000_UCODE_API_MAX, so I gave i=
t a go,
> and built the kernel at ae8373a5add4ea39f032563cf12a02946d1e3546 and now =
firmware 77
> is loaded, and that seems to work, at least I did not notice any issues s=
o far.
>=20
> The full logs and other information about the laptop can be found here[0]=
.
>=20
>=20
> Regards,
> Barnab=C3=A1s P=C5=91cze
>=20
>=20
> [0]: https://linux-hardware.org/?probe=3D43069955ee
