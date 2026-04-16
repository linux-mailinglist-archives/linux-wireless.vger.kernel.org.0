Return-Path: <linux-wireless+bounces-34909-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDjNA85b4WmusQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34909-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 23:59:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 807EF415243
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 23:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29B4B3015CBC
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 21:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62796369985;
	Thu, 16 Apr 2026 21:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gg7/THy1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED8735A939
	for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 21:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776376779; cv=none; b=EQ+aEv5JUPtBlJz0qwPfwNtQjITLckrcIXZrc9tpNUnkNOKvogsfUP5w9WGudxdKLLamXq3OBylcwNH99LVujt3Sio+2PEienKQ5XPeemponpxSYf0od1Ba+UCKtwdtHjwapHq6KTYc364BI+HQP9xo4Th5PpgxdxNbiI6HBmbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776376779; c=relaxed/simple;
	bh=AlLMcUQhFasP1gpVZMHOUydAPyqbNw6g5fn1ghs9xQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xj6Ay23SpVNgEbQRZFOlgLjsSd5lLM1gl71hSuRjtY3y1Xb4cDtA+RsuWrtDilF6gIJCzHbz+93F23Bmf/3uTRgMwL0vxoU8Z5iW2UjDX9HLg3bQ2BO52CdRoEdeWZZWULvP8A9jgNa0e466OQc7HwQSW06LMLRPhXo+lf4lZ0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gg7/THy1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8536C2BCB9
	for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 21:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776376778;
	bh=AlLMcUQhFasP1gpVZMHOUydAPyqbNw6g5fn1ghs9xQc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gg7/THy1+AX+5j9Nd6vMKO6fPOKg9HUVY5TkRex5a6XdEZRUppF6UqJ2uRBly4WCO
	 e9NbcmpJw9bmoZK7z0taLnegnx/b5/tcxZ9wghi4cqF1A+xZManOCZPW9sY/H18G0D
	 MwIyekkyH3F/qWMVuS7CGzFVqkNrlHNkexXtC1z8U6a2lnaW5epQcNniG/uy63mJmw
	 uWoFTGLiVdyDTPUovssflZdkU6dQdtCQfppVJHU55FTtm8X6ryBtqF7/I+ivRRvXv8
	 pO1fT8m1bJODZrM187RNX3nmlJuoHDj3EQesX5HusIQKmiFR9xh3T6LCCXmHXu2uyP
	 Rm5iGlkJR/FPg==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-38e7c3a2deaso168851fa.2
        for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 14:59:38 -0700 (PDT)
X-Gm-Message-State: AOJu0YxB6cxU2EOltSIy3MeDdv7AeyG0Fju+d9AgPvjKAf+2Xqc+G0Np
	IjzZTCYA71+kpH0xLy3wsca4MGEtAQsEmQjVK0dHnC8Ss9WpV944q1Ru28/eh73jFB0ImRsh3Fg
	lByM1ysvNS3eT11thP3Y+uUgLkYhyJac=
X-Received: by 2002:a05:651c:553:b0:383:5390:bc96 with SMTP id
 38308e7fff4ca-38ec7437420mr1136551fa.0.1776376777227; Thu, 16 Apr 2026
 14:59:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <59f58f03-6dee-4380-80d6-7e2778b5f14b@altlinux.org>
 <f264b392-37bc-4b31-ac0e-768466f2b962@altlinux.org> <CAGp9LzrfD+a84ZVGjUnrv7KYCpgfe88NyrXos8wW8U7aKM8BZw@mail.gmail.com>
 <651b9626-0c2c-4993-829a-3259141109dc@altlinux.org> <ddb70af0-b3b1-42c3-9459-ce41914c4d20@altlinux.org>
