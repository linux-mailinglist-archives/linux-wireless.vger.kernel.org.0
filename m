Return-Path: <linux-wireless+bounces-12399-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0727D96A519
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 19:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D877B2135E
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 17:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5B718D64F;
	Tue,  3 Sep 2024 17:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/tZpHKP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0011C14;
	Tue,  3 Sep 2024 17:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725383586; cv=none; b=OrMuNDuba6cl1ZXWRwikXarf5HsXpMOlv0+imx/VyWm/d/Dfwhu6+Gtzfz+pkdGBwJCJ0loFqjpAhpUB0/CXmIe9dePg0DHU6WCgUjvueRb7j3gE+RtBDZf0HrfNEmzrnr1oZAFh72V7FiZSeUVBaegT+k1rRM+Feud+acVWIwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725383586; c=relaxed/simple;
	bh=Nj3zSSXVJY7aWly8kxr2GE48AQpf8nGuG7nIWcYODkA=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=kr8JsBscUOcJtjQrwuNRli4zP339TvNboa5RcHgLC0in4TmRCExEKwBm4mqcyr0ztmqX/9oa9bEcOBgv9ObZSeSFc4bB723lpnJwCUzplQZNeYUK+aeDkasplhjIWbiPilJO0jQumsYbOy1D4V/JCrpMAwWzdWxX+qzEerg+PSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/tZpHKP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F172C4CEC4;
	Tue,  3 Sep 2024 17:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725383586;
	bh=Nj3zSSXVJY7aWly8kxr2GE48AQpf8nGuG7nIWcYODkA=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=K/tZpHKPktx2CDrKKwILBE5Iz1Y8z79gvdsJWC9j309s+u/+NcGpStngyWIcEhx8b
	 coRaxKR90TegAHXVr6mgSYoP2XIlGmrqNIHD6UGJdGrTTBqEptXRdnbJSwrNg98lnS
	 g4HkuHG5M5aKP2Nmm9bYcRC+Sze6B6Ttv8Sch12sTtVBjioNTgnSNRq2v/jekc5aiL
	 18v58Xu7kIhfVTao+/oWM3yWgj6flMIxKAQKRPKKZR0dK4FLA2zIaOV4D5Xd2TmM7m
	 u/L2TuHPQYmR1+ya5K9+N5D7BkJbdYtjsWPvb7m9CYm5zDFcRw/Kf4QdAxtZxASOII
	 4lt85LVd08KhQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v1 5/7] wifi: brcmfmac: of: Make use of
 irq_get_trigger_type()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240902225534.130383-6-vassilisamir@gmail.com>
References: <20240902225534.130383-6-vassilisamir@gmail.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: linux@armlinux.org.uk, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, nico@fluxnic.net,
 arend.vanspriel@broadcom.com, robh@kernel.org, saravanak@google.com,
 andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 devicetree@vger.kernel.org, vassilisamir@gmail.com
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172538357854.1029035.14523322695529094304.kvalo@kernel.org>
Date: Tue,  3 Sep 2024 17:13:00 +0000 (UTC)

Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Convert irqd_get_trigger_type(irq_get_irq_data(irq)) cases to the more
> simple irq_get_trigger_type().
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>

wireless patches go via wireless-next, please submit patches 5-6
separately.

2 patches set to Changes Requested.

13787792 [v1,5/7] wifi: brcmfmac: of: Make use of irq_get_trigger_type()
13787793 [v1,6/7] wifi: wlcore: sdio: Make use of irq_get_trigger_type()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240902225534.130383-6-vassilisamir@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html


