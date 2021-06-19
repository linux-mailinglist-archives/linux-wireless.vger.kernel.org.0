Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDF23AD82A
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Jun 2021 08:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbhFSGl1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 19 Jun 2021 02:41:27 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:17538 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbhFSGl1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 19 Jun 2021 02:41:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624084757; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=/guua7JNF7X/bzK0PnOvryWWZSYg05MwaJIMvdOltW8=; b=LwDzxZJwbf06r1wye+44bwpoKtYg7qsNkHl/030ejX2MWoqA6ltNaZpVqdshny13+5IaMeFK
 zg/VKSaFjUcRR1bsPjk1Sdjhumb+xCAMJ/AwLnXCF1lAEoqt7rq/M6f8lHPmteNBQF7BoBPi
 8g0uJqbOJOvfF9ZwIttMkVJZfaY=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 60cd911151f29e6bae3cc3ee (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 19 Jun 2021 06:39:13
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E53FFC4360C; Sat, 19 Jun 2021 06:39:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 07FA9C433D3;
        Sat, 19 Jun 2021 06:39:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 07FA9C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     viktor.barna@celeno.com
Cc:     linux-wireless@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Aviad Brikman <aviad.brikman@celeno.com>,
        Eliav Farber <eliav.farber@gmail.com>,
        Oleksandr Savchenko <oleksandr.savchenko@celeno.com>,
        Shay Bar <shay.bar@celeno.com>
Subject: Re: [RFC v1 000/256] wireless: cl8k driver for Celeno IEEE 802.11ax devices
References: <20210617160223.160998-1-viktor.barna@celeno.com>
Date:   Sat, 19 Jun 2021 09:39:07 +0300
In-Reply-To: <20210617160223.160998-1-viktor.barna@celeno.com> (viktor barna's
        message of "Thu, 17 Jun 2021 15:58:07 +0000")
Message-ID: <87mtrmicj8.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

viktor.barna@celeno.com writes:

> From: Viktor Barna <viktor.barna@celeno.com>
>
> Celeno Communications publishes to the opensource new wireless driver
> for an own 802.11 chipset family - 80xx. The main chip supports multiple
> simultaneous bands functioning (2.4G/5.2G or 5.2G/6G) over PCIe 3.0
> dual-lane interface. Basically, the chip is dual-band concurrent up to
> 8x8 in total, and up to 6x6 per band, including 802.11ax 160MHz support
> and functioning of AP/STA/MESH modes. The driver architecture is strong
> SoftMAC.
>
> The current patchset is considered to be published in form of RFC
> (Request for Comments). If there are any suggestions/propositions - we
> will be glad to fix them and eventually share the driver with the
> community in form of an official patch (including the firmware
> binaries).
>
> The RFC is divided into separate patches on a per-file basis to simplify
> the review process.

[...]

> ________________________________ The information transmitted is
> intended only for the person or entity to which it is addressed and
> may contain confidential and/or privileged material. Any
> retransmission, dissemination, copying or other use of, or taking of
> any action in reliance upon this information is prohibited. If you
> received this in error, please contact the sender and delete the
> material from any computer. Nothing contained herein shall be deemed
> as a representation, warranty or a commitment by Celeno. No warranties
> are expressed or implied, including, but not limited to, any implied
> warranties of non-infringement, merchantability and fitness for a
> particular purpose. ________________________________
>

I'm not going to review a driver with a disclaimer like this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