In-Reply-To: <ddb70af0-b3b1-42c3-9459-ce41914c4d20@altlinux.org>
From: Sean Wang <sean.wang@kernel.org>
Date: Thu, 16 Apr 2026 16:59:25 -0500
X-Gmail-Original-Message-ID: <CAGp9LzoEaNuQf7+2i5QZi8f44zQfxpWGJiW0WgYrAZhT2a9D+Q@mail.gmail.com>
X-Gm-Features: AQROBzAF8JmAS5EwGdBo41HZ0lpUNVOogRqOVGSfwXTacaEkYFE9SKdGuf0rLfo
Message-ID: <CAGp9LzoEaNuQf7+2i5QZi8f44zQfxpWGJiW0WgYrAZhT2a9D+Q@mail.gmail.com>
Subject: Re: [BUG] mt7921e: Intermittent connection failure
To: silverducks@altlinux.org
Cc: linux-wireless@vger.kernel.org, nbd@nbd.name, lorenzo@kernel.org, 
	ryder.lee@mediatek.com, shayne.chen@mediatek.com, sean.wang@mediatek.com, 
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-34909-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 807EF415243
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Thanks for the update and for sharing the revised script and rerun logs.
I tried to reproduce the issue with your script on an mt7921u, but I
could not reproduce the timeout on my side.
In my run, I got 398 reload cycles and 398 successful reconnects:
grep Reloading test_log.txt | wc -l
388
grep Connection test_log.txt | wc -l
398
The log is consistently like this after module reload [1]
If this were a generic race in the common MCU command layer, I would
expect it to reproduce on mt7921u as well.
Also, could you record and save the "iw event" log when you run the
test? That would help show what userspace-triggered
activities are happening. we can mimic the same sequence using wpa_cli

[1]
Starting WiFi mt7921u reset loop (using NetworkManager)
Making sure network services are down...
----------------------------------------
Reloading module mt7921u...
Starting network services...
Checking for connection...
Checking for connection...
Connected.
Connection succeeded. Cleaning up.
----------------------------------------
Reloading module mt7921u...
Starting network services...
Checking for connection...
Checking for connection...
Connected.
Connection succeeded. Cleaning up.
----------------------------------------
Reloading module mt7921u...
Starting network services...
Checking for connection...
Checking for connection...
Connected.
Connection succeeded. Cleaning up.
----------------------------------------
Reloading module mt7921u...
Starting network services...
Checking for connection...
Checking for connection...
Status: Connecting
Checking for connection...
Connected.
Connection succeeded. Cleaning up.
----------------------------------------
Reloading module mt7921u...
Starting network services...
Checking for connection...
Checking for connection...
Connected.
Connection succeeded. Cleaning up.
----------------------------------------
Reloading module mt7921u...
Starting network services...
Checking for connection...
Checking for connection...
Status: Connecting
Checking for connection...
Connected.
Connection succeeded. Cleaning up.
----------------------------------------
Reloading module mt7921u...
Starting network services...
Checking for connection...
Checking for connection...
Connected.
Connection succeeded. Cleaning up.
----------------------------------------
Reloading module mt7921u...
Starting network services...
Checking for connection...
Checking for connection...
Connected.
Connection succeeded. Cleaning up.
----------------------------------------
Reloading module mt7921u...
Starting network services...
Checking for connection...
Checking for connection...
Connected.
Connection succeeded. Cleaning up.
----------------------------------------
Reloading module mt7921u...
Starting network services...
Checking for connection...
Checking for connection...
Connected.
Connection succeeded. Cleaning up.
----------------------------------------
...
and so on

On Tue, Apr 14, 2026 at 1:22=E2=80=AFAM silverducks <silverducks@altlinux.o=
rg> wrote:
>
> Greetings!
>
> Update:
> New version of the script is less consistent at reproducing the bug.
> I've also noticed that on patched kernel it triggers timeout way
> more often than older script. I've rolled back to the older one,
> which relies on the NM autoconnect feature, though retained cleanup
> changes.
> I'm guessing direct nmcli command is often preventing NM from doing
> whatever it is usually doing that triggers the error.
> Script and reruns with it attached.

