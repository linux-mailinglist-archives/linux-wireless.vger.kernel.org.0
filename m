Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAEE103568
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2019 08:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbfKTHnu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Nov 2019 02:43:50 -0500
Received: from a27-55.smtp-out.us-west-2.amazonses.com ([54.240.27.55]:59890
        "EHLO a27-55.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725268AbfKTHnu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Nov 2019 02:43:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574235829;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date;
        bh=nBf2jvI0j5u8v16i9vUkT4fbmDIvKVWf6Z4vUOF2TRs=;
        b=TxD1W8qnNYkeAFtD3AKZiSvB1bmwhEf4MK9UKCSWqLoJE0Y53675FMZg3mt+l129
        jttl0YEXbpVbhtzKzxsTn6AMmhXV4Eb4AEvq6t/ObfTcjGjcexeEvi6fSl1D9yw8z6/
        EUiUTdXhRt8QxoLb3ot0y3ehi46KXnuIej4bDz7s=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574235829;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date:Feedback-ID;
        bh=nBf2jvI0j5u8v16i9vUkT4fbmDIvKVWf6Z4vUOF2TRs=;
        b=ZjM0WIViDdj2WS8VBDSU/P2WEAJkqaVTHMqJgKqpyEJlci1mYf5WAwjriENaqeNp
        eDNl2tPnRUXl5mDX5PNwUTTBR4r/1lqICfLFu2jAqYrqwd7ucwqd71/mdB+sih6mfKD
        LIaBCdRck81Y4SVgGquFyzrmtLFNRPdxJoJj7M/s=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 692DEC447AA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/7] qtnfmac: remove VIF in firmware in case of error
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191118082255.6032-2-sergey.matyukevich.os@quantenna.com>
References: <20191118082255.6032-2-sergey.matyukevich.os@quantenna.com>
To:     Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-ID: <0101016e87c473e9-014ef1ca-44e5-4cee-9cf7-b2020edca582-000000@us-west-2.amazonses.com>
Date:   Wed, 20 Nov 2019 07:43:49 +0000
X-SES-Outgoing: 2019.11.20-54.240.27.55
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sergey Matyukevich <sergey.matyukevich.os@quantenna.com> wrote:

> From: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
> 
> Currently in case of error when registering network device with the
> kernel, we won't properly cleanup VIF state in firmware due to DEL_VIF
> command will not be send to wifi card. Make sure it does.
> 
> Signed-off-by: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>

7 patches applied to wireless-drivers-next.git, thanks.

45028223425d qtnfmac: remove VIF in firmware in case of error
decfc5c70d20 qtnfmac: track broadcast domain of each interface
904628d3130b qtnfmac: add interface ID to each packet
4e14e76cee38 qtnfmac: advertise netdev port parent ID
1db359946bd1 qtnfmac: signal that all packets coming from device are already flooded
be4f00cf1592 qtnfmac: add TLV for extension IEs
df0af4c7bac4 qtnfmac: process HE capabilities requests

-- 
https://patchwork.kernel.org/patch/11249063/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

