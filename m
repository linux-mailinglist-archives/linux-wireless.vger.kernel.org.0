Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 589F481FFB
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2019 17:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbfHEPUR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Aug 2019 11:20:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48450 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728468AbfHEPUR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Aug 2019 11:20:17 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0758960867; Mon,  5 Aug 2019 15:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565018417;
        bh=lldT1gyYdxII/34jzklE70pyJkb4FyBeBVJS9Wu3oXM=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=PJvf0Ha1CUHXkrJ3m6o+2GJWCL4Fk3K/CA6wao2YymasKV/Oe2cxTpGDLOvIUDqZc
         nOwzFHCc8654RUOszeuTsWUt0XsWQ2YgS7Xyw3yWh6pSp3evivhco0yP+RGS31N2iC
         XAV1+vaqj606A07wJURb0tBomhKiStJT3uLYJMb8=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 42E0F6074F;
        Mon,  5 Aug 2019 15:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565018416;
        bh=lldT1gyYdxII/34jzklE70pyJkb4FyBeBVJS9Wu3oXM=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=pAKnIoIy0WUByNmJ1Dbo8KCqOyBO5yCjKbWIhdT4kINGlQ58iMRSaGpGPcxif8TSS
         4EDpQntdyyGIxhyTnYIBr1OVpSKB4j8ignJn8ntV6tE420K1Ws3x83AxktaBJ8YjeE
         XQD3po59VmyLR9pPLDmeFaDYw3+mWw+eiT0ooyFw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 42E0F6074F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=dlansky@codeaurora.org
From:   "Dedy Lansky" <dlansky@codeaurora.org>
To:     "'Johannes Berg'" <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
Cc:     "'Florian Westphal'" <fw@strlen.de>,
        "'Johannes Berg'" <johannes.berg@intel.com>
References: <20190731220848.1045-1-johannes@sipsolutions.net>
In-Reply-To: <20190731220848.1045-1-johannes@sipsolutions.net>
Subject: RE: [EXT] [RFC/RFT] cfg80211: decouple us from the RTNL
Date:   Mon, 5 Aug 2019 18:20:05 +0300
Message-ID: <000701d54ba1$48ea2520$dabe6f60$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHVR+ylOs684nZaW0qVBxuZT8k/Z6bq3BwA
Content-Language: en-us
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


From: linux-wireless-owner@vger.kernel.org
<linux-wireless-owner@vger.kernel.org> On Behalf Of Johannes Berg
Sent: Thursday, August 1, 2019 1:09 AM

> Fix that by re-adding a mutex to each wiphy/rdev as we had at
> some point, so we have locking for the wireless_dev lists and
> all the other things in there, and also so that drivers still
> don't have to worry too much about it (they still won't get
> parallel calls for a single device).

Sounds good.

> Then, we can restrict the RTNL to a few cases where we add or
> remove interfaces and really need the added protection. Some
> of the global list management still also uses the RTNL, since
> we need to have it anyway for netdev management.

> TODO:
>  - use wiphy_lock()/wiphy_unlock() in all drivers as the code
>    changed in mac80211 does

I guess this change breaks existing drivers because some drivers assume RTNL
is locked when their cfg callbacks are executed. Is that correct?

Would there be any simple rules for drivers when to use each one of the
locking API: rtnl vs wiphy vs wdev ?

Thanks,
 Dedy.

