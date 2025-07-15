Return-Path: <linux-wireless+bounces-25460-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 339EEB05619
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 11:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE5694E3AE6
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 09:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FCC2D46D1;
	Tue, 15 Jul 2025 09:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="gqIhu0JO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3F62459D7
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 09:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752571127; cv=none; b=CTAbsRPJ8ER9wgZoMhjWjReFGeifj0Z0T0z0kNAfueDT0DiykP0oIKARlSMNHqi009/tBSAtdtNkZsEerfvxUSr3RgotEjm5yofpwjJ8TSVjkuaOwLWMnGlSWgDm36entxQ+GMpYFmKrCuHM4UwF4H6sVpLghemnEoJUQiawJuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752571127; c=relaxed/simple;
	bh=XUW18B3qkCxYVLMVMGMi7FK7VXa/NHoFFdvfdjGU4LA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uhKpjeyliFClQB/B95nNIjwQmDpOz22I2QTKQah3d7Z7Lu6kQZd/tHs29e2EIhht4kvzUsU0hdjrEJWnz23Kgw6ZYalQnEpsKWstZrvWtDo7sUj+08ICZ9wUlpG9frcOMl8w8Zgf8gs3wNn7V4iK1cE2m5s3wrtzcEZMQJaPDQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=gqIhu0JO; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=XUW18B3qkCxYVLMVMGMi7FK7VXa/NHoFFdvfdjGU4LA=;
	t=1752571126; x=1753780726; b=gqIhu0JOyBKRNTViOlbFNJgqyPWmffX758/r3ygwbDYv8yq
	hgIFJIZu66LY95a8sHhZ+gCNer0RR0Nu3Wk/zCSRyqqq75Vav1vnHeKWsmez8hi5zkrI7g4kthi6Q
	kfm0K9fKckPMTCuc5MOvgmkTrdHLMouvk5BAvBBMFrq2uTc+OpXBnRArkdE9nkJCscwutyZ/FHRXt
	N9xnnC0LPOfBCZ9xLIn7oLBlkaEPINUgIqopQUJp23ZJE0bX29YY1vHzygwb3tA6Wm9kYfrVW0Ish
	5EuK4wwaTPNtLKZjYRncoDMYP4g7US3JNbB8T2kce+SzOehkX2JW4dH39fySg09Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ubbns-00000005qhI-3FrG;
	Tue, 15 Jul 2025 11:18:26 +0200
Message-ID: <885d6a2ae286e910f4911f151c7ea5b0daecca45.camel@sipsolutions.net>
Subject: Re: [RFC 1/5] wifi: cfg80211: support configuring an S1G short
 beaconing BSS
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Date: Tue, 15 Jul 2025 11:18:19 +0200
In-Reply-To: <bbxqihfwpz3w64md63opkek3z5p2vssgs2g5ha4gwerlbzqknn@wl53iztdzxfb> (sfid-20250715_111247_681807_D1276E28)
References: <20250714051403.597090-1-lachlan.hodges@morsemicro.com>
	 <20250714051403.597090-2-lachlan.hodges@morsemicro.com>
	 <4333caeb7a98bf2d29da7a26181dc34032d5bd9b.camel@sipsolutions.net>
	 <bbxqihfwpz3w64md63opkek3z5p2vssgs2g5ha4gwerlbzqknn@wl53iztdzxfb>
	 (sfid-20250715_111247_681807_D1276E28)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2025-07-15 at 19:12 +1000, Lachlan Hodges wrote:
>=20
> >=20
> > Is that really worth it? We don't have to protect userspace from
> > shooting it self into the foot _too_ much, just make sure that we don't
> > get into a mess in the kernel itself. As long as the elements are not
> > malformed, I'd argue we're fine from a kernel perspective?
> >=20
> > This also prevents future updates and experimentation, and I see little
> > value in it?
>=20
> In that case, would you have any opposition to using the regular
> validate_beacon_head and validate_ie_attr for short beacon validation?

No, don't think so, though I didn't check now that
validate_beacon_head() can deal with the differently sized non-element
fields in the different formats, but I suppose it could just do that.

johannes

