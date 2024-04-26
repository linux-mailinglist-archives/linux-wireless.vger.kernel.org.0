Return-Path: <linux-wireless+bounces-6919-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BF68B3158
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 09:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E96CA283800
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 07:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B9D13BC3E;
	Fri, 26 Apr 2024 07:31:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04A713BC2B
	for <linux-wireless@vger.kernel.org>; Fri, 26 Apr 2024 07:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.112.30.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714116672; cv=none; b=UT/DYca1ZdFfd13aQsM0HUQ+OZ8sTUc8g/jv03cC/QbLIFsbRVgE4baZD4TBbk7E6OGM7QlhR58ECE2vPQBAWpx1aJMZXFd/3EgMOaETU00r/nN69ImLc6iG7Y2rFP6GL3f6CiHOflRqsI2T1h9ADc/jwVRmd3wjc0BFsnSSH0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714116672; c=relaxed/simple;
	bh=vHTVuSE5RBJNJYT4uKR9wB0DgQuqVhgEtpDI/daWLUM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M4CQTXchddNAYM1fpcVB+DnfLtdsaYDP8U5vc/Z3eI37gXqpPiYs6QXQ7Ql0F4VHCzHM2jA6+p9efQiCK9lopR3+9uKEtz6Aag1yxHjZq6Lb7De3hKBbJF/0YfcKovqPsIJZzkcx8l3oD/yOgvOmOqcoz4kfl0nZaeOMUu3/eAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=wens.tw; arc=none smtp.client-ip=140.112.30.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wens.tw
Received: by wens.tw (Postfix, from userid 1000)
	id 4AED05FC9B; Fri, 26 Apr 2024 15:22:36 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Deren Wu <deren.wu@mediatek.com>
Cc: Chen-Yu Tsai <wens@kernel.org>,
	wireless-regdb@lists.infradead.org,
	linux-wireless <linux-wireless@vger.kernel.org>,
	linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] wireless-regdb: Update regulatory rules for Taiwan (TW) on 6GHz
Date: Fri, 26 Apr 2024 15:22:34 +0800
Message-Id: <171411612267.210938.10854070994934082438.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <8f7c6ecd8e2cd15d277435719bf993217d40f12d.1714038069.git.deren.wu@mediatek.com>
References: <8f7c6ecd8e2cd15d277435719bf993217d40f12d.1714038069.git.deren.wu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 25 Apr 2024 17:43:13 +0800, Deren Wu wrote:
> The Ministry of Transportation and Communications in Taiwan has updated
> its frequency allocation rules [1], now including the 5945 ~ 6425 MHz
> range for Low Power Indoor (LPI) and Very Low Power (VLP) devices. As
> only one power rule can be applied to a specific frequency range, we
> choose the LPI devices with a power limit of 23 dBm. There is no Dynamic
> Frequency Selection (DFS) requirement.
> 
> [...]

Applied, thanks!

[1/1] wireless-regdb: Update regulatory rules for Taiwan (TW) on 6GHz
      commit: 87941e40f422dc3deaa7f1e4019a1b226d1f11f7

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>

