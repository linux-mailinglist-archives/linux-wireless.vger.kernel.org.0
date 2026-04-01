Return-Path: <linux-wireless+bounces-34288-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJM1CVKjzWl9fgYAu9opvQ
	(envelope-from <linux-wireless+bounces-34288-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 00:59:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 804B1381293
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 00:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 572843015E3F
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Apr 2026 22:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98187306498;
	Wed,  1 Apr 2026 22:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nr4mDDMp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C60A1C5D7D
	for <linux-wireless@vger.kernel.org>; Wed,  1 Apr 2026 22:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775084348; cv=none; b=sTaK2sfDLQGbayinbzSnBOq9R3QwttksnJc2MYjKuv3Gq9fFow1WgJqKZCc05a6DD8Y5eo6RGG6jfhna3W47c9BHwD5MRP/dDzNi/qgLYkuhGaAkzsHBKB4FC42ov3b/T4VFtwY67tyGl2FSG7RCKZXFXNQEwJ3m8LcamQl9zqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775084348; c=relaxed/simple;
	bh=Bh04i1AsLlmfPzJc4tfDUDKrG+zQUwrNren6a6q14IY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K5ddKpLOxDY4UuvTi03O4ZXEUg12J9TbshJOquPjvQ780gBebQKwdCY/9nPBPHXopIFxSp3ocHh1IiSOnSU9gC3OljEE/LJ3+XlWElPCDOklhFIxK/pm4tDKjp+eQs/ILcT9IaJ6kTOF33915Ko/+kzip0PReV5MYiiDQ9XqlRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nr4mDDMp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E8DC2BCB2
	for <linux-wireless@vger.kernel.org>; Wed,  1 Apr 2026 22:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775084347;
	bh=Bh04i1AsLlmfPzJc4tfDUDKrG+zQUwrNren6a6q14IY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nr4mDDMpqOPxtogvY217Vr023niJV3H3X+OEMpaBiyygtUn+HYAlNrHa+1I0NxIN+
	 iMjn0jgFnRVud5+eAU0J6oMFx8hirsUMhRIb0Pr89kut46lMEpiIGHbhNUsFcjP+TK
	 bKyuXfQCvJX3izTSc6qxW5u5qKxC4BhkouI0c5lwoJ+AKfEGMuhG2Msm/ABCknL4De
	 oygKcNZO6KL4c18d8Sn89Fh9mwhpHFePpc2DW+928Unq3fBDlOVRtW9iKG79wMHTmW
	 +4tYRhV7PM0DiLMaYIm8CdR5zjrDJfQ/8XIWJbpirrSiD+N+56wF0gk/nx7GsupDq6
	 PMYs9ctGKU89g==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-38b13652c87so2928081fa.0
        for <linux-wireless@vger.kernel.org>; Wed, 01 Apr 2026 15:59:07 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx34WxJG/JvJQRRV4BU68JGt4G2wjK7Iciy25DrEq3Q7gFKwvuT
	gX6Tb4S58ZXDCisEK63mgfXbEI55kn94QG/bm5RvY7Z2IkfV+gMP8EFUcxoCtBjZndVcOZaGipc
	jQ/Bd2MXW7qJMvgrT3iSPRlykOsqm21c=
X-Received: by 2002:a05:651c:324b:b0:37c:d689:7e1c with SMTP id
 38308e7fff4ca-38cc3072eeamr20758451fa.23.1775084346107; Wed, 01 Apr 2026
 15:59:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <59f58f03-6dee-4380-80d6-7e2778b5f14b@altlinux.org> <f264b392-37bc-4b31-ac0e-768466f2b962@altlinux.org>
In-Reply-To: <f264b392-37bc-4b31-ac0e-768466f2b962@altlinux.org>
From: Sean Wang <sean.wang@kernel.org>
Date: Wed, 1 Apr 2026 17:58:54 -0500
X-Gmail-Original-Message-ID: <CAGp9LzrfD+a84ZVGjUnrv7KYCpgfe88NyrXos8wW8U7aKM8BZw@mail.gmail.com>
X-Gm-Features: AQROBzCRx5vmL5Svm5WZlkSZUDNKHT4mh-uraOryAXlhYNAIGQLo8xUpZway6ys
Message-ID: <CAGp9LzrfD+a84ZVGjUnrv7KYCpgfe88NyrXos8wW8U7aKM8BZw@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-34288-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,altlinux.org:email]
X-Rspamd-Queue-Id: 804B1381293
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Tue, Mar 31, 2026 at 2:40=E2=80=AFAM silverducks <silverducks@altlinux.o=
rg> wrote:
>
> Greetings!
>
> I apologize for poor formatting in the previous email. I did not realize =
all
> plain text files' contents would be visible on the mailing list.
> I am attaching an archive containing the same files as in previous email =
for
> convenience.
> Given compression, I can also avoid using external hosting, which I
> presume is
> preferred, so I am including all relevant logs in the archive as well.
> I am also including original email text just in case.

I think the current test setup is still mixing too many variables, so
it is hard to tell what is actually triggering the issue.

In particular, if the goal is to test the NetworkManager path, the
script should not also manually manage wpa_supplicant, and iwd should
not be part of the same test either. NetworkManager normally manages
the Wi-Fi backend itself, so mixing manual wpa_supplicant handling,
iwd, and NetworkManager in one setup makes the result difficult to
interpret.

Could you first simplify the setup and test one path at a time?

If you want to test NetworkManager, use only NetworkManager, for
example by using nmcli to explicitly control the connection steps.
If you want to test plain wpa_supplicant, stop NetworkManager
completely and use only wpa_supplicant + wpa_cli. I would suggest
starting with this path, since that is also the setup I usually use
for testing.
If you want to test iwd, please test it separately as well.
Also suggest to avoid suspend/resume or hibernation for now.
The log you shared includes a clear S4 resume path (ACPI: PM: Waking
up from system sleep state S4 and pci_pm_restore returns -110), which
does not match a simple reconnect or module reload test.

