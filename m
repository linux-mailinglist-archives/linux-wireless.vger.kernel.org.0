Return-Path: <linux-wireless+bounces-244-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFFA7FF99B
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 19:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7708A2817A0
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 18:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EEB584C7;
	Thu, 30 Nov 2023 18:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Hr8Je81+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40E294
	for <linux-wireless@vger.kernel.org>; Thu, 30 Nov 2023 10:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=JIIOZmzbvRgOV037OdUMNcPz2Lwt8bdjP3w0tVKnv1o=;
	t=1701369637; x=1702579237; b=Hr8Je81+vsBX5Rt+dVhCwYYcyC19PZqIehAVeO0hY6mRMbC
	Q/gilhRY/M9PmqFGR5Lzr8sWwgp6/c80MZhirkJ5PVvhBvpyktV1KyyXSEQ/oHCbyRuQvGNlPhjOc
	NCfMNa4r1KIal8YA7oPj/IsUdvjHRZTBMXZU8kc9vF8iJtkKYljD++/hwh2nWPw5cDnJT5MEviaGu
	hrRCFRejYTSo8d2ltUyNNrD7XPMOLxKHje9ybJyM2dgqiavBED3HMfdYVD7VktZGg99CvzpZjXWo0
	lVMaUo9j4jdtxQ5N+yUcAZ/KHED7ZBhMIKtNokCTB3CKjTqNyyKqN+/nOGLpXYpA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r8lxc-0000000A925-01DY;
	Thu, 30 Nov 2023 19:40:28 +0100
Message-ID: <01e3663e9e1418a183ee86251e0352256494ee28.camel@sipsolutions.net>
Subject: Re: [RFC PATCH] wifi: cfg80211: fix CQM for non-range use
From: Johannes Berg <johannes@sipsolutions.net>
To: Kees Cook <keescook@chromium.org>, Jeff Johnson
 <quic_jjohnson@quicinc.com>
Cc: Michael Walle <mwalle@kernel.org>, lkp@intel.com, 
	oe-kbuild-all@lists.linux.dev, linux-wireless@vger.kernel.org, Max Schulze
	 <max.schulze@online.de>
Date: Thu, 30 Nov 2023 19:40:26 +0100
In-Reply-To: <202311301016.84D0010@keescook>
References: <202311090752.hWcJWAHL-lkp@intel.com>
	 <202311090752.hWcJWAHL-lkp@intel.com>
	 <1c37d99f722f891a50c540853e54d4e36bdf0157.camel@sipsolutions.net>
	 <fc1dbe4a-a810-445c-9398-60a5e55990a2@quicinc.com>
	 <202311301016.84D0010@keescook>
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

On Thu, 2023-11-30 at 10:32 -0800, Kees Cook wrote:
> Yeah, I would expect this to mean that there is a code path that
> GCC found where the value could overflow. It does this when a variable
> "value range" gets bounded (e.g. an int isn't the full -INT_MAX to INT_MA=
X
> range).And flex_array_size() was designed to saturate at SIZE_MIX rather
> than wrapping around to an unexpected small value, so these are playing
> together it seems.
>=20
> However, I would have expected the kzalloc() to blow up _first_.

Hmm.

> Regardless, I suspect the addition of "if (n_thresholds > 1)" is what is
> tripping GCC.
>=20
>                 int len =3D nla_len(attrs[NL80211_ATTR_CQM_RSSI_THOLD]);
> 		...
>                 return nl80211_set_cqm_rssi(info, thresholds, len / 4,
>                                             hysteresis);
>=20
> Now it "knows" there is a path where n_threasholds could be [2,
> INT_MAX].

Yeah, it's not _really_ bounded, apart from the message length? But then
struct_size() should saturate and fail? But I guess it cannot know that,
and limits the object size to 1<<63 - 1 whereas the copy is 1<<64 - 1...

> Does this warning go away if "len" is made unsigned?

Thing is, neither Kalle nor I can even reproduce the warning locally, so
it's a bit hard to check ... not even with their config and gcc 12.2.0
(nix, rather than debian though.)

> Does adding an upper bounds sanity check help as a work-around, like:

So ... no idea!

I guess I can push something to a branch and see if the robot picks it
up ...

johannes

