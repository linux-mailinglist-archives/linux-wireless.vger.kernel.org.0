Return-Path: <linux-wireless+bounces-8371-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B97898D6F40
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Jun 2024 12:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA8C61C211C7
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Jun 2024 10:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8CF27473;
	Sat,  1 Jun 2024 10:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVH8h/En"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A671103;
	Sat,  1 Jun 2024 10:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717236070; cv=none; b=Du0T967c2k/wY4OVQQ+N1du/XPH1ZyZIj4k2BNHBINxL08oGC07diDj1MNQPQJfwTXxt2/Fo6E0XFfEtmKxH5qmLxb5GECdjjr+CB92LCXVKgIvsc1NUASMgHkPc+MN0Y9OmVUkCPuKEBwdQfeEQwq9l3RBB8HgU8Ooo2Gop2H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717236070; c=relaxed/simple;
	bh=rtJKr1tGc4P6HnOWxAUbGr5jfo2EbV7oDFM7CnUbpJQ=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=cQ3BroD4Eacsk95h1qOpVl2u/G8nsmFTRpraH2JquSUwYk5wpwVv2RXAAbhTdl+LXePpLXVKMwqivwf+zbClQzRpe1EHLZWb6EfbsnPb2fjf9MMu2++jtvN/sqHC4wBxyFzmFzply1DuPohoZP9yVlalkgCLP+c7OwGSRN+EVDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVH8h/En; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6291CC116B1;
	Sat,  1 Jun 2024 10:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717236069;
	bh=rtJKr1tGc4P6HnOWxAUbGr5jfo2EbV7oDFM7CnUbpJQ=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=RVH8h/En/ddO/F3bzVjq3RENho5VfDuePwE/adxMvrP+9V8ixeL7spkykztNwY+vq
	 S3z0O3ahdOSEwaIKpQdx2LD6XeO4+gRLTXJvbEeQTeLGzzvMLXw2kU3E4vjxYwoqRw
	 bZ0GImA3nRt/7gc/ldDdbgiSaijdwpdiBWvoBqvU0KfLvmQwP7ZE1y6aJernplwgpx
	 Q/avnb8Lfgqo1XQN2YbloeNXnUZBSNvl0Frxw8Br4yoNHdyiqoMkolWfMovcHagygS
	 wPAOIzmfeBCVG4tJUtiS4A4+klRoP8GYwc/qLUVUFyxH7lNxRuAuCFWhUKPriZD+vs
	 ntX7PyLaBaMIw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless] wifi: mt76: mt7615: add missing chanctx ops
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <20240528142308.3f7db1821e68.I531135d7ad76331a50244d6d5288e14aa9668390@changeid>
References: 
 <20240528142308.3f7db1821e68.I531135d7ad76331a50244d6d5288e14aa9668390@changeid>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
 stable@vger.kernel.org, Rene Petersen <renepetersen@posteo.de>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171723606640.967328.3130657474143097660.kvalo@kernel.org>
Date: Sat,  1 Jun 2024 10:01:08 +0000 (UTC)

Johannes Berg <johannes@sipsolutions.net> wrote:

> From: Johannes Berg <johannes.berg@intel.com>
> 
> Here's another one I missed during the initial conversion,
> fix that.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Rene Petersen <renepetersen@posteo.de>
> Fixes: 0a44dfc07074 ("wifi: mac80211: simplify non-chanctx drivers")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218895
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Patch applied to wireless.git, thanks.

40cecacabc46 wifi: mt76: mt7615: add missing chanctx ops

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240528142308.3f7db1821e68.I531135d7ad76331a50244d6d5288e14aa9668390@changeid/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


