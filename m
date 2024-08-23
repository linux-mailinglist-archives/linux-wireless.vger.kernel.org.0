Return-Path: <linux-wireless+bounces-11839-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7D295CA66
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 12:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 614211C208DE
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 10:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D694B13AD33;
	Fri, 23 Aug 2024 10:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Asa1fkcW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C7B1BF3A
	for <linux-wireless@vger.kernel.org>; Fri, 23 Aug 2024 10:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724408593; cv=none; b=kCIRVRVZ0PQq9YXG8skFR1xRW9BomO5k8h4PU9qhaW/W9lEMnV9EsQ6tRXd0BiNFOaPDVZkvLeABPNBYkGLDhSTjhpfhsMBaYcDOuND6sZeG78Gq9fxqH7RPILxb1Bcnng/HVet7n8kMKSmUh9POtzfvp6knmrSpnDxbNTm6sGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724408593; c=relaxed/simple;
	bh=f4MjtjvEhGCUyo8ESi6T92hwqfNNqlILhz/G67Uoy5I=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d6KXbUMUnoSJccQxktf/k8KmR+i0sm3+i9TKLw9SLP0qtjxi6Vhm54x/zZxs+l9668OV3OWq44bw6qFgH6XEh0cvDi0TToSMclqhn78yRmnYADpcTlohLFyo+dbtgMG9dDqr8pQcGmHX2A7ziWzxpglJ3wVvlx1nEGO9FTgvyyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Asa1fkcW; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=f4MjtjvEhGCUyo8ESi6T92hwqfNNqlILhz/G67Uoy5I=;
	t=1724408592; x=1725618192; b=Asa1fkcWCdr8zqYd4Vo04ahuNpaO4tsNqOnKXdCwpNtNXz8
	a6smXjTW04/twAtCBKWlmXHlseoYTw3dKxAD9HTecTSEYVDqfm01cYb3xGOLP0kKJ4mx3Qi3Yc3H4
	9GnQpvmOHnyzWXjC5hc/JWBziSvR7bcVSsKET2BO2wI1Ny65EM5m4dNcl8fbPRxc3+K7dTv8whdc/
	luZRqxbdfOvpam7qmDeBDK5flret6sRqiS8Ii2M6fgYbKJLgbOzVJwahCa451/hw973hV+C2VmiTn
	JfkIPo+kr8WYXN3duc0Pz4xIsBXVRJ0Ud4PjyfG4r3dRq7vsVDG29LXbqXrtr6mw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1shRRl-0000000FQuf-3mvr;
	Fri, 23 Aug 2024 12:23:10 +0200
Message-ID: <01d7528bc15ee682fbe2f200bdbf39066b39309a.camel@sipsolutions.net>
Subject: Re: [RFC 6/6] wifi: mac80211: check vif radio_mask for monitor mode
 rx
From: Johannes Berg <johannes@sipsolutions.net>
To: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Date: Fri, 23 Aug 2024 12:23:08 +0200
In-Reply-To: <7d713206957ec56dc297d5645203b45341578588.1722885720.git-series.nbd@nbd.name>
References: 
	<cover.c32cfe64c671566c111b1b7ea426dbd1e8f2c568.1722885720.git-series.nbd@nbd.name>
	 <7d713206957ec56dc297d5645203b45341578588.1722885720.git-series.nbd@nbd.name>
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

On Mon, 2024-08-05 at 21:23 +0200, Felix Fietkau wrote:
> When restricting a monitor vif to only operate on a specific set of radio=
s,
> filter out rx packets belonging to other radios. This only works if drive=
rs
> fill in radio_valid and radio_idx in the rx status.

Why does the driver need to provide the radio, it already provides the
frequency?

But then I wonder if this doesn't go a step too far? This is pretty much
pretending that monitor only exists on a specific sub-radio, but ...
what for? Even userspace could filter on the frequency.

I mean ... I get that you're trying to preserve a notion that you had
that an interface exists on a given PHY and they're all separate, but
they're not really separate any more, get used to it?

johannes


