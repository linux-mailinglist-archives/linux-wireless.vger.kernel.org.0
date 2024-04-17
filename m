Return-Path: <linux-wireless+bounces-6454-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2868A859E
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 16:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA6E4281951
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 14:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0421411E0;
	Wed, 17 Apr 2024 14:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="q4vG7qCd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F68513A869
	for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 14:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713362999; cv=none; b=EfGIlyjm+FgdleykIM7TwodkGUwF3MzIaQfUDdvNKh08ACwrYTgmStRRMW2kNKL4dj2dRpR+duWDqG53/uxrPvqmJ4jf8/Z7FPGGxDSbuGBU6/Tw9XLPcHI++GdA4jX77YGC1T2WuEDZaYV40vHAkq20W1j2kVxHi8ZkbtOUkB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713362999; c=relaxed/simple;
	bh=x5Uz3gRgyxT1+IqFsdR7wre3wK47p8rTToCNr6IsUm4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bX/eR2pbxnPUshS7WETM9Nb+6u5zV0lPpF+1Lgfyq6pZTC1ujOlHRdQqsIHaQdcOi4eAbtuli6yMHRVnVzIi+PNw29lEkinaWQ2Z4yh9xE12PUN/430xifKYg5Mm6oZ+LWhoR/bgSS6TzpKXJsJXy7hfPELFQfypt17XRmhK0OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=q4vG7qCd; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=4wcEcjDMioCJvdEJBFh4Rw7VmBBlM0ZDq9pyplVl+bw=;
	t=1713362997; x=1714572597; b=q4vG7qCdB+oBBCjgtDWLpaGwZfUY+MLHMAT9qMlBlSbQCMe
	w4kjRF5vwL8sOZWo6mNQ+2izQHPK5cplFPGq5VF9v98iw1eVcE0Q4inK4Y9m6pxPyS3AXdF9A2Nz9
	hu/rGe+fmBXElgV62nLBimofgNTm/WPv+h8fxcEwbtDDbjJhNKin72YfIE6DthjucyRvwuXuFl4wk
	aGwssDo9qIieVpicYoqZiYMeYin2wMYwNDjrDp3UodkyyShRRjkieEGtNYAgw0DXi5NmOfez/kE8o
	lzPV4Igti6lJstJ157PQxAXVx3qPIHS7VtOfggiXj84yyfGqXBgOcZ2S9c2+a50A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rx5yz-0000000B0LN-3rBN;
	Wed, 17 Apr 2024 16:09:54 +0200
Message-ID: <2278e0d1026ed336559adbc9ffbf6e945eba422e.camel@sipsolutions.net>
Subject: Re: putting future iwlwifi firmware into intel/ ?
From: Johannes Berg <johannes@sipsolutions.net>
To: Mario Limonciello <superm1@gmail.com>, linux-firmware@kernel.org
Cc: linux-wireless@vger.kernel.org, miriam.rachel.korenblit@intel.com
Date: Wed, 17 Apr 2024 16:09:52 +0200
In-Reply-To: <b7876373-08d9-4948-a49a-e79f42f3abcb@gmail.com>
References: 
	<fec30176f437d565d4c1dfc4944373f117d75a64.camel@sipsolutions.net>
	 <9aa64d50-cb4d-4118-bc27-86c23410ff8b@gmail.com>
	 <f65765b29ea7503fbbaa5e047c95a82de6fc2083.camel@sipsolutions.net>
	 <b0e70576-a53f-4d03-a503-ddf1f98bbe9d@gmail.com>
	 <b712f48a3e35221b7ff7f4c8cb495b5159bdd367.camel@sipsolutions.net>
	 <b7876373-08d9-4948-a49a-e79f42f3abcb@gmail.com>
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

On Wed, 2024-04-17 at 08:58 -0500, Mario Limonciello wrote:
> >=20
> > Yeah, I guess. Though not actually sure, do we need to support new
> > kernel + old firmware install?
>=20
> I'd say you should.  Here's a few examples of why:

Right, agree.

> So yes; do the symlinks when you move directories.  It's one line in=20
> WHENCE per file that you want a symlink.
>=20

That doesn't achieve it though. It means the driver needs to try for the
file in intel/ and then fall back without the intel/ if it's not found.

Or just look for new files in intel/ and old files without intel/, but
then you don't really need the file move/symlinks?

johannes

