Return-Path: <linux-wireless+bounces-7635-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA1F8C4F42
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 12:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D95941C20AC4
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 10:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5011C69950;
	Tue, 14 May 2024 10:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9husjHA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C07964CCC
	for <linux-wireless@vger.kernel.org>; Tue, 14 May 2024 10:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681326; cv=none; b=brlZKvC+Z5AEF3g8TWpjioN1GTr8bySK1dDOYBmZ+XZWzLhoNbQ3bgcwBDHCVoxD+yPosUEf4e904OyoWKSoaAYEw8z+QvENyvktsc/yWr1J3ldWnFJB6ZpOsootQFfh/EFBEfr7PjscEkw/ziZu/x60TBanxk3zi+bzVDvnhrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681326; c=relaxed/simple;
	bh=MI54pPtzEeMPiR0ZUoW6r5WSTm6j3VMEAjvtzTA5p44=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=qKW8UoThSg+09iPgb9wHgLGcGQYF9cpTcmWXKUO5pWyTgTakUcjNMUZxlYf4zTwlzlefRu/i9qezkvWDH97Ot19Aba655hgg+f2a26ZiNj6ZtcBljzFc33q/cv8Qc9s0LyO3uaLl7hbStlALPl4NZDI4Ig6kDd2fMcvmLNNjyVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9husjHA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0707C2BD10;
	Tue, 14 May 2024 10:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715681325;
	bh=MI54pPtzEeMPiR0ZUoW6r5WSTm6j3VMEAjvtzTA5p44=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=G9husjHAbwFKNS9ot5SS5OXWNpv2Wh8cJFOMWAXyQBKauuamd08KdxZH7+KcWFdEb
	 A6sTEZLezFO/cyFb/VnN6O/lGJdGSdrGCwAO8tn9h7L5bSgmlAj4h1gmpW4r5qIlhz
	 /nr15yCeZdXDM7iio3zRZ9UK/Y2X67aL2P8uZNs4eYBxCy+TpAHN0hgFwXjBpRh9dh
	 EUt6ufIeZNCVBcwHhu3lCnnge+JlJGHQypOJRdi2YqqSd5D2KsVT/VGtYQul/hCQce
	 40Ni3ymhpHTMN4u9ZD1VfUD8kLE0tC85IXJVl2BwytsJD18okaK2b97fD4svFtxFM3
	 Ym0Dknr6OHmnQ==
From: Kalle Valo <kvalo@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,  Andrei Otcheretianski
 <andrei.otcheretianski@intel.com>,  Miriam Rachel Korenblit
 <miriam.rachel.korenblit@intel.com>
Subject: Re: [PATCH] wifi: mac80211: RX auth frames on P2P device
References: <20240510113346.8c5b8d1f2f8d.Ib3074ffbe7b296e0f162b2543e84346b190dfbeb@changeid>
Date: Tue, 14 May 2024 13:08:42 +0300
In-Reply-To: <20240510113346.8c5b8d1f2f8d.Ib3074ffbe7b296e0f162b2543e84346b190dfbeb@changeid>
	(Johannes Berg's message of "Fri, 10 May 2024 11:33:47 +0200")
Message-ID: <878r0cemdx.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Berg <johannes@sipsolutions.net> writes:

> From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
>
> This is needed for PASN based P2P pairing.
>
> Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
> Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

The commit message is not really telling much, is the title missing a
verb or something?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

