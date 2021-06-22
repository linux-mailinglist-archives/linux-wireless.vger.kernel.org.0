Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BEE3B08E6
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jun 2021 17:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbhFVP2O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Jun 2021 11:28:14 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:55658 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232328AbhFVP2N (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Jun 2021 11:28:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624375557; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=akNWlPwh03z/InvAsg7qxy/PuXCRIaHlyb13A6Z2OdQ=;
 b=NZcZl1qfu1Ze9mNwXJx//9Fu3wVNB1h339BQEM8dJ4lYSoYl2oMx0IQn8FblGM5HBOvpXOPu
 rtwx1VLNdNP3Qffng3Hm2qwziAieSJ+9tVThgIBfZmu7DOYWwCAJyQhL8R70KeFu+LQzNH5j
 J2F9AVB2va+GsJWtBw8WGHLO4qs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 60d200ea1200320241ef9762 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 22 Jun 2021 15:25:30
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D2849C43144; Tue, 22 Jun 2021 15:25:29 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5946BC433F1;
        Tue, 22 Jun 2021 15:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5946BC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mt7601u: add USB device ID for some versions of XiaoDu
 WiFi
 Dongle.
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210618160840.305024-1-whistler@member.fsf.org>
References: <20210618160840.305024-1-whistler@member.fsf.org>
To:     Wei Mingzhi <whistler@member.fsf.org>
Cc:     kubakici@wp.pl, davem@davemloft.net, matthias.bgg@gmail.com,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Wei Mingzhi <whistler@member.fsf.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210622152529.D2849C43144@smtp.codeaurora.org>
Date:   Tue, 22 Jun 2021 15:25:29 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wei Mingzhi <whistler@member.fsf.org> wrote:

> USB device ID of some versions of XiaoDu WiFi Dongle is 2955:1003
> instead of 2955:1001. Both are the same mt7601u hardware.
> 
> Signed-off-by: Wei Mingzhi <whistler@member.fsf.org>
> Acked-by: Jakub Kicinski <kubakici@wp.pl>

Patch applied to wireless-drivers-next.git, thanks.

829eea7c94e0 mt7601u: add USB device ID for some versions of XiaoDu WiFi Dongle.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210618160840.305024-1-whistler@member.fsf.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

