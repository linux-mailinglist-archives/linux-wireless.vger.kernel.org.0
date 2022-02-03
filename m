Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748D34A806D
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Feb 2022 09:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239717AbiBCI04 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Feb 2022 03:26:56 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46428 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345671AbiBCI0v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Feb 2022 03:26:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3FE4DB83369
        for <linux-wireless@vger.kernel.org>; Thu,  3 Feb 2022 08:26:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A8BC340E4;
        Thu,  3 Feb 2022 08:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643876809;
        bh=5rDIi4DllC9I+53pKYv4b9HludfV+rlezW8nhtn9ETk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ZfrfwCVi+VobBdFzk4pQjL66cx2mBGThxoGPPa1uSJFQV7S0oxMI/EJOb8l8WirzW
         eENjcVf2sEFVxPGMeg7neVdUiRYkbV/yRSgNbYYvEMwaU9b88aidRg1M8HE1zhYgY1
         Vm4kVWkITgrihkP0Y3/KSw7lmbs4fk83qi/n02qIwXWLU/pRLo7i3qQKP6tVKmom7t
         dn37R3/YdqZbNPQFx2ytJF27QPrfVu6ZMREkq42tPvPDhJaCWOetjlTceZ6Z+lAnv/
         2jDRmcCgVcIzRPV2fnM9srtBaOQDhMS3ZN7lzwIX05xKPBIOGcLNyOjy0UuyeB3rc4
         ahS4l47I4eIPQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [for,v5.17,1/2] iwlwifi: remove deprecated broadcast filtering
 feature
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <iwlwifi.20220128144623.9241e049f13e.Ia4f282813ca2ddd24c13427823519113f2bbebf2@changeid>
References: <iwlwifi.20220128144623.9241e049f13e.Ia4f282813ca2ddd24c13427823519113f2bbebf2@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164387680508.14378.16869781709152119153.kvalo@kernel.org>
Date:   Thu,  3 Feb 2022 08:26:48 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Luca Coelho <luciano.coelho@intel.com>
> 
> This feature has been deprecated and should not be used anymore.  With
> newer firmwares, namely *-67.ucode and above, trying to use it causes an
> assertion failure in the FW, similar to this:
> 
> [Tue Jan 11 20:05:24 2022] iwlwifi 0000:04:00.0: 0x00001062 | ADVANCED_SYSASSERT
> 
> In order to prevent this feature from being used, remove it entirely
> and get rid of the Kconfig option that
> enables it (IWLWIFI_BCAST_FILTERING).
> 
> Fixes: cbaa6aeedee5 ("iwlwifi: bump FW API to 67 for AX devices")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215488
> Cc: stable@vger.kernel.org # 5.16.x
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

2 patches applied to wireless.git, thanks.

92883a524ae9 iwlwifi: remove deprecated broadcast filtering feature
5f06f6bf8d81 iwlwifi: mvm: don't send SAR GEO command for 3160 devices

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/iwlwifi.20220128144623.9241e049f13e.Ia4f282813ca2ddd24c13427823519113f2bbebf2@changeid/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

