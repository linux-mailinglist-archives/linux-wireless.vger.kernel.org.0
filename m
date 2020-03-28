Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D74D19663F
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Mar 2020 14:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgC1NKa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 28 Mar 2020 09:10:30 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:16787 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726045AbgC1NKa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 28 Mar 2020 09:10:30 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585401030; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=BkP2Qzuch28mP0cczWwYlYUfLc1s1nSBvN5/FoexL4Q=; b=QZ0XhFkyCxg5wj633GkxStQfWllvFir2NFjZMNnSVb+yW28seFK6gKiU6IIpVPxV6qcnJiZI
 xUHooDuhBtYXsTZg5CaKK6lKo0W4sUjRCIcVz4fdWWfVT+xL2TEDGUlznRUXzHBx9VtktGC6
 O00bKxdUQWx6MJdQ7GAmvsDHX1c=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7f4cbe.7ff8562435a8-smtp-out-n04;
 Sat, 28 Mar 2020 13:10:22 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1062CC433BA; Sat, 28 Mar 2020 13:10:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 08AF9C433F2;
        Sat, 28 Mar 2020 13:10:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 08AF9C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Luca Coelho <luca@coelho.fi>,
        linux-wireless Mailing List <linux-wireless@vger.kernel.org>,
        Len Brown <lenb@kernel.org>, noodles@earth.li
Subject: Re: [PATCH v5.6] iwlwifi: don't send GEO_TX_POWER_LIMIT if no wgds table
References: <iwlwifi.20200318081237.46db40617cc6.Id5cf852ec8c5dbf20ba86bad7b165a0c828f8b2e@changeid>
        <20200323163858.A1183C44788@smtp.codeaurora.org>
        <CAMP44s0xmss2sOpJ7e-Vx-bq8mx+Q+pO3B-SDaaST_iEPOM_3g@mail.gmail.com>
Date:   Sat, 28 Mar 2020 15:10:15 +0200
In-Reply-To: <CAMP44s0xmss2sOpJ7e-Vx-bq8mx+Q+pO3B-SDaaST_iEPOM_3g@mail.gmail.com>
        (Felipe Contreras's message of "Sat, 28 Mar 2020 05:02:40 -0600")
Message-ID: <87ftds1v7s.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Mon, Mar 23, 2020 at 10:42 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>>
>> Luca Coelho <luca@coelho.fi> wrote:
>>
>> > From: Golan Ben Ami <golan.ben.ami@intel.com>
>> >
>> > The GEO_TX_POWER_LIMIT command was sent although
>> > there is no wgds table, so the fw got wrong SAR values
>> > from the driver.
>> >
>> > Fix this by avoiding sending the command if no wgds
>> > tables are available.
>> >
>> > Signed-off-by: Golan Ben Ami <golan.ben.ami@intel.com>
>> > Fixes: 39c1a9728f93 ("iwlwifi: refactor the SAR tables from mvm to acpi")
>> > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
>> > Tested-By: Jonathan McDowell <noodles@earth.li>
>> > Tested-by: Len Brown <len.brown@intel.com>
>>
>> Patch applied to wireless-drivers.git, thanks.
>>
>> 0433ae556ec8 iwlwifi: don't send GEO_TX_POWER_LIMIT if no wgds table
>
> This should be applied to the stable tree, shouldn't it? 5.5 stable
> releases have this issue.

It's now in Linus' tree so I think you can just send a mail to the
stable team and they will queue it.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
