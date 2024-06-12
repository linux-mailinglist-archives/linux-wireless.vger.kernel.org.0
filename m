Return-Path: <linux-wireless+bounces-8848-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E14990502D
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 12:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11EED1F21379
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 10:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10D916E876;
	Wed, 12 Jun 2024 10:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="PSOlY9OD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC27833FE;
	Wed, 12 Jun 2024 10:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718187095; cv=none; b=Iq+mwsqzidNEJ3nAN+GZa7UiY0Qxxx4bM10SKHf8Fjbmp1XpDndL3Ulh8diiHV+uX1cIRk+AbhWufMiC73a/GkOPbCUJq+wmkt/7W/P6+kvBF6gJUYIdRjTp2y7p8erNZSFm5OWIl05NtgxXJPWr0v5yBljUmfX7vQagN5v+jkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718187095; c=relaxed/simple;
	bh=RQd4+UA7wdvXCU0xtrywxrKMF7w3HR0YIfUPyBtqszM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FrunK85IXs7PW7l6G/gCRxZ0PL7B6xmvC/tJEke/J7uDzP0apdZgmOr0t0Cy0FejhMOscT0mp4ORgg9NBVbCoUj8HMpeIrBwC5TRv7WOzrumWZCRMCm7b0+0UWc9OAXzyup4KK0H0lWSGklsBjeUlbkRwFmGQU3VCh2bic0C2tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=PSOlY9OD; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=RQd4+UA7wdvXCU0xtrywxrKMF7w3HR0YIfUPyBtqszM=;
	t=1718187094; x=1719396694; b=PSOlY9ODLRkRwakYnkQFm0rrtK/aRXd3G0dP0U+/XnbfgGR
	R5nXc9GOyMqYK4CZtVNrJ6vKnCkyO1YoDPzGEyiKSJ6ouYK+MOTG2pgeNjWvNrRezkxx0WhFd2Gda
	5GhZ0hh+NqCVyVKsFLVeEHBkISSTN0WNpferI6pbcdGSF1Ebb3+Lcp5kaFMydl2/MXQTPjotwTit4
	2PuHysyKxtbuvONuOzux3ouJ6G5qAdzD+w732XG2kYDMLE9YG42trICDalvlcegDoIRZ9s7EcB7ku
	Iea2tsLYsD23a1MNBUwg/arTPibd85foW+zidYsMh/sjAoTik66tRMOv6BFcDrNA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sHKwx-0000000A9DA-19lv;
	Wed, 12 Jun 2024 12:11:27 +0200
Message-ID: <be3576e234177f8da28be8ba37fd369c00fb548d.camel@sipsolutions.net>
Subject: Re: [PATCH v1 2/2] net: rfkill: Fix a logic error within
 rfkill_set_hw_state_reason()
From: Johannes Berg <johannes@sipsolutions.net>
To: quic_zijuhu <quic_zijuhu@quicinc.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	emmanuel.grumbach@intel.com
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Date: Wed, 12 Jun 2024 12:11:26 +0200
In-Reply-To: <b8610296-f8cf-4b61-9b64-ffb52b7ab251@quicinc.com>
References: <1717771212-30723-1-git-send-email-quic_zijuhu@quicinc.com>
	 <1717771212-30723-3-git-send-email-quic_zijuhu@quicinc.com>
	 <b3e0a55f0680b590537133bfb02cd1bbfd61a56e.camel@sipsolutions.net>
	 <b8610296-f8cf-4b61-9b64-ffb52b7ab251@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-06-12 at 17:43 +0800, quic_zijuhu wrote:
> On 6/12/2024 4:18 PM, Johannes Berg wrote:
> > On Fri, 2024-06-07 at 22:40 +0800, Zijun Hu wrote:
> > > Kernel API rfkill_set_hw_state_reason() wrongly gets previous block s=
tate
> > > by using its parameter @reason as reason mask.
> >=20
> > Using reason as a mask is perfectly valid.
> >=20
> > And checking that the bit changed also seems valid.
> >=20
> i don't think so as explained below.
> let us assume @rfkill->hard_block_reasons has value
> RFKILL_HARD_BLOCK_SIGNAL which means block state before
> __rfkill_set_sw_state(..., true, RFKILL_HARD_BLOCK_NOT_OWNER) is invoked.
>=20
> @prev should mean previous block state, @prev will have false based on
> current logic, it is wrong since rfkill have block state before the call.
>=20
> > We might want to not schedule the worker if it's not needed, but that's
> > a different issue, I don't see a real bug here?
> >=20
> the worker will be unneccessarily scheduled for above example based on
> current logic even if the rfkill always stay in block state.
> >=20

But yes, this is right. It's just not a bug.

johannes

