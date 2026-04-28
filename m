Return-Path: <linux-wireless+bounces-35464-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKptKcJ+8GlSUAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35464-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 11:32:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D61E4817B5
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 11:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E13C30205CB
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 09:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F50A37CD29;
	Tue, 28 Apr 2026 09:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="si4DzF2u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEDD3793DE
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 09:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368235; cv=none; b=Qi/Ve7y8ohyxRAiYpYHn16MpYhQnVBOgsNpcBAvnQ9Oz500jCZGBDKQ2uZEBpL9fhtR1xWaig8YOgcfceyXin3+6PwRDXxQQDK8ILhiiVlugBb/Vrx7Kmw/oQthrh2i8v6EVgFi53dFBrgLKxJKfCWKTbcx84eBcpQSLRI/Dc3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368235; c=relaxed/simple;
	bh=9pkZ6oxnoncKr7jqUvyDrIdS2cxfpXEDf6Td11rH+FU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V0xTC45xCx2MDIYL78Q9BIFsABVe1zoEhYwpIsb8zPSn/cmyCnBkWvNtOPzu08Bw6ZbNP34oC6U6/xMbyZbzPeNMOdRR4k79Xoemdpkno6oPuljsy6ItRgTUZ/H/mXIN44slIvDi+J/hNXcJnnZuqYu7d6cVXAxlOSkBVxZMPLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=si4DzF2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BBCC2BCB8
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 09:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777368234;
	bh=9pkZ6oxnoncKr7jqUvyDrIdS2cxfpXEDf6Td11rH+FU=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=si4DzF2uqzT/VXlkmg6UQCU6fvWCLW0kNYoxT5kigUVg5+aztNt2nK+k6sFhE4Fg3
	 ua53wAvDK33QOrnh8IcK1OX62JeSfAj5oQst4HGk+XkgCNdtCcfeRkLuKP9hN5s3YO
	 YcUfYT1NQ6oyPM2WpqhJluttPOkf1x/C6t6c8DQZ3k1N3nxxULtPQy9tLYiIRS0WYp
	 YpfWC8A9ULmcRyEiC53dgdRVhgQUPolxO7/kpEo1rZVfKVZ6UW04ddDBaeIcl7txWG
	 k1NiCmjh97duvZnfMaSoUw2nrjPnODCJK8gY3yzdYmTTiR2k1TQ2BQcFOlD+FEk9nW
	 FFaQPinWRlPSQ==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-38dd9f11a09so99620421fa.2
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 02:23:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8tvYixIBJj0lsvveREHjWjE6+p+SjskT/W4UdXEJNTCrYgq4MEIFiH06tB2QkdNbei0wmwt6Zc8ByWynwKjg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/1wcEAv/ThLwy3NWFV4gQQVceBpX+jW4Tol72dbZn6ustrrLZ
	EbE71yEf6oGcT1+8NJ2/qFZ7WebtK68hdFh2rsN/g3FAEqYf5Q/iXXt57gcBFcLLFBkuwrbm7F3
	VcEkww0K1ZXo5/WCLeN1h355DL4m8bNM=
X-Received: by 2002:a05:651c:4191:b0:38e:9eb1:6940 with SMTP id
 38308e7fff4ca-39240f694d5mr6737951fa.10.1777368232579; Tue, 28 Apr 2026
 02:23:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708-russia-320-v1-1-53641e8dd417@0upti.me>
 <20260428074500.ru-320-review-resend@gmail.com> <b9d9d6e1-91c4-487f-82af-e53d4148c11b@0upti.me>
In-Reply-To: <b9d9d6e1-91c4-487f-82af-e53d4148c11b@0upti.me>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 28 Apr 2026 18:23:38 +0900
X-Gmail-Original-Message-ID: <CAGb2v66SDbn7KV+ehT9qpEZa1RRYXSXCM_3O-0qgqayks8igqg@mail.gmail.com>
X-Gm-Features: AVHnY4IY33HCwe-Lx3cMh6T9rTZtboswfbohryCVPxTEjpmsxN1GBvAQmwk1AqM
Message-ID: <CAGb2v66SDbn7KV+ehT9qpEZa1RRYXSXCM_3O-0qgqayks8igqg@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: allow 320MHz channel width for Russia
To: Ilya K <me@0upti.me>
Cc: Louis Kotze <loukot@gmail.com>, Valeriy Kosikhin <vkosikhin@gmail.com>, 
	wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4D61E4817B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,lists.infradead.org,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-35464-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,0upti.me:email];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wens@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	HAS_REPLYTO(0.00)[wens@kernel.org]

On Tue, Apr 28, 2026 at 5:17=E2=80=AFPM Ilya K <me@0upti.me> wrote:
>
> On 2026-04-28 10:44, Louis Kotze wrote:
> >
> > Note that the patch base predates the recent RU power update (commit
> > 6873bfe in wens/wireless-regdb), which changed 5925-6425 from 100 mW
> > to 200 mW, so this needs a rebase on current HEAD before it can be
> > applied.
> >
> I can resend a rebased version if necessary.

Yes, please send a new version for the record.


Thanks
ChenYu

