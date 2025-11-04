Return-Path: <linux-wireless+bounces-28521-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9701CC302F0
	for <lists+linux-wireless@lfdr.de>; Tue, 04 Nov 2025 10:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B940C1886145
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Nov 2025 09:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783411A238F;
	Tue,  4 Nov 2025 09:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="despgmRI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B409F2641FB
	for <linux-wireless@vger.kernel.org>; Tue,  4 Nov 2025 09:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762247292; cv=none; b=Zwo3ErD8zo9S92YUti7RgF7TE4XPxNP4Utc1Et771eCNC1simor4+8V/az91HLM47+WkiojBKU5rGTc/1wriXfpMUED2Y27U3IO7o3zOkjeRmxfzmNJ0ZTqqeZnBr3z8iDSLjHUid4Y+AQrQWnYuMk1Mg3h35+BSJXrGysWO0nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762247292; c=relaxed/simple;
	bh=jcmj1ad5I4D/kj14XrweKnnah+lJCVE2agnPwSIA318=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=atRKJKUXK/63bWc+nQqZHAWHFfMEZpKa38sKIpABgEevmU8bBLZlYRI+T7sQ0NifeWr2I0jSEfc5j8JhXNLCEqOvjfy/DlxiwLKPn1TJSWpzgumsp6W+y0moUfCdKCWSc+0RBsK4geLb93B9G1Lqiohu31Iv6T7tCB5NFeZu9Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=despgmRI; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=jcmj1ad5I4D/kj14XrweKnnah+lJCVE2agnPwSIA318=;
	t=1762247290; x=1763456890; b=despgmRI90koANHN64Hz+qorS7Qz2d4kNL3fQasYQmqSCtd
	URnrFxFWCLFZQVChx6EOvxZSYoCdZJ1DGmrCFn+83pktnLdEsOixDBW/Lnoo+d2HXm67fu4vg7Hhy
	PjqQeoSn7ZNxr64A/4D5+ApL4vc2sqiv6oAQfWYaO+tiQzrnhW81sbTcO7L6KIYMFh+l1PemSdMDS
	34K2+M/m6Bsj2w3s0At749UH//kEjk5yuydZ7I0zl0u1XpfLZvHSwfvm1R/J68ZJy32zzo1cLHAES
	1xI6KPoJ09vkg/3KPEzJYvxW36xepflKpxBi46C89pfFhPKnMyUGjo9ZH6BYnFiA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vGD1G-0000000Bb2d-2BSK;
	Tue, 04 Nov 2025 10:08:02 +0100
Message-ID: <dc5017d0e4eed59905597f000a11887e9e264eb9.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 00/57] wifi: inffmac: introducing a driver
 for Infineon's new generation chipsets
From: Johannes Berg <johannes@sipsolutions.net>
To: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
Cc: linux-wireless@vger.kernel.org, wlan-kernel-dev-list@infineon.com, 
 Carter Chen <Carter.Chen@infineon.com>, Owen Huang
 <Owen.Huang@infineon.com>, Ian Lin <Ian.Lin@infineon.com>,  JasonHuang
 <Jason.Huang2@infineon.com>, Shelley Yang <Shelley.Yang@infineon.com>,
 avishad verma	 <avishad.verma@infineon.com>
Date: Tue, 04 Nov 2025 10:08:01 +0100
In-Reply-To: <3cb0e7a95fdba1ee1003c10606fd58e7b9071c58.camel@sipsolutions.net>
References: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
		 <4d46dfb13927a878f5684e9e8cfc51673e8df4b8.camel@sipsolutions.net>
		 <aMqm-soAc5tzHQFf@ISCN5CG14747PP.infineon.com>
	 <3cb0e7a95fdba1ee1003c10606fd58e7b9071c58.camel@sipsolutions.net>
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

On Wed, 2025-09-17 at 14:23 +0200, Johannes Berg wrote:
>=20
> It'd be much easier to start with a reduced driver that doesn't have
> everything, in particular not things that aren't already common and thus
> need more careful review, perhaps even from experts outside of wifi,
> such as the sensing part, XDP, offloads, and probably more.

Actually, it'd be even easier if you just added the necessary features
to brcmfmac, since >50% of this driver is a straight-up copy of that
anyway.

(I estimated 50% by a trivial rename and ignoring whitespace, which
doesn't take into account further cleanups you've done such as
firmware.c's renaming of the parser states.

johannes

