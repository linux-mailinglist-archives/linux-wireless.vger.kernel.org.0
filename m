Return-Path: <linux-wireless+bounces-6763-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A974D8B066B
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 11:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EE021F2384C
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 09:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6622158DC1;
	Wed, 24 Apr 2024 09:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llcj1PHG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05FE1E4A9
	for <linux-wireless@vger.kernel.org>; Wed, 24 Apr 2024 09:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713952231; cv=none; b=lYq5WRsayx3JD5gd1t2lLC3TyMJVvevyYJ3reJzHJ2VpU3yHGaH3tf1c5Bs1vAZ8w/GAnl3uBA9HLIpEp3tNjk5gvA/+kGDVXbZpf6Gpffc1By+BThlCygk/GHoJz3K1ZIOhb59o9n0s1pcZvgNGCEQPeHXXbpXd7lveXs3SjaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713952231; c=relaxed/simple;
	bh=ZgfWCv5rt80c3R+V8piEBul82k/vEs/F7mBFn4S+wkw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=QQBKXJZsLiKGN8L+aBLrSuUcinA1kEhRmDL8YqHve/JFBihjhe0475RfI1TZr/lwX1PGCjqZlefSQLDtI4VMyvfpqRu+YYd/TU4fSAOgFZNowHAhOHLPgNR9d7ExfNvlYxajQAR6DVpWUYRPksP5L4gAwX50ToPQMtDlctstHvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llcj1PHG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E43C113CE;
	Wed, 24 Apr 2024 09:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713952231;
	bh=ZgfWCv5rt80c3R+V8piEBul82k/vEs/F7mBFn4S+wkw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=llcj1PHGQFl1TegzZ1jT8kMTyxj4uiHiuqqxKXlub/wKhhTO5qDQf1d/oWmc1vtEm
	 vr4uefpCgCDESei1wzG8fh16xyVSRCpOdqDucEnwxohZq+BCBMgn40MgSt3F+McMn/
	 jCakuyskNLNiuWmLOkrUKnxmk9M607mZWVRuQa6h2z2I6ACZhqayCOqTWbp/Csb/1l
	 +TFtYzu2Pr2IOhsPs7zNNBr+HtJWWci8soVosb6XpWgssVi2YI9neyJjALY3t11ybK
	 n1IGyTYPKdeuihY9ckOtD1BaEom/hs4L+edVg8kyNQoy2v/RFK+RRzrGnzMlkeDlyY
	 jKbiKW75HAq0g==
From: Kalle Valo <kvalo@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
  ath12k@lists.infradead.org,  linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 3/3] wifi: ath12k: Add lock to protect the hardware
 state
References: <20240424065646.1666166-1-quic_periyasa@quicinc.com>
	<20240424065646.1666166-4-quic_periyasa@quicinc.com>
	<517caf852d37b3803bcf087a6b575f2ecdb5ba10.camel@sipsolutions.net>
	<87il07t7zq.fsf@kernel.org>
	<3dc4339f5c3f603027c2214058e7e3251652a7f0.camel@sipsolutions.net>
Date: Wed, 24 Apr 2024 12:50:27 +0300
In-Reply-To: <3dc4339f5c3f603027c2214058e7e3251652a7f0.camel@sipsolutions.net>
	(Johannes Berg's message of "Wed, 24 Apr 2024 11:43:58 +0200")
Message-ID: <87edavt7h8.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Berg <johannes@sipsolutions.net> writes:

> On Wed, 2024-04-24 at 12:39 +0300, Kalle Valo wrote:
>> 
>> Exactly. Swithing to use wiphy_lock() definitely one of my longterm
>> goals in ath12k. I already started working on switching ath12k to use
>> wiphy_lock() but IIRC I got blocked by not being able to call
>> wiphy_delayed_work_cancel() without taking wiphy_lock.
>
> That's because I didn't want to have an async version, but theoretically
> we could have a version of it that just cancels the timer. If you don't
> hold the wiphy mutex already you could even wait for it to finish. It
> just adds more complexity there, and I was trying to make it all a lot
> more obvious :)

Yeah, understandable. I think changing ath12k WMI event handling to use
wiphy_work makes sense, running them in tasklet context feels overkill.
I just need to write the patch :) But after that I hope we can switch to
using wiphy mutex.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

