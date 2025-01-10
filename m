Return-Path: <linux-wireless+bounces-17318-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C865A0906F
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 13:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B17B188EB91
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 12:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D2C20E33F;
	Fri, 10 Jan 2025 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVEc+R2J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DDD20E6E6
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736512119; cv=none; b=OhUchUgIdJW3E/n2OgMMRv6gF/WFBKMVwV1rZvLW0YJCgJsCH9Vheh9fH0NHIjFxvPoVmcgG94KFIAmCwgnFHw241v7hCnO0EyottBvc6Q1pNSSr01CMy/bwh9m60AngaeiT7/yA18Yasvzw90YuGlWuksIVQJTLObUvNjQV16w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736512119; c=relaxed/simple;
	bh=fFU+KELsOlSeFgOoShwCsHprcd4LKutco8qjr9j8o2g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YVP2otfq2a/G4k9pPYQa29IPxdmb7GDobRILMKq+B87Z8KkQm9hvuaQ1WHqX6Brij9M0GTBzUZ/rObO7ekG+AaEgOcvB+wanpYzzt2xga0hExORxp2ceqaz8jh7eXLCz+O396uCl+Y/e9qIxLJb9Fwl/GUrFr8crAgZ17TDZhZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVEc+R2J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F6B9C4CED6;
	Fri, 10 Jan 2025 12:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736512119;
	bh=fFU+KELsOlSeFgOoShwCsHprcd4LKutco8qjr9j8o2g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bVEc+R2JrzQSfEksFMdQpzaDFa5j4HzW5xMdbRGqwxqnNKQ5WWFYzf3ln/8jpVtWo
	 AeEiGRGjRgGDKx92oLFBHEbTf8UzGnKh39LioVxkud+h1Yy6Y0RHE8D6AAspHaJGtk
	 dGTsYa/idgAtWH4FhsZ7k9uIRWcd0LXOvGJ3GH4B7/bwSLqxFADqJlnE2mJHVPEVNk
	 tP4qZKh4rTlUqtKPFnSSTN+Fi+qXT/oMuaUoxxQTK6khtfjikVxEWtzqMk4MrZCl/W
	 coxcr6nfS8T7JaQsnQRoUOU8T7GhgeHpzKq0Tvo4rPOB0RJwcvMHCmhLw7iJNIKnSd
	 dc7WFSFStS1SQ==
From: Kalle Valo <kvalo@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Jeff Johnson <jjohnson@kernel.org>,  linux-wireless@vger.kernel.org,
  lvc-project@linuxtesting.org,  Fedor Pchelkin <pchelkin@ispras.ru>,
    ath10k@lists.infradead.org
Subject: Re: [PATCH] wifi: ath10k: add extra output check in
 ath10k_wmi_event_debug_print()
In-Reply-To: <20250110115024.1497597-1-dmantipov@yandex.ru> (Dmitry Antipov's
	message of "Fri, 10 Jan 2025 14:50:24 +0300")
References: <20250110115024.1497597-1-dmantipov@yandex.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Fri, 10 Jan 2025 14:28:36 +0200
Message-ID: <87ed1asvij.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dmitry Antipov <dmantipov@yandex.ru> writes:

> In 'ath10k_wmi_event_debug_print()', passing skb of the very weird
> layout may produce debug output of the zero length. In such a case,
> 'if (skb->data[i - 1] == '\n')' will trigger an access beyond skb data
> boundaries. So fix this by adding an extra check whether at least one
> byte of the debug output was really emitted. Compile tested only.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Suggested-by: Fedor Pchelkin <pchelkin@ispras.ru>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Adding ath10k list.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

