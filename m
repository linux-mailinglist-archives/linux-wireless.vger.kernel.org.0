Return-Path: <linux-wireless+bounces-32581-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uI+OOCY2qml+NQEAu9opvQ
	(envelope-from <linux-wireless+bounces-32581-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 03:04:22 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 617F821A735
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 03:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 565C8301683C
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 02:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501568635D;
	Fri,  6 Mar 2026 02:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIMfzVyT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D159749C
	for <linux-wireless@vger.kernel.org>; Fri,  6 Mar 2026 02:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772762660; cv=none; b=VFYtfOJQxMowDOq0uPsdqdyEvtymxIZ4DGKx+YGkznYw//MKUyUd25JspWgLB4+uKaG6FxMSPQZ3rkQuKMyOBsWfnB6Z54q/jW0h6C/TipzJx2YTk7SywtnVwPFi+ic6pXXtqPqwyvlBIdWdenuIExv4PRdgckWV3Lg5YwKS4uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772762660; c=relaxed/simple;
	bh=Gzl6Cp4shwOz8tZHUC5g3wgEqLnlr1EAszXzG4XusGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LXBk7H5jyrN88FKsY2QaVE8FhjXTQK88ohEiJlC4g8KnGsBsR7KZeNIbKTN5isTuty0kKyCIwi1GPjc7T7r8/I7LkuoTZy7fU3NfJ7HBjyZdWmHPUeKHoxDrtW68EH63HJ+UmIqukyfl1RZm5zwXE7Uk0oRxnqbWAbBhkiymBw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIMfzVyT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C033BC116C6
	for <linux-wireless@vger.kernel.org>; Fri,  6 Mar 2026 02:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772762659;
	bh=Gzl6Cp4shwOz8tZHUC5g3wgEqLnlr1EAszXzG4XusGc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JIMfzVyTFKk6s9CjuhqgGc4eLde+120cSjQgtDH3xxm3EAowcIE6f/JMwck7JWIsQ
	 Rb8AVrmGob6EgjaUSA78BIIaQS6W5914exkQih+9PDjNZpg6mq/LXWh4B1rK3gtiGs
	 zNI3vHQUM6d9KQxHHqEAlfq5azN97mtVhVpvVWyAgJLr8BD54gqoj3BQK/akxrtr2L
	 428RsWYes8RwLidbCGQJUIMx3ZElDyD/AJS9N1vw3XPyLmjUTnbAeI/wCwOSDWbkUF
	 J3G79lmztSuqQnwFqV0NZrN+9RgE6HP3622yzRxoP2B+udV5HjqCe16JbUjnH6WOUV
	 20+K8JAaEm7Ow==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38a2cc31e20so33737331fa.1
        for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 18:04:19 -0800 (PST)
X-Gm-Message-State: AOJu0YwkYNUVphIv32H8b1VVG27j5cu2kHRBQH/nUIE03Vd7K/iX3qku
	E+sB3IV8K3XW8Ftu8dsD/xoMFgw1kpQE8M5KHC/MQ7TzA391kBqxSXkRKCxkYtKdwQKG0vOyVel
	Qbb8jTTt5F7wuFzahvdpx5SAK9stmrBE=
X-Received: by 2002:a2e:be23:0:b0:385:c13b:5584 with SMTP id
 38308e7fff4ca-38a40d6e2a7mr1251881fa.36.1772762658151; Thu, 05 Mar 2026
 18:04:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFktD2eaVpRAJRkaGOj4y-m0woK-sNeCM+h_7A=9GELSce6TcQ@mail.gmail.com>
In-Reply-To: <CAFktD2eaVpRAJRkaGOj4y-m0woK-sNeCM+h_7A=9GELSce6TcQ@mail.gmail.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Thu, 5 Mar 2026 20:04:06 -0600
X-Gmail-Original-Message-ID: <CAGp9LzrTMALkJKrGANTCzeG4KUDGwC1YJc8SRKNRriH3a9bnRQ@mail.gmail.com>
X-Gm-Features: AaiRm52VHwutbfFJxM44zTdXvXAmPpmSYbYRXZHR7sTvC6AbIT67eY598EbFXXg
Message-ID: <CAGp9LzrTMALkJKrGANTCzeG4KUDGwC1YJc8SRKNRriH3a9bnRQ@mail.gmail.com>
Subject: Re: [BUG] wifi: mt76: mt7925u: probe with driver mt7925u failed with
 error -110
To: Nick <morrownr@gmail.com>
Cc: linux-wireless <linux-wireless@vger.kernel.org>, Felix Fietkau <nbd@nbd.name>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Deren Wu <deren.wu@mediatek.com>, Leon Yen <leon.yen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 617F821A735
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-32581-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Action: no action

On Thu, Mar 5, 2026 at 12:28=E2=80=AFPM Nick <morrownr@gmail.com> wrote:
>
> Reference: https://github.com/morrownr/USB-WiFi/issues/688#issuecomment-3=
999038526
>
> The above thread is rather lengthy as we have been working on this
> issue since Dec. 25.
>
> Testing with a Netgear A9000 USB WiFi adapter (mt7925u driver). Kernel
> 7.0 rc2 and a x86_64 system. Additional testing with older kernels was
> also performed with the same results.
>
> Problem description:
>
> Cold boot shows the adapter coming up and operating normally.
>
> Removing the adapter from the USB port and replacing it shows the
> adapter coming up and operating normally.
>
> A warm reboot does not provide a WiFi interface and shows the
> following in the system log:
>
> mt7925u 2-3.2:1.0: probe with driver mt7925u failed with error -110
>
> Using the commands rmmod and modeprobe do not provide a WiFi interface.
>
> Thoughts: The problem likely is not the module teardown. The problem
> seems to be that the firmware (or the mt7925u driver) leaves the
> adapter in a strange state such that a power cycle of the adapter
> hardware is needed before the mt7925u driver can properly initialize
> it a second time.
>

Hi Nick,

Could you enable debug logs and check whether the driver can still
read the correct chip ID after a warm reboot, and at which step the
initialization fails before the -110 error? Thanks for continuing to
test and gather this useful information.

         Sean

> Also: Testing with an adapter that uses the mt7921u driver does not
> show this problem.
>

