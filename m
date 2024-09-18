Return-Path: <linux-wireless+bounces-12962-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D34E97BD68
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 15:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57EEEB26089
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 13:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E711F189B98;
	Wed, 18 Sep 2024 13:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICZcOT7u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE1C18952B;
	Wed, 18 Sep 2024 13:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726667686; cv=none; b=rmsloMIu3p770YOkNMeY/fF65eCBDoBPvnS1F+1rAiyGkegNiRH0m48SOpweRnVc3TbtQaTG9KRaGVibSl2dBzFTgFGCBjx+G9UmMD55+4DOyXgLmnPVvnwxyKeToM5/P8n872qV0QPc9ydYP7yjWP/+0N7b8mBQNOGCK9oQEbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726667686; c=relaxed/simple;
	bh=6mfPuW2OrQ3u4Vz8WQRToWHI8ZQ7Z4AAQX9AwXG/BbA=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=TSG4ZJnZ4cM++tfhFjQeU4cMefrTHMBU6tRzYuPPFG4PLVq4UoJRcDXYJ/QHCwTfRz/M7NWqKxIXdjOXUx3G8jXuOk9vWmYp4qgFcwNN0fszNLYHtxftoQbkDpg3xEWhxj5yA4SFOP3eDZjAgT4Xmqb/xjiZecBr9qqXSnpO6oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICZcOT7u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92695C4CEC2;
	Wed, 18 Sep 2024 13:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726667686;
	bh=6mfPuW2OrQ3u4Vz8WQRToWHI8ZQ7Z4AAQX9AwXG/BbA=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=ICZcOT7uGoKE1x3XEDpa09045Z+xhTXSHUVzcDFX6ofGdHTxJWmwKDWcL9Dj3SqUT
	 Aq1GRDRVPR014NXSqlQn6UT3L2zosLzKRBUzndDXAt1oj4PyqYPIzEr/7ehLcdI1Eh
	 FXhNj8atervC01QALjIy+kypgzb08CmMkuGzzPOQsH2kIGtD9iyz4tQ/4wX0JnclRU
	 OOV/XI+A+JI+Mq6b87UtRAkvvE9Arx1GNuGS/JPem+Kr6V2SZuRi+1qJQzJ6408IJQ
	 S1PswI+rRQmN6Kl7UKP8RdBGtlZYEAES16C9ixV9XTxRr5O2ieWocKW0Wp+pPBfgRz
	 Gvtvrj5vo4Tmg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless v2 1/3] wifi: p54: Use IRQF_NO_AUTOEN flag in
 request_irq()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240910124314.698896-2-ruanjinjie@huawei.com>
References: <20240910124314.698896-2-ruanjinjie@huawei.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: <chunkeey@googlemail.com>, <briannorris@chromium.org>,
 <francesco@dolcini.it>, <krzysztof.kozlowski@linaro.org>,
 <leitao@debian.org>, <linville@tuxdriver.com>, <rajatja@google.com>,
 <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <ruanjinjie@huawei.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172666768193.3996465.10777431378652595060.kvalo@kernel.org>
Date: Wed, 18 Sep 2024 13:54:43 +0000 (UTC)

Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> disable_irq() after request_irq() still has a time gap in which
> interrupts can come. request_irq() with IRQF_NO_AUTOEN flag will
> disable IRQ auto-enable when request IRQ.
> 
> Fixes: cd8d3d321285 ("p54spi: p54spi driver")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

3 patches applied to wireless-next.git, thanks.

bcd1371bd85e wifi: p54: Use IRQF_NO_AUTOEN flag in request_irq()
9a98dd48b6d8 wifi: mwifiex: Use IRQF_NO_AUTOEN flag in request_irq()
5a4d42c1688c wifi: wl1251: Use IRQF_NO_AUTOEN flag in request_irq()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240910124314.698896-2-ruanjinjie@huawei.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


