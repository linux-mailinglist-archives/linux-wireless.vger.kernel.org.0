Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71FD02A6931
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Nov 2020 17:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgKDQO3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Nov 2020 11:14:29 -0500
Received: from z5.mailgun.us ([104.130.96.5]:35128 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbgKDQO2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Nov 2020 11:14:28 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604506468; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=jGi3hEfmR9QjvZd352MiD6q1gXChgDqWIUciaVXePf8=; b=dNDIeUhXJ9An70z3+d5BGJ0DShXmgZXlfEyVr3qNqJd4lJW2ELDd7h9nZsRhGRK1Ep1fbDMV
 hte8KfxQ2ohvRMXQLYovdyjaOqhyrBoTtdFLTHVTSPzibJMnpnoZZLueoqUo16ai+dzmPkF1
 9PMkE+PhJkqFgELyaVZjm1Z8dJI=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5fa2d358524c7ffb3d858852 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 04 Nov 2020 16:14:16
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EC221C433C6; Wed,  4 Nov 2020 16:14:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 41CCCC433C8;
        Wed,  4 Nov 2020 16:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 41CCCC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath11k: Initialize complete alpha2 for regulatory change
References: <20201021140555.4114715-1-sven@narfation.org>
Date:   Wed, 04 Nov 2020 18:14:12 +0200
In-Reply-To: <20201021140555.4114715-1-sven@narfation.org> (Sven Eckelmann's
        message of "Wed, 21 Oct 2020 16:05:55 +0200")
Message-ID: <87v9elqeuj.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sven Eckelmann <sven@narfation.org> writes:

> The function ath11k_wmi_send_init_country_cmd is taking 3 byte from alpha2
> of the structure wmi_init_country_params. But the function
> ath11k_reg_notifier is only initializing 2 bytes. The third byte is
> therefore always an uninitialized value.
>
> The command can happen to look like
>
>   0c 00 87 02 01 00 00 00 00 00 00 00 43 41 f8 00
>
> instead of
>
>   0c 00 87 02 01 00 00 00 00 00 00 00 43 41 00 00
>
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

On what hardware and firmware did you test this? I'll add that to the
commit log. I know it doesn't matter here but I want to have that info
anyway.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
