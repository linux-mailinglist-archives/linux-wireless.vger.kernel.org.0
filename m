Return-Path: <linux-wireless+bounces-13017-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A49797C7DE
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 12:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD10D1C23BF7
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 10:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157C9168BD;
	Thu, 19 Sep 2024 10:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="RefKkpwC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B29A33D8
	for <linux-wireless@vger.kernel.org>; Thu, 19 Sep 2024 10:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726741335; cv=none; b=ocgi8g/yXfh66+svPiU0vCypFgbognR/tWzmfzWGaXefqXnrUtzw2eFQHALLQuttzn13eCsPupony77/saM7KZ2c0DfhweLve7Srvruv5ArGE8sJrvQYUxBIFE8cdqII5J1S30tmSzVZC7/pPvh4wacQKQcZyw+J/kUG8mVNhLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726741335; c=relaxed/simple;
	bh=9dvtS0sx+I9r5PYxctr8A5lLqtzdjKgsQ8ix4ubX0yo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ESU/WcXxwskgepUPHO7ZyWDfboQccBKsv6wEeQLptuBxlDlhIx4GcDJHkN1SB03wKTWCoBCK+JPwRgwtkNpZnUlxXH1iRGLBmDRGdNITvlmgjxszfo++rb219fVfrsEFpjAsPK2rF25ZLus1P2uSi1Nky6CCQqusOyHKEsHTlmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=RefKkpwC; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=9dvtS0sx+I9r5PYxctr8A5lLqtzdjKgsQ8ix4ubX0yo=;
	t=1726741333; x=1727950933; b=RefKkpwCD9Fx3SZm9vly3xJMifK6wddTQHn/snwYiECEHx+
	u3jQL/AhB/HTouhVepMQxQ6TBn+r81/fhiYGlbkVi3eUnvNI3Cxgt15Myytd42MzzEAZOqf0uW5J7
	uuRta5w9e2hfwbHb7q94JvXOkI/HvXEyy/L5khAOThN7PM1G+96yFbyCN9zGUcUuLAMypcFF1/tOn
	9NoXjYcLPCUVUvB8BV/O0hRa0DWL0TREZsxOvyZAoHRnE2qRDAqzUd97NaOiQJFwvlEKyCJTuljos
	kIv1Zwi6AGx1kbYinYZxosEDxIc4HZVdb3vRQURNvgoLNySxaThid6wDumKCTl+A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1srEId-00000003pIE-08F7;
	Thu, 19 Sep 2024 12:22:11 +0200
Message-ID: <c48876507ec971c9195e468e6037cc251dcf2218.camel@sipsolutions.net>
Subject: Re: Missing wiphy lock in ieee80211_color_collision_detection_work
From: Johannes Berg <johannes@sipsolutions.net>
To: Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>, Nicolas
 Escande <nescande@freebox.fr>, linux-wireless@vger.kernel.org
Date: Thu, 19 Sep 2024 12:22:10 +0200
In-Reply-To: <b9d5550c-8ac1-41d7-9abb-caa11f484064@green-communications.fr>
References: <D4A40Q44OAY2.W3SIF6UEPBUN@freebox.fr>
	 <b9d5550c-8ac1-41d7-9abb-caa11f484064@green-communications.fr>
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

On Thu, 2024-09-19 at 12:02 +0200, Nicolas Cavallari wrote:
>=20
> > Did I miss something ? Which one should we do ? I'm not sure of all the
> > implications of switching to the wiphy work queue and why it did not ge=
t
> > converted like the color_change_finalize_work stuff ?
>=20
> ieee80211_color_collision_detection_work() used to lock the wdev mutex, n=
ow it=20
> does not hold anything since 076fc8775da("wifi: cfg80211: remove wdev mut=
ex")
>=20
> Also the rate limiting uses delayed_work_pending(), There is no wiphy wor=
k queue=20
> equivalent AFAIK, so the explicit lock is probably the way to go.

That won't work, it's cancel_delayed_work_sync() under the wiphy mutex,
so that'll cause deadlocks (and should cause lockdep complaints about
them.)

johannes

