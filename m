Return-Path: <linux-wireless+bounces-24866-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78089AFAA6E
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 05:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DA431882C05
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 03:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7A725A2C9;
	Mon,  7 Jul 2025 03:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3xstKYT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77B525A2B5
	for <linux-wireless@vger.kernel.org>; Mon,  7 Jul 2025 03:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751860437; cv=none; b=RaTwMhEjI3wlWt6XaxIcIkGbyRf/uN6hzxC9ielxmowH1o0R50WfU4Z5nS6dY15fE4G1238eTn4UnGFYyHuMhR6OJL3CmLTj1NoqNUfxdDU6ZjBpWfZV4w9TsuOlVTuXOris2ZQ6fLJ76PjqA4rPCAcbiWi/5pfYeuh2hJn7eFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751860437; c=relaxed/simple;
	bh=TjB45pv4sNHSr7j2KCBxzY/USQNVmwkNKGlR6VAS8A4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MCkCqeWQj97ZANaOLjENvWVbvEtvqJ5KVTtE5uVQSHU1QrqEYYfBZXDeaRZQSjpL9+unXizunCdOySIIOfYF7W/R2cgMf2vbbK9KzqdwyYvPsaRzrQD0DH0QEE01Y9J2/rbVSMqJQpZy2UIJFZ3E0/V4v55HClt6RvmzbwINeE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3xstKYT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DE9C4CEE3;
	Mon,  7 Jul 2025 03:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751860437;
	bh=TjB45pv4sNHSr7j2KCBxzY/USQNVmwkNKGlR6VAS8A4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=l3xstKYTsxfherhgiq+mkWWGVcealC8MEtKu6PqmduqZlvqe+N8tOnWTW9lTwq1+d
	 GK9DxKkMngs4MSWfs30OVA3f6MsFGvsA0ZB9V7rWhGFm2o7QWp2gW087WA1cfLLNrf
	 /xmvunFlWkgHIgEi08NpPumonMq2t3dDq6nWYGuvaMfWOe1PGONEflyVnYfNlU7hAz
	 sSRzcX7La4NKFm+QzRgvpLlTkdP+y25C6RwFPywi8QLpD6ZAs72EXHWdh2kaDv23oY
	 6XlpPDcwTki/Hq8n6pv1ZlxGk2gLyLm8e/WNHjjO6AALvEaw61lYV1mzv8QhPKG8Fg
	 DHmvWjpr4Y5+Q==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id B4D9A5FA78;
	Mon,  7 Jul 2025 11:53:54 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
In-Reply-To: <20250707024615.38507-1-pkshih@gmail.com>
References: <20250707024615.38507-1-pkshih@gmail.com>
Subject: Re: (subset) [PATCH 1/3] wireless-regdb: Update regulatory info
 for CEPT countries for 6GHz listed by WiFi Alliance
Message-Id: <175186043471.2618926.17715416165051713886.b4-ty@kernel.org>
Date: Mon, 07 Jul 2025 11:53:54 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2

On Mon, 07 Jul 2025 10:46:13 +0800, Ping-Ke Shih wrote:
> From: Ping-Ke Shih <pkshih@realtek.com>
> 
> The regulations enabling 6GHz WiFi [1] of WiFi Alliance lists CEPT
> countries including
>  - Albania (AL)
>  - Andorra (AD)
>  - Austria (AT)
>  - Belarus (BY)
>  - Belgium (BE)
>  - Georgia (GE)
>  - Iceland (IS)
>  - Liechtenstein (LI)
>  - Macedonia, The Former Yugoslav Republic of (MK)
>  - Moldova, Republic of (MD)
>  - Monaco (MC)
>  - Montenegro (ME)
>  - Norway (NO)
>  - Russian Federation (RU)
>  - Switzerland (CH)
>  - Türky (TR)
>  - Ukraine (UA)
> Add 6 GHz frequency entry if not being added yet.
> 
> [...]

Applied to master in wens/wireless-regdb.git, thanks!

[2/3] wireless-regdb: update regulatory rules for India (IN) on 6 GHz for 2025
      https://git.kernel.org/wens/wireless-regdb/c/da0262f68596
[3/3] wireless-regdb: update regulatory rules for Paraguay (PY) on 6 GHz for 2025
      https://git.kernel.org/wens/wireless-regdb/c/b009de81f75d

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


