Return-Path: <linux-wireless+bounces-4098-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 424B486995E
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 15:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F2291C21B8A
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 14:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1811A1487E3;
	Tue, 27 Feb 2024 14:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vh3oAhBP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A311487D8
	for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 14:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709045742; cv=none; b=JC/+s9PNuXjhAkRjaQykELYcbORdFF6V6pz8ClnZcPJFvy+OWUVrKLb+Zf36UjOBMDpy3un4MvMN8Dqi7qdlUfz0pILx2KSsJYW0UDrep/YQ6e2PYTWQ0zW2Npapt7SYWiIqfCC9qpFwPnr/1dKPpEWSz5xbj+A/D0ptHFsoico=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709045742; c=relaxed/simple;
	bh=0sw8nl1ExByGpTRj2s0ABtv+N5Ped/9eYmrNBeXax8o=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=oPjxOoIu4vuuT6baHtkQIj0SceJS8peXZxl+gytF9b6rbwDsWAicaSKhWBY4NB9WM3LRkHb+rsqXhh4ChBKZUm9zhrCNj2LaJy+67HpZrVeq24nXUC3SNjYN6uETpgVf3EAb32nwmRuRrjZHPeBzI9NUgs1qf78tyLzjFUbMQAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vh3oAhBP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D36C433F1;
	Tue, 27 Feb 2024 14:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709045741;
	bh=0sw8nl1ExByGpTRj2s0ABtv+N5Ped/9eYmrNBeXax8o=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=Vh3oAhBP8OSJRiuRBEADQNIhMDhRTGaiMASE6VB2FEWxMfUDjSL4xQKX+lbBwqhm+
	 ihfrNyrw01Y8vuovmnlD4xDTzFWzYU8459JLfTP9KDIBDPT8cQndnY335eOwXxQ5/M
	 MWxbx30tfXgjPFdoZSnQrEGO31Z22UBVeXu1lvNMLbD/qmjv5z2W+Bp+NRPfC/nxs0
	 V5o1PaAIaKqAxvx45zWxHvaGHk7V65cyWUmWG2p9TvP2YSnrKp34bsGAPEACogfaGV
	 P8iIt8codtzxb6DtGUkGIxPpM08zyGFrB+ABqCewhLuJjt0XMYM51aAsRPFKxI9pQC
	 A3iRy9clV+srw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] wifi: rtw89: advertise missing extended scan feature
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240222064258.59782-2-pkshih@realtek.com>
References: <20240222064258.59782-2-pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <timlee@realtek.com>, <damon.chen@realtek.com>,
 <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170904573854.3524945.11030942207005457084.kvalo@kernel.org>
Date: Tue, 27 Feb 2024 14:55:40 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Kuan-Chung Chen <damon.chen@realtek.com>
> 
> Add support for random serial number in probe request and
> configure channel dwell time. Advertise corresponding feature flag
> NL80211_EXT_FEATURE_SCAN_RANDOM_SN and NL80211_EXT_FEATURE_SET_SCAN_DWELL.
> Use the scan request duration as channel dwell time when it is
> non-zero, otherwise use the default value.
> 
> Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

3 patches applied to wireless-next.git, thanks.

dc10daddfeb1 wifi: rtw89: advertise missing extended scan feature
6ebe995542d0 wifi: rtw89: Update EHT PHY beamforming capability
53fe234f15b9 wifi: rtw89: pci: implement PCI CLK/ASPM/L1SS for WiFi 7 chips

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240222064258.59782-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


