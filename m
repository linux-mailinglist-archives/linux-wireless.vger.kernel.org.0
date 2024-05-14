Return-Path: <linux-wireless+bounces-7641-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AFE8C5736
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 15:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A5F01F23093
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 13:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CF86D1A7;
	Tue, 14 May 2024 13:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJS4zKb1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AF955C3B
	for <linux-wireless@vger.kernel.org>; Tue, 14 May 2024 13:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715693480; cv=none; b=LQHOEr1zoiRceKQZQ1hht+4SJXNVynH3AQbXqX7hHL+8RRLZuq1t8ExIFQNac4R+T7p5KMbdq8Ca7NteW2wWepyJ4uwEQ5e3AxBpWrWN68f8ZF87MMkvsYg2MQY6d5WpnkHR3YOlnsMsZwMpq9Itw+Kx2aIWwH1HWsH1uCdRCQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715693480; c=relaxed/simple;
	bh=zRq2LDZMnpsF4mxqHnQSHAod1mCNHX+q7QGgWSI2tZ0=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=YRXvZOkWcZnxO9bcoU0zanTQ2p5gSUk78Vy3WvPqTl5ikqCZl0JcUbCo0wGN2JGqvTEUXdY02hkmChQ1odC1f7NPFyRvl+8mMyIa+ngYmNY9xubVeQ/rbii6qgndVxa7E5ZQ3jQGJxWVC1vHtcXxgDM+YCtgw8R4kAs0lEUlFPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJS4zKb1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2A1C2BD10;
	Tue, 14 May 2024 13:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715693479;
	bh=zRq2LDZMnpsF4mxqHnQSHAod1mCNHX+q7QGgWSI2tZ0=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=GJS4zKb1GIBnadD/xhTpZO0UowJ3WRStIHLclB5W0nxaW0nrUFWLo10Ux2C5g+hQb
	 S2J8CZwJsFo1cMT1dTT86OM9jUrSbdrLo2eJ8J4gMGF+5QOpfsNF91La/6ih01XH6B
	 pLC2NfFF+nwYtWGyZSCf59hNtN5MiF1/iANEdddWWv7PXF0eEjY6eYEpRD/offwDxk
	 2H4qyo1yPZiXsVh2zoEbDtcYYaNe9fVJ6LEO7D8vZSMbUGv3t469iatBtIAAJ9CzB7
	 H/NH634wCDc573xvAH2oCTWekN6vOFlt8+k/YcenfiYmcIh4lFh2uwlpKDrshEItof
	 bWCjbb9CDsIjg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: iwlegacy: do not skip frames with bad FCS
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240509101140.32664-1-batyiev@gmail.com>
References: <20240509101140.32664-1-batyiev@gmail.com>
To: Andrii Batyiev <batyiev@gmail.com>
Cc: Stanislaw Gruszka <stf_xl@wp.pl>, linux-wireless@vger.kernel.org,
 Andrii Batyiev <batyiev@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171569347689.2079576.15518027447268796061.kvalo@kernel.org>
Date: Tue, 14 May 2024 13:31:18 +0000 (UTC)

Andrii Batyiev <batyiev@gmail.com> wrote:

> Monitor/sniffer mode benefits from all types of frames, even if FCS
> check fails. But we must mark frames as such.
> 
> Tested on iwl3945 only.
> 
> Signed-off-by: Andrii Batyiev <batyiev@gmail.com>

Patch applied to wireless-next.git, thanks.

02b682d54598 wifi: iwlegacy: do not skip frames with bad FCS

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240509101140.32664-1-batyiev@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


