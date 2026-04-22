Return-Path: <linux-wireless+bounces-35203-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHNNNH9w6GmvKQIAu9opvQ
	(envelope-from <linux-wireless+bounces-35203-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 08:53:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09623442A02
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 08:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3DA5300B616
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 06:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC3A35B14B;
	Wed, 22 Apr 2026 06:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MDO43mLR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5234347FC8;
	Wed, 22 Apr 2026 06:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776840741; cv=none; b=FswoPX5Yk8AIOaZyZha80NUar5hKDEv76bo6tT6BFvSr0KjKT2WxsREqdu166IotxodI1pOXL7qdsWEedIxCp5G9f5f0H0tzMzBvZN/spQHojLs2cQUXSAKS5xRVApOtrgeZN/daYPipWoewpJWupEys3pvz6lf0AB/1oKZcs+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776840741; c=relaxed/simple;
	bh=ay6xjiGJghH7NwHYxEIqhMcYl2BdvlIR3r4vo0PDoh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIJm9hFIa6CoPofMlTOOwaqo5Ru80dsjo/P1CicwwDU1Z1llxMQCyfOnRU3ePTUFW/F8duRRNOiZ5R1FYQitcOHZKAkrPYRl+HVQlUfC3nAsNrhryMKocMLx5lANCAFbbMmRJTIJFXQ7fokhf0EndSnAwqCgFjBZj7heIcnNBUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MDO43mLR; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776840740; x=1808376740;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ay6xjiGJghH7NwHYxEIqhMcYl2BdvlIR3r4vo0PDoh4=;
  b=MDO43mLRqyNsWBJd+Jk0a8faxJADhY0y43yQ98xM9RjH8Uw8TqeThZ2x
   u3iVgjTM+QFCcuhhvf0OHBpBc3YjE0/0FdKLd5XTT5D2vTld6xnwC1E7b
   LGH8poynB0CyxN7lzpWJfmpoXAZmsSy/sD8QLBgmCEGPV7vBcV8FNMPzR
   xK8TmDK3HTSiofyE3GfDWzTL/PRz5PYViSTPasKp8hPXIS5wWwERXNgDQ
   fZ9aci9bNt3X0ekQxanDd7Dia6V7NcnvOjCdQ51L/+7p0ae5UilFiQVf/
   C0MknNfJY/8GpjV3ApMy1ViZr/F5fkcnygOtrrVQaGUbdK0it/SsQ8mJN
   A==;
X-CSE-ConnectionGUID: rP8xXxJfS1SILi7kmFrDlQ==
X-CSE-MsgGUID: RNZ07PN+Rz2+FgR2BZV3jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="65322966"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="65322966"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 23:52:19 -0700
X-CSE-ConnectionGUID: oNTB+0MOS/qpTyrgLA8O0w==
X-CSE-MsgGUID: gOjFpUXXQRy4nD/0p1uluQ==
X-ExtLoop1: 1
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 23:52:14 -0700
Date: Wed, 22 Apr 2026 09:52:11 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Ulf Hansson <ulfh@kernel.org>,
	"Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>,
	linux-mmc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-kernel@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mediatek@lists.infradead.org,
	Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org,
	Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>
Subject: Re: [PATCH v1 1/6] sdio: Add syntactic sugar to store a pointer in
 sdio_driver_id
Message-ID: <aehwG2Egt93-sPVB@ashevche-desk.local>
References: <cover.1776429984.git.u.kleine-koenig@baylibre.com>
 <c830049dcfcd99f005e2ff6742aace9341c61f13.1776429984.git.u.kleine-koenig@baylibre.com>
 <aeaMkfk_1t98e7SU@monoceros>
 <CABBYNZJzbEmYzTk2m+Y8SoHVouTMA6Gje_55iJsQ6cYtDLftbQ@mail.gmail.com>
 <aecu1ixyHP2hQvgE@monoceros>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aecu1ixyHP2hQvgE@monoceros>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,codasip.com,vger.kernel.org,linuxfoundation.org,sang-engineering.com,holtmann.org,collabora.com,lists.infradead.org,realtek.com,nbd.name,mediatek.com,chromium.org,dolcini.it];
	TAGGED_FROM(0.00)[bounces-35203-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ashevche-desk.local:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,baylibre.com:email]
X-Rspamd-Queue-Id: 09623442A02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 10:12:41AM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> On Mon, Apr 20, 2026 at 04:46:56PM -0400, Luiz Augusto von Dentz wrote:
> > On Mon, Apr 20, 2026 at 4:31 PM Uwe Kleine-König (The Capable Hub)
> > <u.kleine-koenig@baylibre.com> wrote:
> > > On Fri, Apr 17, 2026 at 03:10:47PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> > > > On all current Linux architectures sizeof(long) == sizeof(void *) and
> > > > this is used a lot through the kernel. For example it enables the usual
> > > > practice to store pointers in sdio_driver_id's .driver_data member.
> > > >
> > > > This works fine, but involves casting and thus isn't type-safe.
> 
> To be honest, with the involved void* this isn't really type-safe
> either, but at least the data keeps being a pointer which is really
> helpful on CHERI. FTR: The alternative would be to use uintptr_t instead
> of unsigned long, which also has proponents in the CHERI community and
> which is used in the current vendor patch stack.

FWIW, Linus categorically told that it has to be no uintptr_t in the Linux kernel.

-- 
With Best Regards,
Andy Shevchenko



