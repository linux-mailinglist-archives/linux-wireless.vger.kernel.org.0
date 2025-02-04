Return-Path: <linux-wireless+bounces-18418-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC35FA27284
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 14:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3631B188525E
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 13:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE718C1E;
	Tue,  4 Feb 2025 12:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="b//TTyry"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA5B5228
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 12:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738673645; cv=none; b=hhqMqO+BRwIWC/Yy2NkXWB2vtk4mdzKPhBr+hg1eHPZo91rgQ+SxrjBUs9nz1bYDEbhjksdHZItmBK1dGRedpxSxvAf1n/fB5DDbbIAg7aMaa+PPD3RgLlrakQGTE+AO960SpUaQz3qMYa6rnLfhUrGM15PXGss1aYyZeHl7QC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738673645; c=relaxed/simple;
	bh=LAVgYOD4rF4WS2GfS0uwMY+mPcNk7ZktLakVsx8M6DQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dPnfVchYQc0lAnt1OsvfYG0jyS4jS1b6oidFbfKDb9VyiS0Xf54ZZ9/JAtxgeLSxbNgJek0plPmPexHr0rrKl4o8v2oBa8ZWmKTjwa1xCJYRKrIUrrwCX88ZetVyS7K5Ud1okBMw91+ZSORz5chKb0nX4oRiHYtnAszIGeMHO6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=b//TTyry; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=6v92cMHEkoJdILkC2k/hZmidlA+IpZU59skP4mPqt5o=;
	t=1738673644; x=1739883244; b=b//TTyrymqNZK1mpNo80DrW7hpxKrVTPl81qNbf9pA9NSYz
	Sa7MQwb0e+uvflqwYLflTg5X3hvn1UoQRjFbS3MZL5/PfMqGn3vZBQ3uZ20R5bw4QAomYx/DjUvbF
	Ox4yMieCFT79rvuAznq7249Cu4ts7lfoYKPM+16LcbmA9nosjm4xIoo/e0YHAFB7LHDDF5jnb65hy
	DhYM5coMjOyV5lOgBzep6goGgeicCuUUiafhgPCWaOT/Bh7xsTcPSwoaGna/Ogvqnc2YXDOFfGbQD
	zuAMjwAsAa6unQPFX0GXNh4FTTVsQDK3hPZiXa8DXQ0Acj2DMbG6usmqriIhwmkQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tfIR7-00000002gMX-33vT;
	Tue, 04 Feb 2025 13:53:53 +0100
Message-ID: <9e60d3a81e87649eb25e9bbeb599e1ed24050134.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: Debugfs handling for virtual monitor
From: Johannes Berg <johannes@sipsolutions.net>
To: Alexander Wetzel <Alexander@wetzel-home.de>, 
	linux-wireless@vger.kernel.org
Date: Tue, 04 Feb 2025 13:53:53 +0100
In-Reply-To: <20250204122617.8976-1-Alexander@wetzel-home.de>
References: <20250204122617.8976-1-Alexander@wetzel-home.de>
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

On Tue, 2025-02-04 at 13:26 +0100, Alexander Wetzel wrote:
> Create/delete debugfs entry for the virtual monitor interface according
> to the state of the virtual monitor interface.
>=20
> This fixes the following issues:
>  1) Debugfs is not getting an entry when the virtual monitor interface
>     is created.
>  2) Instead debugfs gets an entry when it's deleted.
>  3) And debugfs warns, that it already has directory for the virtual
>     monitor interface every time the virtual monitor interface is
>     removed again after the first time.
>=20

Started wondering, maybe it should just not have debugfs at all? That'd
also avoid the potential name clash, and there isn't really anything of
value there in the first place?

johannes

