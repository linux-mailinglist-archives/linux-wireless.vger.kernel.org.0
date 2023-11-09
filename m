Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546807E6914
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Nov 2023 12:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbjKILB3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Nov 2023 06:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbjKILBW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Nov 2023 06:01:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03A42D6D
        for <linux-wireless@vger.kernel.org>; Thu,  9 Nov 2023 03:01:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB8DC433C7;
        Thu,  9 Nov 2023 11:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699527679;
        bh=9AClZ2pZKcV2/vsBMHfcBjPVikHmI9SjLKsxQwM/pXY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=WJLc70HDI8Z1wtVLlFHOawtb0gfOyNnZA3CDj117VRUuaGuK9Lm8Zu1I9ZQlAMNXY
         UpdIyysGfvnMFPjAwUDNjEggIv/ZxtG/tD5ZEwppDn1WdviLErAzJwMtWsk7LgZ0ac
         155FJqmnnjmVlRbwHVsxeIiafHoYWHG4393zehVwXrt4ZV9yz8wY580maZpR3e5kCV
         0L+vaBrwhscdLHWZI3nTFTCYv+UAUTI4ucmWgRpP1oa1RSSskN73Vn+UwE7ni0zA22
         N1p/PAmZRUghjZzP1GemowPDO+w3WUNsOiWoJfzTsXN+4AZUVCML9XRY8Hlr71gZRX
         pW9z3d/O7l9+Q==
From:   Kalle Valo <kvalo@kernel.org>
To:     Vinayak Yadawad <vinayak.yadawad@broadcom.com>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        jithu.jance@broadcom.com
Subject: Re: [PATCH v2 1/1] wifi: nl80211: Extend del pmksa support for SAE
 and OWE security
References: <083b63a2e6f5ae42e11e4044350a28cea8d462b7.1699426085.git.vinayak.yadawad@broadcom.com>
Date:   Thu, 09 Nov 2023 13:01:16 +0200
In-Reply-To: <083b63a2e6f5ae42e11e4044350a28cea8d462b7.1699426085.git.vinayak.yadawad@broadcom.com>
        (Vinayak Yadawad's message of "Wed, 8 Nov 2023 12:19:08 +0530")
Message-ID: <87leb79on7.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Vinayak Yadawad <vinayak.yadawad@broadcom.com> writes:

> Current handling of del pmksa with SSID is limited to FILS
> security. In the current change the del pmksa support is extended
> to SAE/OWE security offloads as well. For OWE/SAE offloads, the
> PMK is generated and cached at driver/FW, so user app needs the
> capability to request cache deletion based on SSID for drivers
> supporting SAE/OWE offload.
> ---
> v1->v2: Addressed review comments for indentation
> Signed-off-by: Vinayak Yadawad <vinayak.yadawad@broadcom.com>

The s-o-b should be before the "---" line.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
