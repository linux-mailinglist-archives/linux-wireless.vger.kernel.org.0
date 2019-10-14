Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4D17D5EBE
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2019 11:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730836AbfJNJX6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Oct 2019 05:23:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58964 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730676AbfJNJX6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Oct 2019 05:23:58 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8506360B6F; Mon, 14 Oct 2019 09:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571045037;
        bh=H+y2OxkOwnCdzzHwz8W1y9jMd54C3WoKathCx0W3WjA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=TUyRwgfBkJQBzgyImbrKHSw7CoR+Wo0h9f81/gHCfBw8p46QCVHHe9Vu7ko+6jWi/
         2WMc4pOgU6AFxg2By5j4xPBE496X2u/R4tucsomSQZDOWbZHBDHsikx0di1uKv3nOg
         UfNadtZeajQKa+5znbdxwfugHD+UB1IDxXHFW3vw=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A063C60B7A;
        Mon, 14 Oct 2019 09:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571045033;
        bh=H+y2OxkOwnCdzzHwz8W1y9jMd54C3WoKathCx0W3WjA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=m51Q4/IDlweJ2jKm9PUe15+DrSgkrGqAIhSFaxHgSDM7yZATIsDHp4pTtT3VXK2Gy
         8lW3Lrv1JKqbc1xwFEUbMBkbz5xYJcPQZ/eeDb/q8tj3P/uHw2Zs5pODe/4Ubkme9i
         vrgQ3FIl/IPLba3jTGvBjnLA6bw61/Y5mp/NSuY8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A063C60B7A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Kan Yan <kyan@google.com>
Cc:     johannes@sipsolutions.net, make-wifi-fast@lists.bufferbloat.net,
        toke@redhat.com, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, yiboz@codeaurora.org, nbd@nbd.name
Subject: Re: [PATCH v4 2/2] ath10k: Enable Airtime-based Queue Limit (AQL)
References: <20191011022413.176208-1-kyan@google.com>
        <20191011022413.176208-3-kyan@google.com>
Date:   Mon, 14 Oct 2019 12:23:49 +0300
In-Reply-To: <20191011022413.176208-3-kyan@google.com> (Kan Yan's message of
        "Thu, 10 Oct 2019 19:24:13 -0700")
Message-ID: <87lftny922.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kan Yan <kyan@google.com> writes:

> Calculate the estimated airtime pending in the txqs and apply AQL to
> prevent excessive amounts of packets being queued in the firmware queue.
>
> Signed-off-by: Kan Yan <kyan@google.com>

Forgot to mention earlier that please add tested hardware and firmware
versions:

https://wireless.wiki.kernel.org/en/users/drivers/ath10k/submittingpatches#guidelines

I can also add that during commit, no need to resend because of this.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
