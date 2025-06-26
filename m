Return-Path: <linux-wireless+bounces-24519-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A3FAE9759
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 10:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A422189E6E1
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 08:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1E92165EC;
	Thu, 26 Jun 2025 08:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYLFJCVc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CB81DC998
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 08:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750924831; cv=none; b=G9XE8/gOUehUq25JCWIbquPvkCv8072uni3Rkc3E5X4x0D4BZADrmXDNQuowZaf6fGYiK9PfH1kGKDz51uZ2G6ngS4m2+qYmdvX+KFYmCeeA5Rjdh4w0P1CaW0NirOdi+1xxeStTaAyZMxmS0Z02CjoYwyNPvbzzHpoIlcUmPfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750924831; c=relaxed/simple;
	bh=GhNn1CxE/TVqSMWQ96wk0/Urn0iPGND4WEgwx6J4S4w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ty/GclgWSznKczi367ojmjnfbuaXmYQwYfuYOBysaFQpdI6tv1kWUOXPcftha5wFudCmttfY5eqOtA4qjC0Y0b0Qv8dNwXIjSega+NcyAQEzWcZ819rE2xjY/jD7SEptJIMC1r9/jLk9K2tl0ISVcx2NJ2DA+mNXJd1Vfpson00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYLFJCVc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADCE8C4CEEE;
	Thu, 26 Jun 2025 08:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750924830;
	bh=GhNn1CxE/TVqSMWQ96wk0/Urn0iPGND4WEgwx6J4S4w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mYLFJCVchWOSmgVSAr9NtEFg+s+ePhmxu4VrGi9DzxsepqOTJTlndaaHtV+zHnUhS
	 1H9NkpYBzKvD2eACTvMeX15SxFUE3cBbn2IecL68ezZb7TOELLjgKXjzvGiOh6o1V8
	 +Q5rGXrpQ3tvlOVeBveF7mGtcoKmLH2E+qejVXN5apf+U/AHtiXZcR8DUGjVggW1Xk
	 Vm+R3EgqtJ79fAUKpAIufoe5qz+47P3tlrF3jlW7YzrgDZXVim4s1a3kPSBNGdHM8T
	 5QCzjQQElnxhzcI2T/dEE45g6VgV9KcMvqW9wWC8q32DCuOgYZzZe9ing2uTwfokDx
	 vodK79cQR5STw==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 0E7D55FE35;
	Thu, 26 Jun 2025 16:00:28 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
In-Reply-To: <20250618054904.9107-1-pkshih@gmail.com>
References: <20250618054904.9107-1-pkshih@gmail.com>
Subject: Re: [PATCH] wireless-regdb: Update regulatory info for Egypt (EG)
 for 2024
Message-Id: <175092482805.2040065.11132581971624501350.b4-ty@kernel.org>
Date: Thu, 26 Jun 2025 16:00:28 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Wed, 18 Jun 2025 13:49:04 +0800, Ping-Ke Shih wrote:
> National Telecommunications Regulatory Authority (NTRA) released Radio
> Spectrum Guidelines for Short-range Devices (SRD) on November 2024.
> 
> As Table 4 Mandatary requirements for Wideband Data Transmission Systems:
> Including Wireless LAN (Wi-Fi and Multiple GIGABIT wireless systems for
> Indoor applications only)
> 
> [...]

Applied to master in wens/wireless-regdb.git, thanks!

[1/1] wireless-regdb: Update regulatory info for Egypt (EG) for 2024
      https://git.kernel.org/wens/wireless-regdb/c/a8b5cda00800

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


