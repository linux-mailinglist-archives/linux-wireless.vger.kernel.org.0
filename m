Return-Path: <linux-wireless+bounces-16483-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC339F4F71
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 16:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC4711687CF
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 15:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABAA1F755F;
	Tue, 17 Dec 2024 15:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXmfk+g0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C1D1F6671;
	Tue, 17 Dec 2024 15:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734449257; cv=none; b=XML74kEECaR0PB2fYwSmeMiObSpcPtoG6faOY23fSR5PfVNo9Z/s5vg9l2CPNpS7c51+WVpcOFSjXJgn3BzXTYbHnP+bkkRRq8oDWoa0Virkp19f+94wpxam29J4tjA7UBP0pZ9RfNldsbwJqp3YjjWOx6LipfG+7AIZ5RVk3jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734449257; c=relaxed/simple;
	bh=X6fhOCIws3YMr58Boun0EIq/EQYH3sARWR30RF1nuik=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=jS8rLTsFBOQXa3BmvwtP0BZ7L+KQcqqN3jqQJDRG+8E6tSpXMIURetfxLES9GTN6Df3aaowD+5WIA3quhinF1kK8ajmN3nh37OC2fzrmdBm0XyjY6SnuRMp6Q2QqKuCmUk6YCrJVnitV+5k6KK+A0xd1EGiZAyOyZWXrLuggEEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXmfk+g0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CB3C4CED3;
	Tue, 17 Dec 2024 15:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734449256;
	bh=X6fhOCIws3YMr58Boun0EIq/EQYH3sARWR30RF1nuik=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=LXmfk+g0k8nqUIPgdc6P4Piy783E65cTIdYdt2UwRTum3bsO0mKgRrvqehX9pu0/e
	 4ySj1CjCMsDlwL8tstxkCoAX8EDu5MF7auqwEt8KqLhTxJpXFOnvebSPyKenK5ie/z
	 CGRsyu8lyWNfwQnt3uo6wTKWtbUNv1+d+sfcS4qL/GEa4kWB7zhJ9QKUUe5w3Xyxin
	 fpJ51Ntw/GACYvigo8wM+2QXUoZRYggiMkf9Il5VG+YoaRRWfx6uAMCY/4d+/MgNb3
	 WTk2x2EoWqV2vvy4vbnGmx9dljn1sY9hvlabxuGl4la1is9fY+eGmcs4noJDi4sx1+
	 LeV01bgvpaetw==
From: Kalle Valo <kvalo@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Jeff Johnson <jjohnson@kernel.org>,  linux-wireless@vger.kernel.org,
  ath12k@lists.infradead.org,  kernel-janitors@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] wifi: ath12k: Fix spelling mistake "requestted"
 -> "requested"
References: <20241217105505.306047-1-colin.i.king@gmail.com>
Date: Tue, 17 Dec 2024 17:27:33 +0200
In-Reply-To: <20241217105505.306047-1-colin.i.king@gmail.com> (Colin Ian
	King's message of "Tue, 17 Dec 2024 10:55:05 +0000")
Message-ID: <87pllql47u.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Colin Ian King <colin.i.king@gmail.com> writes:

> There is a spelling mistake in an ath12k_err error message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

My bad, thanks for fixing it.

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

