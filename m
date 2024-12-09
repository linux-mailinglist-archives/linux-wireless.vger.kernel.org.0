Return-Path: <linux-wireless+bounces-16039-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EA19E9482
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 13:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FD691887A40
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 12:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A9D22371C;
	Mon,  9 Dec 2024 12:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvKX0PSS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B036321E0BE;
	Mon,  9 Dec 2024 12:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733748015; cv=none; b=kn8VyxXLrCevohqjeS5SYC0ihsLJCUuyxA13aPfKTlTEEbYTrQia4FEyR5vQEWO2gMYU/zO2wNL3EEPq3S3Hlu4IIc6hZVHcq/BKVXuzx8XUiU4dVDIc0Gj0+mYuP6GRg836h/EPHRcdPlBr6C2hsNknxKAO/yy42r6uyUDKL2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733748015; c=relaxed/simple;
	bh=0mvBxn0PSgu6FsrYzgn8Ezm4CL9y/d3xpE2xs78uGIc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Oz5NKlQHNr1KwSgxUbaz2IeMnLpA5L0HFraUIQya7YQOmdGBJsuV13/grjouPy/TUUVxea0P9TKTZ1sFs6F8s1BRp4l/C1HjcgWHOoOjVF0vtqXiHgzu677HVHKbjWegONqWK4tBaUkwqa/gWk8L1b3ryQtnd+pKhYs3Q8Kqp7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvKX0PSS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B271C4CED1;
	Mon,  9 Dec 2024 12:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733748015;
	bh=0mvBxn0PSgu6FsrYzgn8Ezm4CL9y/d3xpE2xs78uGIc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=DvKX0PSSLEL7SzgRIFSjtJnTkDB+faBBGcovuhW2QCWLjthDYv0xCKQ9i/JhKK7NL
	 RuUXsQvFItOVdv5YTFk5qjZiWrmUfZjbJr7LbZhUTuDuqpaQZlj0laXNSkwM49KiGJ
	 +xTgITS+ALwCcaIL+hSC7/eYLCx+q2hZlO7YIKRBlnRevXIeVtTwBeoak0a+VieG4Y
	 YLYQT4+USZ9++lEbMsAowxhEOo60/uJ2qHZgZqRmqYAF4cnQ1yZH9ZvnKRvAiEgX/R
	 RGlJvl/PS+kQW+3KFLCn6LTqHIY8pSTEPmH9J9s9pwXcdVpj9qE5yj8+NV0CwKSnNK
	 6Q2hNQcy62axQ==
From: Kalle Valo <kvalo@kernel.org>
To: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Cc: ath12k@lists.infradead.org,  jjohnson@kernel.org,
  linux-wireless@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 wireless-next] wifi: ath12k: Fix out-of-bounds read
 in ath12k_mac_vdev_create
References: <20241207071306.325641-1-dheeraj.linuxdev@gmail.com>
Date: Mon, 09 Dec 2024 14:40:12 +0200
In-Reply-To: <20241207071306.325641-1-dheeraj.linuxdev@gmail.com> (Dheeraj
	Reddy Jonnalagadda's message of "Sat, 7 Dec 2024 12:43:06 +0530")
Message-ID: <87r06hrpw3.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com> writes:

> Add a bounds check to ath12k_mac_vdev_create() to prevent an out-of-bounds
> read in the vif->link_conf array. The function uses link_id, derived from
> arvif->link_id, to index the array. When link_id equals 15, the index
> exceeds the bounds of the array, which contains only 15 elements.
>
> This issue occurs in the following code branch:
>
>     if (arvif->link_id == ATH12K_DEFAULT_SCAN_LINK && vif->valid_links)
>         link_id = ffs(vif->valid_links) - 1;
>     else
>         link_id = arvif->link_id;
>
> When the first condition in the if statement is true and the second
> condition is false, it implies that arvif->link_id equals 15 and
> the else branch is taken, where link_id is set to 15, causing an
> out-of-bounds access when vif->link_conf array is read using link_id
> as index.
>
> Add a check to ensure that link_id does not exceed the valid range of the
> vif->link_conf array. Log a warning and return -EINVAL if the check fails
> to prevent undefined behavior.
>
> Changelog:
>
> v2:
> 	- Updated the commit message as per the reviewer's suggestions
> 	- Clarified the description of the bug in the commit message
> 	- Added Fixes and Closes tags with relevant information
>
> Fixes: 90570ba4610 ("wifi: ath12k: do not return invalid link id for scan link")
> Closes: https://scan7.scan.coverity.com/#/project-view/52337/11354?selectedIssue=1602214
>
> Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
> ---

In wireless we prefer to have changelog after the '---' line so it's not
included in git. Not sure if Jeff can fix this during commit or not.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

