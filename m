Return-Path: <linux-wireless+bounces-13687-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B3F993F47
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 09:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 195961F2260C
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 07:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7F4176FCE;
	Tue,  8 Oct 2024 06:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xVJhxnfO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFE9152532;
	Tue,  8 Oct 2024 06:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728369748; cv=none; b=c6LToWJ++oHmmKzYkog0YVDjEI5brK8xcp27ek7whIrB+b/rJFzV8xXrQlGUfA76+Tes0jSoN8d8y/sMA9FUGJ+jzODjY1G/+0+lpJA7lWwZ3arD+1vSWiX+e4irG0Bjfy8QWIMa0DMgK85twhqJcdjidrChju4wYwY5jLJxCjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728369748; c=relaxed/simple;
	bh=vOTzj8MxdS/80qLYwsXhE4V7/BhyxJnz1gAvjPtpems=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4rElC619VRWmJQkt5wg/xfdHlLfj7k5svhPQdK/AN1CvQOzugzfPYm6WC982IXu4NN+iBdNnjoLWXW0+rKboERlNF6cKItapsriQ/qd17OZlK13z2OAqk9Jw8/394uA1ctlo9E2zojdxzhy10QVDGHyARRGSdgxwU/qREOS4iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xVJhxnfO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61FEC4CECC;
	Tue,  8 Oct 2024 06:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728369745;
	bh=vOTzj8MxdS/80qLYwsXhE4V7/BhyxJnz1gAvjPtpems=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xVJhxnfOsXgVkxlXPAFdw5kvKUC5DO1Ln22tmYwAAJrT21ipelsCT49MQWLlznA1S
	 +eZ4k3Lx9i3ZdLFMWw8qe80Q3Kl3UHHXY8KHMGy7TzQHppzALCldT8/kF/sPD8XHrL
	 vlm0lPcx8KCcJUR2Zzw/OjATdLDBCvgeI1puEvWE=
Date: Tue, 8 Oct 2024 08:42:21 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org, linux-staging@lists.linux.dev,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH v2 4/6] staging: rtl8192e: delete the driver
Message-ID: <2024100810-payback-suds-8c15@gregkh>
References: <20241007182706.66888-8-johannes@sipsolutions.net>
 <20241007202707.d0e59cdd2cdc.I8e4d74a6e1d09eefe1f5e2e208735ba2ccef1d4f@changeid>
 <b6ff86e3-56a1-43d3-83b2-01818684f076@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6ff86e3-56a1-43d3-83b2-01818684f076@gmail.com>

On Mon, Oct 07, 2024 at 11:32:25PM +0200, Philipp Hortmann wrote:
> On 10/7/24 20:26, Johannes Berg wrote:
> > From: Johannes Berg<johannes.berg@intel.com>
> > 
> > This driver is using lib80211 and any driver that plans to ever
> > leave staging should never have done that, so remove the driver
> > to enable cleaning up lib80211 into libipw inside the old Intel
> > drivers.
> > 
> > Signed-off-by: Johannes Berg<johannes.berg@intel.com>
> > ---
> 
> Hi Johannes,
> 
> this driver is not only working, it is also supporting a form factor that is
> usable and is available on the used hardware market.
> 
> Is it possible to migrate the driver from lib80211 to libipw?

I don't think a "migration" is simple or easy, I only know of one driver
that ever made that move and it was not easy.  It's simpler to just take
the existing driver, hack it to pieces out-of-tree and then submit a new
driver using the correct apis.

As you have the hardware itself, that would be a good thing to do as you
can test it.

> It does not have to be you who is doing this. How urgent is it to remove
> this driver?

No staging driver should ever get in the way of api changes elsewhere in
the kernel, that's one of the rules of this part of the tree.  So from
my opinion, it's fine to delete it now.  It can always come back in a
new way later on.

thanks,

greg k-h

