Return-Path: <linux-wireless+bounces-22908-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C02AB53D6
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 13:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBEC619E789D
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 11:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894F128CF6E;
	Tue, 13 May 2025 11:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jfarr.cc header.i=@jfarr.cc header.b="MTH63DRt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DGUoCk5b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AB027E7D2
	for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 11:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747135758; cv=none; b=YKwNGRoO+3IDuQ+9N+UqEg/IQZtnxln8dwIHrN3Ye2NWoM7EOneLcq+RZlNFsj4a+6LW9UM/Kr3xL+bXLH8bRoi0JnLj3UtVClMRW6Cv6iG4J9J5yF5L4yVOD7EhHB5G0okxjAj2Y0y7M+CIXvSs9w73AwqQQ7MAgdlJsWm3HOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747135758; c=relaxed/simple;
	bh=uoq/AKall1b1lv9bAX6Uxp0j9BhTBf1FmPr2Kf3uvnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljoSDu+SBZLZy+EFAGKUYVnkT08rfaPJX8Shj7IzxlrSIN9OSuHOHGMDu0t4Q7kNRY7Len6BoplEdQrTs2pqnU3qCwKpoW5+/gNnFjf7yQD8v6f66un8iwiAH6iu/7KGPTIEQKIqwIoUqmJj0x/2b5RsSMNclHHlYG5/kexSDgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jfarr.cc; spf=pass smtp.mailfrom=jfarr.cc; dkim=pass (2048-bit key) header.d=jfarr.cc header.i=@jfarr.cc header.b=MTH63DRt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DGUoCk5b; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jfarr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jfarr.cc
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 1FC8113801C8;
	Tue, 13 May 2025 07:29:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 13 May 2025 07:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747135755; x=1747222155; bh=vmY8/ddd1M
	PQo5tnUMOqoIjPTC4jUX+YX8u+ODw/fvs=; b=MTH63DRtJrT5ww1xqATDEc5rJf
	zZjqayE9YM47MEnVcn31VR69W+1KURoByydp0WC7Zjf27CSULpneQY2VY6QtGY4R
	cSXwE0clQfkU5Q/xssEPPzV6NmKrc6a502LkxQQ6gIJE1X5NLRcoOCQ+os15prjO
	phI0rBHbzIw63f3G5B273zDnbfuBF568/XGb2HSfi1opHExiLQml32qIYjAaAqnd
	gruuM8lPkH5loIob4Ws6jgzOkeXNtJeykmp7swocdTy3gQbtGIJ6hZmPyFVHRP9b
	q3IF4DuIFAKOGFSPrl7btGKIW6/3PWSYVRWVJy1xAyHFeRLoqFdv46hXdBHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747135755; x=1747222155; bh=vmY8/ddd1MPQo5tnUMOqoIjPTC4jUX+YX8u
	+ODw/fvs=; b=DGUoCk5bva6GcavULeof9PBMb/CHR3t420ydndGBgkUS05d3TDn
	U7ZcPPXobuZjuKQVipJRDZs8rQyKF5Ybmm9BbcdUa2bf/U7GdgAYXesURIrhu52R
	gG6+nK13JYvWO/KVR+Tun22z81CFPUs1hW9paHZ/XjexfEzO5+eaEEPMJDFEWMA8
	NT96m8tn67xCx7x6biS/TdJWgyQmrQSGGlOXqk/xBstPWhwPr04BhxPS1Vp/Uk1L
	aFn9n+FIwWp6RybZDkvNp9h/YT02xrKlH2lOLi+WNZBhmU1VbJ2Tw1wmobY5Y4cw
	NBAE9BJCt04finjqu0sRGHlMMn1rCbCfnlA==
X-ME-Sender: <xms:Ci0jaIIovpnME_DpZThtnlslVeMaasggHQoLRqaMTc7kszSSF5MQSg>
    <xme:Ci0jaIInKqpJzP0MTZQWfwwU6gYN18ZhA33bzS1v5FEcfKcmlfGaUP3zXDObkg6Nw
    VgsH51R-FPw5SkaXYE>
