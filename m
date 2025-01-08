Return-Path: <linux-wireless+bounces-17188-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7EEA05692
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 10:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A520318883B2
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 09:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6391EB9ED;
	Wed,  8 Jan 2025 09:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="So8URSuk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827BF1F37B1;
	Wed,  8 Jan 2025 09:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736327891; cv=none; b=pZ7c2xVsCb1rIDMrzfKGoBxRFd88gBknVRSghQVTDKu6MP6ImPaK9nFvxlnl1GyeEVwWmYM0qYu69MwfMyt6Kzb70tbBppj8B44hxqyMdJah/HzmlIesYHssMmHPpqW2i8/3mOrYI857ezcusHYckXAGgG/p1jx/W3ZHH5EUrWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736327891; c=relaxed/simple;
	bh=VFnXYasQzmstDMkPgIW9fxpjCN+xG2BSxv+tlcrcKqw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lwMGYj7SK3A8mScBoFuO5VFrzBkzlLfLl5pE/z2yRKGlVJb8jtQJVFBipUDAgXPClO9E6DkU9s4IB5sdL7aAcKe0VuN1K470l7WvnD9Qv8HlIpXek0e5mmJDoUmVXL0U1w+W7yu6Zgwtuj/Mr50OtKt+R26rExHd7C4qdCSq904=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=So8URSuk; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=F/B6giuYYmo56/PqZF8Wm/OoFgz7fHFXjQpFL/Nwp9E=;
	t=1736327889; x=1737537489; b=So8URSukrGfu+wSVy4F8ZX7XMl0sGYjBthx/0vsABTWkKqd
	EoKP9Uxi59sZCwf5s5AVkoQJb8UzfbJvPgzjuCD3sNl86xHC9HVnS8ZxZXkFDMim2JMf7tMcV2dnc
	Srcyle9g7hDpE2bkZgQqwNcVrTIewFLiKUUqpFpsbcP9++nfW+ejuX58ouF3PnsszEg4S3LH8aU7J
	vxds+BC6HmbFT32OJKp0Amu44omWFvTdEEpaBXZwGnK7r6oX9LNjlDcdU5ijLCdoYIB+8piOx6YNQ
	rEvUDVw2Rgzy/+eK7VIagbEVJ1Epa2GKzdTXiQVz6482Eu9PMwKQ0bmH924oN5fQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1tVSCM-00000008AbL-3841;
	Wed, 08 Jan 2025 10:17:58 +0100
Message-ID: <7d4cd2e755c830803ee8040aafabd7c0632ae335.camel@sipsolutions.net>
Subject: Re: [PATCH 17/19] wifi: mac80211: also verify requirements in
 EXT_SUPP_RATES
From: Benjamin Berg <benjamin@sipsolutions.net>
To: kernel test robot <oliver.sang@intel.com>, Miri Korenblit
	 <miriam.rachel.korenblit@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, Johannes Berg
 <johannes.berg@intel.com>, 	linux-wireless@vger.kernel.org,
 johannes@sipsolutions.net
Date: Wed, 08 Jan 2025 10:17:55 +0100
In-Reply-To: <202501081559.1c188f65-lkp@intel.com>
References: <202501081559.1c188f65-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

On Wed, 2025-01-08 at 15:55 +0800, kernel test robot wrote:
> Kernel test robot noticed "hwsim.owe_assoc_reject.fail" on:
>=20
> commit: 1539283361bfb9c62eb3486ded2c4d38e5858510 ("[PATCH 17/19]
> wifi: mac80211: also verify requirements in EXT_SUPP_RATES")
> url:
> https://github.com/intel-lab-lkp/linux/commits/Miri-Korenblit/wifi-mac802=
11-add-some-support-for-RX-OMI-power-saving/20250101-131018
> base:
> https://git.kernel.org/cgit/linux/kernel/git/wireless/wireless-next.git
> =C2=A0main
> patch link:
> https://lore.kernel.org/all/20250101070249.f1840f19afa7.I12e3a0e634ce7014=
f5067256d9a6215fec6bf165@changeid/
> patch subject: [PATCH 17/19] wifi: mac80211: also verify requirements
> in EXT_SUPP_RATES
>=20
> in testcase: hwsim
> version: hwsim-x86_64-4ea2c336d-1_20241103
> with following parameters:
>=20
> 	test: owe_assoc_reject

These failures happen because mac80211 has become more strict and the
hostap, including the hwsim tests, needs to be updated. The patchset to
update hostap is:
  https://patchwork.ozlabs.org/project/hostap/list/?series=3D439300

Benjamin

