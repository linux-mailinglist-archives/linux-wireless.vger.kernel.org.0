Return-Path: <linux-wireless+bounces-25252-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E82E9B0148A
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 09:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03B6018925BE
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 07:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEF31DC98C;
	Fri, 11 Jul 2025 07:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="sfsfGzvL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B919E1E834C
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 07:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752218692; cv=none; b=X2Tr6SVRlrwUH9uR/fKsQDeCToUVkrzzCix+h3NRqEqSepy9u2KOw5BOCKcysAD0HEuKNEqkP+JjkjElwXuIxRcT8boCOj7wdOu1fLvxIFiQ/o7zIfCNdkpey4kvMIfQyLLm2qUGrwRcjJGMxDNO/NxS7uPK1dpmWkqxNDAvXME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752218692; c=relaxed/simple;
	bh=yUWotihItNISQrSRjjG1VexvatR0fm/XMDxsh06nnSE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EiOFkR0vP8jHhRoV8zRokCAkIAlVfdaZxS3y8XHwIfH9v75ubsV0uMTXkj3Lpaq9n1B//z1WmAIIn2PGpjmwjxYl5i1/DhdlWK5j4movWln1FGYStrADAQJqkeJXUiK6krdnoYIGdHpoRJPoK+LJ/s4M2Mbt4KpG8/G4C18c8ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=sfsfGzvL; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=yUWotihItNISQrSRjjG1VexvatR0fm/XMDxsh06nnSE=;
	t=1752218690; x=1753428290; b=sfsfGzvL6bx9sAHHGpDapA4Tgr9o9Gow1lqYErrQbYZ+0mn
	myVlxjuNKkPAFoAWtbnc/idd39Ae7/EcXAT0honZUdxY6UDVKMNwcCELRLr25WcUrXsvbpu+uNXkz
	arkk7WBw4VkVPRCkNrJPKWetoxD1lFpi194FSu61GfQ7vB9s7WfU54hhvxHk4zO6iaVxKBM99dkX/
	2a0FOXc4MeVhhC36pXgryrDLpmsgmGAISFRwA11UBP1W8Mf9kfr/0caPQOt5SelfdZ0q1OQIqsrs/
	m5NE4XrunvcAcuQQUkvIHFnYcrJuzE5QywqB5SvuPQAsJfoa38wJX2xft8h8VNFg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ua87h-0000000FzDZ-0Spp;
	Fri, 11 Jul 2025 09:24:46 +0200
Message-ID: <11d4f96f70ec5ba470716f1aa6bb59e7d435ec89.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next] wifi: mac80211_hwsim: Update comments in
 header
From: Johannes Berg <johannes@sipsolutions.net>
To: Alex Gavin <alex.gavin@candelatech.com>
Cc: linux-wireless@vger.kernel.org
Date: Fri, 11 Jul 2025 09:24:41 +0200
In-Reply-To: <206f759a-f781-4a34-ab0a-2854c9129297@candelatech.com>
References: <20250710211437.8516-1-alex.gavin@candelatech.com>
	 <206f759a-f781-4a34-ab0a-2854c9129297@candelatech.com>
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

On Thu, 2025-07-10 at 14:18 -0700, Alex Gavin wrote:
>=20
> Noticed these in developing some automation.=C2=A0

Thanks :)

> I also noticed that 'hwsim_new_radio_nl()' returns
> the radio ID after creation. This results 'HWSIM_CMD_NEW_RADIO' command r=
esponse setting the
> error genl message error code to the new radio's ID.
>=20
> Both hostap and iwd rely on this behavior for their hwsim test automation=
, so I imagine the
> existing behavior is best left as is?

Yeah I guess we can't change that now. I suspect it also predates the
netlink extack/cookie support, so we didn't really have much choice in
how we return it then.

johannes

