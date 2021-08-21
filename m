Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3C13F3ADB
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Aug 2021 16:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhHUOCe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Aug 2021 10:02:34 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:28153 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230167AbhHUOCd (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Aug 2021 10:02:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629554514; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=82s4M8aUj4gcBH3tz7jBvrfV+EETME5k1uzeVI98AJw=; b=mKFBk0yzCgpMihHFMUPUnDYqiiKMrSQ+K2Du4E8CfTXxnT9Ox8NZhB54cqgEO8/3WTP3XYMM
 wlfwh6nkQgtLl6m05jaSvsTC346eXIcZYrwL0rYsOp+eD8nrp56u9lzftrCCsAjyknIqe2CC
 Zc5WLSF9Rlhl2w+PwaDrS6sR+Us=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 612107372b9e91b688236d8b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 21 Aug 2021 14:01:27
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4B32FC43460; Sat, 21 Aug 2021 14:01:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 18889C4338F;
        Sat, 21 Aug 2021 14:01:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 18889C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 02/12] iwlwifi: mvm: add support for resonder config command version 9
References: <20210820110318.260751-1-luca@coelho.fi>
        <iwlwifi.20210820140104.b7e1bf6359b6.Ice4112c1910cf94babd1c2d492a3a3de9f7ee6cb@changeid>
Date:   Sat, 21 Aug 2021 17:01:22 +0300
In-Reply-To: <iwlwifi.20210820140104.b7e1bf6359b6.Ice4112c1910cf94babd1c2d492a3a3de9f7ee6cb@changeid>
        (Luca Coelho's message of "Fri, 20 Aug 2021 14:03:08 +0300")
Message-ID: <8735r2ucb1.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> From: Avraham Stern <avraham.stern@intel.com>
>
> This version adds the following configuration options:
> 1. Enable/disable setting the session id in the FTM frame
> 2. Set the BSS color for the responder
> 3. Set the minimum and maximum time between measurements for
>    non trigger based NDP ranging.
>
> Signed-off-by: Avraham Stern <avraham.stern@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

s/resonder/responder/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
