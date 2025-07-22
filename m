Return-Path: <linux-wireless+bounces-25871-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B06AB0E05E
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 17:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FA7B6C1F97
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 15:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E28264624;
	Tue, 22 Jul 2025 15:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="cw6wOJ6C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65E3266EEA
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 15:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753197712; cv=none; b=lP5nr29SToqyLX7FgV8hKow8ahr7ug0S1nsFFjqotamV8Cj+0vu+8QLgoQFPpWNQ9HezEwZcwOobBAAKz9sCM6ynoP6vzcPCP7f9qpBmsmjerH2/0TXxiii1ehm2ql0VvB+xeIG+mvGweKcWIG/lPTK2Xb3iL82f8oHsyUKhPxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753197712; c=relaxed/simple;
	bh=9G70Qo4aIqPrCO8v3K8vyW/ANKv/Ho6Lda2TKwBvcDs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rHrT9992eeZm36RLp6N4kQCVhlsFR8JB5xIwt8GkQNAqZ4n/i4aRPOjHKgaiQY6280mzHGas7xRdYI/pivo7ZbO4mEAT8oznhDxAdW5j/PdXp4MYf1WjLQWQLworBhgGXW2OzWfn19LHQdxlpHOYA2r378Nlic0d4uWWWAUVp/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=cw6wOJ6C; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=9G70Qo4aIqPrCO8v3K8vyW/ANKv/Ho6Lda2TKwBvcDs=;
	t=1753197710; x=1754407310; b=cw6wOJ6CPovV5X5IVp8tj0eFAzqzeGEDfSPch8XBJ8De/2Z
	OzXSrQzkQCKcVNsSBntJ0Dti8rbWPmucDiMeiL0OoUL1FXHdpW0ocv1H9k4Ogh0sTPtIFiODl+Cm5
	MrwSCejhYQbIsCqQZOr6Zy60uyR5/iC3OQY7B6UtkDrIwqXuF2jmfn0m6O9oiAlIeMDXSdKOhIDy1
	JZ5L/3Qk/Tu830cnUwG6IUNpdwWyNaxZr2xnNDqJX2knGdbhPmg/Rv5QTlGuD9hw9iALB8vn7PrcK
	jmZG864dWg0Lo6LDSciXzcLaCRogk1MHQezZI0CE55H7HM/wVrELcRTrKrpQuy9A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ueEoN-00000002HNK-3zKy;
	Tue, 22 Jul 2025 17:21:48 +0200
Message-ID: <ae90e7fbbe34f36278501a04b56bbc881a89f584.camel@sipsolutions.net>
Subject: Re: WARNING check-sdata-in-driver in
 ieee80211_link_info_change_notify
From: Johannes Berg <johannes@sipsolutions.net>
To: Martin Kaistra <martin.kaistra@linutronix.de>, 
	linux-wireless@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>, Emmanuel Grumbach
	 <emmanuel.grumbach@intel.com>
Date: Tue, 22 Jul 2025 17:21:47 +0200
In-Reply-To: <76fa16a8-367e-4f05-9c50-c9ac08ee20ff@linutronix.de>
References: <a9de62a0-28f1-4981-84df-253489da74ed@linutronix.de>
	 <f06f3b3e40e104cb9fcdb086d8f9fff146225330.camel@sipsolutions.net>
	 <76fa16a8-367e-4f05-9c50-c9ac08ee20ff@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2025-07-22 at 17:13 +0200, Martin Kaistra wrote:
> Hi Johannes,
>=20
> Am 22.07.25 um 14:11 schrieb Johannes Berg:
> > On Thu, 2025-07-10 at 09:47 +0200, Martin Kaistra wrote:
> > > Hi,
> > >=20
> > > when trying to use monitor mode with either rtl8xxxu or rtlwifi drive=
r I get a
> > > "Failed check-sdata-in-driver check" warning in
> > > ieee80211_link_info_change_notify(). Aside from the warning, monitor =
mode seems
> > > to work fine. This might also affect other drivers, I just don't have=
 the
> > > hardware to test.
> > >=20
> > > I bisected and found that the warning started with c4382d5ca1af ("wif=
i:
> > > mac80211: update the right link for tx power").
> > >=20
> > > I can make the warning go away when I add WANT_MONITOR_VIF to the dri=
ver, but
> > > the real fix should probably go in mac80211.
> >=20
> > Strange, I'm not sure I see the relation with the commit you mention.
>=20
> Before the mentioned commit __ieee80211_recalc_txpower() returns false an=
d so=20
> ieee80211_link_info_change_notify() doesn't get called.

Hmm, still, I'm not sure I see why it changes anything for _monitor_
since those only have the deflink, so link[0] =3D=3D &deflink and that
should've been the same all along?

Anyway ...

> I can confirm that with the code snippet (with an added curly brace) I do=
n't get=20
> the warning anymore.

I guess it's a reasonable fix, I'll send a real patch.

johannes

