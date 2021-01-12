Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49382F34A4
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Jan 2021 16:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391306AbhALPvw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Jan 2021 10:51:52 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:57380 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733044AbhALPvv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Jan 2021 10:51:51 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610466686; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=tfgyG5hO7cO9yCbB6JKy3CJhVVdrmCws3fnKVbxGmBw=; b=oE4fxHF31WlcFPS/tCdZg3GyrbuQh4A/NlP/hrebiGqMrfCi4pvWWVdoPTxekSB4hs+Lx7sR
 dhKAHyLzYKToylHsapTde26C7RA3wprz9RekALW0RWsRH+3YGtpzM5QOgz0kL+AU5TW3Abm+
 ih91w+JPGc6p4Tp+mhKwBI8Nvpg=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5ffdc561415a6293c548be1d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 12 Jan 2021 15:50:57
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D9EB9C433C6; Tue, 12 Jan 2021 15:50:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 528BBC433CA;
        Tue, 12 Jan 2021 15:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 528BBC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Luca Coelho <luciano.coelho@intel.com>
Subject: Re: [PATCH 2/2] iwlwifi: dbg: Mark ucode tlv data as const
References: <20210112132449.22243-1-tiwai@suse.de>
        <20210112132449.22243-3-tiwai@suse.de>
Date:   Tue, 12 Jan 2021 17:50:54 +0200
In-Reply-To: <20210112132449.22243-3-tiwai@suse.de> (Takashi Iwai's message of
        "Tue, 12 Jan 2021 14:24:49 +0100")
Message-ID: <87pn2arw69.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Takashi Iwai <tiwai@suse.de> writes:

> The ucode TLV data may be read-only and should be treated as const
> pointers, but currently a few code forcibly cast to the writable
> pointer unnecessarily.  This gave developers a wrong impression as if
> it can be modified, resulting in crashing regressions already a couple
> of times.
>
> This patch adds the const prefix to those cast pointers, so that such
> attempt can be caught more easily in future.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

So this need to go to -next, right? Does this depend on patch 1 or can
this be applied independently?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
