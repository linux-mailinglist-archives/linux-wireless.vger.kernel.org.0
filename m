Return-Path: <linux-wireless+bounces-12498-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 258AA96C470
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 18:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C50941F23AC5
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 16:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE5E1DFE37;
	Wed,  4 Sep 2024 16:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tCh7yQLu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF291DFE1F
	for <linux-wireless@vger.kernel.org>; Wed,  4 Sep 2024 16:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725468776; cv=none; b=DUOlQsQCED9tfQ8nUdKQdTpyibISTq9aNQFlVahSRg5LcnNMYaIEGoll7A9yf6eqwo03tnOcQE48GmQqi5Id3beu9zYvrqfrUXo5nN0RsJK79wfjcSPYZ7Ujxgy7JQzWVul5pMX9J2lT+teSrU7GZ0tRjfMVOrXNESHe1f5MnTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725468776; c=relaxed/simple;
	bh=Gv1gM7InFblf176mKW7MZOYTE2TiUstRbAynuNbA0BY=;
	h=From:To:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=RygKNm8GEwKw2YUQCzvGcYmEodHTa33OkX4e/ueabdTMfK3B0LN9SmosUlatEat+J/z8piZMo7WaeyXdm0v1NGTCwnUWns/UbvOHaC+PeOumtd6ViprfSpTlTYvMJFPhqiPWEKWDiBn1JThzi0drBiGdO4jRKgrmKbwE7By0Upw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tCh7yQLu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A467C4CEC5
	for <linux-wireless@vger.kernel.org>; Wed,  4 Sep 2024 16:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725468775;
	bh=Gv1gM7InFblf176mKW7MZOYTE2TiUstRbAynuNbA0BY=;
	h=From:To:Subject:References:Date:In-Reply-To:From;
	b=tCh7yQLu+/SJ6vkVxY2EscLHxNhI5RPOZz4TFTVFZ9BaaetF7z57iOnCe7LPNXNzs
	 +71ICYyv9JekO9v4w489e9v9+tNju7SqPUkqfA7ZlSNkqL3sBPVgkBI34Y3HqMxva6
	 PyDDr0jIiAsh0FKDG2DgH+btbYrzdiAQ7L+i0ZpRTsEkU7qasyfFG+QCz4360ByGl4
	 I5Tcgw3TUahH4bXy5q5Yc+ptwX4uX0V5xbsmgXHz8JmAqkjp82pmGdnv42UW6ppJF/
	 3DM0seSFWEZJTibcS8PcHdLKLsYXizkrVBhCuoO0vyAS7lSfZp4ZZNs6bc3Y7AL1kQ
	 W4Qu1CIAaqJlw==
From: Kalle Valo <kvalo@kernel.org>
To: linux-wireless@vger.kernel.org
Subject: Re: wireless-next v6.12 deadline September 9th
References: <87frqyw8p0.fsf@kernel.org>
Date: Wed, 04 Sep 2024 19:52:53 +0300
In-Reply-To: <87frqyw8p0.fsf@kernel.org> (Kalle Valo's message of "Wed, 21 Aug
	2024 12:01:47 +0300")
Message-ID: <87y147icnu.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kalle Valo <kvalo@kernel.org> writes:

> As net-next might close earlier than normal[1] I ask everyone to submit
> patches and pull requests for wireless-next by Monday September 9th.
> That way we have enough time to prepare for the last wireless-next pull
> request for v6.12.
>
> Kalle
>
> [1] https://lore.kernel.org/all/20240820113034.73448a88@kernel.org/

A reminder about the non-usual deadline, please be early :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

