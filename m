Return-Path: <linux-wireless+bounces-3551-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A70853479
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 16:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD4F1B23265
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 15:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324305A7B7;
	Tue, 13 Feb 2024 15:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npXGlbWA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF5855C39
	for <linux-wireless@vger.kernel.org>; Tue, 13 Feb 2024 15:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707837780; cv=none; b=snTY/QM2TmxiUJyIGyIbzIIEyFu6Y6ZEhlGXQRVFro4yG3PauQjT39JFtfblmDGtikCEnD07CvehiE/fyHXhhpS+SZqr+mJFUdKu3ERN9NNWKEWPutFuRPRHfnrv+4CHY9Wz1P9jSKJRDXy45F1GUGzSStQ7BuSDHFZZpcRsjlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707837780; c=relaxed/simple;
	bh=T3zWkYJB6TH8eWBtz/OZluFWQRVFkS3TMCW/3gKsuEk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=tyJlPphcVqwTTXiVwW9RCUG1IMRx3MF1MAbp017v6LVB/KiNF0ABrigJKFWJ8jDa1ZpqTK/5SGQktS5ObNuV0hRB9hLpdUHeBSY/MEbZuf9X8tdEVyLAiKyTFpCcvvYZ7i2Gh7FtQCuVzg83vM4VB1XlqhRjiGqla2uNEGVhW5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npXGlbWA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0838C433F1;
	Tue, 13 Feb 2024 15:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707837779;
	bh=T3zWkYJB6TH8eWBtz/OZluFWQRVFkS3TMCW/3gKsuEk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=npXGlbWA04duFep92GjgC8Eke/LaEHok4NuKuOwuVoAZth7+j0WRuW3zsDEEkBz61
	 i1uI61CM57YVcRngVLZS3BMoq3HhFeQqK0CMeH/YAoaJ/9VEsdHqq51uKDPfsQa87o
	 gczrjs5LrYP0FWKjivXcRaq+mGWSvwERfjm88FTpGDwyqJmsoGaElmaQ5ScSz4rKZZ
	 LxnLa3YApHN5mwzOAdTIpgmU4VG8Wv9Gt2QR3qJpl7WVqja6SHI7LBbTCB7NjQZr7I
	 eIZvAEYHfDmo86K/mQKqWT1h+ISWAymoF8FCJ4MEHvpcEnZXfqSgwQ50okFrFjoi3C
	 dZcgS/7f60MpA==
From: Kalle Valo <kvalo@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
  "johannes.berg@intel.com" <johannes.berg@intel.com>
Subject: Re: [PATCH] wifi: rtw89: fw: remove unnecessary rcu_read_unlock()
 for punctured
References: <20240213122556.9593-1-pkshih@realtek.com>
	<87ttmced8l.fsf@kernel.org>
	<f8b28bf1f735432489c1674d62fc68a8cf475ee8.camel@realtek.com>
Date: Tue, 13 Feb 2024 17:22:56 +0200
In-Reply-To: <f8b28bf1f735432489c1674d62fc68a8cf475ee8.camel@realtek.com>
	(Ping-Ke Shih's message of "Tue, 13 Feb 2024 13:43:46 +0000")
Message-ID: <874jecpewf.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> writes:

>> This again shows how important it is to fix all the remainging sparse
>> warnings in wireless code so that we don't miss important warnings like
>> this. If there just would be a way to get the cleanup patch submitters
>> to fix the sparse warnings, sigh.
>
> In short term, can we record the count of warnings and ensure it
> doesn't increase while new commits are getting merged? 

Netdev has that kind of checks in checkpatch:

netdev/build_allmodconfig_warn	success	Errors and warnings before: 993 this patch: 992

https://patchwork.kernel.org/project/netdevbpf/patch/20240213112122.404045-2-leitao@debian.org/

But in wireless project we have not set up that. That reminds me that I
need to reply to Jakub's email related to this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

