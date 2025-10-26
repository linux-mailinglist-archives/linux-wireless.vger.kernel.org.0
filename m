Return-Path: <linux-wireless+bounces-28278-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD849C0A610
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Oct 2025 11:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB87D18988A8
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Oct 2025 10:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4639472639;
	Sun, 26 Oct 2025 10:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="RjbNdnyN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E90E335C7;
	Sun, 26 Oct 2025 10:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761474847; cv=none; b=TaTAIQBO61PgezjpAXNH9qgbcu7G2Y5E0n4DdGWwWrCoulGcrOpxV2Bq6+2sn033UWm10iJNdttJcCVdnFCESip8fr6TJdHDFwnomNZ6Umg/d6YDUHyxZNTTO5XoGCuMimkxB2WO2mpNyoKhlDoir/+Gf/fg2Cmmo/jdrOlYTCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761474847; c=relaxed/simple;
	bh=oLGdwjgRsCmv6CFK/UwEoCQrL7bEhm/h+5cq742pIDY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GhAnUsG2zpQ6kPjY9iRLwCTU97Yqxby7DFHqCi7I0F+RYx8bitclJYoz6TRgVAzvo4uftpiGrTzWAQ+XNcvekH0c0ZY8dH0eGEA3tuF2HdHss/LY0xHOo32/G3WIeSFbln73lqgfwjI3I1XWBworsR2rx14cJCTVp0nRlwyBbkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=RjbNdnyN; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=oLGdwjgRsCmv6CFK/UwEoCQrL7bEhm/h+5cq742pIDY=;
	t=1761474845; x=1762684445; b=RjbNdnyNiyaQROnvJEgXxMyiquiXKrQSvjHX40uqBCJ0U5d
	a+q87h0/ojGQD+qJ/SOQRl7eIIghE2NPo3SlsZCDE4jIvwETFFGBOM9Np0Pgf3rgoE2lKdmk2M1MD
	lUXZAv/plK2TFSnIEOR8n5nHPlJ963RJwP0z3majCk0SgDVay/Dl1GRFFYrQkZmS8aN202+TP/lDO
	xT5bOHF/hWgUMoTapGvn/9zbE2S0lODbAw3eZH1Hr3D1BW9UIeHEEsDosZbd5ziw6h5pqad8vwiaH
	h8jAV4/Wm2NFnYNbhv9Q1htz4qZve47k/tePTHOFdwvXN7XKy6i5iqsAv7JX5JrA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vCy4Y-00000007zup-2yIo;
	Sun, 26 Oct 2025 11:34:02 +0100
Message-ID: <6e179c1004ca0fe033cc728bbced0e2ddf301f49.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: tdls: don't WARN_ON_ONCE on missing STA info
From: Johannes Berg <johannes@sipsolutions.net>
To: Nikita Aleksandrov <n.aleksandrovuk@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+e55106f8389651870be0@syzkaller.appspotmail.com
Date: Sun, 26 Oct 2025 11:34:02 +0100
In-Reply-To: <20251026102553.29195-1-N.Aleksandrovuk@gmail.com> (sfid-20251026_112820_017068_8FCE0C8E)
References: <20251026102553.29195-1-N.Aleksandrovuk@gmail.com>
	 (sfid-20251026_112820_017068_8FCE0C8E)
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

On Sun, 2025-10-26 at 10:25 +0000, Nikita Aleksandrov wrote:
> syzbot report e55106f8389651870be0 revealed a crash in tdls handling
> when the STA or AP STA info was missing.
> Fix: replace WARN_ON_ONCE with a regular error log (sdata_err) and
> return early if STA info is missing. Avoids panic_on_warn.
>=20

Wrong way to do this, we shouldn't get here that way.

johannes

