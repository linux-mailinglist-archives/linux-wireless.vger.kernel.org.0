Return-Path: <linux-wireless+bounces-1673-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE371829CEA
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 15:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B4652829D8
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 14:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572564BA8F;
	Wed, 10 Jan 2024 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CvzoUPHM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2CF4BA89
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jan 2024 14:55:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E655C43390;
	Wed, 10 Jan 2024 14:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704898528;
	bh=V2ZPUqpTosvhm2rpc5YpDyv9mhR0ZthfiBv04/WRClY=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=CvzoUPHMIDj+0p6CpBEjJgtWUGKJovR7lrjTKEDDjwwGixyGOHemfRpmayVTVFHv0
	 oX6eJvK5x81xPoQKCm99MckRoyjipGpLWo3QbgEqZ0SY7nPIVcctmwcZ+maYI72iKg
	 K1LuUubp11GjbPvMSNuL9eiqnNKaZshbi/5YRokamWg3hJNCzEEUtsv7RNYzI82G2q
	 teU2oGM6v3LSm79aJti7fDrmQIah8VXMEHEf0XOsUyFI43tGQGdAMtGGM4MphqcBo1
	 reW2GF2sJxnD6OhatLsn3xSzs/elkhBB8JA2pvLgqW66cogB37e8GJ32JhtyNbmqg9
	 4WcGKLuty8Ryg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] wifi: rtl8xxxu: Fix LED control code of RTL8192FU
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <7a2c3158-3a45-4466-b11e-fc09802b20e2@gmail.com>
References: <7a2c3158-3a45-4466-b11e-fc09802b20e2@gmail.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 Jes Sorensen <Jes.Sorensen@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>,
 Zenm Chen <zenmchen@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170489852582.471554.12873126045489668197.kvalo@kernel.org>
Date: Wed, 10 Jan 2024 14:55:27 +0000 (UTC)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Some devices, like the Comfast CF-826F, use LED1, which already works.
> Others, like Asus USB-N13 C1, use LED0, which doesn't work correctly.
> 
> Write the right values to the LED control registers to make LED0 work
> as well.
> 
> This is unfortunately tested only with the Comfast CF-826F.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

9475cc7ac315 wifi: rtl8xxxu: Fix LED control code of RTL8192FU

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/7a2c3158-3a45-4466-b11e-fc09802b20e2@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


