Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3BD235806
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Aug 2020 17:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgHBPSK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 11:18:10 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:28607 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726472AbgHBPSJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 11:18:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596381488; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=vKihmOagz1/Sbz+0RT9b80J6b/3QyMKBydo3NzpUqTQ=;
 b=dk7uov5IB6MjEJ16vCZNhUoAJcEMwxD24Xhn+L5Oeafo9DKdcDGf6SGx+n6JqGFy1IQFGHMN
 pzkD7Pr6JXg+jtpEc2dbJUL+jctW/FLzu+b/hBQi5kwEP2LcSjo/dlwQAt/C0OZESIuX+/pH
 kACljJhr1zZZeao7n+F5qoDe9f0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5f26d920798b10296800c69b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 02 Aug 2020 15:17:52
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E884DC43391; Sun,  2 Aug 2020 15:17:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 77466C433C6;
        Sun,  2 Aug 2020 15:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 77466C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH for v5.9] b43legacy: Replace HTTP links with HTTPS ones
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200719111124.58167-1-grandmaster@al2klimov.de>
References: <20200719111124.58167-1-grandmaster@al2klimov.de>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     Larry.Finger@lwfinger.net, davem@davemloft.net, kuba@kernel.org,
        linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200802151751.E884DC43391@smtp.codeaurora.org>
Date:   Sun,  2 Aug 2020 15:17:51 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>

Patch applied to wireless-drivers-next.git, thanks.

140c6026167b b43legacy: Replace HTTP links with HTTPS ones

-- 
https://patchwork.kernel.org/patch/11672427/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

