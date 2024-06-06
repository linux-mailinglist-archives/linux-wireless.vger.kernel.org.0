Return-Path: <linux-wireless+bounces-8625-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A49D8FF03B
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 17:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B6D21F25A4F
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 15:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2B819645B;
	Thu,  6 Jun 2024 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIZx+eSM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249E71802AC
	for <linux-wireless@vger.kernel.org>; Thu,  6 Jun 2024 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717685762; cv=none; b=Yro3CLomTIAO4y//sxrzVO+yDVayNDu8OXSWMtvZRGLudLnycugLF9XzwtFnzAHJdT/c3yLYRQpf38EwOES9PXHujQ1ewdqy2yfxqb3XrYm+oTsQN3CvCKmhbhvkPX9LkQn4AYp1Qfbik9XWa24OTfCGMrQUnz8HYc0DGzhh5tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717685762; c=relaxed/simple;
	bh=BJvw1GXBb75PGCCdgtHgmV04LTSJ7apMr2NBvvD9rpE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TvZ8xsizlC89NIHir/KZO2iJ8jnl3oFY0xkDC+28dLcui6VT69mcM5L6bi48fYiszh3A2B9drfA2SzX6tw+nMioOuXz/99LHsn9Bz/yzSMpSBN89YAKB/eNuQBRbS1pR2qG7l5TyoY0aG6fYtzjgOETtdGX897apKjVocMnpd6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIZx+eSM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88091C2BD10;
	Thu,  6 Jun 2024 14:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717685761;
	bh=BJvw1GXBb75PGCCdgtHgmV04LTSJ7apMr2NBvvD9rpE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JIZx+eSMLuh8W9sEZX6wWZEwX3XEHQEDaagANYczQH3Q4mmfh+pUiyAlf1NXYwzbj
	 idKHoeLEghNSbG7VLF0b7x6Bk9N92HoRN+/x3G8v1laWEoGCQUWcUJw6W1mVF/kWRZ
	 RumMAve6yyVc0V9+BkWLSPE7Gd74Hp7Lrmyl2F/V6BHZdWv1BZf16ABWCWk4iktFFo
	 22SxaESW7Cfb248hQCTd8lpP4OqyuznEx5DyDxbd2jL/RSwYWichTryOmw44Uy1L+J
	 OMCSiRR0MYfMq+5jd/kSLv1/LzC6JHPfOdF69GMxxEGDtkm3VSlS9xQAri8BXzxklr
	 E+Edmiwgqfe5g==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 792305F8B0;
	Thu,  6 Jun 2024 22:55:59 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
In-Reply-To: <20240605074209.8713-1-pkshih@realtek.com>
References: <20240605074209.8713-1-pkshih@realtek.com>
Subject: Re: [PATCH v3 1/4] wireless-regdb: Update regulatory info for
 Malaysia (MY) for 2022
Message-Id: <171768575947.810795.11893893795963994787.b4-ty@kernel.org>
Date: Thu, 06 Jun 2024 22:55:59 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Wed, 05 Jun 2024 15:42:06 +0800, Ping-Ke Shih wrote:
> Malaysia Communications and Multimedia Commission announced CLASS
> ASSIGNMENT NO. 1 OF 2022, which page 11 describes frequency bands
> 5925-6425 MHz are used with conditions of 25 mW EIRP for indoor and outdoor
> use and 200 mW EIRP for indoor use only. Add frequency range of
> 5925-6425 MHz and update limits of existing entries accordingly.
> 
> [1] https://www.mcmc.gov.my/skmmgovmy/media/General/CA-No-1-of-2022_-signed_19012022.pdf
> 
> [...]

Applied to master in wens/wireless-regdb.git, thanks!

[1/4] wireless-regdb: Update regulatory info for Malaysia (MY) for 2022
      https://git.kernel.org/wens/wireless-regdb/c/f901fa959af9
[2/4] wireless-regdb: Update regulatory info for Morocco (MA) on 6GHz
      https://git.kernel.org/wens/wireless-regdb/c/d72d28865b44
[3/4] wireless-regdb: Update regulatory info for Chile (CL) on 6GHz
      https://git.kernel.org/wens/wireless-regdb/c/414face1b010
[4/4] wireless-regdb: Update regulatory info for Mexico (MX) on 6GHz
      https://git.kernel.org/wens/wireless-regdb/c/1156a08e9106

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


