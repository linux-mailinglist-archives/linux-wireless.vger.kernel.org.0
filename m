Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2110888B67
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2019 14:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbfHJMkS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 10 Aug 2019 08:40:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37418 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfHJMkS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 10 Aug 2019 08:40:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B8C6F602ED; Sat, 10 Aug 2019 12:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565440817;
        bh=bq2a9ifN2qcimVadgjGb2ULkBUInwogFiCmBKE8khQQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V4Vh8mrCDGwy09RRcOqjVRWZs9sQgrLXElgE24Ww422K+rE0Gi4j5VMPoPMQv+CgH
         uQ8kjQOyUB8CssLXM99IwrniwjsqXONvPweTCbFLOB2XN3tNdBvFP/Ujw74fdpOZmN
         OtRxvw/aW/I/lATlo7HIaIe5Ej6dtF64NoWNnbBg=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 38BB1602ED;
        Sat, 10 Aug 2019 12:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565440817;
        bh=bq2a9ifN2qcimVadgjGb2ULkBUInwogFiCmBKE8khQQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V4Vh8mrCDGwy09RRcOqjVRWZs9sQgrLXElgE24Ww422K+rE0Gi4j5VMPoPMQv+CgH
         uQ8kjQOyUB8CssLXM99IwrniwjsqXONvPweTCbFLOB2XN3tNdBvFP/Ujw74fdpOZmN
         OtRxvw/aW/I/lATlo7HIaIe5Ej6dtF64NoWNnbBg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 10 Aug 2019 18:10:17 +0530
From:   Tamizh chelvam <tamizhr@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCHv6 1/9] nl80211: New netlink command for TID specific
 configuration
In-Reply-To: <ea1f9969b52fed2da8b0e88ed8b06527bfc272aa.camel@sipsolutions.net>
References: <1560835632-17405-1-git-send-email-tamizhr@codeaurora.org>
 <1560835632-17405-2-git-send-email-tamizhr@codeaurora.org>
 <ea1f9969b52fed2da8b0e88ed8b06527bfc272aa.camel@sipsolutions.net>
Message-ID: <be096df17632b1a71441a23a373682bf@codeaurora.org>
X-Sender: tamizhr@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-07-31 14:55, Johannes Berg wrote:
> On Tue, 2019-06-18 at 10:57 +0530, Tamizh chelvam wrote:
>> 
>>  /**
>> + * enum nl80211_tid_config - TID config state
>> + * @NL80211_TID_CONFIG_DEFAULT: Default config for the TID
>> + * @NL80211_TID_CONFIG_ENABLE: Enable config for the TID
>> + * NL80211_TID_CONFIG_DISABLE: Disable config for the TID
>> + */
>> +enum nl80211_tid_config {
>> +	NL80211_TID_CONFIG_DEFAULT,
>> +	NL80211_TID_CONFIG_ENABLE,
>> +	NL80211_TID_CONFIG_DISABLE,
>> +};
> 
> Hmm. Looking at this in more detail in patch 3, I don't understand.
> 
> How is DEFAULT different from "attribute not present", i.e. "no
> changes"?
> 
This DEFAULT is used to notify the driver to use default configuration 
value of driver/vif.
This will be used when the attribute is not present.
