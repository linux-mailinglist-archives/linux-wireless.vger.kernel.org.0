Return-Path: <linux-wireless+bounces-22877-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68135AB4608
	for <lists+linux-wireless@lfdr.de>; Mon, 12 May 2025 23:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D415C19E2234
	for <lists+linux-wireless@lfdr.de>; Mon, 12 May 2025 21:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A30A298CDB;
	Mon, 12 May 2025 21:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jfarr.cc header.i=@jfarr.cc header.b="YkHxbjRL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="psyFQRjr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C99D171CD
	for <linux-wireless@vger.kernel.org>; Mon, 12 May 2025 21:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747084845; cv=none; b=FZeg7BCKV8dspDIqdl+3ukeY8yvYmJZeu/6ItJUGKBBplRFaxeQx/RjPS99OcrY+L4H5tunBYATR901dElrcowELMFlV4rjuEBk10upfmIQU5OM/WTq7u9juIkTsfef91Ov2kxbkn10xCUkTqp+eYzpL+5pXgrnuFvt5k86P46k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747084845; c=relaxed/simple;
	bh=Uleduw3CSd4kx9kZLXNhHDNStlb+UtS2zFx4IYyPLwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Alq9Es2ovVhrMzIsIFiOZVhU+cA4DiD6WqXfabOCt7g6rBxfqRTRHdGLO6DAtSLWMtjllr0jPQgShTeJoDzjBoPZqiiBGNtoOE+eB3cz1ePCYt75VOoYuESDLEAheEtgzQ0g656YTzkYzae5EB4aewKvm66Q0Smdd2qUZ0cjZEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jfarr.cc; spf=pass smtp.mailfrom=jfarr.cc; dkim=pass (2048-bit key) header.d=jfarr.cc header.i=@jfarr.cc header.b=YkHxbjRL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=psyFQRjr; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jfarr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jfarr.cc
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 31C7F1380228;
	Mon, 12 May 2025 17:20:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 12 May 2025 17:20:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747084842; x=1747171242; bh=id7Mk5sCX9
	49ElGjgnI0uFx71VE5YIohh2D8Q8jAqbY=; b=YkHxbjRLABRS3izS+1kE8VN36l
	6E4/JG7v665BogKfCjmFx/bcA3LbTDiUcvErvXg7sPwKpNz/D1cRf84Nrxk5jLHv
	X1JUlQwn9ASyVCCdcYT+zGlVKltuNhDp9VJ6/BI3hx6kBt3/mZyi+cce27R0bUZS
	OdEuZBTM6khfm8f0SL5aQSvuxp57z02p9WvOiDrzC0P61JL2n8GEkBcAKgb7p8I6
	hT3du/+SRQAcwiJqZCgrmRcmw3UiuUqxO+/iVD/E3UJtFpLRkGt5WgUR5JMGKKYu
	L7AwD0QhVITit8Pi1MhkHsZBCsl7713AFblHxmQVzZgM00Fg8uiXSkAr0FaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747084842; x=1747171242; bh=id7Mk5sCX949ElGjgnI0uFx71VE5YIohh2D
	8Q8jAqbY=; b=psyFQRjrKXzbI1d2lxcDtHRvQYcK1FBJg4JaemRHcd8EEWGHLOi
	RvGK/ayhI5IsOchOGoKiRzIKyCPzcv70kYGaoiZCt5aHLr6w5YyKGpBjUEDJqNvV
	ZlR1JopjwxblQf4+Tq6j4+2W5BmbCs7npEDwRe+IhbD99XR9XQumkNTVTtY4aUoa
	FF5g/E4IUGnkg3QygHpw5afG20DaHRt7YuBQJn71Ae4y3aPgQ320lHFkB3qiOH4K
	nlZGhW39U3qZYRnGeAtd35BqRJVKRFnFDEVQiz5K2fJq57r+jQZ8TYKM8+s3RxRG
	HblN3GQ/qa5+DGNncPVw5tFKzV95SWriwGA==
X-ME-Sender: <xms:KWYiaCzrb2gDqB1xJ3gE7ET9Tn0Tx-WDnH4yC_U70AOQdKNxib6hLg>
    <xme:KWYiaOTFdkHVTVy8u-_rq3DhGtNDUtOPLiksRcNNiebpPOsdwIsMehHXHxwIHHku0
    uU0pSRfsVXRJuqXzRY>
