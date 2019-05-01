Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEDA10B9F
	for <lists+linux-wireless@lfdr.de>; Wed,  1 May 2019 18:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfEAQxk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 May 2019 12:53:40 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42142 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfEAQxj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 May 2019 12:53:39 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EE194607DF; Wed,  1 May 2019 16:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556729618;
        bh=VI/TlFKnT8iKipxw8mTVNjcXTnCvu1batgDTgEr6VxU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=m8eOU3Chfhl5fd1XuDisExiJ2SdHkQXSPNetisIVnQdLkUOAYrw44zEBeMEpX8g7M
         PBWBXC9leZgz/PptzGCC9iL/f6NsCzNAEK4/DTvwxpd73B5WrHgzrcOZI0Kn47KE40
         rD7Ls1fM9C/aVp8BPrNm+vrTISzvBr3LiGTnknsI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D09F260275;
        Wed,  1 May 2019 16:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556729618;
        bh=VI/TlFKnT8iKipxw8mTVNjcXTnCvu1batgDTgEr6VxU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=m8eOU3Chfhl5fd1XuDisExiJ2SdHkQXSPNetisIVnQdLkUOAYrw44zEBeMEpX8g7M
         PBWBXC9leZgz/PptzGCC9iL/f6NsCzNAEK4/DTvwxpd73B5WrHgzrcOZI0Kn47KE40
         rD7Ls1fM9C/aVp8BPrNm+vrTISzvBr3LiGTnknsI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D09F260275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: pull request: mt76 2019-05-01
References: <6ec922a9-1ed9-9ef2-0043-65fcd242b1fd@nbd.name>
Date:   Wed, 01 May 2019 19:53:35 +0300
In-Reply-To: <6ec922a9-1ed9-9ef2-0043-65fcd242b1fd@nbd.name> (Felix Fietkau's
        message of "Wed, 1 May 2019 13:05:09 +0200")
Message-ID: <87ef5inmk0.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> here's my first pull request for 5.2
>
> - Felix
>
> The following changes since commit e3037485c68ec1a299ff41160d8fedbd4abc29b9:
>
>   rtw88: new Realtek 802.11ac driver (2019-04-30 19:43:37 +0300)
>
> are available in the Git repository at:
>
>   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2019-05-01
>
> for you to fetch changes up to 4d2a6f7b4e17ede86be46013d114d58adaca5631:
>
>   mt76: mt7603: dynamically alloc mcu req in mt7603_mcu_set_eeprom (2019-05-01 13:04:00 +0200)
>
> ----------------------------------------------------------------
> mt76 patches for 5.2
>
> * share more code across drivers
> * new driver for MT7615 chipsets
> * rework DMA API
> * tx/rx performance optimizations
> * use NAPI for tx cleanup on mt76x02
> * AP mode support for USB devices
> * USB stability fixes
> * tx power handling fixes for 76x2
> * endian fixes
>
> ----------------------------------------------------------------

Pulled, thanks Felix.

-- 
Kalle Valo
