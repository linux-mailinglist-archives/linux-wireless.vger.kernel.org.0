Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0FC41B2C9
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Sep 2021 17:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241294AbhI1PTK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Sep 2021 11:19:10 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:30682 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241509AbhI1PTK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Sep 2021 11:19:10 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632842250; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=ZR2sJrlc8RTC1uxRbiguSPjYVpPg+2YaLq//aNbn0Mc=; b=iSur05xE2QxSXixOcIfRBBoM4Vn/qAbSixN0jWOzLkiLMqvHJdIHaJWj2HyvIW38PCD9ZWXs
 woZehe9Vs+D0ag35IGoJ8fdQjOS9llFtqLZNQaNzgPv6gVqzOnMDi7Vx51AA0hUxWXGirFxl
 J4UzJDudWlVFG5YpH/l/Q4ERSAs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 615330cd9ffb413149f97b1c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 28 Sep 2021 15:12:13
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B50C4C4360C; Tue, 28 Sep 2021 15:12:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 32951C4338F;
        Tue, 28 Sep 2021 15:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 32951C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Jouni Malinen <jouni@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Baochen Qiang <bqiang@codeaurora.org>
Subject: Re: [PATCH 1/3] ath11k: Change number of TCL rings to one for QCA6390
References: <20210914163726.38604-1-jouni@codeaurora.org>
Date:   Tue, 28 Sep 2021 18:12:08 +0300
In-Reply-To: <20210914163726.38604-1-jouni@codeaurora.org> (Jouni Malinen's
        message of "Tue, 14 Sep 2021 19:37:24 +0300")
Message-ID: <87tui4pwdz.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jouni Malinen <jouni@codeaurora.org> writes:

> From: Baochen Qiang <bqiang@codeaurora.org>
>
> Some targets, QCA6390 for example, use only one TCL ring,
> it is better to initialize only one ring and leave others
> untouched for such targets.
>
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
>
> Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>
> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>

It's better? Please be more specific. Does this fix a bug or is this
just a theoretical fix you found during code review?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
