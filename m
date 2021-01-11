Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66232F11A9
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Jan 2021 12:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbhAKLmD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Jan 2021 06:42:03 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:49879 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729672AbhAKLmC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Jan 2021 06:42:02 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610365302; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=7ZNKQnY2KXtPoyAsECsnCeatiDYLZlClVjDB34+RiFc=; b=bFEI+d8AlXkctsgU8eN2OQIfbCci2FYQWMORMP1N0wllHImGpX0xRWSxzfINEzogv9D253v3
 JPP9c5neAsLx3KgCiQZ5bE9Nirvxk3YHmwOX33vtGpHcIwEJ3GmB+IK05FM8HI6JUxE5fmUP
 uaYsmj2fZxK8kle4ZoOy/IxMNYw=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5ffc3956af68fb3b06cde4e5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Jan 2021 11:41:10
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5B885C433C6; Mon, 11 Jan 2021 11:41:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 41294C43461;
        Mon, 11 Jan 2021 11:41:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 41294C43461
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>,
        <ku920601@realtek.com>
Subject: Re: [PATCH] rtw88: coex: set 4 slot TDMA for BT link and WL busy
References: <20201230033602.13636-1-pkshih@realtek.com>
Date:   Mon, 11 Jan 2021 13:41:06 +0200
In-Reply-To: <20201230033602.13636-1-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Wed, 30 Dec 2020 11:36:02 +0800")
Message-ID: <87ft37k8fh.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> To protect both of WL/BT performance while BT is under re-link state.
> 4-slot mode TDMA can make the re-link more sensitive and mitigate the WL
> throughput drop.
>
> Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Who should be marked as the author, I guess Ching-Te? Then From field is
missing.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
