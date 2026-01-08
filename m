Return-Path: <linux-wireless+bounces-30563-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1376BD03F34
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 16:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D6DC30CFAFB
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 15:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997674E9E9B;
	Thu,  8 Jan 2026 12:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="SK8wP7gl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF25D4E9E69;
	Thu,  8 Jan 2026 12:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767875362; cv=none; b=ArR3Pwe48R0s6MtNF9q805vnUupV+1XSjtJrgPjEJJZDbsRlg2lz+I/ck8WjG7RseeEK5Zgv3lZKnjpEhCqjWyXpe4f71DRuFpe0DOw9AEmS6mMjEc6EMI6doPZwyoX1sutt2pyniGisDrnSyRWi6ZsOM8qwMqotKVuKR+v1CLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767875362; c=relaxed/simple;
	bh=GI50FtbxnCGJLfiimvYVEal+960NN6vWl1dWh9V+A+Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GQkeuw7ve1FUiLE9VGGLNQiuDSBmI9eUfV6l7fDaH7AWzII49hEuuaGPoEuGbubt3oM3k/d47+GT5O9qo4G7ZSEonOjz9UUNXW/X4XpCw/HEyw7nFsaFHyTRwC9I7vtI0vZblFOQn4k7iSt3Gzo7fniXRWDQX1d+E7gBXWpqxRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=SK8wP7gl; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=GI50FtbxnCGJLfiimvYVEal+960NN6vWl1dWh9V+A+Q=;
	t=1767875361; x=1769084961; b=SK8wP7glM/wuhBjV6jHULfgmbKj1T53jHLAj2TbQYVa6q8e
	4MpZVO6JuvCRGE+OLV+ZrWumHIgjNZPk/sA+Dolvara9FMVQ6h9lSzVZaENsS1EYtMSmHQPOoNhuH
	lUcreydHQ0SAXCHjFZoDPpagKazLD2IgglJn8hM3Bh8hTWsUibWEVCFa7VdFy8JGMDZapI2n8GvcW
	k7b3pwQJ5m40uPe71kJcTVyeDf8D/9JWOmkP97tlp7uT7GNBLiFi4oKvqd/hqOR9Ti2QSpH+PDOx5
	VuXCxbgBGBq2L4VU299yuufIiWvtg1FNW+0kT47Fr7Izb9NE6IFfAQ4hcqpjJ83w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdp8g-00000006Uqj-1Xbc;
	Thu, 08 Jan 2026 13:29:18 +0100
Message-ID: <6983492c92a811b45c27bc36337e16fbd1abd94f.camel@sipsolutions.net>
Subject: Re: [PATCH net-next] net: rfkill: Replace strcpy with memcpy to
 improve rfkill_alloc
From: Johannes Berg <johannes@sipsolutions.net>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 08 Jan 2026 13:29:17 +0100
In-Reply-To: <20251215122036.379322-2-thorsten.blum@linux.dev>
References: <20251215122036.379322-2-thorsten.blum@linux.dev>
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

On Mon, 2025-12-15 at 13:20 +0100, Thorsten Blum wrote:
> strcpy() is deprecated [1] and uses an additional strlen() internally;
> use memcpy() directly since we already know the length of 'name' and
> that it is guaranteed to be NUL-terminated.
>=20
> Use struct_size(), which provides additional compile-time checks for
> structures with flexible array members (e.g., __must_be_array()), to
> determine the allocation size for a new 'struct rfkill'.

TBH, I don't really see that this is a real _improvement_. I guess I'll
take it if you sell it as "let's not use deprecated strcpy" instead,
although even the documentation says "no new uses"...

johannes

