Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252BD1A73DB
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2020 08:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgDNGsw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Apr 2020 02:48:52 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:63963 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728133AbgDNGsv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Apr 2020 02:48:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586846931; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=UHM5/YIDr5wmXBMzN36WzRu76iZETHqETU6tv8SIFjc=; b=Ll6El0oNYpvmYgoimlhThoIU3Ds18dQssVWIYXAaWWRqMC+VsLyylBGQBlVcpaMWa+7VKnNX
 I4AQObdN3TzpAGDC5wrOoRti+Ar0xDyWKjDxYqswb3h1AmA5dgox+/ueREss9FCxCT9nVHOr
 2YvLxTTA/TzVZX4B/oYya4owMyc=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e955cd2.7f5a9e09f378-smtp-out-n03;
 Tue, 14 Apr 2020 06:48:50 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DFED5C43637; Tue, 14 Apr 2020 06:48:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 25D0EC433F2;
        Tue, 14 Apr 2020 06:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 25D0EC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        YF Luo <yf.luo@mediatek.com>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        Chih-Min Chen <chih-min.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v1 00/16] Add MediaTek IEEE 802.11ax devices - MT7915E
References: <cover.1586558901.git.ryder.lee@mediatek.com>
Date:   Tue, 14 Apr 2020 09:48:45 +0300
In-Reply-To: <cover.1586558901.git.ryder.lee@mediatek.com> (Ryder Lee's
        message of "Sat, 11 Apr 2020 06:51:15 +0800")
Message-ID: <87eesqlfzm.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ryder Lee <ryder.lee@mediatek.com> writes:

> MT7915E is the latest generation IEEE 802.11ax NIC in MediaTek, which
> currently supports AP, Station and Mesh mode.
>
> Even though some code of MT7915[1] are similar to MT7615. New generation has: 
> - Huge amounts of HE dedicated parts.
> - New designs of PHY/firmware/DMA scheme.
> - Most fields of txd/txs/rxd/rxv are rearranged or deprecated.
> - Support much more offloading stuff.
>
> Most importantly, for the sake of convenience to get family devices supported
> in the future, it was concluded to be simpler to have a clean start for this
> generation. This makes maintenance easier and avoids major changes in MT7615,
> which currently shares the codes with low power capable device MT7663. It will
> increase the risk of regressions in existing flow.
>
> MT7915 supports only basic HE for the moment, whereas other 802.11ax specific
> features, such as BSS color, TWT, SR, DCM and OFDMA are work in progress,
> and will be gradually added in upcoming days.
>
> The firmwares are available now from https://github.com/ryderlee1110/wireless-fw ,
> and will be submitted soon. At last, the developers are all listed in the series.
>
> [1] https://www.mediatek.com/blog/mediatek-mt7915-wi-fi-6-wave-1-chipset-builds-in-a-range-of-industry-firsts 
>
> Thanks,
> Ryder
>
> Changes since v1 -
> - list a missing developer.
> - drop unused codes in the hw_tx_amsdu patch.
> - add a missing bitwidth change of wcid.
> - add more TODO items in the driver.

This patchset should be marked as v2, no big deal but just a
clarification. I did have few comments on the real v1 though, please
take a look.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
