Return-Path: <linux-wireless+bounces-6736-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B558AF6E5
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 20:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 876A328CE72
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 18:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C08285653;
	Tue, 23 Apr 2024 18:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="pWjs5iXI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D223EA76
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 18:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713898267; cv=none; b=Lf4kWZVfpjiCwC3z7QfrMBbVoN1/kfIvHOsBNWV6r0NeJr1IqO9ELxtLWXl0fZ76EeIyG6Q3PxaPBpzZXcCuctlEedXs0LQq+IEUsakskAWyHMYHQhKJDbw81rCYxnGWvRrdnWEdFR3tRptnAtJ8jtK2ICNHy8X44iJlmlpMM+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713898267; c=relaxed/simple;
	bh=t0wZkylqj1UqrS5hLwdnXpZwAcq9noeTa9AVM8GitMw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QWK8BwaZdlGjAMj7y7pMlCtpq/VY7jgIi7OHUL6kuqFRXOYc1UcaWys+d8X1RQh8iJ1LmViFji/JJ9gH+6dFuk9OabC1aHUN4iIJHVvDDWA1C1xmBg3aNV8u3epLcVHgNBTOckyTHZtEQAiNs9id5lk6ZGOjLw8HUOsCzkNgri0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=pWjs5iXI; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Xsb95Iv3rb9ybzf1glT6ZAyn/POorM4OkOS9//+IWJM=;
	t=1713898264; x=1715107864; b=pWjs5iXIzPSZP5tlOPZOl+VPp8INtRsRqaC9Do0CpLxCd79
	WjOoe/cajWzg0a5Yeqll7HiHAvuI0hRY05cZtrygPng5G3UogU+ytzA1RjrZYbfJftSzfQ2TT8jR9
	pfDkRMcvD7jr105M27odlwGxIbBjnzleh7Jki/ypi57n8m1SDsjwsle89OqPzBePqPTiNZUCuxTum
	rZdLdx9ys87RT+ZpF90wfgZ/aads8HOOb5PqGES7M+EhwPzJIH0pVyc1jBFaF8zOt/AywRD8HrRzV
	Om21828h/g46O44QBqN02H4X7yt0fJDOtygaGME1wVPSzFWsp0mHNeBHCIJJOiiw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rzLEK-00000002Lpq-36eN;
	Tue, 23 Apr 2024 20:51:00 +0200
Message-ID: <76b20f4054876cd70fb31e4b31c9653ccfe29a08.camel@sipsolutions.net>
Subject: Re: [PATCH v2 6/7] wifi: mac80211: add support to call color_change
 and OBSS collision on a link
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Aditya Kumar Singh
	 <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 23 Apr 2024 20:50:59 +0200
In-Reply-To: <ca17a2f0-eb18-487a-8c5d-811748f2ca00@quicinc.com>
References: <20240422053412.2024075-1-quic_adisi@quicinc.com>
	 <20240422053412.2024075-7-quic_adisi@quicinc.com>
	 <ca17a2f0-eb18-487a-8c5d-811748f2ca00@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-04-23 at 11:46 -0700, Jeff Johnson wrote:
>=20
> Johannes, how do you feel about the new cleanup.h functionality? I ask be=
cause
> if we change this to just be:
>=20
> 	guard(rcu)();
>=20
> then we can remove all of the explicit rcu_read_unlock() calls --
> rcu_read_unlock() will be called automatically when the function goes out=
 of
> scope.

Sounds like a good idea to me.

Jakub doesn't like it so much, see this thread:
https://lore.kernel.org/netdev/20240325223905.100979-5-johannes@sipsolution=
s.net/

But ultimately I don't think he'll stop us from doing it here,
especially if we use it carefully enough that we actually do need the
guard for the whole scope.

johannes

