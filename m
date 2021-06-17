Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7D73AB54A
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 15:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbhFQOBG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 10:01:06 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:56439 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbhFQOBF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 10:01:05 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623938338; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=TzfxZUyHGmp56u7Fj/mDFFozDlUVMgHz4/qdIVPnPuE=; b=T7UsijArKTcxK4GWGx0pu25ExNMHFSbONQ9Nc+KrLIQcUmQbir4b9lRoOrVd4Tp+ZzfoX0ox
 BzngQT8bYf2YhAw48I10bsR0bIno1qaYPFcI+I6l/0XaA4UvhGKZwH1L/bvzJw1HoyaI3d+E
 rrWzMtrFGgTRd1KigoIxdmVdpoI=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 60cb5516b6ccaab75394d1cd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 17 Jun 2021 13:58:46
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2ABE1C43460; Thu, 17 Jun 2021 13:58:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 286B1C433F1;
        Thu, 17 Jun 2021 13:58:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 286B1C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: pull request: mt76 2021-06-10
References: <7e509477-cb3d-9d18-7386-d989cbeeb178@nbd.name>
Date:   Thu, 17 Jun 2021 16:58:40 +0300
In-Reply-To: <7e509477-cb3d-9d18-7386-d989cbeeb178@nbd.name> (Felix Fietkau's
        message of "Thu, 10 Jun 2021 13:41:59 +0200")
Message-ID: <871r90k2y7.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> Hi Kalle,
>
> here's my first pull request for 5.14
>
> - Felix
>
> The following changes since commit 080f9c10c773df39ccebe8dc414179d9179005a9:
>
>   ipw2x00: Minor documentation update (2021-06-03 12:33:55 +0300)
>
> are available in the Git repository at:
>
>   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2021-06-10
>
> for you to fetch changes up to c3dfa83c3e625e111874295076557b7dddadda13:
>
>   mt76: mt7915: drop the use of repeater entries for station interfaces (2021-06-10 13:39:41 +0200)
>
> ----------------------------------------------------------------
> mt76 patches for 5.14
>
> * mt7915 MSI support
> * disable ASPM on mt7915
> * mt7915 tx status reporting
> * mt7921 decap offload
> * driver fixes
> * cleanups
> * mt7921 runtime power management improvements
> * testmode improvements/fixes
>
> ----------------------------------------------------------------

I updated wireless-drivers-next this morning to latest net-next and
there are now few conflicts:

$ git pull https://github.com/nbd168/wireless tags/mt76-for-kvalo-2021-06-10
From https://github.com/nbd168/wireless
 * tag                         mt76-for-kvalo-2021-06-10 -> FETCH_HEAD
Auto-merging drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
CONFLICT (content): Merge conflict in drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
Auto-merging drivers/net/wireless/mediatek/mt76/mt7921/main.c
Auto-merging drivers/net/wireless/mediatek/mt76/mt7921/mac.c
Auto-merging drivers/net/wireless/mediatek/mt76/mt7921/init.c
CONFLICT (content): Merge conflict in drivers/net/wireless/mediatek/mt76/mt7921/init.c
Auto-merging drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
Auto-merging drivers/net/wireless/mediatek/mt76/mt7615/mac.c
Auto-merging drivers/net/wireless/mediatek/mt76/mt7615/init.c
Auto-merging drivers/net/wireless/mediatek/mt76/mac80211.c

I can fix those but having instructions how to solve them will help.

With GCC 11.1 I see a new warning:

drivers/net/wireless/mediatek/mt76/mt7915/init.c: In function 'mt7915_thermal_init':
drivers/net/wireless/mediatek/mt76/mt7915/init.c:138:17: warning: ignoring return value of 'sysfs_create_link' declared with attribute 'warn_unused_result' [-Wunused-result]
  138 |                 sysfs_create_link(&wiphy->dev.kobj, &cdev->device.kobj,
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  139 |                                   "cooling_device");
      |                                   ~~~~~~~~~~~~~~~~~

Also two problems with commit logs:

In commit

  a4777798a401 ("mt76: connac: fix WoW with disconnetion and bitmap pattern")

Fixes tag

  Fixes: ffa1bf97425 ("mt76: mt7921: introduce PM support")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

Commit

  34bd6f5f1e24 ("mt76: move mt76_rates in mt76 module")

is missing a Signed-off-by from its committer.


-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
