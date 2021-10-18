Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B2A431EF4
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Oct 2021 16:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbhJROHk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 10:07:40 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:31409 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233576AbhJROFk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 10:05:40 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634565809; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=0Fj4oE9VmcQdSF7I96TQicw/pGH/Pcdi7r+NuocLYnU=; b=k18XbjNjPiknCv1FxWw7b+Ck6qbur6CvjUsCLdaDngjUSNoJvEwl3Z/Ip3GWHKAWJdhStaRd
 m0dHJDxWtTw2OOIasAegtWlRzrCpvUGf26ivU9R+0CB20uz/aAyzM7klecs/s0bTZDRC9k0n
 pqedEvC+QmJWa9o0IfrQpbvVIhI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 616d7e75f922f9e77202c9bf (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 18 Oct 2021 14:02:29
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 31179C43616; Mon, 18 Oct 2021 14:02:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 41275C43616;
        Mon, 18 Oct 2021 14:02:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 41275C43616
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: pull request: mt76 2021-10-11 v2
References: <f595fe67-e3cc-4477-db79-5e2975c60160@nbd.name>
Date:   Mon, 18 Oct 2021 17:02:22 +0300
In-Reply-To: <f595fe67-e3cc-4477-db79-5e2975c60160@nbd.name> (Felix Fietkau's
        message of "Tue, 12 Oct 2021 21:13:47 +0200")
Message-ID: <874k9etor5.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> Hi Kalle,
>
> here's an updated version of my first pull request for 5.16
>
> - Felix
>
> The following changes since commit 9b793db5fca44d01f72d3564a168171acf7c4076:
>
>   b43: fix a lower bounds test (2021-10-11 09:09:30 +0300)
>
> are available in the Git repository at:
>
>   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2021-10-12
>
> for you to fetch changes up to 39e333d657f49619c65b9f5b59aa6405f13abf35:
>
>   mt76: do not access 802.11 header in ccmp check for 802.3 rx skbs (2021-10-12 20:28:10 +0200)
>
> ----------------------------------------------------------------
> mt76 patches for 5.16
>
> * various bugfixes
> * endian fixes
> * mt7921 aspm support
> * cleanup
> * mt7921 testmode support
> * rate handling fixes
> * tx status fixes/improvements
> * mt7921 power management improvements
> * mt7915 LED support
> * DBDC fixes
> * mt7921 6GHz support
> * support for eeprom data in DT
> * mt7915 TWT support
>
> ----------------------------------------------------------------

There are few problems:

In commit 4869b41c75770da466ed90eb8ac022175c5f72ce fixes tag have
incorrect format:

    Fixes: 1d8efc741df8 'mt76: mt7921: introduce Runtime PM support'
    Fixes: de5ff3c9d1a2 'mt76: mt7615: introduce pm_power_save delayed work'

In commit

  b7fce5823fd0 ("mt76: mt7921: fix the inconsistent state between bind and unbind")

Fixes tag

  Fixes: c1af184ba830 ("mt76: mt7921: fix dma hang in rmmod")

has these problem(s):

  - Target SHA1 does not exist

In commit

  34f3427bd233 ("mt76: add a bound check in mt76_calculate_default_rate()")

Fixes tag

  Fixes: 75fb2e62d444 (mt76: add mt76_default_basic_rate more devices can rely on)

has these problem(s):

  - Target SHA1 does not exist
  
In commit

  787523c2b0bd ("mt76: mt7915: add a missing HT flag for GI parsing")

Fixes tag

  Fixes: 14b220c07188 ("mt76: mt7915: report tx rate directly from tx status")

has these problem(s):

  - Target SHA1 does not exist

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
