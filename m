Return-Path: <linux-wireless+bounces-4627-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B9B87979A
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 16:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5E561C20823
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 15:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27BD5B1E0;
	Tue, 12 Mar 2024 15:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsRfXypx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F06A58AD4
	for <linux-wireless@vger.kernel.org>; Tue, 12 Mar 2024 15:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710257584; cv=none; b=nje8nQq94wQQuPq+JzfT0JI3Ke2RD5KU/mptDfjBH5MNMkB0CckGtn5hzrxJaYdPysGgYnv0NyLtBMOzxpAh3cpO7sPuwlyoPOtKt6ggrrfioYAUGzRdYXAHDAzib/YwklaSeDla68dB1VnMTET9e6DAKQs39Mof4YfBWYFnWG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710257584; c=relaxed/simple;
	bh=2YRxSl3rpYldgwpApuR0qN4n7qANY3/Nx4rmF0Rk+hc=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=pwcUtsswhcZHnDbpuW5M2ExvZr9vlvZJewqvdk83HrF5+cshIYS0Upizib9ql4UlGqlQwKvZa1W2M+g0iUCKfBKiI0PMcudIX0SohYwMZ8Q5hD1OHQs6OZeBbgnnS6lOa2z7NI76KCo3EVbroScJgOXXZ+YhGHkPmHzA1JZ6duU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsRfXypx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81DDFC433F1;
	Tue, 12 Mar 2024 15:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710257584;
	bh=2YRxSl3rpYldgwpApuR0qN4n7qANY3/Nx4rmF0Rk+hc=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=IsRfXypxqARHAiKIJJfUu0yQf/qmkIO0ZC43l2BS5lMPHzRtw5Y0x3Pii/5w1bZP5
	 sX7uFtkRZKf0AbVyHjLUK76KERMiPz+P7TzhBGkPu2BTgtCx8f7Xx7msnJekdw2eJf
	 7E3pdrdgXAafGGE3sEsAUTlnLFWs8j9rp3BeutvEgxQEjNJ0W9MqWp56EQ4bGtCsIA
	 2FlAd4HaOj9L+LCcZpjjsX3syhRwKygKRLHXEvlXyEgWhpk3WkiNgo3/qwGWPvEoof
	 999JeN5xP3eKZTx3Ofbg2IGnKHj74lkLHeOQvGc4wbgwI+pAS4o3UK9cHnXguaoVG1
	 SoR84ks6LBt5w==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bcma: convert to platform remove callback returning void
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <a92e4b2f7aace64a1e3a91af7974a6982700a18f.1709886922.git.u.kleine-koenig@pengutronix.de>
References: 
 <a92e4b2f7aace64a1e3a91af7974a6982700a18f.1709886922.git.u.kleine-koenig@pengutronix.de>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 linux-wireless@vger.kernel.org, kernel@pengutronix.de
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171025758181.1969294.16929397784471774653.kvalo@kernel.org>
Date: Tue, 12 Mar 2024 15:33:03 +0000 (UTC)

Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:

> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Patch applied to wireless-next.git, thanks.

370e6231dfbd bcma: convert to platform remove callback returning void

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/a92e4b2f7aace64a1e3a91af7974a6982700a18f.1709886922.git.u.kleine-koenig@pengutronix.de/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


