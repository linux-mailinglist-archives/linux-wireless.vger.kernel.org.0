Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8511AA19D
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2019 13:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732093AbfIELhP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Sep 2019 07:37:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60940 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731633AbfIELhP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Sep 2019 07:37:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E6B446115B; Thu,  5 Sep 2019 11:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567683434;
        bh=En7H/vjEfdCHenDTzylmtXEv8eSxVc80QkgW02+ubgw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Lj75MEpf9aLo/MVe56iZj+pBq2UEJgxQgW79/SjFSaB6DZSUlkvwV0UuZ6pwfHHzD
         53p244Br1hXJrbNLh5hwwt7h8UZIXiCSMlagfeV1zk5ZC3TFpWijTXBkExerrMaEQ8
         e3+Q4qzWNrhSBC1ZjOWW0lwi+VPhWUgxh1sbYHn4=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C7E34602EE;
        Thu,  5 Sep 2019 11:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567683433;
        bh=En7H/vjEfdCHenDTzylmtXEv8eSxVc80QkgW02+ubgw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ChhsYj4Vyft9WWdWnRFTxhovyfGx0bP0BuX5BCJTVS5DsYfx3EcD/u74vj9SDsS/s
         Kr5l2kcJc3wb6YhfgMmWZjFE0BPcTpnRAUBUgQFDI0K8i6rKAiaUVbtG/yuOi8ka1F
         Vm2oTw3oy3v8jLXGGHzc3LIJYAsCPaYFDJsyRMzI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C7E34602EE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        ath11k@lists.infradead.org
Subject: Re: [PATCH 08/49] ath11k: add core.c
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
        <1566316095-27507-9-git-send-email-kvalo@codeaurora.org>
        <0c526ce00e6e1c7731c990515e7438230efb55af.camel@sipsolutions.net>
Date:   Thu, 05 Sep 2019 14:37:09 +0300
In-Reply-To: <0c526ce00e6e1c7731c990515e7438230efb55af.camel@sipsolutions.net>
        (Johannes Berg's message of "Tue, 20 Aug 2019 22:32:45 +0200")
Message-ID: <874l1rnfdm.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

>> +module_param_named(debug_mask, ath11k_debug_mask, uint, 0644);
>> +
>> +MODULE_PARM_DESC(debug_mask, "Debugging mask");
>> +
>> +static const struct ath11k_hw_params ath11k_hw_params = {
>> +			.name = "ipq8074",
>
> indentation here seems a bit too much
>
>> +MODULE_LICENSE("Dual BSD/GPL");
>
> All your files state "ISC", shouldn't that be reflected here?

The MODULE_LICENSE() macro doesn't accept anything else. AFAIK all ISC
drivers use this.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
