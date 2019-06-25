Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0CED52266
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 07:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfFYFBW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 01:01:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60654 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727542AbfFYFBW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 01:01:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 44874608CE; Tue, 25 Jun 2019 05:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561438881;
        bh=kiWBs0u7DmFS05pJ+9N7PFjE8giSR59xiCGnTL4NwpE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=OzCRrxGmY5lTQ4rVbH0tkTQvj7mosB3MmgC0OsCukmoNXykAalzwUeSEHPHV2NqvS
         Kbd9Syy0RHZpBSPekxMz0wr/xOiDeLR52zsewHzgOE4UEx416uYG1zynWQPMReKrji
         GbK9aDKMGWD0tEp0PePBQSOxmOPHNOxr3MohwXIM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AFBBD606DC;
        Tue, 25 Jun 2019 05:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561438880;
        bh=kiWBs0u7DmFS05pJ+9N7PFjE8giSR59xiCGnTL4NwpE=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=LHL2eHSXDRZKRK7eCYotEmG46uvCjiOL0aZN3/paHYgE7rOYG4VsAFD5VBFwIx9vo
         6aZlof0aY1KRd3lF7+9mfSW5u0CI7Re/gDBOr7XTfJ8cJIFD8AdSXZSpGWGIc9hvfZ
         XajR9czy5U6ZuUp9gmgpZx6DjwOZX7vFgIKKuZOU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AFBBD606DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/2] mt7601u: do not schedule rx_tasklet when the
 device has been disconnected
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <bfb533c51126ee82843e3d525e55ec5b08adb860.1559906499.git.lorenzo@kernel.org>
References: <bfb533c51126ee82843e3d525e55ec5b08adb860.1559906499.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     kubakici@wp.pl, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190625050121.44874608CE@smtp.codeaurora.org>
Date:   Tue, 25 Jun 2019 05:01:21 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Do not schedule rx_tasklet when the usb dongle is disconnected.
> Moreover do not grub rx_lock in mt7601u_kill_rx since usb_poison_urb
> can run concurrently with urb completion and we can unlink urbs from rx
> ring in any order.
> This patch fixes the common kernel warning reported when
> the device is removed.
> 
> [   24.921354] usb 3-14: USB disconnect, device number 7
> [   24.921593] ------------[ cut here ]------------
> [   24.921594] RX urb mismatch
> [   24.921675] WARNING: CPU: 4 PID: 163 at drivers/net/wireless/mediatek/mt7601u/dma.c:200 mt7601u_complete_rx+0xcb/0xd0 [mt7601u]
> [   24.921769] CPU: 4 PID: 163 Comm: kworker/4:2 Tainted: G           OE     4.19.31-041931-generic #201903231635
> [   24.921770] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./Z97 Extreme4, BIOS P1.30 05/23/2014
> [   24.921782] Workqueue: usb_hub_wq hub_event
> [   24.921797] RIP: 0010:mt7601u_complete_rx+0xcb/0xd0 [mt7601u]
> [   24.921800] RSP: 0018:ffff9bd9cfd03d08 EFLAGS: 00010086
> [   24.921802] RAX: 0000000000000000 RBX: ffff9bd9bf043540 RCX: 0000000000000006
> [   24.921803] RDX: 0000000000000007 RSI: 0000000000000096 RDI: ffff9bd9cfd16420
> [   24.921804] RBP: ffff9bd9cfd03d28 R08: 0000000000000002 R09: 00000000000003a8
> [   24.921805] R10: 0000002f485fca34 R11: 0000000000000000 R12: ffff9bd9bf043c1c
> [   24.921806] R13: ffff9bd9c62fa3c0 R14: 0000000000000082 R15: 0000000000000000
> [   24.921807] FS:  0000000000000000(0000) GS:ffff9bd9cfd00000(0000) knlGS:0000000000000000
> [   24.921808] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   24.921808] CR2: 00007fb2648b0000 CR3: 0000000142c0a004 CR4: 00000000001606e0
> [   24.921809] Call Trace:
> [   24.921812]  <IRQ>
> [   24.921819]  __usb_hcd_giveback_urb+0x8b/0x140
> [   24.921821]  usb_hcd_giveback_urb+0xca/0xe0
> [   24.921828]  xhci_giveback_urb_in_irq.isra.42+0x82/0xf0
> [   24.921834]  handle_cmd_completion+0xe02/0x10d0
> [   24.921837]  xhci_irq+0x274/0x4a0
> [   24.921838]  xhci_msi_irq+0x11/0x20
> [   24.921851]  __handle_irq_event_percpu+0x44/0x190
> [   24.921856]  handle_irq_event_percpu+0x32/0x80
> [   24.921861]  handle_irq_event+0x3b/0x5a
> [   24.921867]  handle_edge_irq+0x80/0x190
> [   24.921874]  handle_irq+0x20/0x30
> [   24.921889]  do_IRQ+0x4e/0xe0
> [   24.921891]  common_interrupt+0xf/0xf
> [   24.921892]  </IRQ>
> [   24.921900] RIP: 0010:usb_hcd_flush_endpoint+0x78/0x180
> [   24.921354] usb 3-14: USB disconnect, device number 7
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

2 patches applied to wireless-drivers-next.git, thanks.

4079e8ccabc3 mt7601u: do not schedule rx_tasklet when the device has been disconnected
23377c200b2e mt7601u: fix possible memory leak when the device is disconnected

-- 
https://patchwork.kernel.org/patch/10981545/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

