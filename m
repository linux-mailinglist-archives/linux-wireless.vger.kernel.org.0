Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4378710927E
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2019 18:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbfKYRDC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Nov 2019 12:03:02 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60329 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728889AbfKYRDB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Nov 2019 12:03:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574701381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+wgtIZ12esqDhl79Qty/M+dH0ookIsm0zzkc5k+dN0k=;
        b=WBJ4K88CWQJKUA6yZnZwj4LjdzcWKp9EfH27wF5TOfBZB0l2x556Tbi/RWKIjbDmPPqoSE
        Sdrlww9CFNEIqIaRnYWxovg/uVg2LKuiAVZ7eUCDwCC8bI7aVsC+QKI6n07IVQ5n8Q6oAD
        mkLfPTcLmOGc/rPljC3UmdzXQByk8ME=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-bEJnLMXvODW6yoWuPC2DZg-1; Mon, 25 Nov 2019 12:02:57 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0B77107ACFB;
        Mon, 25 Nov 2019 17:02:56 +0000 (UTC)
Received: from localhost (ovpn-204-116.brq.redhat.com [10.40.204.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A7EC19C69;
        Mon, 25 Nov 2019 17:02:53 +0000 (UTC)
Date:   Mon, 25 Nov 2019 18:02:53 +0100
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH v8 6/6] mt76: mt76x02: add channel switch support for usb
 interfaces
Message-ID: <20191125170252.GC14273@redhat.com>
References: <20191121180001.22451-1-markus.theil@tu-ilmenau.de>
 <20191121180001.22451-7-markus.theil@tu-ilmenau.de>
 <20191125130449.GC28102@redhat.com>
 <76778e31-5757-6e8b-eecb-b1b3a23acc6d@tu-ilmenau.de>
 <7de34f93-ab33-400b-6b5b-d126bab43b97@tu-ilmenau.de>
MIME-Version: 1.0
In-Reply-To: <7de34f93-ab33-400b-6b5b-d126bab43b97@tu-ilmenau.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: bEJnLMXvODW6yoWuPC2DZg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Nov 25, 2019 at 04:32:42PM +0100, Markus Theil wrote:
>=20
> On 11/25/19 3:51 PM, Markus Theil wrote:
> > On 11/25/19 2:04 PM, Stanislaw Gruszka wrote:
> >> On Thu, Nov 21, 2019 at 07:00:01PM +0100, Markus Theil wrote:
> >>> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c b/=
drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
> >>> index 90c024f12302..b9bd6bfb2a9d 100644
> >>> --- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
> >>> +++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
> >>> @@ -210,6 +210,12 @@ static void mt76x02u_pre_tbtt_work(struct work_s=
truct *work)
> >>> =20
> >>>  =09mt76x02_mac_set_beacon_prepare(dev);
> >>> =20
> >>> +=09mt76_csa_check(&dev->mt76);
> >>> +=09if (dev->mt76.csa_complete) {
> >>> +=09=09mt76_csa_finish(&dev->mt76);
> >>> +=09=09goto out;
> >>> +=09}
> >> mmio counterpart setup beacons on CSA, but do not sent buffered
> >> PS frames. Perhaps here we should do the same. However not sending
> >> beacons on one TBTT looks ok to me as well.
> >>
> >> Stanislaw
> >>
> > If I change the order of beacon iteration and csa check, the following =
warning in mac80211 gets triggered:
> >
> > =09/* the counter should never reach 0 */
> > =09WARN_ON_ONCE(!beacon->csa_current_counter);
> >
> > Dmesg output looks like this:
> >
> > [  153.829617] ------------[ cut here ]------------
> > [  153.829752] WARNING: CPU: 0 PID: 224 at net/mac80211/tx.c:4318 __iee=
e80211_csa_update_counter.isra.0.part.0+0x5/0x10 [mac80211]
> > [  153.829756] Modules linked in: ccm bridge stp llc nft_masq nft_chain=
_nat nf_nat nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c nf_tables_set nf_tabl=
es nfnetlink ath10k_pci amd64_edac_mod mt76x2u edac_mce_amd mt76x2_common a=
th10k_core mt76x02_usb kvm_amd mt76_usb mt76x02_lib mt76 kvm ath mac80211 i=
rqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel cfg80211 pcengin=
es_apuv2 gpio_keys_polled aesni_intel input_polldev crypto_simd gpio_amd_fc=
h cryptd glue_helper igb pcspkr k10temp fam15h_power rfkill sp5100_tco i2c_=
piix4 libarc4 ccp i2c_algo_bit dca rng_core uio_pdrv_genirq uio leds_gpio e=
vdev mac_hid pinctrl_amd coreboot_table acpi_cpufreq ip_tables x_tables ext=
4 crc32c_generic crc16 mbcache jbd2 sd_mod ahci sdhci_pci libahci cqhci lib=
ata sdhci crc32c_intel xhci_pci ehci_pci mmc_core xhci_hcd scsi_mod ehci_hc=
d gpio_keys
> > [  153.829948] CPU: 0 PID: 224 Comm: kworker/0:1H Not tainted 5.4.0-rc7=
-1-01110-g19b7e21c55c8 #32
> > [  153.829952] Hardware name: PC Engines apu2/apu2, BIOS v4.10.0.3 11/0=
7/2019
> > [  153.829966] Workqueue: events_highpri mt76x02u_pre_tbtt_work [mt76x0=
2_usb]
> > [  153.830067] RIP: 0010:__ieee80211_csa_update_counter.isra.0.part.0+0=
x5/0x10 [mac80211]
> > [  153.830077] Code: 4c 89 4a 18 c3 48 8b 47 10 4c 89 4f 10 48 89 4e 18=
 48 89 46 20 4c 89 08 eb a1 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00=
 <0f> 0b c3 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41 54 53 48 89 fb
> > [  153.830082] RSP: 0018:ffffbde8803d7c80 EFLAGS: 00010246
> > [  153.830089] RAX: 0000000000000003 RBX: ffffbde8803d7d20 RCX: ffffa3b=
01df8f658
> > [  153.830093] RDX: ffffbde8803d7d20 RSI: ffffa3b02901d450 RDI: ffffbde=
8803d7ce0
> > [  153.830097] RBP: ffffa3b0267007a0 R08: ffffffff8d011040 R09: 0000000=
000000000
> > [  153.830101] R10: ffffa3b029908098 R11: ffffa3b02ab2ab38 R12: 0000000=
000000000
> > [  153.830105] R13: ffffa3b02901d450 R14: 0000000000000000 R15: ffffa3b=
0284eae00
> > [  153.830111] FS:  0000000000000000(0000) GS:ffffa3b02aa00000(0000) kn=
lGS:0000000000000000
> > [  153.830115] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  153.830119] CR2: 00007fbb6b5c9f30 CR3: 0000000126ee2000 CR4: 0000000=
0000406f0
> > [  153.830124] Call Trace:
> > [  153.830203]  __ieee80211_beacon_get+0x4c2/0x4d0 [mac80211]
> > [  153.830312]  ieee80211_beacon_get_tim+0x41/0x150 [mac80211]
> > [  153.830336]  mt76x02_update_beacon_iter+0x2d/0x40 [mt76x02_lib]
> > [  153.830352]  ? mt76x02_add_buffered_bc+0x80/0x80 [mt76x02_lib]
> > [  153.830420]  __iterate_interfaces+0x74/0x110 [mac80211]
> > [  153.830469]  ? mt76x02_add_buffered_bc+0x80/0x80 [mt76x02_lib]
> > [  153.830566]  ieee80211_iterate_interfaces+0x3a/0x50 [mac80211]
> > [  153.830580]  mt76x02u_pre_tbtt_work+0x96/0x220 [mt76x02_usb]
> > [  153.830600]  process_one_work+0x1e2/0x3b0
> > [  153.830610]  worker_thread+0x4a/0x3d0
> > [  153.830623]  kthread+0xfb/0x130
> > [  153.830631]  ? process_one_work+0x3b0/0x3b0
> > [  153.830639]  ? kthread_park+0x90/0x90
> > [  153.830650]  ret_from_fork+0x22/0x40
> > [  153.830665] ---[ end trace 7a658e5cbfd0f9d1 ]---
> >
> > Markus
> >
> In my current local changes I've decoupled checking csa_check and mt76_cs=
a_finish, like it is in the mmio case. As usb has no tbtt interrupt,
> I just schedule a delayed work around the estimated beacon transmission t=
ime and finish csa there. I'll send another series, if this works.

I would prefer not to add yet another delayed work. Does the warning
still happen if you arrange code like this?

        mt76x02_mac_set_beacon_prepare(dev);

        ieee80211_iterate_active_interfaces(mt76_hw(dev),
                IEEE80211_IFACE_ITER_RESUME_ALL,
                mt76x02_update_beacon_iter, dev);

        mt76_csa_check(&dev->mt76);
        if (dev->mt76.csa_complete) {
                mt76_csa_finish(&dev->mt76);
                goto out;
        }

        nbeacons =3D hweight8(dev->mt76.beacon_mask);
        mt76x02_enqueue_buffered_bc(dev, &data, N_BCN_SLOTS - nbeacons);
=09...
out:
        mt76x02_mac_set_beacon_finish(dev);
        mt76x02u_restart_pre_tbtt_timer(dev);


