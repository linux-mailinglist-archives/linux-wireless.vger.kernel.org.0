Return-Path: <linux-wireless+bounces-18080-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AFCA21099
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 19:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 951121881EA8
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 18:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976381DE3BF;
	Tue, 28 Jan 2025 18:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsJkmReF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703481DE3C4;
	Tue, 28 Jan 2025 18:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738088083; cv=none; b=bp+GJuB1dOwy7a7ySZ4RkzyYOXYt7Yfa+KW8tMsr2c+gn/1bQm9pcMQskCVpBjPokU4rpG//op3r+weO2ekwV6YEJtH3qD6WRqqSrK9J/yA5zsRC1rZJQXs8b66Tul9bjbk31w9gtEOZOUfq9lysoHG29lnKTea64Xh3051Vr8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738088083; c=relaxed/simple;
	bh=CaZhd4pdbyiDzLiUWSPfBdRRi3ufXE+H78EfO17x+fM=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=D4mBiCSlTcMGcCbPJsQyyD5FqG5b/IFZEq/A2U1v3kIdmby+V5nAB8xqW5EYxN6YOQafw+ZXLQdAd9S+6VC2aFq4G5Nq8lWDOteMdarG/hiQH+bjD9A1dsm22i8yW7cz9yqY2sG1TLmlAsJ+lMus3olS2D51tYqzZj6H4+RAknU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsJkmReF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCBBAC4CEE1;
	Tue, 28 Jan 2025 18:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738088081;
	bh=CaZhd4pdbyiDzLiUWSPfBdRRi3ufXE+H78EfO17x+fM=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=ZsJkmReFCEmfAvjvr30ATMpfpwjU6k4Bb21usXw6TuP6RueAxacmY/QEMB8efmWnb
	 N48k1APKcycen2EMfKEgQJB7D7q4nTS4NrM2L+TE/Hp3tiIzlSwykw8DmQRARcXxLC
	 ld4IsmVo1UqWl/72itRgaj4brPrV4/5cRKI7NL78SkmeHOrWn3k9pumDP8Tz6ra+cs
	 A0rc75YsmpQ6cIuUp2cGrwtnj5GC2vTXfjQyy0E6z++cwaktBbVtvaQjCAolZlK/4o
	 5WPXd0gCsPCXOhar5jCJsHmduKSv7d+cGi6AE/cdekxVwMR5XAREOOe1vBRa/ed9St
	 DPktTN2iEdjmw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [1/3] wifi: libertas: main: remove unused functions
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20250121013300.433538-2-linux@treblig.org>
References: <20250121013300.433538-2-linux@treblig.org>
To: linux@treblig.org
Cc: libertas-dev@lists.infradead.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Dr. David Alan Gilbert" <linux@treblig.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173808807897.1254064.13481558888532934866.kvalo@kernel.org>
Date: Tue, 28 Jan 2025 18:14:40 +0000 (UTC)

linux@treblig.org wrote:

> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> lbs_data_rate_to_fw_index(), lbs_enter_auto_deep_sleep() and
> lbs_exit_auto_deep_sleep() last use was removed in 2010 by
> commit e86dc1ca4676 ("Libertas: cfg80211 support").
> 
> Remove them.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

3 patches applied to wireless-next.git, thanks.

d5b66511fd35 wifi: libertas: main: remove unused functions
5a7148ba1806 wifi: libertas: cmd: remove unused functions
107c2be8ddf4 wifi: libertas: Remove unused auto deep sleep code

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20250121013300.433538-2-linux@treblig.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


