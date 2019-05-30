Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F284C2FA25
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2019 12:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfE3KUD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 May 2019 06:20:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60858 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbfE3KUD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 May 2019 06:20:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 09AEC6087B; Thu, 30 May 2019 10:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559211603;
        bh=SXB5KwAZvO/cHcFyvoabKUDcid0La6lGPtu/+S0DRjA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=RL4IVdoX2ZVa7BDFCkfp0hh669jotp7wjCFiifBkayg4p4g1lY9UzG2fVfbFvp4my
         jt5AknVGWwAOe5Y4Ov5aXW9MU+tm6iIlzIMwQ0A0AzDDKV+TGbWnHpelZBzAL31ZdB
         osWyZ9A9+Gw7O6XFwYLZyrj8nK9AdrlS1UnV7pHQ=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 37F626030D;
        Thu, 30 May 2019 10:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559211602;
        bh=SXB5KwAZvO/cHcFyvoabKUDcid0La6lGPtu/+S0DRjA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Fy4EjKrxDiccRXsYMOm7CKAsfWeHOaaXYmAv6sDhs/IZxL9x0/TKOYLLsW47i1E2w
         cLn46SuoN75oVDKmtICWCRhTGhrxaVB1u2j1AdpJUYuYbMOyrWmR56QZivVswFB79G
         v7KommuZamVksCJAiaHjRdYcC4TWRrCDuA9ZjQVo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 37F626030D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, nbd@nbd.name,
        lorenzo.bianconi@redhat.com, sgruszka@redhat.com
Subject: Re: [PATCH wireless-drivers] mt76: usb: fix buffer allocation for scatter-gather capable devices
References: <f1f5b9f564e374174a9a2bbae29f4b72fd4c6ddd.1559163190.git.lorenzo@kernel.org>
        <87zhn4pmjv.fsf@codeaurora.org>
        <20190530092327.GA2626@localhost.localdomain>
Date:   Thu, 30 May 2019 13:19:58 +0300
In-Reply-To: <20190530092327.GA2626@localhost.localdomain> (Lorenzo Bianconi's
        message of "Thu, 30 May 2019 11:23:29 +0200")
Message-ID: <87blzk1bxt.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

>> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>> 
>> > Partially revert commit f8f527b16db5 ("mt76: usb: use EP max packet
>> > aligned buffer sizes for rx") since it breaks A-MSDU support.
>> > When A-MSDU is enable the device can receive frames up to
>> > q->buf_size but they will be discarded in mt76u_process_rx_entry
>> > since there is no enough room for skb_shared_info.
>> > Fix it by introducing q->data_size and take info account
>> > skb_shared_info size in q->buf_size
>> > Moreover increase buffer size even for legacy mode (scatter-gather not
>> > available)
>> >
>> > Fixes: f8f527b16db5 ("mt76: usb: use EP max packet aligned buffer sizes for rx")
>> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>> 
>> Felix, can I take this directly to wireless-drivers?
>
> Hi Kalle,
>
> please hold on with this patch, I will post a new one with a different
> approach based on what Felix has suggested me

Ok, thanks for letting me know.

-- 
Kalle Valo
