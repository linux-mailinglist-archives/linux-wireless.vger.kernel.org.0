Return-Path: <linux-wireless+bounces-24518-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEE8AE96BD
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 09:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3D541C21EEB
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 07:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB8223B63A;
	Thu, 26 Jun 2025 07:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zOz4Dkoa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8FD23B62A;
	Thu, 26 Jun 2025 07:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750923001; cv=none; b=svCqhcKJfGCE13m9WG2TnyTzcexa5R6wkjbXoSa/gRe88EkBsqJGLCFNVdhQ5CHi3AUGPYvJ7NtC0sBXNufAhA+IgSo1EAwJ5X9TeuA94zpmZjU6XiZIlhIyKUr6jYVXIPBVsUDO1u8Ryb/PzVw4WI+VgON2rrKi3tC+Fs/Dtw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750923001; c=relaxed/simple;
	bh=USPecJ+fVgr0c6joAtvhKAAbQeCia+AOGrJmMy5S67s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Smqi/BNKF43zjBh3vO5viv+eQIIGfIsay1Lc2A4jBNIQKVoxHltUROjkT0dH6augKxsJajrp0jiTU+eoZ54b/C5H3GK1SoLI+XvtmufgvuXwe7RipED/wgng9AXWsuJgtaN0DZeD8BeOrqJ0L61NSljMgvmOPFea0OJkbngv7Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zOz4Dkoa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99F2C4CEEB;
	Thu, 26 Jun 2025 07:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750923001;
	bh=USPecJ+fVgr0c6joAtvhKAAbQeCia+AOGrJmMy5S67s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zOz4DkoaO1jWxTi1g8gxaqhuZFjhE58S2mC08ZOo65kPh8SCcNbP/rKvuW+4l78g8
	 fgF47yIEpADGouZPK6Z7LTVUYQyBDzVmeDDL6Vm0wv4U9fLCT3zHF2wkC5oa81G/us
	 oM69Ad7pj8HIncudOUeIlD2SyDqSz8kzL4dfsMlo=
Date: Thu, 26 Jun 2025 08:29:58 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: stable@vger.kernel.org, Jeff Johnson <jjohnson@kernel.org>,
	linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org, Gregoire <gregoire.s93@live.fr>,
	Sebastian Reichel <sre@kernel.org>,
	Baochen Qiang <quic_bqiang@quicinc.com>,
	Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: install pairwise key first
Message-ID: <2025062637-facsimile-chatter-f87a@gregkh>
References: <20250523-ath12k-unicast-key-first-v1-0-f53c3880e6d8@quicinc.com>
 <aFvGnJwMTqDbYsHF@hovoldconsulting.com>
 <2d688040-e547-4e18-905e-ea31ea9d627b@quicinc.com>
 <e23d7674-31cd-4499-9711-6e5695b149c6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e23d7674-31cd-4499-9711-6e5695b149c6@oss.qualcomm.com>

On Wed, Jun 25, 2025 at 07:48:54AM -0700, Jeff Johnson wrote:
> On 6/25/2025 3:15 AM, Baochen Qiang wrote:
> > 
> > 
> > On 6/25/2025 5:51 PM, Johan Hovold wrote:
> >> [ +CC: Gregoire ]
> >>
> >> On Fri, May 23, 2025 at 11:49:00AM +0800, Baochen Qiang wrote:
> >>> We got report that WCN7850 is not working with IWD [1][2]. Debug
> >>> shows the reason is that IWD installs group key before pairwise
> >>> key, which goes against WCN7850's firmware.
> >>>
> >>> Reorder key install to workaround this.
> >>>
> >>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=218733
> >>> [2] https://lore.kernel.org/all/AS8P190MB12051DDBD84CD88E71C40AD7873F2@AS8P190MB1205.EURP190.PROD.OUTLOOK.COM
> >>>
> >>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> >>> ---
> >>> ---
> >>> Baochen Qiang (2):
> >>>       wifi: ath12k: avoid bit operation on key flags
> >>>       wifi: ath12k: install pairwise key first
> >>
> >> Thanks for fixing this, Baochen.
> >>
> >> I noticed the patches weren't clearly marked as fixes. Do you think we
> >> should ask the stable team to backport these once they are in mainline
> >> (e.g. after 6.17-rc1 is out)? Or do you think they are too intrusive and
> >> risky to backport or similar?
> > 
> > Yeah, I think they should be backported.
> > 
> >>
> >> [ Also please try to remember to CC any (public) reporters. I only found
> >>   out today that this had been addressed in linux-next. ]
> > 
> > Thanks, will keep in mind.
> 
> +Stable team,
> Per the above discussion please backport the series:
> https://msgid.link/20250523-ath12k-unicast-key-first-v1-0-f53c3880e6d8@quicinc.com

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

