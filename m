Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767A441143E
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Sep 2021 14:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237933AbhITMVu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Sep 2021 08:21:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27475 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237968AbhITMVl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Sep 2021 08:21:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632140414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b1c2zWZO1NcaSx2dsz3YV2QQA3S+k0Mk2SUv8yV9rbU=;
        b=ZOpF7Y5jH7qsmJtcMtdUiVTAAPfjaXLVCwq3aSr9mKQ2uDttLagZybpB2jzHS9piz6w5oI
        NSXqgszoA2mfJQ9ejgsOGwg0CH5A1n3aDBgXjqFWXvAGqknXDst/hFmyJfydCU6XQBsISJ
        a2j6yHUfoDb3V/LbnDZtBhHnsRF8QMo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-qCrVUBnVMRS5nYpfoY9PzA-1; Mon, 20 Sep 2021 08:20:13 -0400
X-MC-Unique: qCrVUBnVMRS5nYpfoY9PzA-1
Received: by mail-qv1-f70.google.com with SMTP id e8-20020a0cf348000000b0037a350958f2so182235040qvm.7
        for <linux-wireless@vger.kernel.org>; Mon, 20 Sep 2021 05:20:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b1c2zWZO1NcaSx2dsz3YV2QQA3S+k0Mk2SUv8yV9rbU=;
        b=tHdXSnXHvRhDnxtBeaP/WNG/rEe+HrKIpeqdd3cLeTZqerK9ZcHlp0NLlc52XdYjfD
         vjnNEl1R91RM5MVru3D68WOqn3gLrHDBFW1NdjzVopnTNGm/a77wW4SOjkIz2YuxPpEf
         QkDt14h0Wl2WU2a2OuM9s0eguLu/tgQi7o3mdSN+dprS5WmxLS26lOKhgn+H2qTZePL5
         FyjWWgDDCR0he/qpY3VG/ovXA711XTG0OTElLmB4r+qL/eXOlBFJrgl5Wwn3D5j0ckf2
         siU2cyroc4hWmyJW4kSl/D+sXbrlemZhZ33TcUe1E3IK4Af5i04ZshFTrBa/0XwsGiE2
         uAzw==
X-Gm-Message-State: AOAM531ayRcXJ7heSjSzvYq2Z4LBE9OmDH1JobxKhhIyS3Qtc2t/Zjqp
        XShYNdhqxRDCyMzuwaGZ8MBvgNjU9MGFNErrHuVD6sBZ38KSsfIGocs/bCFEafuKKEtqbvY1qgj
        WQoq7DDDkC2joZohSB8fR+hlQVhZ/ZNAb2dntzPz62Y8=
X-Received: by 2002:a25:2142:: with SMTP id h63mr31371617ybh.70.1632140412384;
        Mon, 20 Sep 2021 05:20:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZPo3AKHHEpKLTyPNp43woYH9H3DYnWqItCDHiHE0Az1FX49Ntg2bWY9dTj1vtn87OMl6BdVf02wIkcyZdQus=
X-Received: by 2002:a25:2142:: with SMTP id h63mr31371582ybh.70.1632140412044;
 Mon, 20 Sep 2021 05:20:12 -0700 (PDT)
MIME-Version: 1.0
References: <0529e19e583be780ba2488e891c50dcfcf2ce4c1.1632128258.git.lorenzo@kernel.org>
 <e848121b-c0ee-d8e4-8f4b-dc9b64210261@broadcom.com>
