Return-Path: <linux-wireless+bounces-1651-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6745C82958B
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 10:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA21DB261B1
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 09:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCA136B0D;
	Wed, 10 Jan 2024 09:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIAPZcii"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649222BCE3
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jan 2024 09:00:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F081C433F1;
	Wed, 10 Jan 2024 09:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704877245;
	bh=3+z0SdPTREQrbn1cVrx7uav3ugSi/3MWwFhTgEerRc0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=AIAPZciiyosFsW9jMaaEHumvKYvJUpzavuurVmZW/zggdoRg1bA4aZGbeIEQuXkPb
	 R8eyNqsVAT9BjdDkDrl6McijKr84VXzkkKId1kPfnzFfqHxs5NUgkTQKRexQ5oJC4g
	 47NxF5X9De26V4lWR5P0VvtF/+wRkjzcGUhuYyvMHkp6eabRrNM5fZ+m4FnhW8raqY
	 RdQcYl1v11YuzP97JOKfbw0IkwFznhVqeO2CbaJ/Q6tsOWMxDwRbmmzKNr3PleiC0l
	 4ZgK/uFCPWomGO1HDj6ZP8pZXEJ8UDztF9nzm/twgQ2ZdVYSU/lmsPFqtXdD13NB2F
	 qHphwVDcfN8qg==
From: Kalle Valo <kvalo@kernel.org>
To: James Prestwood <prestwoj@gmail.com>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: ath11k and vfio-pci support
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
Date: Wed, 10 Jan 2024 11:00:42 +0200
In-Reply-To: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com> (James
	Prestwood's message of "Mon, 8 Jan 2024 05:17:15 -0800")
Message-ID: <8734v5zhol.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

+ ath11k list

James Prestwood <prestwoj@gmail.com> writes:

> For a while now I've been using vfio-pci to pass through wireless
> hardware to a Qemu VM. This makes testing kernel changes quick and
> easy compared to swapping the host kernel for reach iterative change.
> So far I've had very few issues doing this, maybe I've just been
> lucky... I tried doing this with an ath11k (WCN6855) card and ran into
> issues with the driver starting up. I'm wondering if its a
> configuration issue or just a lack of support by ath11k? The card
> works just fine when I use it on my host machine. Based on the logs it
> may not even be related to ath11k as wmi-bmof seems to fail first, but
> I'm not familiar with anything at the PCI level so I've got no idea
> whats going on.

There's a bug report about this:

https://bugzilla.kernel.org/show_bug.cgi?id=216055

But I have also no idea what is causing this, I guess we are doing
something wrong with the PCI communication? That reminds me, you could
try this in case that helps:

https://patchwork.kernel.org/project/linux-wireless/patch/20231212031914.47339-1-imguzh@gmail.com/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

