Return-Path: <linux-wireless+bounces-18230-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D5FA234A4
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 20:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1D6A3A57EB
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 19:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F721F03EF;
	Thu, 30 Jan 2025 19:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="dPApPhuf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C1D1946C8;
	Thu, 30 Jan 2025 19:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738265025; cv=none; b=gyN8Sz4ed3l+nL+YtKSWelvg0FNBspZfPqvs/fWonkK2o0divDgUEnsq8SQ4NwWoDwg/gBtGjZux7eFUWRxZ7WjWSv+5Tx2P7aWdK8TgVQvhIATcmaTsZubCBhwIc4dErOu6SCQGrEjz4MMwA5UKf2zk7FynftNNMr1EOxe0D2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738265025; c=relaxed/simple;
	bh=lIvGpX8WD3XTBMcZTY7azxPjmetV+HPPVHJ824ZuIRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ez58e69DRPzNU29ywd6u9LQWYg1jpewz41kcKbWQP2SoIN9JZxUJlTPq5TzMhEMs7vwVvPSqL9gWuxM2WnNfFrwDFSx/kbSM0DgydyEngsjcAtmojkZXyKN5u5OHuALzDoyZ44FoBQ7CxUYjPUo0ZdJJRW374G6S8RwG/wWTDbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=dPApPhuf; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.6])
	by mail.ispras.ru (Postfix) with ESMTPSA id 3ED6E40B1E97;
	Thu, 30 Jan 2025 19:23:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 3ED6E40B1E97
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1738265011;
	bh=fRNREKn21spnJPWVm/lHW/IC6vrxQE/c8YaO5ujKpmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dPApPhufZn1+n+sSnZDqA+dQCitqUQW/zgh+XvRqe4tpR1Yu2ilKLUvOshaMRmYly
	 J6cBO2g66C6PGPuwv7uRbihmyNmEcN7Fl9S0AP5Y9HH1PF8ljbt8spjgJAbgG+QMEJ
	 uKeTXs+Hk6cX1N0vUG09LcRG6cyeOBw3Wk29hDJ0=
Date: Thu, 30 Jan 2025 22:23:30 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>, 
	lvc-project@linuxtesting.org, Michael Wu <flamingice@sourmilk.net>, 
	linux-wireless@vger.kernel.org, "John W. Linville" <linville@tuxdriver.com>, 
	linux-kernel@vger.kernel.org, syzbot+2e5c1e55b9e5c28a3da7@syzkaller.appspotmail.com
Subject: Re: [lvc-project] [PATCH] wifi: nl80211: override all other flags if
 MONITOR_FLAG_COOK_FRAMES is set
Message-ID: <fhgill32gd3ugmd23oxnyvvqqfd3feu4zv3ecrkubeyqhwnb2h@pkflwiezmsp2>
References: <20250130123432.4534-1-v.shevtsov@mt-integration.ru>
 <14c5edc71a74049c49d51960249b0aefc77208be.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <14c5edc71a74049c49d51960249b0aefc77208be.camel@sipsolutions.net>

On Thu, 30. Jan 13:36, Johannes Berg wrote:
> On Thu, 2025-01-30 at 17:34 +0500, Vitaliy Shevtsov wrote:
> > It is possible to set both MONITOR_FLAG_COOK_FRAMES and MONITOR_FLAG_ACTIVE
> > flags simultaneously on the same monitor interface from the userspace. This
> > causes a sub-interface to be created with no IEEE80211_SDATA_IN_DRIVER bit
> > set because the monitor interface is in the cooked state and it takes
> > precedence over all other states. When the interface is then being deleted
> > the kernel calls WARN_ONCE() from check_sdata_in_driver() because of missing
> > that bit.
> > 
> > Fix this by overriding all flags if MONITOR_FLAG_COOK_FRAMES is set because
> > this flag is incompatible with other monitor flags being set.
> > 
> 
> That seems wrong, reject it instead. Anyway we should probably remove
> cooked mode.

Do you suggest rejecting to set MONITOR_FLAG_COOK_FRAMES overall?
Wouldn't it break existing userspace, especially in context of systems
running old stable kernels where the patch is also needed?

There is still some usage of this flag in hostap [1].

Or your suggestion is to explicitly reject setting MONITOR_FLAG_COOK_FRAMES
only when it is passed combined with some other flags which it is
incompatible with?

Btw, the fragment [2] says the cooked flag overrides the other ones.
But it was written a long time ago so many things have changed I guess.

  /**
   * enum nl80211_mntr_flags - monitor configuration flags
   *
   * Monitor configuration flags.
  
  ...
  
   * @NL80211_MNTR_FLAG_COOK_FRAMES: report frames after processing.
   *	overrides all other flags.

[1]: https://w1.fi/cgit/hostap/tree/src/drivers/driver_nl80211.c#n6209
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/nl80211.h#n4731

--
Thanks,
Fedor

