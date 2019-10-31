Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86E58EAC5C
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2019 10:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfJaJKA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Oct 2019 05:10:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43926 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbfJaJKA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Oct 2019 05:10:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9CAA5601D4; Thu, 31 Oct 2019 09:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572512999;
        bh=iOaJ1rxMhr1nplRF5WVapRA85FaZYrFzAt3Vpe714mA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ndN9Z4YZt/ANHREe2diKEGR5tlIJ6ftKWG0iQGJyKwKBxHu+X1oV1/PlX+FwlNJH2
         mlqWQz7dQkT6UL/fuwGpwTmgKDrSJ6JKlKDIWw747IRZY5gybkR/6ZE9c6qIz5rQ/y
         TTfF/D+g1LWQNqjy5UJ8yCPX0qjBXmp0siri8O0s=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2FA5A60397;
        Thu, 31 Oct 2019 09:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572512999;
        bh=iOaJ1rxMhr1nplRF5WVapRA85FaZYrFzAt3Vpe714mA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ndN9Z4YZt/ANHREe2diKEGR5tlIJ6ftKWG0iQGJyKwKBxHu+X1oV1/PlX+FwlNJH2
         mlqWQz7dQkT6UL/fuwGpwTmgKDrSJ6JKlKDIWw747IRZY5gybkR/6ZE9c6qIz5rQ/y
         TTfF/D+g1LWQNqjy5UJ8yCPX0qjBXmp0siri8O0s=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2FA5A60397
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Subject: Re: [PATCH v6 2/3] ath10k: change max RX bundle size from 8 to 32 for sdio
References: <1569402639-31720-1-git-send-email-wgong@codeaurora.org>
        <1569402639-31720-3-git-send-email-wgong@codeaurora.org>
        <87h83ysbjy.fsf@kamboji.qca.qualcomm.com>
        <73e2d996575023b14c24665b2607a5b3@codeaurora.org>
Date:   Thu, 31 Oct 2019 11:09:56 +0200
In-Reply-To: <73e2d996575023b14c24665b2607a5b3@codeaurora.org> (Wen Gong's
        message of "Thu, 24 Oct 2019 18:48:21 +0800")
Message-ID: <87y2x11dsr.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> writes:

> On 2019-10-24 18:05, Kalle Valo wrote:
>> Wen Gong <wgong@codeaurora.org> writes:
>
>> As you can see I also changed the macro to a function, as I prefer C
>> over CPP :) And changed ATH10K_HTC_FLAG_BUNDLE_MASK to use GENMASK().
>>
> yes.
>> But this only compiled tested, please do properly test the patches from
>> pending branch and let me know if I broke something:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=afd85ca1b086695cfd26bf484442eaf3bccb6bdd
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=4225b4d50a4f6a1159dc3316d068398f1b5edb57
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=911e0fc846cfc46fb4ccd1d223cb153681ff05bd
>
> I will test the 3 patches.

Did you have a chance to test them? Do note that I did one minor change
today:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=28da1fe7a3ffa5c55c52328c21165d9efdf2e94c

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
