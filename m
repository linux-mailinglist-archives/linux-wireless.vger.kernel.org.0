Return-Path: <linux-wireless+bounces-22910-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A104AB542A
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 13:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CDBD1B457F8
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 11:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3100828CF59;
	Tue, 13 May 2025 11:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jfarr.cc header.i=@jfarr.cc header.b="a9V5aR+2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZWqikWmt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0390728C5AC
	for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 11:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747137371; cv=none; b=l3DJp8qnAda6RQ/x7BefPZbkh59sGofAbNfl5qyhL1/x+g/s89Thr8jdP5/yNnyp2CRJfpqF/aCbldzy7PJSrpWsP8Vr7kViaRq+NiuncgO/MFBbEbMUeX6KwPR0F6SnxCpsHVofT+Pd2p1Xplu1OnMKEXQVFThpPwjKMIAPwqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747137371; c=relaxed/simple;
	bh=HxJucLyY8g/2zIXMzKI1xHP2ORuFQ0eqO7cNHCOFd5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMs3dEtQnWrdiuEfRgUT42550LwddChSSODKyf/B45sOrgZN2aTVDCwqWEtp6bn1QyuM4BGHI7V4YmjP00q1RcrbydpeawaxmvKrDP42NiUaiC/pooogx8IBX3MbR/wuuf1PmfYfRjj5c4/HtZq7OnKpce7CobN/6kohGO+ic2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jfarr.cc; spf=pass smtp.mailfrom=jfarr.cc; dkim=pass (2048-bit key) header.d=jfarr.cc header.i=@jfarr.cc header.b=a9V5aR+2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZWqikWmt; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jfarr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jfarr.cc
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1E71911400D7;
	Tue, 13 May 2025 07:56:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 13 May 2025 07:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747137368; x=1747223768; bh=kFkGHgpBP/
	eunDDfXfIMMe587KqwVZVkhuA4qU6EZhI=; b=a9V5aR+2ThoePSMbJX2sCSpkiF
	lahmdaatsLhfRjxP9Kp8M5knY8yA+N+FhGHlnP7tjTZz3tbY3NDfsK4FiKwIlDB5
	h/DPiqyv84i/JamuiGKAJZRbd5fFr8Jfhj7/plgz/PmqAxDsNoDD5jQJje4sTPvY
	Wxdhr0n8FB+FflFwJTZKv5kVe2Z+sT5K0+QStNdEGLJAEAUTp46HAQCCfRs2V85b
	yOyt20LXnBQ8rEYsP9U0UmjjBzdVQSSLd09MP8Ujst5at4qYUn0brnAGF304yQBS
	WJJuFCKnfAx4Pq7IBwB8gJbNMQItSToeoAJvsjBNGGxIlImQ1A9wu+VmsVZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747137368; x=1747223768; bh=kFkGHgpBP/eunDDfXfIMMe587KqwVZVkhuA
	4qU6EZhI=; b=ZWqikWmtLpJLP3976elvTuulMpzxNOVvz/OYC1TmUYBmno16/cq
	R6a2SAwTLvLuU977Af+lValc7j714yurUw2S/wegPXTRiwlEPgfs5XBwq7pZ8BiX
	dqX5P1Bfgauq/CWNNg6AjK7q0KpmzRfJ4vCWwfhdUv/Ip15SGHa242SF+w1I9beE
	LCP1wlRG16HwwBcgRDL/PZJHpRrgrazPcEaB5Q0AZwB6uwi5S7lMTf/tIsNTG9+r
	mCzcNrpRkzGU7Bb5uIU+OrkvayX+ObHUwNOsmnyhn46d0ZQsk95ujnrpRq3jANFh
	J8HKh1e/N6r9o8P23Uy2pTrNRr8JAb021jg==
X-ME-Sender: <xms:VzMjaFh-Hse91W3H87MRnlngsXxQ-CEV6yCwJ_8pTkrHZxFc_zrKvw>
    <xme:VzMjaKD3lD6bwshaZ30vSUd0JfjauLBDmmo4PxY5P88EENplMYz8vDhYD8AdS_xrp
    HH3-AWZczarNDjKA0o>
