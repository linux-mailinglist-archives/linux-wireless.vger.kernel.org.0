Return-Path: <linux-wireless+bounces-24908-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCD9AFC426
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 09:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E82A1799CE
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 07:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DCD299952;
	Tue,  8 Jul 2025 07:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpTtvHqN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C88299948
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 07:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751960066; cv=none; b=XA9uqGGYLho2+7TLxuDAqj7fAlUL8+kdrNkr1/BdQ6utjsHF4c/DBvtuDgidR8ACcOQey2oM8xwKCG03bLXNGJJ+K0akjVbCwytHsjKzVlRSAG5BouY5fboJv0mBApkuhZPh56AZJlj6X+SOeTORIhmYgcpJWwEZrbarQ/Rqqvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751960066; c=relaxed/simple;
	bh=8rANQBPBT41eM0qDK/tPvHTzfo1o0EeQtduLK/SHhC8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KR9/dTGZBZXWxXJ9Y3lbqyZeedAKuI8RMx0fWw3NOvRr1GAPJ0xkn40AoGmjv+PVDQEfkdqjJAnwLcx5Xgtnn8xcZNbwn6CvQ4+2CJhXgQW2WuUWDIwBGVwGFsN2Z7MRd1sZwmwzCj0PTrAyxRGj9ZAEKwF3seAdj4Kts+p0Www=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpTtvHqN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D2AC4CEED;
	Tue,  8 Jul 2025 07:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751960066;
	bh=8rANQBPBT41eM0qDK/tPvHTzfo1o0EeQtduLK/SHhC8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=LpTtvHqNYGH1nm6cR7cfGamIRqagULzLgBQYu7xN8uAcPe1EGiswnfiDxTDrrhQR5
	 x2My9mL9zTe1YTkgtHtXBOVBCQkMo2c0SDYKTtpv7I5kNGXutlY5moqp4jDRwGF74I
	 TLLqLlIiSchuE2QIk/6Uq2evhD48J6ZI5ASbNn5EXuL2oFjwyq+CkcHzM3Q2KiBQ79
	 O6t6TLzqj4ATaYK+c+YTylBTl8AyE73DffN3ybKGa1zo1d1NipR0JBIcNKirszj+TQ
	 4f0Jwc0zOoWDNYpDvTzjG5qgLqJd8N1hFCZ6FcCpnwZ/bwWFpi0+IBQh4tEBaSGYWE
	 R1Vb3cubY5uuQ==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 55E5D5FA91;
	Tue,  8 Jul 2025 15:34:23 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
In-Reply-To: <20250708015005.6470-1-pkshih@gmail.com>
References: <20250708015005.6470-1-pkshih@gmail.com>
Subject: Re: [PATCH v3] wireless-regdb: Update regulatory info for CEPT
 countries for 6GHz listed by WiFi Alliance
Message-Id: <175196006331.3185674.8904603752210086354.b4-ty@kernel.org>
Date: Tue, 08 Jul 2025 15:34:23 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2

On Tue, 08 Jul 2025 09:50:05 +0800, Ping-Ke Shih wrote:
> The regulations enabling 6GHz WiFi [1] of WiFi Alliance lists CEPT
> countries including
>  - Albania (AL)
>  - Andorra (AD)
>  - Austria (AT)
>  - Belgium (BE)
>  - Georgia (GE)
>  - Iceland (IS)
>  - Liechtenstein (LI)
>  - Macedonia, The Former Yugoslav Republic of (MK)
>  - Moldova, Republic of (MD)
>  - Monaco (MC)
>  - Montenegro (ME)
>  - Norway (NO)
>  - Switzerland (CH)
>  - Türky (TR)
>  - Ukraine (UA)
> Add 6 GHz frequency entry if not being added yet.
> 
> [...]

Applied to master in wens/wireless-regdb.git, thanks!

[1/1] wireless-regdb: Update regulatory info for CEPT countries for 6GHz listed by WiFi Alliance
      https://git.kernel.org/wens/wireless-regdb/c/5a8ced5ad313

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


