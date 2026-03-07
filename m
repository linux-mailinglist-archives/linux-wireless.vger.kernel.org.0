Return-Path: <linux-wireless+bounces-32706-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qK0WFlh1q2kvdQEAu9opvQ
	(envelope-from <linux-wireless+bounces-32706-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 01:46:16 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B9B22917B
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 01:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16C11303DAEC
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Mar 2026 00:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D6CEED8;
	Sat,  7 Mar 2026 00:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugLuKkaO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E690DF76
	for <linux-wireless@vger.kernel.org>; Sat,  7 Mar 2026 00:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772844373; cv=none; b=r3Mv1MMilV6zuzfLM1gmv+fZcmfZL4/MTzMCcgXmAL7QUY0Quolxd2lbevqiBk9jDlrnc+Bkx9rM7riQVb+jI5Y1LijE+PTMYqz6k6LVRAr1fZs+Egvql696pFb8yJ7woCEzCbFGp2h0BA3W+/fMuERZ+eUezPjZbxiSki/biII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772844373; c=relaxed/simple;
	bh=v/ZPsdekFjG47NT8M+I56PGbX39i713MbgKkCGM/sZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gf5fIfp2hqWYCPlGQnCgc73+SIS+2588B0bGrctSOWGwwybgM7Sfgxj0eYH4OFmVabiP2dQx9N1zUfGyA47zw+py/qHmQoEP0Ezc50dY78GPsC2MkXZsh7HjH0gzhCvyG3dSYO/r5+WuyFc7DF3ONZbpUgKWkC0GgqgJNZQFAi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ugLuKkaO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11627C19422
	for <linux-wireless@vger.kernel.org>; Sat,  7 Mar 2026 00:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772844373;
	bh=v/ZPsdekFjG47NT8M+I56PGbX39i713MbgKkCGM/sZI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ugLuKkaO/ZiP70ONN9oAPL7olhxrHwHKUT1G5nZjpIF9RVg6Tz0lx8oNILuGMAssO
	 9sqNeBF5kmFNSjDBVV1IUgpdCR7i03H2J0SL3O3y6+XJad5r8yuitjbQQ0DMi4V/Gj
	 NYmf5evzX/9cg5WUFcquY7uqz17gXEe6koD60G1FNOaS7VJx0kXpG3jSCPJSfLUtge
	 1WXKvaUmyO+AcdSUEl/iS8LsvXkQT1FYTLn6vwBmVDe+p5ler10UM8QV/4EVRXxpij
	 Ffl4KAqBh56/K8EE+3izuLUQ1/LKXBJjDiNye1HmWYyF2g1roOqEjixJTz4W+McCVL
	 +c987u22QXNCA==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38a3066b68bso39537201fa.3
        for <linux-wireless@vger.kernel.org>; Fri, 06 Mar 2026 16:46:12 -0800 (PST)
X-Gm-Message-State: AOJu0Yz/zG3lKxwwzLaz1/0ntRBv3ljqvdH2o3+iyhiJH44oTs6CcAp7
	vA8YKPoNT3ZN/0LxvI3RJCBUz2hW9WLy9nMVgOZIS+0/PF5l/pPjNNTy7wPL7bNmxcwpaJ+JnCO
	APwbyEjATZHus2AoYRcuIXCUSbEEsR7I=
X-Received: by 2002:a2e:8713:0:b0:389:ef35:fb9e with SMTP id
 38308e7fff4ca-38a40d94bcamr10056641fa.24.1772844371411; Fri, 06 Mar 2026
 16:46:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFktD2eaVpRAJRkaGOj4y-m0woK-sNeCM+h_7A=9GELSce6TcQ@mail.gmail.com>
 <CAGp9LzrTMALkJKrGANTCzeG4KUDGwC1YJc8SRKNRriH3a9bnRQ@mail.gmail.com> <CAFktD2eG+nebKcNbw2imufSOz6MCR-SUXjcUQmDqJabNfwx4sg@mail.gmail.com>
In-Reply-To: <CAFktD2eG+nebKcNbw2imufSOz6MCR-SUXjcUQmDqJabNfwx4sg@mail.gmail.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Fri, 6 Mar 2026 18:46:00 -0600
X-Gmail-Original-Message-ID: <CAGp9Lzp2s675kmTJG+iYgLXS=fjiD-JC6GYjom7i-bcWFDxWoQ@mail.gmail.com>
X-Gm-Features: AaiRm525bNABfOeNAiV8Hh2Y2gDrcESPjzzid372jWqtIntLfhkpyIrN6LZNT4c
Message-ID: <CAGp9Lzp2s675kmTJG+iYgLXS=fjiD-JC6GYjom7i-bcWFDxWoQ@mail.gmail.com>
Subject: Re: [BUG] wifi: mt76: mt7925u: probe with driver mt7925u failed with
 error -110
To: Nick <morrownr@gmail.com>
Cc: linux-wireless <linux-wireless@vger.kernel.org>, Felix Fietkau <nbd@nbd.name>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Deren Wu <deren.wu@mediatek.com>, Leon Yen <leon.yen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B8B9B22917B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-32706-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.956];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi Nick,

