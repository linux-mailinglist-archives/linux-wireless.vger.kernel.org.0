Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB3048B58E
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jan 2022 19:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344366AbiAKSTD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jan 2022 13:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242138AbiAKSTA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jan 2022 13:19:00 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872C7C06173F;
        Tue, 11 Jan 2022 10:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=acPDER6jF3ztHC8rJCJUZmRxHypUOh4ymE5mvYRNn/8=; b=sArLEDkt5CVNIuIf4JcwUvx+bh
        Jk7/zuuIv66n+Pdaahl4bPVGGazRXHjkpTiwQbL8YJUd6EPc6AsgxKS88ot8TU1Xvjo0eIWeoKVLI
        i9Knukthco7IpPfYl8PT+l1W6WnhZNQIyBzJCSOhGGH9+ByB7Sxty9MMaZX429KsDW1W3uv5T15sH
        KzrFJ5DkLc49E028n3LdWNJFmA5IteWVlhmbncu4a3/dHWhsOKuekFoBK3OHo9nvoR8+dJO73YKAC
        WQe3giCcZyfvvrbHYSLY9wSOgeMPjGVIs8K1aztekkNGaEgNMS26n9W5+wWOHZ4JK0FQX26iMf3tC
        OQYLXgjA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7LjV-00HGMH-3r; Tue, 11 Jan 2022 18:18:57 +0000
Date:   Tue, 11 Jan 2022 10:18:57 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Zekun Shen <bruceshenzk@gmail.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, brendandg@nyu.edu
Subject: Re: [PATCH] ath5k: fix OOB in ath5k_eeprom_read_pcal_info_5111
Message-ID: <Yd3KEZAnOlpudny0@bombadil.infradead.org>
References: <YckvDdj3mtCkDRIt@a-10-27-26-18.dynapool.vpn.nyu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YckvDdj3mtCkDRIt@a-10-27-26-18.dynapool.vpn.nyu.edu>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Dec 26, 2021 at 10:12:13PM -0500, Zekun Shen wrote:
> The bug was found during fuzzing. Stacktrace locates it in
> ath5k_eeprom_convert_pcal_info_5111.
> When none of the curve is selected in the loop, idx can go
> up to AR5K_EEPROM_N_PD_CURVES. The line makes pd out of bound.
> pd = &chinfo[pier].pd_curves[idx];
> 
> There are many OOB writes using pd later in the code. So I
> added a sanity check for idx. Checks for other loops involving
> AR5K_EEPROM_N_PD_CURVES are not needed as the loop index is not
> used outside the loops.
> 
> The patch is NOT tested with real device.
> 
> The following is the fuzzing report
> 
> BUG: KASAN: slab-out-of-bounds in ath5k_eeprom_read_pcal_info_5111+0x126a/0x1390 [ath5k]
> Write of size 1 at addr ffff8880174a4d60 by task modprobe/214
> 
> CPU: 0 PID: 214 Comm: modprobe Not tainted 5.6.0 #1
> Call Trace:
>  dump_stack+0x76/0xa0
>  print_address_description.constprop.0+0x16/0x200
>  ? ath5k_eeprom_read_pcal_info_5111+0x126a/0x1390 [ath5k]
>  ? ath5k_eeprom_read_pcal_info_5111+0x126a/0x1390 [ath5k]
>  __kasan_report.cold+0x37/0x7c
>  ? ath5k_eeprom_read_pcal_info_5111+0x126a/0x1390 [ath5k]
>  kasan_report+0xe/0x20
>  ath5k_eeprom_read_pcal_info_5111+0x126a/0x1390 [ath5k]
>  ? apic_timer_interrupt+0xa/0x20
>  ? ath5k_eeprom_init_11a_pcal_freq+0xbc0/0xbc0 [ath5k]
>  ? ath5k_pci_eeprom_read+0x228/0x3c0 [ath5k]
>  ath5k_eeprom_init+0x2513/0x6290 [ath5k]
>  ? ath5k_eeprom_init_11a_pcal_freq+0xbc0/0xbc0 [ath5k]
>  ? usleep_range+0xb8/0x100
>  ? apic_timer_interrupt+0xa/0x20
>  ? ath5k_eeprom_read_pcal_info_2413+0x2f20/0x2f20 [ath5k]
>  ath5k_hw_init+0xb60/0x1970 [ath5k]
>  ath5k_init_ah+0x6fe/0x2530 [ath5k]
>  ? kasprintf+0xa6/0xe0
>  ? ath5k_stop+0x140/0x140 [ath5k]
>  ? _dev_notice+0xf6/0xf6
>  ? apic_timer_interrupt+0xa/0x20
>  ath5k_pci_probe.cold+0x29a/0x3d6 [ath5k]
>  ? ath5k_pci_eeprom_read+0x3c0/0x3c0 [ath5k]
>  ? mutex_lock+0x89/0xd0
>  ? ath5k_pci_eeprom_read+0x3c0/0x3c0 [ath5k]
>  local_pci_probe+0xd3/0x160
>  pci_device_probe+0x23f/0x3e0
>  ? pci_device_remove+0x280/0x280
>  ? pci_device_remove+0x280/0x280
>  really_probe+0x209/0x5d0
> 
> Reported-by: Brendan Dolan-Gavitt <brendandg@nyu.edu>
> Signed-off-by: Zekun Shen <bruceshenzk@gmail.com>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
