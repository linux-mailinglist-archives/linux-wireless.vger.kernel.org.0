Return-Path: <linux-wireless+bounces-19435-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A51A44A4D
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 19:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ADA8423F86
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 18:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D800E186E2F;
	Tue, 25 Feb 2025 18:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDIDpF7d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD75317B418;
	Tue, 25 Feb 2025 18:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740507916; cv=none; b=NELoQquOaGBx9scYDnWb+/1unux3fV3HflEwNnWfComlJYk4OUx8W2BcDp94HtdzBGK6+wpKEW4yUaX+dUrYIakJQQ9i5aLnc3mb7Fp8OhOulmfNSVZSorn95isNFCQicEWXKqOm+NihVKtfSAD+RWgKpUyMkvFh46LrRZPJfOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740507916; c=relaxed/simple;
	bh=o1iiOA9LfnQe0ALiZ+iV2Yj2Y8Ra3J2HvrNSi5k9uUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nXzLYGK3kV9DsQIVbVrNYaTqf7bBVXjbfa4xM3DFRr83BVdNvdq+Z+89at0ptmK6rDntzbaC1VWI/eiwpKyykLY2steLdZ+83814sBaZLkt5+2EBMBGdi/AFoFlbbvYS7rqOZ4VnGsXxs3qoa9qv/SAMB8jZsqyTZ22sz/jP/3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDIDpF7d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2E8C4CEDD;
	Tue, 25 Feb 2025 18:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740507916;
	bh=o1iiOA9LfnQe0ALiZ+iV2Yj2Y8Ra3J2HvrNSi5k9uUQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YDIDpF7dFzNIyTih0uCzjJfw4vs3xlnImSNlOdnNwwOySd1S+k5IYOXtR1lbsS0J9
	 EovqW53KYBNAKTR6FRu5s/mrVEUQZTw7lQnrwAcbiIyvU+SAGKWKO9EUeYV7/NvFXx
	 W+UtVXdNrAGR1i3OEBmsrFJktzeviFoEd7DzsqjvLbC8Vf/bw4D+4qLQf//gE+tjvQ
	 UQoSjRwRzlcw5JWvBWkG43kfrYS2lT5OkV1y/X/aDBFAzgd2oESCMG8amrW4vgBzmR
	 spAKa7f/GCNfAFiEzg3U3nrohFCLLLN4UKF3gseJwO/zvG2ioWYowPsmREyYixXvJq
	 zQgTOj7CS5scQ==
Date: Tue, 25 Feb 2025 12:25:14 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Johannes Berg <johannes.berg@intel.com>, Kalle Valo <kvalo@kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [regression] Significant WiFi Speed Reduction with Kernel
 Versions > 6.8.12 on Intel Wi-Fi 6 AX203
Message-ID: <20250225182514.GA512422@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e9c5c74-9b36-48bb-b74a-9a209b71a634@leemhuis.info>

On Thu, Aug 08, 2024 at 08:43:53AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 07.08.24 11:12, Linux regression tracking (Thorsten Leemhuis) wrote:
> > 
> > Mukesh Sisodiya, I noticed a report about a regression in
> > bugzilla.kernel.org that appears to be caused by a change of yours:
> > 
> > 099a47dbe71b75 ("wifi: iwlwifi: Add support for new 802.11be device")
> > [v6.9-rc1]
> 
> For the record, turns out the bisection went a bit sideways and the
> problems apparently is caused by 84ec2d2e960f33 ("wifi: iwlwifi: disable
> 160 MHz based on subsystem device ID") [v6.9-rc1]. For details, see
> https://bugzilla.kernel.org/show_bug.cgi?id=219114#c8

Browsing the regression tracker, this seems stalled with no responses
even though the submitter (bcc'd) has bisected it.

Maybe regzbot will notice the correct commit below?

#regzbot introduced: 84ec2d2e960f ("wifi: iwlwifi: disable 160 MHz based on subsystem device ID")

