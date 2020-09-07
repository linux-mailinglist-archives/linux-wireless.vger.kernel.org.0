Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D09D25FA04
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Sep 2020 13:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgIGL6u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Sep 2020 07:58:50 -0400
Received: from a27-188.smtp-out.us-west-2.amazonses.com ([54.240.27.188]:34340
        "EHLO a27-188.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729042AbgIGL6V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Sep 2020 07:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599476582;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID;
        bh=c0tNUJLjtjf1p27IOiKG5JMFWiohn2Olzu4gHEom3VE=;
        b=LJOHZ7N0slacmMGeV5fWRQCDPluWMQfIvyu6MzN/Q6Z7Vt9xpw64Zi8v4McsclFF
        bWU9ZNET5+Sf99UNiBt+ffMXRwSo0n1NzRV3T6ojbXlfe1oqBv3FWWP6te7efBb3rnV
        CRD9/GYf4pXek/9hYiwDPWZ35RDaLTuRt6JtJGoU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599476582;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:Feedback-ID;
        bh=c0tNUJLjtjf1p27IOiKG5JMFWiohn2Olzu4gHEom3VE=;
        b=jEbmGErHYRTd08w1Yn0ZJejS6BTiIEzvrOhfXXG5D11rAS9B6wfzRuiVyEpBBoDs
        DB0WxyY0B9IAv0D703o4f0ycOrVCS5H6X8q0emGjd0ddS+LDIW+BFHVye50lt8Oizgw
        a5EDvYuRs6OZ/8LPZJ6db5EJX0gakTrcty+vU34U=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 7 Sep 2020 11:03:02 +0000
From:   akolli@codeaurora.org
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v6 0/3] ath11k: Add IPQ6018 support
In-Reply-To: <877dt552q1.fsf@codeaurora.org>
References: <1598287470-1871-1-git-send-email-akolli@codeaurora.org>
 <877dt552q1.fsf@codeaurora.org>
Message-ID: <01010174683bc855-68c24953-aad8-4e8f-be57-2ef8f25891e0-000000@us-west-2.amazonses.com>
X-Sender: akolli@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
X-SES-Outgoing: 2020.09.07-54.240.27.188
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-09-07 15:27, Kalle Valo wrote:
> Anilkumar Kolli <akolli@codeaurora.org> writes:
> 
>> IPQ6018 has a 5G radio and 2G radio with 2x2
>> and shares IPQ8074 configuration.
>> 
>> Tested on: IPQ6018 WLAN.HK.2.2-02134-QCAHKSWPL_SILICONZ-1
>> Tested on: IPQ8074 WLAN.HK.2.4.0.1-00009-QCAHKSWPL_SILICONZ-1
> 
> I don't store the cover letters to git, so please move the Tested-on
> tags to actual patches so that they are properly archived.

Sure.

Thanks
Anil
