Return-Path: <linux-wireless+bounces-5316-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 586B188D871
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 09:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 104191F2A861
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 08:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AED92E644;
	Wed, 27 Mar 2024 08:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="lJ+u4/oY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718DD2E63B
	for <linux-wireless@vger.kernel.org>; Wed, 27 Mar 2024 08:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711526996; cv=none; b=rYgkzwRaxoBcpfYPzT/6Dxzhtv39ivyMRpTIW5TCTwwKocxvihxqaaOK3TxqriR3Tg7RA9ZOa9kYAx1+C8wZn+J6sltg8eyEEzcCblZA26mDMY5QhvgxlCLR6HjTK75Y6bEgNwbEafdJNUBDfKvFmIXE186BXVzR12okvYgrcoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711526996; c=relaxed/simple;
	bh=zLSXPOy5UiOe/fq6oA7+rIU//D/A7SSVNZativHCEBo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pa5bTXMXRnS2XkZvjEugiW7HDOTwmJJa2AKtr+33LaLKuZm9EZ57zGJ4nQ2ehFHQpXiH95631g86g8Eh4KgoY/bqcHC0IS4BDF2tYBn3rwqYXzG4QKlm8XtXptKqVfDGdxSjTSdMuKyQ2A2N1vSw84dv2KcwHd+LstRlJmrMH8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=lJ+u4/oY; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zLSXPOy5UiOe/fq6oA7+rIU//D/A7SSVNZativHCEBo=;
	t=1711526993; x=1712736593; b=lJ+u4/oYEFm+9km2gEjcfsuUPsRIrKSx149/ccnTjgOvBsb
	SLpYhdLPAb1spHG6RpFJVfyCm+pc50cLLInDcfHejEuBaGDq7lViboa0HFmjOnO5xqQw4zXOwW7Xx
	sW0PCsWhQ3UbKFvq2f/qlIKDnOdswNGZRJ9/wnijCfHLRZp/ENX/md5XI/W0ihcM9BG5KKk3+IeTH
	naUtqjnidLdhuRAI15ZsTxFw5N5QiqidYmc46Qs4Bh9VFMwEGxnimXCq08631XOpkCkubUfPsy5F3
	/gCN/k8oj/67n3y6ic6hkqWOvdjhx8f9CLXhFg5HTDTx14R+K4le63GanDfitCdQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rpOM2-0000000GvR4-2pCe;
	Wed, 27 Mar 2024 09:09:50 +0100
Message-ID: <e729ac7c7bf91a512679ae6406f7cb9ef548b6fb.camel@sipsolutions.net>
Subject: Re: [PATCH 04/15] wifi: mac80211: simplify non-chanctx drivers
From: Johannes Berg <johannes@sipsolutions.net>
To: Ben Greear <greearb@candelatech.com>, linux-wireless@vger.kernel.org
Date: Wed, 27 Mar 2024 09:09:49 +0100
In-Reply-To: <7dd7ef40-ea25-4c38-a3c4-42262f5d09a9@candelatech.com>
References: <20240129184108.49639-17-johannes@sipsolutions.net>
	 <20240129194108.6d0ead50f5cf.I60d093b2fc81ca1853925a4d0ac3a2337d5baa5b@changeid>
	 <7dd7ef40-ea25-4c38-a3c4-42262f5d09a9@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

> Any reason mtk7915 was skipped in this patch?

Huh. Not that I remember! That ... means the driver is entirely non-
functional right now? Ouch.

> I'll test duplicating what was done for 7996, but wanted to make
> sure I'm not missing bigger problems.

Should of course just add the ieee80211_emulate_*_chanctx calls to it,
unless it should be using its own chanctx implementation now.

(I am always surprised to see a relatively modern driver not using its
own chanctx implementation, but that's part of the reason I did that
change in the first place.)

johannes

