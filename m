Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718B02C410B
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Nov 2020 14:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgKYNW1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Nov 2020 08:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgKYNW1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Nov 2020 08:22:27 -0500
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58944C0613D4
        for <linux-wireless@vger.kernel.org>; Wed, 25 Nov 2020 05:22:27 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Ch1lM5mHMzQlS0;
        Wed, 25 Nov 2020 14:22:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=doubly.so; s=MBO0001;
        t=1606310542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0+0yV9UWSSfTAHJIFnoA6cRC+hPz6KMs92d5BPOgKmg=;
        b=woEAkSDh7Vm59uGkGvErbU/rUrDknIwXZNgOqERMHiJ1Eyz/2HUzrI2AjLh03vInujcI5d
        eiSVNwqZkKQLI8yEASPaxMUYKQMgbGR90ivLqXXilaBXBdTRGTPjuf5hbOhHgptHc8OvEg
        W2hBhH0ZJTEtML1ELFegw8fac1nXQddC9vUi0GmwMuyjlbtpZ+Q8AEq/XMi57Ha3c73cb0
        ZnG8h6zMNOHuFbwjf35af4lYZUOskMup7dVo5yIndULoXf2X81/aCH9bBa+VG3DHH2KQAk
        1s/gp8TMOZVRy6Zeo0R0mvC8dCUTrTVxFj2Z1VoV7qUD5w55lU+j3rRWF/lyYA==
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id CzznykU25NaE; Wed, 25 Nov 2020 14:22:20 +0100 (CET)
Subject: Re: ath11k with QCA6391
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
References: <c9fb5fa6-297e-a595-7670-c9105641bc83@doubly.so>
 <87wnz3twvo.fsf@codeaurora.org>
 <5f3ee526-e96f-3c88-a17e-e7ebf9703ed1@doubly.so>
 <87d00uo85x.fsf@codeaurora.org>
From:   Devin Bayer <dev@doubly.so>
Message-ID: <48f37c07-ca63-7ba9-1518-a31681777b15@doubly.so>
Date:   Wed, 25 Nov 2020 14:22:19 +0100
MIME-Version: 1.0
In-Reply-To: <87d00uo85x.fsf@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -5.09 / 15.00 / 15.00
X-Rspamd-Queue-Id: BDB1B171A
X-Rspamd-UID: 11fca3
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 03/11/2020 14.56, Kalle Valo wrote:
> Devin Bayer <dev@doubly.so> writes:
> 
>> On 02/11/2020 19.51, Kalle Valo wrote:
>>>
>>> To my knowledge, from ath11k point of view, QCA6391 should look the same
>>> as QCA6390 but most likely the board file for QCA6391 is different.
>>>
>> [snip]
>>
>> They are different than those from your repo, but maybe I can use
>> bdwlan01.e04 as the board file.
> 
> Yes, that's what I would also suggest to test first: take the firmware
> from ath11k-firmware.git and the board file from the vendor.

I would like to report that with your latest qca6390-bringup branch my QCA6391
card is working well with just the one MSI vector. I'm using the board file for
6390 from the linux-firmware repo.

Thanks for the fixes :)

~ dev
