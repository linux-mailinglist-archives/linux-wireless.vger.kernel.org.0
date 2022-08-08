Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FCE58CD40
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Aug 2022 20:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237087AbiHHSAV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Aug 2022 14:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243992AbiHHSAR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Aug 2022 14:00:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D33B28
        for <linux-wireless@vger.kernel.org>; Mon,  8 Aug 2022 11:00:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBEE661204
        for <linux-wireless@vger.kernel.org>; Mon,  8 Aug 2022 18:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D63FC433D7
        for <linux-wireless@vger.kernel.org>; Mon,  8 Aug 2022 18:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659981612;
        bh=CRxLN6JWqv8WMzAg3J/iOmvt8kPXA+EsmPpUBi7UBGQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mnQ8G2yweKwQxdoE9mjXCzGoLVm1D88ZHefvZiCsplzWSlMGp7gsLJSma4OPiteIP
         3NEVuSoiCbqz5Gthy0GiFkf/k3J0nnUaZf+fgxu9zt6puLG7gZ1ahcRqDGVzB4ogXl
         rsbdttOLF33EasmBpdycYORYhovwWN9ZpWkzmlfL2ht/d9rA7W6+zy8s8Er5jxia+b
         EN7fSKIVt0fnNQW4CkOZzQBjTg+5CC76W2tyPWAJlk6Kh8DPfuDDYu1TZMpXgFYqzy
         BVL9vuY1K47YHxd2jY4jTjNqEYTqnrpE5MJBxxos0bu+ZPNdeGh4GjDl2zDoLrptys
         SB4S1y9yVA3cw==
Received: by mail-wm1-f43.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so993061wms.5
        for <linux-wireless@vger.kernel.org>; Mon, 08 Aug 2022 11:00:11 -0700 (PDT)
X-Gm-Message-State: ACgBeo1fQlaF6ug9tu8sHYcZ6m791MfvuiBG1itK88Gw+/1pSP7BkTZ0
        MWtU6WIC39//zt7AwKXk82gaD+HVYjEVKu7kc4Y=
X-Google-Smtp-Source: AA6agR7JseF+2MSlhdKrFGeVay+PALd869TXy/nqDagbXqPtp4rtA9ws8gIsxOZRg2haDC3voeYJ6CqtqolIw9+KjLw=
X-Received: by 2002:a7b:cb4e:0:b0:3a2:f3b0:4233 with SMTP id
 v14-20020a7bcb4e000000b003a2f3b04233mr13276724wmj.50.1659981610198; Mon, 08
 Aug 2022 11:00:10 -0700 (PDT)
MIME-Version: 1.0
References: <VE1PR04MB64945C660A81D38F290E4A4BE59F9@VE1PR04MB6494.eurprd04.prod.outlook.com>
In-Reply-To: <VE1PR04MB64945C660A81D38F290E4A4BE59F9@VE1PR04MB6494.eurprd04.prod.outlook.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Mon, 8 Aug 2022 10:59:58 -0700
X-Gmail-Original-Message-ID: <CAGp9Lzp0H7wEAhbFBHDkr2q3fCvjRB5CnpHqeE+y9D=62Y9GOQ@mail.gmail.com>
Message-ID: <CAGp9Lzp0H7wEAhbFBHDkr2q3fCvjRB5CnpHqeE+y9D=62Y9GOQ@mail.gmail.com>
Subject: Re: mt7921e: Network device not responding following chip reset
To:     Kostas Peletidis <kostas.peletidis@suse.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kostas,

Applying the patch in [1] should be able to fix the following kernel
panic to make the system run even if something goes wrong in the
driver.

Jul 08 08:47:21 savra kernel: WARNING: CPU: 7 PID: 113 at
kernel/kthread.c:659 kthread_park+0x7b/0x90
<...>
Jul 08 08:47:21 savra kernel: Call Trace:
Jul 08 08:47:21 savra kernel:  <TASK>
Jul 08 08:47:21 savra kernel:  mt7921e_mac_reset+0x9e/0x2d0 [mt7921e
1df6344b7ec017c6819314bafbaefbc4739af58d]
Jul 08 08:47:21 savra kernel:  mt7921_mac_reset_work+0x9f/0x14a
[mt7921_common a3df60fd5ed501d6ce3c322675b791e633aa28b5]
Jul 08 08:47:21 savra kernel:  process_one_work+0x208/0x3c0
Jul 08 08:47:21 savra kernel:  worker_thread+0x4a/0x3b0
Jul 08 08:47:21 savra kernel:  ? process_one_work+0x3c0/0x3c0
Jul 08 08:47:21 savra kernel:  kthread+0xda/0x100
Jul 08 08:47:21 savra kernel:  ? kthread_complete_and_exit+0x20/0x20
Jul 08 08:47:21 savra kernel:  ret_from_fork+0x22/0x30
Jul 08 08:47:21 savra kernel:  </TASK>

On the other hand, we need time to figure out why "mt7921e
0000:03:00.0: driver own failed" happened in the log you provided
here.
But if it is possible for you, you can try out the latest firmware in
[2] first to see if it would be helpful for you.

