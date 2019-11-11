Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5E2BF73C8
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2019 13:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfKKMXw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Nov 2019 07:23:52 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:47300 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfKKMXw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Nov 2019 07:23:52 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BD63760611; Mon, 11 Nov 2019 12:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573475031;
        bh=+U/zNmU7ZFRJPfXrBaeI836hI1qD6Bufi05gKUoZShw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=kdw2nlnQbniq1SVWU7Ci3V4I+7aTSrs1tp2VO8QLPgK4VXnmeS/xPnq92jXesRUE9
         2NyjD7tbl1Nz09U8i3c7BK3c5B8cBjz35X1zzSwrU19VwZlpSFoovxzaxWm77C1Lq3
         wEF7vbrRrsKQzbI23PagtwSY9jn95MH21RAwIVg0=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B8C196055C;
        Mon, 11 Nov 2019 12:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573475030;
        bh=+U/zNmU7ZFRJPfXrBaeI836hI1qD6Bufi05gKUoZShw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=NKSm+lKOZf34cY+2mSplW94+1JqETyLzgba+2mf6fbbu+kjt5ihz9obGkIMatlWaX
         BUM1+Z9onLrwCcyaoNH/I0iKG80ZZNzhldG2EW8EVgkaLKJjGXJqYR2+Xq3h4gZEky
         sxvvgdG6DWts77utlT2j+3g/qrJolqqKQwYK7QBU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B8C196055C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v6 3/3] ath10k: add workqueue for RX path of sdio
References: <1569402639-31720-1-git-send-email-wgong@codeaurora.org>
        <1569402639-31720-4-git-send-email-wgong@codeaurora.org>
        <8736f92sfx.fsf@kamboji.qca.qualcomm.com>
        <3f3641ad49a2664d346558760e38b404@codeaurora.org>
        <70f8f208f631a2a2c7337f45b873a16e@codeaurora.org>
Date:   Mon, 11 Nov 2019 14:23:45 +0200
In-Reply-To: <70f8f208f631a2a2c7337f45b873a16e@codeaurora.org> (Wen Gong's
        message of "Mon, 11 Nov 2019 18:47:32 +0800")
Message-ID: <87r22ewqi6.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> writes:

> On 2019-11-01 15:42, Wen Gong wrote:
>> On 2019-10-31 17:08, Kalle Valo wrote:
>> =E3=80=81> I just realised that this is RX path so we should use
>> ATH10K_SKB_RXCB()
>>> instead. I made the change below to this commit in pending branch:
>>>
>> I will test with the new patch together with other performance patches.
> Hi Kalle, I have tested with the patches of pending branch, it is
> success.
> result is same with the public review which I tested before.
>
> the patches I tested on pending branch:
>
> ath10k: enable alt data of TX path for sdio
> ath10k: add htt TX bundle for sdio
> ath10k: disable TX complete indication of htt for sdio
> ath10k: enable napi on RX path for sdio
> ath10k: sdio: remove struct ath10k_sdio_rx_data::status
> ath10k: sdio: cosmetic cleanup
> ath10k: add workqueue for RX path of sdio
> ath10k: change max RX bundle size from 8 to 32 for sdio
> ath10k: enable RX bundle receive for sdio

Very good, thanks for testing.

--=20
Kalle Valo