In-Reply-To: <e848121b-c0ee-d8e4-8f4b-dc9b64210261@broadcom.com>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Mon, 20 Sep 2021 14:20:00 +0200
Message-ID: <CAJ0CqmW1c0Zs61yF9d3QJevBenB2B9TNWLADFTpH7cBGbjhbgw@mail.gmail.com>
Subject: Re: [PATCH mac80211] mac80211: limit mcs/nss to spec values in ieee80211_parse_tx_radiotap
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>
> On 9/20/2021 11:03 AM, Lorenzo Bianconi wrote:
> > Limit max value for mcs and nss according to specs in order to fix the
> > following warning reported by syzbot:
> >
> > WARNING: CPU: 0 PID: 10717 at include/net/mac80211.h:989 ieee80211_rate_set_vht include/net/mac80211.h:989 [inline]
> > WARNING: CPU: 0 PID: 10717 at include/net/mac80211.h:989 ieee80211_parse_tx_radiotap+0x101e/0x12d0 net/mac80211/tx.c:2244
> > Modules linked in:
> > CPU: 0 PID: 10717 Comm: syz-executor.5 Not tainted 5.14.0-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > RIP: 0010:ieee80211_rate_set_vht include/net/mac80211.h:989 [inline]
> > RIP: 0010:ieee80211_parse_tx_radiotap+0x101e/0x12d0 net/mac80211/tx.c:2244
> > RSP: 0018:ffffc9000186f3e8 EFLAGS: 00010216
> > RAX: 0000000000000618 RBX: ffff88804ef76500 RCX: ffffc900143a5000
> > RDX: 0000000000040000 RSI: ffffffff888f478e RDI: 0000000000000003
> > RBP: 00000000ffffffff R08: 0000000000000000 R09: 0000000000000100
> > R10: ffffffff888f46f9 R11: 0000000000000000 R12: 00000000fffffff8
> > R13: ffff88804ef7653c R14: 0000000000000001 R15: 0000000000000004
> > FS:  00007fbf5718f700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000001b2de23000 CR3: 000000006a671000 CR4: 00000000001506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
> > Call Trace:
> >   ieee80211_monitor_select_queue+0xa6/0x250 net/mac80211/iface.c:740
> >   netdev_core_pick_tx+0x169/0x2e0 net/core/dev.c:4089
> >   __dev_queue_xmit+0x6f9/0x3710 net/core/dev.c:4165
> >   __bpf_tx_skb net/core/filter.c:2114 [inline]
> >   __bpf_redirect_no_mac net/core/filter.c:2139 [inline]
> >   __bpf_redirect+0x5ba/0xd20 net/core/filter.c:2162
> >   ____bpf_clone_redirect net/core/filter.c:2429 [inline]
> >   bpf_clone_redirect+0x2ae/0x420 net/core/filter.c:2401
> >   bpf_prog_eeb6f53a69e5c6a2+0x59/0x234
> >   bpf_dispatcher_nop_func include/linux/bpf.h:717 [inline]
> >   __bpf_prog_run include/linux/filter.h:624 [inline]
> >   bpf_prog_run include/linux/filter.h:631 [inline]
> >   bpf_test_run+0x381/0xa30 net/bpf/test_run.c:119
> >   bpf_prog_test_run_skb+0xb84/0x1ee0 net/bpf/test_run.c:663
> >   bpf_prog_test_run kernel/bpf/syscall.c:3307 [inline]
> >   __sys_bpf+0x2137/0x5df0 kernel/bpf/syscall.c:4605
> >   __do_sys_bpf kernel/bpf/syscall.c:4691 [inline]
> >   __se_sys_bpf kernel/bpf/syscall.c:4689 [inline]
> >   __x64_sys_bpf+0x75/0xb0 kernel/bpf/syscall.c:4689
> >   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >   entry_SYSCALL_64_after_hwframe+0x44/0xae
> > RIP: 0033:0x4665f9
> >
> > Reported-by: syzbot+0196ac871673f0c20f68@syzkaller.appspotmail.com
> > Fixes: 646e76bb5daf4 ("mac80211: parse VHT info in injected frames")
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >   net/mac80211/tx.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> > index 2d1193ed3eb5..d81a9409fd0e 100644
> > --- a/net/mac80211/tx.c
> > +++ b/net/mac80211/tx.c
> > @@ -2209,7 +2209,11 @@ bool ieee80211_parse_tx_radiotap(struct sk_buff *skb,
> >                       }
> >
> >                       vht_mcs = iterator.this_arg[4] >> 4;
> > +                     if (vht_mcs > 9)
> > +                             vht_mcs = 0;
>
> Some devices can use higher mcs values so maybe we may want to allow
> higher values(?). See cfg80211_calculate_bitrate_vht() [1].

Hi Arend,

AFAIK mcs10 and mcs11 are not part of 802.11ac standard but I am fine
allowing them since they are already managed in the code.
@Johannes: Do you agree?

Regards,
Lorenzo

>
> >                       vht_nss = iterator.this_arg[4] & 0xF;
> > +                     if (!vht_nss || vht_nss > 8)
> > +                             vht_nss = 1;
> >                       break;
> >
> >               /*
> >
>
> Regards,
> Arend
>
> [1] https://elixir.bootlin.com/linux/latest/source/net/wireless/util.c#L1250
>
> --
> This electronic communication and the information and any files transmitted
> with it, or attached to it, are confidential and are intended solely for
> the use of the individual or entity to whom it is addressed and may contain
> information that is confidential, legally privileged, protected by privacy
> laws, or otherwise restricted from disclosure to anyone else. If you are
> not the intended recipient or the person responsible for delivering the
> e-mail to the intended recipient, you are hereby notified that any use,
> copying, distributing, dissemination, forwarding, printing, or copying of
> this e-mail is strictly prohibited. If you received this e-mail in error,
> please return the e-mail to the sender, delete it from your computer, and
> destroy any printed copy of it.

