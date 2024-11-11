Return-Path: <linux-wireless+bounces-15189-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 728AE9C44EB
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 19:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A6F31F221C3
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 18:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE49414EC55;
	Mon, 11 Nov 2024 18:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="hDBhFv2/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E1F450EE
	for <linux-wireless@vger.kernel.org>; Mon, 11 Nov 2024 18:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731349557; cv=none; b=re624fubvkzo7g5Z4x11LcQXj/nbsXPli2+0UBGgE7cH9huhBJ0t7PHJ0pXuKPigWg9G2NOa17WSHPAdEvw1FsKbIV+CCha0ul1Fy13WbHr4/pRevH9NOHQGBJzrImREZCtw1DQpF223JmQnXtBBh9GkGpSZ+1P/e1hJEDcTois=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731349557; c=relaxed/simple;
	bh=vTo6T3XavLxH7ZTOyjAvle/VfQOddRVJxAFO1HtVIbE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t0zLAR+05Keo97MZ7Nk+HGtS/Z+DuOaaZYGoML1k4N74WVTZjoByvd/RxSWs9DgdGnohY51WYHcELO9jTaB64pYzpQWuAWa1wACv0DVVZzJwrHQ65ATlJKIun7ixiEeTi9E6v8Mm+IlCbOLY6M4TlCcEcN3oEEirpnVU0DMRVwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=hDBhFv2/; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1731349548; bh=vTo6T3XavLxH7ZTOyjAvle/VfQOddRVJxAFO1HtVIbE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hDBhFv2/upl+0hxswO+lEn5RPg4yy3hHfk1A9jpSY1Sf39mx/ojreNgosm0djfHmC
	 bOZrpUTwAePCbsKgdjIktCEnu4mfw89gZ6KmdbMgIyRB+/6Pl1RVHeQ9zagy3MroNW
	 +TtZCQMQw6fi8i5S13RE9guTvvLyoYA/EYXxLoURAf0solg0yXoMJG3/OfY9wJJ1c9
	 9/gguSXDRAXEBVconamsQtbWejbhjt8knISCEkc5qjGTwqzA1UzXYs2bVj1iaQ2QnE
	 aCyhMchgIy1EWTQ+68Nh5C4m+/S7B6ImgtlWhDwf7hA416K5xk8rEXHpaKqjPq3erS
	 6Eo+Dq+obpV4g==
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Dmitry Antipov
 <dmantipov@yandex.ru>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] wifi: ath9k: miscellaneous spelling fixes
In-Reply-To: <a5503b65-2722-467a-8bee-0130b3807a4a@quicinc.com>
References: <87frny5bcl.fsf@toke.dk>
 <20241111104724.484586-1-dmantipov@yandex.ru>
 <a5503b65-2722-467a-8bee-0130b3807a4a@quicinc.com>
Date: Mon, 11 Nov 2024 19:25:48 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87ttcd4ogj.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 11/11/2024 2:47 AM, Dmitry Antipov wrote:
>> Correct spelling here and there as suggested by codespell.
>> 
>> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
>> ---
> ...
>> @@ -747,7 +747,7 @@ int ar9003_mci_end_reset(struct ath_hw *ah, struct ath9k_channel *chan,
>>  	 * BT is sleeping. Check if BT wakes up during
>>  	 * WLAN calibration. If BT wakes up during
>>  	 * WLAN calibration, need to go through all
>> -	 * message exchanges again and recal.
>> +	 * message exchanges again and recall.
>
> this one is incorrect. recal in this context is an abbreviation for recalibrate.

Ah, nice catch!

> I'll s/recall/recalibrate/ in ath/pending

Thanks!

-Toke

