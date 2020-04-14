Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126521A780F
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2020 12:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438110AbgDNKGD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Apr 2020 06:06:03 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:23540 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2438097AbgDNKGC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Apr 2020 06:06:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586858761; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=VXvOdKy6CCyAPMd/h91SwZnHIpupce3DVaASPSKrwg8=; b=QV1OLhFTAtpfOvOQofexuNJuVFqtsdD5MrTVsbqmmesKFpoWuDk0mMNnSWRzFAfe6ffmQY7N
 wZHvHg2HQQ4WkSuq0rEZ4qGaXsG6W2yKu725dQ6dByApSNFz/APRUClA/GxawAcoadpJ9two
 qpy4kKmr8lQ+riHwGTOktmaI0Go=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e958b02.7f7c1e0737d8-smtp-out-n02;
 Tue, 14 Apr 2020 10:05:54 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E3737C432C2; Tue, 14 Apr 2020 10:05:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 49171C433F2;
        Tue, 14 Apr 2020 10:05:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 49171C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        "YF Luo" <yf.luo@mediatek.com>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        Chih-Min Chen <chih-min.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 08/16] mt76: mt7915: add offloading Tx AMSDU support
References: <cover.1586507878.git.ryder.lee@mediatek.com>
        <0cf99a5f317b0d41cd4832b14c99b6b9b8e5fefc.1586507878.git.ryder.lee@mediatek.com>
        <87imi2lg71.fsf@tynnyri.adurom.net>
        <1586858399.6545.1.camel@mtkswgap22>
Date:   Tue, 14 Apr 2020 13:05:48 +0300
In-Reply-To: <1586858399.6545.1.camel@mtkswgap22> (Ryder Lee's message of
        "Tue, 14 Apr 2020 17:59:59 +0800")
Message-ID: <874ktmtm9v.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ryder Lee <ryder.lee@mediatek.com> writes:

> On Tue, 2020-04-14 at 09:44 +0300, Kalle Valo wrote:
>> Ryder Lee <ryder.lee@mediatek.com> writes:
>> 
>> > Add module parameter to enable hw_tx_amsdu.
>> 
>> Why is a module parameter needed? And why is it not enabled by default?
>> 
>
> This is still WIP, so make it optional. But I will drop this one until
> we're ready.

What do you mean? Are you saying that these patches are still RFC and
the final patches will not have the module parameter?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
