Return-Path: <linux-wireless+bounces-23379-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 301BEAC348A
	for <lists+linux-wireless@lfdr.de>; Sun, 25 May 2025 14:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BECF3B805C
	for <lists+linux-wireless@lfdr.de>; Sun, 25 May 2025 12:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8340B19FA8D;
	Sun, 25 May 2025 12:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="g+s7R5M8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A3C15E97;
	Sun, 25 May 2025 12:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748175890; cv=none; b=GxsfAxFJ12yU15y7VAYzdRwDswN8hP5OtrSsExGYSiFib73IS5OWGBtZL7pPwv70EBhLnIE44QhJPuisZ9JY4bM3Unc8WF/jjkwbySvtQJNfAoG0oRsSlimDZVyFXM+X9tsfZvs5H6qoMVKqqAAab4dY83VwUvk76U9mECWasrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748175890; c=relaxed/simple;
	bh=Rjj/o/ekSJoAunv2A0v4/2wGpdJXxdvj2TdrL/29MrA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F3wpzxGPJr7YDORXL4RPxuHWmMsAgaOmIs69LER3rsZ1a/+6PD9JKBNWTvrBXvF9eP4IGZnWb+QTkq+7jrx7iy1nN/tG7d/bJJLhIxMrqJOxCrwh82Jus/2TUvTsAZ7p4DbVF3Sihm0xmV9rkbHlGYsX2M9wroUgo2UvpsqFnaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=g+s7R5M8; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=+3UVFqyZN629ikA7W2IqWpJT6OK74u8xGHztzVCky9Q=;
	t=1748175888; x=1749385488; b=g+s7R5M8azNHDh1QUKrDd28kZXvMaQD6RWgo8tByEyBciMu
	DNQeVCuRs0Pdllf89z7l38f54Pyj1cWYyIParpZklfvs3P4Bf7jwC+7TQMM0yTQAwmLHO5t02n6Y7
	m8/842XfGPLIk6Rsr5DL+CnvC/vkQ0kMQkkLhp9cZeMbXG2EILpNCzgM4UlbAC/zZfrLf0+ZmEaEn
	LQWT2gcfI9DcdSiG2Bibtl3K+0S83v4CuvW9SMA97M/e9tVy6gfpdb8oznolaMM+zcg62sB8lBiq+
	6UVFSPTBzW6fq81rEVaCUAoyW96qPVB9b0V7RqLY+qWJyzgMaZ03/G9bRNSYbU9w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uJAP9-00000009uJb-3tPt;
	Sun, 25 May 2025 14:24:40 +0200
Message-ID: <66ab4bd4e87b20004f7acd751674b0b9712164ca.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v3 0/4] wifi: brcmfmac: external auth
 support for Infineon devices
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>, Tim Harvey
	 <tharvey@gateworks.com>
Cc: brcm80211@lists.linux.dev, linux-wireless
 <linux-wireless@vger.kernel.org>, 	hostap@lists.infradead.org
Date: Sun, 25 May 2025 14:24:39 +0200
In-Reply-To: <c3ed7fd4-f4ac-4d23-bed1-78d5bd615ec5@broadcom.com> (sfid-20250525_114722_653916_1A8EE084)
References: 
	<CAJ+vNU2pLJd696Fc_98arrzs8QK70HfstPrZv6zVJm3G13REHQ@mail.gmail.com>
	 <196d7901068.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
	 <CAJ+vNU009QSwYopCFzZtwDNXDBppx7L4v_ZKtmNZ=5ep7trOSA@mail.gmail.com>
	 <c3ed7fd4-f4ac-4d23-bed1-78d5bd615ec5@broadcom.com>
	 (sfid-20250525_114722_653916_1A8EE084)
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

On Sun, 2025-05-25 at 11:47 +0200, Arend van Spriel wrote:
>=20
> > [  161.608607] ------------[ cut here ]------------
> > [  161.608646] memcpy: detected field-spanning write (size 104) of
> > single field "&mgmt_frame->u" at drivers/net/wireless/broadcom/brcm8021=
1/brcmfmac/cyw/core.c:307 (size 26)
>=20
> Okay. I do not run with that Kconfig option. Will have to look into how=
=20
> to fix this. Probably need some kind of annotation. If you know what is=
=20
> needed feel free to post a patch for it.

I think just copy to mgmt_frame->u.body instead of ->u itself.

johannes

