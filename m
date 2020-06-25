Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D774120A6A9
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2020 22:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436619AbgFYUTD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Jun 2020 16:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436566AbgFYUTB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Jun 2020 16:19:01 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CD6C08C5C1
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2020 13:19:01 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l63so3822993pge.12
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2020 13:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=offblast-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=IXd3a0GoahSIkaKnK+/JSI4bBSq3rEjg/9+EUfGKJKE=;
        b=V65Jv7PQhdOyXoAaYhPw3r/1T9gIPgHn/RhSLsEsFvSkbg9mVWegXvEKKlzjVGZ9PA
         lB7oyfh07TKZyBkmesv8hGw7yhDABt3cZVA2j4Wf5dyFvGudX/r8D7FZeklhG2SiHuep
         mvobWb1C+3KRnsM1X/UaRl50OZnVf5+nlPwVoR7swgGKmw+PtSDWtnpaZSjg3d4Xa+yP
         fu2nOCV1g2NJ7pr27xhT60w3A/GqSsFfYW5WfQXGVSV9c5degf7D+2fjL6Pf0c2xG/Wm
         /pOpdJEkLF6LdourjgcxTl0I7wyswViMLgsiiW/L9IqsCHEfV/AVLB8Fvc9DW831Q423
         vNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=IXd3a0GoahSIkaKnK+/JSI4bBSq3rEjg/9+EUfGKJKE=;
        b=KqOniLEeb6SjxauwemU6u3fwQ5JXE5gcuEMQzD4RbfaJOiSOu9nDstULFdcy6K1vQf
         lDC1ITD9kQynXFaHQ5Uo67KhEyJHN60zE5qAD05aIqtGMY1vgkZxWMtsjBJIldldbnUg
         kuUkFQEE5lIbRtyXjB7IYj/A/DhVH/gzNEsZYpKjLIPF7VOGeTJjxbnb9yOcfWgpichh
         VqQ2hrHoTlmoTxHgA97zByov+GJauNJHdoSMbk6DUc02IaI87S0Yt3n3Ob8K3IYjZpZu
         csTqtN1eGKQWoEXmSZ4NRbjqbHbh5MN0WrxjXyBLD+NQVRIiiEVFuNhL+X0ybzE41GXl
         wLsg==
X-Gm-Message-State: AOAM531KArD6p+vYTAa+hSKAd4A+8v5qto1ZNwgrSgdZzkTA+IZiYNmR
        cFsai4InzJaVmEk6fApR3tddoZEUJ7qxvw==
X-Google-Smtp-Source: ABdhPJwsWLFHtLFsq8mDQ+2sXGrWygGISqaszrTKrKexK5b1x6scWfDb9R6ALAsqqF8FG58UIzDVmg==
X-Received: by 2002:aa7:9e89:: with SMTP id p9mr2606801pfq.110.1593116340680;
        Thu, 25 Jun 2020 13:19:00 -0700 (PDT)
Received: from wololo.home.arpa ([2601:646:100:8cb:2c6d:f3ff:fe32:a632])
        by smtp.gmail.com with ESMTPSA id j8sm9036024pji.3.2020.06.25.13.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 13:18:59 -0700 (PDT)
Date:   Thu, 25 Jun 2020 13:18:57 -0700
From:   Nick Owens <mischief@offblast.org>
To:     linux-wireless@vger.kernel.org
Cc:     Yan-Hsuan Chuang <yhchuang@realtek.com>
Subject: [PATCH] rtw88: fix skb_under_panic in tx path
Message-ID: <20200625201857.almm27xgzburyxxu@wololo.home.arpa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
User-Agent: NeoMutt/20180716
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

hello :)

this change fixes a reliable crash on my thinkpad A485.

please note i have no prior experience doing kernel development or
sending patches, and i'm not sure if this is a correct approach.

--

=46rom aa589182d30a0f99e1b3201ed4f3830e8af71dac Mon Sep 17 00:00:00 2001
=46rom: Nick Owens <mischief@offblast.org>
Date: Thu, 25 Jun 2020 12:55:41 -0700
Subject: [PATCH] rtw88: fix skb_under_panic in tx path

fixes the following panic on my thinkpad A485

