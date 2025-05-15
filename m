Return-Path: <linux-wireless+bounces-23011-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50803AB8686
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 14:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39FD63ACD9B
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 12:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE40298C14;
	Thu, 15 May 2025 12:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jfarr.cc header.i=@jfarr.cc header.b="mhEOnxd6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gDwSZOgq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E152989A8
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 12:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747312593; cv=none; b=iCrz95iaxP9SmSWqJTOyovaqGvmZjJElVA+DJhEIJZu+BuPNwG5sT8WoLlyUE7rjKXDdjIdR7ddK0gnL7EdtTBy0sixSxTyDq4+wz4+Sgl8kpDhjgJctaeDvkzlBqPR1m1EhWka1hNXjofHgQyBYHAJBrJdOHhKCOpQxhtjpFf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747312593; c=relaxed/simple;
	bh=lTKZv2ZFMWbe89p97/KJ2hJ7DKX/ZkB33TS44pbxeHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Miqc+6TXSsQl/So5GLRm2pzR8890PNSEidHdJahZdf+LA0ofzIUwxClrlbQRfYXu6TNIIZB69oLAeYwrSGFRqiZqta+wsAqrv4UldxAiee5RjzWSPjA2D/nhMEwup3rPAnp3jJmZMmxRVJ40yxP0MWVz4ONz7UXhEdISZAEfepM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jfarr.cc; spf=pass smtp.mailfrom=jfarr.cc; dkim=pass (2048-bit key) header.d=jfarr.cc header.i=@jfarr.cc header.b=mhEOnxd6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gDwSZOgq; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jfarr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jfarr.cc
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 173871140091;
	Thu, 15 May 2025 08:36:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 15 May 2025 08:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747312590; x=1747398990; bh=K5r/1q6jge
	2KHTiGII6HlPItfj1T6yVcVbt/UNJM1NE=; b=mhEOnxd6otG7sxrjmfs0vtlmnE
	Qh19qsiwsg6fSZmFCarrNy3HQyOihpeu8lfJBgerrwmbQxNdd/OYEXleAiG38upb
	HbWWY+J1VH+vjEGSywpdbRiRlAZ6I7/g//3cuQaJO1QVSsMaRr1+0aOT0bDAvWAQ
	47HrAyo8wGHoSYr26x7I0iazakcOl3i+aiv+94z1TemTscIFyyYfSmWqs/fe4d+K
	JsHy34EvjA/V/d3ul29lamznEaFwQqp8V9XX33YvmRyLvul0T3ammoRxGZ/RlmCQ
	Fs3GxySzZeMj5uYmZvXCfJF9JcWbJNGJL9TJBX1VykiBxzYSlWvpb6CrVm5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747312590; x=1747398990; bh=K5r/1q6jge2KHTiGII6HlPItfj1T6yVcVbt
	/UNJM1NE=; b=gDwSZOgq1voVC1eZxjoDgVNkl85rpHo59x1HP2DPWSTQmTZ6/P1
	kTaek1vhzvoi6a9rp631CbFv8b5RbskGy1zo38/WWIcAtwDqSCMY0a20ZlAFwNsS
	eE2qLWkPUqey37T+/mxVRwm4DI5GPBjCd/0zORYlEkOdo5Rvs76ArRL9rVF7uwfA
	p1pn8Nwc3HgrHz8DFXKMxvdsLwhdzT1NPyCyBDMm+d7PDF32rIA71JWwD/UIFjnF
	kKM6DYFD0ULeBSLxhG2su6swSyW9PBTXuyV055/5MsREa3dUnun4Pk0vGv3jWQ+j
	MR3QCgITRzK5S5uQp1ixEts6jtv4QE8mrGw==
X-ME-Sender: <xms:zd8laNf3yMXXM5hY1we_BiVFUw2xx2bmarENAURSKQf0_q6MypyvYA>
    <xme:zd8laLPMZvkxI7vhpB0ktpEZgJmerM2KwTssqusuQWEWJSmmFA1-xvz7rYgpPnIHr
    yAwdzadGVdTSfCkxSE>
