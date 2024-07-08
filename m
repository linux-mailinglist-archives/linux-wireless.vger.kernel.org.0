Return-Path: <linux-wireless+bounces-10076-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1DD92A5AE
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jul 2024 17:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A7AD2825FE
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jul 2024 15:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B851E536;
	Mon,  8 Jul 2024 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nn8GHG+6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CB21E86F
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jul 2024 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720452629; cv=none; b=U+Yn/Yzwozxx5DpIaeXcuft/689KRwDDXTRYtgVJ+UQQj0MzO0D+zbDHb2GUyAReQZ/FhMfGASjBVp95Q2mYxkMx4LsGI4exKSuH7we3j0Foj+sPhQZgFGQ/j4/vUuZSXMzUfsiu8zZZxYjUn2otLC0M+tL9fLej4PYCBamhNxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720452629; c=relaxed/simple;
	bh=N6/uANSukAgxQHKbtZvFKqrY5X6rxnjtvteTWKscDOw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=VKXTwkuxOCQjvHjpWJ7CWMMAVLliflPHPZAqGSprwSghXZ6G+ztRupUJmozrYLdRF/gaCVOH6s2suvg3HjouiPaaeOYPaLKV2Q9pExa8tBl69YO/MUF4eD2k/Lwxf1r7PhYWAGsVFKXNNCSH5elFYKVkdUcV+Nji4pOrI1IALE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nn8GHG+6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242EEC116B1;
	Mon,  8 Jul 2024 15:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720452629;
	bh=N6/uANSukAgxQHKbtZvFKqrY5X6rxnjtvteTWKscDOw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=nn8GHG+6gpyh/BTGr92dufeArDlY0dsERrBOFleUgOhIhedxeDcgRfYyYxCGuKi04
	 +CAVy7dqHSkVJzFwvBFiDI/i4lKkI1eOO9fWQN2CkgrhGDeIX5kcm+FkFYiGuZripo
	 McviQoJC+DA9o0ktCp9bLGVHEW3nmKmPrXcwSIw4sglQiuWWOf9DiVUIVHnAk2v7x/
	 5XlLl9Y/n7EeohDyZl2ogkVao63HEX/QbZblknQjKtvWvPhyFzyTyQJJfyEILAgJNg
	 J1EQZ3aMdiJTNFZEcOdx50uIn9Wc9BJUHkGfemU4967GOU3CBjqTrfIOzsQW1tdLkO
	 +A5uiOuA9fqkw==
From: Kalle Valo <kvalo@kernel.org>
To: Felix Fietkau <nbd@nbd.name>
Cc: linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: pull request: mt76 2024-07-08
References: <f5e72ce2-11db-4f19-8aaf-8fd9b62e5a77@nbd.name>
Date: Mon, 08 Jul 2024 18:30:27 +0300
In-Reply-To: <f5e72ce2-11db-4f19-8aaf-8fd9b62e5a77@nbd.name> (Felix Fietkau's
	message of "Mon, 8 Jul 2024 12:34:19 +0200")
Message-ID: <87bk37dhpo.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Felix Fietkau <nbd@nbd.name> writes:

> Hi Kalle,
>
> here's my first request for 6.11
>
> - Felix
>
> The following changes since commit 1b431ba4ef9a760e7643d6fbc53bf522d59650f3:
>
>   wifi: iwlwifi: mvm: re-enable MLO (2024-07-04 13:50:10 +0200)
>
> are available in the Git repository at:
>
>   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2024-07-08
>
> for you to fetch changes up to 755db1b86ff49027cae37fc57ce8fef608432c4e:
>
>   wifi: mt76: mt792x: fix scheduler interference in drv own process (2024-07-08 12:23:23 +0200)
>
> ----------------------------------------------------------------
> mt76 patches for 6.11
>
> - mt7925 MLO support
> - mt7925 fix
>
> ----------------------------------------------------------------

With this pull request I see (sparse?) warnings:

drivers/net/wireless/mediatek/mt76/mt7925/mcu.c:365:19: warning: invalid assignment: +=
drivers/net/wireless/mediatek/mt76/mt7925/mcu.c:365:19:    left side has type int
drivers/net/wireless/mediatek/mt76/mt7925/mcu.c:365:19:    right side has type restricted __le16
drivers/net/wireless/mediatek/mt76/mt7925/mcu.c:1759:42: warning: incorrect type in assignment (different base types)
drivers/net/wireless/mediatek/mt76/mt7925/mcu.c:1759:42:    expected unsigned char [usertype] bss_idx
drivers/net/wireless/mediatek/mt76/mt7925/mcu.c:1759:42:    got restricted __le16 [usertype]
drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c:63:51: warning: Using plain integer as NULL pointer

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

