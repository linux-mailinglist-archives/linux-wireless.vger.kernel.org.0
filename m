Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D154CF3409
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2019 17:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbfKGQER (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Nov 2019 11:04:17 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:36802 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfKGQER (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Nov 2019 11:04:17 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C12C46085F; Thu,  7 Nov 2019 16:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573142656;
        bh=DJ2xMknYMaZ94hSWkYmWf6xlTs5TXO/5IILLZm6y32E=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=dBcH3HJpzddI2r8jnEYxLSe0FRpnQt8Z3Y9tlnteseUFo34PNUkrJeikc84IYWEl1
         0Y22q92O/+AOV0eJMVmB2xyWyry0iGnlvyId2C6WwsJjtblrxw74OoW3zu23BgW07Y
         mc/N16+EnVpQ1dx4lxeZMX9u+OawzkhQf8V61GlU=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 306C8602F0;
        Thu,  7 Nov 2019 16:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573142656;
        bh=DJ2xMknYMaZ94hSWkYmWf6xlTs5TXO/5IILLZm6y32E=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=dBcH3HJpzddI2r8jnEYxLSe0FRpnQt8Z3Y9tlnteseUFo34PNUkrJeikc84IYWEl1
         0Y22q92O/+AOV0eJMVmB2xyWyry0iGnlvyId2C6WwsJjtblrxw74OoW3zu23BgW07Y
         mc/N16+EnVpQ1dx4lxeZMX9u+OawzkhQf8V61GlU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 306C8602F0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Jeff Johnson <jjohnson@codeaurora.org>
Cc:     devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
Subject: Re: [PATCH v2 02/49] ath11k: add Kconfig
References: <1571565847-10338-1-git-send-email-kvalo@codeaurora.org>
        <1571565847-10338-3-git-send-email-kvalo@codeaurora.org>
        <6ffc215251b54d562496d978bdbbcead@codeaurora.org>
Date:   Thu, 07 Nov 2019 18:04:13 +0200
In-Reply-To: <6ffc215251b54d562496d978bdbbcead@codeaurora.org> (Jeff Johnson's
        message of "Mon, 21 Oct 2019 13:53:51 -0700")
Message-ID: <87ftizy8oy.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jeff Johnson <jjohnson@codeaurora.org> writes:

> On 2019-10-20 03:03, Kalle Valo wrote:
>> [...snip...]
>> +config ATH11K_TRACING
>> +	bool "ath11k tracing support"
>> +	depends on ATH11K && EVENT_TRACING
>> +	---help---
>> +	  Select this to ath11k use tracing infrastructure.
>
> Help text does not parse

Will be fixed in v3:

https://patchwork.kernel.org/patch/11233257/

Thanks for the review.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
