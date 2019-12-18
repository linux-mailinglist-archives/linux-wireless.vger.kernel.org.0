Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCA7F12507E
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 19:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfLRSXb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 13:23:31 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:32971 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726939AbfLRSXb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 13:23:31 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576693410; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=VFdskumPXW2kKxJv0BxYbV7monMNpjxLfnVG4ScB1nU=;
 b=bFV0HvpVZ+vN8kF6b2g4kbzH7tZMWqKVWjguiKWhShiVV4aQltL6fQGuPSpLCHKpIrEZ5kOF
 bqtfW7tVk3zLhXgvgNceCuweHZrOFDPmOlNxCxqoUnGoeXqrhdwiWHXii6vOK9s7UnAxHYpH
 bN3IEJ4IuwnLGjGKPpbz9t7bq6M=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfa6ea2.7f1c7488dae8-smtp-out-n02;
 Wed, 18 Dec 2019 18:23:30 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 71D62C4479C; Wed, 18 Dec 2019 18:23:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2CEBCC43383;
        Wed, 18 Dec 2019 18:23:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2CEBCC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/9] rtlwifi: rtl8192de: Remove usage of private bit
 manipulation macros
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191125220934.32693-2-Larry.Finger@lwfinger.net>
References: <20191125220934.32693-2-Larry.Finger@lwfinger.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191218182329.71D62C4479C@smtp.codeaurora.org>
Date:   Wed, 18 Dec 2019 18:23:29 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Larry Finger <Larry.Finger@lwfinger.net> wrote:

> Besides the previously changes macros in trx.h, there are some of these
> local macros in the driver. These are replaced with standard bit
> manipulations. Unused macros are deleted.
> 
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>

9 patches applied to wireless-drivers-next.git, thanks.

7031fb7f1cd1 rtlwifi: rtl8192de: Remove usage of private bit manipulation macros
5ea5c93d937c rtlwifi: rtl8188ee: Remove usage of private bit manipulation
4c8692d4939d rtlwifi: rtl8192ce: rtl8192c_com: Remove usage of private bit manipulation macros
f0dcd57e0b41 rtlwifi: Remove dependence on special bit manipulation macros for common driver
39f40710d0b5 rtlwifi: rtl88821ae: Remove usage of private bit manipulation macros
8e3457621263 rtlwifi: rtl8192ee: Remove usage of private bit manipulation macros
1626f1929575 rtlwifi: rtl8723ae: Remove usage of private bit manipulation macros
84bc9a58326a rtlwifi: rtl8723be: Remove usage of private bit manipulation macros
bb7e6d85536b rtlwifi: Remove last definitions of local bit manipulation macros

-- 
https://patchwork.kernel.org/patch/11260865/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
