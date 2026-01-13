Return-Path: <linux-wireless+bounces-30747-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB94D19956
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 15:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B642E30942F1
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 14:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF4229E0F7;
	Tue, 13 Jan 2026 14:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="PVsr1dya"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD812BE639
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 14:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768315334; cv=none; b=Gaa6wQYQw3zhtbMX7k7TjRbfzeGZIR1EoK+bXNj18tq+nYobnvuXZ7hC+9sKE2C/YY2l6LA7K3uvjK6gOcuz52y3bG376qWvkxCW1gAvQA5M5COTIarQGoH838qdf3YaGSyXzWcFNTNn3cF2/Ve3+qg0SaJvLewsr//d6Nbo7aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768315334; c=relaxed/simple;
	bh=HTHiFXvh7AdPW+CJnXFMgzG5n3Q1HacuPldT5dXH03A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SR+VrBp4MXCLg3UJs3HLA/K9YHwGgn8WTBL8OxVoFbXZSZ/b5aQA6TJdX4r9LMi6o/N6xHdpdr9/nNav2C7BBqQbdpTecSA2bCIx5g1ZGGXl3SG7Y6eTu8sFGC/p3z9Jl8ogUtpR3FuzJFaSnLYy6+F7yxWPcPVRjQ+3J9q7Rzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=PVsr1dya; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=+/2k2H1JWRhRNRkjqgYzZfJqLcnAMyfXDc/h7HSFIW0=;
	t=1768315332; x=1769524932; b=PVsr1dyat+75DcpHXG1O8sJv7ZznTHSj55DUioTj/8Ilri0
	dlOf5cf/8sYMT/CZJgNhcmZQyn7nkjalD7trUAMxllxflPD40XIewAjvxEtkyJsAaDpXU2OurrczX
	/+4td3sVq801nbRX+zkuzj194gf0+8Oqi1pn7Ji08P99EoDX0TqpTSi+4/HoyKRbzuKr5NT4WNzbF
	zmeZ584FUzXLdkg2INpjDv7ueuTW6+F4silyUO7DlFpAUGM2yTOKTMcAy7bFNt98SNmLTaaIoImVd
	2yn3V0qQBgkCVL3KeJh20+EjeR1YOR426hKkdmyPfPwo9o2aS8lwS8499D1/zGEA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vffb0-0000000AoOq-1v4q;
	Tue, 13 Jan 2026 15:42:10 +0100
Message-ID: <b2dcb04fc0a26eb46ef146fcbfc92a0823b320d1.camel@sipsolutions.net>
Subject: Re: [RFC PATCH] wifi: wlcore: allocated packets tracking mechanism
 may get broken
From: Johannes Berg <johannes@sipsolutions.net>
To: Peter =?ISO-8859-1?Q?=C5strand?= <astrand@lysator.liu.se>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 13 Jan 2026 15:42:09 +0100
In-Reply-To: <3bc7166c-7076-0d98-a45c-c993049621ca@lysator.liu.se> (sfid-20260113_153847_078773_40BD5239)
References: <476e02ce-4592-b08a-fcc9-c1b151500bb9@lysator.liu.se>
	  (sfid-20251228_170449_364924_53B203D7) <838a14637a5c134761ae75b600008396333ae95a.camel@sipsolutions.net>
	 <3bc7166c-7076-0d98-a45c-c993049621ca@lysator.liu.se>
	 (sfid-20260113_153847_078773_40BD5239)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2026-01-13 at 15:38 +0100, Peter =C3=85strand wrote:
> > >=20
> > >  It is observed that at some scenarios, the best effort queue
> > >  that should always show positive or 0 count, may show negative. This=
 cause
> > >  the best effort queue to look full to the network stack and thus cau=
sing the
> > >  network stack to push less packets than to other QoS queues. It woul=
d cause
> > >  specific WFA tests like 5.2.27 to fail.
> >=20
> > [snip]
> >=20
> > It seems to me that we probably wouldn't _intentionally_ transmit frame=
s
> > with a mismatched AC/TID mapping, so is the patch just being lazy to
> > overwrite it rather than figure out why it happened?
>=20
> Yes, agree. I guess the question is if such mismatch can be prevented by=
=20
> the kernel? Since wl18xx firmware is closed.

Oh, it's transmit, so it's coming from higher layers of the kernel.
Which is why I'm saying this, working around firmware in the driver
would seems like the only choice, but working around mac80211 in the
driver seems odd, unless perhaps we can show that's something that it
does intentionally for other drivers.

johannes

