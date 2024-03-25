Return-Path: <linux-wireless+bounces-5222-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 719E588ABD2
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 18:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A7EF2E5F38
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 17:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D33146A7D;
	Mon, 25 Mar 2024 16:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="QuZ/olKr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B81F84047
	for <linux-wireless@vger.kernel.org>; Mon, 25 Mar 2024 16:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711384382; cv=none; b=CTz8fXYTTig2vAi4Xaib3zApYO2fAiB4pZxPMzvWx7fgyn46ZGB0KcyD0v5wcYRTV1RFt1mU2h/ssnFWAoeiXxF9JYwkywzL/61wx+v6kZTUqW8iFW4qvHVODaRZ4tpubVi/eI8xMLl4uhwvVAzilqXzZT2hzo7orRbK4e/xQjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711384382; c=relaxed/simple;
	bh=gGjXkXJdYs7YTScboi+CHwojUWcX1kNCosLPke24bBM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bavBoC4WreSZJ4Hu0Ggl9LlN165a89Q1ptwyroihvZU7qR9sRiDPxEWwt//R+i8fHjCzq92qX1VUMPftPGS9k9bzUz8jgEihgO2ckgGc1vsw3ofIycKIE3ZbBdBqLyNKOhiwJ4KeWC57BHolYXZ7uEZJgD4P0w+LNueLlhtkBN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=QuZ/olKr; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=C4JkLaPzy+FHNYkjByuPk97Bb325dxvMetJZG1ECmpo=;
	t=1711384380; x=1712593980; b=QuZ/olKrixp9ISGWYrUOpzxw3Z8etI/Scc+8NhY5j913clu
	d6GQY+lfBE2Hd3Lif0AQOhLLQCVT1aqrL814ERwciVg57U814u+15f0vn6gCpYE27ZPjycNxn+oBe
	hjZSFCNfxTDWtghjBUHsojVJOR7kNTByO54fY1ArvypnbH1e5PaldSSG4eDbq4jGjmA6wxusICYtY
	ARykyGTZSjh7OdZhnW+VHiAXgKSFiN5AhboMvHXPEQmLkcfuoDslzajFsmVAss7q20EH67lIyVMgG
	Q9NVx+hWIS/FYUqbIKuFwYZtu1xC+QQnkZb9YQ61p4/5xKxZ53Mbs+sqMLK3PHLg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ronFk-0000000Dx5A-2jqM;
	Mon, 25 Mar 2024 17:32:52 +0100
Message-ID: <f3ab160dd84e936134c6aa60e2f6d0fcf4d61e4c.camel@sipsolutions.net>
Subject: Re: [PATCH v12] Add JSON output options to 'iw' for scan results
From: Johannes Berg <johannes@sipsolutions.net>
To: Isaev Ruslan <legale.legale@gmail.com>, linux-wireless@vger.kernel.org
Date: Mon, 25 Mar 2024 17:32:51 +0100
In-Reply-To: <206d1b47b7ece7ccd1c371d23ae1f1c6.legale.legale@gmail.com>
References: <206d1b47b7ece7ccd1c371d23ae1f1c6.legale.legale@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hmm.

Honestly, this output is awful. I can kind of understand where that's
coming from (the desire to have an object created for each element in
the frame, but ...)

>=20
>         TSF:
>                 usec: 321559832898
>                 dd: 3
>                 hh: 17
>                 mm: 19
>                 ss: 19

Really?  We used to print this as

	TSF: 0 usec (0d, 00:00:00)

(not sure why all zeroes here but anyway)

>         Frequency: 5180
>         Beacon Interval, TUs: 100
>         Capability:
>                 ESS
>                 Privacy
>                 ShortPreamble
>         Capability Raw Value: 0x0031

	capability: ESS Privacy SpectrumMgmt RadioMeasure (0x1111)

>         Signal: -72.00 dBm
>         Last Seen Ago, ms: 2740
>         BSS Probe Response Data Frame:
>                 SSID:
>                         SSID: tobe52

That's just silly.

>                 Supported rates:
>                         Rates:
>                                 6.0*
>                                 9.0
>                                 12.0*
>                                 18.0
>                                 24.0*
>                                 36.0
>                                 48.0
>                                 54.0

	Supported rates: 6.0* 9.0 12.0* 18.0 24.0* 36.0 48.0 54.0=20

And that stuff is a really pointless output in JSON, for JSON it'd be
much more useful to output an object with actual (integer) values, and a
flag to indicate 'basic', or something.

Anyway ... I think you're hyper-focused on exactly the wrong thing.

Arguably, for scan results, the right thing to do would be to just
output the raw elements in the JSON, and not do any of this parsing.
Then you can use your favourite parsing library (dpkt? tshark? ...) to
actually understand the data there. We really don't need to expose the
element parsing logic of iw, especially not in a bad way like this.

Also, outputting the *string* data in a machine-readable format like you
do now has very little value, and yet it ties us to a specific output
format that we'd probably have to consider stable. Bad idea.

So I guess I'm saying yhou should abandon this line of changes in this
code entirely.

Much more interesting, IMHO, would be to focus in pretty much anything
_else_ in the iw code, e.g. the output of 'iw dev', 'iw wlan0 info',
statistics, etc. Maybe 'iw list' and similar too.

Although I suspect that what we really need is better access for tools
from nl80211. Maybe the "JSON" output format should just dump the raw
nl80211 message attributes that are involved, or something.

johannes

