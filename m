Return-Path: <linux-wireless+bounces-6449-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8158A8387
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 14:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B6B51C2105D
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 12:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA30132803;
	Wed, 17 Apr 2024 12:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7wRYvHP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B47D12E1E8
	for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 12:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713358610; cv=none; b=QFLUSir7+qQ6fMViVETrMLgz+vb+crmRUtYuitYNYcwvzD4Ti6roRLyw+Lu17SNMmSgyKSvxET58P/WbhnkvFE88u/b5HTbQAY5TbvsbFdFvEAfi/CLAwReeqUqUULgaaNie5paQg7WwTE3yHbvXPHFL4ujPr17GZJyuVqOsTmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713358610; c=relaxed/simple;
	bh=bEePnxse+2I8XzUO+l8wK/LeFQ1L2SJAzaYTvMp6hCg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=rQ33tA0WEIvSGA7/szJwgrnSFUNQXdewjopMoTUADXmTWn8BYW4V9ry3FjsHA1tPBSbF+H35dc4VFUPg+b2kRTUspC97P+XDy/QwVANF41C0QZBMxS/rjUJyLCPwIHUxYUIcDo6s8jTtxjpCz9F0Qoc5eOVcY5oQ18P0ja65rg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7wRYvHP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8877C072AA;
	Wed, 17 Apr 2024 12:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713358609;
	bh=bEePnxse+2I8XzUO+l8wK/LeFQ1L2SJAzaYTvMp6hCg=;
	h=From:To:List-Id:Cc:Subject:References:Date:In-Reply-To:From;
	b=d7wRYvHPWdssaEVt/RjNMmvXBCB4Mt/2JPVFM1viY/vgtr5DrgQbsMXQXPauXeujk
	 7g9ftrmY/v04m7f030FW7JzWPHyC0/RaswZksWQVNIRsvqrA0seZnvbZTpv2A0PSt9
	 zOXmlzX4n1YYSNt7oV7gFqWF67+8pCiI1WGIBZXTbQHK9465m/gfXMIX/qBVLIdmVl
	 GErCwclEODEVUdL9CT190AViFnuMn2nw8sx4TMTY/lNsAWGM+LI3td9dmoU0Cb7vQl
	 8pQBa1cmqqO2/7OfgNi62s5UooFeVCXruloH3LXRt7795yjm4y7OvK6iDEXy8fcSTY
	 FPwUzq/MAaqvg==
From: Kalle Valo <kvalo@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-firmware@kernel.org,  linux-wireless@vger.kernel.org,
  miriam.rachel.korenblit@intel.com
Subject: Re: putting future iwlwifi firmware into intel/ ?
References: <fec30176f437d565d4c1dfc4944373f117d75a64.camel@sipsolutions.net>
Date: Wed, 17 Apr 2024 15:56:47 +0300
In-Reply-To: <fec30176f437d565d4c1dfc4944373f117d75a64.camel@sipsolutions.net>
	(Johannes Berg's message of "Wed, 17 Apr 2024 13:18:03 +0200")
Message-ID: <87v84gi1v4.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Berg <johannes@sipsolutions.net> writes:

> Since I was just looking at some firmware related thing (files for the
> hardware that might be shared between Intel BT and WiFi), I noticed that
> just over 30% of the files/dirs in the top-level firmware tree are
> iwlwifi-* files.
>
> While we can't move the files that older drivers might consume, we could
> e.g. change the driver to look up future versions/future hardware under
> intel/ instead? Would that be worth doing?

Yes, please. It would be nice to cleanup linux-firmware.git top level
directory. But what about this:

* convert iwlwifi to first use _all_ files under intel/ and then as a
  fallback top level directory

* move existing iwlwifi firmware files to intel/ but create symlinks from
  the old location to the new one (using 'Link:' in WHENCE)

* add new files only to intel/ directory

* after few (4?) years remove the symlinks from linux-firmware and the
  fallback from iwlwifi

This should ensure backwards compatibility, right?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

