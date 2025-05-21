Return-Path: <linux-wireless+bounces-23219-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F64CABF09D
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 11:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 167B04E47F8
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 09:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F41B25B1C5;
	Wed, 21 May 2025 09:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="IK1b7+qj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEA325A2C5
	for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 09:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747821539; cv=none; b=cBu1n0uV0lksUTYzVModwDr7vi/m8nATNUn7m9H3+fcg7QoC3MrneNfzPyRsVBGCMfimwpRq1BHYc0nxVerc0ezTDYdNQYBKyDUMTrffUhIgLEoOk9y/He7Go8z4msc1x7HzAKydg3zO84UM0NRg/lK1e5rsiMVQzV90KKd2gzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747821539; c=relaxed/simple;
	bh=bijyc8aWgiWnrEMRuvX2RC0yTh0O1goUhsUiojf4Hxs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D7VY6BTkiSnpO1qlZViparIe0KPjr38kuTGwgGfVdXx6Au2WsjuD68t/6bGnYsURiHg1l8TfmHInA1z314Krr22p7bqhFidV0Mr4jA4EoYPTI0nJPm7+DC1kSLaeqIU7PKwLiT4B+HxHw+7zFflu2vzTGaOnS6IbFjyLMBvbRVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=IK1b7+qj; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=xs9xTa/eaahK6LeTq1FmOhlS4QNh25+ORYF+Rq8WDvI=;
	t=1747821538; x=1749031138; b=IK1b7+qjsQlxf5eQ1kkgC+51DFa4Ivz31YawTfcBNSYGFc1
	cM13l2fyMi/w2Bj3QEXSYGIseI6KiVa753VgMMlpflNTBQbv0fS0yQfxJDqZAbV/Q7q2aquf+kjcU
	TmXt6dWDhDLafOMX7o1tH1XwL//13oZlBywfUjGou/mcbNJ1vC9r31mBtjINWH3OpH3J6jbmu8ohY
	hB636gGp001250RXpD+4669Z1UeOMKsK84RFi87CaMFmoJwPOPaEtUjWPfWetzJbKnWhhcnMxqIM1
	8Sm12qMG54n+nOiTEzef0xAq6moWJmumkVFkC9Az3hetf22BII0Fg6cHzlpbILDw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uHgDu-0000000EE1Y-1owa;
	Wed, 21 May 2025 11:58:54 +0200
Message-ID: <b758b8768c508812e786d32289dbbd39e97dacfc.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v9 3/3] wifi: mac80211: Set RTS threshold
 on per-radio basis
From: Johannes Berg <johannes@sipsolutions.net>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 21 May 2025 11:58:52 +0200
In-Reply-To: <aab47e6a-7b45-43db-a4ba-f2372e27a946@quicinc.com>
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
	 <6341cc8198b7054f9242821d8a7db2d2f12b92eb.camel@sipsolutions.net>
	 <beae7cfb-03cf-496d-94b8-45425b1aa44c@quicinc.com>
	 <4825b1cf6d59570d9bb3f03b500023bc2574c19d.camel@sipsolutions.net>
	 <aab47e6a-7b45-43db-a4ba-f2372e27a946@quicinc.com>
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

On Wed, 2025-05-21 at 15:27 +0530, Roopni Devanathan wrote:
> >=20
> Okay, understood. If I can directly assign -1 as default value to radio_i=
d,
> then I can cut down this definition entirely. I can re-write radio_id
> declaration in nl80211_set_wiphy() as:
> 	s8 radio_id =3D -1;
> instead of=20
> 	u8 radio_id =3D NL80211_WIPHY_RADIO_ID_DEFAULT;
>=20
> This will solve the whole problem. Is that alright?

Seems fine, there's probably only one place anyway that does this.

If there are multiple I guess you can have a function a la
nl80211_link_id_or_invalid().

johannes

