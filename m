Return-Path: <linux-wireless+bounces-12102-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B98B961AB4
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 01:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE1FFB22B0A
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 23:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A961D4606;
	Tue, 27 Aug 2024 23:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fireburn-co-uk.20230601.gappssmtp.com header.i=@fireburn-co-uk.20230601.gappssmtp.com header.b="JNKlLJRG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC061D45E1
	for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 23:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724801953; cv=none; b=cBiVHfuot2x+zsZtDHaQtZpRT9o6y/Jjf+CtPPwmVbz8PmA1NcTdw1ctIrx++IevUr0ZwCGjcJr0yGrOx4/+grIV1KVFiQyg/kfoU2RUJSfTvvuPRhoyumb6V0uNxBm4p985ZsinjOdWfGmAp0gHiVL4HXuv+f3fqlFTxcBo2tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724801953; c=relaxed/simple;
	bh=zqEJPxE3ijVG9PKraeFzWftokBayNOaf4PiGB5yKmUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ejnmHSeE6PduG8DgtjB3AUZbQF1t1Y2QaZA0fSiRjZrSbONsyVaJjqpSJqSnZemhvEqhZFLuNRv157vEsGFrh7PmVfLXczVsZWmiANFuI1u7qz9Og9jfEDfqmjzESDSr+ySpeqrRspqMj1dCE/CGn413Dt9n1UbDnZb71aVPhVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk; spf=none smtp.mailfrom=fireburn.co.uk; dkim=pass (2048-bit key) header.d=fireburn-co-uk.20230601.gappssmtp.com header.i=@fireburn-co-uk.20230601.gappssmtp.com header.b=JNKlLJRG; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fireburn.co.uk
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-6bce380eb96so3358629a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 16:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20230601.gappssmtp.com; s=20230601; t=1724801950; x=1725406750; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T4PisI5k+CfeJZ/d6jf7PylUfwjMDeTeS1VBco4cxQM=;
        b=JNKlLJRG1lwsiXrrOAdn4Y3nHITEHM4rOfbGJHsiBiv7xAxM6J+jy3yWCeNh5tREbD
         01jg8Ih2GHYiHgx0L2xsL0XLNu6mLYqkLrxbn6imUSXMzxC6zImV3lajztgXnXhE7xiG
         eI8Czp+cqOVgpcf5QDL/pCDpct0xFmnXE7G+1omChApDv9SHQRGZ4EMBpU05H2zfNARK
         0RkvYx4SNnVQauDinOo0uAhG7JZX93ky75r/QY55e6CW02/SH/4jrL0LisLTTRUaVkGW
         S5wSY4SKwFpppJa1Lxq1hXlEdMKyfq+RUUoPaKOjvXBT2sv6QQcZfTc64OH5dmAZGBkv
         iIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724801950; x=1725406750;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T4PisI5k+CfeJZ/d6jf7PylUfwjMDeTeS1VBco4cxQM=;
        b=EIU+s+fACpnUTxg7i/346fUCz7LdXZbDIEdxjB4n42TTF9JMfV8ujLwPOvqTGc5Syl
         ulwPOqvfJRQLZH8ASwJ/aCIA+JXRWzlMSIfX3GnVtfCBBFlRaf3poABcG5/KsVJKJhwn
         ygY7PgUTa+3yA3mkqVdfuA1s6nPIMe+xEm6GkiQ//sMvGP22fqg8HWycCE70hrnEPReE
         mP66Op/O2Q7+Q3jbmPnOlfxg//Cx2vPwWZTGRHHTuGqihNnQQ4Ed8djZlKwJmih+ylHA
         AZGTfMuJC7ZKiDIXmK49A2h4PyoeiVsdDLgcgLY4v3mI5azY3BAZ8dP7GQz4Cm2dJtks
         Vjqg==
