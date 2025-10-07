Return-Path: <linux-wireless+bounces-27843-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD09BC059F
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Oct 2025 08:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 064BF3A6B60
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Oct 2025 06:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1641219302;
	Tue,  7 Oct 2025 06:37:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC5F1DFE12
	for <linux-wireless@vger.kernel.org>; Tue,  7 Oct 2025 06:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.112.30.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759819032; cv=none; b=W/wgQ5rN6k+TvnNkE/KEPkeQVqqNuiGLLTMEULwkU5jsiDznUyLI3vay5PvTdEXtmKpQIfZ/hN5ix7eiQRvqMDRDwWhW3aDbF6HzKFiQNwL0Z5lTTyr/YJR4pu4O/AdeWsOEYUcVABfUwSxSuai387ch/wAm9bn/RnZyc5VV6Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759819032; c=relaxed/simple;
	bh=BbgZwJJf7YLhPPmb7oNvyR7I74hMoYigELt+icJ6crQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T29r4sHMvHeMu3KO79A7oU1ePBDD/dVtbOTVnVI2XsdUmcVXXFc2u+A7tJHcLOJYmcHy/iD0SYPb1NN8P3Qz+zpN1NIuyrD4XwvWMk21Tgm5QPQGOvKQGpPUGLHG5rF1YPFR3iodw1w/osQBBiwBq36dLAnz2g+oLzWBwEU9xOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=wens.tw; arc=none smtp.client-ip=140.112.30.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wens.tw
Received: by wens.tw (Postfix, from userid 1000)
	id D71D75FC3F; Tue, 07 Oct 2025 14:37:02 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Pavel Starosek <starosekpd@gmail.com>,
	Chen-Yu Tsai <wens@kernel.org>
Cc: wireless-regdb@lists.infradead.org,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wireless-regdb: Permit lower 6 GHz band for Kazakhstan (KZ)
Date: Tue,  7 Oct 2025 14:36:59 +0800
Message-ID: <175981896885.2552342.3876391305784148797.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250930042948.427154-1-wens@kernel.org>
References: <20250930042948.427154-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 30 Sep 2025 12:29:46 +0800, Chen-Yu Tsai wrote:
> By Order of the Minister of Digital Development No. 564/NK dated
> September 19, 2024 [1], an amendment was made to the assignment of
> frequency bands, opening up the lower part of the 6 GHz band (5,945 MHz
> to 6,425 MHz) was opened up to "SRD (wideband data transmission systems)
> WAS/RLAN Data transmission systems/radio local area networks".
> 
> The power is limited to 200 mW e.i.r.p. with a spectral density of 10
> mW/MHz. Only indoor use is permitted.
> 
> [...]

Applied to master in wens/wireless-regdb.git, thanks!

The commit message was updated to mention lowering by 3 dBm in the 5250
to 5350 MHz range to cover TPC requirements.

[1/1] wireless-regdb: Permit lower 6 GHz band for Kazakhstan (KZ)
      https://git.kernel.org/wens/wireless-regdb/c/39e5e045fdfc

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>