X-ME-Received: <xmr:VzMjaFGHx3pJ5Wn1z8LH3Y8UN9OlYgtXUF1W3nISr0K7Ts8L225EVt6f_KHpmZ4EveP_btyZC6d1AZtFV6fn_LE0z06O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdegtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnegfrhhlucfvnfffucdludehmdenucfjughrpeffhffvvefu
    kfhfgggtuggjsehttdortddttddvnecuhfhrohhmpeflrghnucfjvghnughrihhkucfhrg
    hrrhcuoehkvghrnhgvlhesjhhfrghrrhdrtggtqeenucggtffrrghtthgvrhhnpeduveei
    ffefhfdtvdeiheffudffheelueehtdeigedvtdetfedvgeduffffveduheenucffohhmrg
    hinhepphgtrghpnhhgrdhithdpshhiphhsohhluhhtihhonhhsrdhnvghtnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhgvrhhnvghlsehjfh
    grrhhrrdgttgdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepjhhohhgrnhhnvghssehsihhpshholhhuthhiohhnshdrnhgvthdprhgtphhtth
    hopehprhgvshhtfihojhesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdif
    ihhrvghlvghsshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhrih
    grmhdrrhgrtghhvghlrdhkohhrvghnsghlihhtsehinhhtvghlrdgtohhmpdhrtghpthht
    ohepihifugeslhhishhtshdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:VzMjaKTPFsxbksiOUFv_lHvhXeyvqRwAj0aBFSClHvVUDL6ZvYfHgQ>
    <xmx:VzMjaCyFt0NBcRHPTS6L2dspzG1u1QrwcJdZvUbN09hkO-LaSMtdLQ>
    <xmx:VzMjaA7YPyRg9VwyISygaNcs6M5qC4hBQXNwUo0Q502JsVbaK4A-BQ>
    <xmx:VzMjaHwj0Y7_LZrlvpSjOvdwUwmhOVhWzaAdOULy3MapphGIW07H-A>
    <xmx:WDMjaMOIqqyyPgMG7XnTpM_NZqq1l58Eqprll4bBPQOG5i0D-2QsTSWY>
Feedback-ID: i01d149f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 May 2025 07:56:06 -0400 (EDT)
Date: Tue, 13 May 2025 13:56:05 +0200
From: Jan Hendrik Farr <kernel@jfarr.cc>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: James Prestwood <prestwoj@gmail.com>, linux-wireless@vger.kernel.org,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	iwd@lists.linux.dev
Subject: Re: wifi: iwlwifi: SAE fails when AP sends confirm before STA
Message-ID: <aCMzVUJlLfuhupzm@archlinux>
References: <aB30Ea2kRG24LINR@archlinux>
 <4ffbeb94-ac19-4437-9d98-24981fe6c240@gmail.com>
 <aB4HC8Iaa6wR5dj7@archlinux>
 <15943a1f-0e5d-4705-b8ef-3f22fa3fe672@gmail.com>
 <aB4hMsBfyawYatoj@archlinux>
 <902daf8802c723d72fff0155cd0638848ce1bc7f.camel@sipsolutions.net>
 <aB5onavenLymR-QJ@archlinux>
 <8a1c5172bc0fd9d2a33522294d1a2a4c4ceb313a.camel@sipsolutions.net>
 <aCMtCCYtNNl4dL5Q@archlinux>
 <e1b26ee842bc60cfa939874f467a03531871807e.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1b26ee842bc60cfa939874f467a03531871807e.camel@sipsolutions.net>

On 13 13:46:51, Johannes Berg wrote:
> On Tue, 2025-05-13 at 13:29 +0200, Jan Hendrik Farr wrote:
> > 
> > There is a an SAE confirm sent by the AP. It's frame 170 in
> > capture2.pcapng. It's also retried a number of times after that.
> 
> Oops, yes, I didn't catch the different seqno and thought it was all
> retries of a single frame.
> 
> > There is however no ACK from the client in response to it and it also never
> > shows up in iwd.
> 
> Right. Clearly this is because we actually leave the channel when we get
> the response to the auth frame.
> 
> I guess most cases we have the client much faster than the AP, so this
> might never be an issue. I guess here you were saying the client wasn't
> all that fast in responding.
> 
> In fact the AP seems to take ~17.1ms from one frame to the other, and
> the client ~20.4ms, though the client has some propagation delay through
> the software stack too.
> 
> I don't think this is really the right fix, but it might help:
> https://p.sipsolutions.net/e852565303ad878b.txt

Thanks for the help! I'll test the patch this evening.

> 
> johannes

