Return-Path: <linux-wireless+bounces-1268-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D21781D54F
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Dec 2023 18:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CECEE1C20CA7
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Dec 2023 17:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB3B11718;
	Sat, 23 Dec 2023 17:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="enGO9Kkc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170ED11708
	for <linux-wireless@vger.kernel.org>; Sat, 23 Dec 2023 17:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=HruMqW4AN25WKcLoNyh5+TCCaIGY5U5hqg0dV6qeK1c=;
	t=1703352641; x=1704562241; b=enGO9Kkczt9QjgLeu6mw1joi17L0X0AavTciJLPHwtaSCUp
	g5+BcWpKb+YXNuWWj3CmQWQfC7a+3aH0Mlu+trFNRqHFWJCxhHoVVEABkptQb934w093A3WYs2BSu
	J5KIOrVj6Ux6EhPvrsHlAS/pp4BNij3x/7e7VoovxSyKpu4JZQ74ewJzQmyjD/qxSic2SrFTGyiHS
	kUEC44WaYZCw0xwTLMS7rK9/05r3bBV7VYMY656jq3fpeYypbDRazPUAEjEdNiiQejb1yHC13zts2
	J4tylY5yT35Um76Wu2PEUwfklceAS0JsqhNqcbcqVxbBFLyBG0FnYXf+DqQHJH8Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rH5pX-00000005mBB-0tMm;
	Sat, 23 Dec 2023 18:30:31 +0100
Message-ID: <578287d18de951b8211a8a0b1875f9c038b8ff90.camel@sipsolutions.net>
Subject: Re: [PATCH 15/15] wifi: mac80211_hwsim: support HE 40MHz in 2.4Ghz
 band
From: Johannes Berg <johannes@sipsolutions.net>
To: Jouni Malinen <j@w1.fi>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>, 
	linux-wireless@vger.kernel.org
Date: Sat, 23 Dec 2023 18:30:29 +0100
In-Reply-To: <ZYcEYIauIJAz0q2q@w1.fi>
References: <20231220023803.2901117-1-miriam.rachel.korenblit@intel.com>
	 <20231220043149.56bf8f5cd373.I1ba6905c806be6e0548ed15130c0bbb2ee04c9fd@changeid>
	 <19b41966397952fc18cb90346550eb3f2f03711c.camel@sipsolutions.net>
	 <ZYcEYIauIJAz0q2q@w1.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sat, 2023-12-23 at 18:01 +0200, Jouni Malinen wrote:
> On Tue, Dec 19, 2023 at 09:57:52AM +0100, Johannes Berg wrote:
> > On Wed, 2023-12-20 at 04:38 +0200, Miri Korenblit wrote:
> > > We are missing the flag that indicates that capability
> > > of 40MHz bandwidth support in HE on the LB.
> > > Add it.
>=20
> > Jouni, I had basically the same patch and I'm going to apply it...
> >=20
> > However, it breaks two tests in hostap - according to my earlier
> > analysis, this is because throughput estimation for HE/EHT doesn't take
> > the AP *operation* into account, only the *capabilities*.
>=20
> That's now fixed in hostap.git.
>=20

Thanks :)

johannes

