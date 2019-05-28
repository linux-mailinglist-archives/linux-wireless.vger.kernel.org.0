Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8EF2C567
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2019 13:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfE1L34 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 May 2019 07:29:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45598 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfE1L34 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 May 2019 07:29:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 907246087F; Tue, 28 May 2019 11:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559042995;
        bh=FeM1B7S1k5cqeMl9o/LwP3eyRGc45nofIGS55xOJA/c=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=f1ycf40rL89EiOcxUDUmDz9dcZESnBm7u5eqK+EkY+/L1NrRr3wJ/W4IBOUs9wY+y
         In8wsZbOaGMOw62ovMxop67AQSwDGO8FOkI+dCtLB6tHPNGLm7b4W6m9fBbiklKmpz
         p9jIsS/vZK65Hl8fntuz50SExuEqe9aY79bEUOHc=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 570D3607C3;
        Tue, 28 May 2019 11:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559042995;
        bh=FeM1B7S1k5cqeMl9o/LwP3eyRGc45nofIGS55xOJA/c=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=ZZHnVDenG+hD2tZ9v/P5cNhkj99IosApMYyGXMEOIwQvk516ABmwEi/4hZ+bHEUSh
         G+l7y2Ma7wCsVZ7tHEJiT9sKORZh5c4gaDNUT0xCVLg+lP++6LwlJm0DIe2Ean/ETh
         AdmjD+0QXNTrnUrlengbmkmWyV9FGPdgEnYsvgYg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 570D3607C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 5.1] rtw88: fix subscript above array bounds compiler
 warning
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190506073917.10106-1-sgruszka@redhat.com>
References: <20190506073917.10106-1-sgruszka@redhat.com>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     linux-wireless@vger.kernel.org,
        Yan-Hsuan Chuang <yhchuang@realtek.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190528112955.907246087F@smtp.codeaurora.org>
Date:   Tue, 28 May 2019 11:29:55 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stanislaw Gruszka <sgruszka@redhat.com> wrote:

> My compiler complains about:
> 
> drivers/net/wireless/realtek/rtw88/phy.c: In function ‘rtw_phy_rf_power_2_rssi’:
> drivers/net/wireless/realtek/rtw88/phy.c:430:26: warning: array subscript is above array bounds [-Warray-bounds]
>   linear = db_invert_table[i][j];
> 
> According to comment power_db should be in range 1 ~ 96 .
> To fix add check for boundaries before access the array.
> 
> Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
> Acked-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

Patch applied to wireless-drivers.git, thanks.

8a03447dd311 rtw88: fix subscript above array bounds compiler warning

-- 
https://patchwork.kernel.org/patch/10930671/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

