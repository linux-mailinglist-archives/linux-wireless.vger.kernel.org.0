Return-Path: <linux-wireless+bounces-38013-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kArCKbqTOmpiAggAu9opvQ
	(envelope-from <linux-wireless+bounces-38013-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 16:10:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA886B7C01
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 16:10:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=J4+J6cKe;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38013-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38013-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 662563016AFD
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 14:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75333812E1;
	Tue, 23 Jun 2026 14:09:48 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A4E380FFE;
	Tue, 23 Jun 2026 14:09:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782223788; cv=none; b=WfhzVxT5HLMOEIIJDbcpRaXbixuMcaH212vpTNkj/M8TP05W1M58eEppPKGk6n/v76af79b/WDm6dZAb8vh9tgkLbW82ooWcWormBgP+bb/FnKPswdtJ01e3g13/t6XbaRODai07ZpBlKIvxhoYyAxxzuML/Vs65p3WWcVBXmc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782223788; c=relaxed/simple;
	bh=kOprRzbM7KFPtmvL8N6apCL4mJ4W8aayvM4vio8qpao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVlcQSJdge66bXs7sCzp1ijjgQKNNx2zk5PDJFSbbH+ox3wAO+QYwzvqRtuSDov+nY3/TT3rpPFPJ40CENBmJc3RreOfVahlaZZn5wZDOyw7I0bis0xjqiZbZjgD0t5oybFMZuOlbK6z7/alc2t+46CXNXf0AKIaci1B/89wszY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J4+J6cKe; arc=none smtp.client-ip=192.198.163.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782223786; x=1813759786;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=kOprRzbM7KFPtmvL8N6apCL4mJ4W8aayvM4vio8qpao=;
  b=J4+J6cKevjZMWmCZxP/QqQRjUpWpKXPDvuJdto6hQcOmvSuq+HlypRhy
   MQyeWVdw0bkKatMCAY8vQe2sZYnJT4TuOol58uGZY2apFY/z/RN6rORvW
   VUrKffDIzoJAzzyYhD07Ct74emnzPt4/YhNt9UWNWHUpUdwkGr776oq60
   CS8hu/wJ3oh67Ef9xpM1igrrzLrydUlq5osEcXYL05oSi0FDS/OdOPakh
   zeaspsluW6bGhpiuYfa6L81WzXv/zfBZWAaxwMVu7bVUzYW/NaIUkhWeQ
   j9+saLJT5aRnzKCmsG1BrMlOA4a8eDk024Fqw9R1mRramrXvexJt81MOr
   Q==;
X-CSE-ConnectionGUID: d0Ad45jLTmSLxd7FfSlTzg==
X-CSE-MsgGUID: mdE/CPoZSH+9CWLzrxGgdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="82074173"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="82074173"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 07:09:44 -0700
X-CSE-ConnectionGUID: kiNjFd8VQpmeNcjlSz3bfw==
X-CSE-MsgGUID: h/g9ioxRRBiW564TCjXsXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="245161587"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.7])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 07:09:42 -0700
Date: Tue, 23 Jun 2026 17:09:40 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v1 1/2] overflow: Allow to sum a few arguments at once
Message-ID: <ajqTpJAMFFV3H5Im@ashevche-desk.local>
References: <20260617112250.2791461-1-andriy.shevchenko@linux.intel.com>
 <20260617112250.2791461-2-andriy.shevchenko@linux.intel.com>
 <202606182046.AE5F6A241@keescook>
 <ajTlfuOFHXlA7xdu@ashevche-desk.local>
 <202606192025.CF68F2E@keescook>
 <ajY5hg0f34C-iV3R@ashevche-desk.local>
 <54974e4298efd26a52c9c0e9ada88d57e8695a09.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <54974e4298efd26a52c9c0e9ada88d57e8695a09.camel@sipsolutions.net>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:kees@kernel.org,m:linux-hardening@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:gustavoars@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[andriy.shevchenko@linux.intel.com,linux-wireless@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-38013-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,vger.kernel.org:from_smtp,ashevche-desk.local:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8DA886B7C01

On Mon, Jun 22, 2026 at 01:16:29PM +0200, Johannes Berg wrote:
> On Sat, 2026-06-20 at 09:56 +0300, Andy Shevchenko wrote:
> > Johannes, are you okay to take a new version (I assume the wish is to h=
ave
> > the balanced additions)? If so, I will prepare one.
>=20
> Sure, I can take the patches, sounds good to me.

Will send soon, for the record the *.i file is 61 character less with the p=
atch.

Was

size =3D __builtin_choose_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((=
long)(n_channels) * 0l)) : (int *)8))), sizeof(*(request)) + __builtin_choo=
se_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)(n_channels) * 0l)=
) : (int *)8))), (n_channels) * sizeof(*(request)->channels) + ((int)sizeof=
(struct {_Static_assert(!(!(!__builtin_types_compatible_p(typeof(((request)=
->channels)), typeof(&((request)->channels)[0])))), "must be array");})), s=
ize_mul(n_channels, sizeof(*(request)->channels) + ((int)sizeof(struct {_St=
atic_assert(!(!(!__builtin_types_compatible_p(typeof(((request)->channels))=
, typeof(&((request)->channels)[0])))), "must be array");})))), __size_add(=
sizeof(*(request)), __builtin_choose_expr((sizeof(int) =3D=3D sizeof(*(8 ? =
((void *)((long)(n_channels) * 0l)) : (int *)8))), (n_channels) * sizeof(*(=
request)->channels) + ((int)sizeof(struct {_Static_assert(!(!(!__builtin_ty=
pes_compatible_p(typeof(((request)->channels)), typeof(&((request)->channel=
s)[0])))), "must be array");})), size_mul(n_channels, sizeof(*(request)->ch=
annels) + ((int)sizeof(struct {_Static_assert(!(!(!__builtin_types_compatib=
le_p(typeof(((request)->channels)), typeof(&((request)->channels)[0])))), "=
must be array");}))))));
- size =3D __size_add(size, size_mul(sizeof(*request->ssids), n_ssids));
- size =3D __size_add(size, size_mul(sizeof(*request->match_sets), n_match_=
sets));
- size =3D __size_add(size, size_mul(sizeof(*request->scan_plans), n_plans)=
);
- size =3D __size_add(size, ie_len);

Now

size =3D __size_add(__size_add(__size_add(__builtin_choose_expr((sizeof(int=
) =3D=3D sizeof(*(8 ? ((void *)((long)(n_channels) * 0l)) : (int *)8))), si=
zeof(*(request)) + __builtin_choose_expr((sizeof(int) =3D=3D sizeof(*(8 ? (=
(void *)((long)(n_channels) * 0l)) : (int *)8))), (n_channels) * sizeof(*(r=
equest)->channels) + ((int)sizeof(struct {_Static_assert(!(!(!__builtin_typ=
es_compatible_p(typeof(((request)->channels)), typeof(&((request)->channels=
)[0])))), "must be array");})), size_mul(n_channels, sizeof(*(request)->cha=
nnels) + ((int)sizeof(struct {_Static_assert(!(!(!__builtin_types_compatibl=
e_p(typeof(((request)->channels)), typeof(&((request)->channels)[0])))), "m=
ust be array");})))), __size_add(sizeof(*(request)), __builtin_choose_expr(=
(sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)(n_channels) * 0l)) : (int=
 *)8))), (n_channels) * sizeof(*(request)->channels) + ((int)sizeof(struct =
{_Static_assert(!(!(!__builtin_types_compatible_p(typeof(((request)->channe=
ls)), typeof(&((request)->channels)[0])))), "must be array");})), size_mul(=
n_channels, sizeof(*(request)->channels) + ((int)sizeof(struct {_Static_ass=
ert(!(!(!__builtin_types_compatible_p(typeof(((request)->channels)), typeof=
(&((request)->channels)[0])))), "must be array");})))))), ie_len), size_mul=
(sizeof(*request->ssids), n_ssids)), __size_add(size_mul(sizeof(*request->m=
atch_sets), n_match_sets), size_mul(sizeof(*request->scan_plans), n_plans))=
);

--=20
With Best Regards,
Andy Shevchenko