[1] https://patchwork.kernel.org/project/linux-wireless/patch/727eb5ffd3c7c=
805245e512da150ecf0a7154020.1659452909.git.deren.wu@mediatek.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware=
.git/tree/mediatek
Grab and update the following three files.
1.) BT_RAM_CODE_MT7961_1_2_hdr.bin
2.) WIFI_MT7961_patch_mcu_1_2_hdr.bin
3.) WIFI_RAM_CODE_MT7961_1.bin

         Sean

On Thu, Aug 4, 2022 at 10:25 AM Kostas Peletidis
<kostas.peletidis@suse.com> wrote:
>
> Hello,
>
> Takashi (in cc) and I have been looking at a strange mt7921e issue I enco=
untered and any help to get to the bottom of it would be much appreciated. =
During normal use of my machine sometimes the network would become unreacha=
ble and any network related commands, such as ping or ss, would hang indefi=
nitely when executed in a terminal. This is what a typical dmesg output wou=
ld look like (see URL at the end of this message for full details):
>
> [11249.676616] r8169 0000:02:00.0 enp2s0f0: Link is Down
> [11453.812782] mt7921e 0000:03:00.0: driver own failed
> [11454.986117] mt7921e 0000:03:00.0: driver own failed
> [11454.986134] mt7921e 0000:03:00.0: chip reset
> [11456.170894] mt7921e 0000:03:00.0: driver own failed
> [11456.278532] pcieport 0000:00:02.3: pciehp: Slot(0): Link Down
> [11456.278536] pcieport 0000:00:02.3: pciehp: Slot(0): Card not present
> [11456.313973] wlp3s0: deauthenticating from f8:5b:3b:0f:2b:9f by local c=
hoice (Reason: 3=3DDEAUTH_LEAVING)
> [11457.286206] mt7921e 0000:03:00.0: Timeout for driver own
> [11458.400420] mt7921e 0000:03:00.0: driver own failed
> [11458.400442] ------------[ cut here ]------------
> [11458.400443] WARNING: CPU: 2 PID: 8597 at kernel/kthread.c:659 kthread_=
park+0x81/0x90
>
> I have noticed this issue both with tainted and not tainted kernels. To m=
e it looks like some kind of hardware reset timed out (or the hardware was =
probed too quickly). This is what a successful chip reset looks like in my =
logs:
>
> Chip reset OK, no warning
> -------------------------
> Jul 04 13:06:33 savra kernel: mt7921e 0000:03:00.0: driver own failed
> Jul 04 13:06:35 savra kernel: mt7921e 0000:03:00.0: driver own failed
> Jul 04 13:06:35 savra kernel: mt7921e 0000:03:00.0: chip reset
> Jul 04 13:06:35 savra kernel: mt7921e 0000:03:00.0: HW/SW Version: 0x8a10=
8a10, Build Time: 20220311230842a
> Jul 04 13:06:35 savra kernel: mt7921e 0000:03:00.0: WM Firmware Version: =
____010000, Build Time: 20220311230931
> Jul 04 13:06:36 savra kernel: wlp3s0: Driver requested disconnection from=
 AP f8:5b:3b:0f:2b:9f
>
> And this is what the chip reset looks like when the issue occurs:
>
> Chip reset timeout, warning
> ---------------------------
> Aug 03 12:18:00 savra kernel: mt7921e 0000:03:00.0: driver own failed
> Aug 03 12:18:02 savra kernel: mt7921e 0000:03:00.0: driver own failed
> Aug 03 12:18:02 savra kernel: mt7921e 0000:03:00.0: chip reset
> Aug 03 12:18:03 savra kernel: mt7921e 0000:03:00.0: driver own failed
> Aug 03 12:18:03 savra kernel: pcieport 0000:00:02.3: pciehp: Slot(0): Lin=
k Down
> Aug 03 12:18:03 savra kernel: pcieport 0000:00:02.3: pciehp: Slot(0): Car=
d not present
> Aug 03 12:18:03 savra kernel: wlp3s0: deauthenticating from f8:5b:3b:0f:2=
b:9f by local choice (Reason: 3=3DDEAUTH_LEAVING)
> Aug 03 12:18:04 savra kernel: mt7921e 0000:03:00.0: Timeout for driver ow=
n
> Aug 03 12:18:05 savra kernel: mt7921e 0000:03:00.0: driver own failed
> Aug 03 12:18:05 savra kernel: ------------[ cut here ]------------
> Aug 03 12:18:05 savra kernel: WARNING: CPU: 6 PID: 26340 at kernel/kthrea=
d.c:659 kthread_park+0x81/0x90
>
> I have added dmesg logs and all pertinent information in the ticket below=
:
> https://bugzilla.opensuse.org/show_bug.cgi?id=3D1201845
>
> Would someone please have a look and help us figure out what would cause =
the "driver own failed" message to be logged? Thank you.
>
>
> Regards,
> Kostas
