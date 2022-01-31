Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482234A49D9
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Jan 2022 16:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349143AbiAaPIb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Jan 2022 10:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242525AbiAaPIb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Jan 2022 10:08:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C67C061714
        for <linux-wireless@vger.kernel.org>; Mon, 31 Jan 2022 07:08:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6034BB82AB2
        for <linux-wireless@vger.kernel.org>; Mon, 31 Jan 2022 15:08:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1F0C340EF;
        Mon, 31 Jan 2022 15:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643641708;
        bh=3zKxdeETFxr1a/79OocE/JHiQlVeaG49m4EjTJWV1s4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=pl5X+kVNMB8xbYUQLJzBsRW4ijAzcFDVGeIhYSsJFg5MuRwK4iDlpic/UG8Rlf2OO
         wvv9DQcy3D6aiBmKXbnxWd6zuB3V53UnCK2ooj16YmM7mTpXpIiK7UVqZ31XOEsLQE
         1tUIeZvVek9Rk3Xv2M/vR+9970XTYC3ytEwh7FmZpVFVWGtdtwX3Yw4/Vk4PSCtpJ4
         goX7hq0Trt90PGltYHBchNhiGhLO2RH9H2c4waiRHG/443TutWdWljtkCR9CyBAN/O
         cQAHauV0nTKA7ytE78VqQw+FrlRL0mcVlOXX/sDlF37bmWFlUcKpCpC/hRN3F+yQOw
         yAIo8TiESb5ug==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wright Feng <wright.feng@infineon.com>
Cc:     <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list@broadcom.com>,
        <SHA-cyfmac-dev-list@infineon.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@infineon.com>
Subject: Re: [PATCH] MAINTAINERS: update maintainer list for Infineon
References: <20211228061315.11126-1-wright.feng@infineon.com>
Date:   Mon, 31 Jan 2022 17:08:22 +0200
In-Reply-To: <20211228061315.11126-1-wright.feng@infineon.com> (Wright Feng's
        message of "Tue, 28 Dec 2021 00:13:15 -0600")
Message-ID: <87czk8djtl.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wright Feng <wright.feng@infineon.com> writes:

> From: Chi-Hsien Lin <chi-hsien.lin@infineon.com>
>
> Add new maintainer and remove old maintainers.
>
> Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@infineon.com>
> Signed-off-by: Wright Feng <wright.feng@infineon.com>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5ebfc9de0caf..845058803f95 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3759,9 +3759,9 @@ BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER
>  M:	Arend van Spriel <aspriel@gmail.com>
>  M:	Franky Lin <franky.lin@broadcom.com>
>  M:	Hante Meuleman <hante.meuleman@broadcom.com>
> -M:	Chi-hsien Lin <chi-hsien.lin@infineon.com>
>  M:	Wright Feng <wright.feng@infineon.com>
> -M:	Chung-hsien Hsu <chung-hsien.hsu@infineon.com>
> +M:	Double Lo <double.lo@infineon.com>
> +M:	Kurt Lee <kurt.lee@infineon.com>

I'm not really a fan of having too many maintainers, I would say max is
3 and even that needs good justification. And most importantly, is
anyone else than Arend even doing any maintainer work for brcmfmac and
brcmsmac?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
