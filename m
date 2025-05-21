Return-Path: <linux-wireless+bounces-23215-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2868ABEFCC
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 11:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA8643B2A1B
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 09:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954462472B6;
	Wed, 21 May 2025 09:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="X70X2RvM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14653241698
	for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 09:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747819848; cv=none; b=XINKCbvWGLpY0CH8S9e/QXGrJPupcXcct1yrLCaZjCYwqLjcHt26otkz21RK6yGOE/5wTDAvI10UQfSIPkfwEUhqIX5cVobum6che74obLkv22rP6v5KbQ6+zCISfk/E0Cuxu+XJlY81CQhVQebCs+ZgE8s6jnj47MjDNNTDTFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747819848; c=relaxed/simple;
	bh=acRhUQ+FqY68mOIWChHIo6OXaX9+AgIxaIKITNQXv5k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EunnV0WRjAr3I/wU5IT0AFRHd32vx282J6GFuCJcQIbFmqXtUCutf0fjhzlGiEJKtCkFX4VWXJ1jyOkusSDo1vO1GgiQgUG2d7omU0+cdLyHJT+K0275krlzoOibBY+HoN+PwaRzZu5JBOzPq50zgMsLvb+wo4eoXbY/WIIxa8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=X70X2RvM; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=acRhUQ+FqY68mOIWChHIo6OXaX9+AgIxaIKITNQXv5k=;
	t=1747819847; x=1749029447; b=X70X2RvMsWXSRDj9Qs9lwN5t569+qYZ63TkRJvCAeMuvHgs
	5+U1UfmYTm5n5a4fcuaqgC0bJkQZqcqh5WeI5cCREU6iZROy5uHf0B+gqGTqnOCs2cM4cFOkWevf5
	BVEc5UTmTgRZ99pemwxjtXCLF7MNYZWuVGqnfN4m6lKGZb8zY4pt8qgPxlA7HVXY4NFnsYahdQKOD
	6l0TrIzipt/E9WsE8ljraDWnzmPVs/XMJVWjhPyc+LrlwxAGcQBzp8tjHmLxUpBw996tcXmYZgemB
	qPYOiT7kpsyl6UXrCv8rheBb4kehpr1P48xwNvTUkCS954DZhkG2jLko70p7Lb8g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uHfmd-0000000EA7g-36zi;
	Wed, 21 May 2025 11:30:43 +0200
Message-ID: <6341cc8198b7054f9242821d8a7db2d2f12b92eb.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v9 3/3] wifi: mac80211: Set RTS threshold
 on per-radio basis
From: Johannes Berg <johannes@sipsolutions.net>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 21 May 2025 11:30:42 +0200
In-Reply-To: <5ea169b9-8f63-46b7-8f48-40d8caf97ac4@quicinc.com>
References: <20250429040048.3356960-1-quic_rdevanat@quicinc.com>
	 <20250429040048.3356960-4-quic_rdevanat@quicinc.com>
	 <e98a1b2791eaef6ec12ae2f9d9060cf6eca47d46.camel@sipsolutions.net>
	 <3850d61a-8c6d-4cb5-b56b-d53a4a8afd32@quicinc.com>
	 <6ae5c6bd10fd7eade50bba846a701ba5846bf811.camel@sipsolutions.net>
	 <6c4fd852-c70a-4d7e-ac34-3a7f375b98ab@quicinc.com>
	 <78e46648e8bbaec139df2a3d11a2408fe5973afb.camel@sipsolutions.net>
	 <694e3a16-c2d9-41b1-8f6f-033c6b1ef0f3@quicinc.com>
	 <157dd058a06a2f111c52459610b0de7057a5d557.camel@sipsolutions.net>
	 <c2c54fbf-c9d5-4a4c-982c-dfcd5b6d9624@quicinc.com>
	 <4c9a74c436bd14b49fc9a15e7f9c68cb446baa84.camel@sipsolutions.net>
	 <5ea169b9-8f63-46b7-8f48-40d8caf97ac4@quicinc.com>
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

On Wed, 2025-05-21 at 14:58 +0530, Roopni Devanathan wrote:
>=20
> On 5/21/2025 2:56 PM, Johannes Berg wrote:
> > On Wed, 2025-05-21 at 14:55 +0530, Roopni Devanathan wrote:
> > >=20
> > > I think so, too. As mentioned already, I can change the datatype of r=
adio_id to
> > > int, retain the NL80211_WIPHY_RADIO_ID_INVALID value at -1. This woul=
d mean that
> > > passing default value to individual drivers will set RTS threshold to=
 all the radios
> > > in a wiphy, or it will be the case of single wiphy architecture.
> > >=20
> > > I hope this change will be sound and standing?
> >=20
> > Right, that sounds good. Except it still shouldn't be
> > NL80211_WIPHY_RADIO_ID_INVALID since negative values are not part of th=
e
> > nl80211 API :)
> >=20
> So, why not, we give a value of 255 to NL80211_WIPHY_RADIO_ID_DEFAULT? Th=
en, we can
> retain u8 datatype of radio_id.

The internal "all radios" (and otherwise invalid) value is _never_ part
of the API. Quoting myself:

> In the userspace API we have an attribute that can be in [0, n_radios-1]
> or unspecified if no specific radio is intended, which is how it'll work
> with existing userspace anyway.

So no, regardless of the value (and I still think -1 is better), this
define simply doesn't belong to the nl80211 API.

johannes

