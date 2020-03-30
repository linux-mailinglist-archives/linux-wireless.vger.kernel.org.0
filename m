Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 041F81978A3
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2020 12:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbgC3KQU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Mar 2020 06:16:20 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:50124 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728609AbgC3KQT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Mar 2020 06:16:19 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585563379; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=dQ1l+GSDnoNwDcUL5xl5hNd2b9ut5PAeUZvxWUY9fYw=; b=EC9tfeYCRrhyfDa//2v4hT622e/eu+QMO5DO7JJwCVzIdN/9CwnCkpBqG5qfsi8D71COAIDg
 wS+LJsiZWtXxZfjw1GG8NgKeQCtpDLxqdzV048QYymy5olAP3M/yel+v0/O3esK9U70x3sII
 1yvmEQDfPeQIKiaaMenn+IdN3hg=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e81c6f2.7f961592a030-smtp-out-n05;
 Mon, 30 Mar 2020 10:16:18 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8E885C44788; Mon, 30 Mar 2020 10:16:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 088BFC433F2;
        Mon, 30 Mar 2020 10:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 088BFC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        "open list\:TI WILINK WIRELES..." <linux-wireless@vger.kernel.org>,
        "open list\:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        brcm80211-dev-list@cypress.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>
Subject: Re: [PATCH] brcmfmac: fix wrong location to get firmware feature
References: <CGME20200330052521epcas1p1eedc926d4b11513f8502cf0c90ecf433@epcas1p1.samsung.com>
        <20200330052528.10503-1-jh80.chung@samsung.com>
        <CAHp75Vey9VUSAT6j6NTSXqNUK1vwSqY=aSx3-WPoXgxCK33SDg@mail.gmail.com>
Date:   Mon, 30 Mar 2020 13:16:12 +0300
In-Reply-To: <CAHp75Vey9VUSAT6j6NTSXqNUK1vwSqY=aSx3-WPoXgxCK33SDg@mail.gmail.com>
        (Andy Shevchenko's message of "Mon, 30 Mar 2020 12:08:27 +0300")
Message-ID: <87r1xaf8r7.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Andy Shevchenko <andy.shevchenko@gmail.com> writes:

> On Mon, Mar 30, 2020 at 8:26 AM Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>
>> sup_wpa feature is getting after setting feature_disable flag.
>> If firmware is supported sup_wpa feature,  it's always enabled
>> regardless of feature_disable flag.
>>
>
>> Fixes: b8a64f0e96c2 ("brcmfmac: support 4-way handshake offloading for WPA/WPA2-PSK")
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>
> No blank line in between. (Dunno if you need to resend, just wait what
> maintainer says)

I can fix that during commit, no need to resend because of this.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
