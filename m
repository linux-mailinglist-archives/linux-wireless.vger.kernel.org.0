Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50962AA2E3
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2019 14:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388719AbfIEMUG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Sep 2019 08:20:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38900 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731196AbfIEMUG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Sep 2019 08:20:06 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 801306115B; Thu,  5 Sep 2019 12:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567686004;
        bh=Y5jzBWaoxbHQwkqFZtjIhJ21JazMaO6JvYJZgDsm6lg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=OVV60cCO2ZRg7JJogWRR3NW9LWvoZ+FZV6ZZ2lRANckMZ8Vl8oCTGFKb5BEdUwq/c
         wesc+tbfoUmDvI/6Z3sv8Q6wF7YT9EQ9c8AZ0p3OtUp1gl44Jxf8rNsUYnpNOSI6BR
         cDlkdTbDB1a1QCXS5LEzvgXsH8wbmqpgr8NBiyVE=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B4B556058E;
        Thu,  5 Sep 2019 12:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567686003;
        bh=Y5jzBWaoxbHQwkqFZtjIhJ21JazMaO6JvYJZgDsm6lg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=eSpIoSIFBRk7oLCAtWWHHBv3owayzUA/WFRQypPQYsM6AhH/wCim24IK7rq+5AFgv
         E7D5Fw1h3JqI7pQMlRHZr65AJtVC0De6d/FLes4x/rHgcomV/qUjw/aRSZvo/+VXPJ
         pHBh7SJJ60cx2IT5lWi9X0EB68ZruuDNI7s5l1Fc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B4B556058E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@qti.qualcomm.com>
Cc:     Wen Gong <wgong@codeaurora.org>,
        "ath10k\@lists.infradead.org" <ath10k@lists.infradead.org>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v4 8/8] ath10k: enable napi on RX path for sdio
References: <1567416146-14403-1-git-send-email-wgong@codeaurora.org>
        <1567416146-14403-9-git-send-email-wgong@codeaurora.org>
        <c816734498c349119c12c23bc8a4827f@aptaiexm02f.ap.qualcomm.com>
Date:   Thu, 05 Sep 2019 15:19:59 +0300
In-Reply-To: <c816734498c349119c12c23bc8a4827f@aptaiexm02f.ap.qualcomm.com>
        (Wen Gong's message of "Thu, 5 Sep 2019 10:50:29 +0000")
Message-ID: <875zm7lyts.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@qti.qualcomm.com> writes:

>> -----Original Message-----
>> From: ath10k <ath10k-bounces@lists.infradead.org> On Behalf Of Wen Gong
>> Sent: Monday, September 2, 2019 5:22 PM
>> To: ath10k@lists.infradead.org
>> Cc: linux-wireless@vger.kernel.org
>> Subject: [EXT] [PATCH v4 8/8] ath10k: enable napi on RX path for sdio
>> 
> Patch v5 sent with change, https://patchwork.kernel.org/patch/11132677/

No need to reply to every patch in the series. It's enough to reply to
the cover letter that a new version was posted, less emails that way.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
