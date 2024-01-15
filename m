Return-Path: <linux-wireless+bounces-1943-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 547DE82E114
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 21:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03AA4282E4B
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 20:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB8F18E25;
	Mon, 15 Jan 2024 20:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="NlnYItp0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459F918E20;
	Mon, 15 Jan 2024 20:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=CRFKM3mqGAyECZMl3VOp9tD4rz9UsD6jBBbM8HZGeCo=;
	t=1705348834; x=1706558434; b=NlnYItp0QYFifMRCAJqA0hl3YFYH/i4FY3fiQDEnE2iNmGA
	XSz5NXcH6rr93u0sBKmMlysLo8bsi343qvg2hD+BpvkCx7g9sNZh6FIyzduG9ja9nwefCuFjOUdle
	hkFJP2RB0om1eHFTPbNztjTDxDw5rFREBE6cfvB0/iEAPsM595Ha5mjizhyFpKOelJCXR5dyDhRfD
	2QeIDGdoOcDMW15tlTru3XqHLIFFe16hHIiMmq9Vsz3OHMm8P1+6zcaYFsAZPYcPJ74dF5j3/omSV
	bjueHTaEyKw5ICOQL3gEBu0GB0HFYoG5j4RCREJQrYh363F1c4EnRnowamxaLnFg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rPT8I-00000003kqH-2U5O;
	Mon, 15 Jan 2024 21:00:30 +0100
Message-ID: <dae4bb032ad8b0c9fa6547de5e869e51f9f6e766.camel@sipsolutions.net>
Subject: Re: [REGRESSION] 6.7 broke wifi "AP is in CSA process, reject auth"
From: Johannes Berg <johannes@sipsolutions.net>
To: coldolt <andypalmadi@gmail.com>, ayala.beker@intel.com, 
	linux-wireless@vger.kernel.org, regressions@lists.linux.dev
Date: Mon, 15 Jan 2024 21:00:29 +0100
In-Reply-To: <CAJvGw+DQhBk_mHXeu6RTOds5iramMW2FbMB01VbKRA4YbHHDTA@mail.gmail.com>
References: 
	<CAJvGw+DQhBk_mHXeu6RTOds5iramMW2FbMB01VbKRA4YbHHDTA@mail.gmail.com>
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

On Mon, 2024-01-15 at 16:39 +0200, coldolt wrote:
> I'm on Arch linux, updated the kernel from 6.6.10 -> 6.7.
>=20
> Now it doesn't connect to my 5GHz wifi, to 2.4GHz it still connects.
> Also the earlier kernel version still works. Output from "sudo dmesg |
> grep -i wlp2s0":
>=20
> > [    6.049600] iwlwifi 0000:02:00.0 wlp2s0: renamed from wlan0
> > [  131.095861] wlp2s0: AP is in CSA process, reject auth
> > [  132.143170] wlp2s0: AP is in CSA process, reject auth
> > [  133.599906] wlp2s0: AP is in CSA process, reject auth
> > [  135.549325] wlp2s0: AP is in CSA process, reject auth
> > [  145.510438] wlp2s0: AP is in CSA process, reject auth
>=20
> I notice that the commit c09c4f31998bac, which was added to kernel
> 6.7, introduced rejecting a connection with that error message "AP is
> in CSA process, reject auth".
>=20
> My guess is that commit is the cause of the regression.

I guess? But that was quite intentional - we don't handle connecting
well while the AP is switching channels.

This really shouldn't persist for longer than a few seconds though, even
the 15 seconds sounds pretty excessive.

Could you show the output of

$ sudo iw wlp2s0 scan -u

for this AP?

johannes

