Return-Path: <linux-wireless+bounces-32800-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHXHME5mr2m5XAIAu9opvQ
	(envelope-from <linux-wireless+bounces-32800-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 01:31:10 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E95C02430B7
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 01:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C0733034DCA
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 00:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD4D202F71;
	Tue, 10 Mar 2026 00:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fF+dPqGg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A381A5B9E
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 00:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773102668; cv=pass; b=J2uE5TQnj/bEPmzL2ZUnu4vQGPJ9wnxjnZ8KGeSO02O83JdqfXqWGGp6uGqs5Z08AnYRttQASrdRPWrO7tfRd7bOXOOHbZp7QvqqX4uAQUjLCZxuBVnRGFh39T+B0CMFuiL5f95Zi2eLqJqYwBG+qd0v80z1V6KvZIDpB0uUjQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773102668; c=relaxed/simple;
	bh=GvBA8YCK7t+bmQHVOMeqyWfuvgsiymQwWEvMHlxa3RE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T4AUGUlPT86ShHSLTXTUm8mGQgsyQloDbcgLy1c5DRYOFijZlBPvTL/MStciwm0x2mhiJZg7fkCdXqC3YwUy0U2NgVNF5w3C5kNU4dd0G27iuuw/cvGoMT1fFPCQ/yw7XDf9MZhE8I0zRfGb3/Ina/Dhognl+snDfWPe0Xcucqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fF+dPqGg; arc=pass smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-899a5db525cso114041736d6.3
        for <linux-wireless@vger.kernel.org>; Mon, 09 Mar 2026 17:31:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773102666; cv=none;
        d=google.com; s=arc-20240605;
        b=Io8/s/66I42OGF4j9f0mc+EK2IvkBtQqFMEuPJhwxh+UAxRjJzM0s9uz+DhplcaTWw
         u1uHK88DYHIIC1CjYDubvgt2KZ+SY4QqGIaO511GeILb+Clwf6HTzcrFHifm03i/OtGU
         zfbjE61AfFO4ZHWA+X8+EbHIH4/4+c3GJEbkudhI9g7xRJCk/RXpA+ThLJmxDXQdMR7o
         PZNBXOcz6cSu55R2wWJdlocvV9tD/9Lwktrbw37x25vATGgekzNcCVKIp7hmPJxo0RQV
         HzRZAiYjwcCaNDKA/5XlhVVBkE0ACLMVRBZMbM3QwrqsxPwDeQVgE/LnzWVAAoqXIW4B
         bjQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t9wDJEseBZJT0tw4504PLVNc5jkQhgh2E19CGcQH/A4=;
        fh=catXQ7Tn+OxyEnd2v3aLqF4uQdbmZNB9gk3U7d+3rvQ=;
        b=js6FqBmyltYQY0x/O2iuwJCgtJZvudadOVsr+OMi2WEHuwUjf2G0vIJmSGCzAjN4ux
         GBrvLQ4T3EndwciiIZXe9oNamlBKUHJcpMPPnaW/eAO/qj2dFAuqGVJY4nZEirRHCp97
         k5nSoo0EHZ9fYuO018vapZ7l1GmNjAZTkGhQQzTzxeqavdHpHDNqTs4LRI0m7BPSOKnp
         HjlEqQmTC6/Gxo1VmFy81Yrl+Xd0PCnt8mC3vvRxXVx42PALksBZlAlk24q5yw0OhbWV
         WftsqZqfZOF48fG7QEiECXggLFsDSu0IvAAyg4GyCTFyOwDFWCPtYz48CGoQIFkYjl6f
         sg+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773102666; x=1773707466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9wDJEseBZJT0tw4504PLVNc5jkQhgh2E19CGcQH/A4=;
        b=fF+dPqGgr3CbHV4FscfvbpMstJsBbU81p2zl1rIWNxsWQfgYTbXVZNPInzdez4lJAc
         G3KwjCRtEpD/LwY9Dl5Hjd1oGJ1U70yY3hUQXpNOD15GZd5uFzti0T6yC0pqDwXGR8Z2
         ONhs6+R1j1eo2qneSdbnOt9/9XaPp2xEREyNv0CnynZJPn7dG7RpuEji5lz8TqcsSa+9
         FU3NZUnCjdiDaauc5173ghaCedusTT9HdtUXkm++bOZ8menjfDdRmTMhfgKNiM5CCznU
         vWSoHtwtxjHaZ4CPtOuDy5brMEy4Ouofc9eVbupODKoOprTuwixn9pdlqEx7IuqtnokF
         LD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773102666; x=1773707466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t9wDJEseBZJT0tw4504PLVNc5jkQhgh2E19CGcQH/A4=;
        b=qkpaMkd9bVp/UrNONVqFXakHSptOk3+l82UOtG1+57a2k2JNMM7f7aMS/UKXfXX4P+
         agzv3sfJaujMpMBgQSfZOXI86bjPwFHI0nLm+7RleeaHju18A6gWCkxrkYnDCVh/7cV+
         u+deXGM4TPBBgxI42FF4kwfam3A4jOsCr9rxzdvEnFdaix44u+VoGOQzj5KobkUegqyp
         YNFujCm8ya9jSmOtXrCXcrMoSeF5EHVBTI4DKsRWjcRcU/GQnKZzuqM2lhoY+pSJHgSM
         P9IKN8BHXEzf6zkBdVPE1CRFhaP6RPUnUfGy8NgwF1ZY6YCjGIHxV4x2gCrDQCgRtauS
         chMQ==
X-Gm-Message-State: AOJu0YyBbeeK4y5DaUy6YuSqiwI3VkA5QFVmKbBSjELHUiLC/GGMQtbc
	Uq/Xeebyl9vaL7WfIBKnW/8FgR2+r3c05OpDTBtIn5pvG0Qx+ar8FDuWK3Qt9g3C3kzNm5oxGhJ
	uNXxd2zXhmQRBt5KVmEsm/iNqn3btjg==
X-Gm-Gg: ATEYQzzgCJfnFQPHy9JBnJYg0jl891t0cr7skrxZsOLcCW84bdmisZ4L/GqDQ6/NYdF
	jn+YmfosPKzE20pBYIr8COI/9TjbUbPEHRgVOLPoYXi14rSTjGSsxjaxGWi+babbVfWcGXzaBTm
	g43uhzY68g78EtKJ6r2xDl41JdfVjEVK2cBAYV6uKbuuZaMqueJRtya8jt9L77Q0Z62zLuwb+ig
	CjSYZ4e1BkeUiLE/ITi9oqHaCk7jPoqMfXiKwoUOTMV+PgVr9x463hRwhL9jvVeAg1IBE+gvmwh
	tqeYEh+WJXBuH4J9tA==
X-Received: by 2002:ad4:5d4a:0:b0:899:f0d6:98c6 with SMTP id
 6a1803df08f44-89a30a9eb6bmr213356516d6.38.1773102665632; Mon, 09 Mar 2026
 17:31:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFktD2eaVpRAJRkaGOj4y-m0woK-sNeCM+h_7A=9GELSce6TcQ@mail.gmail.com>
 <CAGp9LzrTMALkJKrGANTCzeG4KUDGwC1YJc8SRKNRriH3a9bnRQ@mail.gmail.com>
 <CAFktD2eG+nebKcNbw2imufSOz6MCR-SUXjcUQmDqJabNfwx4sg@mail.gmail.com> <CAGp9Lzp2s675kmTJG+iYgLXS=fjiD-JC6GYjom7i-bcWFDxWoQ@mail.gmail.com>
In-Reply-To: <CAGp9Lzp2s675kmTJG+iYgLXS=fjiD-JC6GYjom7i-bcWFDxWoQ@mail.gmail.com>
From: Nick <morrownr@gmail.com>
Date: Mon, 9 Mar 2026 19:30:39 -0500
X-Gm-Features: AaiRm51-SPdK-uByJlD8gIwo0gSZSGDwL9gAwLKh8EvfKXck5ZozzIINJjRopFU
Message-ID: <CAFktD2dbdccWFodfFNya_XnbKro-O+BKrs4cZRNa0uPrK6FFfQ@mail.gmail.com>
Subject: Re: [BUG] wifi: mt76: mt7925u: probe with driver mt7925u failed with
 error -110
To: Sean Wang <sean.wang@kernel.org>
Cc: linux-wireless <linux-wireless@vger.kernel.org>, Felix Fietkau <nbd@nbd.name>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Deren Wu <deren.wu@mediatek.com>, Leon Yen <leon.yen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E95C02430B7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-32800-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[morrownr@gmail.com,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Action: no action

On Fri, Mar 6, 2026 at 6:46=E2=80=AFPM Sean Wang <sean.wang@kernel.org> wro=
te:
>
> Hi Nick,
>
> Thanks for the detailed report  this is very helpful. I don't  have an
> MT7925 USB device to detail look into the issue, but based on the
> trace I wrote a small change to try a different MT7925 reset sequence.
> please help test.
>
> --- a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
> @@ -234,6 +234,36 @@ int mt792xu_dma_init(struct mt792x_dev *dev, bool re=
sume)
>  }
>  EXPORT_SYMBOL_GPL(mt792xu_dma_init);
>
> +static int mt7925u_wfsys_reset(struct mt792x_dev *dev)
> +{
> +    u32 val;
> +    int i;
> +
> +#define MT7925_CBTOP_RGU_WF_SUBSYS_RST        0x70028600
> +#define MT7925_WFSYS_SW_INIT_DONE_ADDR        0x184c1604
> +#define MT7925_WFSYS_SW_INIT_DONE        0x00001d1e
> +
> +    val =3D mt792xu_uhw_rr(&dev->mt76, MT7925_CBTOP_RGU_WF_SUBSYS_RST);
> +    val |=3D MT_CBTOP_RGU_WF_SUBSYS_RST_WF_WHOLE_PATH;
> +    mt792xu_uhw_wr(&dev->mt76, MT7925_CBTOP_RGU_WF_SUBSYS_RST, val);
> +
> +    msleep(20);
> +
> +    val =3D mt792xu_uhw_rr(&dev->mt76, MT7925_CBTOP_RGU_WF_SUBSYS_RST);
> +    val &=3D ~MT_CBTOP_RGU_WF_SUBSYS_RST_WF_WHOLE_PATH;
> +    mt792xu_uhw_wr(&dev->mt76, MT7925_CBTOP_RGU_WF_SUBSYS_RST, val);
> +
> +    for (i =3D 0; i < MT792x_WFSYS_INIT_RETRY_COUNT; i++) {
> +        val =3D mt792xu_uhw_rr(&dev->mt76, MT7925_WFSYS_SW_INIT_DONE_ADD=
R);
> +        if (val =3D=3D MT7925_WFSYS_SW_INIT_DONE)
> +            return 0;
> +
> +        msleep(100);
> +    }
> +
> +    return -ETIMEDOUT;
> +}
> +
>  int mt792xu_wfsys_reset(struct mt792x_dev *dev)
>  {
>      u32 val;
> @@ -241,6 +271,9 @@ int mt792xu_wfsys_reset(struct mt792x_dev *dev)
>
>      mt792xu_epctl_rst_opt(dev, false);
>
> +    if (is_mt7925(&dev->mt76))
> +        return mt7925u_wfsys_reset(dev);
> +
>      val =3D mt792xu_uhw_rr(&dev->mt76, MT_CBTOP_RGU_WF_SUBSYS_RST);
>
>

Sean,

Testing complete. Results are good. You can show the following:

Tested-by: Nick Morrow <morrownr@gmail.com>
Tested-by: Satadru Pramanik <satadru@gmail.com>

Thank you for working on this issue. If it is possible for your patch to go
directly in to be in one of the next rc's, that would be great and setting
it to backport would also be much appreciated.

Nick Morrow

> On Fri, Mar 6, 2026 at 1:24=E2=80=AFPM Nick <morrownr@gmail.com> wrote:
> >
> > > > Reference: https://github.com/morrownr/USB-WiFi/issues/688#issuecom=
ment-3999038526
> > > >
> > > > The above thread is rather lengthy as we have been working on this
> > > > issue since Dec. 25.
> > > >
> > > > Testing with a Netgear A9000 USB WiFi adapter (mt7925u driver). Ker=
nel
> > > > 7.0 rc2 and a x86_64 system. Additional testing with older kernels =
was
> > > > also performed with the same results.
> > > >
> > > > Problem description:
> > > >
> > > > Cold boot shows the adapter coming up and operating normally.
> > > >
> > > > Removing the adapter from the USB port and replacing it shows the
> > > > adapter coming up and operating normally.
> > > >
> > > > A warm reboot does not provide a WiFi interface and shows the
> > > > following in the system log:
> > > >
> > > > mt7925u 2-3.2:1.0: probe with driver mt7925u failed with error -110
> > > >
> > > > Using the commands rmmod and modeprobe do not provide a WiFi interf=
ace.
> > > >
> > > > Thoughts: The problem likely is not the module teardown. The proble=
m
> > > > seems to be that the firmware (or the mt7925u driver) leaves the
> > > > adapter in a strange state such that a power cycle of the adapter
> > > > hardware is needed before the mt7925u driver can properly initializ=
e
> > > > it a second time.
> > > >
> > >
> > > Hi Nick,
> > >
> > > Could you enable debug logs and check whether the driver can still
> > > read the correct chip ID after a warm reboot, and at which step the
> > > initialization fails before the -110 error? Thanks for continuing to
> > > test and gather this useful information.
> > >
> > >          Sean
> >
> > Hi Sean,
> >
> > Github user @exct has performed the testing requested and provides the
> > following report:
> >
> > mt7925u Probe Failure Debug Report
> > Adapter: Netgear A9000 (USB ID 0846:9072, MediaTek MT7925)
> > Kernel: 6.19.6-2-cachyos
> >
> > Summary
> > The driver can read the correct chip ID after a warm reload. The
> > failure occurs before firmware is loaded, inside
> > mt792xu_wfsys_reset(), which times out waiting for the WiFi subsystem
> > to reinitialize. -ETIMEDOUT (-110) is returned and the probe aborts.
> >
> > Findings
> >
> > Question: Chip ID readable after warm reload?
> > Answer: Yes =E2=80=94 MT_HW_CHIPID =3D 0x7925, MT_HW_REV =3D 0x8a00
> >
> > Question: Which step fails?
> > Answer: mt792xu_wfsys_reset() =E2=80=94 WFSYS_INIT_DONE never asserted
> >
> > Question: Does it reach mt792xu_mcu_power_on()?
> > Answer: No
> >
> > Question: Does it reach mt7925_run_firmware()?
> > Answer: No
> >
> > Probe Sequence Trace
> >
> > mt7925u_probe()
> >   =E2=94=9C=E2=94=80 mt76_alloc_device()             OK
> >   =E2=94=9C=E2=94=80 __mt76u_init()                  OK
> >   =E2=94=9C=E2=94=80 read MT_HW_CHIPID (0x70010200)  =E2=86=92 0x000079=
25  =E2=9C=93
> >   =E2=94=9C=E2=94=80 read MT_HW_REV    (0x70010204)  =E2=86=92 0x00008a=
00  =E2=9C=93
> >   =E2=94=9C=E2=94=80 read MT_CONN_ON_MISC (0x7c0600f0) =E2=86=92 0x0000=
0003  =E2=86=90 FW_N9_RDY is SET
> >   =E2=94=9C=E2=94=80 enters mt792xu_wfsys_reset()    =E2=86=90 triggere=
d because FW_N9_RDY =3D 1
> >   =E2=94=82    =E2=94=9C=E2=94=80 write MT_CBTOP_RGU_WF_SUBSYS_RST  (as=
sert reset)
> >   =E2=94=82    =E2=94=9C=E2=94=80 write MT_CBTOP_RGU_WF_SUBSYS_RST  (de=
assert reset)
> >   =E2=94=82    =E2=94=9C=E2=94=80 poll MT_UDMA_CONN_INFRA_STATUS (0x740=
00a20) =E2=86=92 0x00000000
> >   =E2=94=82    =E2=94=9C=E2=94=80 poll MT_UDMA_CONN_INFRA_STATUS (0x740=
00a20) =E2=86=92 0x00000000
> >   =E2=94=82    =E2=94=94=E2=94=80 ... timeout after ~212 ms =E2=86=92 r=
eturn -ETIMEDOUT
> >   =E2=94=94=E2=94=80 goto error:  (mt76u_queues_deinit + mt76_free_devi=
ce)
> >
> > Root Cause
> >
> > After rmmod, the firmware leaves FW_N9_RDY asserted in
> > MT_CONN_ON_MISC. On re-probe, the driver correctly detects this and
> > calls mt792xu_wfsys_reset() to recover. However, the WiFi subsystem
> > never signals completion =E2=80=94 WFSYS_INIT_DONE in
> > MT_UDMA_CONN_INFRA_STATUS (reg 0x74000a20) stays 0x00000000 throughout
> > the retry loop. The subsystem is stuck in a state that the software
> > reset path cannot recover from. Only a full USB power cycle clears it.
> >
> > Hope this helps,
> >
> > Nick

