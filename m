Return-Path: <linux-wireless+bounces-16325-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 371799EFA52
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 19:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32A341890E5F
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 18:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4156223C4E;
	Thu, 12 Dec 2024 18:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fx1O2n/D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D71B223C4A;
	Thu, 12 Dec 2024 18:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026548; cv=none; b=AQrNfjpFvBfcNc91IFZS1XsOJNJ99egukVn4gntvc16ataBlwqUlLMd5bjXqxbD4o1lU7yWksVPWL4ydAjW3p7s3tuD1lSvlRRICg+cC3J53V+0RAdqKE7Dboxd7j21RsGKDD8rELb0mklaEozN8aaAuGALM3lNTkRN4kIGw+60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026548; c=relaxed/simple;
	bh=Uif3QDEnAOMvC10YitD6AAmrgRJA9UGiXLhFAz+1Htg=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=LofbiArTY8kwMDs9bSaV+wrC+Kf9Ltu6ZV9Un2uakcvSrLPXLlS4b7RGPDNWgKuWwva0K2z3JompiBJUwz40HaYGrigp3T90jcW+h+IxprG/k72uuH5LslvEd2yXxBGevW6FrfLCkqnZWkceU9Z2vuAUjh1oq8pd0g0Au8DhOdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fx1O2n/D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8045CC4CECE;
	Thu, 12 Dec 2024 18:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734026548;
	bh=Uif3QDEnAOMvC10YitD6AAmrgRJA9UGiXLhFAz+1Htg=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=fx1O2n/DcINXOsnBc+UeGAC4EfyZhAPPUDGff8CMIN6TeUCtuFotKOSx5VLiE9pal
	 lnezVDE7Rl6HkS8GF1cQmZMxkIkYq4mDB1VbvH4nXdr0YzIZ5NA4BKqAtb31NVwBkN
	 YBfmIZkYhQNKSq231emHjp1ac0zJ/suDjtTvo1i7KACF6Gx4oIqrSUAGoSB5Ld+0d0
	 Rhv4iC/AZ0p0Yo88skJ9TGOvwIfLD+PsiDen6inzwESUGgdWSv5LVE9m093ojBbgag
	 U/ABFVgrGB+oVWtjl3UwEepJVCDfvl44jZ6muTSdybr16Z7NLZY+xCGbqTYnqz0+sA
	 8CJ+En12Wt/Qw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: qtnfmac: fix spelling error in core.h
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20241209062425.4139-1-liujing@cmss.chinamobile.com>
References: <20241209062425.4139-1-liujing@cmss.chinamobile.com>
To: Liu Jing <liujing@cmss.chinamobile.com>
Cc: imitsyanko@quantenna.com, geomatsi@gmail.com, johannes.berg@intel.com,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 Liu Jing <liujing@cmss.chinamobile.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173402654446.853073.13797999061536602834.kvalo@kernel.org>
Date: Thu, 12 Dec 2024 18:02:26 +0000 (UTC)

Liu Jing <liujing@cmss.chinamobile.com> wrote:

> Fix specific spelling error in core.h.
> 
> Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
> 
> diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.h b/drivers/net/wireless/quantenna/qtnfmac/core.h
> index b375a4751580..a377d85c2451 100644
> --- a/drivers/net/wireless/quantenna/qtnfmac/core.h
> +++ b/drivers/net/wireless/quantenna/qtnfmac/core.h
> @@ -102,7 +102,7 @@ struct qtnf_wmac {
>  	struct qtnf_mac_info macinfo;
>  	struct qtnf_vif iflist[QTNF_MAX_INTF];
>  	struct cfg80211_scan_request *scan_req;
> -	struct mutex mac_lock;	/* lock during wmac speicific ops */
> +	struct mutex mac_lock;	/* lock during wmac specific ops */
>  	struct delayed_work scan_timeout;
>  	struct ieee80211_regdomain *rd;
>  	struct platform_device *pdev;

Patch applied to wireless-next.git, thanks.

73e456b402fa wifi: qtnfmac: fix spelling error in core.h

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20241209062425.4139-1-liujing@cmss.chinamobile.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


