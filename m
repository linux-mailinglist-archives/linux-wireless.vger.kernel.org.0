Return-Path: <linux-wireless+bounces-24486-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3194EAE8741
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 16:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61DE87A7A8D
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 14:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C2423C4EB;
	Wed, 25 Jun 2025 14:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cv9utmEV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC9717BEBF;
	Wed, 25 Jun 2025 14:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750863445; cv=none; b=RRBiRGyPqLi0YN62mzhyb1ciE8fkbY292X4Y0k2/mG2VD3XoMx8MPxAoEa62usXduWTR4sVZG4KHfgnd+0culBLNm5QbVDPFIyb+rZ+JSSJnU08WkdFeky/8p8Xk64QlZum1E9YUwBEyIyWpaX7eQcZ4WVRXLRqgOYX+hyTwTpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750863445; c=relaxed/simple;
	bh=VS8Oe5TcNPQQJw9J+j+AnUHFH2WyAvcFZgDmG5vDQYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hx9iReGCbtAgtHzQ4rqtpP3BIYhPk46L0tPtMFAWjYVfQ0go4hl8Z2SMDzseTgx0O/LwPlf/ZX7pGZH9b0zKK9NUtgDcCQI0/nn5wFxiX+9SNXv70vt2cwFtPK6DCWTGDQToGdA8bqR3v8H2glPzdL/ZauCazSZqNE8QXPEVeCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cv9utmEV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4398DC4CEEA;
	Wed, 25 Jun 2025 14:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750863445;
	bh=VS8Oe5TcNPQQJw9J+j+AnUHFH2WyAvcFZgDmG5vDQYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cv9utmEV2fnWju69799elbmfrSNfyOT15Vfs4DTZcjww/e8GF5Fq0tsukmsgUBvv2
	 SXsj4F8L90Eqt5dhvNfvv0SCak2H7wjAwbLkQJANBF2/2mP04cyPI5ruXeDvn2DuH6
	 J896FZ1jRIE3HglmkBcGDvgxNhXrmnIQ5gBn8nNjwq45+Sdfmia49u317QJpnxmyZA
	 wkjIQlgT+V7lrwVI8ggMThl0Z7pE8Ys8ZB00ZqZCCkYv82T9unlTAVWIlr8KKnTUXo
	 FY7JjwwJb7nSM+7dVX43LMTzC5USEbewG4/5wKR4yjeuPBBc0qefsikW9OiTNWoJoo
	 77C0sV0owK9cg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uURYy-0000000014F-28Mh;
	Wed, 25 Jun 2025 16:57:25 +0200
Date: Wed, 25 Jun 2025 16:57:24 +0200
From: Johan Hovold <johan@kernel.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: stable@vger.kernel.org, Jeff Johnson <jjohnson@kernel.org>,
	linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org, Gregoire <gregoire.s93@live.fr>,
	Sebastian Reichel <sre@kernel.org>,
	Baochen Qiang <quic_bqiang@quicinc.com>
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: install pairwise key first
Message-ID: <aFwOVGGHOHbko9So@hovoldconsulting.com>
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
> > On 6/25/2025 5:51 PM, Johan Hovold wrote:
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

> +Stable team,
> Per the above discussion please backport the series:
> https://msgid.link/20250523-ath12k-unicast-key-first-v1-0-f53c3880e6d8@quicinc.com

These are currently only in linux-next but would need to be in Linus's
tree before they can be backported, so we'll need to send another
requested once they are in mainline.

> This is a 0-day issue so ideally this should be backported from 6.6+

By "0-day" you mean it has been there since the driver was added, right
(and not that it's exploitable or similar)?

Johan