X-Forwarded-Encrypted: i=1; AJvYcCVu49PJofK3u1wkRnq1SLyeIBZjYp5QDC7Q1KX5cvMKtUrG91aDRXvmGGcsYOle7P+U9EJtuoYwlNqONUaK8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwT10EGj1YHyyST52PsGe23ARKBf2X0N8Xazz5DITmTrlNro83e
	DrJ9CBG3FyMtAQhcK8YuVLNXsTS5yFD/sfG28d8NNCqAOOpAnzgE/xkOgMOnWbixx8TQvTd7oaQ
	te3/re1/ro84cYPao5kve8XwM5+sWh0bG4LBc
X-Google-Smtp-Source: AGHT+IFyOMTxDVvdjsTkUOrXFboZT2ut4g6GrRztFbuilJBl1mNWPskjYUfLKS3f+zopF/YHybvP94Hhn1cqXKMAxVA=
X-Received: by 2002:a17:90b:4c10:b0:2d3:ce76:4af2 with SMTP id
 98e67ed59e1d1-2d8440c80f0mr366881a91.18.1724801950414; Tue, 27 Aug 2024
 16:39:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718234633.12737-1-sean.wang@kernel.org> <0124ff39-7d63-49f8-bacd-3a40ce37ec4d@leemhuis.info>
 <CAHbf0-Hn=ZyYpk7bS1yLK7K3ZpfWKgt3-t=c9Nhdj3Ov3H84mQ@mail.gmail.com>
 <f7197c55d059cc8ddbf6c3def16dc414c5ec0b42.camel@web.de> <CAHbf0-EBHERbxPGakY4-1jTQWqGqua3F0OYZjxcakdemJ5Soqw@mail.gmail.com>
 <51e80bde6e3f3256ecdea2e5260463341e65578e.camel@web.de>
In-Reply-To: <51e80bde6e3f3256ecdea2e5260463341e65578e.camel@web.de>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Wed, 28 Aug 2024 00:38:59 +0100
Message-ID: <CAHbf0-HYi=x11bc-sMJFbZ4cbkdphMYQ_hjzD_wrPvJevVwyYg@mail.gmail.com>
Subject: Re: [PATCH] wifi: mt76: mt7921: fix null pointer access in mt792x_mac_link_bss_remove
To: Bert Karwatzki <spasswolf@web.de>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, sean.wang@kernel.org, nbd@nbd.name, 
	lorenzo.bianconi@redhat.com, sean.wang@mediatek.com, deren.wu@mediatek.com, 
	mingyen.hsieh@mediatek.com, linux-wireless@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

But not the follow on fix which fixes suspend...

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 2e6268cb06c0..a85c19da77e5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1182,7 +1182,7 @@ static void mt7921_ipv6_addr_change(struct
ieee80211_hw *hw,
      struct inet6_dev *idev)
 {
  struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
- struct mt792x_dev *dev = mvif->phy->dev;
+ struct mt792x_dev *dev = mt792x_hw_dev(hw);
  struct inet6_ifaddr *ifa;
  struct in6_addr ns_addrs[IEEE80211_BSS_ARP_ADDR_LIST_LEN];
  struct sk_buff *skb;
@@ -1205,6 +1205,9 @@ static void mt7921_ipv6_addr_change(struct
ieee80211_hw *hw,
  },
  };

