Return-Path: <linux-wireless+bounces-16377-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E10B9F0CAC
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 13:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B940160470
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 12:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AA01A0AF7;
	Fri, 13 Dec 2024 12:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d92VN0eo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE03423C9;
	Fri, 13 Dec 2024 12:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734094105; cv=none; b=R2IDnZk6S1fxvnBpT9EGgRAzJz/D2isYhQF5/V2VkuOeL/V1iqVVA+RARgr/JJ3bk2Bd9zZWoHArwrcXD3pQivtxHIcCp9oNhY1IvBdqX2zhXt6pl3n2NuVxwE2qCbx9jcXNEHTe5tJ/+dwqKo/2MqJKN3EdkkadMnJFQJ7O4kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734094105; c=relaxed/simple;
	bh=JUoyttvnJF0jPvh4eHNSgzi9/O2FGvHE1DyVE1UE/MA=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=jUvcYdAdOD0/9HRP9mJjzwbtPD7AA0o+ZfpUdVglKm0MvxXNHoqM4iQW0LCOkPnZSUg94D/DfcgmnOyyMZMAXu+qV2t2N9M4SbkkenSccpYvwgOPf76u/VNyGvQGUbmAYJ0Wc3PkcymVmbf//ppMS5nL+sWyWK95e1NLrya62CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d92VN0eo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493E0C4CED0;
	Fri, 13 Dec 2024 12:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734094105;
	bh=JUoyttvnJF0jPvh4eHNSgzi9/O2FGvHE1DyVE1UE/MA=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=d92VN0eogs364wuHcXEzwFkte8e516ds0VeN5PMyBvmDXV77g2Tp0dj3xKA+Pzd3D
	 gqqVX6VplPAIfh4wgORcFamUnLNlV+YVQqeUIPsoQWcNYPuQJ76J0wuqNcRrNg9liF
	 n5pGH7KNCpMiCNHYYc/0PS2dGH0jmLP2cbsJ4izD7sin5e57Lku1vMkA6tMV/pFGaQ
	 DEZvpT5wmcADBix2zeLANlqyk9C6+KrNFEegV65sVKK7lxkJFpjRVWT92Vuhqyu9i7
	 qgz/bYytZgmoeyigaw3eX2Ovrj8r9BpUbJTQ9J7Y0zT3DktHBBwYBgrXsU5Avn1yhY
	 Px3hWpM8pF9xw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] MAINTAINERS: wifi: ath: add Jeff Johnson as maintainer
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20241212-ath-maintainer-v1-1-7ea5e86780a8@kernel.org>
References: <20241212-ath-maintainer-v1-1-7ea5e86780a8@kernel.org>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173409410234.1031231.17080692203646648392.kvalo@kernel.org>
Date: Fri, 13 Dec 2024 12:48:24 +0000 (UTC)

Jeff Johnson <jjohnson@kernel.org> wrote:

> The "ATHEROS ATH GENERIC UTILITIES" entry shares the same git tree as
> the ATH10K, ATH11K, and ATH12K entries which I already maintain, so
> add me to that entry as well.
> 
> Signed-off-by: Jeff Johnson <jjohnson@kernel.org>

Patch applied to wireless.git, thanks.

b83accfec081 MAINTAINERS: wifi: ath: add Jeff Johnson as maintainer

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20241212-ath-maintainer-v1-1-7ea5e86780a8@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


