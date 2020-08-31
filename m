Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3506C257BF5
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Aug 2020 17:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgHaPOh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Aug 2020 11:14:37 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:44186 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728143AbgHaPOf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Aug 2020 11:14:35 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598886875; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=C08wNUsYTzB5AdfLy6zi8cAoZnfb3YPVv7p7dBqcL54=;
 b=u2z71h03fkYevpmicMKIAbJoBlXCAB98IV8DbdpJAG+6moxve9nTGWNZvUsr4rkdUH+SkGNy
 bTbMUbJPwhhIcWO83fnmfCLJdwSKmIE10ALyv8lsS7HshZj4kSnXsxiR+u+1u6ykIKqqN5bc
 A0p/qnw3Mwnu1ZHWrg7AZRhIqpc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5f4d13d1947f606f7e63e7e6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 31 Aug 2020 15:14:25
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 88955C433AD; Mon, 31 Aug 2020 15:14:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6DB90C433CA;
        Mon, 31 Aug 2020 15:14:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6DB90C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 04/16] wireless: ath11k: convert tasklets to use new
 tasklet_setup() API
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200817090637.26887-5-allen.cryptic@gmail.com>
References: <20200817090637.26887-5-allen.cryptic@gmail.com>
To:     Allen Pais <allen.cryptic@gmail.com>
Cc:     kuba@kernel.org, jirislaby@kernel.org, mickflemm@gmail.com,
        mcgrof@kernel.org, chunkeey@googlemail.com,
        Larry.Finger@lwfinger.net, stas.yakovlev@gmail.com,
        helmut.schaa@googlemail.com, pkshih@realtek.com,
        yhchuang@realtek.com, dsd@gentoo.org, kune@deine-taler.de,
        keescook@chromium.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, b43-dev@lists.infradead.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, Allen Pais <allen.lkml@gmail.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200831151424.88955C433AD@smtp.codeaurora.org>
Date:   Mon, 31 Aug 2020 15:14:24 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Allen Pais <allen.cryptic@gmail.com> wrote:

> In preparation for unconditionally passing the
> struct tasklet_struct pointer to all tasklet
> callbacks, switch to using the new tasklet_setup()
> and from_tasklet() to pass the tasklet pointer explicitly.
> 
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

c08279a93191 ath11k: convert tasklets to use new tasklet_setup() API

-- 
https://patchwork.kernel.org/patch/11717399/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

