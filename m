Return-Path: <linux-wireless+bounces-20840-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7445A715E6
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 12:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D289017451B
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 11:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514051DDA3E;
	Wed, 26 Mar 2025 11:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="dNG3PfP4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47E71DDA0F;
	Wed, 26 Mar 2025 11:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742989002; cv=none; b=cnwyKz5AHamD0q50kDEXiXOZHHZ7fqA16lFsUJfvYJM0EHJJdAnkRwVpzAVx6Uod1z6Z0PaNQyamxnksV1QQnnQCWt1wlM0TuuFAiB5ls5ahoypGA8zDupb4j5kIKl9ICeure5Ycg6uaxiE3TcDfbh8/ulF6ecJf4hjrfuiFsig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742989002; c=relaxed/simple;
	bh=UIcGMZzqapku84tGCnvJpZjCZta4/XVKhGVywNMnxxk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=onbGBiUU8LBeOP0soyyf3/Xn8JL38zvwweDSxSsWQpASLn+qclVCfq5dcoPkVEBD9Ef9nRkrJpoEtEt8LjAgi/scFIi43Bud7VDYJWlw6A9VcSLa6u0405GkoSjXizu6e6vguCXzoXRMBGkXoFuTC3etIpjyb53DF4NUMEUKMmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=dNG3PfP4; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=+l+9QIp9TGMef6UlAbKvhJo8zBrueVnPBn7jR2ntm8o=;
	t=1742989000; x=1744198600; b=dNG3PfP4+7kowdnvmQ8sXBVlYPaUkw16T1iUHHh/09EmZst
	n3JDfLlTqmt+3Fti1j0rpnP6L168zhPGRBnlbXBuSEDk0gQqsMWJi1StyLAlkmScPX3fi5Raocemk
	DWZOupKIGF4/592mMS3pD8s8z9g/AE1Hbh+r+1Ccv7aQG6+6a08shPPHVE0c8aCdTTks2C//ViON2
	iPPtNNM1m9dp28C3m9aO8eQSLOsNtzm15qF0V4hZCxLneeaRo9Lb1zuH4bYd/zMQjhx71WLSAteYn
	QUqC4s35641mXkoY9h+J6AjnBV0cnzeu2ngpBMR6gEqG8gKeQw9WRp6/MGvJan8A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1txP3g-00000006AxC-2Rap;
	Wed, 26 Mar 2025 12:36:32 +0100
Message-ID: <0abd9752e86a9cc4e7bdf544a6eee9192c57f69c.camel@sipsolutions.net>
Subject: Re: pull-request: wireless-next-2025-03-20
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Date: Wed, 26 Mar 2025 12:36:31 +0100
In-Reply-To: <20250326043427.3999be11@kernel.org>
References: <20250320131106.33266-3-johannes@sipsolutions.net>
	 <20250326043427.3999be11@kernel.org>
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

Hi Jakub,

> Not very urgent but doing my "pre-PR weird arches build testing"
> I see a lot of:
>=20
> make[1]: Leaving directory '/home/kicinski/linux/build_csky'
> In file included from ../drivers/net/wireless/intel/iwlwifi/mld/mlo.h:13,
>                  from ../drivers/net/wireless/intel/iwlwifi/mld/mld.c:17:
> ../drivers/net/wireless/intel/iwlwifi/mld/iface.h:169:5: warning: "CONFIG=
_PM_SLEEP" is not defined, evaluates to 0 [-Wundef]
>   169 | #if CONFIG_PM_SLEEP
>       |     ^~~~~~~~~~~~~~~

Yeah, I apologize. We had this in the robot for quite a while, but it
either slipped through or it managed to not hit it. Arnd already sent a
patch for some of these, and I thought we also already had a patch for
this one. I'll check.

What's the best way to get it to you now?

johannes

