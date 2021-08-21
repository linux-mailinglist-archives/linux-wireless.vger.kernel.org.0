Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DECC3F3AD6
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Aug 2021 15:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhHUNy1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Aug 2021 09:54:27 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:37997 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229593AbhHUNy1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Aug 2021 09:54:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629554027; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=ExSTpZVTkMLuLl3k2obEZndgqEaIBsVKlJ9wh93FXDM=; b=wivYB8CcGlIPf3swUm78YUQ56GkCUVcso1kyO7WouAKpai8CV69/qI07Li7zuLEjdKiGqFn/
 KQbX16qrJ35vTsV1fUz0yH2ak6SMYwBnCCLpKNocgagR+iLeMr2cGw4WGSLUHTHbLFR6lNea
 20BGxm3a47iRuOtzpvrln2WTa5I=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 6121056b2b9e91b6881ea8ee (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 21 Aug 2021 13:53:47
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E126AC43617; Sat, 21 Aug 2021 13:53:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C7A01C4338F;
        Sat, 21 Aug 2021 13:53:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org C7A01C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        Deren.Wu@mediatek.com
Subject: Re: [PATCH 3/5] mt76: mt7921: report tx rate directly from tx status
References: <cover.1629277624.git.lorenzo@kernel.org>
        <1aa7b946cac8bb1c3d3ad3eaa41a7c610d122d92.1629277624.git.lorenzo@kernel.org>
        <87a6ldbi20.fsf@tynnyri.adurom.net> <YR54aQ2Rih62lZYj@lore-desk>
Date:   Sat, 21 Aug 2021 16:53:41 +0300
In-Reply-To: <YR54aQ2Rih62lZYj@lore-desk> (Lorenzo Bianconi's message of "Thu,
        19 Aug 2021 17:27:37 +0200")
Message-ID: <877dgeucnu.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> On Aug 19, Kalle Valo wrote:
>> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>> 
>> > Report tx rate from tx status packets instead of receiving periodic mcu
>> > event. This improves flexibility, accuracy and AQL performance, and
>> > simplifies code flow for better readability.
>> >
>> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>> 
>> [...]
>> 
>> > +		/* We don't support reading GI info from txs packets.
>> > +		 * For accurate tx status reporting and AQL improvement,
>> > +		 * we need to make sure that flags match so polling GI
>> > +		 * from per-sta counters directly.
>> > +		 */
>> > +		rate = &msta->wcid.rate;
>> > +		addr = MT_WTBL_LMAC_OFFS(idx, 0) + 7 * 4;
>> 
>> Magic values.
>
> ack, I reused what was already in mt7921_mac_sta_poll(), but I can add some
> definitions :)

Heh, I guess then I have been doing sloppy review earlier :) But thanks
for fixing these, we should not repeat past mistakes.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
