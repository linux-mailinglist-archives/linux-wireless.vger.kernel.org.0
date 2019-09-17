Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5AA6B4FF3
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2019 16:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfIQOId (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Sep 2019 10:08:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48424 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfIQOId (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Sep 2019 10:08:33 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 658B1613A8; Tue, 17 Sep 2019 14:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568729312;
        bh=5wstTaol9OEkbdIh5bH2JEcOWDwQTs42JwDygN0c5K4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=JiDNSU5z5U3zrBl14WbZT3ufHNfwxpAjAQGKVcQQHpm6j5LWkdSgJOnxkD6zz/osD
         90SiHba6y19CR49nD1xAMbaQkblz489lBaykVuAIfdgJWtdDn3kwYGAII6KpMW7WGr
         /FtZHsqX5TvvTPtsB/5k5KAhsiyf+JrVsQWO50eo=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B529B6021C;
        Tue, 17 Sep 2019 14:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568729312;
        bh=5wstTaol9OEkbdIh5bH2JEcOWDwQTs42JwDygN0c5K4=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=F3GuoGxkGdAgLc5l6g2fxO0MgWhfTbkkYMAgTq7gqlfFcCZHuNuUftZDZS5Rm+Zfd
         5qvRpw3+83CUpCIaKUqb0muiCBDENIjwv9OMoz4n+vflguGyPT+IuPX8AMnT0yazdy
         b28imho1BFRyY/LwaNJTB3HsuB/7ilbi6DG7xtTk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B529B6021C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] ath10k: avoid leaving .bss_info_changed prematurely
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190703141949.9295-1-sven@narfation.org>
References: <20190703141949.9295-1-sven@narfation.org>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Sven Eckelmann <seckelmann@datto.com>,
        Sriram R <srirrama@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190917140832.658B1613A8@smtp.codeaurora.org>
Date:   Tue, 17 Sep 2019 14:08:32 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sven Eckelmann <sven@narfation.org> wrote:

> ath10k_bss_info_changed() handles various events from the upper layers. It
> parses the changed bitfield and then configures the driver/firmware
> accordingly. Each detected event is handled in a separate scope which is
> independent of each other - but in the same function.
> 
> The commit f279294e9ee2 ("ath10k: add support for configuring management
> packet rate") changed this behavior by returning from this function
> prematurely when some precondition was not fulfilled. All new event
> handlers added after the BSS_CHANGED_BASIC_RATES event handler would then
> also be skipped.
> 
> Signed-off-by: Sven Eckelmann <seckelmann@datto.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

0227ff3656f2 ath10k: avoid leaving .bss_info_changed prematurely

-- 
https://patchwork.kernel.org/patch/11029683/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

