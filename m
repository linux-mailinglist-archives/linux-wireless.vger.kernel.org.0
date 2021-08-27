Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881923F923C
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Aug 2021 04:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244038AbhH0CMm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 22:12:42 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:42784 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbhH0CMl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 22:12:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630030313; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=fISNtX8wZGZ+2uDcr9S040FeGsG7DbFo4sejr04LNQ0=;
 b=ACbiuEoJxXt5O7DlRGK2urUDj7m4ubAYndDFn9pIu9y1qDM9nIxeLRkZzSpqzcQ8NnDKAGJm
 XJxcUlt/L+8PH7qdg1c99DVjZjt9v8alprlwFcj7UqKWkYCBZf571QtMox3RsDWqNLDxx99m
 Sy+4qGxz2CTfCcStltDABp0+Mhc=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 612849de825e13c54a10ea46 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 27 Aug 2021 02:11:42
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 79047C43617; Fri, 27 Aug 2021 02:11:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 104A3C4338F;
        Fri, 27 Aug 2021 02:11:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 27 Aug 2021 10:11:40 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 8/8] mac80211: save transmit power envelope element and
 power constraint
In-Reply-To: <dfe27f657b4615369cf751d394f5cba75f5fdcc1.camel@sipsolutions.net>
References: <20210820122041.12157-1-wgong@codeaurora.org>
 <20210820122041.12157-9-wgong@codeaurora.org>
 <dfe27f657b4615369cf751d394f5cba75f5fdcc1.camel@sipsolutions.net>
Message-ID: <25fcede26b99604a03d0b321b7120db4@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-08-26 16:29, Johannes Berg wrote:
...
> 
>> +		if (is_6ghz) {
>> +			struct ieee802_11_elems elems;
> 
> This is pretty big, not sure we want it on the stack (causes warnings
> for me in build). Also, if we're doing this anyway, then we can change
> the code above (perhaps as a separate patch) to not do
> cfg80211_find_ext_ie() but rather take it out of the parsed.
do you mean NOT use cfg80211_find_ext_ie()/cfg80211_find_ie() and still 
use "struct ieee802_11_elems elems" here and
move this code to a separate function/patch?
it has more than one tx_pwr_env in one beacon, if we use 
cfg80211_find_ext_ie()/cfg80211_find_ie(),
it need add more logic.
> 
...
> 
> johannes
