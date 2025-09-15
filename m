Return-Path: <linux-wireless+bounces-27324-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21750B573AC
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 10:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D61821894FDC
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 08:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A9B2F0689;
	Mon, 15 Sep 2025 08:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="LtBl9Fo0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC572F3C3B
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 08:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926392; cv=none; b=qTqsbK7toNWmNu4k2VKsm2ICTHLQuLAfOlYdbwY8zt3yXAym1yxxPM+myr4rQM4WuDxAmpWvxlRwHh3JO62DLbLs8dVLVSx1OurJbkV4dRtkCTRFm9kk857XocgXi2FQZe+lvu3MvaCRCG5dw5mtwI/On8Frmk16gi91FcDSmV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926392; c=relaxed/simple;
	bh=H+22KKChXzNX9iM6KKlsTWWBok/h/ZWmSrWZePYLO0c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JszuzSn1m4WMwN3q61Y+VGHseeYKHcHHyz1ikkNxjYjaK6GoRy57CkoehrMGQ8klSRrxnHWyDdpbRYZtXCJxtnNz7zmwInrlYDN3a/t6JtmCD/mRceyML9ePi911NyXe2LvE81sfZONzTakgU4hrgipdkSGOCGV2OCeah4g41bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=LtBl9Fo0; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=H+22KKChXzNX9iM6KKlsTWWBok/h/ZWmSrWZePYLO0c=;
	t=1757926391; x=1759135991; b=LtBl9Fo0WV980vzsMo0Shv8zIPXlx5s8Na5XDaWmqiw8fcP
	k/NqgiBl8d1RZnd7Amhah2VlwEYmSA+3ugQ6fxFEh1UdpnxXld+BFsxgKTE4hFfJVjsWzS6rquY0v
	Ztg2RycupOw/1OjdpLxNScAAoc6Ah7ogRhbJaQTzmkABQRKV3j4n8Bd/7nty00atuquCsCvtBukDj
	tKJykhim0OOILTScpGd65lFpntk44NpjwR2t4o2aer4Wffxl7sI7Cj70tQfWWnxPkbARiuaHllA2T
	7L0ps81qU19vxligWQkSJVMACmpW+UBXwcCk3KuUOT9NzPNThPd664zi6aKqSLfg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uy4xQ-0000000647R-4Ax2;
	Mon, 15 Sep 2025 10:53:09 +0200
Message-ID: <5e0d4ccc88a292f5087ef16a3de4fb642a7ddcab.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: always mark 6 GHz BSS as QoS/EDCA
 capable
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Isaacs <scaasiffej@gmail.com>
Cc: linux-wireless@vger.kernel.org
Date: Mon, 15 Sep 2025 10:53:08 +0200
In-Reply-To: <CAOYMkPpsLa9dBeAwrS7o3--0D9O4is7D8qU_OAjLyh9hwJpBLA@mail.gmail.com> (sfid-20250910_230507_015661_713613FB)
References: <20250909135510.757750-1-scaasiffej@gmail.com>
	 <8d5d8339f1dd568f43d97c4ed60817df1838fc13.camel@sipsolutions.net>
	 <CAOYMkPqAt-ETcwL7ZzUUB=0YO-ML+Mh60cB_-8MZj6zcp_-Cxg@mail.gmail.com>
	 <2735aec6379159923299d6cfb916a2bf03aecf18.camel@sipsolutions.net>
	 <CAOYMkPpsLa9dBeAwrS7o3--0D9O4is7D8qU_OAjLyh9hwJpBLA@mail.gmail.com>
	 (sfid-20250910_230507_015661_713613FB)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2025-09-10 at 17:04 -0400, Jeff Isaacs wrote:
> FWIW (probably nothing), after applying the patch and getting past
> authentication, the association response has the WMM IE and also includes
> the MU EDCA parameter set, so everything seems to be within spec from tha=
t
> point forward. The sole problem really is the incorrect assumption of
> inheritance to the non-Tx profiles.

One additional problem though with this is that we're not actually using
the intended inherited values, but rather the defaults. That might be OK
in the specific situation you have, but might not be OK in general. Also
(at least in theory) the QoS/WMM parameters can change during the
lifetime of the BSS, and then the station might not know about updates
from the beacon since they aren't present in the expected way there.

In both of those cases the station can then cause conflicts with medium
use vs. other stations, such as always winning or always losing the race
to transmit if there's contention.

> I spent quite a bit of time turning knobs in the Ruckus controller and AP
> CLI trying to define a different QoS profile per SSID, so that maybe it
> would be explicit in the non-Tx profile, but it still wouldn't show up un=
til
> the association response.

That's pretty strange, in that case it shouldn't even be inherited. That
almost seems like an additional bug, though chances are when they fix
things both will just be fixed.

> I also tried to use iw to set the SSID within a directed probe to the AP
> over its 6 GHz channel. At least in theory, the AP is supposed to include
> all QoS params in the response. It didn't work, but even if it did, it's =
still
> not an excuse to disclude the params in the beacon frames.

Interesting, not even _that_ worked... oh well.

> Thanks again for the very detailed response!

Thanks for understanding! I really do hope they'll fix it soon - FWIW
the issue we were already discussing with them (via other parties) was
on the same AP model.

johannes

