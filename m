Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EECA82261DC
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jul 2020 16:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbgGTOUS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Jul 2020 10:20:18 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:42894 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728579AbgGTOUR (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Jul 2020 10:20:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595254816; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=rZ2qDylZEr8icyXInAF654XoH3GzHgMGv7qoKZMYd6k=; b=ZqcaP+04YsVoTUFRYtGIDKqyWEP/2HEGAprgUuGp7J0wfqqSGeKypTCXMuUk9kTPqsAWMaLf
 WYKDWzT50taqajkpJDAk7oQ5KPpzqcCZq6S08HDxqB8scZh2qNEIXe3sKBUI9EPbhT47KRHJ
 DFPGXsaGvBMXxvDtEpF17dJn8+I=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n13.prod.us-west-2.postgun.com with SMTP id
 5f15a7f95b75bcda602cb51b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 20 Jul 2020 14:19:37
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C2C9EC43391; Mon, 20 Jul 2020 14:19:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3711CC433C9;
        Mon, 20 Jul 2020 14:19:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3711CC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/4] wcn36xx: Fix multiple AMPDU sessions support
References: <1593524821-32115-1-git-send-email-loic.poulain@linaro.org>
        <20200715153329.B95B6C433CA@smtp.codeaurora.org>
        <CAMZdPi9kbcDha32Dy1w3ejS_nqmTQu1tXhGn8e20sfU8wzjLbQ@mail.gmail.com>
Date:   Mon, 20 Jul 2020 17:19:32 +0300
In-Reply-To: <CAMZdPi9kbcDha32Dy1w3ejS_nqmTQu1tXhGn8e20sfU8wzjLbQ@mail.gmail.com>
        (Loic Poulain's message of "Mon, 20 Jul 2020 16:17:02 +0200")
Message-ID: <87a6zu6zgr.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Loic Poulain <loic.poulain@linaro.org> writes:

> On Wed, 15 Jul 2020 at 17:33, Kalle Valo <kvalo@codeaurora.org> wrote:
>
>     Loic Poulain <loic.poulain@linaro.org> wrote:
>     
>     > Several AMPDU sessions can be started, e.g. for different TIDs.
>     > Currently the driver does not take care of the session ID when
>     > requesting block-ack (statically set to 0), which leads to never
>     > block-acked packet with sessions other than 0.
>     > 
>     > Fix this by saving the session id when creating the ba session
>     and
>     > use it in subsequent ba operations.
>     > 
>     > This issue can be reproduced with iperf in two steps (tid 0
>     strem
>     > then tid 6 stream).
>     > 
>     > 1.0 iperf -s # wcn36xx side
>     > 1.1 iperf -c ${IP_ADDR} # host side
>     > 
>     > Then
>     > 
>     > 2.0 iperf -s -u -S 0xC0 # wcn36xx side
>     > 2.1 iperf -c ${IP_ADDR} -u -S 0xC0 -l 2000 # host side
>     > 
>     > Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
>     
>     What's the difference from the earlier version:
>     
>     https://patchwork.kernel.org/patch/11609871/
>     
>     A changelog would be nice.
>     
>
> There is no change, but I've simply included it in this series.
> I can resend the series without this one if necessary so that you can
> consider only the initial one.

No need to resend, I just wanted to understand if there are any changes.
In the future try to always include a changelog, that way I don't need
to guess if something has changed or not.

And don't send HTML mail, linux-wireless list drops it and then your
mail won't be visible in the patchwork either.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
