Return-Path: <linux-wireless+bounces-27209-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09909B5136E
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 12:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 283271C261DC
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 10:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA094253B56;
	Wed, 10 Sep 2025 10:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="LAkt5r+H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47114253355
	for <linux-wireless@vger.kernel.org>; Wed, 10 Sep 2025 10:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757498736; cv=none; b=YDK7Hom23mGBfzLCsUsk8Afz3MRyt1LD/FK9VpBJ2gWiMD5SYQ9/b2WrAQFdLzhJPCSogIEVZajlpN/yhUhbdJ/dM13576RjC48gxB42uDF5Q+EUH23dB5A4dzphJqyAtHpTyG3wYLFk2MRn4PImrF9hhRYj6CPPTlaPlrApjvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757498736; c=relaxed/simple;
	bh=vUPrIbiOrHVWOK7/Od11YAkGGZwKIn0/wBjBNSnDSpQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qj4QdjGq7SdjthOl3OjZ1VFeI4NYXaezgXypXkG5I34IYjBmsmJpv6phPFaS+g0qi3X9YP2fRImZ4Q6Hn0MIYZdQIj1vshPleIkL55jYv0R7rRYrxwyR+aWu4V5kJIMOMQRQU3rxk0KdcYyZ0u40/x6DSUu6RTIokaSHPrubqlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=LAkt5r+H; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=vUPrIbiOrHVWOK7/Od11YAkGGZwKIn0/wBjBNSnDSpQ=;
	t=1757498735; x=1758708335; b=LAkt5r+Htt7B6Qe6V6cppC8Er1/adOjUBzPNjG1qCy22Rq0
	eCqSzEa/WowpM1UY8igLdbyDTzIdfaK/HQ9xOxGpByzctzqrjNUmJq/sBTPFRoMYx25nwmc2GEBSe
	JehXZNkIH1cnpXNajlbOETYQZXE+HzCnfsFf7wwR7ky6NeFJIftwfYmv1Bg8z6Mw8XRaESCdEPn6P
	iKG+l+4NMo2djGcipuL+643JGaU9X4pjRJ2pk2M2BsJ5C7rDiMWsPPaJ6wPp6pE9ZW5oEVOt9H8P/
	slVdF5sY/7TkVV9me44JUFyN6/95QZPtGNm27oO3DmlqUKq+UPdItxnfMDb7336A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uwHhf-0000000Cc6d-2LlK;
	Wed, 10 Sep 2025 12:05:27 +0200
Message-ID: <5074d1cada1bd429aff921529621e934a6234106.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next] wifi: cfg80211: cancel background radar
 correctly
From: Johannes Berg <johannes@sipsolutions.net>
To: Janusz Dziedzic <janusz.dziedzic@gmail.com>, 
	linux-wireless@vger.kernel.org
Date: Wed, 10 Sep 2025 12:05:26 +0200
In-Reply-To: <20250908180813.2414794-1-janusz.dziedzic@gmail.com>
References: <20250908180813.2414794-1-janusz.dziedzic@gmail.com>
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

On Mon, 2025-09-08 at 20:07 +0200, Janusz Dziedzic wrote:
> Release background radar ownership after cancel
> delayed background cac work.

I _think_ I see why you might be doing this change, but really, you do
need to have a commit message that actually contains such information...
I hope that doesn't come as a surprise :)

johannes

