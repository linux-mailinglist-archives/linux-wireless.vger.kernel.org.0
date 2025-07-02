Return-Path: <linux-wireless+bounces-24764-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 663BBAF12A3
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 12:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DC2A4E185B
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 10:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7734024BC0A;
	Wed,  2 Jul 2025 10:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="EVkuAQH6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C721F25A33A
	for <linux-wireless@vger.kernel.org>; Wed,  2 Jul 2025 10:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751453561; cv=none; b=RyCR9UbGx+kK3v7z+AWJW+79+XTUEU09500CY7QKIUsiFxv/arsCsYJAVBwA4j3zRRKdEW3PJI9jon7FHJN2YhzUXGB5AyLPlf5bl6WA8b7SPlC7fUW6wQecbgRlgXu7dk9sGnRtXorTCpy/cBe3gAq1A2Lo5GJE/qY7AoXe5ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751453561; c=relaxed/simple;
	bh=VmjK8rNSM/xmVXwtCilTwJLsFw22/Z+6WW9SGkMh9Y4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UvSvp7jHBha1C2BbxKgKW3VGi3sA1qNIfpWKeT8KYlCV5e3w/aMpG2gPZI7ilZGTc9++Wlu5XPH7D9vvkk0LUPdkwnnRETbViy0djgKdMdXxD052ZyvK78NmiFqyl0S2Xiytk2XlEGxjJUmGEjs4bK2KxFszuwQnLQncDkhlX8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=EVkuAQH6; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=VmjK8rNSM/xmVXwtCilTwJLsFw22/Z+6WW9SGkMh9Y4=;
	t=1751453559; x=1752663159; b=EVkuAQH6SCK7X+OQphNh5F8SNe0wuOhXo4R+8udvxcQdpL9
	ruKfclB6qKKjOWQPnfLj9k3qdz/7eIuhuAhKMRMW/87rWKzrQnKdj+2AENXB8oTEL3QBPdo66dqrv
	UxuA+z5hvivVk0X8+nzdbKFmjQqSdjx1Zq83AG2z8xCuFOI8Sftzt37NXFFE+vXCc7GH2yS6Yx7oD
	qw2x3szAbkgj+YAEqTsXvDZZktQ0fHzybAAYVwwpZetNKWJNmAJLCwM7O0zd2q0Say7pFxArcG9BT
	J6KwSVSEjiDjuhw6LNgZmx0ROhqPPwCb6u0RE434QeaaraTDorbQvdCevvTzfUwA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uWv4m-0000000429T-40sT;
	Wed, 02 Jul 2025 12:52:29 +0200
Message-ID: <6c666ab6d83ba45f9f15643eeffed5d0f4770867.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: determine missing link_id in
 ieee80211_rx_for_interface() based on band
From: Johannes Berg <johannes@sipsolutions.net>
To: Michael-CY Lee <michael-cy.lee@mediatek.com>, linux-wireless
	 <linux-wireless@vger.kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Evelyn Tsai <evelyn.tsai@mediatek.com>, Money Wang
 <money.wang@mediatek.com>, linux-mediatek	
 <linux-mediatek@lists.infradead.org>
Date: Wed, 02 Jul 2025 12:52:27 +0200
In-Reply-To: <20250702104403.2738634-1-michael-cy.lee@mediatek.com>
References: <20250702104403.2738634-1-michael-cy.lee@mediatek.com>
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

On Wed, 2025-07-02 at 18:44 +0800, Michael-CY Lee wrote:
> For broadcast frames, every interface might have to process it and
> therefore the link_id cannot be determined in the driver.
>=20
> When the frame is about to be forwarded to each interface, we can
> use the member "band" in struct ieee80211_rx_status to determine the
> "link_id" for each interface.

Hm. Qualcomm has a similar thing with frequency, I think, and that
probably makes more sense for them since 'band' isn't unique for the
radio:

https://lore.kernel.org/linux-wireless/20250612121127.1960948-3-maharaja.ke=
nnadyrajan@oss.qualcomm.com/

Or is it not related?

johannes

