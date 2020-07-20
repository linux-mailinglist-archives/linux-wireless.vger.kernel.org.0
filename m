Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D7E225C08
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jul 2020 11:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgGTJt2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Jul 2020 05:49:28 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:10352 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727972AbgGTJt2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Jul 2020 05:49:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595238567; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=vfSYH5wuauFN0yvMZ+Uhpt1wFYnJrhTjMM2NSzbwkmQ=; b=grt5bBuoOm+zePlaI/sRQCrGDrugpP7/Fs+td56UwfcflEnUjhjBK7Fwla8rBszHKaNjpTGW
 D3litzidL8hgqZ6VlsISWqo76yPewJWzf2v8OEeqCNYwEYX2X2d9hwduCcAp3/UUfBh7hE81
 U1IcWI5w016HB7iwijCbIuyj+9M=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5f15689b0cb8533c3b7d9a40 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 20 Jul 2020 09:49:15
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 62E6BC43395; Mon, 20 Jul 2020 09:49:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 84EB3C433CA;
        Mon, 20 Jul 2020 09:49:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 84EB3C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Ajay.Kathat@microchip.com,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Claudiu.Beznea@microchip.com, Sripad.Balwadgi@microchip.com,
        Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>
Subject: Re: [PATCH] wilc1000: Move wilc1000 SDIO ID's from driver source to common header file
References: <20200717051134.19160-1-ajay.kathat@microchip.com>
        <CAPDyKFp5-6QeHLTE4gtc5u6moMsLFhOBZckDZBTD+B1RV28Z3g@mail.gmail.com>
Date:   Mon, 20 Jul 2020 12:49:11 +0300
In-Reply-To: <CAPDyKFp5-6QeHLTE4gtc5u6moMsLFhOBZckDZBTD+B1RV28Z3g@mail.gmail.com>
        (Ulf Hansson's message of "Sat, 18 Jul 2020 11:28:52 +0200")
Message-ID: <87blkabjoo.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On Fri, 17 Jul 2020 at 07:11, <Ajay.Kathat@microchip.com> wrote:
>>
>> From: Ajay Singh <ajay.kathat@microchip.com>
>>
>> Moved macros used for Vendor/Device ID from wilc1000 driver to common
>> header file and changed macro name for consistency with other macros.
>>
>> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Just so that I have understood correctly, so the plan is to take this
via wireless-drivers-next?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
