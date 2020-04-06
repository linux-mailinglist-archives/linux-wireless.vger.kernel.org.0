Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0A119F144
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Apr 2020 10:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgDFIC6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Apr 2020 04:02:58 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:43273 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726475AbgDFIC6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Apr 2020 04:02:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586160177; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=xIQT9TO9TYelu63iWJRDZFHeyeSwGSWGVN2avkb3S4g=; b=JokObTovw35yeWgGXh36D/LZ8U9P9YnnCeqBQbvY9rkf63ALU+3Yqts26V6kznVpedxWol6k
 KX6LLro7ffgcXDqPItm1k75etKIrWhesI8/XuVTLfh+DQeMeqdBVVfqKhsKRehnSX0P9AIt3
 onLMfc8odIjLph/WLbujy39n+DE=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8ae202.7f1e11669c00-smtp-out-n03;
 Mon, 06 Apr 2020 08:02:10 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6AC77C433F2; Mon,  6 Apr 2020 08:02:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7043DC433D2;
        Mon,  6 Apr 2020 08:02:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7043DC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Giuseppe Marco Randazzo <gmrandazzo@gmail.com>
Cc:     chunkeey@googlemail.com, davem@davemloft.net,
        linux-wireless@vger.kernel.org
Subject: Re: PATCH p54usb.c to support AirVasT USB wireless adapter
References: <CADT+tpPuQo7DZ9sSZCMiwUe8EVU4wZjBMhnVn=AHCUkBXnpqKg@mail.gmail.com>
Date:   Mon, 06 Apr 2020 11:02:03 +0300
In-Reply-To: <CADT+tpPuQo7DZ9sSZCMiwUe8EVU4wZjBMhnVn=AHCUkBXnpqKg@mail.gmail.com>
        (Giuseppe Marco Randazzo's message of "Sun, 5 Apr 2020 22:42:06
        +0200")
Message-ID: <87imidf3es.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Giuseppe,

Giuseppe Marco Randazzo <gmrandazzo@gmail.com> writes:

> Dear p54 maintainers,
>
> the following patch allows to use the AirVasT USB wireless devices
> 124a:4026 using the ISL3886 usb firmware. Without this modification,
> the wiki adapter is not either recognized. 
>
> Best regards,
> Giuseppe Marco "zeld" Randazzo
>
> ---
> /home/marco/LinuxKernel/linux/drivers/net/wireless/intersil/p54/p54usb.c.orig
> 2020-04-05 21:28:08.247905535 +0200 
> +++
> /home/marco/LinuxKernel/linux/drivers/net/wireless/intersil/p54/p54usb.c
> 2020-04-05 21:45:31.677747811 +0200 
> @@ -98,6 +98,7 @@ static const struct usb_device_id p54u_t 
> {USB_DEVICE(0x0cde, 0x0015)}, /* Zcomax XG-705A */ 
> {USB_DEVICE(0x0d8e, 0x3762)}, /* DLink DWL-G120 Cohiba */ 
> {USB_DEVICE(0x124a, 0x4025)}, /* IOGear GWU513 (GW3887IK chip) */ 
> + {USB_DEVICE(0x124a, 0x4026)}, /* AirVasT */ 
> {USB_DEVICE(0x1260, 0xee22)}, /* SMC 2862W-G version 2 */ 
> {USB_DEVICE(0x13b1, 0x000a)}, /* Linksys WUSB54G ver 2 */ 
> {USB_DEVICE(0x13B1, 0x000C)}, /* Linksys WUSB54AG */
>
> Signed-off-by: Giuseppe Marco "zeld" Randazzo <gmrandazzo@gmail.com>

Your patch has multiple issues, starting with use of HTML. I see that
Christian submitted your patch in correct format so this patch is now
properly in queue:

https://patchwork.kernel.org/patch/11474885/

But for future patches please first read the documentation from the link
below, it's important that the patches are submitted in correct format.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
