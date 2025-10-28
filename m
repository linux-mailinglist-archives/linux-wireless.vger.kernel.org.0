Return-Path: <linux-wireless+bounces-28336-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FF4C13318
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Oct 2025 07:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C19191AA4771
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Oct 2025 06:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAE92BE047;
	Tue, 28 Oct 2025 06:40:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117502BE024
	for <linux-wireless@vger.kernel.org>; Tue, 28 Oct 2025 06:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.112.30.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761633615; cv=none; b=ONK2VCNSpMLZWgM7slcB89OVLPBQpCVuKkMOlsQi3UXVhABEmXdB/EMmX1gIE/LicCnEoI8j9bbgF8UxSVguH4M5oxWYYz22UzLDhVl9sbyFR9x7TKsa+KBP+sq4WCRsB4HCKRJHjitJTL3O4ij+MhINGm8VthDapKTc9eqNbZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761633615; c=relaxed/simple;
	bh=XnzddYupCaDUir58LmQG6ZH68GnTvp6CXNKtRg/GRyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vy4KEPosYCfC7KeAZAMh8RtMyf3W/Q1mkQV9SCSIlp9pWeykG7mcFi7DDJpvj38DOA+iAzZsRenGajl1xWxEddwEWiYlos4s5KE7UVwkHvlTSDtE2oOenP9aCeG9FqfLZ9z2f4BcspRSAmuCWSCqnmbmr5M+YMBsl0eAjljJnpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=wens.tw; arc=none smtp.client-ip=140.112.30.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wens.tw
Received: by wens.tw (Postfix, from userid 1000)
	id 231605FCB3; Tue, 28 Oct 2025 14:34:05 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: linux-wireless@vger.kernel.org,
	Andrew Yong <me@ndoo.sg>
Cc: Chen-Yu Tsai <wens@kernel.org>,
	wireless-regdb@lists.infradead.org
Subject: Re: [PATCH v2] wireless-regdb: Update regulatory info for Malaysia (MY) for 2024
Date: Tue, 28 Oct 2025 14:34:03 +0800
Message-ID: <176163321686.1019491.3964867291138608750.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251028062841.49216-2-me@ndoo.sg>
References: <20251028062841.49216-1-me@ndoo.sg> <20251028062841.49216-2-me@ndoo.sg>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 28 Oct 2025 14:28:41 +0800, Andrew Yong wrote:
> Malaysia Communications and Multimedia Commission announced CLASS ASSIGNMENT NO. 1 OF 2024[1].
> 
> With reference to class assignments on page 10, and Power Spectral Density (PSD) limits on page 20, update the following rules:
> 
> 2400-2500 MHz: Align previous 2402-2482 MHz rule to class assignment
> 5150-5250 MHz:
>   1. Align previous 5170-5250 MHz rule to class assignment
>   2. Mark as NO-OUTDOOR
> 5250-5350 MHz:
>   1. Align previous 5250-5330 MHz rule to class assignment
>   2. Limit EIRP from 1 W to 200 mW due to PSD limit of 10 mW/MHz, calculated at 20 MHz channel width
>   3. Mark as NO-OUTDOOR
> 5470-5650 MHz:
>   1. Align previous 5490-5650 MHz rule to class assignment
>   2. Limit EIRP from 1 W to 200 mW due to PSD limit of 10 mW/MHz, calculated at 20 MHz channel width
> 5725-5875 MHz: Align previous 5735-5835 MHz rule to class assignment
> 5925-6425 MHz: Increase EIRP from 200 mW to 250 mW (remains within PSD limit of 12.5 mW/MHz)
> 
> [...]

Applied to master in wens/wireless-regdb.git, thanks!

[1/1] wireless-regdb: Update regulatory info for Malaysia (MY) for 2024
      https://git.kernel.org/wens/wireless-regdb/c/9e8c67fa3e9f

Note that I wrapped the two long comments related to PSD.

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>

