Return-Path: <linux-wireless+bounces-23213-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C592ABEFA9
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 11:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0372D3B298A
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 09:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4F8237713;
	Wed, 21 May 2025 09:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Ssn5C533"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379A8221549
	for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 09:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747819578; cv=none; b=fdRWPOvhUauMbBiz4xEeWd0ll05CW29+lwHhwnC+FKwSSL3U0HBTOGQH97H1IOq57+NiZYjko/9vD6GYZ5kfUtFv3jrHFMCPCnckRcbkvIvs2L+xGIHrTBwjK4IBjjaChOZty9bx7AXJB28Meug/ljJ1yoump/8iMzjnQ1+cDzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747819578; c=relaxed/simple;
	bh=ytRuHbQltkipOwfD0WqthiYzNO1CH6u9jg61FX1c4TI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rUjoRkF8SASIvQT6d1/N61Qj+vEt9Ts6trL4qJ/eP4i6JGGfjk8Zo2RGe+Cfp5w3YCj0+JV/y//zC8DgvdNpoclfeL36wGb4ZhpEfTBgjT6dvZR1gyDkhd4swenqOHzx46q8Et0ezCv/SEbzM4ui8hymi4HsoGu8WEQ9zvQgEao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Ssn5C533; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ytRuHbQltkipOwfD0WqthiYzNO1CH6u9jg61FX1c4TI=;
	t=1747819577; x=1749029177; b=Ssn5C533cB1jYzopAe/a9dtE3I0Hq65x3alyhRdQSZiRma4
	cRUot6qJu9ea6R1rPBSupG15C5U2mUik9wNO2toZWVQxbDB+B/HD90C4ihvpxKSBiBNmAurh4WoK7
	MYqE+FYxxvj3HWfClSTJgu6Id1sYfy5l09YLccqxTt6fDMXEnfRz/j21cNMhgRi9e2rbI2gdsMb7g
	7rxvFjYICm2xSG8fX+t6pH/aop8itMJW8DKqVmf+3rTeyVsrw6v8di66OWamQtqtkURHKh6j7Qmnd
	/NvHg2/3tfPD0eZlNOuOCv+5wMHHAIEm77O86aX3k7K69uSa3U+ptTzXZe5TIAAA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uHfiG-0000000E9eV-3sVq;
	Wed, 21 May 2025 11:26:13 +0200
Message-ID: <4c9a74c436bd14b49fc9a15e7f9c68cb446baa84.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v9 3/3] wifi: mac80211: Set RTS threshold
 on per-radio basis
From: Johannes Berg <johannes@sipsolutions.net>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 21 May 2025 11:26:12 +0200
In-Reply-To: <c2c54fbf-c9d5-4a4c-982c-dfcd5b6d9624@quicinc.com>
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

On Wed, 2025-05-21 at 14:55 +0530, Roopni Devanathan wrote:
>=20
> I think so, too. As mentioned already, I can change the datatype of radio=
_id to
> int, retain the NL80211_WIPHY_RADIO_ID_INVALID value at -1. This would me=
an that
> passing default value to individual drivers will set RTS threshold to all=
 the radios
> in a wiphy, or it will be the case of single wiphy architecture.
>=20
> I hope this change will be sound and standing?

Right, that sounds good. Except it still shouldn't be
NL80211_WIPHY_RADIO_ID_INVALID since negative values are not part of the
nl80211 API :)

johannes

