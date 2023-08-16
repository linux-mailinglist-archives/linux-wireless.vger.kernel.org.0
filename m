Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6513477DB24
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Aug 2023 09:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242399AbjHPHa7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Aug 2023 03:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242441AbjHPHaf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Aug 2023 03:30:35 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBD9213A
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 00:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=NNFtxgLoMRBMt3pCEVJ0nAUZ+0ASWVgI3HkHV3v/PEk=;
        t=1692171032; x=1693380632; b=dAoVQ3nr5xLcy084PpD4zMUtpaAqQ7mlxCAETQFS7haWe8n
        7r1v5zbdk3zU23fkyXhogXrCK9t4y1t5MQMFMgnUWw1iGW+A0a7Mvdem6W2QHlUJ4X7AKmg1Mi1t+
        wgK8hTQvqTmLGW+FdqlnohJvC/LlKk3mXlRT3rKeHbVQxVwMQrMquPZ7JGxzsdAATsM/VMWHn50hl
        yrbU3OKB0EJ9bbvAnfM4VV6K+jhDiUN4l3/PCgLgdZvEaZsFsui9nM+y04OppL35dAPW3aBX4/dWS
        2+xbQzv2W8j3i00xDw5XcHINfus73XTrc4bJTK90dGhXEAn/XOnpYGJJ/gEQqQxQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qWAz8-00AZMC-0z;
        Wed, 16 Aug 2023 09:30:30 +0200
Message-ID: <dd3c90b687a933f3b2d467a0e3a2f918c26201f4.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v2 6.1] wifi: cfg80211: fix cqm_config access race
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Max Schulze <max.schulze@online.de>, linux-wireless@vger.kernel.org
Date:   Wed, 16 Aug 2023 09:30:29 +0200
In-Reply-To: <98456a69-d597-505c-6a1b-f33b5f6343e9@online.de>
References: <20230815134247.4b4bd52ea708.I1a1bb102329fc88e4712eaf394cba3025ada0dc7@changeid>
         <20230815153741.cc51cb52a296.I1a1bb102329fc88e4712eaf394cba3025ada0dc7@changeid>
         <98456a69-d597-505c-6a1b-f33b5f6343e9@online.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

This is ... pretty odd?

> h63 kernel: Unable to handle kernel paging request at virtual address fff=
f8061d9850028
> h63 kernel: Mem abort info:
> h63 kernel:   ESR =3D 0x0000000096000004
> h63 kernel:   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> h63 kernel:   SET =3D 0, FnV =3D 0
> h63 kernel:   EA =3D 0, S1PTW =3D 0
> h63 kernel:   FSC =3D 0x04: level 0 translation fault
> h63 kernel: Data abort info:
> h63 kernel:   ISV =3D 0, ISS =3D 0x00000004
> h63 kernel:   CM =3D 0, WnR =3D 0
> h63 kernel: [ffff8061d9850028] address between user and kernel address ra=
nges
> h63 kernel: Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> h63 kernel: Modules linked in: [...]
> h63 kernel: CPU: 3 PID: 493 Comm: Xorg Tainted: G         C 6.1.45-v8-gdc=
69f9d60872 #3
> h63 kernel: Hardware name: Raspberry Pi Compute Module 4 Rev 1.0 (DT)
> h63 kernel: pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
> h63 kernel: pc : dma_resv_add_fence+0x80/0x260

I mean, that's in some other code entirely?

> h63 kernel: Call trace:
> h63 kernel:  dma_resv_add_fence+0x80/0x260
> h63 kernel:  v3d_attach_fences_and_unlock_reservation+0x6c/0x1c0 [v3d]
> h63 kernel:  v3d_submit_cl_ioctl+0x540/0x70c [v3d]
> h63 kernel:  drm_ioctl_kernel+0xcc/0x180 [drm]
> h63 kernel:  drm_ioctl+0x210/0x440 [drm]
> h63 kernel:  __arm64_sys_ioctl+0xb0/0xf4
> h63 kernel:  invoke_syscall+0x50/0x120
> h63 kernel:  el0_svc_common.constprop.0+0x68/0x124
> h63 kernel:  do_el0_svc+0x34/0xd0
> h63 kernel:  el0_svc+0x30/0x94
> h63 kernel:  el0t_64_sync_handler+0xb8/0xbc
> h63 kernel:  el0t_64_sync+0x18c/0x190
> h63 kernel: Code: fa401044 54000061 d4210000 d503201f (f9401678)

Unless my code caused some really bad corruption somewhere, I'm not sure
I see how that would happen?


Were you able to reproduce it multiple times? Maybe we can see a pattern
out of multiple reports.

johannes
