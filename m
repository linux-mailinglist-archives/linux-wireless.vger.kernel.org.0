Return-Path: <linux-wireless+bounces-2154-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B888315EA
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 10:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E40B1F26DB2
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 09:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1926D1F92D;
	Thu, 18 Jan 2024 09:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqTEF3tt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1351F922
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 09:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705570419; cv=none; b=uPns7jbF618bW8T8OQtc3o06+WUuedzaf4UWpSLTJS9PzBZhdQWUlZi+5TOE94MJGOr1ErJN1Oyi+XgitThayWyoMdJk1pj2Psp4OorexDon7ViY0pMS53Xm8a55el+Mu8+JvuhMUeFoHCaHs0ekahvtlmHBA4oPJsGTIkstLug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705570419; c=relaxed/simple;
	bh=OVLNJN8zZ5+S4cRu8IxCqNEZeVP9+AN5CdN0kcl7xlU=;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:
	 Cc:User-Agent:Message-ID:Date; b=cX4/mODAT86+c42gQkoo8WjLgYgfR8Lxnp8bqeTnsjmEOc9gUEcHTkqwnG+eRmN2adALYsw0EOJinQL8lVxLpjwkNm78WbByRF3/dFf2QXTaSiQxqMjX4ECBzhCMiqaJO16H/3Ca025zVN6dE83JMzt7OdozTwdoinuQlYP3His=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqTEF3tt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37640C433F1;
	Thu, 18 Jan 2024 09:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705570418;
	bh=OVLNJN8zZ5+S4cRu8IxCqNEZeVP9+AN5CdN0kcl7xlU=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=eqTEF3ttkygMrnFrxsDYRfndtbjZq7A7CdiatD054jgXOckugHUlmU+e36jNVFsAp
	 Y9+pIcKHgEP+U3ySi+e8mP2Fb6lKGKo43J9n1qj2rBuaT6IS1FbmDNmobtMQCtCxK4
	 vgp6K3EJBBayZVWqqzQb5O14MqvPhaB7PNt/nDhJEoXEveFPI9Eq6SuZfRdjRsEXdH
	 Z2z+jfiJNYZYgrZCyJxllJewJGvBvnjGYVktNS7q9fhE3m6ci+UvwvYcbKhYJowZU+
	 SrH4cmkOH5F8UA8+adiob78GT8OeXP/RGFHUZWysvKOgTE+YHHSr6kH3H5ZeezluMF
	 WL6UQdfQ0LAqg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/4] wifi: rtw89: adjust init_he_cap() to add EHT cap into
 iftype_data
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240112062640.36922-2-pkshih@realtek.com>
References: <20240112062640.36922-2-pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170557041616.2797779.7684670904630840965.kvalo@kernel.org>
Date: Thu, 18 Jan 2024 09:33:38 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> EHT capabilities are also stored in struct ieee80211_sband_iftype_data, so
> adjust allocation of iftype_data as common part named init_he_eht_cap(),
> and then init_eht_cap() can be added later. Don't change logic at all
> by this patch.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

4 patches applied to wireless-next.git, thanks.

c19443700370 wifi: rtw89: adjust init_he_cap() to add EHT cap into iftype_data
c5bdcddaa32c wifi: rtw89: change supported bandwidths of chip_info to bit mask
9156181f6274 wifi: rtw89: add EHT capabilities for WiFi 7 chips
4f47e0cf1a84 wifi: rtw89: declare EXT NSS BW of VHT capability

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240112062640.36922-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


