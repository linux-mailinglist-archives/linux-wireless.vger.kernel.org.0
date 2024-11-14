Return-Path: <linux-wireless+bounces-15295-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C8B9C867C
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2024 10:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A94A1F21579
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2024 09:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900161F583E;
	Thu, 14 Nov 2024 09:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="qEsfXk9U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98241DD52D;
	Thu, 14 Nov 2024 09:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731577954; cv=none; b=dIgjiM7/MLu3BtJHHOrqp6QQShh7HwF4CMC1veWINEMgTQDP6G00oc2CKPduAylHec1Tq2qSk+C85mVKEKZypDJVq3AlW9vxpo9uUewI/IM3KWcSlqDDgJWmQylgJnZDPCvNgDGQZ4giQ5P36STdf/VwMk395o16IDbowZqPZSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731577954; c=relaxed/simple;
	bh=Hx67m0P7TWTSqFAUZH/cg/4h1meOzxypHmijjl0BCJ8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WGOQ5bGumR0jS0gkvb/jdgOTV6z1ftkBDjgE1MuMaARvfnUP46SpzHlMmnzwUoHn9THWMguKZ3SjpZr6ku9amnDOh7hWEQMMW3ilaxPuw0Ld/y0X5Gca8Z/HD4QARVdqgyB5yxWug5pHw44/GNTyCNFIMlaciA1qu/eU/UVVFak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=qEsfXk9U; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Hx67m0P7TWTSqFAUZH/cg/4h1meOzxypHmijjl0BCJ8=;
	t=1731577953; x=1732787553; b=qEsfXk9U+3prdGZ/SrZwNDIyM5uh8uZbqbse8sFCJFQFGdm
	vMNhREi3dez2pzjvdo5jcq/mm+ffb6Se/+YKlF0Xi3sZE4riP9DDVpgkqZHwB/mHG6vnQze84XFF5
	Cnn2xYH6YwiZ1BOH/tbH6qTEIXgnTm0mAiV+Y+CUbvzK9GNQac7zS2RxHAYxdh1UDbrJUXmyArqjj
	vvRCkihVHZ3psVSqbFfD7uiT3Si4CUqpQyqG+dOaLU2UPbrljEA+Wtt5Sj0YcVRcfkFuH40nP6ecC
	o/BGgPbT0adq280PKGqTMS3c2DBSMQgXcsZZnvDJAEJIDXME+M3pLlUYxjcgXDow==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tBWWc-00000004gaH-19o1;
	Thu, 14 Nov 2024 10:52:30 +0100
Message-ID: <9fa869ddec6c22c0bb299676e27b7b33d3e3b5d7.camel@sipsolutions.net>
Subject: Re: [REGRESSION] The iwl4965 driver broke somewhere between 6.10.10
 and 6.11.5 (probably 6.11rc)
From: Johannes Berg <johannes@sipsolutions.net>
To: Linux regressions mailing list <regressions@lists.linux.dev>, Kalle Valo
	 <kvalo@kernel.org>, Alf Marius <post@alfmarius.net>
Cc: Andrey Batyiev <batyiev@gmail.com>, linux-wireless@vger.kernel.org
Date: Thu, 14 Nov 2024 10:52:29 +0100
In-Reply-To: <5f64abc6-017f-4283-bf08-dba1aea28e9d@leemhuis.info>
References: <60f752e8-787e-44a8-92ae-48bdfc9b43e7@app.fastmail.com>
	 <87wmhg61yp.fsf@kernel.org>
	 <CAEQQxWx7PXw3O_j1FWn7G+DhUUXt3sEB0qDyA2+udRQ6r28FUA@mail.gmail.com>
	 <4f689121-f2c1-45ec-bd5b-105a770af935@app.fastmail.com>
	 <87ttcauv7x.fsf@kernel.org>
	 <5f64abc6-017f-4283-bf08-dba1aea28e9d@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-11-14 at 10:24 +0100, Linux regression tracking (Thorsten
Leemhuis) wrote:
>=20
> Sigh.

Please. You really should consider adjusting your attitude on all this.=C2=
=A0

Do you _actually_ think that everyone is just out to make everyone's
life difficult? Because you certainly consistently make it sound like
it. It takes time to get something into the kernel, it's not like we can
just commit it to Linus's tree.

johannes

