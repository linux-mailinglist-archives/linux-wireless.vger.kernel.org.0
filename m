Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E840427CEA
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Oct 2021 21:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhJITFm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 9 Oct 2021 15:05:42 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:64155 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhJITFi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 9 Oct 2021 15:05:38 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633806220; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=DEVHqhERMyF+yDvTD6c1J+XFH/EcPQz2B8BOjcV+97E=; b=Y6+rjG3y+rT673pPOw7A8aq36cgBCcTieQ1MzzTOeC7UCvrc7fWhmycyZjDNlXHmrAMWC52v
 +Y/h2kNFSh7IFqM+1MnwftF4ATUqUrOWBGLDMEYq6UdTwoy1ufB1wjpwRHT+EQM7WGANhxpk
 PHZFLYgnx8WMfU8C+jzeAZ27Gk4=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 6161e78a22fe3a98e58c5cfe (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 09 Oct 2021 19:03:38
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 136D5C43617; Sat,  9 Oct 2021 19:03:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6F270C4338F;
        Sat,  9 Oct 2021 19:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 6F270C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Shayne Chen <shayne.chen@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v5 4/8] mt76: mt7915: fix sta_rec_wtbl tag len
References: <20211001095355.10598-1-shayne.chen@mediatek.com>
        <20211001095355.10598-4-shayne.chen@mediatek.com>
Date:   Sat, 09 Oct 2021 22:03:30 +0300
In-Reply-To: <20211001095355.10598-4-shayne.chen@mediatek.com> (Shayne Chen's
        message of "Fri, 1 Oct 2021 17:53:51 +0800")
Message-ID: <87y2722f7h.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Shayne Chen <shayne.chen@mediatek.com> writes:

> Fix tag len error for sta_rec_wtbl, which causes fw parsing error for
> the tags placed behind it.
>
> Fixes: e57b7901469f ("mt76: add mac80211 driver for MT7915 PCIe-based
> chipsets")

Fixes tag must be in one line.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
