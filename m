Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95529427CEB
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Oct 2021 21:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhJITGl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 9 Oct 2021 15:06:41 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:26429 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229558AbhJITGk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 9 Oct 2021 15:06:40 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633806283; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=gnNNeRV6yuM2PnnQ2KoPRyYnD88mgagT1XjcGE1UiZg=; b=Rmq7eJET3OAzbgZcBv7FguO0CeE4V6w9YAEa6+XfV7W4RylWqO1OE4UHVw+x9PYuOPwPSR2q
 vMBl7OY146pj7hLPl29KJk2JckuUw7ZNC9p7oTjtGzFNiZTgIGiTA57eRGPS7LHPtl4oVV4f
 QYxth69Z2/2MObCTBBKn1+SSlAg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 6161e7c34ccc4cf2c74e1e19 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 09 Oct 2021 19:04:35
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 19CB2C4360D; Sat,  9 Oct 2021 19:04:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EC053C4338F;
        Sat,  9 Oct 2021 19:04:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org EC053C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Shayne Chen <shayne.chen@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v5 6/8] mt76: mt7915: fix muar_idx in mt7915_mcu_alloc_sta_req()
References: <20211001095355.10598-1-shayne.chen@mediatek.com>
        <20211001095355.10598-6-shayne.chen@mediatek.com>
Date:   Sat, 09 Oct 2021 22:04:30 +0300
In-Reply-To: <20211001095355.10598-6-shayne.chen@mediatek.com> (Shayne Chen's
        message of "Fri, 1 Oct 2021 17:53:53 +0800")
Message-ID: <87tuhq2f5t.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Shayne Chen <shayne.chen@mediatek.com> writes:

> For broadcast/multicast wcid, the muar_idx should be 0xe.
>
> Fixes: e57b7901469f ("mt76: add mac80211 driver for MT7915 PCIe-based
> chipsets")

Same here. Fixes tag on one line, no line wrapping.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
