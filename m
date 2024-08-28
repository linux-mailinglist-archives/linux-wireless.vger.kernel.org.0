Return-Path: <linux-wireless+bounces-12155-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82546962540
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 12:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 397FE1F23240
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 10:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FE815C15B;
	Wed, 28 Aug 2024 10:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="q6b20qn3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50275A79B
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 10:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724842202; cv=none; b=fkV8s3ZTGL4+ohNcsYxoavErVeYWM+caTrHD4apAAD6QnEPL44Z7ODdorB4nV8cWZuOldy+goZClKcsPq95bbB2yazCeuJtJbJxHVG3e8zLI0PeD9fEcUdqISHS/Qx9B8DsKLSYNKqczzoX4M4JB3RNy+8DPcDX3yLVHx2hWlFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724842202; c=relaxed/simple;
	bh=m3lk68im/N0rY8mMHqVHl3slS+p7e3jKLOGc+h0Tn08=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GRwDVQfOiji0e3cnDPfwmL2R25R+PRJnWfmh6fisVho8upS09LgfwNrEjxw90YDWoEbQ/h7f3EqtvMKwrTzYCuPkqtXYSZsMOuipNnVjAMtTbwZOB5tC6l3boC43XC0IS45Aviu02mF5rE67QjXmAG9Fg2DrtFVobm+5GHhB/h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=q6b20qn3; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=m3lk68im/N0rY8mMHqVHl3slS+p7e3jKLOGc+h0Tn08=;
	t=1724842200; x=1726051800; b=q6b20qn3G7NX4LGROrjjFKb123mHIIVxjEVEJCMJQZW5i7o
	nWcV3TT1xrlX/wuhMX6eDMgM64mA3HFQiGPY8aTQv7HcAwr8eAqnozlCiFlaVpqIDtmQPpXqifN4y
	D9l0sZOOzyH4flhIbDHE6vzSSKoxkQ1d1kptkXudDQ4TkJX8g1spBTWLcofgbDrCL454V05ICIGax
	PG40fRcB8QMYV2m/piTCUJWw0N3VbGJzFcisZSBJP19UhLs8LdkJ99idXm7O32nQqNYuNP7hSNtBP
	KH/lahSTkgAjzW3hU2a83zGaNtX0AC4UhMkPrzYrqVj6iolX5nCrCL9Kug0ZK2Pw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sjGFR-00000006z3H-23nv;
	Wed, 28 Aug 2024 12:49:57 +0200
Message-ID: <d2ca7bdd57bb4d90e4b76846afb75dbc3bb9bd59.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: cfg80211: check radio iface combination for
 multi radio per wiphy
From: Johannes Berg <johannes@sipsolutions.net>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 28 Aug 2024 12:49:56 +0200
In-Reply-To: <20240813055917.2320582-1-quic_periyasa@quicinc.com>
References: <20240813055917.2320582-1-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

So ... I don't think this is correct, for multiple reasons.

One, you're completely removing *any* validation of the (global)
interface combinations in case per-radio interface combinations are
present. This is clearly not desirable. You're arguing the DFS vs.
multi-channel check shouldn't be done, but that doesn't imply removing
all checks entirely.

Secondly, I'm not convinced that the DFS vs. multi-channel check should
actually be removed, though I'll admit that this may be a bit
questionable. My argument would be something like this: The global
interface combinations exist to let existing software (that isn't aware
of multi-radio yet) continue functioning as-is. Since it is not radio-
aware, multi-channel can mean many different things to it, including the
ability to use say two 2.4 GHz channels at the same time, by time-
sharing. This is e.g. used to support concurrent P2P-GO and (BSS) client
today. But DFS capability on this is broken, since you're not on the
correct channel all the time, hence the check.

Therefore, I think this patch is entirely wrong, and you need to
advertise only a lowest common denominator on the global interface
combinations (where the num_different_channels is actually possible to
support on each individual radio, since no band separating is implied by
it).

johannes


