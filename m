Return-Path: <linux-wireless+bounces-25551-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2751B07C28
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 19:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AEF21C41A65
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 17:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590AA276047;
	Wed, 16 Jul 2025 17:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYW8J2ED"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CED92E3715;
	Wed, 16 Jul 2025 17:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752687449; cv=none; b=DGGiMMKmYeFZP3EmPcbbgngFvxf7jDHGydmVtvJjPYDWJGXMu+94ZUC5OGoNKNcQ/8lWkB8VyO0TkA3Dz/A5vLzQlN/wsz7iAz6TuTshvTc9AA589Fdi0q2vqoXfV5dHmXdetYM9TbgECZxq5lqB1e5MNs+emG3zruUC2WxMM/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752687449; c=relaxed/simple;
	bh=f6IxuR+5LyLa3xTmgpVU7XxYAsnemiPidYN2+s4atr4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CmFEoajDRBzmqgRqO0EnLWI9o8gih0dHNj1NuT5z8NqntfkAJI2Nh6iyzimgChHBIDp002uN5u5ulPo2Y+yc/Nmgt0KMhf85ahx9iRK+4c83df22BFPxsdsF0VKLihlL5GV3WnUALZG/wGrQ2GzAQGf1fCfRhcV+a8XrQZ9VypA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYW8J2ED; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D638C4CEE7;
	Wed, 16 Jul 2025 17:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752687448;
	bh=f6IxuR+5LyLa3xTmgpVU7XxYAsnemiPidYN2+s4atr4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UYW8J2EDgjaUvT+v3iFQ/kMHBSTYJjFPWoXht+YbSLLZsVpONIftuM/hfz46XWwuY
	 p89VhWrQ/AaieXAg5C6PCToVdGj74+1kLm9am+ZEiY+amNXwoiRoTgtwNlurTgp2jM
	 sOawO/Odi8bpE86VnH9hvLsEMlECSc+MnmNcC7YrcQ2uYEhkvMwMuaGTw3aGsIES3y
	 fLyusMNfy673x0d5M9PTriG9x+NS/1/8kkXYb0s0YU4XUO7h846H4dp82VrKIAEr/2
	 1Z7J8czO4r53xTPBGIcmjt3qtTn7Yfv1oy6m68DAzyQ69cxyqa2KftvMrDlQJrzu0q
	 tGj9OudfOpjJA==
Date: Wed, 16 Jul 2025 12:37:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: iwlwifi stopped working with AX200 (6.16-rc3 regression)
Message-ID: <20250716173726.GA2545047@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aF6rfM-RFrwFyoEw@mail-itl>

On Fri, Jun 27, 2025 at 04:32:28PM +0200, Marek Marczykowski-Górecki wrote:
> On Fri, Jun 27, 2025 at 03:53:57AM +0200, Marek Marczykowski-Górecki wrote:
> > On Fri, Jun 27, 2025 at 03:51:18AM +0200, Marek Marczykowski-Górecki wrote:
> > > I see the only change there between rc2 and rc3 is fixing that WARN_ON
> > > condition. Unfortunately, I don't know what cmd_ver value I have there,
> > > but apparently it's outside of that range (and yet, the driver worked
> > > fine before).
> > > 
> > > The device is:
> > > 02:00.0 Network controller [0280]: Intel Corporation Wi-Fi 6 AX200 [8086:2723] (rev 1a)
> > >     Subsystem: Intel Corporation Wi-Fi 6 AX200NGW [8086:0084]
> > > 
> > > #regzbot introduced: v6.16-rc2..v6.16-rc3
> > 
> > Oh, I see it might be already fixed by
> > https://lore.kernel.org/linux-wireless/20250623111351.1819915-1-miriam.rachel.korenblit@intel.com/,
> > I'll test it.
> 
> Yes, it does fix the issue.

The patch you mention appears to have been merged and appears in
v6.16-rc4:

  https://git.kernel.org/linus/93598167dcb6 ("wifi: iwlwifi: mvm: assume '1' as the default mac_config_cmd version")

so perhaps this entry in the regression tracker can be closed?  Maybe
a response including this would do the trick?

  #regzbot fix: 93598167dcb6 ("wifi: iwlwifi: mvm: assume '1' as the default mac_config_cmd version")