Thanks for the detailed report  this is very helpful. I don't  have an
MT7925 USB device to detail look into the issue, but based on the
trace I wrote a small change to try a different MT7925 reset sequence.
please help test.

--- a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
@@ -234,6 +234,36 @@ int mt792xu_dma_init(struct mt792x_dev *dev, bool resu=
me)
 }
 EXPORT_SYMBOL_GPL(mt792xu_dma_init);

+static int mt7925u_wfsys_reset(struct mt792x_dev *dev)
+{
+    u32 val;
+    int i;
+
+#define MT7925_CBTOP_RGU_WF_SUBSYS_RST        0x70028600
+#define MT7925_WFSYS_SW_INIT_DONE_ADDR        0x184c1604
+#define MT7925_WFSYS_SW_INIT_DONE        0x00001d1e
+
+    val =3D mt792xu_uhw_rr(&dev->mt76, MT7925_CBTOP_RGU_WF_SUBSYS_RST);
+    val |=3D MT_CBTOP_RGU_WF_SUBSYS_RST_WF_WHOLE_PATH;
+    mt792xu_uhw_wr(&dev->mt76, MT7925_CBTOP_RGU_WF_SUBSYS_RST, val);
+
+    msleep(20);
+
+    val =3D mt792xu_uhw_rr(&dev->mt76, MT7925_CBTOP_RGU_WF_SUBSYS_RST);
+    val &=3D ~MT_CBTOP_RGU_WF_SUBSYS_RST_WF_WHOLE_PATH;
+    mt792xu_uhw_wr(&dev->mt76, MT7925_CBTOP_RGU_WF_SUBSYS_RST, val);
+
+    for (i =3D 0; i < MT792x_WFSYS_INIT_RETRY_COUNT; i++) {
+        val =3D mt792xu_uhw_rr(&dev->mt76, MT7925_WFSYS_SW_INIT_DONE_ADDR)=
;
+        if (val =3D=3D MT7925_WFSYS_SW_INIT_DONE)
+            return 0;
+
+        msleep(100);
+    }
+
+    return -ETIMEDOUT;
+}
+
 int mt792xu_wfsys_reset(struct mt792x_dev *dev)
 {
     u32 val;
@@ -241,6 +271,9 @@ int mt792xu_wfsys_reset(struct mt792x_dev *dev)

     mt792xu_epctl_rst_opt(dev, false);

+    if (is_mt7925(&dev->mt76))
+        return mt7925u_wfsys_reset(dev);
+
     val =3D mt792xu_uhw_rr(&dev->mt76, MT_CBTOP_RGU_WF_SUBSYS_RST);


On Fri, Mar 6, 2026 at 1:24=E2=80=AFPM Nick <morrownr@gmail.com> wrote:
>
> > > Reference: https://github.com/morrownr/USB-WiFi/issues/688#issuecomme=
nt-3999038526
> > >
> > > The above thread is rather lengthy as we have been working on this
> > > issue since Dec. 25.
> > >
> > > Testing with a Netgear A9000 USB WiFi adapter (mt7925u driver). Kerne=
l
> > > 7.0 rc2 and a x86_64 system. Additional testing with older kernels wa=
s
> > > also performed with the same results.
> > >
> > > Problem description:
> > >
> > > Cold boot shows the adapter coming up and operating normally.
> > >
> > > Removing the adapter from the USB port and replacing it shows the
> > > adapter coming up and operating normally.
> > >
> > > A warm reboot does not provide a WiFi interface and shows the
> > > following in the system log:
> > >
> > > mt7925u 2-3.2:1.0: probe with driver mt7925u failed with error -110
> > >
> > > Using the commands rmmod and modeprobe do not provide a WiFi interfac=
e.
> > >
> > > Thoughts: The problem likely is not the module teardown. The problem
> > > seems to be that the firmware (or the mt7925u driver) leaves the
> > > adapter in a strange state such that a power cycle of the adapter
> > > hardware is needed before the mt7925u driver can properly initialize
> > > it a second time.
> > >
> >
> > Hi Nick,
> >
> > Could you enable debug logs and check whether the driver can still
> > read the correct chip ID after a warm reboot, and at which step the
> > initialization fails before the -110 error? Thanks for continuing to
> > test and gather this useful information.
> >
> >          Sean
>
> Hi Sean,
>
> Github user @exct has performed the testing requested and provides the
> following report:
>
> mt7925u Probe Failure Debug Report
> Adapter: Netgear A9000 (USB ID 0846:9072, MediaTek MT7925)
> Kernel: 6.19.6-2-cachyos
>
> Summary
> The driver can read the correct chip ID after a warm reload. The
> failure occurs before firmware is loaded, inside
> mt792xu_wfsys_reset(), which times out waiting for the WiFi subsystem
> to reinitialize. -ETIMEDOUT (-110) is returned and the probe aborts.
>
> Findings
>
> Question: Chip ID readable after warm reload?
> Answer: Yes =E2=80=94 MT_HW_CHIPID =3D 0x7925, MT_HW_REV =3D 0x8a00
>
> Question: Which step fails?
> Answer: mt792xu_wfsys_reset() =E2=80=94 WFSYS_INIT_DONE never asserted
>
> Question: Does it reach mt792xu_mcu_power_on()?
> Answer: No
>
> Question: Does it reach mt7925_run_firmware()?
> Answer: No
>
> Probe Sequence Trace
>
> mt7925u_probe()
>   =E2=94=9C=E2=94=80 mt76_alloc_device()             OK
>   =E2=94=9C=E2=94=80 __mt76u_init()                  OK
>   =E2=94=9C=E2=94=80 read MT_HW_CHIPID (0x70010200)  =E2=86=92 0x00007925=
  =E2=9C=93
>   =E2=94=9C=E2=94=80 read MT_HW_REV    (0x70010204)  =E2=86=92 0x00008a00=
  =E2=9C=93
>   =E2=94=9C=E2=94=80 read MT_CONN_ON_MISC (0x7c0600f0) =E2=86=92 0x000000=
03  =E2=86=90 FW_N9_RDY is SET
>   =E2=94=9C=E2=94=80 enters mt792xu_wfsys_reset()    =E2=86=90 triggered =
because FW_N9_RDY =3D 1
>   =E2=94=82    =E2=94=9C=E2=94=80 write MT_CBTOP_RGU_WF_SUBSYS_RST  (asse=
rt reset)
>   =E2=94=82    =E2=94=9C=E2=94=80 write MT_CBTOP_RGU_WF_SUBSYS_RST  (deas=
sert reset)
>   =E2=94=82    =E2=94=9C=E2=94=80 poll MT_UDMA_CONN_INFRA_STATUS (0x74000=
a20) =E2=86=92 0x00000000
>   =E2=94=82    =E2=94=9C=E2=94=80 poll MT_UDMA_CONN_INFRA_STATUS (0x74000=
a20) =E2=86=92 0x00000000
>   =E2=94=82    =E2=94=94=E2=94=80 ... timeout after ~212 ms =E2=86=92 ret=
urn -ETIMEDOUT
>   =E2=94=94=E2=94=80 goto error:  (mt76u_queues_deinit + mt76_free_device=
)
>
> Root Cause
>
> After rmmod, the firmware leaves FW_N9_RDY asserted in
> MT_CONN_ON_MISC. On re-probe, the driver correctly detects this and
> calls mt792xu_wfsys_reset() to recover. However, the WiFi subsystem
> never signals completion =E2=80=94 WFSYS_INIT_DONE in
> MT_UDMA_CONN_INFRA_STATUS (reg 0x74000a20) stays 0x00000000 throughout
> the retry loop. The subsystem is stuck in a state that the software
> reset path cannot recover from. Only a full USB power cycle clears it.
>
> Hope this helps,
>
> Nick

