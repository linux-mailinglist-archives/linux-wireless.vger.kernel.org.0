Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3395464EFF
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Dec 2021 14:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349620AbhLANvX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Dec 2021 08:51:23 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:60550 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349641AbhLANug (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Dec 2021 08:50:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 139F0CE1E65
        for <linux-wireless@vger.kernel.org>; Wed,  1 Dec 2021 13:47:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B20C53FAD;
        Wed,  1 Dec 2021 13:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638366433;
        bh=otbsTxIVh1rr6Hhf3d/MnlwSeX3CjnoNqhsj5vyMA48=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=YXWWJjGL3OQjI62QNaVDhDpC6TSa/0GqCsUXfz6KwmeYeD/HvC2jNuDEjZCEYR11T
         bblmVZJF/bKyiAq531cvY1hxwfcEe3RJYVKUXOW9Zu2jc0k0qHy5YawGo0MNNMZ2qY
         suMVM1DPKAsjdxubJ3uVL+LwP/qTmLExtuqXAsFBY33360ZaGaNSeoFcUkxw9V/yEv
         J83LcJT46VYYpAUUzqLhD2ap2sdhy/oVkYZDFkXk0oNngzECFRcT9tZMJ/Y6c/0SG1
         /cz6pU/2TkPXH9z561RJW2YA2xIYNgMxaaVYgVAOugXgXJly/sbcFqUNKyGyHKTlbr
         BZCm9N6GJHD6g==
From:   Kalle Valo <kvalo@kernel.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 16/16] cfg80211: Acquire wiphy mutex on regulatory work
References: <20211129133248.83829-1-luca@coelho.fi>
        <iwlwifi.20211129152938.faf291271590.I40ad9372a47cbad53b4aae7b5a6ccc0dc3fddf8b@changeid>
Date:   Wed, 01 Dec 2021 15:47:10 +0200
In-Reply-To: <iwlwifi.20211129152938.faf291271590.I40ad9372a47cbad53b4aae7b5a6ccc0dc3fddf8b@changeid>
        (Luca Coelho's message of "Mon, 29 Nov 2021 15:32:48 +0200")
Message-ID: <87bl20saht.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> From: Ilan Peer <ilan.peer@intel.com>
>
> The function cfg80211_reg_can_beacon_relax() expects wiphy
> mutex to be held when it is being called. However, when
> reg_leave_invalid_chans() is called the mutex is not held.
> Fix it by acquiring the lock before calling the function.
>
> Fixes: a05829a7222e ("cfg80211: avoid holding the RTNL when calling the driver")
> Signed-off-by: Ilan Peer <ilan.peer@intel.com>
> Fixes: a05829a7222e ("cfg80211: avoid holding the RTNL when calling the driver")

Duplicate Fixes tags.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
