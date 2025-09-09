Return-Path: <linux-wireless+bounces-27184-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2417B4BE0E
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 14:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52ACD16653C
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 12:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC001258ECC;
	Tue,  9 Sep 2025 12:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="u4SPqf4K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEDE314A83
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 12:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757419654; cv=none; b=PhdeLpAPEpf7NPwUPn/TMdmJ3Rt4Mjwk5h+zlPi07c6YgsWJbXttfu3qKN/pY4sH36luMX7HMA5nbgqpj1ugrFqlBWT8SGHxxBc+ENwaRibxnFT/wzVSnKTH1fHaN3qNnjLgaTe2+Nk68VhHuUdQj2SwmlbKR5tx65elDKga2Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757419654; c=relaxed/simple;
	bh=MyJAxWtrl1VpnM89lwLe43XnbBbcqPOetX2Yt6bP+Ik=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DLxi7a0h8xZwXjd2vJd21dbRXLVMYghmh7p/Nq6j1JykykoyIsj4prVIJThrNsoMBKQkrW7SlJqZfsk6QdZXz0u+PF6uJAkocb9AMo+D4RNjLf7Ix0ro/XuZVSfJ4W+j95fI0WwlkO9l6sVCVvzUoKDIOSgkW3uvrO77lF59Iu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=u4SPqf4K; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=MyJAxWtrl1VpnM89lwLe43XnbBbcqPOetX2Yt6bP+Ik=;
	t=1757419653; x=1758629253; b=u4SPqf4KozjGNiRlDPLxX+tz96fbM/h596mDefsRUtg2GhR
	YhQjlb3/oGhEQdSB0sUAOA73x1rmaQfEEW4uaUU3WFRoRHpd4+AkoFj5tzxe7hW8R9ue5psK2EGGm
	s4G06x62l6fExdmOYEMah0k7JFZMcQILJ6UL/B9au63J8dR8132xFGoX3uIftjPmuvYxNOtcnF39C
	a8qYeTNZ6LYfmB75KUuLe03Q1DSAGZ4wK2eqpJfY04t8lfQP8BOU/Y275aXFIYeiUyesijcHiYoA8
	9lU3C1vQt9FFjDLSYIUyxKsB0sI55kA7fgndWCo3QSS2DTvgt8yR7DC/O9HoingA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uvx8D-0000000AFAi-1mnP;
	Tue, 09 Sep 2025 14:07:30 +0200
Message-ID: <616281cfe861b4b18115feffea7f160cc749cb52.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next] wifi: mac80211: add tx_handlers_drop
 statistics to ethtool
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Hari Chandrakanthan
 <quic_haric@quicinc.com>
Date: Tue, 09 Sep 2025 14:07:28 +0200
In-Reply-To: <f220c991-f17b-498c-a0a6-68ead97b2e44@quicinc.com>
References: <20250822052110.513804-1-quic_sarishar@quicinc.com>
	 <ce5f2bd899caa2de32f36ce554d9cada073979c0.camel@sipsolutions.net>
	 <f220c991-f17b-498c-a0a6-68ead97b2e44@quicinc.com>
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

On Mon, 2025-09-08 at 21:25 +0530, Sarika Sharma wrote:
> On 9/4/2025 2:56 PM, Johannes Berg wrote:
> > On Fri, 2025-08-22 at 10:51 +0530, Sarika Sharma wrote:
> > > Currently tx_handlers_drop statistics are handled only for slow TX
> > > path and only at radio level. This also requires
> > > CONFIG_MAC80211_DEBUG_COUNTERS to be enabled to account the dropped
> > > packets. There is no way to check these stats for fast TX,
> > > at interface level and monitor without enabling the debug configurati=
on.
> > >=20
> > > Hence, add a new counter at the sdata level to track packets dropped
> > > with reason as TX_DROP during transmission for fast path, slow path
> > > and other tx management packets. Expose this via ethtool statistics,
> > > to improve visibility into transmission failures at interface level
> > > and aid debugging and performance monitoring.
> > >=20
> > > Place the counter in ethtool with other available tx_* stats for
> > > better readability and accurate tracking.
> >=20
> > As much as I don't like ethtool for wifi, I guess you found a use where
> > it's actually the right thing to use even in wifi ;-)
> >=20
> > But why not remove the old debug statistic, you have a superset now?
>=20
> I believe you're referring to removing TX_DROP_HANDLER from the=20
> DEBUG-enabled statistics as part of cleaning up the old debug entries.
>=20
> If that's the case, I=E2=80=99ll go ahead and send a follow-up patch to r=
emove it?

Works for me.

johannes

