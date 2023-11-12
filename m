Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D1F7E91C1
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Nov 2023 18:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjKLRKw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 12 Nov 2023 12:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjKLRKv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 12 Nov 2023 12:10:51 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401E6211B
        for <linux-wireless@vger.kernel.org>; Sun, 12 Nov 2023 09:10:48 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c788f5bf53so36088231fa.2
        for <linux-wireless@vger.kernel.org>; Sun, 12 Nov 2023 09:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699809046; x=1700413846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEDFIRAXn3yTGAq7UevLwoGNdZrHn8Ib3v9RNzpG5Kk=;
        b=NAprBPfUiM2Whi8VunWyvwM3MisCJnW4V0VOlrI+Abmk2IM8rHvTG3WqX39pEvOoPL
         AU62DOKSKQHc8V5miOw/Zm/SBKj3pTVD63zwxMjKuZuL9bvd1LvqZpXlnl+VhyImzSZA
         O6xlods+gfKh1JBPJub9fmtsz0vkDNQunW3bLqB+xRW9aBPRDBC1RMQm2CKbxEQp3rLt
         QNCOii5NYxq3PUGDXu0SyEoUVqvAkcZMGzp5hyAkmS5x+biFcsLPCoXcYgqIc0kY2v3y
         +8O4Ef7RGej0hGEvOakOw30KxhpE3SQ2AwGAVtI+CcKg+oQU5EtRNcY9J7FnH5JbjSOU
         GCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699809046; x=1700413846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEDFIRAXn3yTGAq7UevLwoGNdZrHn8Ib3v9RNzpG5Kk=;
        b=bvILW6hqLUaynV3Kt6g9byZVzM3l68lHWv6VoqRPV1p8B+T3bQVGpe1hvegPNOG46e
         hswh6hYhs/A3tN2rn9E8vD2TRhe1EBzwZBfw91JvcR5Rb1AjvK0cW5U8CjsS1w2ceCqJ
         i1fa7AI2X71E8pdLGWvTf3kY4q2LCGFjp9/elITMfKL06eb6hg50dYEK1W5eo4YIhLf7
         x8kXbvc+bwal+Ul/0n394dVdcKv7B8CRKHSOqwcaA2f21UfCpi3srNijQoVOw3jyvONR
         0lIYkTNhsawEJHdzkgPno03WxDDrXerhMdVe5pC+mRQRbdGl/Q+32YFcySihbASDDxGd
         J67g==
X-Gm-Message-State: AOJu0YzD1aXPy3v7616qgCcJhTEjhAQuCNq4bRBR6/wK7xJRu4HSom+/
        VC4GdB5FVCeitP0ByOt4iy3lmIey8xniVF8VObH0i4frnIU=
X-Google-Smtp-Source: AGHT+IEpxz0d6cO/S7M1YqkWPPXTIaiZhYxHsAz6q+xhswk3a6U7I86YzNf6iGZ1GV98AfOXjmZPvjCuYyzwPs21nao=
X-Received: by 2002:a19:ee1a:0:b0:506:93a0:777a with SMTP id
 g26-20020a19ee1a000000b0050693a0777amr2723902lfb.2.1699809045745; Sun, 12 Nov
 2023 09:10:45 -0800 (PST)
MIME-Version: 1.0
References: <20231022145556.244202-1-gregory.greenman@intel.com>
 <20231022173519.8cc7df0ebff2.If1dcb57145841c5b3c68ed112bbfcd0201f7acc3@changeid>
 <20231103031705.GA947@sol.localdomain> <ZU49Y0Nhf5XVfxPm@fedora.fritz.box>
In-Reply-To: <ZU49Y0Nhf5XVfxPm@fedora.fritz.box>
From:   Emmanuel Grumbach <egrumbach@gmail.com>
Date:   Sun, 12 Nov 2023 19:10:34 +0200
Message-ID: <CANUX_P25_CcSVbW8R1SB-X=ztsAQb+7u0R=YOSzNTxX94b20+w@mail.gmail.com>
Subject: Re: [PATCH 01/10] wifi: iwlwifi: mvm: implement new firmware API for statistics
To:     damian@riscv-rocks.de
Cc:     Eric Biggers <ebiggers@kernel.org>, gregory.greenman@intel.com,
        johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Fri, Nov 10, 2023 at 9:28=E2=80=AFPM Damian Tometzki <damian@riscv-rocks=
.de> wrote:
>
> On Thu, 02. Nov 20:17, Eric Biggers wrote:
> > Hi Gregory and Anjaneyulu,
> >
> > On Sun, Oct 22, 2023 at 05:55:47PM +0300, gregory.greenman@intel.com wr=
ote:
> > > From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
> > >
> > > The new firmware API uses a new command and notification,
> > > the command configures in which statistics types driver is
> > > interested and the notification is sent periodically.
> > > An additional change in the API is that most of the statistics
> > > data is accumulated and reported by the firmware per MLO link.
> > > Implement new command and notification handlers and adjust to
> > > per-link statistics.
> > >
> > > Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
> > > Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
> >
> > I'm seeing a warning at boot time due to this patch.  See below.  It's =
from
> > 'WARN_ON(iwl_cmd_groups_verify_sorted(trans_cfg));'.  Looks like there'=
s an
> > array that is supposed to be sorted that isn't sorted anymore.
> >
> Hello together,
>
> is there an update on this kernel dump below ?
>

