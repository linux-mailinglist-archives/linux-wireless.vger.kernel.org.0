Return-Path: <linux-wireless+bounces-7135-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC8F8BA9DD
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2024 11:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07C041C20D9F
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2024 09:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2E9139CE5;
	Fri,  3 May 2024 09:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="UNmvbb4u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09706139596
	for <linux-wireless@vger.kernel.org>; Fri,  3 May 2024 09:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714728444; cv=none; b=pDYrj9iC6ZonvHhGS1uIqsQ2AOmgDQ5k1zfqnyyuUqswYmKLDxxBM9l5Fg7EL+tpxkP9izdOw1qQO48wevCfYt3lFfafm6VlbozKaZyksird84uxwzteJITCDqs0sxV66ji7z8c8nE4CPzMmb8KJPBB4ZhLyB4fbWhfRUgb/jDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714728444; c=relaxed/simple;
	bh=2s7DeluZDVb1XJcdL4KAWDAifSxvo/q7wwqk8IGAFMs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mqAArWW/slLq1me9LZiyQovFn28din/+caP6+4yn8eDQihcDRVXGM1euwuxH5DmmNClkC6J+gm14AOE7qLiAb5NmUTBuI/oTMelltsE/mgDtIw995PhjXZZIpx4AzM9XYHAoQlDoiXfALdp0GczYs7btPsIhuPpWBFd7TDpM3NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=UNmvbb4u; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zvoaLEoLVfuj/TEnAwzhfD/jgdKZZlOpp1Fto2Myzak=;
	t=1714728438; x=1715938038; b=UNmvbb4u+EHOQ9qAqInwTHkZ2o7Jhs/fKkfTCmYuSDkTNms
	Wf2BkPps47MlOuk186F3+6jBQf1QH+4gm6HqALPZ4OFOxEfLB3o4nZCwzN1zZ8Qit7igVWlImRob5
	wrra3eiZikpIlUaOt0ZJ/sml0C7BN5rPaNLwJQA6SUuxXXDo/GoigyAMV25um9NlUa1lHsrSZujD/
	nCtF5LL8k96CJFpcCYwpR6cH1W8AWD8n3U+Yt2JQXZC8/tP/esxqaysWVLCyTDlZKl+XoZV9xrx96
	ffXL/JmYVYfkV7VvNqwnZmfOhdk7XImsyesPmwZ2JWNkwwy09HVhHOvDaIHEEKTA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s2pCB-00000001jXD-0C2J;
	Fri, 03 May 2024 11:27:11 +0200
Message-ID: <226dad2f0736d9b5c3313943dce93f57cb6f4b2a.camel@sipsolutions.net>
Subject: Re: [RFC v2 0/2] wifi: nl80211/mac80211 Handle BSS critical update
From: Johannes Berg <johannes@sipsolutions.net>
To: Rathees Kumar R Chinannan <quic_rrchinan@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Fri, 03 May 2024 11:27:10 +0200
In-Reply-To: <20240403162225.3096228-1-quic_rrchinan@quicinc.com>
References: <20240403162225.3096228-1-quic_rrchinan@quicinc.com>
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

On Wed, 2024-04-03 at 21:52 +0530, Rathees Kumar R Chinannan wrote:
> When a critical update occurs to any of elements inside beacon frame, AP
> shall increment BSS Parameters Change Count(BPCC) subfield and set the
> Critical Update flag subfield of the Capability Information to notify
> client that the critical update occurred on AP. Refer section "35.3.10
> BSS parameter critical update procedure" on IEEE P802.11be D4.0 for
> details.
>=20
> On beacon offload case, change in CU parameters should be sent to user
> space either before or along with probe or assoc request frame receive
> to ensure that user space uses latest CU values and BPCC while generating
> response to the received frames. So, add the critical update parameters
> as a new attribute to existing NL80211_CMD_FRAME command instead of
> sending this on a separate NL80211 event.
>=20
> Add an ieee80211_critical_update() API to send the parameters to cfg80211
> and call it when event received from firmware to update critical
> parameters to user space.

Somewhat more conceptually, I wonder if we should really handle this
hybrid approach? You're offloading the beacon updates, why not offload
the probe/assoc response cases as well? Are they really _that_ much more
complex? What does the hostapd code for this look like?


Also, as we already discussed, this is fundamentally racy today, and
that cannot be fixed unless you really put it all into the firmware,
directly in the TX path, which is probably never going to happen.

So under the assumption that it already *is* racy, I'm not entirely sure
I see where this is needed at all?

You're basically handling two (kinds of) values here:

 1a) CSA counters: these are today handled in mac80211, and we've
     already decided that we need to handle them also in mac80211 (and
     get offsets to the partner links from hostapd a la
     NL80211_ATTR_CSA_C_OFFSETS_TX).
     Yeah this is still racy, but you can't fix that without offloading
     it all anyway.

 1b) BCCA counters: these are missing today, but that should be fixed,
     and then it's just the same as 1a.

 2) BSS parameter change count and critical update flag: are these
    really actually completely by the firmware? I'm not sure how that's
    necessary, since hostapd initiates all the relevant operations? So
    not sure why you need these at all, couldn't hostapd track this and
    you just copy it across to the other links?

So for 1a/1b I don't even think we should push this to hostapd, it's not
necessary and it will just cause more API fragmentation, because already
*know* that we have to do things like NL80211_ATTR_CSA_C_OFFSETS_TX for
other devices (and hwsim) for this, just more complex.

Thus, I don't think this is right. We can handle your case the same way,
and you don't even need the NL80211_EXT_FEATURE_CRITICAL_UPDATE_OFFLOAD
flag right now, by just pushing the offsets into the kernel and handling
the values coming from the firmware by filling in at the right offsets.
Could perhaps get the offsets down into the driver and do it there, or
just handle it in mac80211, not sure.

But this then doesn't fragment the API here, because hostapd will just
give all the offsets, and the below stack (mac80211/driver/fw/hwsim)
will fill the values.

Not sure about the BPCC and critical update flag, but let's think about
how that would be handled on other hardware? It feels to me right now
that hostapd should already be in control and know this, and not need
any indications (it does control all links), but maybe I'm wrong (or
there's just some extra case the firmware might do) and it doesn't, but
then let's also consider how that would be handled in other hardware (or
think about hwsim instead), and find API that doesn't fragment so much.

Yes we'll always fragment whether or not the partner link beacons need
updating, but it shouldn't need all those different paths for everything
else too.

johannes

