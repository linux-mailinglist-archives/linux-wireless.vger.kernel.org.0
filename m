Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4996B273C30
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Sep 2020 09:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730066AbgIVHln (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Sep 2020 03:41:43 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:10488 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729751AbgIVHln (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Sep 2020 03:41:43 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600760502; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=oUtPTLeBFiuDVxK6/092BYw0o/DBJUk47gV+VLDbkIA=;
 b=j+rNr5KbsZgJuoZAB0nUoG59PciIj8fPWUSGkOwKSdIfKHPsDUCHgRlr0uVA4kNJyos/CqxM
 6p0tONJZhgYrJCVtC26fY41QgpnT+04aETtLcpK8MUwoZy9axfIRmeQOS0RzXd0Ro5pjxLf2
 A0GLLWuHb1fTtw7hVTHrmE9s55o=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f69aa9bfa736648e8cc38e7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 22 Sep 2020 07:41:15
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 61096C433CB; Tue, 22 Sep 2020 07:41:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5FAD0C433C8;
        Tue, 22 Sep 2020 07:41:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5FAD0C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH -next] ath11k: Add checked value for ath11k_ahb_remove
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200621095136.7xdbzkthoxuw2qow@debian.debian-2>
References: <20200621095136.7xdbzkthoxuw2qow@debian.debian-2>
To:     Bo YU <tsu.yubo@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, tsu.yubo@gmail.com
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200922074114.61096C433CB@smtp.codeaurora.org>
Date:   Tue, 22 Sep 2020 07:41:14 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bo YU <tsu.yubo@gmail.com> wrote:

> Return value form wait_for_completion_timeout should to be checked.
> 
> This is detected by Coverity: #CID:1464479 (CHECKED_RETURN)
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Signed-off-by: Bo YU <tsu.yubo@gmail.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

80b892fc8a90 ath11k: Add checked value for ath11k_ahb_remove

-- 
https://patchwork.kernel.org/patch/11616495/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

