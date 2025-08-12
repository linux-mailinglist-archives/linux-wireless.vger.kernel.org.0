Return-Path: <linux-wireless+bounces-26291-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E1BB21E9F
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 08:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FBE73B8FAC
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 06:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7807D27A917;
	Tue, 12 Aug 2025 06:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUfz6Lt3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5417325487C
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 06:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754981655; cv=none; b=CqpdcUFeql4C6xc+bS0L3DyXvLkhnJoYndf/jamdAHrPabzqpIwq4Oglwo0NOMJadNcpwMeH6CcaAd7Agud9EOFSPAaMqwTnWA0g9F3Yt3Z9jxKXwPeWffy9aS2EUc09jnukNtEIgTjf5kuMjBeKNY4F6cjA/L7MlbunkDQCW5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754981655; c=relaxed/simple;
	bh=sYn4unF3y3ZRcHusS+/p+Um8rP0JGBzA88BqHzHtyZQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bqtPjJpoAr9r465LwV3pTWuDAiwdwVhhygKS7Jnt96nqHSHIdVtG2qytkclnistuId8Zl+1zTn/TrWraxDMmPgK17if+o3dJlZZug7rbmGLRRNp+gZjBj3ihEKt7f7TOqyDQ8qIvtDCC+BDQRwhrBpt+iS7ysXXEf8opHjaKXto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUfz6Lt3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B616FC4CEF0;
	Tue, 12 Aug 2025 06:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754981654;
	bh=sYn4unF3y3ZRcHusS+/p+Um8rP0JGBzA88BqHzHtyZQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RUfz6Lt3BYPFwnS2yoxFTYbDvqsSLbMBFqYCOUutJ9eoFOUr/X+dXw9yofjgtP+LI
	 fmTCl+zo021VGQmlvxhutWHMBKa6PmzJ49FmHj+S6/imOYYMFPmCM/lQXRb++61dC5
	 Dl02HbUSdbkxZK77M66rFYZb5KyUYjOAPA/mSf394DpNaDjJGhrixyVg3Sp3gkU/J2
	 6XGbwOmuyI7UON+v994jaI40KDVQD481xaP9BDK6vyvihyaU/lCe7wQ77z0/oB1aLL
	 2Jr3D29sbIyJ7VFLPpcl9OhBd8j22fafJb1QdRcAChGKUwygTD7+LnnacY2YimQaAs
	 aBckYRlb0Vo7A==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 202C25FAC5;
	Tue, 12 Aug 2025 14:54:12 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
In-Reply-To: <20250718030810.17213-1-pkshih@gmail.com>
References: <20250718030810.17213-1-pkshih@gmail.com>
Subject: Re: [PATCH 1/2] wireless-regdb: update regulatory rules for
 Botswana (BW) for 2022
Message-Id: <175498165208.1954687.8856625467332452057.b4-ty@kernel.org>
Date: Tue, 12 Aug 2025 14:54:12 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Fri, 18 Jul 2025 11:08:09 +0800, Ping-Ke Shih wrote:
> Guidelines On The Use Of Short-Range Devices (SRDs) In Botswana released
> on February 2022 [1]. The pages 20-21 describe:
> 
> * 2400 - 2483.5 MHz
>   - 100 mW e.i.r.p.
>   - EN 300 328
> * 5150 - 5350 MHz
>   - 200 mW mean e.i.r.p
>   - EN 301 893
>     * DFS: 5250 - 5350 MHz
>     * for devices without TPC, the limit is lowered 3 dBm
>       (reduce 5250 - 5350 MHz to 20 dBm)
> * 5470 - 5725 MHz
>   - 250 mW e.i.r.p
>   - EN 301 893
>     * DFS: 5470 - 5725 MHz
>     * for devices without TPC, the limit is lowered 3 dBm
>       - Not required for devices that operate at a maximum mean e.i.r.p. of
>         27 dBm when operating in 5470 MHz to 5725 MHz
>         (keep 250 mW for 5470 MHz to 5725 MHz)
> * 5725 - 5875 MHz
>   - BFWA is limited to 5725 - 5850 MHz
>   - PTP/PTMP: max mean e.i.r.p = 4 W
>   - Mesh/AP-MP: max mean e.i.r.p = 2 W
>   - EN 302 502
>     * DFS: 5725 - 5850 MHz
>     * The FWA device shall have the capability to reduce the operating mean
>       EIRP level to a level not exceeding 24 dBm for ChS = 20 MHz
> 
> [...]

Applied to master in wens/wireless-regdb.git, thanks!

[1/2] wireless-regdb: update regulatory rules for Botswana (BW) for 2022
      https://git.kernel.org/wens/wireless-regdb/c/e51d5681b3c2
[2/2] wireless-regdb: update regulatory rules for Sint Marteen (SX) for 2018
      https://git.kernel.org/wens/wireless-regdb/c/5afc6329e5c1

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


