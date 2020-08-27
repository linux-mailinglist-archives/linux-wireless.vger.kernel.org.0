Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A351D2547BD
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Aug 2020 16:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgH0NPM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 09:15:12 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:58527 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727863AbgH0NN1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 09:13:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598534007; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=U+qTNJaSSVwTdCar1nMaVLBQkJLIa6dkmct+l7FiGIU=;
 b=LOIiqG/DNxJSOdtLlKjeEJ7gScMw/4pSZR1WWCAEjvqh1AXenphc8U2hQGtWrRW0AvEQPfRl
 X2yRxt7gNGpB8n1MLW/Lh9IeLs5BvMq7vKShPma+DFCmZ7qXORzAcp/R+mRsxisQjxZpGqU0
 vnLtk0KQJd0Roliv/n+iEPvx+ds=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f47b17415988fabe06a2e29 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 27 Aug 2020 13:13:24
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 63E99C433CB; Thu, 27 Aug 2020 13:13:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 95756C433CA;
        Thu, 27 Aug 2020 13:13:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 95756C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 5.9] mt76: mt7915: use ieee80211_free_txskb to free tx
 skbs
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200812144943.91974-1-nbd@nbd.name>
References: <20200812144943.91974-1-nbd@nbd.name>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200827131324.63E99C433CB@smtp.codeaurora.org>
Date:   Thu, 27 Aug 2020 13:13:24 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> wrote:

> Using dev_kfree_skb for tx skbs breaks AQL. This worked until now only
> by accident, because a mac80211 issue breaks AQL on drivers with firmware
> rate control that report the rate via ieee80211_tx_status_ext as struct
> rate_info.
> 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>

Patch applied to wireless-drivers.git, thanks.

b4be5a53ebf4 mt76: mt7915: use ieee80211_free_txskb to free tx skbs

-- 
https://patchwork.kernel.org/patch/11710923/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

