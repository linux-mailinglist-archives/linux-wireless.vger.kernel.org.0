Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3FB4BB375
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2019 14:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393968AbfIWMQd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Sep 2019 08:16:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45180 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393960AbfIWMQd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Sep 2019 08:16:33 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 870406013C; Mon, 23 Sep 2019 12:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569240992;
        bh=LkGj+5ymw4rIGPpNpqU/Eznq6S0QBsoLMSqf4vE2rPk=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=OV4B/raWMz5Nalk9NznN4H7f23wN1Va+6newzUPjyjn3kWQ5dvrRhcSnak/8r0f+k
         jkQ6sZqOPRp01IGs+BOrF9tcVX7mMPBKgC9B3tldnpnXk2Br6qV60/AQUxzeth9U80
         a7KjY9dRwG2NEZZ/Tk5NCG7BuNgmom1+cbo+qnUg=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from DLANSKY (unknown [185.23.60.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: dlansky@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A6ACC60240;
        Mon, 23 Sep 2019 12:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569240991;
        bh=LkGj+5ymw4rIGPpNpqU/Eznq6S0QBsoLMSqf4vE2rPk=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=e+GmIk4mFNqqkIxGgqDBB09k6HBoBEeMwtGCDDjL7cJtrn5yKCCtaMaIPbpTGyWuI
         rR+cvgCkLChe7jQ88BCXj4qw0Q7jUvJLf0csrIS/zmxnfYDLbkvSICiMlVdTfQH/fh
         ezaWbo4pzfcZBQJsHsI8YUt9D/kjwb9lb7+mbEBM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A6ACC60240
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=dlansky@codeaurora.org
From:   "Dedy Lansky" <dlansky@codeaurora.org>
To:     "'Johannes Berg'" <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
Cc:     "'Johannes Berg'" <johannes.berg@intel.com>,
        "'Dmitry Osipenko'" <digetx@gmail.com>
References: <1569239475-I2dcce394ecf873376c386a78f31c2ec8b538fa25@changeid>
In-Reply-To: <1569239475-I2dcce394ecf873376c386a78f31c2ec8b538fa25@changeid>
Subject: RE: [EXT] [PATCH] cfg80211: initialize on-stack chandefs
Date:   Mon, 23 Sep 2019 15:16:28 +0300
Message-ID: <000b01d57208$bc0b0000$34210000$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHVcgVGtDddkMgf9kygRaUriCTrQKc5KXBA
Content-Language: en-us
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>
>
> ---
>  net/wireless/nl80211.c     | 4 +++-
>  net/wireless/reg.c         | 2 +-
>  net/wireless/wext-compat.c | 2 +-
>  3 files changed, 5 insertions(+), 3 deletions(-)

We planned to upload pretty much same fix today. You beat us on this.
We thought also to add memset in ieee80211_build_preq_ies()
(net/mac80211/util.c) but maybe this is not critical.

Thanks,
 Dedy.

