Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483403DC495
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Jul 2021 09:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbhGaHtb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 31 Jul 2021 03:49:31 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:10579 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhGaHtb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 31 Jul 2021 03:49:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1627717765; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=PG8Cr4JhAKc51L0Lar8WV4pKB9F7HYK3uZSxjpCZnc8=; b=Ih6HbVTgcfs72uPspxT7nqMyKpkQ3V84psLBwehIkC1Mh+PNsjk4uesdJyGcrKPayAV9Tbqb
 BarZLafHwbXhVdAOiXO9xoMvUyD2f8i3KrEp9PdGmlrbkZWwVqgpiii/hgbVfdAjdkB95ALK
 qTqbUpkVcsGJkwbb21LC0s8fxF0=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 6105006ee81205dd0ab04cd2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 31 Jul 2021 07:49:02
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F0B84C433D3; Sat, 31 Jul 2021 07:49:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7FDBBC433F1;
        Sat, 31 Jul 2021 07:49:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7FDBBC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     greearb@candelatech.com
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v4 1/8] mt76 - mt7915: Add ethtool stats support.
References: <20210723154627.10078-1-greearb@candelatech.com>
Date:   Sat, 31 Jul 2021 10:48:56 +0300
In-Reply-To: <20210723154627.10078-1-greearb@candelatech.com> (greearb's
        message of "Fri, 23 Jul 2021 08:46:20 -0700")
Message-ID: <87bl6iditz.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

greearb@candelatech.com writes:

> From: Ben Greear <greearb@candelatech.com>
>
> This exposes some tx-path stats to the ethtool API, so that
> ethtool -S wlanX provides some more useful info.
>
> Signed-off-by: Ben Greear <greearb@candelatech.com>

The subject style mt76 uses is:

mt76: mt7915: Add ethtool stats support

And no period in the end.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