X-ME-Received: <xmr:zd8laGhSEnMG0-lIRqVsMX-qqAS1luKvaiXdvDOgBqsdS1LkTrwJNfIzhGV-JozModQioHopnlxpYyUUpSybqc34Zunv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdelkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnegfrhhlucfvnfffucdlfedtmdenucfjughrpeffhffvvefu
    kfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeflrghnucfjvghnughrihhkucfhrg
    hrrhcuoehkvghrnhgvlhesjhhfrghrrhdrtggtqeenucggtffrrghtthgvrhhnpedukeeg
    ffdtfeeihfehteevvdeiueetteelgfefvdfhleeufeegieduieduhfekieenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkvghrnhgvlhesjhhf
    rghrrhdrtggtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehjohhhrghnnhgvshesshhiphhsohhluhhtihhonhhsrdhnvghtpdhrtghpthht
    ohepphhrvghsthifohhjsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqfi
    hirhgvlhgvshhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhirhhi
    rghmrdhrrggthhgvlhdrkhhorhgvnhgslhhithesihhnthgvlhdrtghomhdprhgtphhtth
    hopehifigusehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepuggvnhhkvghn
    iiesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:zd8laG_ymeGNN15YHWozbDlPwkO5URZGy1hrvMvKM_4wAABKoZBxXA>
    <xmx:zd8laJu381r8KwUN8ZPifkyejZDUvWlkDT3JlltmMW00bBEA1rV1Sw>
    <xmx:zd8laFELhd49bDH6E7fJLQq716qGcx0RmirZgOSljpBPkTL_SbXBxQ>
    <xmx:zd8laAMpGmasB82rtAkpEKOIAtlzhRN99SuyAz_uH87tbOOflxq1zQ>
    <xmx:zt8laLH00sm7Vt0YVfUwabn3eYmIH-SIKCrGPITppNL5mqsNrH_hwR4K>
Feedback-ID: i01d149f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 May 2025 08:36:28 -0400 (EDT)
Date: Thu, 15 May 2025 14:36:27 +0200
From: Jan Hendrik Farr <kernel@jfarr.cc>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: James Prestwood <prestwoj@gmail.com>, linux-wireless@vger.kernel.org,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	iwd@lists.linux.dev, Denis Kenzior <denkenz@gmail.com>
Subject: Re: wifi: iwlwifi: SAE fails when AP sends confirm before STA
Message-ID: <aCXfy0Uqx6wH32DR@archlinux>
References: <aB4hMsBfyawYatoj@archlinux>
 <902daf8802c723d72fff0155cd0638848ce1bc7f.camel@sipsolutions.net>
 <aB5onavenLymR-QJ@archlinux>
 <8a1c5172bc0fd9d2a33522294d1a2a4c4ceb313a.camel@sipsolutions.net>
 <aCMtCCYtNNl4dL5Q@archlinux>
 <e1b26ee842bc60cfa939874f467a03531871807e.camel@sipsolutions.net>
 <aCN0Tjwu-yS2mzi_@archlinux>
 <047456d40bc42248a6ba1b76d630d5d82b857bf1.camel@sipsolutions.net>
 <aCODE231NMCQ48xu@archlinux>
 <1a6ee5fb05b32e290fc45e66af4b7dc719f06ed8.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a6ee5fb05b32e290fc45e66af4b7dc719f06ed8.camel@sipsolutions.net>

On 13 19:45:45, Johannes Berg wrote:
> On Tue, 2025-05-13 at 19:36 +0200, Jan Hendrik Farr wrote:
> 
> > So this test doesn't proof that it would work with the order the other way
> > around. Maybe I should try making iwd sleep while generating the commit.
> 
> I guess you could, right.

Just to report back on this:

I added a 20ms delay in iwd's generation of the confirm message and
everything is working as expected with your patch applied.
Connection is succesful with the following order of frames
confirmed by external capture:

1. client sends SAE commit
2. AP sends SAE commit
3. AP sends SAE confirm
4. client sends SAE confirm

Best Regards
Jan


