Return-Path: <linux-wireless+bounces-24280-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDABAE1688
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 10:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F348219E7505
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 08:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F70B2620EE;
	Fri, 20 Jun 2025 08:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="fc7f7DgQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3575F2571B2
	for <linux-wireless@vger.kernel.org>; Fri, 20 Jun 2025 08:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750408801; cv=none; b=aj0YVte2l2VDWhIWfiE+dT8VJv4rsEdFnWPH76GR+5Norfw/vDUiMbfXGGiaBMrWQTF9OYb89K5sAEcvapyyoTxhwOeHq09KDXeCg8Ee0aQcKGV+W80ixKbXzDy+J4v7GesoMFYSx+AeaU2RqoTTJSgFiQu7h+oVBusjIack4Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750408801; c=relaxed/simple;
	bh=ieYH9WcsktvUi9Kr/kbpFjzpjWKaEe2z81/WwrY7384=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eQpdh5xOty/xi0JRQFTdRw84TQIfRTXvkI+6f3fYzmzAblO28A8b/nu+uXSUxCdqum0o6eazPYBvqEVu25a2iWOYX1zC3QAWOzAxXx/Uocnw2N5E2Op1/huVZ5qlrKdmHNrG/gprp0zaUgMzf+OkCdAzXZ+Z7YVED1OjH4DzlwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=fc7f7DgQ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ieYH9WcsktvUi9Kr/kbpFjzpjWKaEe2z81/WwrY7384=;
	t=1750408799; x=1751618399; b=fc7f7DgQ0zw7G841sWMXr1cPegQxUIEktIYSpOSfJd48HVS
	f/R88fBPCO8HanLGlO+hWcSUK2fu28mp5HSEwmaL06ee0fnOv2jrWUI1LFY7Uqa1m5oXp+7BBq6tm
	fg8BbgBOCUZ/GrnZC5ikh1LxZ7dCWhLHVsA0B2Z9+tNXd5wr4AA69fgdyPULnQm1KiFWYqD2cUyoh
	OksbV7KGPMG/93HyCymz10gLhsGr/dV1eQA6rMoM/o05rR0n8qg5CPzQJ1EJi/IHPPdwOcZd+8S9Z
	Pc3IVjsPv4A6DKDNviJCriKpvP3PAK7n4QaQ6VHRuysp+ZJQ5cHcsjIwfBokJRLQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uSXHs-00000002aZc-0lEv;
	Fri, 20 Jun 2025 10:39:52 +0200
Message-ID: <4a1c89a13b299588bf9c94dd545eda3e30fb5491.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next] wifi: mac80211: Fix 6 GHz Band
 capabilities element advertisement in lower bands
From: Johannes Berg <johannes@sipsolutions.net>
To: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, Ramya Gnanasekar
	 <ramya.gnanasekar@oss.qualcomm.com>, Jouni Malinen <j@w1.fi>
Date: Fri, 20 Jun 2025 10:39:51 +0200
In-Reply-To: <48b3af20-dd6c-49cf-88b0-1d535bd917f7@oss.qualcomm.com>
References: <20250606104436.326654-1-rameshkumar.sundaram@oss.qualcomm.com>
	 <4ab522796b91ed3421991799d3a7831a3c0ffb53.camel@sipsolutions.net>
	 <92a6a3b6-397d-4cf3-95d6-01b50f827183@oss.qualcomm.com>
	 <6290a248adbc1208df293dc22b85fe5a33963239.camel@sipsolutions.net>
	 <ec688c7e-65b1-4ef4-a977-e6c89d2176ef@oss.qualcomm.com>
	 <f80c107d6cf596091865961f8d1371b98486a14a.camel@sipsolutions.net>
	 <48b3af20-dd6c-49cf-88b0-1d535bd917f7@oss.qualcomm.com>
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

On Thu, 2025-06-19 at 19:35 +0530, Rameshkumar Sundaram wrote:
> >=20
> > Now that I look at it again though, it says for both beacon and probe -
> > _request_ to include it when dot11HEOptionImplemented and
> > dot11HE6GOptionImplemented are (both) true... We always though, with
> > some discussions with Cisco IIRC, that we should then always include it
> > even on the other bands for probe requests etc.
> >=20
>=20
> Thanks for the detailed explanation.
>=20
> > But does that make sense for beacons? Not really?
>=20
> Feel like it doesn't. Shall i make this patch to restrict this only for=
=20
> mesh beacons ?

Not sure? I guess what I'm starting to think is that if the language is
all the same across all the frames and says to include it "when
dot11HEOptionImplemented and dot11HE6GOptionImplemented are true", but
the beacon clearly doesn't make sense - is that a bug in the spec for
the beacon, or does it mean your patch is actually correct also for the
client?

Jouni, maybe you have some spec interpretation opinion? :)

johannes

