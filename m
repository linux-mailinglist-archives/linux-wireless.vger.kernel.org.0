Return-Path: <linux-wireless+bounces-23421-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC407AC3D6F
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 11:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF03E3B9541
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 09:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028421EFFB2;
	Mon, 26 May 2025 09:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="JLgVGVib"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7222C1F2C58;
	Mon, 26 May 2025 09:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748253381; cv=none; b=WMtLoyOfmWzsLyo+C9Yu0ZSenal2EkFj9TLLmMVrZy4E8kxipJNXvN33JN9tgo+YX5EFiAF3/3LMvVTo1lkk44efW9BY+1yBP/4tnU6wYrSdBonX0genblPcCMykxI1SfhOLEbkWupRMg0dWHZM4tIwCSNhqoC8um0kxYQ61waE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748253381; c=relaxed/simple;
	bh=fzYsk7ko2OmJIPwDuUnKvOTy+wKYHxqbvnzr2gbifqk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ATFAKcZFoUNR4eQs65C6MOl8YDgqXjeSAWiVdFmuDr9x5EIGL92kAnkfD93TggbnWEGve9kLU0rapadIlD1QGwzClO5/EABO3MQHDUQC5uvReFMs4ZmWGM2jHusYQs8wsP3GjWDFucT1nh/YzbmRq14KP7e9vDHsIsSWzf4y8RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=JLgVGVib; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=fzYsk7ko2OmJIPwDuUnKvOTy+wKYHxqbvnzr2gbifqk=;
	t=1748253380; x=1749462980; b=JLgVGVibH1At3CbNaQuOG47IJUVEX5LozLoZ6WbAaqqhR1v
	i6A1um95Z+DOZdHCYEL7MzJipj6METmKs/c6a3bYTUu2O6XTRwUBZAMIku1TNLztyCASCneu0bKG6
	S63MTBoa55fMV0bMEA445/cFmCPwOKGS+gO0kNXJade7xwtcpdkEc6SSWpHAAATJ7rXc3O4aM7u2M
	9amfQS7NwefrNyrD+cdNAehtg0U8NDh5dBk+1kmSE3W9fpAJ7f6qsrXRQUQE/yhW39cGdwCbGWzQm
	OhnSf/ZN9aLuXqu1bj6Ht5xpQxzpDMy6Esd3+UX6kFiuMbsHMRTWZHY3+8HfIRqA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uJUZ7-0000000Dg0x-0Il1;
	Mon, 26 May 2025 11:56:17 +0200
Message-ID: <293fe5ea564a98113443bbe93e6022c5bb6dd747.camel@sipsolutions.net>
Subject: Re: [PATCH v2] mac80211: Add null pointer check for
 ieee80211_link_get_chanctx()
From: Johannes Berg <johannes@sipsolutions.net>
To: Greg KH <greg@kroah.com>, Wentao Liang <vulab@iscas.ac.cn>
Cc: luciano.coelho@intel.com, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 26 May 2025 11:56:16 +0200
In-Reply-To: <2137c5905fc87e80698e6578ebf360be6d899f6f.camel@sipsolutions.net>
References: <20250526091903.587-1-vulab@iscas.ac.cn>
		 <2025052614-spring-ether-8d09@gregkh>
	 <2137c5905fc87e80698e6578ebf360be6d899f6f.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2025-05-26 at 11:50 +0200, Johannes Berg wrote:
>=20
> I still very much disagree with you and _will_ keep adding warnings to
> the wireless stack. This would be one of those places where it's totally
> warranted, because it's actually impossible that this happens, for it to
> something else would have to be changed to go wrong in how this is
> called, for example.

And come to think of it, cases like this are exactly why some people
decide to crash the system on warnings. It's things that the developers
thought were impossible, but should be double-checked. If we stop
putting warnings on such places, then the decision to crash on warnings
becomes entirely meaningless. So seems to me that just lashing out
against warnings all the time is actually detrimental to the intent of
such configurations?

johannes

