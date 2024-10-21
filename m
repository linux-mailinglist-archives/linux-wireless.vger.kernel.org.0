Return-Path: <linux-wireless+bounces-14261-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 179C49A64E6
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 12:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B71DF1F211CB
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 10:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678161E882B;
	Mon, 21 Oct 2024 10:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="s9auR7c6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97ED1E8829
	for <linux-wireless@vger.kernel.org>; Mon, 21 Oct 2024 10:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507556; cv=none; b=adZshSL+uPyST3P2h13T0olgAaBcwIVA1Qtqm/wrBw4ZSj3f8uidFQg473wigtGJRyRWB3bhgFRUVV+21YTUlItbLuMuVY+WcXPuegJmfDqMYEPc+DQJv7mRXcJdEvalENINV5dqE6WyX0zJs/4a8kaabZ8WHe+9jyca4ysGeiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507556; c=relaxed/simple;
	bh=YsW4ZLJmDYaGLrDkKiwkBrIZzQXB4vAnW72cdlR4EME=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=srfNv0TvdYYQj9JWi8xx6s1NzsQyyyAzmQ0TywmFLIM0Srn54Ce3XXEmRc4AYDxVKdbsWxuSgmEAjzx3c5f4C2RHTcvwGLmfwEJ7UhwbOEAWdjdcIzi4+oApHxPipdgCXibHPaAo0SA0wfunugV75bnf7SXUByjQTRFWUGyK+z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=s9auR7c6; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=yptIV6CYVuQ70UtwSTqboJfcmEhv6I3xKeUd0Sg5Ucw=;
	t=1729507554; x=1730717154; b=s9auR7c6lO6ii3oI8UlQ0ECfszpO0EFbc0UG+GaoMLtUpfF
	FizzU/HZgxL/MRFEHqhAQ5wSnLItY/YZw/V0mWGfJ0FC02m62mKUKEjuMIb9gXLncguV3CtCGeJN5
	PgtKQWGNMUHF3YC/2OMbsGjOqOA2/wj8d/xH/XWPLRcoKzE2sf1NSXVeFq8hm4vr5pZvxRJ37NIUJ
	HEy57G8TzBdog7cz7hYOsSnkAebvUbPuWKJUu55oeMSUNuyyL/D7cF8bW+WFF63dfn2BcGEcHP15q
	i250OYpcpspCd2klWHv8/mHczgnhhj3XAQTf8ZxO7yakVSwa4X8SPNKmd6C7493Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t2pv5-00000000kpa-05YI;
	Mon, 21 Oct 2024 12:45:51 +0200
Message-ID: <1606121bda73a1295f934cff07b1ab52fcebaf94.camel@sipsolutions.net>
Subject: Re: iwlwifi GTK rekey is not working with WPA3 SAE encryption
From: Johannes Berg <johannes@sipsolutions.net>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: linux-wireless <linux-wireless@vger.kernel.org>
Date: Mon, 21 Oct 2024 12:45:50 +0200
In-Reply-To: <96a7a24b-61e2-45cc-9c76-15552107976d@quicinc.com>
References: <9840f652-7d4a-4693-90da-844174dc30f5@quicinc.com>
	 <ee5e7f5020bc874f477def3b1ea79339f0812b40.camel@sipsolutions.net>
	 <a45e6c7a-7348-45a1-9ce6-7a5425b21a36@quicinc.com>
	 <e96a1d4b63388e8d7e8a9fadfce31f408ae83ab2.camel@sipsolutions.net>
	 <96a7a24b-61e2-45cc-9c76-15552107976d@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2024-10-21 at 18:35 +0800, Baochen Qiang wrote:
> > >=20
> > > Oct 21 17:50:17 xps13 kernel: [  153.758773] iwlwifi 0000:00:14.3: lo=
aded firmware version 77.0b4c06ad.0 Qu-c0-hr-b0-77.ucode op_mode iwlmvm
> >=20
> > Huh, I'm surprised you have that version :)
> i just upgrade to the latest linux-firmware repo :)

Oh, didn't realize that was released there already.

> > Hm. Support for SAE AKMs should've been backported, so that's a bit odd=
.
> > What's the AKM in use, ciphers, etc.?
> i am not familiar with 802.11 security, guessing it is SAE & CCMP?
>=20
> here is M2 in 4-way handshake:
>=20

Can you also capture the rekeying M1?

johannes

