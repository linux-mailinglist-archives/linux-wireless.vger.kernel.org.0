Return-Path: <linux-wireless+bounces-1870-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9AE82CA4D
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jan 2024 07:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D28351C2171E
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jan 2024 06:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EED918EBE;
	Sat, 13 Jan 2024 06:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPH0Ec6Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0561D18EBF
	for <linux-wireless@vger.kernel.org>; Sat, 13 Jan 2024 06:54:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7516BC433C7;
	Sat, 13 Jan 2024 06:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705128893;
	bh=bxmZhWWVppfZyW25Xz78Kjm2HzG4tyaFtHGTkKRMwfE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=FPH0Ec6YKWgDy5+1LJyUyxTbc1pf7bunHlYORLwQCOqxe21WyNM16VZnl7353Qstm
	 nMskFVyaIIaqEJBNkUyDxTGsGEMvQoJh+yC0eFhTlOw69E3ZVVVd/910OJ8XIQ422h
	 r8dJV1z2r4HUvp4C9SgGHHRTDH+nMXtU5pbfBucgDdAyHlB5qll95pJnDNazKLBJzP
	 l8DyBvAcpf1Oob8zaL1OKqP65QsnjYsxLyHws36siQ5HljqrafsE7F6/9zTKSieNsR
	 AOa54gXb18LOTLrTa0HGYfHRw5q9QD2vCsHQwGepk2TSlDwF93jOrY+tTe5uRAcCol
	 xDe8RRExJrN2g==
From: Kalle Valo <kvalo@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
  linux-wireless@vger.kernel.org,  Gregory Greenman
 <gregory.greenman@intel.com>
Subject: Re: [PATCH 5/8] wifi: mac80211: disallow drivers with HT wider than HE
References: <20240111161746.3978601-1-miriam.rachel.korenblit@intel.com>
	<20240111181514.da15fe3214d2.I4df51ad2f4c844615c168bf9bdb498925b3c77d4@changeid>
	<87wmsehf3d.fsf@kernel.org>
	<aae05a63171cf0f3c81dedc24d3b0a558ce530f5.camel@sipsolutions.net>
Date: Sat, 13 Jan 2024 08:54:50 +0200
In-Reply-To: <aae05a63171cf0f3c81dedc24d3b0a558ce530f5.camel@sipsolutions.net>
	(Johannes Berg's message of "Fri, 12 Jan 2024 19:42:27 +0100")
Message-ID: <87h6jhhged.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Berg <johannes@sipsolutions.net> writes:

> On Fri, 2024-01-12 at 15:10 +0200, Kalle Valo wrote:
>> Miri Korenblit <miriam.rachel.korenblit@intel.com> writes:
>> 
>> > +			/* currently no support for HE client where HT has 40 MHz but not HT */
>> > +			if (iftd->he_cap.has_he &&
>> > +			    iftd->types_mask & (BIT(NL80211_IFTYPE_STATION) |
>> > +						BIT(NL80211_IFTYPE_P2P_CLIENT)) &&
>> > +			    sband->ht_cap.ht_supported &&
>> > +			    sband->ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 &&
>> > +			    !(iftd->he_cap.he_cap_elem.phy_cap_info[0] & he_40_mhz_cap))
>> > +				return -EINVAL;
>> 
>> Should there be a warning message so that this is noticed if it ever
>> happens? I don't know.
>
> Yeah I don't really know either. I've done that a lot in the past, but
> these days I'm kind of thinking that people who develop their drivers
> should have some debug story and be able to figure it out? You know
> better perhaps ...

My worry here is the time needed to figure this all out. Especially if
we have more of these kind silent checks it could get complex quite
quick.

> Though it'd kind of suck to indent this further with WARN_ON ;-)

Yeah, WARN_ON() feels a bit too much. I was more thinking about a small
pr_err() or something like that which give at least some hint what's
happening.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

