Return-Path: <linux-wireless+bounces-22876-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4E7AB45AC
	for <lists+linux-wireless@lfdr.de>; Mon, 12 May 2025 22:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D88B8C3BC2
	for <lists+linux-wireless@lfdr.de>; Mon, 12 May 2025 20:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88ECE2980D8;
	Mon, 12 May 2025 20:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jfarr.cc header.i=@jfarr.cc header.b="eQLCh0ZA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S7XECg7P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716A227511F
	for <linux-wireless@vger.kernel.org>; Mon, 12 May 2025 20:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747083136; cv=none; b=V14swee+Cj9Hc0I6N6WbiOhjCw2bo7LOx7lmZ4md+6gJUmtq3BdN65EAmfebUIf6eZkLk6uW0XNQSpsXIAdHHe2aocOWQAMUliu3z+S5OuSkY6894oTm2zF2at6+EZKyF/1ZJIBLa9wlkHxeQ8GEYrcVxrBGESG1EmZp7GXEkyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747083136; c=relaxed/simple;
	bh=YdiU2gTkrSKQU9SPGThxWy0Etr6ju8zYvcT17sdQ83Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KnoYF/yxPt3ZTj3UV3Otr7X3y0baYiMIkWKEWjPYJVNlEjlwUOQ/neRo7YOC9F+AXLRc0J2+i2F/PInjI2LQFRfQHVkBIPql8p6qg9VhVSBaKag88Uo2B6b3wUDUXhZKdw1oF/wuBu8mJvVyRoslK66J7VjGd54RR/aRrj0Dtoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jfarr.cc; spf=pass smtp.mailfrom=jfarr.cc; dkim=pass (2048-bit key) header.d=jfarr.cc header.i=@jfarr.cc header.b=eQLCh0ZA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S7XECg7P; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jfarr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jfarr.cc
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 6A69813800D0;
	Mon, 12 May 2025 16:52:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 12 May 2025 16:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747083133; x=1747169533; bh=8NoIQ1VVHd
	Y9E/NzQDXuU4uALGtsF740JJdCC9TGiQM=; b=eQLCh0ZAFjg2bKZ2hzxZUuRU/i
	B6QEybo5bQ7X22zcpjqtmVd18ShYCfvll/4Ky/KLStVZCzG4srasbfrKLA1ZvYGr
	GsVnWDvPGS1Tb3qy4Ee99e5gGZpeUm4zM6DnaZcrHHFCsQgDlmgbr85Opc012U7/
	+pzyt+0G1AQLT5N4z2dkKDDuQIKoqXdWICX3owcGzIiagg9HOeMkfKEv1sOgJv0R
	ZX201/wG3nJTaTmfYPC9T7LpknpkjK1qDJavI/JDz1aHvqWTac1D+AQsa3oWfD8/
	m4uSoFaEIuA8RHdxILbw5mHeeS7u7Y1vv6v3b5tXuqtSKfXLDGH08SiLovmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747083133; x=1747169533; bh=8NoIQ1VVHdY9E/NzQDXuU4uALGtsF740JJd
	CC9TGiQM=; b=S7XECg7PszerXZgw8/sukwshduYtvOMKGvgahpalEgjh+CEjJt5
	/XmQ/Okj43xv4GbagxfXHMVm75tStvXq+DJxRdMCYPuvZl19ozBjS926fDAuZNSH
	GZ8Y9BJbgdv3C8CRs+Jt312OXcJxg4GM6z6hpQd/g5Rb2dTCJJrzGswl+G6sn9iv
	cM4A+2GLXl3rIxJRSRuDaWxTBGlMvWE5gc9fMRLCB3KQE/l2V02iFuy/C7eO7OSY
	dCbpSfFbAOgiK0ISU94Q3OfClJbbMHbSPEB5CK2VICVRs/1uYO6b9FdbnoE/aMpe
	df3s8a14zmfNhw2SL3KyZU/RO8+OtB46Znw==
X-ME-Sender: <xms:fV8iaL7CmAWzyk6e78sVejWggc1IshD5xojT1SAw1r6BOFzuQFQRyA>
    <xme:fV8iaA67HzRmk819NJ3qs72TZeGSIZwlAbKmvTAizpFPVSvWOmeXaXUDQ3TDLGswm
    I-rA_2-oZfW2QoiPig>
