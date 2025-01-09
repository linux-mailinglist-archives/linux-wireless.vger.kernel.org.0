Return-Path: <linux-wireless+bounces-17229-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA781A06E29
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 07:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9A167A2C0A
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 06:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946237E0E8;
	Thu,  9 Jan 2025 06:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZlnsQXH3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9AF19BBA
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jan 2025 06:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736403694; cv=none; b=mRmLuOGKFEYQcWpRxBrjQa4ZfE/iMqZA9cW10gaiKqNchxSQB+TWF0V99qE5c/QSd1qfzdPvVlyJBE0AwsWhy4RKy8m81i2l8ecQw1r1I/gxFoCpXucFkFOtrR0r01/OJtpRQU3QxejyuIaZkRuKjecG3N/0rbZ/fPh34Wwdubc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736403694; c=relaxed/simple;
	bh=7PppcD8YUSLHlXIYSjmuqkpPVW38HBYdV3c8U455hGE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=dHZ+t/aUFP74xEKD19EYO7pJMRYobtMEk4d2vam42s2lBjtObJUMiYdc2Z4/YWstUMfo78PmksTCxV+hjr6fNxTOFGHHj0HOxfnKxjAesSZH4CCw8d752HBiSINvhH4kVhBBJYIJZN/kjYASs3Hquu3Q8GgixdcXP65Tbsiy1H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZlnsQXH3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B02C4CED2;
	Thu,  9 Jan 2025 06:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736403693;
	bh=7PppcD8YUSLHlXIYSjmuqkpPVW38HBYdV3c8U455hGE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=ZlnsQXH3XDiJ2o1CMvX1InNstCLK+XFHzh9fo4wxjFlpPrWRMKLge/NwpFNROwv6x
	 gAUJUl+Pa/WBnBzB7dV+vYD8wzDo6FFAcqiUmwOgY/4JSO4ZRtp4gC5ozE6RE2RhC/
	 snSwd71/tgircxeF4VAzlCQwKOHxHosJOITkOjMpZ0r47LfrP69kzi8tPev/FCH0Lh
	 /g5KxTMd4TxL5rgUPtrGJVaO8DTaw5xIeBQemnrk44E+sC34/q5JIUkDa3Y6t7de9I
	 odC/tkWB9E/8aaOML07jvxRfkbbtDONJHGUq1eOuEwB8paD+PagiCQATX24Z+M3duJ
	 emqfRtzbXBWRw==
From: Kalle Valo <kvalo@kernel.org>
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH 12/15] wifi: iwlwifi: pcie: Add support for new device ids
References: <20241226154456.473690-1-miriam.rachel.korenblit@intel.com>
	<20241226174257.6a0db60436e7.I50a66544dde6c88acd9abe4b31badab96ef04cfc@changeid>
	<878qrlqrry.fsf@kernel.org>
	<MW5PR11MB5810C851A45E62BE7A1B6A66A3122@MW5PR11MB5810.namprd11.prod.outlook.com>
Date: Thu, 09 Jan 2025 08:21:31 +0200
In-Reply-To: <MW5PR11MB5810C851A45E62BE7A1B6A66A3122@MW5PR11MB5810.namprd11.prod.outlook.com>
	(Miriam Rachel Korenblit's message of "Wed, 8 Jan 2025 18:50:23
	+0000")
Message-ID: <87msg0pkwk.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

(adding back linux-wireless)

"Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com> writes:

>> -----Original Message-----
>> From: Kalle Valo <kvalo@kernel.org>
>> Sent: Wednesday, 8 January 2025 16:55
>> To: Korenblit, Miriam Rachel <miriam.rachel.korenblit@intel.com>
>> Cc: johannes@sipsolutions.net; linux-wireless@vger.kernel.org;
>> Puttagangaiah, Somashekhar <somashekhar.puttagangaiah@intel.com>;
>> Berg, Johannes <johannes.berg@intel.com>
>> Subject: Re: [PATCH 12/15] wifi: iwlwifi: pcie: Add support for new device ids
>> 
>> Miri Korenblit <miriam.rachel.korenblit@intel.com> writes:
>> 
>> > From: "Somashekhar(Som)" <somashekhar.puttagangaiah@intel.com>
>> >
>> > Add support for new device-ids 0x2730 and 0x272F.
>> >
>> > Signed-off-by: Somashekhar(Som)
>> <somashekhar.puttagangaiah@intel.com>
>> 
>> Is the name in From and s-o-b really correct?
>
> yes

So Somashekhar really signs all legal documents just with
"Somashekhar(Som)"? And is Som a nickname or something? We don't add
nick names to From and s-o-b, only full names used in official
documents.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

