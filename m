Return-Path: <linux-wireless+bounces-23529-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C155ACAABD
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Jun 2025 10:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F40D417A366
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Jun 2025 08:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2879719C55E;
	Mon,  2 Jun 2025 08:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="TKsQ1i/7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC4B1754B
	for <linux-wireless@vger.kernel.org>; Mon,  2 Jun 2025 08:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748853685; cv=none; b=VeaRLfRnCX260WenEhQGTtSPnmWMCsxIg0AX7LTFKvHBEMVLiI9GLxA/SEYU5m6+xI7cMOm2pTFlDJLsMayhryYg/g75zPO97GWBPqYzMOWixXjIIdrt7XDtr/2odZr6LgNtyQ2Z5ZGEP1b6ilI5lU1ZOc20CN6xs/9K7vdeXJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748853685; c=relaxed/simple;
	bh=2jwFfMyjapLCy1lyxUTEYdQEpM5vYEwlnrfI6LCKR00=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nQnklsX57YJsvaLsBoSEK2hRUw9JZSFJhg4MA53Wlo58vHI3jAMU0m6LJWGeXAOujYeFd8+KEIDPo3C8DBil/F2Eml5TV7mdKOcbv/yX/oRWDwg8NQ23LLNfJ8li/jO/abdBvcAH/52oJ/dYf2N9g8TG+4GtD0PG4AbP/4y8jeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=TKsQ1i/7; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=2jwFfMyjapLCy1lyxUTEYdQEpM5vYEwlnrfI6LCKR00=;
	t=1748853683; x=1750063283; b=TKsQ1i/7vN+jF/+D8AGjAOQ9t20KEkSRoH7FkgYw2WBnO6E
	EPAX+LAA0XbNdQcE5OJYQpilwwF/Ck69+slVKAl1cSMwQN7QM5mb8PF+C7dVpwc++d5TksIyS6gUC
	S8YhEOVpik1LyDG9Giet5CKusrbVM4A+qjL87hdFNXjDaqkrTpKJFHAC1wLyXLRfWg73THRkJ9rk7
	QMU0lmloJggLWCKNGGJhO62f0G2kGZivu9oQI69JM+l5c+BEXRO+bN1SoEXkZ9Ef106jhdkTtlEZy
	i3/ryH4YehkQID01zg5er9rzktblf+CzcwnoN8QAEAXnphR9Hwr7T0uzZlw7vRLg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uM0jP-00000004w1c-0ZNx;
	Mon, 02 Jun 2025 10:41:19 +0200
Message-ID: <7608ad17b404d115bbca7955d33088b90dcfbe53.camel@sipsolutions.net>
Subject: Re: CI results
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>, 
	linux-wireless@vger.kernel.org
Date: Mon, 02 Jun 2025 10:41:18 +0200
In-Reply-To: <8c0dfc10-f60f-47bd-a139-d60f2663c22b@oss.qualcomm.com>
References: 
	<01da63d05c861af5a71eb18d117341b5f7c7628f.camel@sipsolutions.net>
	 <8c0dfc10-f60f-47bd-a139-d60f2663c22b@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2025-05-28 at 09:26 +0530, Aditya Kumar Singh wrote:
>=20
> Concur with your thoughts here. However, I just want to bring one point=
=20
> related to _Dependencies_.

Yes, nipa doesn't handle anything wrt. dependencies.

It's also tricky - consider if it has recursive dependencies, does it
potentially go into a loop to apply patches? Where does it take them
from? I'd think only the same patchwork instance, but it feels subject
to feature creep.

> In case of Dependency (Depends-on tag) between series (even from the=20
> same tree), the bots - kernel as well as the NIPA, currently does not=20
> handle it gracefully and in such cases there could be legitimate build=
=20
> failures reported since obviously the declarations are in parent series=
=20
> which is not taken by the bots. So in such cases, _red_ items will be the=
re.

Right.

> Do you have any suggestions on how we should go about handling=20
> dependencies?

So Konstantin also said the "Depends-on:" tag likely wouldn't fly, and I
agree, why should this be recorded in the final git commit message.
Looks like b4 supports something else though:

https://lore.kernel.org/all/20250528-sparkling-expert-taipan-5ad429@meerkat=
/

Might be worth standardising on. I did plan to move to b4 eventually,
but mostly when I actually do merging I'm in a hurry and/or more focused
on reviewing, so haven't focused on the workflow much yet. With Miri now
sending pull requests for iwlwifi things got simpler though.

As to whether or not the bot will get support for it - I don't know, I
guess we could take it up with netdev. Maybe you can float it as an idea
for the netdev foundation [1] if development work is there - but maybe
also first search netdev to see if it's been discussed before :)

[1] https://github.com/linux-netdev/foundation

For now I guess I think reposting the patchset after the prerequisites
land isn't _horrible_?

johannes