X-ME-Received: <xmr:KWYiaEVy7bIOO_7ZYFmlk2MKRVhLnp3zFrzus8oFLVQa1gfM1aDMzDmQQoBjAt4rYqTw6KW0H7x7btus0gqbYMA6Q16X>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddvfeefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:KmYiaIgRQ_bW_66G4VuS-ejhuPSZVtwg8OK0KpLBIYfvPOeJT7EBtw>
    <xmx:KmYiaEBr8nEbs0lIf9dM-jVQjZfIChjM1_eWlUwiadUD0VHp4obOSA>
    <xmx:KmYiaJLGeTAyrDu_bhlU1Mx1RvkXwDNmJuSgJIK3bWipt1fih3WDHQ>
    <xmx:KmYiaLBJdimNaqZ-WObC-9Ajq3OqO5JsG3llMekkDcwPnnz_wPm2bw>
    <xmx:KmYiaEdEKgIXcFbyokIEB9REUf-mXgf78wnbQnbpBfEXYaqEOym2hc3g>
Feedback-ID: i01d149f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 17:20:41 -0400 (EDT)
Date: Mon, 12 May 2025 23:20:39 +0200
From: Jan Hendrik Farr <kernel@jfarr.cc>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: James Prestwood <prestwoj@gmail.com>, linux-wireless@vger.kernel.org,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	iwd@lists.linux.dev
Subject: Re: wifi: iwlwifi: SAE fails when AP sends confirm before STA
Message-ID: <aCJmJ65OvSLzq7f2@archlinux>
References: <aB30Ea2kRG24LINR@archlinux>
 <4ffbeb94-ac19-4437-9d98-24981fe6c240@gmail.com>
 <aB4HC8Iaa6wR5dj7@archlinux>
 <15943a1f-0e5d-4705-b8ef-3f22fa3fe672@gmail.com>
 <aB4hMsBfyawYatoj@archlinux>
 <902daf8802c723d72fff0155cd0638848ce1bc7f.camel@sipsolutions.net>
 <aB5onavenLymR-QJ@archlinux>
 <aCJfeg0f9c2sTX4c@archlinux>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCJfeg0f9c2sTX4c@archlinux>

On 12 22:52:13, Jan Hendrik Farr wrote:
> On 09 22:42:10, Jan Hendrik Farr wrote:
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
> > All attached to capture2.tar. Contents:
> > capture2/dmesg2.txt      : dmesg
> > capture2/iwd_log2.txt    : iwd log using IWD_SAE_DEBUG=1
> > capture2/trace2.dat      : trace-cmd (iwlwifi, mac80211, cfg80211, iwlwifi_msg)
> > capture2/iwd_main.conf   : iwd config (/etc/iwd/main.conf)
> > capture2/kepler_test.psk : ssid config for iwd (/var/lib/kepler_test.psk)
> > capture2/capture2.pcapng : the external 802.11 frame capture
> > 
> > 
> > I disabled 5Ghz via BandModifier5GHz=0.0 (couldn't disable 2.4GHz as iwd
> > then complains about not being able to disable both)
> > 
> > 
> > One note about the client: It's running an Intel N100, so it's probably
> > on the lower end of devices that will be running a modern wifi 6e card.
> > So this increases the chances that the AP will send it's confirm before
> > the client will.
> > 
> > 
> > Best Regards
> > Jan
> 
> I think there is something weird going on with the system time. I tried
> lining up the times of frames in the packet capture with the
> iwlwifi/iwlwifi_dev_(rx/tx) events and noticed that it's not possible to
> get them to line up.
> 
> For example time between STA sending commit and sending it's own confirm
> is 41.85 ms according to the packed capture. But the time between what I
> think are the corresponding events in the trace is 106.63 ms.
> 
> Then I noticed that the time in dmesg -T was running ahead of the
> correct time even though it was synced at boot. clock source is tsc.

Did a small experiment by running
echo 'before sleep 10' > /dev/kmsg && sleep 10 && echo 'after sleep 10' > /dev/kmsg

It does take ~10 seconds to complete (checked against smartphone
stopwatch).

dmesg output shows 10 seconds passing:

[326951.572303] before sleep 10
[326961.575732] after sleep 10

demsg -T shows 10 seconds as well:

[Fri May 16 06:35:58 2025] before sleep 10
[Fri May 16 06:36:08 2025] after sleep 10

I assume the incorrect time has something todo with suspend...

But at least the timestamps in the trace seem to be ticking at the
correct rate then. They still don't line up with the packet capture for
me though.

Should the iwlwifi/iwlwifi_dev_tx events roughly match up with frames
sent by the client?

> 
> This is making analysis very annoying, but could it also be causing the
> issue in the first place?
> 
> Best Regards
> Jan
> 

