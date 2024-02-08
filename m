Return-Path: <linux-wireless+bounces-3335-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D443A84E245
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 14:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ED2F28253D
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 13:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85CC76414;
	Thu,  8 Feb 2024 13:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="cRTB4HOy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BB11E4A7
	for <linux-wireless@vger.kernel.org>; Thu,  8 Feb 2024 13:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707400146; cv=none; b=nA6PPaDIuzR6PVTUxNNf1bizge+msJUtDTRMvX2/qnqimT8nTlCgxVJbpDyOppCk6OM5ptpR8TmeKH+R/B/iWENoJme/1Ezv94KeKUiOpUPQqkmGnRlLTFB8bC4QiSn/KDXjU05CcUNL9kuv4dwPXKSUzOo3y6EvepxC1vb5HXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707400146; c=relaxed/simple;
	bh=YIIDnoB2Ay5t4+Uuyap+oXW0DShLR4A4P4w7d/dKgts=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ovQif8vQ8AyLBpfoFyJv57bCk3W/F2jlQcg4ln2snRSKQUhxSqM3zfWIqVOIwXCgTnJxus6+ogEfntMXK7kyepkP+hVDX0E2GiCYl2tUtRBJROIbbzoxEQB0+BEqdFZEToGEuO2JfvxUCbl9HnrhUvqe2Iqm3bxw5lknc2nzuWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=cRTB4HOy; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=YIIDnoB2Ay5t4+Uuyap+oXW0DShLR4A4P4w7d/dKgts=;
	t=1707400145; x=1708609745; b=cRTB4HOyRJSmh1JAQm6N1n7R9czz1IiGr6hjb5ytdtX4QWG
	QwyPZRTWN7E49dC536Q1EeKnBP3HXS4rHLj18xjI2rb2idNtzmCwA0CcR+4tuAfF6eeqn3qXIKSr1
	VBcxcFMSI0HNaDKxP6HRDYpLoMb3QxpvF6RV5O7LgerxPY1meBQdSrQV6BmD4RIxCvefCbmnBSlpV
	m3mTTGIDhFV0+7D0jm7LnIVkNmcgXZtwhcXNbdfanD/WIprpGx5TeaJQOe/3OIsfdbAHyVkpy0UW3
	D82Y7cN+KXGga3pCEvaZEdaoe2jwY0/WFCqAavO8v2PmAUlh3wChnJql4MzSy/zg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rY4lx-0000000HUw1-0aji;
	Thu, 08 Feb 2024 14:49:01 +0100
Message-ID: <2ef35ead3540cb1b19cde635631361b57bb8b189.camel@sipsolutions.net>
Subject: Re: [v4,2/2] wifi: mac80211: refactor STA CSA parsing flows
From: Johannes Berg <johannes@sipsolutions.net>
To: Michael-CY Lee <michael-cy.lee@mediatek.com>, linux-wireless
	 <linux-wireless@vger.kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Evelyn Tsai <evelyn.tsai@mediatek.com>, Money Wang
 <money.wang@mediatek.com>, linux-mediatek
 <linux-mediatek@lists.infradead.org>
Date: Thu, 08 Feb 2024 14:48:59 +0100
In-Reply-To: <b74f21d22a41b2ca635e64f04c06d5db6d38d920.camel@sipsolutions.net>
References: <20231222010914.6521-1-michael-cy.lee@mediatek.com>
	 <20231222010914.6521-3-michael-cy.lee@mediatek.com>
	 <b74f21d22a41b2ca635e64f04c06d5db6d38d920.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-02-08 at 14:35 +0100, Johannes Berg wrote:
> Hi,
>=20
> So ... I foolishly applied my other changes first, so I had to rebase
> this - please do check.
>=20

Oh, also: some tests for this in the hwsim tests in hostap would be
really nice, though I don't know if that would require extending
hostapd's implementation of CSA first ...

johannes

