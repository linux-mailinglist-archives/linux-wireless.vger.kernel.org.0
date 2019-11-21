Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3411D10521E
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2019 13:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfKUMQc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Nov 2019 07:16:32 -0500
Received: from a27-185.smtp-out.us-west-2.amazonses.com ([54.240.27.185]:50386
        "EHLO a27-185.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726197AbfKUMQb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Nov 2019 07:16:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574338590;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=JF7ooBmQ+MLBsMjxJ+MENB7mii+RnrKImvrzg0cWnoI=;
        b=WflKaVRYhyE25gQO5neGD08BGacnGu3gpwDR97s8at3Il7JjhJy0fDA8ZJf+sH8c
        FjMM3azpOmfIQI9HFE2VaPJqViPfq006T2wveeIRDOsQwTY8tUGhmQbw42XoRnQQtj0
        hVNBBDUT8/s2UcL0HIgSXBXrlLVmSHTPLZPrzflo=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574338590;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=JF7ooBmQ+MLBsMjxJ+MENB7mii+RnrKImvrzg0cWnoI=;
        b=Mv26eeJsCm0W/w9pFt82WEQAKFv4T0IQfQLyw4GY1lMarQWVa9Ne1UWov2u/yvs6
        HQwXD80EzwBcj22GStNYSHDntORNZSywDs+VHEr219EzEksZwCSoVQUsTgBRWVRqHlg
        YliM8KfDOKPN52N6cMXBBbBwGOgdW7TLA6l/IpUA=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6AD58C433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
Cc:     Jonas Gorski <jonas.gorski@gmail.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Andrey Shevchenko <ashevchenko@quantenna.com>
Subject: Re: [PATCH v2 2/2] qtnfmac: add support for Topaz chipsets
References: <20181016102349.26544-1-sergey.matyukevich.os@quantenna.com>
        <20181016102349.26544-3-sergey.matyukevich.os@quantenna.com>
        <CAOiHx=nBWr4GNh61WV+SAY-++Z6es-HX3_pd70DB_N33bVK1tw@mail.gmail.com>
        <41b4f41f-37ae-ef5f-476c-eb616d6a3da1@quantenna.com>
        <CAOiHx=myYOAYPm0KwS3wP+sPLaQH9obUv0wbdteCx6REJPKQgw@mail.gmail.com>
        <37ee7285-5856-6a77-3a29-92b86886c48c@quantenna.com>
Date:   Thu, 21 Nov 2019 12:16:30 +0000
In-Reply-To: <37ee7285-5856-6a77-3a29-92b86886c48c@quantenna.com> (Igor
        Mitsyanko's message of "Thu, 21 Nov 2019 02:27:17 +0000")
Message-ID: <0101016e8de4774f-c81ce2c1-f2c7-40d4-83b2-f8f8a49b1f8a-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2019.11.21-54.240.27.185
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Igor Mitsyanko <igor.mitsyanko.os@quantenna.com> writes:

> On 11/19/19 8:12 AM, Jonas Gorski wrote:
>> Any update on this? The support now had its first anniversary, and
>> still no firmware available for it.
>> 
>> Maybe you could put it up in a (temporary) download location at
>> Quantenna until you get around to the second attempt?
>
> Hi Jonas, Quantenna was recently acquired by ON Semiconductor and this 
> was put on hold during the integration. I have gone back to our legal / 
> IT department to work on this again.

Thanks, and please put priority on this. It's really bad that if there's
an upstream driver but users can't use it because of lack of firmware.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
