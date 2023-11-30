Return-Path: <linux-wireless+bounces-246-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 682BC7FFA0E
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 19:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF502B20E7D
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 18:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09C454FB4;
	Thu, 30 Nov 2023 18:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ri5MnTIy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25988194
	for <linux-wireless@vger.kernel.org>; Thu, 30 Nov 2023 10:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=AWW3+CM6ik8ct0WgTHPe92vPRix8fk2yUkpq6s6NPmE=;
	t=1701370354; x=1702579954; b=ri5MnTIycccPpBKLZfJAaaGwRy0sXvRPPQtz5qmcjciMUue
	c6MXBscMaF5imv0vgQmf0Vh9WD8tOWHKc0prDicYRCv/ZKc5Imf17PzrtmUjgh/rjWlaAhPok8L1r
	MVqZQloU7yUdY93lfFwON4ntx58zBDsfDxyULzurNNVvnLYmZTsxaNJkxasbrVT9G77T6VqK4PIJj
	Astp+kfcUzcixDuDNIm6lphHm1XIRNEoFWjao/Nj4jzekn+cmmTMN3fN9/ahqdpWzCFrZVds6pGt+
	rIbAaKhsAaaHatng6+m4rAkxz+cbomQMZKePwKEVVQJ9u2hHUoIrhJgB3FkJKrVA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r8m9D-0000000A9Km-3gAp;
	Thu, 30 Nov 2023 19:52:28 +0100
Message-ID: <678c2ed84d94b2f87bdeaf165bd769996a395e7c.camel@sipsolutions.net>
Subject: Re: [RFC PATCH] wifi: cfg80211: fix CQM for non-range use
From: Johannes Berg <johannes@sipsolutions.net>
To: Kees Cook <keescook@chromium.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, Michael Walle
 <mwalle@kernel.org>,  lkp@intel.com, oe-kbuild-all@lists.linux.dev,
 linux-wireless@vger.kernel.org,  Max Schulze <max.schulze@online.de>
Date: Thu, 30 Nov 2023 19:52:26 +0100
In-Reply-To: <202311301045.6DA830F7@keescook>
References: <202311090752.hWcJWAHL-lkp@intel.com>
	 <202311090752.hWcJWAHL-lkp@intel.com>
	 <1c37d99f722f891a50c540853e54d4e36bdf0157.camel@sipsolutions.net>
	 <fc1dbe4a-a810-445c-9398-60a5e55990a2@quicinc.com>
	 <202311301016.84D0010@keescook>
	 <01e3663e9e1418a183ee86251e0352256494ee28.camel@sipsolutions.net>
	 <202311301045.6DA830F7@keescook>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2023-11-30 at 10:46 -0800, Kees Cook wrote:
> >=20
> > > Does this warning go away if "len" is made unsigned?
> >=20
> > Thing is, neither Kalle nor I can even reproduce the warning locally, s=
o
> > it's a bit hard to check ... not even with their config and gcc 12.2.0
> > (nix, rather than debian though.)
>=20
> Ah! Hmm. Let me see if I can coax out the warning locally...
>=20
Actually, I see it now with wireless-next + that patch ... I had put it
into wireless, not wireless-next :)

johannes

