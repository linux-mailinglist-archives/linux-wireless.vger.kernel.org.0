Return-Path: <linux-wireless+bounces-250-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCD37FFA9F
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 20:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E5171C20FC5
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 19:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA09F5FEF5;
	Thu, 30 Nov 2023 19:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="WBOmF01E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3960194;
	Thu, 30 Nov 2023 11:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=vsYR7scdNZIludsndTghewaH2HznFu0Os5QUOPvM1nM=;
	t=1701370851; x=1702580451; b=WBOmF01E6Upq82AIEmzqAngGCrNPVkhshRmAxIeVvBTF4nx
	Veh+JmsSERVzV9RvCVUzxiogMcru/K+SLZvZrvR6iLCzIjP/IvBT+pIJhuSV9O0jt7zm6bB49Q4FV
	AscWjSx1MXLL6PXq7yRehSL2VWcTkdf2GrttAF1AAZ+9PCFHZVOdLaxQL/pH145geHnjAAOVIZQbu
	wMwfKdg3WnstNcLrMG3HmCjJOhlCfs9DmAB5Azk9qLOWsKzrVQUNuM16DKDF5D/Blsfdt0FPf5IST
	jK4Mb7GBrsIx/AghSXg5Hh20TTLzfBMz1TnlVGlU1oM+DeYvcRztFqO33UCsVncw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r8mHF-0000000A9bL-1Kjt;
	Thu, 30 Nov 2023 20:00:45 +0100
Message-ID: <bbfd6f959e7ff4b567084ef3d962bf255aa25c85.camel@sipsolutions.net>
Subject: Re: [RFC PATCH] wifi: cfg80211: fix CQM for non-range use
From: Johannes Berg <johannes@sipsolutions.net>
To: Kees Cook <keescook@chromium.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, Michael Walle
 <mwalle@kernel.org>,  lkp@intel.com, oe-kbuild-all@lists.linux.dev,
 linux-wireless@vger.kernel.org,  Max Schulze <max.schulze@online.de>,
 netdev@vger.kernel.org
Date: Thu, 30 Nov 2023 20:00:44 +0100
In-Reply-To: <202311301054.0049306B7@keescook>
References: <202311090752.hWcJWAHL-lkp@intel.com>
	 <202311090752.hWcJWAHL-lkp@intel.com>
	 <1c37d99f722f891a50c540853e54d4e36bdf0157.camel@sipsolutions.net>
	 <fc1dbe4a-a810-445c-9398-60a5e55990a2@quicinc.com>
	 <202311301016.84D0010@keescook>
	 <01e3663e9e1418a183ee86251e0352256494ee28.camel@sipsolutions.net>
	 <202311301054.0049306B7@keescook>
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

On Thu, 2023-11-30 at 10:55 -0800, Kees Cook wrote:
> On Thu, Nov 30, 2023 at 07:40:26PM +0100, Johannes Berg wrote:
> > On Thu, 2023-11-30 at 10:32 -0800, Kees Cook wrote:
> > > Yeah, I would expect this to mean that there is a code path that
> > > GCC found where the value could overflow. It does this when a variabl=
e
> > > "value range" gets bounded (e.g. an int isn't the full -INT_MAX to IN=
T_MAX
> > > range).And flex_array_size() was designed to saturate at SIZE_MIX rat=
her
> > > than wrapping around to an unexpected small value, so these are playi=
ng
> > > together it seems.
> > >=20
> > > However, I would have expected the kzalloc() to blow up _first_.
> >=20
> > Hmm.
> >=20
> > > Regardless, I suspect the addition of "if (n_thresholds > 1)" is what=
 is
> > > tripping GCC.
> > >=20
> > >                 int len =3D nla_len(attrs[NL80211_ATTR_CQM_RSSI_THOLD=
]);
> > > 		...
> > >                 return nl80211_set_cqm_rssi(info, thresholds, len / 4=
,
> > >                                             hysteresis);
> > >=20
> > > Now it "knows" there is a path where n_threasholds could be [2,
> > > INT_MAX].
> >=20
> > Yeah, it's not _really_ bounded, apart from the message length? But the=
n
> > struct_size() should saturate and fail? But I guess it cannot know that=
,
> > and limits the object size to 1<<63 - 1 whereas the copy is 1<<64 - 1..=
.
> >=20
> > > Does this warning go away if "len" is made unsigned?
>=20
> Actually, this alone fixes it too:
>=20
> diff --git a/include/net/netlink.h b/include/net/netlink.h
> index 167b91348e57..c59679524705 100644
> --- a/include/net/netlink.h
> +++ b/include/net/netlink.h
> @@ -1214,9 +1214,9 @@ static inline void *nla_data(const struct nlattr *n=
la)
>   * nla_len - length of payload
>   * @nla: netlink attribute
>   */
> -static inline int nla_len(const struct nlattr *nla)
> +static inline u16 nla_len(const struct nlattr *nla)
>  {
> -	return nla->nla_len - NLA_HDRLEN;
> +	return nla->nla_len > NLA_HDRLEN ? nla->nla_len - NLA_HDRLEN : 0;
>  }
>=20

Heh. If you can sell that to Jakub I don't mind, but that might be a
harder sell than the int/u32 in our code...

johannes

