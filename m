Return-Path: <linux-wireless+bounces-21448-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B08DAA86094
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 16:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE0A8467940
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 14:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15BF1F3FC2;
	Fri, 11 Apr 2025 14:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="RWVKY+cv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0961F3BAA;
	Fri, 11 Apr 2025 14:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744381744; cv=none; b=EkrKa3Yp744o6WIWVdl6+7e/jRbKoEnhSwNkrEtBqQhQ28DXWmGtDAlbrHkfGHHUTMmz+eVl7LxZdd1cBRWZjijG2Pijx0ZAIYv78MuC0jloQehh4uM9qMvVm/SQGeYwOk0ppfeBJEiPLO0zLbUrHw6oj/jIT1KOrz2j6oIWLLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744381744; c=relaxed/simple;
	bh=/m0T6nXYEzl8fOAVMaz0qT1vqiFYywpkevcH8Iwmj14=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JGPYggc/ct3c3fq13xQaO+wExPIrOLsnWogHJBpwibOVnXPTFCoj0z5u9C2ot2Ba0jv5pJHvtRtV2tb+G0/rGdEA4FE3Xsljp0tIIB2O7RyMt9b+2BeCGixdNoMRA1jCGExN67LN2wUuyKeNGqjy8N+SK4Lw+cJg6vJE9AFTCqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=RWVKY+cv; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=8xtjiQORwC/tRzRJXL7FfuWzyCHpFww45/vS8cjqMb0=;
	t=1744381743; x=1745591343; b=RWVKY+cvJjEsNuKfpUEbsP5gzr7J5zCQsqt+kcwWk2TSxd8
	rNnj6a6nYDoM6b8wQjx34b+8XxlbIpe1xTAEnlSipKB4VYg8GpUJ+igCZ5cxOuhcLH9OBp/bR1/18
	2mgfHB+lqJ1VkEaT8f7QxQYFbwcBI34gSYY+S6qHE5adOY1ghY3CvqW5UUBmH28He9LEapBDxbtVY
	eL5nCDM0Y03y8tpRjAm/oS+vcAz/l+FNrSeTlG/0U8dm2J7xvdp4x8B2FZPAxmAaUqnkbkR6vKADU
	vu/zoPlO+vW6RUaQZy5JMgmn1+QGUhWte1huap0NnTVmwGda4eZvJ32XUYRj/apA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u3FNM-00000007hNS-3RWa;
	Fri, 11 Apr 2025 16:29:00 +0200
Message-ID: <ce52ea6c0c1634646c32ed1df098767bb52ec1b6.camel@sipsolutions.net>
Subject: Re: pull request: wireless-2025-04-11
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Date: Fri, 11 Apr 2025 16:29:00 +0200
In-Reply-To: <20250411142354.24419-3-johannes@sipsolutions.net>
References: <20250411142354.24419-3-johannes@sipsolutions.net>
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

On Fri, 2025-04-11 at 16:22 +0200, Johannes Berg wrote:
>=20
> for you to fetch changes up to 85bf1ae049468d6cdf8f3876819c1f526f10ed92:
>=20

Oops, I messed up, it really is 0937cb5f345c79d702b4d0d744e2a2529b551cb2.

The tag is correct:

tag wireless-2025-04-11
Tagger: Johannes Berg <johannes.berg@intel.com>
Date:   Fri Apr 11 16:24:22 2025 +0200

Just a handful of fixes, notably
 - iwlwifi: various build warning fixes (e.g. PM_SLEEP)
 - iwlwifi: fix operation when FW reset handshake times out
 - mac80211: drop pending frames on interface down
-----BEGIN PGP SIGNATURE-----
...
-----END PGP SIGNATURE-----

commit 0937cb5f345c79d702b4d0d744e2a2529b551cb2 (tag: wireless-2025-04-11, =
wireless/main, wireless/HEAD)
...

johannes

