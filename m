Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677FF3B3427
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jun 2021 18:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhFXQtg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Jun 2021 12:49:36 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:28514 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhFXQtf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Jun 2021 12:49:35 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624553236; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=UPAFmqxx55H0GndHGJHMEiQ/ST7XzzmLk4xXxkXAhyY=; b=S9jeW0s+60j3Ay3J7tEO+GCEFuv0hesClrVa0X6yjVBMI4wXQvxygyHYnUY2f/WDXQDZUz9N
 pE2QYc1UFjZ+NlVgIck8dnKdBu2osC9DHmQvOeuFBPG/OcYnKJHZp0FeF+jooNkflPM6z+bg
 DPuClGKf0mA81yqGNirRPUaboJA=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 60d4b707d2559fe392a0bebe (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 24 Jun 2021 16:47:03
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9362DC433D3; Thu, 24 Jun 2021 16:47:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A6040C4338A;
        Thu, 24 Jun 2021 16:46:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A6040C4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Emmanuel Grumbach <egrumbach@gmail.com>
Cc:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        "Coelho\, Luciano" <luciano.coelho@intel.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Ayala Beker <ayala.beker@intel.com>
Subject: Re: [PATCH v2 1/4] iwlwifi: mei: add the driver to allow cooperation with CSME
References: <20210621080159.12883-1-emmanuel.grumbach@intel.com>
        <87k0mmjaep.fsf@tynnyri.adurom.net>
        <CANUX_P2rdkaBpKV=RTkS9ffLR89hL1yqBHskRp_Vdu8hJVrshg@mail.gmail.com>
Date:   Thu, 24 Jun 2021 19:46:56 +0300
In-Reply-To: <CANUX_P2rdkaBpKV=RTkS9ffLR89hL1yqBHskRp_Vdu8hJVrshg@mail.gmail.com>
        (Emmanuel Grumbach's message of "Tue, 22 Jun 2021 16:39:00 +0300")
Message-ID: <87o8bvi51b.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Emmanuel Grumbach <egrumbach@gmail.com> writes:

> On Tue, Jun 22, 2021 at 4:32 PM Kalle Valo <kvalo@codeaurora.org> wrote:
>>
>> Emmanuel Grumbach <emmanuel.grumbach@intel.com> writes:
>>
>> > iwlmei is a driver that handles the communication with the
>> > Wireless driver of the CSME firmware.
>> > More details in the documentation included in this patch.
>>
>> A complicated new feature and just two sentences in the commit log? The
>> commit log should give a proper overview what the patch does and why.
>> This commit log really says to the reader "I don't care, find out
>> yourself".
>>
>> And being nice I did try to read few paragraphs from the patch but as I
>> didn't even see any explanation for CSME or SAP I gave up.
>>
>
> CSME stands for converged security and management engine.
> It is well known and has a driver in the kernel under drivers/misc/mei

It maybe well known to you but it's not for me, and I'm pretty sure I'm
not the only one. Remember that not everyone work for Intel and this is
a community project, so please write commit logs accordingly.

But I see that you submitted v3, good. I'm reading that right now.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
