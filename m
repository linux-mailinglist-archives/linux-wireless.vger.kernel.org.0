Return-Path: <linux-wireless+bounces-27876-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CB0BC3D94
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Oct 2025 10:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9DC77352CF4
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Oct 2025 08:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE4F21767A;
	Wed,  8 Oct 2025 08:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="SCe3oqH/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BAC1E835D
	for <linux-wireless@vger.kernel.org>; Wed,  8 Oct 2025 08:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759912322; cv=none; b=c3ujowci77xOD2BAt0bqmEdi44wJDQITOChdpYk4jkdkpyBcE2m7ThMME5nzYM0ii/thDxFpimpq1vblopQIB/uvvXRdkcitHNE27SPmZl5hVtkoLOADFB9EgXLncRC5X5XQUdEIzF/7nQUTX2BvM7DxYh4cfU/RFMxo2Jou5Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759912322; c=relaxed/simple;
	bh=FKOdZinitW1TQTIrQBN68vQPeTDgd6+3Sw/3RzWLGfk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lXeA4S174CydpOi8LqwR4/pwPowFBOFNgJ8wMVwyDr7FRZlnTthtXlYw1WuKx4fpuKxRdeMZ/E+rQSfYnscoKkIBPw+mRyNHcGGrMyqUoqBSISlui0m/o2pSv1k3LE8CVj9WShldT5j03nLwmN0dy0LS8sBK7/TK1UyO3bVmXeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=SCe3oqH/; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=FKOdZinitW1TQTIrQBN68vQPeTDgd6+3Sw/3RzWLGfk=;
	t=1759912321; x=1761121921; b=SCe3oqH/swBwQg8vC6LMOARrAX3BdqJRM7Mae9wNXmBophW
	mH7vmmtJN/1AfJCBdXgTp71pK0F17tDt3pYnGAd1Ebamf5UIxxXzb7GORgqPMjjX3JS3DlFenQGCh
	fs+6NxWWJXPo9KlG4b2WCdQaPy33hwb/940yJb0IVPUJ40b0WGKTCOo4O7YkPvB+9wpEwGYH/2DqD
	o8QwJdAswcuwoVC4uXBWYLUhtjVQUjQWAYURZlTNYNAsTItvDcUrwB+pNnYcBu/z1SXuoJJPsKKqi
	SkbNU3CV/I6Fz2tg9OjqaivTnj419ZhZGwSmGwotGvd/6Z/GS1O3NkkkEgMW+mYg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1v6PaY-00000000DB1-2g9L;
	Wed, 08 Oct 2025 10:31:58 +0200
Message-ID: <dc4c1e040b7d5e9951dccd2d68ed541fe737daeb.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next] wifi: mac80211_hwsim: update S1G channel
 list
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Date: Wed, 08 Oct 2025 10:31:57 +0200
In-Reply-To: <c66wv25xain2iqudsz2xirzb444pfbaaeumkbv6gnaqddqgt2h@hvtkge7zjadi> (sfid-20251008_044005_045010_53BA81AB)
References: <20251008013903.219169-1-lachlan.hodges@morsemicro.com>
	 <c66wv25xain2iqudsz2xirzb444pfbaaeumkbv6gnaqddqgt2h@hvtkge7zjadi>
	 (sfid-20251008_044005_045010_53BA81AB)
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

On Wed, 2025-10-08 at 13:39 +1100, Lachlan Hodges wrote:
> Also unrelated and im sure you're aware but it seems like the patchworks
> bot is broken or patchwork isnt reporting the bot result?

Oops. I wasn't aware, hadn't been paying much attention to patchwork
during the merge window. But yes, there had been a lab shutdown on the
25th and it didn't (couldn't, really) come back up automatically. Fixed
now, should be running, but will of course take a while.

johannes

