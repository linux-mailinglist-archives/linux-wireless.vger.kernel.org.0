Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0437846DB17
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Dec 2021 19:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238908AbhLHSd5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Dec 2021 13:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbhLHSd5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Dec 2021 13:33:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B89C061746
        for <linux-wireless@vger.kernel.org>; Wed,  8 Dec 2021 10:30:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BCFEAB82075
        for <linux-wireless@vger.kernel.org>; Wed,  8 Dec 2021 18:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6D0C00446;
        Wed,  8 Dec 2021 18:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638988222;
        bh=JFZTihJJPe+GGj0J3PDuQcxUI14ZOEYHr2FDglmbDnE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=SmNyVMgq6EKc3F6LUoT//cHXFMeCYR0C08dd/RfBkjauTmUJTZMqF4Y21q1HH1qog
         VJRBhZmT3cAl4lze0ePjbjJJNZxJFQCwCUiEt3uNHlGjUPkSwFJviRTyxEhvR7+Eup
         Ixw4LDozYftHhGQceEnCAW1vh3+IqLMHQrSFxU+S6aFUJTfAa46wNviO99A7Nv2/dv
         xSOhHJVGGIFCXx2j317c8q0Wz+s1bpxJ94m6ATrsQ4XyzMWjaQqC9HOFts1odidEKb
         PIuefE8zum6wHrEiM9q08hxfa5y5JpUEf9MfNBmMPDxV0PEpD99TYGVqLfzYJeCI20
         xoquYUKFt4mBw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw89: fix sending wrong rtwsta->mac_id to firmware to
 fill
 address CAM
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211201080607.11211-1-pkshih@realtek.com>
References: <20211201080607.11211-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kvalo@codeaurora.org>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163898821940.25635.4887674169264372269.kvalo@kernel.org>
Date:   Wed,  8 Dec 2021 18:30:21 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> With wrong rtwsta->mac_id, it can't send out ack properly when we receive
> assoc response occasionally. Then, it failed to connect an AP.
> 
> The cause is that we store 'sta' and use it somewhere. To correct this,
> remove the variable and use mac_id in drv_priv of 'sta' or 'vif' passed
> by mac80211.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-drivers-next.git, thanks.

40822e079011 rtw89: fix sending wrong rtwsta->mac_id to firmware to fill address CAM

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211201080607.11211-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

