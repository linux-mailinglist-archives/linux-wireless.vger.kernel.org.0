Return-Path: <linux-wireless+bounces-23211-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E4FABEFAC
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 11:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63E454A1AEA
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 09:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1090115E96;
	Wed, 21 May 2025 09:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="lkXbMQwt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673B5238D56
	for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 09:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747819212; cv=none; b=NtQafIpX1OYRJ9tEwnVzOyBnymwNvVtdKsNp+2HEnIqk8KMQyw9+CwI5+88UPZbinVgdrMe3BWDwsFp29VAUXY26mA54Ybf90PJzWry+YHDduzqNvW2Ea0Q3dFhu4ZZzKTAdgjfqU/4QBCxPFSwfg92+eYzuqWwlyzG6oVQ3Gxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747819212; c=relaxed/simple;
	bh=bT3ei4u84wfozC6evAkTnl6stU7D95PbA9itTzdkz+A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PE2s8IaI/GyNNNnYILrU5nsJCM2eoeQT6P0OIdsVp5wI4apnUNNjHGrMkRFP2mGPUDwsk+PzTKwbrOCdqOdjM4UmVEYtElf3ZZ3CzZo8rU4jKACyCoMz+F8GswqkzOYjquMtV03dA0WxFUTmouaFugar1cVr3YtfPMugWzglvzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=lkXbMQwt; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zAJeXQf2nAj8aUwSzG/mnNsfhA0dZXVv7Ra/neHGv50=;
	t=1747819210; x=1749028810; b=lkXbMQwt1T4Qu3C2hC9EyMFHMzUl7KY4VBw0VkrjQhJTK7o
	ysstroletnOpz35SagqNl5+8VFpEzokgeQjhgq9pQN2rh/rACmcg5G7dmZW52XHHW2q2d1cdhwear
	rjir5DVv9AdIlIeaToK/Nxatbz0SKadTxKxgIiwT2uhlOPGvWjCzeLrh4Z5aKpI8UfDR6JG4vSSOG
	tLxuM/cVLonBJ3xSDvEkPnZongvXiGDq4MuvV8bXgh7sF++dpb1kvsO3mC6TOJoprm0TDF85zipYI
	oUxu62SlUD9j9DZbHks1lP3vlcaqR3BohM2daWYT4ZGc/TYhRAtyL/4NGf3bM33g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uHfcM-0000000E90x-3KuD;
	Wed, 21 May 2025 11:20:07 +0200
Message-ID: <157dd058a06a2f111c52459610b0de7057a5d557.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v9 3/3] wifi: mac80211: Set RTS threshold
 on per-radio basis
From: Johannes Berg <johannes@sipsolutions.net>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 21 May 2025 11:20:05 +0200
In-Reply-To: <694e3a16-c2d9-41b1-8f6f-033c6b1ef0f3@quicinc.com>
References: <20250429040048.3356960-1-quic_rdevanat@quicinc.com>
	 <20250429040048.3356960-4-quic_rdevanat@quicinc.com>
	 <e98a1b2791eaef6ec12ae2f9d9060cf6eca47d46.camel@sipsolutions.net>
	 <3850d61a-8c6d-4cb5-b56b-d53a4a8afd32@quicinc.com>
	 <6ae5c6bd10fd7eade50bba846a701ba5846bf811.camel@sipsolutions.net>
	 <6c4fd852-c70a-4d7e-ac34-3a7f375b98ab@quicinc.com>
	 <78e46648e8bbaec139df2a3d11a2408fe5973afb.camel@sipsolutions.net>
	 <694e3a16-c2d9-41b1-8f6f-033c6b1ef0f3@quicinc.com>
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

On Wed, 2025-05-21 at 14:47 +0530, Roopni Devanathan wrote:
> >=20
> Yes those were the case. The history goes back to v6 of the patch series.
> Quoting your comment:
> "And why should the attribute even be signed, when you explicitly reject
> negative values anyway? Seems like it should simply be unsigned?"

Well that was regarding the _attribute_, you had that as NLA_S8 at that
point.

> So I came under the impression that it would be better to change the radi=
o_id
> datatype to u8, instead.

Oh, well, I didn't really mean to give that impression.

In the userspace API we have an attribute that can be in [0, n_radios-1]
or unspecified if no specific radio is intended, which is how it'll work
with existing userspace anyway.

In the internal APIs, using -1 with a properly signed value seems
better, since we don't have the option of "not specifying" an integer.

> Now with this, (u8)-1 would give 255 and when driver
> changes come in, I was planning on checking if=20
> 	radio_id >=3D wiphy->n_radios
> If this condition returns true, I was planning on setting RTS threshold t=
o all
> radios in the wiphy.

That seems pretty odd, -1 for an invalid value is much easier to handle?

johannes

