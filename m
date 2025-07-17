Return-Path: <linux-wireless+bounces-25603-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFE4B08E75
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 15:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E006B585C95
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 13:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF7E2E6D10;
	Thu, 17 Jul 2025 13:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Goog9wO2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52762EAD0B;
	Thu, 17 Jul 2025 13:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752759969; cv=none; b=qQkRxi2/W+dtvlOSUzjTIht0CwDfX8nJoSdsGGgjnggfEjI0cLdrKi51HhcIuT0cc21zMElrMhmOcxm9Grs7wJBc4fbkkezVKkYB0zZZD27fQjhKXs1pJI3/JnfRZZ58/SAl5prykHVgTHu21T6vpVKlo6Jko7AEVrb7f+jTg9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752759969; c=relaxed/simple;
	bh=xYi0/WapeRzpmbObHuOB/kY1akJu7pL4zSBarvKzMK0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h0ca1hjUsyZodD28iC9SYmz75cSbidgFVMakesAAXEXTHk7M+h+D7Vd/1kfZDAgeIsIN9kOkw5yU3xNcl2X4gQt61NLwSuhNSozUF3L+rYalACBz0vVj2cyqdS/7PQwaxLT4xtKyXcSoaxeR8D+QEKx3hjZjO4+vgvk14cOtl00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Goog9wO2; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=xYi0/WapeRzpmbObHuOB/kY1akJu7pL4zSBarvKzMK0=;
	t=1752759964; x=1753969564; b=Goog9wO2TvJ+urvScy3UGVhd8bgY771IiukNU3TldgIG5mK
	sQoGCTEJL0sygZ3dI97z1cSNBK0bvvQSL4off6llAEwqksQgDkyM8JW7w1VJzrTIn9VParI1uyorf
	x8zapUWHQJBPSxTgaYNAFiOPFM6qa+Tlo3JmJUkXPR2bFYyRqxx4e5fKLmWo02s4fNSVmFUOcTNxl
	re2fINwF0EyUDUg3NhTZmubxWQsHTCBRsmVGUmfc8Yo6/4lgL+g42O9aJe3dvHw96xRmuUTDoWYGc
	vKTSMzoNcKiBUnT/hQegifvESoNxz7tUbw2YJbv964ZTlVjhzZcCqSNxSMLbiEsw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ucOvx-0000000Aeey-2J22;
	Thu, 17 Jul 2025 15:46:01 +0200
Message-ID: <fa538ba960369497f6d65c1448ab7710f76aa078.camel@sipsolutions.net>
Subject: Re: [PATCH wireless v2 1/2] wifi: mac80211: Update skb's control
 block key in ieee80211_tx_dequeue()
From: Johannes Berg <johannes@sipsolutions.net>
To: Remi Pommarel <repk@triplefau.lt>, Bert Karwatzki <spasswolf@web.de>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
Date: Thu, 17 Jul 2025 15:46:00 +0200
In-Reply-To: <aHj4zS_3uhDRhzDn@pilgrim>
References: 
	<06aa507b853ca385ceded81c18b0a6dd0f081bc8.1742833382.git.repk@triplefau.lt>
	 <20250410215527.3001-1-spasswolf@web.de> <Z_jpq26P99qzPP1c@pilgrim>
	 <1df3a3df19b77e3b8d1f71a3a93c61221ff46a6b.camel@web.de>
	 <aHj4zS_3uhDRhzDn@pilgrim>
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

Hi,

On Thu, 2025-07-17 at 15:21 +0200, Remi Pommarel wrote:
> I have ordered a mt7921 card so I could reproduce this and finally took
> time to debug that.=C2=A0

Oh wow, talk about dedication. Thank you!

> The issue comes to the fact that mt7921 uses 802.11
> encapsulation offloading and as such we are calling
> ieee80211_tx_h_select_key() on a 802.3 frame.

Oh... Guess we could've thought about that, sorry. Though I would've
thought ath12k will also do that. Maybe not in the config you were
seeing the issue in?

> This function casts the skb data as a 802.11 header regardless the skb
> is 802.11 or not in order to decide if the info->control.hw_key needs to
> be set. So the hw_key is likely to remain NULL in ieee80211_tx_dequeue()
> and because mt7921 driver needs this key to be valid data frames are
> dropped.
>=20
> Will send a patch so that ieee80211_tx_h_select_key() does not try to
> get info from a ieee80211_hdr mapped on 802.3 packet data (i.e. when
> IEEE80211_TX_CTL_HW_80211_ENCAP is set).
>=20

Sounds good!

johannes

