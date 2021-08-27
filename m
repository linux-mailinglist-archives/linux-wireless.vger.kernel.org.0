Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 525783F961D
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Aug 2021 10:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244583AbhH0IaF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Aug 2021 04:30:05 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:47328 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244572AbhH0IaE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Aug 2021 04:30:04 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630052955; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=KSnANkxkmR2WEQ3ZPEcdEYDljKk8xJccrXlBzDwykF8=;
 b=mFQf3XF4ZCRAMEYNvs7AZSetHi3LdAqz4qL21BFQkdJiAaDpEgc1jI5ttEr21ccYXHsT2nLK
 1H/j9nPamp87Gq4WmsHxuZjTn+hDoDDSaEwkKAMkzFeAMaacaAXL1Q5OkF6SKOsyWejN/FGP
 +8qgQqrjQ2OP9ffvGcPsMaBCFQc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 6128a24dd6653df767f01258 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 27 Aug 2021 08:29:01
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 643CCC4360C; Fri, 27 Aug 2021 08:29:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EF6B8C4338F;
        Fri, 27 Aug 2021 08:28:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 27 Aug 2021 16:28:59 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 8/8] mac80211: save transmit power envelope element and
 power constraint
In-Reply-To: <3483aeb87a81dea538af3a2640cd49831274320f.camel@sipsolutions.net>
References: <20210820122041.12157-1-wgong@codeaurora.org>
 <20210820122041.12157-9-wgong@codeaurora.org>
 <dfe27f657b4615369cf751d394f5cba75f5fdcc1.camel@sipsolutions.net>
 <25fcede26b99604a03d0b321b7120db4@codeaurora.org>
 <48ad47869e703cbef437378c508d6a5b64c160ae.camel@sipsolutions.net>
 <db22a4cb9a07e3845a50f436c7052feb@codeaurora.org>
 <0680b508a7864e02f55d763851f7460baa73b53f.camel@sipsolutions.net>
 <110489059796b17849d0f32fb5189828@codeaurora.org>
 <27680423e824dd67217cc6f1e62f9ac0a1af78f2.camel@sipsolutions.net>
 <01d9e4eadbb0d87edbc026fc719858a3@codeaurora.org>
 <3483aeb87a81dea538af3a2640cd49831274320f.camel@sipsolutions.net>
Message-ID: <40e8c88cec2d3601afbfe187c57fac6b@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-08-27 16:20, Johannes Berg wrote:
> On Fri, 2021-08-27 at 16:18 +0800, Wen Gong wrote:
>> 
>> then should I use "struct ieee802_11_elems elems = {0}" or "struct
>> ieee802_11_elems *elems = kzalloc(sizeof(*elems))"
>> in the parsing patch?
> 
> Yeah, it's a good question ...
> 
> We keep adding stuff here, so it'll be safer to alloc it.
> 
> I get a fair number of stack size warnings on the build now (possibly
> due to the addition of the TPE fields?), and while they're probably 
> fine
> for now (we get there from nl80211, so no deep stack), it's only going
> to increase - we have EHT patches already now, for example.
> 

the TPE is only 8 pointer in the struct ieee802_11_elems.
so stack size warnings should not caused by TPE.

#define IEEE80211_TPE_MAX_IE_COUNT	8
const struct ieee80211_tx_pwr_env 
*tx_pwr_env[IEEE80211_TPE_MAX_IE_COUNT];

> johannes
