Return-Path: <linux-wireless+bounces-12960-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E56597BD5E
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 15:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A038B210DD
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 13:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A56189F5D;
	Wed, 18 Sep 2024 13:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/hLzor5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332832E64B;
	Wed, 18 Sep 2024 13:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726667613; cv=none; b=DQ6t7VgUQE+bTjWMUBDI+Xg2hDnpCDHro0oyx2b6hlJo8cJTVU9MBsPyLDdzQjBe2fh4iSJrr2ZUC1A+uaoFDk0PtjZNcmIcyXBa1zZtKdoNwUxDuX9+e7vsaiAIlSEhkowYEI4U0XuUABBlg/LXqDnBZDN5QRdxfovOzQMp13s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726667613; c=relaxed/simple;
	bh=ytdWxpJA5dsKY/k0IBA4HdX0IWT4USq8QFpguDrueRI=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=UhdE69DbDjiopVP8MBA5qhJOWGCaJgeRcuGHWGmiYj+681a5oGcVJqUhq+mmwy14R0dUtvKsiWUg50pANsbalS8Vb5KhZYM7yHFR29I/KB7QNoxCbfeH/hf0rSegklzCxI+hqL1VaWwMo0pHcMj7xDPo741LlOJuswLkxzPWVlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/hLzor5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556C5C4CEC2;
	Wed, 18 Sep 2024 13:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726667612;
	bh=ytdWxpJA5dsKY/k0IBA4HdX0IWT4USq8QFpguDrueRI=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=P/hLzor5fkh4NFvpUfizd8FldWH+JwdSFqXsK8kAxw5bamINN3Scteuy4cKkaUpfm
	 yi0/HAulnA4FmjruhtBfTNyK1KV7o6n/g0CUU/Dd56XWWM11U/XPqC6drpOhP3XOl0
	 RB7IgMtlYhIY6k6X8HsV9rd7MFchKctTv1B7dGr1Bhsv9RgSXar6wkegNtJdRAwLkR
	 +udaGRjiqLv7/sq41WrqYJHf9l+mf8k82u14jEHilFBDIp1HgK1NJLq+GKs2rinvHg
	 UAegV/zpGQZM+G8mcJDt38ovI4sOSJ47W0mhHNFQWyWH2Z4+5vlUZS4ORdJ4NSDCSd
	 JPD4JPkdP0YMw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless-next v2 1/3] wifi: brcmfmac: of: Make use of
 irq_get_trigger_type()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240904154919.118513-2-vassilisamir@gmail.com>
References: <20240904154919.118513-2-vassilisamir@gmail.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: arend.vanspriel@broadcom.com, knaerzche@gmail.com, leitao@debian.org,
 linus.walleij@linaro.org, javierm@redhat.com, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-kernel@vger.kernel.org, Vasileios Amoiridis <vassilisamir@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172666760843.3996465.8297118999206093713.kvalo@kernel.org>
Date: Wed, 18 Sep 2024 13:53:30 +0000 (UTC)

Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Convert irqd_get_trigger_type(irq_get_irq_data(irq)) cases to the more
> simple irq_get_trigger_type().
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>

3 patches applied to wireless-next.git, thanks.

50282c028316 wifi: brcmfmac: of: Make use of irq_get_trigger_type()
18ae128c1ddc wifi: wlcore: sdio: Make use of irq_get_trigger_type()
a3ede2b0e65a wifi: wlcore: sdio: Use helper to define resources

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240904154919.118513-2-vassilisamir@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


