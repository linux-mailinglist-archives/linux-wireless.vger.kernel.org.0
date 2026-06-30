Return-Path: <linux-wireless+bounces-38404-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eie3MSIwRGogqQoAu9opvQ
	(envelope-from <linux-wireless+bounces-38404-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 23:07:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 224B76E8061
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 23:07:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ThHcSzt6;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38404-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38404-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 254EE30E8504
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 21:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930B730EF7E;
	Tue, 30 Jun 2026 21:03:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129512FE56A
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 21:03:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782853411; cv=pass; b=pSQ5toNAnnEQuG4Miud9hzywwFKziQkGBjnYPhgfEvvfXRaM2IrUSFzzkuEQ3toUPR4cunHRBXzYVdniADo78IsqUj00gVmkxfqJ4emzYYmeF+K3nvOGX1142NlZVg3Vz3y46DwCPEbMSRq8vsD3cFpuq6b9REjUO/p0DEZPa+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782853411; c=relaxed/simple;
	bh=q7JoXzPTuey5MTxrK590E54YxP0efCGYmeHmx7RdAY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r2fZr3xc0WwK7+bSpVDqINTiIuj+MxQgV9F9TRnopmdc2YXAZzlWU5RZrFvFcwtuL2B54n+xA/ekAj/SMZe2xqnBUxN26CV87DhpDX4Xp+M1f4hR8EFHnVN/I40SXmitE76C/Z7h+GWpfKkod9WuZqmd/4kQiAso7MMZstvde+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThHcSzt6; arc=pass smtp.client-ip=209.85.167.41
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aebf9a509eso1137678e87.3
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 14:03:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782853408; cv=none;
        d=google.com; s=arc-20260327;
        b=XRkpeLplTNCgFpkZ9ckno6sWNjNgIdpKjE2gZMkeo0CRTdUlSgTu9UO6iJTCLVIB5e
         gd+73tZC37aL2alJIm5xYz3XUI2wuBc6cFxUPm5/kBokC43zms77Bg/Ht9j++9Mi9PZT
         peEHryTuflaXouu7gbQUaApil4l3MxJEUHufqU6cXbZeX5SFOxoKGNhMdjL3EBrGC0eR
         1y6qTIfXULyNupgfngMlwQ7Y9cWe+wlApPQuhbsp6yCnBVtY+p/4t/Atl787jjt15CBa
         wI7s6n6eHFeEDbz6xF/11uF7Qh7VtotDqK5QpE4ZpfdXX7A6gnzGHIPKFqXoFZjAgkfN
         PZ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q7JoXzPTuey5MTxrK590E54YxP0efCGYmeHmx7RdAY0=;
        fh=acbvM9fvSluZ9/GR1L+txpzekSSd5Hr2/nQ55BPCpPs=;
        b=sNQJOxgVOnfpp3mfzAGKAW3fea9XE7RCIwcK0i3AeMYLaj6xQIuvVKXpzDqzU7Vthp
         ebqp05NIbaSSMjopxnmZK7cAmXmHBWNwpy1WxL9ZrMOYOu4Sr/OaCAhPCNUpQW2RlDxk
         X+4Ru/0gfjXCSyzgcrf+/fNP9ZCqivwTC8w+m4BKVUeP4OCbGdLzkyOaXu83zIS0kg3p
         bPLhE3lQwizWopY6ZJ1EQ5kgonJo4S8sKiKDdRi9XwfrES1Qi9E8BlKHrag+BPYfHhnp
         WoqVwpVGWr8Cgffekn1tvrOVWxIJLyYduQQ8mEWaHZk7duLIHS4295WyHT3b42lYa5y/
         +hOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782853408; x=1783458208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7JoXzPTuey5MTxrK590E54YxP0efCGYmeHmx7RdAY0=;
        b=ThHcSzt6Xsjtmq9Tm0oA/m8zikOsxPxBGyPJ0zW8Hh7ZOvAry8SOkY8DL8bA0GaBGe
         IoJYsnfL1wEspRmaRybq4ePEQlWx8rzoanU/PSw45JUNNJCelXPEMBCJLbK1gtldi1ZD
         JcgwVgjMsBo1CoQJJyBJy7aq+V9x1BHJICcgm76QTMabqPiuGD6H9NLdOBxqmCYPAyNS
         Oh3NCZ6l7po8orObVIArLj5VYsZmm1tPcRy/nnKGEf6QjCtoUL4joHTYm+Bzw92DNP4p
         9wulZSMgJ5HBmNhhrzE2twGKNHEJzZSIbrLrIF9ygA9X514c1oIZVVNO51APnFdbf5Fe
         qbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782853408; x=1783458208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q7JoXzPTuey5MTxrK590E54YxP0efCGYmeHmx7RdAY0=;
        b=cwktR4yi769DWmb5/2LzUrBfyZed8P4t1xCyHpNObPC5qY/IpPVSGn5yR0gKpy7na8
         NpmYPPnlvwXNddZejVkjE68/pg/oDqYtrtAzpDzRSnJrPfAfx29F5VW2+BgDe9rshmro
         9OlvMjDw6woNDYb6YgiSXvT/Ih6Em9ALIkcAMyCEC6+gCE2KEzcZTp058BrBuyWvVEG/
         OoWPXu8Ccknapvr4PHdVayyeGBzKxO5Ex19CuE5Hjvjq9KPEapSqYj0SyHkkvfFn+XD4
         rie0vcAVR7zBEc4zNEZbhY9rzr8w2ZApUD/Atmlw4Q7ewVgaHdSKYvrjbffP89DtQfqF
         26LA==
X-Forwarded-Encrypted: i=1; AHgh+Rpv8Om83LFrXUVQrVVCpip84Q3GEPQDMfJcrhnW8FDF3OyuWsG8f0lSN549RrAxBAWGa0AtFhnZhwKiVMigBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMaJphQKsduGWFnrPT2EpOfVY2IIjpw5UNdoqKMZ/lbmIf7sC3
	MO1kkZ+y9AKPwwceRprgMU5TMwlBuleymHjJkeRlxgzgcwgzX3hVGSs0xZHGQQG4H8c4wtVt7S0
	VCK42fh1R4vgiwVKaEeWY9JEPac5ouh0=
X-Gm-Gg: AfdE7cnvyVTZdGNh1jtjWvZxElWdF182YIYwZqIU7SHgSLa123IdWuBxMIjadrbOwep
	5BzAdeH8UAoFpL28hB9BIHFrjDWIQ5mAM2u1G6bn7BWoYoF9XpatHocmEMMyLj3wAl+hJUiUajn
	eX++cWoB3AgI8PD8iYy4M+FfIPcPRUxKkwANWUP9JJDgtvxvgBxFb7N6I0osej19OlpC7qtKd2D
	5iiS9OKLCLw4ycFSDx/ZnXukus0Drgixggrm/QWdCVLrG64OOD8IZD1zW9URAWpC2Cg+j1kMFCl
	WADgYgDih6q942KOes0TuRPNdZ7faBvMCLcbgyAIhXIZFYVPt0Bsy1ZsjzZGxwKLo0vqOUC6PV7
	RvFdfjoTx9w/v4Z9t/2poZ1yevxY=
X-Received: by 2002:a05:6512:618c:b0:5ae:a9ec:9fc4 with SMTP id
 2adb3069b0e04-5aebdbc70a5mr1360054e87.63.1782853408064; Tue, 30 Jun 2026
 14:03:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427051746.954704-1-rosenp@gmail.com> <ajRmlyx_AEGybykL@soda.int.kasm.eu>
 <CAKxU2N-gfH8Tq29-j2MArogLZuO7JEqtN5LNPVygJzrAERa3cg@mail.gmail.com>
 <ajSDtsJCmYnMNJSD@parmesan.int.kasm.eu> <DJCNDEE8JMPL.1DL49X1EUDFCE@gmail.com>
 <173df064-f373-4cce-b35f-e52f728be263@leemhuis.info>
In-Reply-To: <173df064-f373-4cce-b35f-e52f728be263@leemhuis.info>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 30 Jun 2026 14:03:13 -0700
X-Gm-Features: AVVi8CdKSeWNxVJXoQWTYXgaetJpdvlliSZ-GmhRr-ByVwdKSQxkvdocgc7yH_E
Message-ID: <CAKxU2N9hw6bUNA+rZC_jfZVzi7bMXe96jzLWdL9F3P4=rYnmUQ@mail.gmail.com>
Subject: Re: [PATCH wireless-next] wifi: mt76: fix of_get_mac_address error handling
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, 
	Tobias Klausmann <klausman@schwarzvogel.de>, Klara Modin <klarasmodin@gmail.com>, 
	Linux kernel regressions list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38404-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:regressions@leemhuis.info,m:nbd@nbd.name,m:linux-wireless@vger.kernel.org,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:klausman@schwarzvogel.de,m:klarasmodin@gmail.com,m:regressions@lists.linux.dev,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[nbd.name,vger.kernel.org,kernel.org,mediatek.com,gmail.com,collabora.com,lists.infradead.org,schwarzvogel.de,lists.linux.dev];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 224B76E8061

On Tue, Jun 30, 2026 at 5:18=E2=80=AFAM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> On 6/19/26 03:50, Rosen Penev wrote:
> > On Thu Jun 18, 2026 at 4:51 PM PDT, Klara Modin wrote:
> >> On 2026-06-18 16:01:45 -0700, Rosen Penev wrote:
> >>> On Thu, Jun 18, 2026 at 2:47=E2=80=AFPM Klara Modin <klarasmodin@gmai=
l.com> wrote:
> >>>> On 2026-04-26 22:17:46 -0700, Rosen Penev wrote:
> >>>>> Check return value instead of is_valid_ether_addr. The latter is ha=
ndled
> >>>>> by the former.
> >>>>>
> >>>>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> >>>>> [...]
> >>>>>>>> Recently I have started to see randomized MAC-addresses on my
> x86 laptop
> >>>> with a MT7922 and the above message printed in the kernel log. I hav=
e
> >>>> CONFIG_OF turned on, but since this is an ACPI system the device is =
not
> >>>> described by any device tree and the earlier of_get_mac_address() li=
kely
> >>>> fails with -ENODEV. Looking at the !CONFIG_OF stub for
> >>>> of_get_mac_address it always returns -ENODEV, meaning this will alwa=
ys
> >>>> randomize the mac in that case too.
> >>
> >>> IIRC, the normal device_get_mac_address supports nvmem now. Does that
> >>> fix your use case?
> >>
> >> I tried this:
> >> [...]
> >> but I still get a random MAC.
> > Then the original patch should be reverted. Unfortunate that it doesn't
> > workq
>
> Happens, no worries, but seems nobody submitted such a revert yet since
> you posted that. Unless I'm missing something -- if so, please do not
> hesitate to tell me!
>
> But if no revert is in the works, could you please submit one, given
> that it was your change that cause the problem?
https://lore.kernel.org/linux-wireless/20260630210215.400379-1-rosenp@gmail=
.com/T/#u
>
> Side note: Tobias (now CCed) ran into the same problem, too:
> https://lore.kernel.org/all/30a90714-02d8-45f2-a7f1-4cfe0627d50b@skade.lo=
cal/
>
> Makes me wonder if more people are affected by this and if we should try
> to mainline the revert rather sooner than later.
>
> Ciao, Thorsten
>
> >>>>
> >>>> Reverting this patch fixes the issue and the correct MAC address is
> >>>> used. I'm not sure if there is any case where of_get_mac_addres() co=
uld
> >>>> fail in a way that results in a valid MAC address but it seems unlik=
ely
> >>>> to me.
> >>>>
> >>>> Regards,
> >>>> Klara Modin
> >
> >
>