Oops#1 Part3
<0>[ 3743.881656] skbuff: skb_under_panic: text:000000005f69fd98 len:208 pu=
t:48 head:000000009e2719e8 data:00000000bd3795e0 tail:0xc2 end:0x2c0 dev:wl=
p2s0
<4>[ 3743.881675] ------------[ cut here ]------------
<2>[ 3743.881677] kernel BUG at net/core/skbuff.c:109!
<4>[ 3743.881688] invalid opcode: 0000 [#1] SMP NOPTI
<4>[ 3743.881693] CPU: 7 PID: 665 Comm: irq/85-rtwpci Tainted: G           =
 E     5.7.5 #31
<4>[ 3743.881695] Hardware name: LENOVO 20MU000TUS/20MU000TUS, BIOS R0WET56=
W (1.24 ) 06/28/2019
<4>[ 3743.881703] RIP: 0010:skb_panic+0x48/0x4a
<4>[ 3743.881706] Code: 4f 70 50 8b 87 bc 00 00 00 50 8b 87 b8 00 00 00 50 =
ff b7 c8 00 00 00 4c 8b 8f c0 00 00 00 48 c7 c7 68 14 51 bd e8 d5 22 ab ff =
<0f> 0b 48 8b 14 24 48 c7 c1 00 c7 2c bd e8 a6 ff ff ff 48 c7 c6 40
<4>[ 3743.881708] RSP: 0018:ffffb354002fce00 EFLAGS: 00010246
<4>[ 3743.881711] RAX: 0000000000000088 RBX: ffff954377fe1e80 RCX: 00000000=
00000000
<4>[ 3743.881713] RDX: 0000000000000000 RSI: ffff95437ffd8968 RDI: ffff9543=
7ffd8968
<4>[ 3743.881714] RBP: ffff954362d7d000 R08: 0000000000000485 R09: 00000000=
00000097
<4>[ 3743.881716] R10: 0000000000000000 R11: ffffb354002fccb0 R12: 00000000=
00000030
<4>[ 3743.881717] R13: 0000000000000001 R14: ffffb354002fcf08 R15: ffffffff=
c163aba0
<4>[ 3743.881720] FS:  0000000000000000(0000) GS:ffff95437ffc0000(0000) knl=
GS:0000000000000000
<4>[ 3743.881721] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[ 3743.881723] CR2: 00007f63e45e8cb0 CR3: 00000003c7fb0000 CR4: 00000000=
003406e0
<4>[ 3743.881724] Call Trace:
<4>[ 3743.881728]  <IRQ>
<4>[ 3743.881733]  skb_push.cold.98+0x10/0x10
<4>[ 3743.881741]  rtw_pci_tx_write_data+0xb1/0x4e0 [rtwpci]
<4>[ 3743.881746]  rtw_pci_tx_write+0x59/0xe7 [rtwpci]
Panic#2 Part3
<4>[ 3743.881755]  rtw_tx_tasklet+0xfd/0x1f0 [rtw88]
<4>[ 3743.881763]  tasklet_action_common.isra.20+0x4e/0xf0
<4>[ 3743.881769]  __do_softirq+0xd9/0x2d9
<4>[ 3743.881773]  do_softirq_own_stack+0x2a/0x40
<4>[ 3743.881775]  </IRQ>
<4>[ 3743.881778]  do_softirq.part.18+0x2b/0x30
<4>[ 3743.881780]  __local_bh_enable_ip+0x4b/0x50
<4>[ 3743.881784]  rtw_pci_interrupt_threadfn+0x154/0x230 [rtwpci]
<4>[ 3743.881789]  ? irq_forced_thread_fn+0x70/0x70
<4>[ 3743.881791]  irq_thread_fn+0x1f/0x50
<4>[ 3743.881794]  irq_thread+0xe7/0x160
<4>[ 3743.881797]  ? wake_threads_waitq+0x30/0x30
<4>[ 3743.881800]  ? irq_thread_check_affinity+0x80/0x80
<4>[ 3743.881804]  kthread+0x112/0x130
<4>[ 3743.881807]  ? kthread_park+0x80/0x80
<4>[ 3743.881810]  ret_from_fork+0x22/0x40
<4>[ 3743.881813] Modules linked in: ctr(E) ccm(E) xt_MASQUERADE(E) nf_conn=
track_netlink(E) xfrm_user(E) xfrm_algo(E) nft_counter(E) nft_chain_nat(E) =
xt_addrtype(E) nft_compat(E) nf_tables(E) nfnetlink(E) xt_conntrack(E) nf_n=
at(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) br_netfilter(E) b=
ridge(E) stp(E) llc(E) overlay(E) cmac(E) bnep(E) nls_ascii(E) nls_cp437(E)=
 vfat(E) snd_hda_codec_realtek(E) fat(E) btusb(E) btrtl(E) snd_hda_codec_ge=
neric(E) btbcm(E) rtwpci(E) btintel(E) uvcvideo(E) snd_hda_codec_hdmi(E) bl=
uetooth(E) rtw88(E) videobuf2_vmalloc(E) edac_mce_amd(E) snd_hda_intel(E) v=
ideobuf2_memops(E) snd_intel_dspcfg(E) videobuf2_v4l2(E) mac80211(E) videob=
uf2_common(E) snd_hda_codec(E) drbg(E) efi_pstore(E) kvm_amd(E) ansi_cprng(=
E) joydev(E) snd_hda_core(E) kvm(E) snd_hwdep(E) videodev(E) ecdh_generic(E=
) snd_pcm(E) irqbypass(E) pcspkr(E) serio_raw(E) efivars(E) ftdi_sio(E) wmi=
_bmof(E) k10temp(E) mc(E) sp5100_tco(E) ecc(E) tpm_crb(E) usbserial(E) snd_=
timer(E) ccp(E) cfg80211(E)

Signed-off-by: Nick Owens <mischief@offblast.org>
Cc: stable@vger.kernel.org
---
 drivers/net/wireless/realtek/rtw88/pci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireles=
s/realtek/rtw88/pci.c
index d735f3127fe8..21b3b268cb25 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -741,6 +741,12 @@ static int rtw_pci_tx_write_data(struct rtw_dev *rtwde=
v,
 	else if (!avail_desc(ring->r.wp, ring->r.rp, ring->r.len))
 		return -ENOSPC;
=20
+	if (skb_headroom(skb) < chip->tx_pkt_desc_sz &&
+	    pskb_expand_head(skb, chip->tx_pkt_desc_sz - skb_headroom(skb), 0, GF=
P_ATOMIC)) {
+		dev_err(rtwdev->dev, "no headroom available");
+		return -ENOMEM;
+	}
+
 	pkt_desc =3D skb_push(skb, chip->tx_pkt_desc_sz);
 	memset(pkt_desc, 0, tx_pkt_desc_sz);
 	pkt_info->qsel =3D rtw_pci_get_tx_qsel(skb, queue);
--=20
2.20.1

