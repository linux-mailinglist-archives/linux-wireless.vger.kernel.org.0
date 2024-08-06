Return-Path: <linux-wireless+bounces-11012-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B46AB948F6C
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 14:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74F77283709
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 12:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E551DA4E;
	Tue,  6 Aug 2024 12:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="bEgc4VC6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BEE1C4632
	for <linux-wireless@vger.kernel.org>; Tue,  6 Aug 2024 12:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722948336; cv=none; b=Tyu6PRvkDs423qzQOwujUIitW+TaLskUgu22qdVCTBLyqz1dEzh1fx9avZ4hwntMw18MgdxZAi4XUlylmMUQ4UVa0KJYGL1Tf6+S8z4OWpwdRX1FixEbhfQBJzKSKLSyGwh5bk9vR148Aaem8EtrfK/9jxF2AEUZrJIw+B5WviY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722948336; c=relaxed/simple;
	bh=ByWDoHwZSPZe8EzuSccSuILJYQlOer4FNo5JbQGGZrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Chg5jReZdepOgOc9hKdkWGfLttfYgljADmvaGa1VaAnyAla0C7JAcqkYbhAuOu1KHSAmkUGmaZjKxeELy2lygheqxNEW8ByxYVsRlfVfmYEf7ExtpWhr6JzQWIFoR4pXrWEvlcPWS3NvCAd91xKE5yFK1a9+j1ENedhpprqWi+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=bEgc4VC6; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-111-165.bstnma.fios.verizon.net [173.48.111.165])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 476CjJpD005237
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 Aug 2024 08:45:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1722948321; bh=vpciuStYajt/lvFNtFVUk5Tz/4zcViYPF69Qs4nAgA0=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=bEgc4VC6p7yoOsuJ6gQFnZc8DY/HjIYo8OFAduommuEovK1l/+WqNDPqw0WATPTwB
	 NNf2lck1Kb0NYSoMv4Wued41T5myzlHn7nErcLB6qV0f4/5fhFEWSaUZFCnGzJOBhz
	 tfBtUrN4gLCE8DAfnhBk1dPDYpj6fdL9U+ilzd4LrCraAE/GbWz0GVS3IqMtmRRdDR
	 ewS7jisc1pxXhX5SwCtguh26i7V/Bu90HXubD0R4Oc+4IsjgMW/ThsBOdeyGcYTFQP
	 ZScMumlj0chaNB2FSrDA9gMERHBpCukGgVdqW7JwI3+V0aHcwZTKi2y37+hGgREcBj
	 W1BNGo9Q7zk2g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 2DDF015C0330; Tue, 06 Aug 2024 08:45:19 -0400 (EDT)
Date: Tue, 6 Aug 2024 08:45:19 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: LidongLI <wirelessdonghack@gmail.com>
Cc: gregkh@linuxfoundation.org, kvalo@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        mark.esler@canonical.com, stf_xl@wp.pl
Subject: Re: Ubuntu RT2X00 WIFI USB Driver Kernel NULL pointer
 Dereference&Use-After-Free Vulnerability
Message-ID: <20240806124519.GA1174689@mit.edu>
References: <2024080359-getaway-concave-623e@gregkh>
 <20240806035433.20901-1-wirelessdonghack@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806035433.20901-1-wirelessdonghack@gmail.com>

I was taking a closer look at your reproducer, and there's even a
bigger problem.  Your reproducer runs the moral equivalent of this:

   import usb.core

   dev = usb.core.find(idVendor=0xb58e, idProduct=0x0005)
   dev.reset()

(I've changed the USB vendor/product id's to my Blue Yeti microphone,
so that it was a valid USB device; but that doesn't matter for the
purposes of this demonstration.)

The reset method requires root privileges!

usb.core.USBError: [Errno 13] Access denied (insufficient permissions)

So how does this actually show up in a real life exploit?  The
attacker won't have root privileges, or it's already game over.  If
this is an embedded device, the USB device will be soldered onto the
PC board, so you're not going to be able to plug and unplug it a
hundreds time, with a tenth of a second between plug/unplug cycles
(good luck having a human do that, BTW).

And if you do have physical access, and it's not soldered in -- in
most situations, if you have phyysical access to the device, it's also
likely game over.  For example, you could plug into the debug headers,
and just flash a new firmware onto the embedded device, and again,
game over.

Again, this may very well be a bug.  But not all bugs are real life
security exploits.  This is especially true for syzbot-generated
noise, which runs its "attack scripts" as root.  The excuse given for
this is that it finds real kernel bugs, which may be true (although
others are still syzbot-generated noise); however, not all kernel bugs
are CVE-worthy.

Best regards,

						- Ted

