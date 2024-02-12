Return-Path: <linux-wireless+bounces-3458-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D15AF851745
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 15:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68F291F229DD
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 14:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CBA3C088;
	Mon, 12 Feb 2024 14:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="NnFV0U9i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445D43C067
	for <linux-wireless@vger.kernel.org>; Mon, 12 Feb 2024 14:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707749194; cv=none; b=T4EM/nGX8b6vNdRyM7PXpsBJIH1E/OiQ1tmsYe5Dxm7sgw5Ln1P80/ErpK06RVHxw2aOpsvGGvm6J7EJ1H0P+w219TeumHlWzouDCdcwNAcfODRCKKomVuh6ho17BMkIDxVQEwmjzwaON3/euAdQZLuzSwHxPRsIi2pYrI2g4dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707749194; c=relaxed/simple;
	bh=MRw+u5lmk2+/xuwLBMmMK0MmtAiBBTAFPPu0Laj1HcA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mUOK5cPG0dOQaP5W884nrVQJM60QPFDN8xjV7VBS1ii1rmwxmtpqG2QHLa2cj2/SkC0GoU4OUb1rcJ0KkHMwrJYC6D+7RDpP2uq7VBnoKRXxveBLeyzuJJp3p9fl/oiQyUjAzsI9doVNBqJgakyRcmuQ6TvoE00+FueC7Mu+vZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=NnFV0U9i; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=nzNF2blEpO8cg67fVYiDOXN8GwiFy2C+1xozYNmaTp0=;
	t=1707749192; x=1708958792; b=NnFV0U9iK/QpgZMGkH17ghVY8KLbdJd9LkMk/7oZvyaUIBa
	fMRLBh/W5A8bZrq2c1tpzg+QvxEIZVGcOrgvxEygnPOzSZ2eLr5YQXdmusbmqdGkH6nBR6XiUmwii
	yhtForlGZMIw55Co+06S9hF3AXIxBfZ9bPS6gOaGiYPwYVg5T+wYnkmAld6U+4z9ldhow0O8WiYqI
	EiESRsXGRQPLm5FDk6cGo783Dsnu5m8Pg2ws1/nB7J9O9gPM3OE5qJsJKSb6U3WnnozuNGC6XG7kl
	hIlTpfOlSgGkmW/kAgRXn5kQTDomXW9UkvZPWt/XgcwFDKqQb5Z50t7p4qIWpByw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rZXZi-00000006CQA-3uZK;
	Mon, 12 Feb 2024 15:46:27 +0100
Message-ID: <f7174207668cac149246cafa0e4b4749ee3289f0.camel@sipsolutions.net>
Subject: Re: [PATCH v8 4/5] wifi: mac80211: start and finalize channel
 switch on link basis
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Jeff Johnson
 <quic_jjohnson@quicinc.com>,  Ilan Peer <ilan.peer@intel.com>, Jouni
 Malinen <j@w1.fi>, Ping-Ke Shih <pkshih@realtek.com>, Ryder Lee
 <ryder.lee@mediatek.com>
Date: Mon, 12 Feb 2024 15:46:25 +0100
In-Reply-To: <b2cf5c1d-7842-4e59-b25a-904a6879fa9c@quicinc.com>
References: <20240130140918.1172387-1-quic_adisi@quicinc.com>
	 <20240130140918.1172387-5-quic_adisi@quicinc.com>
	 <b73dd1f9c23c164179c38e2109aa1550d87e87ed.camel@sipsolutions.net>
	 <646d1e3e404a437f4c99c80996eb4f194ac242b8.camel@sipsolutions.net>
	 <26df9aa6-e497-4040-ad5c-c647454acca6@quicinc.com>
	 <b2cf5c1d-7842-4e59-b25a-904a6879fa9c@quicinc.com>
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

On Mon, 2024-02-12 at 12:48 +0530, Aditya Kumar Singh wrote:

> My bad! I see you have applied the changes. Thanks :)

Right, sorry that wasn't clear.

> Looks good to me.

OK, thanks for checking.

> Let me see on the hwsim test cases and if possible=20
> send it soon for review to Jouni.

So ... I'm looking at the client side, and thinking about that.
According to the spec, multi-link element should be present in beacons
of APs affiliated with the same MLD if one of the (other) links is doing
CSA, and then have also the CSA counters of course, relative to the
target link's TBTT (of course.)

Theoretically, both mac80211 and hostapd today support different beacon
interval on different links, I believe.

This makes the whole thing of including CSA for link A on beacons/probe
responses transmitted on link B very tricky, because you have to know
the timing, etc.

For the CSA counter of a link _itself_ we have counter_offsets_beacon
and counter_offsets_presp (for probe response offload) in struct
cfg80211_csa_settings, and also counter offsets in struct
cfg80211_mgmt_tx_params for sending probe responses.

But ... for the cross-link information in the MLE this gets way more
tricky? Especially if the beacon interval is different - we couldn't
just count down, we'd have to fill in the information when we know where
the frame is transmitted. For probe responses maybe we can afford to not
be perfect, but for beacons it better be right - so we have to calculate
the right counter value(s) for (all of) the switching link(s) according
to the current TSF, TSF offset and TBTT - not all of which we even have
in the driver?

I can see a few ways of implementing this:

 a) Punt to firmware and it parses the multi-link element etc. to
    find the places to update. But that's awful, it requires parsing
    possibly fragmented MLE with fragmented subelements containing the
    CSA elements inside ...

 b) Punt to firmware and give it a (possibly long) list of offsets K_N
    where to put the N'th counter for link K when transmitting the
    frame.

 c) Require the get_tsf operation and add an operation to retrieve TSF
    offset (**), and then calculate the TBTT for each link when
    beacon_get is called with the per-link beacon intervals and update
    the values correctly if CSA is in progress on any link ... requires
    against parsing like in (a) or offset information like in (b), but
    at least now it's in software?
    For probe responses this could be a bit off I guess, but maybe that
    doesn't matter as much - probe responses are not authenticated so a
    client probably shouldn't use them for real CSA anyway.

    (**) which I guess we need anyway for hostapd to put it into beacons
    etc.?

 d) Require beacon intervals to be the same, and then just count down?
    Still requires the offset information etc., but that's also not
    great because if the configuration happens during a TBTT on any of
    the links (some before, some after), it'll be very wrong. So not
    very inclined to do this one ...


Do you have any plans for any of this?

I'm mostly asking right now because I want a reliable way to test the
work I'm trying to do on the client side though, so I could also live
with some hacks (inject through debugfs?), but having it for real would
be nice.

johannes

