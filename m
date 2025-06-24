Return-Path: <linux-wireless+bounces-24419-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB39CAE60EB
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 11:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9904019259B9
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 09:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6C027B519;
	Tue, 24 Jun 2025 09:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="F24G3517"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E8F27AC28;
	Tue, 24 Jun 2025 09:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750757562; cv=none; b=L4VIiifqlMD/CxJRsEnxFZxkdDd/1n4pBg4b+l0+8fAqJU0p0c1tC44Dv9+PfBCV1QVzmgl+8AVhMezDN4DpauMLosg6j9UnbMU8fS1+m49X2d67ktc2DJL3ylkPfu4DuVTUUVGR87+8ijJuX4Nnv3mGSyCLtXbtETdf2vRz6J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750757562; c=relaxed/simple;
	bh=4OQsrJ+xjnNPW/a9zx2wFqIKLWmysKxqynS7O6HfJ6A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e80uNubflyuLkNfaROZjilj+NcKTlC2DwnSq58W0dtioHqlTFNXexygBZ6XX21D7qbn+xG3ct7Yzap+FfpYoifUO3t4Fus8cGdLdEXQmP0VdLz8MNXErSU6nHeW6bXUZHpkKbUULEZmNb7L4OkSZkTgpz6Kbk44eb9tySCKHHJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=F24G3517; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=gM/mStdZZqSQ6Ty5+QzIsuryaKtXTFCfMkKt8t3B8sw=;
	t=1750757560; x=1751967160; b=F24G351743tCu/L8xpU6EJrZ2H4MEF6+UBEglUKCkf3NjuT
	OXewqWpf4eiysGTqYM+pQXSNmf3yFBoc5OSYiYD+6/wir2vA+Ad2rpHlLxhoxGtof47jjJKKhYgEf
	tuuX7daKU5sv1VvubYond7BQOQAZ5FsrEOXGbEOlb57y4zOUS09jDgCYF5tHCVJrneL1Evnw+rRPd
	MMKnuxxH5zSQajXvat0VBcpssODTCb11FbVZVAZDBhIalFvvl5Cr0QbFtyak61IS3epMxHBAIL+cd
	PmdQVocG9rnIochH14ThRUdJcQDXwsPRFs1aLEhNfE8BxgARLNPTX4iXiWCwP5ww==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uU015-00000008jLg-21O7;
	Tue, 24 Jun 2025 11:32:35 +0200
Message-ID: <0b71b66f4e2a7e38ba78b1897675bbd5eb44c0e6.camel@sipsolutions.net>
Subject: Re: [RFC 3/4] wifi: nl80211: strict checking attributes for
 NL80211_CMD_SET_BSS
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev
Date: Tue, 24 Jun 2025 11:32:34 +0200
In-Reply-To: <20250604085539.2803896-4-arend.vanspriel@broadcom.com> (sfid-20250604_105551_659690_B4FF4585)
References: <20250604085539.2803896-1-arend.vanspriel@broadcom.com>
	 <20250604085539.2803896-4-arend.vanspriel@broadcom.com>
	 (sfid-20250604_105551_659690_B4FF4585)
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

On Wed, 2025-06-04 at 10:55 +0200, Arend van Spriel wrote:
>=20
> +	if (strict && (changed & ~rdev->wiphy.bss_param_support))
> +		return -EINVAL;
> +

>  	return rdev_change_bss(rdev, dev, &params);

You probably also need

	changed &=3D rdev->wiphy.bss_param_support;
	if (!changed)
		return 0;

(a) to force drivers to actually list the bits they want to see, and
(b) to not call the (partially now-removed) driver calls for "no change"
(or no change it cares about)

johannes

