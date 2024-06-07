Return-Path: <linux-wireless+bounces-8715-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 018A3900B3A
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 19:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 269551C219C9
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 17:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C33819B3D2;
	Fri,  7 Jun 2024 17:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="owbLSfDZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7593F19B3D3
	for <linux-wireless@vger.kernel.org>; Fri,  7 Jun 2024 17:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717781199; cv=none; b=p4I6Y5Fs5v+9vmCWwPtIbrby1wAn7hVw76n2rBQ05yqNAaqFnDFceGPrARLwPOdUsjgqms2296eAfSbl6JUPKdUP8QGS99v8C7t/oBK0WZI9izFHWu6bUlfnxDbM7JoPi2sTaXiP/iQK5wyg4NJJHRwz6Wdjc97+e2Xy4zPyKoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717781199; c=relaxed/simple;
	bh=LEGwDRIs8v1qbJnF2Cs6SPJOmrT3TiKiSGYXhLy62S0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FqnOLNijitJS3iQ232q6TojrNQObTrn7MzrqX88AjIRbodnLDs3qKTGItsKZkkxgQaxlGwvmKBwrZNXMeDmTyEJmx6cekK/87xZZxMCn4OuRG8DWTI+0vM+Y+QatOx8BWVKHBo96ygBTHkujXXg9gj0CpMSXh49ktrxwBIF9Uiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=owbLSfDZ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=LEGwDRIs8v1qbJnF2Cs6SPJOmrT3TiKiSGYXhLy62S0=;
	t=1717781197; x=1718990797; b=owbLSfDZ8w9XK2QppsWFD7ggYqm65TeeFLXhwbarW0SdJMP
	ddEJbD+3i/rXLr0TMb1QqktB6NH9rQjfItiOuMJ76VBldPl0i1vJbWM9kqjNPvcilAlffzqTtDZ47
	WKPCZZmF+vStNcx5aTyqomWEHM9i6+B1+M7Nlt9VZmMWFyP4RioV3k7ED/jQtSC1xaPGVZMZrxFuj
	UJW9WQyChsLflV/yh1lHhkFQF/ymd7zXukbpjeEiYTjKt0wdMgRvxg9KTPBJgx2Ie+b+yD6noLVL1
	baE0TtKj5APf+QLbwYeENXAoGA1QWTMVnySJ44ewcdPCYLhpRwUvmY+sKxYaqw5w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sFdMI-00000001ObR-0nSo;
	Fri, 07 Jun 2024 19:26:34 +0200
Message-ID: <c3ce5ca1cb434c2ff4b9ee3a1be9d81bf5ae01b2.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: fix NULL dereference at band check in
 starting tx ba session
From: Johannes Berg <johannes@sipsolutions.net>
To: Zong-Zhe Yang <kevin_yang@realtek.com>, "linux-wireless@vger.kernel.org"
	 <linux-wireless@vger.kernel.org>
Date: Fri, 07 Jun 2024 19:26:33 +0200
In-Reply-To: <639f8c2b59eb42beb56b28e53307886a@realtek.com>
References: <20240523082200.15544-1-kevin_yang@realtek.com>
	 <173a8af7e9b544c496f2aee2bb47fca99279873c.camel@sipsolutions.net>
	 <639f8c2b59eb42beb56b28e53307886a@realtek.com>
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

On Thu, 2024-05-30 at 13:49 +0000, Zong-Zhe Yang wrote:
> Johannes Berg <johannes@sipsolutions.net> wrote:
> >=20
> > On Thu, 2024-05-23 at 16:22 +0800, kevin_yang@realtek.com wrote:
> >=20
> > [...]
> >=20
> > This checks that the *first* link the STA used isn't 6 GHz, but maybe i=
t should be *any* link?
> >=20
> > But then again, we don't really need this check for an MLO STA since it=
 will have HT supported
> > unless it associated on 6 GHz. Maybe we should just not do the check th=
is way, but check if it
> > has HT or VHT or HE or something like that?
> >=20
>=20
> I think there are two points here.
>=20
> 1. the way to avoid this NULL dereference
> (Current patch just followed original logic and made it runnable on both =
MLD and non-MLD.)
>=20
> According to comments, I will change to check ht_supported/vht_supported/=
has_he/has_eht.
> Then, it doesn't need to reference chanreq.oper.chan here. So, there won'=
t be NULL dereference.
>=20
> 2. the check logic when MLD
> (Current patch didn't consider this properly.)
>=20
> According to spec., BA agreement does once per TID and apply to all corre=
sponding links.
> So, I am thinking maybe I check the conditions on all valid_links when ML=
D.
> And, only check deflink when non-MLD.

Well, spec also requires that you have EHT (on all links) to be able to
do MLO in the first place, so you shouldn't be connected. IOW, checking
one link should be sufficient? And that can even be deflink, because for
a STA that's always used as the assoc link (unlike for vif)

johannes

