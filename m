Return-Path: <linux-wireless+bounces-20798-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 423B4A6FAAC
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Mar 2025 13:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 959927A3ED1
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Mar 2025 12:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA90257429;
	Tue, 25 Mar 2025 12:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="weTchOid"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3CD1A08CA;
	Tue, 25 Mar 2025 12:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742904291; cv=none; b=XcLc0FflT4Qln5tAeezFQV8nRMukhEk/UOIonuIgiFvgxAO7xxuT7gAlbgdh/4/DFxJkpaRA0pO62CENttwbk31/8Cv3mycfNgX+TzzBn/MYqE4S05BLf5oN+YRSeDpZFpEFrweRiB0iZZl3TSmWPaOGSyZb/5SaoG8OKZj+JFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742904291; c=relaxed/simple;
	bh=zNg6WqSwfHoDXTJo4CN1g0u2BNkW0N8Jh71pNbdLExU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YN3fAhMFEZeU0OQ8Xnq/pCF3egnUDtTAcYsKX+17PMD44PlDCJYKMaP5betkkBi2YHv2Lb8HR3ohX/aPU2KkJJv/MzP0FbnrujZ4Re2CLInxA0f6/7rIxXfKZAB8UWsS3k7Umt2JlBTM+2uVok07JobJIMjx0sZL65YiFx5XCuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=weTchOid; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1742903880; bh=zNg6WqSwfHoDXTJo4CN1g0u2BNkW0N8Jh71pNbdLExU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=weTchOidfyb8Ak6zjeYUr/Bz2a7Pq36yXNE6NKAOeUsO9pU1BXLrRQVYH+4dX2ux5
	 mfZHU/ix/ugXWw2VSl1JA/K5XsvHZXJ1Nn3IZxuQ+kuDjxO18maKjYROmehlVbS19d
	 N6LOa2CLcSynqcgYFxeX1z1RjLsQOqwNcZqEV6o2K06FUzIOCYAih847bf6YTjpT+p
	 65UvtYIXOUFz4b0W5hKWE54s4pw1jAcaQNzdbaLWMoxP5MveZdCGRXrpzs9R40JlxF
	 ArkUOvvL+Q9TXBwfz5fsvrsbDLv735qSozQ0ZfwOoge3dCNOzfHQ2LGpCS5vqZ/uuT
	 KvPfDO4dZzivA==
To: Johannes Berg <johannes@sipsolutions.net>, Remi Pommarel
 <repk@triplefau.lt>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] wifi: mac80211: Update skb's NULL key in
 ieee80211_tx_h_select_key()
In-Reply-To: <cca02b859f5732d6290eaef62b0d7389c740aa59.camel@sipsolutions.net>
References: <cover.1741950009.git.repk@triplefau.lt>
 <95269f93724a94ee0b22f8107fe5b5e8f2fbea76.1741950009.git.repk@triplefau.lt>
 <754c24f1b1f7d37cb616478c57a85af18d119c21.camel@sipsolutions.net>
 <Z-Fl9OUQ1EAEWW7h@pilgrim>
 <cca02b859f5732d6290eaef62b0d7389c740aa59.camel@sipsolutions.net>
Date: Tue, 25 Mar 2025 12:57:59 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87sen1qq48.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Berg <johannes@sipsolutions.net> writes:

> On Mon, 2025-03-24 at 15:02 +0100, Remi Pommarel wrote:
>> 
>> Finding a fix tag is not easy for this case because I am not sure which
>> commit exactly introduced the issue. Is it the introduction of
>> ieee80211_handle_wake_tx_queue() (i.e. c850e31f79f0) that allows packets
>> queued on another dev to be processed or the one that introduced
>> ieee80211_tx_dequeue() (i.e.  bb42f2d13ffc) ?
>> 
>> I would have said the latter, what do you think ?
>
> I would agree, despite saying "Move ..." that called
> ieee80211_tx_h_select_key() twice, once in invoke_tx_handlers_early()
> before queueing the frame, and again in ieee80211_tx_dequeue().

Yeah, agreed :)

-Toke

