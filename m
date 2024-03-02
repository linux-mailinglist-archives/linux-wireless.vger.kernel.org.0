Return-Path: <linux-wireless+bounces-4321-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF8A86EF68
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Mar 2024 09:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABCACB241EC
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Mar 2024 08:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5C712B77;
	Sat,  2 Mar 2024 08:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="n39tL9xL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4178D125AC
	for <linux-wireless@vger.kernel.org>; Sat,  2 Mar 2024 08:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709366530; cv=none; b=ikcRXZIvIrJpXr5vpKogCQuy6TdMEOeaRmpl9jcxHsjCFHnobKKvi9oGGVmEPbLI4iRXm244OUyWlsFEEFTox+AXZ/zBNYg7/zhAYXwSnXUdjeG8fxAVuOIs8uYei23uEFQP3CsYd55s4KPBX+ItR74QinM8cwteN+srrCqIr/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709366530; c=relaxed/simple;
	bh=s6YpWJ5wHXyuK1dUAyiFJJy9ZSFYXVOXczsle7xZPBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0F5FrGtNqCSudmRMdX1K4bQaenH72a3Sah8AzggrjDtq7Y9qWXJBcFiXRDtwFP0r9MU0N4Eb568uBuCpB601cvQsiMyg4G7FKlkmKFy068XewZbdt3QDgMw8iMneVKNZmE0nNrtNUYz7KCFYc0c8/ggeg1wnXR2ncHh6QKAS/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b=n39tL9xL; arc=none smtp.client-ip=212.77.101.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 19940 invoked from network); 2 Mar 2024 09:01:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1709366518; bh=LkUuXAbpxNJuTRZOfv78mua6aea8iciubVI2+0Ql1zQ=;
          h=From:To:Cc:Subject;
          b=n39tL9xLfOH+LbXabkCZmPqm+g6FYkEFpxrzd63xmPU5cXDbmhOz79U+b+WKXFRaB
           wO48/kK8xx+LU6oQO9FWjtEKkAjOWu2GprBQxPCR4O8pcAyYCPJTgY27UP4V7l6PaY
           kSDWe/nTFX9UsaRQZKyfJk9I6Dm/OSIM6ANZiR2k=
Received: from 89-64-9-52.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.9.52])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <kvalo@kernel.org>; 2 Mar 2024 09:01:58 +0100
Date: Sat, 2 Mar 2024 09:01:57 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH 4/4] wifi: rt2x00: fix __le32 sparse warnings
Message-ID: <20240302080157.GA196452@wp.pl>
References: <20240130151556.2315951-1-kvalo@kernel.org>
 <20240130151556.2315951-5-kvalo@kernel.org>
 <87il3aaqoz.fsf@kernel.org>
 <20240203123528.GA170353@wp.pl>
 <87v8689b46.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8689b46.fsf@kernel.org>
X-WP-MailID: 6c9126480c75da848af03b068cc90e95
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [kSNE]                               

On Wed, Feb 28, 2024 at 11:44:25AM +0200, Kalle Valo wrote:
> Stanislaw Gruszka <stf_xl@wp.pl> writes:
> 
> > On Wed, Jan 31, 2024 at 09:48:44AM +0200, Kalle Valo wrote:
> >> Kalle Valo <kvalo@kernel.org> writes:
> >> 
> >> > Sparse warns:
> >> >
> >> > drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10949:39: warning: incorrect type in assignment (different base types)
> >> > drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10949:39:    expected unsigned int [usertype]
> >> > drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10949:39:    got restricted __le32 [usertype]
> >> > drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10951:43: warning: incorrect type in assignment (different base types)
> >> > drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10951:43:    expected unsigned int [usertype]
> >> > drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10951:43:    got restricted __le32 [usertype]
> >> > drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10953:43: warning: incorrect type in assignment (different base types)
> >> > drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10953:43:    expected unsigned int [usertype]
> >> > drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10953:43:    got restricted __le32 [usertype]
> >> > drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10955:43: warning: incorrect type in assignment (different base types)
> >> > drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10955:43:    expected unsigned int [usertype]
> >> > drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10955:43:    got restricted __le32 [usertype]
> >> >
> >> > rt2x00 does some wicked casting here so no wonder sparse warns. Clean that up
> >> > and use cpu_to_le16() to avoid any warnings.
> >> >
> >> > Compile tested only.
> >> >
> >> > Signed-off-by: Kalle Valo <kvalo@kernel.org>
> >> 
> >> Stanislaw, sorry somehow I corrupted your address but fixed it now. Let
> >> me know what you think, patch here:
> >> 
> >> https://patchwork.kernel.org/project/linux-wireless/patch/20240130151556.2315951-5-kvalo@kernel.org/
> >
> > If I analyse it correctly, patch is not ok on Big Endian machines
> > where we do bytes swapping.
> 
> Ouch, thanks for catching this. Johannes sent a new version:
> 
> https://patchwork.kernel.org/project/linux-wireless/patch/20240223114023.ce0c714124e9.I2b5710b761f63522574fbe7654d37151c31e0b77@changeid/
That one looks good.

Thanks
Stanislaw

