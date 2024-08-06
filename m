Return-Path: <linux-wireless+bounces-10987-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17ED39487CC
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 05:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C65692836BC
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 03:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6503BBC9;
	Tue,  6 Aug 2024 03:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Kxcbkszu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B523626CB
	for <linux-wireless@vger.kernel.org>; Tue,  6 Aug 2024 03:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722913597; cv=none; b=hkC+c7XhMpICoRATU+E4SKJDS6E3MbuqSwFpgv0bsD04SkHbq3bwLm8Q9MuurF96zCZLImsC4AvFA0VCchvHftzVRrlQNsBdhhhcOQK/44B9inLuotjlMKpmqS9tyAIFkESgFj/GZ+Z1xunKvM6Oc6AdrBQ8c2Z+EJpadnN/a1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722913597; c=relaxed/simple;
	bh=z2RduF5SrSCqYnNFY3ic96xP4oa47G8J68FG6Cq48kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byeGv0xy39a0HsauON/DyeSF0JTGDinny+STPGcUOwMfFjj8eZ9/ZmfTh9GWegQqLSF/cFNDyjL4JAGEW2DxOOlB4byYVSUXbeHpxHRBd1Haqwye11vnG6gZwaATPyQZsrxb+yD78dM+BuEa72fiSlFp5UhH7AtACenXCAnClJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Kxcbkszu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-111-165.bstnma.fios.verizon.net [173.48.111.165])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 47636Jep028166
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Aug 2024 23:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1722913582; bh=VmaAGTx1wD/W53aSiZJmwqSRUde/TdzrR3XDoX7JRVQ=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Kxcbkszu3ob/vTjugSeK2rDLUNNrxWZ1IY/tOKH+MEk7/Zd89M2nSAoDLxP34y7C/
	 AH7kFAHly4P9vlTGn3AZlEgRdGiRKpjVL7qGrbp9QSbnCorieg2GH5hKEEz6lHbuEM
	 kJ1l+ezTPJTj0k6KjJShtFBFwPY9ccmtYlpvEbfKVD0zn7q1mFwvu5DvbGKrNIhZ/O
	 r6ZxEb4hSCPgMj6mDDDo6S5IKHwgdD4muz0Lu2jSkODOeBjfCQ1Xoed085v8axbhMB
	 Yh8HYQsSEq8bhdO8U4oD9tmaz7fwZL9Piu82HeyFpB9W/ZfDpvjQH4joPE7r8+p+8a
	 MrCqAH44fmBkQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 60C5715C0330; Mon, 05 Aug 2024 23:06:19 -0400 (EDT)
Date: Mon, 5 Aug 2024 23:06:19 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: LidongLI <wirelessdonghack@gmail.com>
Cc: gregkh@linuxfoundation.org, kvalo@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        mark.esler@canonical.com, stf_xl@wp.pl
Subject: Re: Ubuntu RT2X00 WIFI USB Driver Kernel NULL pointer
 Dereference&Use-After-Free Vulnerability
Message-ID: <20240806030619.GB1008477@mit.edu>
References: <2024080359-getaway-concave-623e@gregkh>
 <20240806015904.1004435-1-wirelessdonghack@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806015904.1004435-1-wirelessdonghack@gmail.com>

On Tue, Aug 06, 2024 at 09:59:04AM +0800, LidongLI wrote:
> 
> Yes, as you mentioned, it requires users to create their own udev
> rules, which is not common among Ubuntu personal users. However, in
> some non-personal user scenarios, they must pre-add udev rules to
> meet their needs. A simple example: in some Ubuntu embedded Linux
> scenarios, we found that when starting a wireless hotspot,
> developers must configure udev rules to ensure a stable connection,
> enable auto-loading of drivers, or auto-run or write USB-based
> auto-configuration scripts.

Yes, but when the user is setting up their own udev rules, they are
editing them as root (e.g, "sudo nano /etc/udev/rules.d/").

But in your exploit scenario, the *attacker* needs to be able to
insert a specific udev rule to allow the attack to succeed.  So that
means that the attacker needs to be able to manipulate the user to
insert a udev rule which allows the attacker to acarry out the attack,
or the user has left the udev rule file in such a way that it is
writeable by the attacker.  But in that case, the attacker can just
edit the udev rule to arrange to run some script as root, ad it's
already game over.

Your argument is roughly the same as "sudo is a vulerability because
the attacker could run (or trick the user to run) the command 'sudo
chmod 4755 /bin/bash'.  Well yes, if the attacker can arrange to run a
particular command as root, it's game over.  But that's not a security
bug, but rather a bug in the gullible user who has root access.

Similarly, if the user has a insecure configuration --- say, suppose
the user has run the command "sudo chmod 4755 /bin/bash", it does not
follow that this is a reason to request a CVE for /bin/bash.  It's not
really a security bug in /bin/bash, but a bug in how /bin/bash was
confiured.

Cheers,

						- Ted

