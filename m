Return-Path: <linux-wireless+bounces-24427-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC87AE661B
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 15:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA98C3A75D7
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 13:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F4329B206;
	Tue, 24 Jun 2025 13:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="gtQ5a7A5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13BC23A58B
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 13:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750771274; cv=none; b=lj0CFaNIplDqchY0aawl5VdXdEQFTurnGsuaJPYUZJUPKtHCpdK2umDGJEaCFn95hAvVAa9IA6jH6oX4RNrJC1Zdve6Ts8rEui0Qr8L0RoLDs61ZdJn2uKsZKt0SlLStJ62yemd8CVA3Xm5nXO1bruE7Q0CpZOVcFOi0MEFdPKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750771274; c=relaxed/simple;
	bh=4RRvDc3Ysru6ZH5jhWVE9yJgAy1ytUe4Ep3CErAepW0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RDruN/qLoJJo1et0d06LuNe2qWkH7nxi8Ea6YKBrm9G/OUpuyjaESiLY/X6jiH8Fs9pE8y0L4L22M/dGL+ZulZc4iUINKzJUmVewTBtF/t7hvgK+h7esrP3XVkL1ZU88lU+OMFcYHs8WtLbCTP5qOSiPKCSoOy+Dy4uqhApoyF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=gtQ5a7A5; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=4RRvDc3Ysru6ZH5jhWVE9yJgAy1ytUe4Ep3CErAepW0=;
	t=1750771272; x=1751980872; b=gtQ5a7A5cv9SFaE42OmuysaAGGidKTdk5bS9IKSlznF6+x9
	hoJg+SuMN+El8B2rY4XbPnbjSw5M7rDUt1UP1XUmJsWeqSrDjFG5liiANWUT5P8KCknEsR9bW3KDa
	Qcnw9t/7urvZ5qiz+xWvLO3TduF22aj3JOS2mPi7q93AaxTl4eoBhEPiFr/w+jYyEZ80ySHII2LWR
	qJWWfHGy2BvdxeRMxU2sWxskbi9dqfq8V+jnqPHpJHNwkzN5x8nrmI+amnSVKcf10Kl9DOboA9wQ7
	5Sbe4OqzAAg9VRXxQkZN1fDVSAMPevzo0t6o3asdpGxFkmBYjvSp/X1RJG+BvguQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uU3aH-00000008rYU-0lux;
	Tue, 24 Jun 2025 15:21:09 +0200
Message-ID: <a4a41f5549a1becb441264c811e4378e6a0ee7bb.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v4 0/2] wifi: mac80211: Fix Rx packet
 handling in multi-radio devices
From: Johannes Berg <johannes@sipsolutions.net>
To: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 24 Jun 2025 15:21:08 +0200
In-Reply-To: <20250612121127.1960948-1-maharaja.kennadyrajan@oss.qualcomm.com>
References: 
	<20250612121127.1960948-1-maharaja.kennadyrajan@oss.qualcomm.com>
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

On Thu, 2025-06-12 at 17:41 +0530, Maharaja Kennadyrajan wrote:
> This patch series addresses issues related to the handling of Rx group
> addressed data and management frames in multi-radio devices with ath12k
> driver. These frames don't have the destination station information, unli=
ke
> unicast Rx frames, and are forwarded to all the active sdata of the devic=
e.
>=20
> This happens because currently there is no check to ensure if the sdata i=
s
> running on the same band as the frames are received on before start
> processing those frames.
>=20
> The patches ensure that packets are correctly processed and forwarded onl=
y
> to the appropriate interfaces by mandating the ieee80211_rx_status::freq
> for group addressed data frames and check the operating frequency against
> the rx_status->freq and forward to the appropriate interface when the
> frequency matches.
>=20

This series fails hwsim tests due to lockdep complaints.

johannes

