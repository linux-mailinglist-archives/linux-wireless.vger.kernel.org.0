Return-Path: <linux-wireless+bounces-5269-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C53E588BAB2
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 07:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 804EC2A59E8
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 06:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0198062E;
	Tue, 26 Mar 2024 06:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLSCYicQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37442A954
	for <linux-wireless@vger.kernel.org>; Tue, 26 Mar 2024 06:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711435580; cv=none; b=olV5pdMi2TX0FXkR9Q7MJbySp5yvTxtNNS9cXqm1LrRFQclOWOZD3lIj1R69IBf0YU3YXPYWqe1PiUfNSPmARw1ngbThvalIifvGrrLny9EIFUNnXnBz8leKcoJo7VA4zAuk7cMXbDAElnp82KyrRNctkwhtMLcjBxZjsNaU4J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711435580; c=relaxed/simple;
	bh=9z0mCiNP7LoiS/PcsTURyVuNiGId9uKfE7O+GoXoAhM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=VWRgTHkahHHukqnT01ccauqG+O/g2Xav00flXYnwsr5YnshQEYeR80KltZLNEtV+8CiztP5XLiFGX/M2AhjJsMWiGspQ/WIYW0/1vD2kLjehQ7jubVdOOGCu8C5nMwwwIQDEjLEJ25r6g7m80nA4S+k5Ht4JVeWFlHmK/o4OYAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLSCYicQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73AEC433C7;
	Tue, 26 Mar 2024 06:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711435579;
	bh=9z0mCiNP7LoiS/PcsTURyVuNiGId9uKfE7O+GoXoAhM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=hLSCYicQD78bZ64Nm5Oryz4h2YJKk9P1CSGFtpdwA9Q/kjDLNy6Ia/kPwOw2J3DCP
	 TOe0aBmSlb0JoGT6UH4KS0alpVY8b+bbYtFJ0fHtn9+I0rpXlGg8Z+PUlRjtvNgRh0
	 WgANYxj4EMk1SilfREc+NgWV9cMuSfV/Wtg4Y7nDUxJrp1WLX3jnIGlusaY7CLfN8W
	 sIopz2PFIz5WqtUfY2caUyFVy3FiyWbUNL/ejKbhxu+koTpPppKt83EB+VWwMdpZ7w
	 Tt7nJw2pbQJxURgEenWKJikJx2/3uKVqUTgwZBBV3sYfxJKpSCkQ+uFlWfFA8UCRZ6
	 QeJShupA6UZ7Q==
From: Kalle Valo <kvalo@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Isaev Ruslan <legale.legale@gmail.com>,  linux-wireless@vger.kernel.org
Subject: python nl80211 libraries?
References: <206d1b47b7ece7ccd1c371d23ae1f1c6.legale.legale@gmail.com>
	<f3ab160dd84e936134c6aa60e2f6d0fcf4d61e4c.camel@sipsolutions.net>
Date: Tue, 26 Mar 2024 08:46:17 +0200
In-Reply-To: <f3ab160dd84e936134c6aa60e2f6d0fcf4d61e4c.camel@sipsolutions.net>
	(Johannes Berg's message of "Mon, 25 Mar 2024 17:32:51 +0100")
Message-ID: <878r251oee.fsf_-_@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Berg <johannes@sipsolutions.net> writes:

> Although I suspect that what we really need is better access for tools
> from nl80211. Maybe the "JSON" output format should just dump the raw
> nl80211 message attributes that are involved, or something.

Related to this, are there any recent/decent python libraries for using
nl80211? A quick google search found these:

https://pypi.org/project/libnl3/
https://git.sipsolutions.net/pynl80211.git
https://pyroute2.org/

What do people use nowadays?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