Fixed by:
https://patchwork.kernel.org/project/linux-wireless/patch/20231112143620.36=
619-1-emmanuel.grumbach@intel.com/

>
> Many Thanks for an update and a nice weekend

you too

>
> Damian
>
>
> > [    5.342367] Intel(R) Wireless WiFi driver for Linux
> > [    5.342405] iwlwifi 0000:04:00.0: enabling device (0000 -> 0002)
> > [    5.342978] iwlwifi 0000:04:00.0: Detected crf-id 0xbadcafe, cnv-id =
0x10 wfpm id 0x80000000
> > [    5.342993] iwlwifi 0000:04:00.0: PCI dev 24fd/1010, rev=3D0x230, rf=
id=3D0xd55555d5
> > [    5.343131] xhci_hcd 0000:01:00.0: xHCI Host Controller
> > [    5.343137] xhci_hcd 0000:01:00.0: new USB bus registered, assigned =
bus number 1
> > [    5.346469] iwlwifi 0000:04:00.0: loaded firmware version 36.ca7b901=
d.0 8265-36.ucode op_mode iwlmvm
> > [    5.346502] ------------[ cut here ]------------
> > [    5.346503] WARNING: CPU: 1 PID: 20 at drivers/net/wireless/intel/iw=
lwifi/mvm/../iwl-trans.h:1158 iwl_op_mode_mvm_start+0x995/0x9b0
> > [    5.346511] CPU: 1 PID: 20 Comm: kworker/1:0 Not tainted 6.6.0-11999=
-gae7b1149d4fb #1
> > [    5.346514] Hardware name: Gigabyte Technology Co., Ltd. X399 AORUS =
Gaming 7/X399 AORUS Gaming 7, BIOS F2 08/31/2017
> > [    5.346516] Workqueue: events request_firmware_work_func
> > [    5.346520] RIP: 0010:iwl_op_mode_mvm_start+0x995/0x9b0
> > [    5.346524] Code: 41 5e 41 5f 5d e9 2b 4c 59 00 cc 48 c7 c7 10 58 a2=
 ba 48 c7 c6 8a 0c a3 ba e8 87 f1 57 00 e9 b6 fb ff ff 0f 0b e9 b2 fe ff ff=
 <0f> 0b e9 aa fc ff ff e8 6f 96 58 00 66 66 66 66 66 66 2e 0f 1f 84
> > [    5.346526] RSP: 0018:ffffa87d402e7bf8 EFLAGS: 00010286
> > [    5.346529] RAX: 00000000ffffffff RBX: ffffa87d402e7c00 RCX: fffffff=
fba721630
> > [    5.346531] RDX: 0000000000000000 RSI: 0000000000000002 RDI: fffffff=
fba721cc0
> > [    5.346532] RBP: ffff8ba7c72e0028 R08: 0000000000000090 R09: 0000000=
000000070
> > [    5.346534] R10: 0000000000000070 R11: 00000000000000ff R12: ffff8ba=
7c7241f88
> > [    5.346536] R13: ffff8ba7c6fff814 R14: ffff8ba7c7241f80 R15: 0000000=
000000000
> > [    5.346537] FS:  0000000000000000(0000) GS:ffff8baf1e840000(0000) kn=
lGS:0000000000000000
> > [    5.346540] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    5.346541] CR2: 0000000000000000 CR3: 0000000056228000 CR4: 0000000=
0003506f0
> > [    5.346543] Call Trace:
> > [    5.346546]  <TASK>
> > [    5.346548]  ? __warn+0xa7/0x140
> > [    5.346551]  ? iwl_op_mode_mvm_start+0x995/0x9b0
> > [    5.346554]  ? report_bug+0xe8/0x180
> > [    5.346557]  ? handle_bug+0x3d/0x90
> > [    5.346560]  ? exc_invalid_op+0x1a/0x60
> > [    5.346562]  ? asm_exc_invalid_op+0x1a/0x20
> > [    5.346566]  ? iwl_op_mode_mvm_start+0x995/0x9b0
> > [    5.346568]  ? iwl_op_mode_mvm_start+0x63e/0x9b0
> > [    5.346571]  _iwl_op_mode_start+0x4e/0xa0
> > [    5.346575]  iwl_req_fw_callback+0x2501/0x2610
> > [    5.346579]  ? srso_return_thunk+0x5/0x5f
> > [    5.346582]  ? __switch_to+0x80/0x480
> > [    5.346586]  request_firmware_work_func+0x62/0xa0
> > [    5.346589]  process_scheduled_works+0x263/0x3d0
> > [    5.346593]  worker_thread+0x222/0x300
> > [    5.346595]  ? __cfi_worker_thread+0x10/0x10
> > [    5.346598]  kthread+0xf4/0x110
> > [    5.346602]  ? __cfi_kthread+0x10/0x10
> > [    5.346604]  ret_from_fork+0x43/0x50
> > [    5.346608]  ? __cfi_kthread+0x10/0x10
> > [    5.346610]  ret_from_fork_asm+0x1b/0x30
> > [    5.346614]  </TASK>
> > [    5.346615] ---[ end trace 0000000000000000 ]---
> > [    5.346617] iwlwifi 0000:04:00.0: Detected Intel(R) Dual Band Wirele=
ss AC 8265, REV=3D0x230