X-ME-Received: <xmr:Ci0jaIv2qXJbDDrGfE9jnPDQXTlXCr-e35SvK_6y5tmBP2pZ4kFCw19unyx0U0zEU6wEAfdkbgWkT--HUXkpvgrjo91r>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdefleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnegfrhhlucfvnfffucdludehmdenucfjughrpeffhffvvefu
    kfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeflrghnucfjvghnughrihhkucfhrg
    hrrhcuoehkvghrnhgvlhesjhhfrghrrhdrtggtqeenucggtffrrghtthgvrhhnpeetfeet
    gedvgfdvveefgfeivddthfdtvefffefhveeljefgieduffeuheeliedvkeenucffohhmrg
    hinhepphgtrghpnhhgrdhithdpihgvvggvrdhorhhgnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepkhgvrhhnvghlsehjfhgrrhhrrdgttgdpnh
    gspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhohhgr
    nhhnvghssehsihhpshholhhuthhiohhnshdrnhgvthdprhgtphhtthhopehprhgvshhtfi
    hojhesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdifihhrvghlvghsshes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhrihgrmhdrrhgrtghhvg
    hlrdhkohhrvghnsghlihhtsehinhhtvghlrdgtohhmpdhrtghpthhtohepihifugeslhhi
    shhtshdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:Ci0jaFZH5pwBwh6Fe9hEI0yNqw8szEH15f9xFs5qkD27nvzwNZIeFg>
    <xmx:Ci0jaPZnr0XSjMiUIKSb8fWNNwyWCoNFJCsAg8l9yqKBMlreiG0Efw>
    <xmx:Ci0jaBDkxO4jIj9UPPIYNTY-4_0ajV2j_nSDyZwt08ruiEeOn8i38Q>
    <xmx:Ci0jaFYMGSCbloV8Q6yB7Se7sfRSWDOc0BFBI-fZkT0N2oZU3j430w>
    <xmx:Cy0jaEXrM5oB8udnusNVHGChmWR-hmMR8tVHBK4tRPJyHqT1adOJyHWR>
Feedback-ID: i01d149f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 May 2025 07:29:13 -0400 (EDT)
Date: Tue, 13 May 2025 13:29:12 +0200
From: Jan Hendrik Farr <kernel@jfarr.cc>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: James Prestwood <prestwoj@gmail.com>, linux-wireless@vger.kernel.org,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	iwd@lists.linux.dev
Subject: Re: wifi: iwlwifi: SAE fails when AP sends confirm before STA
Message-ID: <aCMtCCYtNNl4dL5Q@archlinux>
References: <aB30Ea2kRG24LINR@archlinux>
 <4ffbeb94-ac19-4437-9d98-24981fe6c240@gmail.com>
 <aB4HC8Iaa6wR5dj7@archlinux>
 <15943a1f-0e5d-4705-b8ef-3f22fa3fe672@gmail.com>
 <aB4hMsBfyawYatoj@archlinux>
 <902daf8802c723d72fff0155cd0638848ce1bc7f.camel@sipsolutions.net>
 <aB5onavenLymR-QJ@archlinux>
 <8a1c5172bc0fd9d2a33522294d1a2a4c4ceb313a.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a1c5172bc0fd9d2a33522294d1a2a4c4ceb313a.camel@sipsolutions.net>

On 13 09:35:13, Johannes Berg wrote:
> On Fri, 2025-05-09 at 22:42 +0200, Jan Hendrik Farr wrote:
> > > Could you do trace and sniffer at the same time? According to the trace
> > > there was no authentication frame from the AP. In the sniffer capture it
> > > _is_ there, of course, but I'd like to look at the timing.
> > 
> > 
> > Ok, I did another capture.
> > 
> > 1. iwd only knows credentials for a single SSID: kepler_test
> > 2. kepler_test is the only SSID broadcasting on 6GHz channel 37 (or any
> > 6GHz channel)
> > 3. I captured 802.11 frames using a second device
> > 4. I did a trace on the client in question
> > 5. I captured dmesg and iwd logs
> > 6. All captures were done simultaneously
> > 
> 
> I'm confused now, this all looks fine from a driver perspective.
> 
> We send SAE commit, receive SAE commit, send SAE confirm, never receive
> a response. There's no response in sniffer nor tracing data, so that
> matches up. There are a couple of retries of the confirm response, but
> that seems OK.

There is a an SAE confirm sent by the AP. It's frame 170 in
capture2.pcapng. It's also retried a number of times after that.

There is however no ACK from the client in response to it and it also never
shows up in iwd.

The SAE confirm by the AP (frame 170) is before the SAE confirm by the
STA (frame 174) however. In all cases where the connection actually
works (maybe every 10th attempt or so) this happens to be in the
opposite order (first SAE confirm by the STA, then SAE confirm
by the AP). This is making me think that the order is causing
this issue somewhere in the stack.

The spec [1] seems to allow the SAE confirms to come in any order.
12.4.5.1 says that "[a] party confirms after it has committed and its peer
has committed". So the AP does not have to wait for the confrim from STA
before sending it's own confirm.


[1] https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=7786995

Best Regards
Jan

> 
> Seems like maybe iwd builds an SAE confirm that the AP doesn't like, try
> wpa_supplicant I guess.
> 
> johannes

