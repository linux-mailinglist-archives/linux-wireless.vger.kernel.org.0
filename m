Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B943B08CE
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jun 2021 17:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhFVP1B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Jun 2021 11:27:01 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:56076 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbhFVP0z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Jun 2021 11:26:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624375480; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=QBiR2dvj4W5lDYRv8mZ1n6ge+cEkkiiBArMH1RJ+mC4=;
 b=Dha3IPXoYmGG+PmMFWv/7HC/5F3YWKH6XKQTUbu+hCTAIegynRw+CPS05ULthohb/Ey4VKiV
 IiVeLtNIFITyIb42HjjI1m44AJyIhi1yUvATDGPANSiYg0ECLI7SZu76uy61nY367LvJlf1s
 5w/OkEjDdrGtKmsqKFGKIQ4U+Ds=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 60d2009b32b73d6b28258ae7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 22 Jun 2021 15:24:11
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 74439C43460; Tue, 22 Jun 2021 15:24:10 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 46588C43460;
        Tue, 22 Jun 2021 15:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 46588C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] mwl8k: Avoid memcpy() over-reading of mcs.rx_mask
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210617041431.2168953-1-keescook@chromium.org>
References: <20210617041431.2168953-1-keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Lunn <andrew@lunn.ch>, Kees Cook <keescook@chromium.org>,
        Lennert Buytenhek <buytenh@wantstofly.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Romain Perier <romain.perier@gmail.com>,
        Allen Pais <allen.lkml@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        wengjianfeng <wengjianfeng@yulong.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-hardening@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210622152410.74439C43460@smtp.codeaurora.org>
Date:   Tue, 22 Jun 2021 15:24:10 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kees Cook <keescook@chromium.org> wrote:

> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> field bounds checking for memcpy(), memmove(), and memset(), avoid
> intentionally reading across neighboring array fields. Use the
> sub-structure address directly.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Patch applied to wireless-drivers-next.git, thanks.

3f26f7665c5d mwl8k: Avoid memcpy() over-reading of mcs.rx_mask

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210617041431.2168953-1-keescook@chromium.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

