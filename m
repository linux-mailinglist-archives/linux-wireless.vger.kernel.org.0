Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8319B2210AF
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2020 17:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgGOPRk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jul 2020 11:17:40 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:54067 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbgGOPRk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jul 2020 11:17:40 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594826259; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=tOZFP/klG7vNJndiBNDrNIJYWKwCiCWq64q01roen4w=;
 b=N6Tj65HPZzsqVtnxqfrHV9ES+R3biAJ6+4OqWqtnUJL3O7kRhv5Jpaj/IiLKP+ZqopOjuMIz
 DcLvCj6mZngm0SmtufwvHXZUVwkJuG6VSrKTEUHmGTAj+X6zJsoJIHZESt7GH4PMuUBNjHKh
 Xkff79GlWRTlUmOWZm9x9FKXMy8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n16.prod.us-west-2.postgun.com with SMTP id
 5f0f1e06b35196d59d300d2e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 15 Jul 2020 15:17:26
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 03350C433C6; Wed, 15 Jul 2020 15:17:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 79F26C433C6;
        Wed, 15 Jul 2020 15:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 79F26C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/1] ath9k: Fix regression with Atheros 9271
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200711043324.8079-1-shiftee@posteo.net>
References: <20200711043324.8079-1-shiftee@posteo.net>
To:     Mark O'Donovan <shiftee@posteo.net>
Cc:     linux-wireless@vger.kernel.org, jaegerskuepper@freenet.de,
        hqjagain@gmail.com, ath9k-devel@qca.qualcomm.com,
        davem@davemloft.net, kuba@kernel.org,
        Mark O'Donovan <shiftee@posteo.net>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200715151726.03350C433C6@smtp.codeaurora.org>
Date:   Wed, 15 Jul 2020 15:17:26 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Mark O'Donovan <shiftee@posteo.net> wrote:

> This fix allows ath9k_htc modules to connect to WLAN once again.
> 
> Fixes: 2bbcaaee1fcb (ath9k: Fix general protection fault in
> ath9k_hif_usb_rx_cb )
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=208251

These should be:

Fixes: 2bbcaaee1fcb ("ath9k: Fix general protection fault in ath9k_hif_usb_rx_cb")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=208251

But I can fix those during commit.

There are basically two options now, either take this patch or revert commit 2bbcaaee1fcb:

https://patchwork.kernel.org/patch/11637341/

I prefer taking Mark's patch but I would appreciate if people could provide
testing feedback.

-- 
https://patchwork.kernel.org/patch/11657669/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

