Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18826204CC1
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2020 10:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731959AbgFWImv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jun 2020 04:42:51 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:16358 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731827AbgFWImv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jun 2020 04:42:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592901770; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=2JXv1sPeKohhL31DbbI4oeGc4hDEaCu/fgKpr1Zi9Wg=;
 b=qwCbrxNaAh+MVNqVgXyk/BNihaLxWhfwEwrQO8Dfm6V1ufmPKPFCMZd858lYH2KfTi8W0M1G
 VkkHL1kzk3QuAvlsizCeQ/brA908+0vQ4J2sBSWJ9CONOdqN5Etq3ZEzGV+0VIV+cOLgwvmA
 5Quyl24hQNg36vJSFuKoF5LskE4=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n11.prod.us-west-2.postgun.com with SMTP id
 5ef1c0684c9690533aa673d2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 23 Jun 2020 08:42:16
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 67C96C433CA; Tue, 23 Jun 2020 08:42:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 22C85C433C8;
        Tue, 23 Jun 2020 08:42:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 22C85C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull request: mt76 2019-06-07
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <8af947fd-8d23-ce5c-eee5-1107d6af9d22@nbd.name>
References: <8af947fd-8d23-ce5c-eee5-1107d6af9d22@nbd.name>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200623084216.67C96C433CA@smtp.codeaurora.org>
Date:   Tue, 23 Jun 2020 08:42:16 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> wrote:

> Hi Kalle,
> 
> here's another pull request for 5.8 with a few fixes
> 
> - Felix
> 
> The following changes since commit 1806c13dc2532090d742ce03847b22367fb20ad6:
> 
>   Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2020-05-31 17:48:46 -0700)
> 
> are available in the Git repository at:
> 
>   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2020-06-07
> 
> for you to fetch changes up to 7f88314321e20744114bc596b6528bb9d57ff46f:
> 
>   mt76: overwrite qid for non-bufferable mgmt frames (2020-06-07 16:59:40 +0200)
> 
> ----------------------------------------------------------------
> mt76 patches for 5.8
> 
> * tx queueing fixes for mt7615/22/63
> * locking fix
> 
> ----------------------------------------------------------------
> Lorenzo Bianconi (4):
>       mt76: add missing lock configuring coverage class
>       mt76: mt7615: fix lmac queue debugsfs entry
>       mt76: mt7615: fix hw queue mapping
>       mt76: overwrite qid for non-bufferable mgmt frames
> 
>  drivers/net/wireless/mediatek/mt76/mt76.h           |  1 +
>  drivers/net/wireless/mediatek/mt76/mt7603/main.c    |  2 ++
>  drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c |  9 +++++----
>  drivers/net/wireless/mediatek/mt76/mt7615/dma.c     |  9 +++++----
>  drivers/net/wireless/mediatek/mt76/mt7615/mac.c     | 20 +++++++-------------
>  drivers/net/wireless/mediatek/mt76/mt7615/mac.h     | 15 ---------------
>  drivers/net/wireless/mediatek/mt76/mt7615/main.c    |  4 ++++
>  drivers/net/wireless/mediatek/mt76/mt7615/mmio.c    |  2 +-
>  drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h  | 30 ++++++++++++++++++++++++++++++
>  drivers/net/wireless/mediatek/mt76/mt7615/usb.c     |  2 +-
>  drivers/net/wireless/mediatek/mt76/mt7915/main.c    |  3 +++
>  drivers/net/wireless/mediatek/mt76/tx.c             |  7 +++++++
>  drivers/net/wireless/mediatek/mt76/usb.c            | 17 +++++++++--------
>  13 files changed, 75 insertions(+), 46 deletions(-)

Pulled, thanks.

6247c3b0779c Merge tag 'mt76-for-kvalo-2020-06-07' of https://github.com/nbd168/wireless

-- 
https://patchwork.kernel.org/patch/11591655/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

