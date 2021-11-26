Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6BF245F1E9
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Nov 2021 17:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354120AbhKZQfP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Nov 2021 11:35:15 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:41093 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349558AbhKZQdO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Nov 2021 11:33:14 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637944201; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=BpI9gMluGjsVU1FeZ5TOrFPIOSyG+6OqY/NPMAxIwhA=;
 b=rBkNUTxPNsN8rPsHUhwgj+yZmWLRjvaVhIvJXq5GlfbZT53PV4O3Rv/VzZxvlIw0wxuBJqFa
 0KooewPVjvPgYk7YACtqd3o4BCsjIj83z1YjwJWHGDf1foQr6cGvNNe7IK7bOS1n7VvLbuUo
 aWa0R/+g+Zp81mB6KLP/5qQ6iII=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 61a10b89db3ac5552aab6edf (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Nov 2021 16:30:01
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0FD94C4361A; Fri, 26 Nov 2021 16:30:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 21446C4338F;
        Fri, 26 Nov 2021 16:29:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 21446C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 1/3] mwifiex: Use a define for firmware version string
 length
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20211103201800.13531-2-verdre@v0yd.nl>
References: <20211103201800.13531-2-verdre@v0yd.nl>
To:     =?utf-8?q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        =?utf-8?q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163794419512.10370.1044487519020075349.kvalo@codeaurora.org>
Date:   Fri, 26 Nov 2021 16:30:01 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jonas Dreßler <verdre@v0yd.nl> wrote:

> Since the version string we get from the firmware is always 128
> characters long, use a define for this size instead of having the number
> 128 copied all over the place.
> 
> Signed-off-by: Jonas Dreßler <verdre@v0yd.nl>

3 patches applied to wireless-drivers-next.git, thanks.

2d1d7091ddac mwifiex: Use a define for firmware version string length
939b571a3b62 mwifiex: Add quirk to disable deep sleep with certain hardware revision
deb573f1d7dd mwifiex: Ensure the version string from the firmware is 0-terminated

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211103201800.13531-2-verdre@v0yd.nl/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

