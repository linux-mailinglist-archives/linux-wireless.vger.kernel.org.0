Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF032C12E2
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Nov 2020 19:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390520AbgKWSGJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Nov 2020 13:06:09 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:36733 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390438AbgKWSGJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Nov 2020 13:06:09 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606154768; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=+GWPIHuQwAD1Es+0RdG56GcW72pfXIcFQM3ufPZO2KA=; b=CmBANUJ4A+buqJKouYpP1PpMsbPTtV7vgNjz8XoxNKjNmlFUjLl2FoW8EEM3y7SippZzz4nb
 kggY0tLkNXvEQgPLiy+SxlEarRgFAsqgK8ACvY8yfeBm1RmeFHC0zoZ/CbynCqwkLpPXTs3g
 tVihDJFEU1mbsMk7hafQV4a3iRQ=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5fbbfa0f7f0cfa6a16c980b8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 23 Nov 2020 18:06:07
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 91A28C43467; Mon, 23 Nov 2020 18:06:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C9F60C433ED;
        Mon, 23 Nov 2020 18:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C9F60C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-wireless@vger.kernel.org,
        QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        ath10k@lists.infradead.org, Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        ath11k@lists.infradead.org
Subject: Re: [PATCH 0/9] relay: cleanup and const callbacks, take 2
References: <cover.1606153547.git.jani.nikula@intel.com>
Date:   Mon, 23 Nov 2020 20:06:00 +0200
In-Reply-To: <cover.1606153547.git.jani.nikula@intel.com> (Jani Nikula's
        message of "Mon, 23 Nov 2020 19:59:20 +0200")
Message-ID: <87mtz8q77b.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jani Nikula <jani.nikula@intel.com> writes:

> This is v2 of [1], with a number of cleanups added first based on
> Christoph's feedback, making the actual constness patch much smaller and
> cleaner.
>
> I don't know who actually maintains relay, it's not in MAINTAINERS -
> Cc'd Andrew just in case.
>
> I'd think it would be simplest to queue patches 5-9 via whichever tree
> the relay patches get merged. They're all one-liners so neglible
> conflict potential.
>
> BR,
> Jani.
>
>
> [1] http://lore.kernel.org/r/20201118165320.26829-1-jani.nikula@intel.com
>
>
> Cc: linux-block@vger.kernel.org
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: ath11k@lists.infradead.org
> Cc: ath10k@lists.infradead.org
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Cc: linux-wireless@vger.kernel.org
> Cc: QCA ath9k Development <ath9k-devel@qca.qualcomm.com>
> Cc: intel-gfx@lists.freedesktop.org
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
>
>
> Jani Nikula (9):
>   relay: remove unused buf_mapped and buf_unmapped callbacks
>   relay: require non-NULL callbacks in relay_open()
>   relay: make create_buf_file and remove_buf_file callbacks mandatory
>   relay: allow the use of const callback structs
>   drm/i915: make relay callbacks const
>   ath10k: make relay callbacks const
>   ath11k: make relay callbacks const
>   ath9k: make relay callbacks const
>   blktrace: make relay callbacks const

For ath9k, ath10k & ath11k:

Acked-by: Kalle Valo <kvalo@codeaurora.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