X-ME-Received: <xmr:fV8iaCeR2T9GHMYHkCKmf_ERElaKa2kB7YLT5Pki-gzM9dc_IGpol6lrOS6FOskmFtOarvMJy8uAVRqG1ZdvWUAVLgun>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddvvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnegfrhhlucfvnfffucdlfedtmdenucfjughrpeffhffvvefu
    kfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeflrghnucfjvghnughrihhkucfhrg
    hrrhcuoehkvghrnhgvlhesjhhfrghrrhdrtggtqeenucggtffrrghtthgvrhhnpedukeeg
    ffdtfeeihfehteevvdeiueetteelgfefvdfhleeufeegieduieduhfekieenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkvghrnhgvlhesjhhf
    rghrrhdrtggtpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehjohhhrghnnhgvshesshhiphhsohhluhhtihhonhhsrdhnvghtpdhrtghpthht
    ohepphhrvghsthifohhjsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqfi
    hirhgvlhgvshhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhirhhi
    rghmrdhrrggthhgvlhdrkhhorhgvnhgslhhithesihhnthgvlhdrtghomhdprhgtphhtth
    hopehifigusehlihhsthhsrdhlihhnuhigrdguvghv
X-ME-Proxy: <xmx:fV8iaMJD446NACcIx2ZEMeL1OF9OXexZUW-vCfN6YpPBBG1mGCZW4Q>
    <xmx:fV8iaPLpv_Q59Cy4rJVNKvUa6a1dZQbPKvwyiVO8-Bouxv8C2mw0ow>
    <xmx:fV8iaFyk5KkZP26SSggtXW0kRBzvh1guEsyHycoMG2b1y-rCUuF4Iw>
    <xmx:fV8iaLI0coE8lrd42MGtnE0_ycVd3ZiGFFfNZG4LaiqWCinYRDmTng>
    <xmx:fV8iaJGCnorHBECdrx5xxvh7dvXnpnV7ElYLh4j0t1jRRscsiWKCrMTF>
Feedback-ID: i01d149f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 16:52:12 -0400 (EDT)
Date: Mon, 12 May 2025 22:52:10 +0200
From: Jan Hendrik Farr <kernel@jfarr.cc>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: James Prestwood <prestwoj@gmail.com>, linux-wireless@vger.kernel.org,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	iwd@lists.linux.dev
Subject: Re: wifi: iwlwifi: SAE fails when AP sends confirm before STA
Message-ID: <aCJfeg0f9c2sTX4c@archlinux>
References: <aB30Ea2kRG24LINR@archlinux>
 <4ffbeb94-ac19-4437-9d98-24981fe6c240@gmail.com>
 <aB4HC8Iaa6wR5dj7@archlinux>
 <15943a1f-0e5d-4705-b8ef-3f22fa3fe672@gmail.com>
 <aB4hMsBfyawYatoj@archlinux>
 <902daf8802c723d72fff0155cd0638848ce1bc7f.camel@sipsolutions.net>
 <aB5onavenLymR-QJ@archlinux>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aB5onavenLymR-QJ@archlinux>

On 09 22:42:10, Jan Hendrik Farr wrote:
> > Could you do trace and sniffer at the same time? According to the trace
> > there was no authentication frame from the AP. In the sniffer capture it
> > _is_ there, of course, but I'd like to look at the timing.
> 
> 
> Ok, I did another capture.
> 
> 1. iwd only knows credentials for a single SSID: kepler_test
> 2. kepler_test is the only SSID broadcasting on 6GHz channel 37 (or any
> 6GHz channel)
> 3. I captured 802.11 frames using a second device
> 4. I did a trace on the client in question
> 5. I captured dmesg and iwd logs
> 6. All captures were done simultaneously
> 
> All attached to capture2.tar. Contents:
> capture2/dmesg2.txt      : dmesg
> capture2/iwd_log2.txt    : iwd log using IWD_SAE_DEBUG=1
> capture2/trace2.dat      : trace-cmd (iwlwifi, mac80211, cfg80211, iwlwifi_msg)
> capture2/iwd_main.conf   : iwd config (/etc/iwd/main.conf)
> capture2/kepler_test.psk : ssid config for iwd (/var/lib/kepler_test.psk)
> capture2/capture2.pcapng : the external 802.11 frame capture
> 
> 
> I disabled 5Ghz via BandModifier5GHz=0.0 (couldn't disable 2.4GHz as iwd
> then complains about not being able to disable both)
> 
> 
> One note about the client: It's running an Intel N100, so it's probably
> on the lower end of devices that will be running a modern wifi 6e card.
> So this increases the chances that the AP will send it's confirm before
> the client will.
> 
> 
> Best Regards
> Jan

I think there is something weird going on with the system time. I tried
lining up the times of frames in the packet capture with the
iwlwifi/iwlwifi_dev_(rx/tx) events and noticed that it's not possible to
get them to line up.

For example time between STA sending commit and sending it's own confirm
is 41.85 ms according to the packed capture. But the time between what I
think are the corresponding events in the trace is 106.63 ms.

Then I noticed that the time in dmesg -T was running ahead of the
correct time even though it was synced at boot. clock source is tsc.

This is making analysis very annoying, but could it also be causing the
issue in the first place?

Best Regards
Jan


