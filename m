Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18212211C21
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jul 2020 08:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgGBGtN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Jul 2020 02:49:13 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:40835 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbgGBGtN (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Jul 2020 02:49:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593672552; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=Z1FQKJa+CcrDHMyZpRsA52XudrtWn5rPp4C8kePR6JE=; b=mkbUe8w6Ixelfe6wsTDNcpHjhnzHgUWkeGD6RIZSxr+N7yzHcsPkzmXtjGc0p7/zw/ZY0QZC
 uTiGCT2Lo+RSCgqdSCgxsAT81kPauC5oiI78JfqSkSTZfybcEGlJlfn0jN2doWevJ4RgS5TX
 7b/XGWsMS24Ibi3lPELYUffSL2Y=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5efd83636f2ee827dadb7f1e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 02 Jul 2020 06:49:07
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0A487C43395; Thu,  2 Jul 2020 06:49:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 317DDC433C6;
        Thu,  2 Jul 2020 06:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 317DDC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <Nicolas.Ferre@microchip.com>
Cc:     <luc.vanoostenryck@gmail.com>, <adham.abozaeid@microchip.com>,
        <Ajay.Kathat@microchip.com>, <gregkh@linuxfoundation.org>,
        <linux-wireless@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging/wilc1000: let wilc_mac_xmit() to NETDEV_TX_OK
References: <20200628183237.74749-1-luc.vanoostenryck@gmail.com>
        <8a2f50dc-2cbe-64e4-438c-4320bb574f4f@microchip.com>
Date:   Thu, 02 Jul 2020 09:48:59 +0300
In-Reply-To: <8a2f50dc-2cbe-64e4-438c-4320bb574f4f@microchip.com> (Nicolas
        Ferre's message of "Mon, 29 Jun 2020 07:58:09 +0000")
Message-ID: <87eepubeec.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<Nicolas.Ferre@microchip.com> writes:

> Luc,
>
> Thanks for your patch...
>
> On 28/06/2020 at 20:32, Luc Van Oostenryck wrote:
>> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
>> which is a typedef for an enum type defining 'NETDEV_TX_OK' but this
>> driver returns '0' instead of 'NETDEV_TX_OK'.
>> 
>> Fix this by returning ''NETDEV_TX_OK' instead of 0.
>> 
>> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
>> ---
>>   drivers/staging/wilc1000/netdev.c | 6 +++---
>
> ... would it be possible that you re-spin it so that it applies to the 
> new location of this driver:
> drivers/net/wireless/microchip/wilc1000/netdev.c
>
> You can rebase your patch on the wireless-driver-next tree with 
> wilc1000-move-out-of-staging branch:
>
> tree: 
> git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git
> branch: wilc1000-move-out-of-staging
>
> (Then you can also review the subject line of your patch, BTW)

And also cc linux-wireless so that our patchwork sees it (not sure if
the original patch had it or not, just making sure), more info in the
link below.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
