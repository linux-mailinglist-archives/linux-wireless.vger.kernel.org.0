Return-Path: <linux-wireless+bounces-9798-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5624491EAC5
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 00:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB2CD1F21A44
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 22:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B5385923;
	Mon,  1 Jul 2024 22:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="TEdhY5WT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A1138394
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jul 2024 22:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719872358; cv=none; b=CPegYaJn++h7rzSIgKSz6/dedpRmdHgwtJANY2V4ANu/VkHVYpR086UH8dWRKHp9d2bWf2crT64DQk0d1XnPEoB0m5ltviIVAQkMCB4VRi3f5t5YRLtiVeplQV6OjT7BrzVVPTVifr/7GzoauyGSCoxN14o0ckQ0d5lQlGZIIFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719872358; c=relaxed/simple;
	bh=dp+qmbrhiTUqo6VaBbV/VBoyIYGDmM580kjVK0+WJjY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N91UfYT5oDP6QBNrNiPEqvnfsBbixz4Ky7ebHaYtY1ogEJQoVpj81Wi8CpgZSMUutDAgMaQ9tGMKbmMULlGu3hzOhzm9OjXCqs5U3tKUWqWoeZqtAG4VBwwnZTBIvHhSLu4Yc9In0kZwPVF+IMa0+R96TFodbZXpM8EMa7dQ7EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=TEdhY5WT; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=dp+qmbrhiTUqo6VaBbV/VBoyIYGDmM580kjVK0+WJjY=;
	t=1719872355; x=1721081955; b=TEdhY5WTQw555L2ZV/uvmPbD7+SrcjjSNCxLbs5hJgG0L4/
	/wwQkrVg32e14HHC+pCjAswIWw3fnn8rCZS4q9ZOAsX3xK+ETV4ZeUdrZEVAhIh8CAzQzqO+f4etd
	QjY3+zbC3PGKGmPPMymijGqsYPn/VRXd1jVem7wLtAQxwuPkrhcYxzQ1gX80gCUIkLnrhmcGcjeea
	RfdZ0VFEudohfsctpNeevr9hgMg09rYH30IO5Up6YjPryfwBV+OWu7sevCiqdZmpRVX849Wy9TCkd
	PGkeRX6Mn+03SpbFf1GYVItKnIaQXejgWUMvVUvnv3xcKEqlA9uyzU30At7igE/w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sOPMf-00000003Tsr-0dqL;
	Tue, 02 Jul 2024 00:19:13 +0200
Message-ID: <28fecb57a105ec177ccaf3a2742fade8a77b9102.camel@sipsolutions.net>
Subject: Re: [PATCH] iw: fix formats under MIPS64/PPC
From: Johannes Berg <johannes@sipsolutions.net>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 02 Jul 2024 00:19:12 +0200
In-Reply-To: <CAKxU2N-SH2pKTq4tQX+cJEceQ3EHN2nxQK+krr8q3VQ7a-3nrg@mail.gmail.com>
References: <20240628223237.16222-1-rosenp@gmail.com>
	 <8f826bf3e6c2a676c4db37fdfd5b10e364abbb51.camel@sipsolutions.net>
	 <CAKxU2N-L+B_DSTA9nsseDgnzCtgOvtSgd6pShEF-MmA=DQCR7A@mail.gmail.com>
	 <a95d943d72123ddf4079262003516f29f52b06ad.camel@sipsolutions.net>
	 <CAKxU2N91jXA9hjdbPkfdQnHa1iehdBE+_K4QdsRGGfKu9V_sJw@mail.gmail.com>
	 <1dd82a549053f7c2d841a966704664ca785b14c9.camel@sipsolutions.net>
	 <CAKxU2N-SH2pKTq4tQX+cJEceQ3EHN2nxQK+krr8q3VQ7a-3nrg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2024-07-01 at 15:16 -0700, Rosen Penev wrote:
> On Mon, Jul 1, 2024 at 3:10=E2=80=AFPM Johannes Berg <johannes@sipsolutio=
ns.net> wrote:
> >=20
> > On Mon, 2024-07-01 at 15:07 -0700, Rosen Penev wrote:
> > >=20
> > > They go away because if the define is found before any header
> > > inclusion, __u64 gets defined to unsigned long long.
> >=20
> > It *isn't* found before any header inclusion though.
> >=20
> > For pretty much all of the C files, "iw.h" comes _last_ in the list of
> > included headers.
> Oh I see what you mean. No real idea. However without this patch, I get
>=20
> event.c: In function 'parse_nan_match':

OK, well, event.c is one of those cases where indeed most things are
included indirectly via iw.h, so it would actually work ... but most
files don't do that. Maybe lucky that they don't use 64-bit types (yet)?

> I submitted a similar patch to fio and was advised to move the define
> into the Makefiles. Not too sure how to do that here.
>=20

Probably a good idea, just add

 CFLAGS +=3D -D__SANE_USERSPACE_TYPES__

in the an appropriate place with the others.

johannes

