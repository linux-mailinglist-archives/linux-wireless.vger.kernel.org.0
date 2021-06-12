Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB773A4E3A
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jun 2021 12:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhFLKkG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Jun 2021 06:40:06 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:59144 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230459AbhFLKkD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Jun 2021 06:40:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623494284; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=WJKfHEJnbZdo8otfSAG/z+fj+JLmSR3mNXoH8Q9SGqQ=;
 b=VUobeBJdwkSTaAiV/R26jI1AUfpU1KwnrOErLXvDvswvjxuQLa6xYOzpF9s0ymfa2PVK6QcX
 NyAbuXaCFTK5qrIKlK1sSYFxoitv+xdVhVWtDg2c5Eq+X6WZ5n626nV80XtEi3MSl6tjQKqN
 UGtQGD3F0GKBp6dRS1QUaWBx274=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 60c48e8bb6ccaab7537ba349 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 12 Jun 2021 10:38:03
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 30C90C4338A; Sat, 12 Jun 2021 10:38:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2D5A8C433D3;
        Sat, 12 Jun 2021 10:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2D5A8C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] wireless: carl9170: fix LEDS build errors & warnings
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210530031134.23274-1-rdunlap@infradead.org>
References: <20210530031134.23274-1-rdunlap@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Christian Lamparter <chunkeey@googlemail.com>,
        linux-wireless@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210612103803.30C90C4338A@smtp.codeaurora.org>
Date:   Sat, 12 Jun 2021 10:38:03 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> wrote:

> kernel test robot reports over 200 build errors and warnings
> that are due to this Kconfig problem when CARL9170=m,
> MAC80211=y, and LEDS_CLASS=m.
> 
> WARNING: unmet direct dependencies detected for MAC80211_LEDS
>   Depends on [n]: NET [=y] && WIRELESS [=y] && MAC80211 [=y] && (LEDS_CLASS [=m]=y || LEDS_CLASS [=m]=MAC80211 [=y])
>   Selected by [m]:
>   - CARL9170_LEDS [=y] && NETDEVICES [=y] && WLAN [=y] && WLAN_VENDOR_ATH [=y] && CARL9170 [=m]
> 
> CARL9170_LEDS selects MAC80211_LEDS even though its kconfig
> dependencies are not met. This happens because 'select' does not follow
> any Kconfig dependency chains.
> 
> Fix this by making CARL9170_LEDS depend on MAC80211_LEDS, where
> the latter supplies any needed dependencies on LEDS_CLASS.
> 
> Fixes: 1d7e1e6b1b8ed ("carl9170: Makefile, Kconfig files and MAINTAINERS")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Cc: Christian Lamparter <chunkeey@googlemail.com>
> Cc: linux-wireless@vger.kernel.org
> Cc: Arnd Bergmann <arnd@arndb.de>
> Suggested-by: Christian Lamparter <chunkeey@googlemail.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Christian Lamparter <chunkeey@gmail.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

272fdc0c4542 wireless: carl9170: fix LEDS build errors & warnings

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210530031134.23274-1-rdunlap@infradead.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

