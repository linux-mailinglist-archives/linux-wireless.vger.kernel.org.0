Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571DC4286A6
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 08:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbhJKGL5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 02:11:57 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:54653 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbhJKGL4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 02:11:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633932595; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=TpfG1WYDfAVppP0rLatznHaMsvv90u64ZEh5Fo6Gw3Y=;
 b=mHiuJ0U2HKY1x1cIOt0WtWy238ox1vcoJw7gJGmXCGbt1OQ4dbt5GFOFsXeUw8cj61Z7nKdb
 kVObvEcoa9pUOt3wBqQ0qBHT4ffacuoystd9ffRFENmuzsrr/HsZQt9RSi7DLJCR7uTu7JyC
 BwnphT2F20f6zFy91xjC/XaxSIE=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 6163d53103355859c8246092 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Oct 2021 06:09:53
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4FF11C4360C; Mon, 11 Oct 2021 06:09:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AB4ABC4338F;
        Mon, 11 Oct 2021 06:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org AB4ABC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] b43legacy: fix a lower bounds test
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20211006073542.GD8404@kili>
References: <20211006073542.GD8404@kili>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org,
        kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163393258963.11913.9834603879232230405.kvalo@codeaurora.org>
Date:   Mon, 11 Oct 2021 06:09:53 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> wrote:

> The problem is that "channel" is an unsigned int, when it's less 5 the
> value of "channel - 5" is not a negative number as one would expect but
> is very high positive value instead.
> 
> This means that "start" becomes a very high positive value.  The result
> of that is that we never enter the "for (i = start; i <= end; i++) {"
> loop.  Instead of storing the result from b43legacy_radio_aci_detect()
> it just uses zero.
> 
> Fixes: 75388acd0cd8 ("[B43LEGACY]: add mac80211-based driver for legacy BCM43xx devices")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Acked-by: Michael Büsch <m@bues.ch>

2 patches applied to wireless-drivers-next.git, thanks.

c1c8380b0320 b43legacy: fix a lower bounds test
9b793db5fca4 b43: fix a lower bounds test

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211006073542.GD8404@kili/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

