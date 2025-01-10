Return-Path: <linux-wireless+bounces-17323-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B62CAA09181
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 14:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86617188E1CF
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 13:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A800F20D4FD;
	Fri, 10 Jan 2025 13:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chKvc2FV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2E61B4248;
	Fri, 10 Jan 2025 13:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736514742; cv=none; b=QBTMoyFqa31k53YpN6HGtE+/QtLPpKb61Qa7zATROQ/zcOTn5twu0WWwTkhUGfubL1FDEPk9RynF1l8O0hs31UByVvjXXhyzXaxQztxkkgzsB0N8Nn+syfvRxc7wq8gbY3QcVe5D7WakxER/5HDEVK+P+CqkpU3Oc95GqSOWRKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736514742; c=relaxed/simple;
	bh=ffHqRwikKiZdHZpxa8JpRqA1BAgAZPomRbaPIWgD47I=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=ChochX8nWCS/csHV1J3zRyuFmVMsxpwIvHYvB6Vm0YdQLPfFCRx1wXCOgH6W7c0Merk2mJrhHo4br5hApHEp9jIuzmHYiT6nq62smtKOcn4IIPW7eQwHxd8tV1KI3eJ1bd33skIJc02vUurwTE+ZaNCsl4//xIMzzoI9kEhA90E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chKvc2FV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364B7C4CED6;
	Fri, 10 Jan 2025 13:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736514742;
	bh=ffHqRwikKiZdHZpxa8JpRqA1BAgAZPomRbaPIWgD47I=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=chKvc2FVuSEe62ved5GMZUMCV30YCXdUSfhZjZuDRXXe2426ZwT0iGK/jO8AxYlsP
	 HYkMQsX/unFkENsvfwSzZhKsLu6s191bqU21Fzz/YUkN9MSHeObaJGz2p7sIfsULsp
	 55qkKMjiixm55bxwA5pofQNFYP+XLr6UoVcPzH5Nd/NZ8KjcDNIthZZYyeYwaU+rsF
	 /2qSaEuCTxELeWWp+FV4DvPV5jRzHGjxxrn870JcUGE4ZUb9Ygibl09EdQ+W0nk7a4
	 DGeCLWkQk5KucDph4knPWHV/SahllFNFwWIi6YbsGS8Paog9fsSg8lmkXfwwflUgRf
	 GMO6H2FlaTCGg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [1/2] wifi: rt2x00: Remove unused rfval values
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20241221124445.1094460-2-ariel.otilibili-anieli@eurecom.fr>
References: <20241221124445.1094460-2-ariel.otilibili-anieli@eurecom.fr>
To: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>,
 Stanislaw Gruszka <stf_xl@wp.pl>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173651473967.72755.9279682035059989986.kvalo@kernel.org>
Date: Fri, 10 Jan 2025 13:12:21 +0000 (UTC)

Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr> wrote:

> The intention here is not clear but as this was already tested and matches
> vendor driver it's better not to change behavior even if it looks suspicious.
> So just remove the unused values.
> 
> Coverity-ID: 1525307
> 
> Signed-off-by: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
> Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
> [kvalo@kernel.org: write commit message]

Patch applied to wireless-next.git, thanks.

280c8b39050b wifi: rt2x00: Remove unused rfval values

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20241221124445.1094460-2-ariel.otilibili-anieli@eurecom.fr/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


