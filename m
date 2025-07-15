Return-Path: <linux-wireless+bounces-25461-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE9CB0563E
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 11:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6BDF4E6906
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 09:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3147D275118;
	Tue, 15 Jul 2025 09:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="hWYTrisG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30F22741D4
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 09:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752571397; cv=none; b=A/T7UK/veOLbv3GEUEBrGk3B8ZfBLPeRzrmkJZm0ju28eIa6TmnVk2VBQOLbkiKxV+oBxgFKKIN1zhUGdHrPc2lr8BwhO8/6sR9UPU7ddgVv35llnlhUSom3PiCvnpRn27Hu0+J1oLn6IwCagd3Y92dkeoUTOL2BpoD7dtZl3Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752571397; c=relaxed/simple;
	bh=2NcjLjmHK3Cqd7mD2lbmbevp5tyhdvyf/gTmu4FilO4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z3Ux4X/6WWemXMV9G8xubn6zZMliVT0lTGAqk6o7UXHr4TBt3+P7/5VE5RFJus/SkkE7bssF6lAwOU4kv9xQqLbc4rXWH/lZF+uehzVoXX242PAJ1Ee4pqPm8ZS0K/Q3GC0WTf4iyPfSXvlj9Xn2/tsHxb/Tf5dOHNWWtkA7lls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=hWYTrisG; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=2NcjLjmHK3Cqd7mD2lbmbevp5tyhdvyf/gTmu4FilO4=;
	t=1752571395; x=1753780995; b=hWYTrisGb03w5dW9JFVe6h+D0oj7SJ0QH/BDPHU9GKRX2Ll
	Hcy2Q8fEuNgH1k4ctalOrWH76cyMIbJw9RQRUH+cGhpXz+MgqDRuphv10cghgBpfxRv21D+v57SdR
	1eb7vAcFT971Eq33E/xFnqQ47pZ3HwL2vsHIWPUZx6OlKZQMqtDLkiyt+1HNTF5B9A+kMytr6bpA4
	Wi0cPMnA0kc6fDsxew6CZJNB4dDamLZkytOPEMwin5wjMkxP6yJHmigrkj9+LaUtbcQmRIkj7a1Cs
	CGKT5ppftAKW/s5K4G3rLBHbY4OjHA0TRYlU1+/xqtcSXHWzuu1LtHS2YD5vgBQQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ubbsP-00000005rD1-1R5R;
	Tue, 15 Jul 2025 11:23:08 +0200
Message-ID: <9b7b20568df1bd7b62f3e8604a9d9b76cb25c340.camel@sipsolutions.net>
Subject: Re: [RFC 1/5] wifi: cfg80211: support configuring an S1G short
 beaconing BSS
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Date: Tue, 15 Jul 2025 11:23:02 +0200
In-Reply-To: <885d6a2ae286e910f4911f151c7ea5b0daecca45.camel@sipsolutions.net> (sfid-20250715_111922_730161_A007D6DF)
References: <20250714051403.597090-1-lachlan.hodges@morsemicro.com>
		 <20250714051403.597090-2-lachlan.hodges@morsemicro.com>
		 <4333caeb7a98bf2d29da7a26181dc34032d5bd9b.camel@sipsolutions.net>
		 <bbxqihfwpz3w64md63opkek3z5p2vssgs2g5ha4gwerlbzqknn@wl53iztdzxfb>
		 (sfid-20250715_111247_681807_D1276E28) <885d6a2ae286e910f4911f151c7ea5b0daecca45.camel@sipsolutions.net>
	 (sfid-20250715_111922_730161_A007D6DF)
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

On Tue, 2025-07-15 at 11:18 +0200, Johannes Berg wrote:
> On Tue, 2025-07-15 at 19:12 +1000, Lachlan Hodges wrote:
> >=20
> > >=20
> > > Is that really worth it? We don't have to protect userspace from
> > > shooting it self into the foot _too_ much, just make sure that we don=
't
> > > get into a mess in the kernel itself. As long as the elements are not
> > > malformed, I'd argue we're fine from a kernel perspective?
> > >=20
> > > This also prevents future updates and experimentation, and I see litt=
le
> > > value in it?
> >=20
> > In that case, would you have any opposition to using the regular
> > validate_beacon_head and validate_ie_attr for short beacon validation?
>=20
> No, don't think so, though I didn't check now that
> validate_beacon_head() can deal with the differently sized non-element
> fields in the different formats, but I suppose it could just do that.

Maybe that came out confusing, to clarify, I have no objection assuming
it handles the different formats :)

I don't even think it would be relevant to force the short beacon to be
short and the long beacon to be long since we already have a mix of the
three beacon formats everywhere, and all the code now (since your fixes)
handles all the possible formats/permutations thereof.

johannes

