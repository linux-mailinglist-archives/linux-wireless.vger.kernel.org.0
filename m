Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3143F1D71
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Aug 2021 18:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhHSQHN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Aug 2021 12:07:13 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:28835 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhHSQHN (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Aug 2021 12:07:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629389196; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=PfiKxiRVzTeZn/6Bdsu/sbhy2HWUxwJvKh650opMqZQ=; b=Y+UBkt4VV7HtUMY79QhJpOfYi+2XYXCPBvvo/vPMVpPZECNuwnxTjViM+Hi99diaWqDT1zDX
 FFR28W6KHIGF9KAr1UMw7QeRPIm2IKR7dgP1/5Y3noVPBGIoRdenUxAUCp0fl/7f8qVDkEY4
 Yf+6NgZFY2xhDW3300VN9qvEVxI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 611e817e454b7a558f9d22df (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 19 Aug 2021 16:06:22
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 84C2FC4338F; Thu, 19 Aug 2021 16:06:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 72AE1C43460;
        Thu, 19 Aug 2021 16:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 72AE1C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     greearb@candelatech.com
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v5 05/11] mt76: mt7915:  debugfs hook to enable TXS for NO_SKB pkt-ids
References: <20210804134505.3208-1-greearb@candelatech.com>
        <20210804134505.3208-5-greearb@candelatech.com>
Date:   Thu, 19 Aug 2021 19:06:18 +0300
In-Reply-To: <20210804134505.3208-5-greearb@candelatech.com> (greearb's
        message of "Wed, 4 Aug 2021 06:44:59 -0700")
Message-ID: <87mtpda079.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

greearb@candelatech.com writes:

> From: Ben Greear <greearb@candelatech.com>
>
> This lets user turn on/off this feature.  Enabling gives better
> tx-rate related stats, but will cause extra driver and (maybe)
> firmware work.  Not sure if it actually affects performance or
> not.
>
> Signed-off-by: Ben Greear <greearb@candelatech.com>

This is grey area, debugfs is not really meant to be used for users
enabling driver features.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
