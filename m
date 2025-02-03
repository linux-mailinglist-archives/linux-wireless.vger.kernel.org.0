Return-Path: <linux-wireless+bounces-18299-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13199A2573D
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 11:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65AD5188141B
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 10:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0E7201034;
	Mon,  3 Feb 2025 10:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w1.fi header.i=@w1.fi header.b="l4bcrekQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.w1.fi (mail.w1.fi [212.71.239.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E4E1E0DB3;
	Mon,  3 Feb 2025 10:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.71.239.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738579726; cv=none; b=eT0Jl0zxO5dvOgfBSCRnHdol9l1CYdHwowrE8UH6EhKXw5D6BgVqM7gZH/mvPow81+ei1GgBL9tzU0Ox5oZ3Nl3tqRIFQHBRqiPufxBe+OobzsrMhnq+7AcNpBUnF2ZiT/5bqVWI0MZWXmi9R4zshcQkl1M6J6XomBXrNO6LzNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738579726; c=relaxed/simple;
	bh=sekvpPexvmQdy0Fo/779D+igUWcBh5Z432CGAD709/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HqsskBe6KOf34XW9ju+uSHiAgeiZBgC+dGpSdPzOUZHlS7gHKgVFhKU1ej1RcmIDtKcllpxEdCWJD5hheusAZH1uIbrYyh4P9OPE7Z9ZFjPcrcORNccYT2cGxUbbGCae/wNpzdLKZ/ylGGYBiw0piMAeXkQqlYSudNNhV9UMf8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=w1.fi; spf=pass smtp.mailfrom=w1.fi; dkim=pass (2048-bit key) header.d=w1.fi header.i=@w1.fi header.b=l4bcrekQ; arc=none smtp.client-ip=212.71.239.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=w1.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w1.fi
Received: from localhost (localhost [127.0.0.1])
	by mail.w1.fi (Postfix) with ESMTP id C893B11C71;
	Mon,  3 Feb 2025 10:40:51 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at w1.fi
Received: from mail.w1.fi ([127.0.0.1])
	by localhost (mail.w1.fi [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2RbUdEjGWDZt; Mon,  3 Feb 2025 10:40:28 +0000 (UTC)
Received: by jm (sSMTP sendmail emulation); Mon, 03 Feb 2025 12:40:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=w1.fi; s=default;
	t=1738579228; bh=sekvpPexvmQdy0Fo/779D+igUWcBh5Z432CGAD709/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l4bcrekQPWct+AGMZbOjcLHUDG387g3wQunDTgva3o8//qiTDLefZnCqPAbX2YQ5R
	 44QmJWCG6RrK5NB9pShdZz5d7QPIOidVzunxcVpN52FUiuQGqoms2S2TQyoMU1sC3b
	 /BJu8FWvllimcEfK8YLT+Fa7pKtbiQkUk5oB6CpRAH1fKanojGX3Qx1hnf+Yz0HAzi
	 Qor1X2k96QI57j0EqPKKuKLHrQrd7lriu3AFKAI7VB5L1emx68wECNmKhj+NlnyLZ4
	 qolaL311IMIa/JAO7XfEashgnw0lAt6XkJRp9cy7lMBmjm6ss7JPm+VYEvEXM5BFaL
	 VlPgvbhH9TjTg==
Date: Mon, 3 Feb 2025 12:40:26 +0200
From: Jouni Malinen <j@w1.fi>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>,
	lvc-project@linuxtesting.org, Michael Wu <flamingice@sourmilk.net>,
	linux-wireless@vger.kernel.org,
	"John W. Linville" <linville@tuxdriver.com>,
	linux-kernel@vger.kernel.org,
	syzbot+2e5c1e55b9e5c28a3da7@syzkaller.appspotmail.com
Subject: Re: [lvc-project] [PATCH] wifi: nl80211: override all other flags if
 MONITOR_FLAG_COOK_FRAMES is set
Message-ID: <Z6CdGnGnFJ8OuWyT@w1.fi>
References: <20250130123432.4534-1-v.shevtsov@mt-integration.ru>
 <14c5edc71a74049c49d51960249b0aefc77208be.camel@sipsolutions.net>
 <fhgill32gd3ugmd23oxnyvvqqfd3feu4zv3ecrkubeyqhwnb2h@pkflwiezmsp2>
 <49fe46c6a158873cdc6593b0d5630b62a59ed059.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49fe46c6a158873cdc6593b0d5630b62a59ed059.camel@sipsolutions.net>

On Thu, Jan 30, 2025 at 10:13:14PM +0100, Johannes Berg wrote:
> On Thu, 2025-01-30 at 22:23 +0300, Fedor Pchelkin wrote:
> > Wouldn't it break existing userspace, especially in context of systems
> > running old stable kernels where the patch is also needed?
> > 
> > There is still some usage of this flag in hostap [1].
> 
> Theoretically, but I just commented on that here:
> 
> https://lore.kernel.org/r/a49e58998553c45953a30243ad1957c06ce6db8c.camel@sipsolutions.net
> 
> tl;dr: only ancient hostapd versions will actually _use_ it, and they
> have to fall into a relatively narrow range (April 2009 - Dec 2011.)

How did you determine that commit a11241fa1149 ("nl80211: Use nl80211
for mgmt TX/RX in AP mode") ends this use? Support for monitor mode
interface is still in hostap.git and it is even tested as part of the
hwsim test cases.. Both hostapd and wpa_supplicant can still be
configured to use the monitor interface.

It would be another question to ask whether there is any good reason to
use this anymore now that a better approach has been available for 13
years and the answer to that is likely "no". Anyway, this is a kernel
interface that has a user even in the current snapshot of user space
programs. If we are about to break that use, it would make sense to
first remove such users. I don't think I would really care about this
anymore and it would be nice to get rid of all that unlikely to be used
much, if at all, code.

> > Or your suggestion is to explicitly reject setting MONITOR_FLAG_COOK_FRAMES
> > only when it is passed combined with some other flags which it is
> > incompatible with?
> 
> Yes.

Though, this seems to imply that the case used by hostapd/wpa_supplicant
would not be broken.

-- 
Jouni Malinen                                            PGP id EFC895FA

