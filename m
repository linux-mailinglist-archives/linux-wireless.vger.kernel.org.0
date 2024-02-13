Return-Path: <linux-wireless+bounces-3536-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E43D28530EF
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 13:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2889B283002
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 12:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9277340BFE;
	Tue, 13 Feb 2024 12:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t9I7BxEG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691FF3FE47;
	Tue, 13 Feb 2024 12:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707828634; cv=none; b=Dj93mBBSgtgmSOsXSgUmMjmVlpc2QE71MCwh3fKMAL2Is40dCM8vnewZpKhsifgBFSq693elFEG2gFwAvmUg9WtVon7n7iWOlAdfwDz0FKNtcERXOKZoOnDoL/8jCvb75QD/CVUybCnyT8q3bfdtDPLLUicv4YQYIJy7su98wmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707828634; c=relaxed/simple;
	bh=OW5tEdpRIbVny8tlbkMpyNRX41FPqyqm6ItiVEchB+M=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Nh/8eIo4zz22xyfNLcLiW+oYxUc3mKAVtpn+pmQev8nPYxqFMrLTz5MWtcOlv+RWcjSPx7/1QA992wdlC2uDINo+AoHdAyZzrwS7Cl2ETn6HCnkbzXSBmu7tZod4mhUTM6anbs3oSJS0xjaHe3MVq2iwIltc/O4K+qhhlbkLwog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t9I7BxEG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7716BC433C7;
	Tue, 13 Feb 2024 12:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707828633;
	bh=OW5tEdpRIbVny8tlbkMpyNRX41FPqyqm6ItiVEchB+M=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=t9I7BxEGsmQ7vLJ/W5RIFRgC+StvhiKFQNbEcMa05WA+svOVRgaUZYmmFmXqC9ZWm
	 kb3HBKaJtWo05t8ThRY+jHG9eg6EkK2jSBImEGq3baFWVuve9IMuBiP0ml7YFt5oQS
	 gXM0riEa3iA3o/yBWWhbgITk5t07G7lH36YaUbhJACrDtG4ye3Fm2axA8t1G3lu1lu
	 19k8Xjwywlm0NsrWMfV6qk74xIX5tvd3iubbTN7lj6VK04rv4nJMM9N6rCs2j/xSwZ
	 Byv6IavrruV9L5u4gPxJJKt91YQmmvyuIv93OWrF58tvSt7/gvOttxQAf3cBvxsaUp
	 NoO4TkMTqUjRA==
From: Kalle Valo <kvalo@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,  Vinayak Yadawad
 <vinayak.yadawad@broadcom.com>,  linux-wireless@vger.kernel.org,
  jithu.jance@broadcom.com,  netdev@vger.kernel.org,  Jakub Kicinski
 <kuba@kernel.org>
Subject: Re: [PATCH 1/1] wifi: nl80211: Add support for plumbing SAE groups
 to driver
References: <309965e8ef4d220053ca7e6bd34393f892ea1bb8.1707486287.git.vinayak.yadawad@broadcom.com>
	<87mss6f8jh.fsf@kernel.org>
	<2c38eaed47808a076b6986412f92bb955b0599c3.camel@sipsolutions.net>
	<b4d44fb5-78e5-4408-a108-2c3d340b090e@broadcom.com>
	<b00c3b53cd740e998163f84511ee05dc3051ce8b.camel@sipsolutions.net>
	<df8f02b1-25b0-4dae-a935-cee9ba7f3dc4@broadcom.com>
	<0cb1d7ef63ad1ea1ff4109d85a6bcdcaca16f1c8.camel@sipsolutions.net>
	<6eaab8fa-f62e-4f78-9cbe-9b13e3d77ca7@broadcom.com>
	<ca517fb19f78e3c507fd315e2f30e5efa4723eb8.camel@sipsolutions.net>
Date: Tue, 13 Feb 2024 14:50:30 +0200
In-Reply-To: <ca517fb19f78e3c507fd315e2f30e5efa4723eb8.camel@sipsolutions.net>
	(Johannes Berg's message of "Tue, 13 Feb 2024 13:30:31 +0100")
Message-ID: <87y1boedex.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Berg <johannes@sipsolutions.net> writes:

> On Tue, 2024-02-13 at 13:19 +0100, Arend van Spriel wrote:
>
>> On 2/13/2024 12:45 PM, Johannes Berg wrote:
>> > On Tue, 2024-02-13 at 12:13 +0100, Arend van Spriel wrote:
>> > > 
>> > > I recall the rule was that nl80211 API changes
>> > > should also have at least one driver implementing it. Guess we let that
>> > > slip a couple of times. I fully agree enforcing this.
>> > 
>> > Well, enforcing it strictly never really worked all that well in
>> > practice, since you don't necessarily want to have a complex driver
>> > implementation while hashing out the API, and the API fundamentally has
>> > to come first.
>> > 
>> > So in a sense it comes down to trust, and that people will actually
>> > follow up with implementations. And yeah, plans can change and you end
>> > up not really supporting everything that was defined ... that's life, I
>> > guess.
>> > 
>> > But the mode here seems to be that there's not even any _intent_ to do
>> > that?
>> > 
>> > I guess we could hash out the API, review the patches, and then _not_
>> > apply them until a driver is ready? So the first round of reviews would
>> > still come with API only, but once that settles we don't actually merge
>> > it immediately, unlike normally where we merge a patch we've reviewed?
>> > And then if whoever did it lost interest, we already have a reviewed
>> > version for anyone else who might need it?
>> 
>> Sounds like a plan. Maybe they can get a separate state in patchwork and 
>> let them sit there for grabs.
>
> I guess I can leave them open as 'under review' or something? Not sure
> we can add other states.

I belong to the church of 'Clean Inbox' so I use 'Deferred' state for
stuff I can't work on right now. Though I know a lot of people don't
like it because deferred patches are not shown in the default patchwok
view.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