+ if (!mvif->phy)
+ return;
+
  read_lock_bh(&idev->lock);
  list_for_each_entry(ifa, &idev->addr_list, if_list) {
  if (ifa->flags & IFA_F_TENTATIVE)

On Tue, 27 Aug 2024 at 22:13, Bert Karwatzki <spasswolf@web.de> wrote:
>
> Am Dienstag, dem 27.08.2024 um 17:30 +0100 schrieb Mike Lothian:
> > Hi
> >
> > This fix hasn't made it upstream yet, has it fallen through the cracks?
> >
> > Cheers
> >
> > Mike
> >
> > On Thu, 1 Aug 2024 at 17:58, Bert Karwatzki <spasswolf@web.de> wrote:
> > >
> > > Am Donnerstag, dem 01.08.2024 um 13:38 +0100 schrieb Mike Lothian:
> > > > I also saw the following after I restarted my router on two machines -
> > > > they both have this fix applied already:
> > > >
> > > > Aug 01 08:59:33 quark kernel: BUG: kernel NULL pointer dereference,
> > > > address: 0000000000000008
> > > > Aug 01 08:59:33 quark kernel: #PF: supervisor read access in kernel mode
> > > > Aug 01 08:59:33 quark kernel: #PF: error_code(0x0000) - not-present page
> > > > Aug 01 08:59:33 quark kernel: PGD 0 P4D 0
> > > > Aug 01 08:59:33 quark kernel: Oops: Oops: 0000 [#1] PREEMPT SMP
> > > > Aug 01 08:59:33 quark kernel: CPU: 13 UID: 0 PID: 468 Comm:
> > > > NetworkManager Not tainted 6.11.0-rc1-tip+ #3200
> > > > 9c927d6f3c59d826d15d8e39c195392d1d16b8a8
> > > > Aug 01 08:59:33 quark kernel: Hardware name: Micro Computer (HK) Tech
> > > > Limited EliteMini Series/HPBSD, BIOS 1.02 03/28/2024
> > > > Aug 01 08:59:33 quark kernel: RIP: 0010:mt7921_ipv6_addr_change
> > > > Aug 01 08:59:33 quark kernel: Code: 41 57 41 56 41 54 53 48 83 e4 f0
> > > > 48 83 ec 50 48 8b 86 70 09 00 00 0f b6 8e 90 04 00 00 4c 8d ba 68 02
> > > > 00 00 49 89 d6 4c 89 ff <48> 8b 58 08 88 4c 24 04 66 c7 44 24 05 00 00
> > > > c6 44 24 07 00 66 c7
> > > > Aug 01 08:59:33 quark kernel: RSP: 0018:ffffc900069373b0 EFLAGS: 00010282
> > > > Aug 01 08:59:33 quark kernel: RAX: 0000000000000000 RBX:
> > > > ffff888106740920 RCX: 0000000000000000
> > > > Aug 01 08:59:33 quark kernel: RDX: ffff888106854800 RSI:
> > > > ffff88810bb35ca0 RDI: ffff888106854a68
> > > > Aug 01 08:59:33 quark kernel: RBP: ffffc90006937420 R08:
> > > > 0000000000000000 R09: ffff888104c98200
> > > > Aug 01 08:59:33 quark kernel: R10: ffffffff7fff0000 R11:
> > > > 0000000000000020 R12: 0000000000000002
> > > > Aug 01 08:59:33 quark kernel: R13: 0000000000000000 R14:
> > > > ffff888106854800 R15: ffff888106854a68
> > > > Aug 01 08:59:33 quark kernel: FS:  00007f4265049400(0000)
> > > > GS:ffff888c2df40000(0000) knlGS:0000000000000000
> > > > Aug 01 08:59:33 quark kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > Aug 01 08:59:33 quark kernel: CR2: 0000000000000008 CR3:
> > > > 0000000117250000 CR4: 0000000000350ef0
> > > > Aug 01 08:59:33 quark kernel: Call Trace:
> > > > Aug 01 08:59:33 quark kernel:  <TASK>
> > > > Aug 01 08:59:33 quark kernel:  ? __die_body+0x66/0xb0
> > > > Aug 01 08:59:33 quark kernel:  ? page_fault_oops+0x39a/0x410
> > > > Aug 01 08:59:33 quark kernel:  ? exc_page_fault+0x59/0xa0
> > > > Aug 01 08:59:33 quark kernel:  ? asm_exc_page_fault+0x22/0x30
> > > > Aug 01 08:59:33 quark kernel:  ? mt7921_ipv6_addr_change
> > > > Aug 01 08:59:33 quark kernel:  ? __try_to_del_timer_sync
> > > > Aug 01 08:59:33 quark kernel:  ieee80211_ifa6_changed+0x68/0x120
> > > > Aug 01 08:59:33 quark kernel:  atomic_notifier_call_chain+0x45/0xc0
> > > > Aug 01 08:59:33 quark kernel:  addrconf_ifdown+0x521/0x7d0
> > > > Aug 01 08:59:33 quark kernel:  addrconf_notify+0x1ed/0x4a0
> > > > Aug 01 08:59:33 quark kernel:  raw_notifier_call_chain+0x45/0xb0
> > > > Aug 01 08:59:33 quark kernel:  __dev_notify_flags+0xf4/0x200
> > > > Aug 01 08:59:33 quark kernel:  dev_change_flags+0x49/0x50
> > > > Aug 01 08:59:33 quark kernel:  do_setlink+0x49b/0x1300
> > > > Aug 01 08:59:33 quark kernel:  ? terminate_walk+0x6b/0x100
> > > > Aug 01 08:59:33 quark kernel:  ? __nla_validate_parse
> > > > Aug 01 08:59:33 quark kernel:  ? filename_lookup+0xc7/0x1b0
> > > > Aug 01 08:59:33 quark kernel:  rtnl_newlink+0xb6a/0xde0
> > > > Aug 01 08:59:33 quark kernel:  ? __wake_up_sync_key+0x51/0x80
> > > > Aug 01 08:59:33 quark kernel:  ? scm_destroy+0xc/0x30
> > > > Aug 01 08:59:33 quark kernel:  ? security_capable+0x38/0x50
> > > > Aug 01 08:59:33 quark kernel:  rtnetlink_rcv_msg+0x2dd/0x330
> > > > Aug 01 08:59:33 quark kernel:  ? select_task_rq_fair
> > > > Aug 01 08:59:33 quark kernel:  ? rtnetlink_bind+0x30/0x30
> > > > Aug 01 08:59:33 quark kernel:  netlink_rcv_skb+0xb5/0xf0
> > > > Aug 01 08:59:33 quark kernel:  netlink_unicast+0x230/0x330
> > > > Aug 01 08:59:33 quark kernel:  netlink_sendmsg+0x3b1/0x460
> > > > Aug 01 08:59:33 quark kernel:  ____sys_sendmsg
> > > > Aug 01 08:59:33 quark kernel:  ? chacha_block_generic+0x6a/0x130
> > > > Aug 01 08:59:33 quark kernel:  ___sys_sendmsg+0x282/0x2a0
> > > > Aug 01 08:59:33 quark kernel:  ? __fget_files+0x95/0xb0
> > > > Aug 01 08:59:33 quark kernel:  __se_sys_sendmsg+0xf4/0x120
> > > > Aug 01 08:59:33 quark kernel:  do_syscall_64+0x7e/0x130
> > > > Aug 01 08:59:33 quark kernel:  ? pollwake+0x52/0x60
> > > > Aug 01 08:59:33 quark kernel:  ? do_task_dead+0x50/0x50
> > > > Aug 01 08:59:33 quark kernel:  ? __wake_up_locked_key+0x48/0x70
> > > > Aug 01 08:59:33 quark kernel:  ? eventfd_write+0x193/0x1b0
> > > > Aug 01 08:59:33 quark kernel:  ? syscall_exit_to_user_mode+0x93/0xc0
> > > > Aug 01 08:59:33 quark kernel:  ? vfs_write+0xfa/0x3d0
> > > > Aug 01 08:59:33 quark kernel:  ? __fget_files+0x95/0xb0
> > > > Aug 01 08:59:33 quark kernel:  ? __fget_files+0x95/0xb0
> > > > Aug 01 08:59:33 quark kernel:  ? ksys_write+0x8f/0xb0
> > > > Aug 01 08:59:33 quark kernel:  ? arch_exit_to_user_mode_prepare+0x11/0x50
> > > > Aug 01 08:59:33 quark kernel:  ? syscall_exit_to_user_mode+0x93/0xc0
> > > > Aug 01 08:59:33 quark kernel:  ? do_syscall_64+0x8a/0x130
> > > > Aug 01 08:59:33 quark kernel:  ? syscall_exit_to_user_mode+0x93/0xc0
> > > > Aug 01 08:59:33 quark kernel:  ? do_syscall_64+0x8a/0x130
> > > > Aug 01 08:59:33 quark kernel:  ? do_syscall_64+0x8a/0x130
> > > > Aug 01 08:59:33 quark kernel:  ? do_syscall_64+0x8a/0x130
> > > > Aug 01 08:59:33 quark kernel:  ? arch_exit_to_user_mode_prepare+0x11/0x50
> > > > Aug 01 08:59:33 quark kernel:  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> > > > Aug 01 08:59:33 quark kernel: RIP: 0033:0x7f4264d31fae
> > > > Aug 01 08:59:33 quark kernel: Code: 20 89 54 24 1c 48 89 74 24 10 89
> > > > 7c 24 08 e8 a9 75 f7 ff 41 89 c0 8b 54 24 1c 48 8b 74 24 10 b8 2e 00
> > > > 00 00 8b 7c 24 08 0f 05 <48> 3d 00 f0 ff ff 77 3a 44 89 c7 48 89 44 24
> > > > 08 e8 fd 75 f7 ff 48
> > > > Aug 01 08:59:33 quark kernel: RSP: 002b:00007ffff4b1afa0 EFLAGS:
> > > > 00000293 ORIG_RAX: 000000000000002e
> > > > Aug 01 08:59:33 quark kernel: RAX: ffffffffffffffda RBX:
> > > > 000055c35260c570 RCX: 00007f4264d31fae
> > > > Aug 01 08:59:33 quark kernel: RDX: 0000000000000000 RSI:
> > > > 00007ffff4b1afe0 RDI: 000000000000000d
> > > > Aug 01 08:59:33 quark kernel: RBP: 00007ffff4b1b050 R08:
> > > > 0000000000000000 R09: 0000000000000000
> > > > Aug 01 08:59:33 quark kernel: R10: 000000000000009d R11:
> > > > 0000000000000293 R12: 0000000000000004
> > > > Aug 01 08:59:33 quark kernel: R13: 0000000000000000 R14:
> > > > 0000000000000000 R15: 0000000000000000
> > > > Aug 01 08:59:33 quark kernel:  </TASK>
> > > > Aug 01 08:59:33 quark kernel: Modules linked in:
> > > > Aug 01 08:59:33 quark kernel: CR2: 0000000000000008
> > > > Aug 01 08:59:33 quark kernel: ---[ end trace 0000000000000000 ]---
> > > > Aug 01 08:59:33 quark kernel: RIP: 0010:mt7921_ipv6_addr_change
> > > > Aug 01 08:59:33 quark kernel: Code: 41 57 41 56 41 54 53 48 83 e4 f0
> > > > 48 83 ec 50 48 8b 86 70 09 00 00 0f b6 8e 90 04 00 00 4c 8d ba 68 02
> > > > 00 00 49 89 d6 4c 89 ff <48> 8b 58 08 88 4c 24 04 66 c7 44 24 05 00 00
> > > > c6 44 24 07 00 66 c7
> > > > Aug 01 08:59:33 quark kernel: RSP: 0018:ffffc900069373b0 EFLAGS: 00010282
> > > > Aug 01 08:59:33 quark kernel: RAX: 0000000000000000 RBX:
> > > > ffff888106740920 RCX: 0000000000000000
> > > > Aug 01 08:59:33 quark kernel: RDX: ffff888106854800 RSI:
> > > > ffff88810bb35ca0 RDI: ffff888106854a68
> > > > Aug 01 08:59:33 quark kernel: RBP: ffffc90006937420 R08:
> > > > 0000000000000000 R09: ffff888104c98200
> > > > Aug 01 08:59:33 quark kernel: R10: ffffffff7fff0000 R11:
> > > > 0000000000000020 R12: 0000000000000002
> > > > Aug 01 08:59:33 quark kernel: R13: 0000000000000000 R14:
> > > > ffff888106854800 R15: ffff888106854a68
> > > > Aug 01 08:59:33 quark kernel: FS:  00007f4265049400(0000)
> > > > GS:ffff888c2df40000(0000) knlGS:0000000000000000
> > > > Aug 01 08:59:33 quark kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > Aug 01 08:59:33 quark kernel: CR2: 0000000000000008 CR3:
> > > > 0000000117250000 CR4: 0000000000350ef0
> > > >
> > > > On Wed, 24 Jul 2024 at 10:36, Linux regression tracking (Thorsten
> > > > Leemhuis) <regressions@leemhuis.info> wrote:
> > > > >
> > > > >
> > > > >
> > > > > On 19.07.24 01:46, sean.wang@kernel.org wrote:
> > > > > > From: Sean Wang <sean.wang@mediatek.com>
> > > > > >
> > > > > > Fix null pointer access in mt792x_mac_link_bss_remove.
> > > > > >
> > > > > > To prevent null pointer access, we should assign the vif to bss_conf in
> > > > > > mt7921_add_interface. This ensures that subsequent operations on the BSS
> > > > > > can properly reference the correct vif.
> > > > > >
> > > > > > [...]
> > > > > > > Fixes: 1541d63c5fe2 ("wifi: mt76: mt7925: add
> > > > > mt7925_mac_link_bss_remove to remove per-link BSS")
> > > > > > Reported-by: Bert Karwatzki <spasswolf@web.de>
> > > > > > Closes: https://lore.kernel.org/linux-wireless/2fee61f8c903d02a900ca3188c3742c7effd102e.camel@web.de/#b
> > > > > > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > > > >
> > > > > TWIMC, Mike (now CCed) ran into the problem and on bugzilla confirmed
> > > > > that this fixes the problem:
> > > > >
> > > > > https://bugzilla.kernel.org/show_bug.cgi?id=219084
> > > > > https://lore.kernel.org/all/CAHbf0-HOS-jdRGvJOBmEgaaox3PDbDSTgnnZkZF9pz37Bmh2iw@mail.gmail.com/
> > > > >
> > > > > Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> > > > > --
> > > > > Everything you wanna know about Linux kernel regression tracking:d
> > > > > https://linux-regtracking.leemhuis.info/about/#tldr
> > > > > If I did something stupid, please tell me, as explained on that page.
> > >
> > > The fix to this issue has been posted here by Felix Fietkau:
> > > > Am Mittwoch, dem 17.07.2024 um 17:25 +0200 schrieb Felix Fietkau:
> > > >
> > > > This change should fix it: https://nbd.name/p/0747f54f
> > > > Please test.
> > > >
> > > > Thanks,
> > > >
> > > > - Felix
> > >
> > > Bert Karwatzki
>
> It's in linux-6.11-rc4 and later:
>
> commit 479ffee68d59c599f8aed8fa2dcc8e13e7bd13c3
> Author: Bert Karwatzki <spasswolf@web.de>
> Date:   Mon Aug 12 12:45:41 2024 +0200
>
>     wifi: mt76: mt7921: fix NULL pointer access in mt7921_ipv6_addr_change
>
>     When disabling wifi mt7921_ipv6_addr_change() is called as a notifier.
>     At this point mvif->phy is already NULL so we cannot use it here.
>
>     Signed-off-by: Bert Karwatzki <spasswolf@web.de>
>     Signed-off-by: Felix Fietkau <nbd@nbd.name>
>     Signed-off-by: Kalle Valo <kvalo@kernel.org>
>     Link: https://patch.msgid.link/20240812104542.80760-1-spasswolf@web.de
>
>
> Bert Karwatzki
>
>

