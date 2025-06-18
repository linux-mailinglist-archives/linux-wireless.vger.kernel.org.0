Return-Path: <linux-wireless+bounces-24246-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C3CADEA4C
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 13:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B17E1680A8
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 11:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904DD27817A;
	Wed, 18 Jun 2025 11:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="NECMS1Nf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F981E98FB
	for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 11:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750246542; cv=none; b=AMZC14/uWTftfZ6H+9rBMjrjPbGTlU7ZT+Eh23BhmEW9NJePBVAYE6yVBQZ3JIrXFp5hSd6h/UHj1qkuWsfWF9EzAuYqPHuonMZ9SmbVIJ+SLpzP6z03KVeS+jvwdgvmFRSVTNNPKFvtt4rJiZdjGVzwA6A661/WvgEEGZQQ6tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750246542; c=relaxed/simple;
	bh=xPtH1kK+LehwLSb+Eh6IARPwK3NWlPMB3Sq6dqx61u0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tiWcaTRphlyOGyb/NxH1YXlpBtpndJzP3r281osEEd/CnQY0bbjNnuZdvTGUeydG84IifvU0qbwjY3ia1GS/kXxMYA7OXu3o1/6MnED5LIrvewk5+dc+pYX/if9r6G/r4Hhr3aopMhici7I0mYS6aVQpGnq2cB/VcHB3nm3rvVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=NECMS1Nf; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=xPtH1kK+LehwLSb+Eh6IARPwK3NWlPMB3Sq6dqx61u0=;
	t=1750246540; x=1751456140; b=NECMS1NffakXJGX4lQ7wlcZYv8vA6hXebSfVcVVZFGYV6xz
	YByIbb6mH7F0SuT7sZqqJL7xQ7RBVgiNXFmdJLVnrQHdftlai69da5yE4ARr9ijwA7TbOf9DJy91H
	UyTFqa5G1NimGCi1hyAYZeyWWuWtRC7V1o9C81ddhlMERfB80pGHBoCTUyhCEHz9XcZuBOOCVYGiD
	DUItsljXEego79WCR7gZ2KHYzQH/zCcG8mlfVWPDpOz/gegGHwX/wM6m/1mssYrmtn6aWdfNUv7D8
	PVVJ1pQnzWPX551N5XMeTw9HdWEt3oL3zrrqmpxBLs6s27JQHrm3k0nEKS3dl49w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uRr4l-0000000GGIq-3T00;
	Wed, 18 Jun 2025 13:35:32 +0200
Message-ID: <f80c107d6cf596091865961f8d1371b98486a14a.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next] wifi: mac80211: Fix 6 GHz Band
 capabilities element advertisement in lower bands
From: Johannes Berg <johannes@sipsolutions.net>
To: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, Ramya Gnanasekar
	 <ramya.gnanasekar@oss.qualcomm.com>
Date: Wed, 18 Jun 2025 13:35:31 +0200
In-Reply-To: <ec688c7e-65b1-4ef4-a977-e6c89d2176ef@oss.qualcomm.com>
References: <20250606104436.326654-1-rameshkumar.sundaram@oss.qualcomm.com>
	 <4ab522796b91ed3421991799d3a7831a3c0ffb53.camel@sipsolutions.net>
	 <92a6a3b6-397d-4cf3-95d6-01b50f827183@oss.qualcomm.com>
	 <6290a248adbc1208df293dc22b85fe5a33963239.camel@sipsolutions.net>
	 <ec688c7e-65b1-4ef4-a977-e6c89d2176ef@oss.qualcomm.com>
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

On Wed, 2025-06-18 at 16:55 +0530, Rameshkumar Sundaram wrote:
> > I think it might make more sense for _mesh_ to do this, and honestly
> > mesh probably doesn't have much 6 GHz language in the spec anyway? I
> > didn't check now.
>=20
> Guess mesh is defined for 6 GHz as well,
>=20
> 26.17.2 HE BSS operation in the 6 GHz band
> A mesh STA with dot11HE6GOptionImplemented equal to true and operating=
=20
> in the 6 GHz band is a 6 GHz mesh STA.

OK fair :)

> > I don't see why multi-radio would behave differently, sure, something
> > else could be occupying the 6 GHz band but that's also true for a "non-
> > multi-radio design", after all that doesn't mean it doesn't have
> > multiple radios, it just manages them differently.
> >=20
>=20
> That makes sense, thanks for the explanation, but is there a reason we=
=20
> should include the 6 GHz band capabilities element even-though the link=
=20
> STA/ mesh BSS that is going to send the beacon/assoc req frames is=20
> operating in a lower band (say 5GHz) ?

It's probably not useful in a *beacon*, I guess?

> Does this help in discovery of any out of band capabilities ? Just=20
> trying to understand how this is useful.
>=20
> With current implementation, an ML STA negotiating 5 GHz and 6 GHz links=
=20
> with an ML AP would send HE 6 GHz Band capabilities element in both the=
=20
> links as part of association request.

There was, afaik, some discussion here in the spec asking explicitly to
have it included if the STA is 6 GHz capable, but don't ask me why.

Now that I look at it again though, it says for both beacon and probe -
_request_ to include it when dot11HEOptionImplemented and
dot11HE6GOptionImplemented are (both) true... We always though, with
some discussions with Cisco IIRC, that we should then always include it
even on the other bands for probe requests etc.

But does that make sense for beacons? Not really?

johannes

