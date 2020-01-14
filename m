Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29E6A13AB3E
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2020 14:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgANNnw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Jan 2020 08:43:52 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:17560 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725904AbgANNnv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Jan 2020 08:43:51 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579009431; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=grv067apNIcUdGejucgF9bWSVoDiljz0jVxYhGB3g5c=; b=oXIs0DFPTsMV5jM4PNZijRfmGycZb7dz9ht9F9vqLMPy6XQL3UEUsjjLWpzcmMGqg67kjNNU
 mgXYE7azefxSeCYcj7NwDDrWpa9325tNCLoeY1YOPqKHp+ZgMiJWwGh8EdApTGefmXoXSLLV
 8mCdf1i2qdteC66IF31bWlnEg5k=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e1dc593.7fd7a435b500-smtp-out-n02;
 Tue, 14 Jan 2020 13:43:47 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B23A4C4479C; Tue, 14 Jan 2020 13:43:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (85-76-19-103-nat.elisa-mobile.fi [85.76.19.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D95ECC43383;
        Tue, 14 Jan 2020 13:43:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D95ECC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Nicolai Stange <nstange@suse.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Wen Huang <huangwenabc@gmail.com>,
        libertas-dev@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.de>, Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 1/2] libertas: don't exit from lbs_ibss_join_existing() with RCU read lock held
References: <87woa04t2v.fsf@suse.de> <20200114103903.2336-1-nstange@suse.de>
        <20200114103903.2336-2-nstange@suse.de>
Date:   Tue, 14 Jan 2020 15:43:42 +0200
In-Reply-To: <20200114103903.2336-2-nstange@suse.de> (Nicolai Stange's message
        of "Tue, 14 Jan 2020 11:39:02 +0100")
Message-ID: <87o8v6qhkh.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Nicolai Stange <nstange@suse.de> writes:

> Commit e5e884b42639 ("libertas: Fix two buffer overflows at parsing bss
> descriptor") introduced a bounds check on the number of supplied rates to
> lbs_ibss_join_existing().
>
> Unfortunately, it introduced a return path from within a RCU read side
> critical section without a corresponding rcu_read_unlock(). Fix this.
>
> Fixes: e5e884b42639 ("libertas: Fix two buffer overflows at parsing bss
>                       descriptor")

This should be in one line, I'll fix it during commit.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
