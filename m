Return-Path: <linux-wireless+bounces-6647-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4618ACC6F
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 14:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74D841C2088D
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 12:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E32E1465AB;
	Mon, 22 Apr 2024 12:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tP9jtSeh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081451465A6
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 12:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713787491; cv=none; b=dn4mOP4Zxa+KAeWOh4QOAsXmh8pjbohNqIRtbpK+IZV9gY6Fk/e0tT3721K61X1M673kHUanEezE6kRxqmmjbib4UrZgKjFMO45Vf86S6HwzzcJT+FKNe4jfBr0v4AEO3KKV1xFu24le1aZeC8m+8dc/0lJD8vSI6XYHQFWGFkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713787491; c=relaxed/simple;
	bh=LEi8KqD0QT1mRT0jXH4fKgSapV5rZlrnBHIDJq5K6Ig=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=aAMHf/mtsHPfGBaTnEk+weJHDpOESoxwHzOaLVt4pNuy2OSSBj3thJVqRDQEYzTQ3WZoGt2u8THc55o6ihFOf0hS7ESCpSSBJ5eAsDC3rl0o+K21AOp30GlKG6v8Om84j31DtKMvlNDvgaOxRbhhKx9oeNdnVivUrW9nMjNcGZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tP9jtSeh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74930C113CC;
	Mon, 22 Apr 2024 12:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713787490;
	bh=LEi8KqD0QT1mRT0jXH4fKgSapV5rZlrnBHIDJq5K6Ig=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=tP9jtSeh7zHs4pnN3EebOqPrYYI55XYr4T/a9WLwb92P28kd62/gFPr+hOuI84hfX
	 KHM0NK10+JArt/ZoKj4MiArc2fahxeAua+Q4QivS9384LC28U01wlIKjEtAkb4mYIj
	 6cwpISC565Utuua1QLgQJbwe/ubjUzORQDWd74jCjuaaRVIT6pc3PeWvB8xx0VzHpP
	 3GMszWzEUrcpLYZvETB3PJdOcuA4TpJXHiP+vXM6GA4oec3mqqwhbr+8eo6KnjrA83
	 jYz/H806d/qXZc84gCLmfiRKgeZuNAn0E6jgt/qFPZ2Q+/IBzLAH9W1krwvxP0f49/
	 9lPaVnUNEbESg==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
  <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] wifi: ath12k: Refactor data path cmem init
References: <20240409151415.1226109-1-quic_periyasa@quicinc.com>
	<20240409151415.1226109-5-quic_periyasa@quicinc.com>
	<877ch4z0z1.fsf@kernel.org>
	<6ac588c2-6206-c12e-e741-cbc507365bc3@quicinc.com>
	<823fe8a6-1e6c-49e9-a225-2012e77093ac@quicinc.com>
Date: Mon, 22 Apr 2024 15:04:47 +0300
In-Reply-To: <823fe8a6-1e6c-49e9-a225-2012e77093ac@quicinc.com> (Jeff
	Johnson's message of "Thu, 11 Apr 2024 08:20:38 -0700")
Message-ID: <87y195vc0w.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

>>>> +	default:
>>>> +		ath12k_err(ab, "invalid descriptor type %d in cmem init\n", type);
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	/* Write to PPT in CMEM */
>>>> +	for (i = start; i < end; i++)
>>>> +		ath12k_hif_write32(ab, cmem_base + ATH12K_PPT_ADDR_OFFSET(i),
>>>> + dp->spt_info[i].paddr >> ATH12K_SPT_4K_ALIGN_OFFSET);
>>>> +}
>>>
>>> Here's a good example why I don't like functions returning void. How do
>>> we handle the errors in this case?
>>>
>> 
>> sure, will handle the error case in the caller.
>> 
>
> this is a static function with one caller. the only error is the default case
> which will never be hit. adding logic to return an error and then check it in
> the caller seems like overkill. why not just WARN() in the default case since
> this would be a logic error with newly added code?

I think the software will be more robust then all errors are properly
handled in a uniform way. For example, will everyone notice the warning
message? What if the function is extended later and then the person
doesn't add any error handling "because it didn't have that even
earlier"? It's also a lot easier to review if error handling follows the
same style throughout the driver.

I didn't do any measurements but the overhead from this shouldn't be
that large, maybe few bytes in the binary and few new lines in the
source code. I think that's a reasonable price to pay from having more
robust software.

This is why I want to avoid void functions as much as possible. Of
course there also are good cases when to use void functions, like here:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=ath-next&id=6ef5b4c9598c928b3e2c4c4b543c81331941f136

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

