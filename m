Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94F7A4C8A5
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2019 09:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbfFTHsP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Jun 2019 03:48:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59982 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfFTHsP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Jun 2019 03:48:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8C9586087F; Thu, 20 Jun 2019 07:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561016894;
        bh=IW+/KOeblX1xWhniA1gfEQRbRm3aTfkZd0m2dEWUnWQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ojean/Q4pJ5QLUJAb2Lj9LU81GaLk694sokm4LQGEnLfiircyCUlKU1iNUCeG72JS
         Fq8FiXMdrvp+GqF6fMmFTjpRYmeis8+KH0mjicFMUaLj9fBSWkx/uRZ6pu6EmZVKa6
         CjIEe6FewKcoYvdiHLmwz3emGAa6+GWXN/lSdHYc=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from purkki.adurom.net (purkki.adurom.net [80.68.90.206])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6601B602A9;
        Thu, 20 Jun 2019 07:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561016894;
        bh=IW+/KOeblX1xWhniA1gfEQRbRm3aTfkZd0m2dEWUnWQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ojean/Q4pJ5QLUJAb2Lj9LU81GaLk694sokm4LQGEnLfiircyCUlKU1iNUCeG72JS
         Fq8FiXMdrvp+GqF6fMmFTjpRYmeis8+KH0mjicFMUaLj9fBSWkx/uRZ6pu6EmZVKa6
         CjIEe6FewKcoYvdiHLmwz3emGAa6+GWXN/lSdHYc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6601B602A9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     "Hodaszi\, Robert" <Robert.Hodaszi@digi.com>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] Revert "cfg80211: fix processing world regdomain when non modular"
References: <20190614131600.GA13897@a1-hr>
        <ebab80c3f632f792373bfcace252c7a1bf65ce89.camel@sipsolutions.net>
        <32951d52-3f9d-aaee-fa07-75585c03edba@digi.com>
        <6a9c7642a2fcca60658036c605438ff2ac982bd0.camel@sipsolutions.net>
Date:   Thu, 20 Jun 2019 10:48:10 +0300
In-Reply-To: <6a9c7642a2fcca60658036c605438ff2ac982bd0.camel@sipsolutions.net>
        (Johannes Berg's message of "Fri, 14 Jun 2019 16:01:00 +0200")
Message-ID: <87ef3ou285.fsf@purkki.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> On Fri, 2019-06-14 at 13:58 +0000, Hodaszi, Robert wrote:
>> 
>> I didn't just resend that. I just realized, accidentally I forgot to fix 
>> the debug message printing function, that define doesn't exist anymore. 
>> Sorry for the confusion!
>
> Oops. I looked too superficially then and didn't even see the
> difference, sorry.
>
> I guess that's why Kalle always says you should have a patch changelog
> :-)

Indeed :) And the obligatory link:

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#changelog_missing

-- 
Kalle Valo
