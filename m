Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A1928BE2D
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Oct 2020 18:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403855AbgJLQlg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Oct 2020 12:41:36 -0400
Received: from z5.mailgun.us ([104.130.96.5]:64146 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403785AbgJLQlg (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Oct 2020 12:41:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602520896; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=4b6HjVPJx7bWlKGDMwRW4NablLyrW3oR4n+QdccdtWE=;
 b=Dk7uxLEjq8NLHmOYM5a204VjoPkgaWTZafeLjPEZMfEaX7KFGy54SE8f+HnC9jx/IUz9U2T8
 q4j6FxeHvXVlnlVPKSqHNr7UJW+9VQfXXYRvJzY2CeqOS2VwQRdjz1o5vuDDp/Ba8Z/8+Gkx
 jLCO5D8p5I9Abm6RsBILBmmrfDY=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5f848736a03b63d6734064a4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 12 Oct 2020 16:41:26
 GMT
Sender: pradeepc=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 23C18C433F1; Mon, 12 Oct 2020 16:41:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pradeepc)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DA9B7C433CB;
        Mon, 12 Oct 2020 16:41:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 12 Oct 2020 09:41:25 -0700
From:   Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH] mac80211: save he oper info in bss config for AP and mesh
In-Reply-To: <f6daeb86f2cf83f57785e08b86fecfdf6410de46.camel@sipsolutions.net>
References: <20200715030937.25290-1-pradeepc@codeaurora.org>
 (sfid-20200715_050947_264568_478AF07B)
 <f6daeb86f2cf83f57785e08b86fecfdf6410de46.camel@sipsolutions.net>
Message-ID: <561813d2d5a5268261c48e51a6ad90b9@codeaurora.org>
X-Sender: pradeepc@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


>> -u8 *ieee80211_ie_build_he_oper(u8 *pos, struct cfg80211_chan_def 
>> *chandef)
>> +u8 *ieee80211_ie_build_he_oper(u8 *pos, struct cfg80211_chan_def 
>> *chandef,
>> +			       struct ieee80211_sub_if_data *sdata)
>>  {
>>  	struct ieee80211_he_operation *he_oper;
>>  	struct ieee80211_he_6ghz_oper *he_6ghz_op;
>> @@ -3056,6 +3057,7 @@ u8 *ieee80211_ie_build_he_oper(u8 *pos, struct 
>> cfg80211_chan_def *chandef)
>>  	he_oper = (struct ieee80211_he_operation *)pos;
>>  	he_oper->he_oper_params = cpu_to_le32(he_oper_params);
>> 
>> +	sdata->vif.bss_conf.he_oper.params = he_oper_params;
> 
> I think these changes are inappropriate. This is a helper function to
> build something, not to store the data. Please change the callers
> instead.
> 
> johannes
Hi Johannes,

Sorry for late response..

Thanks for the review.. I have tried to address the review comments
provided and created new series @ 
https://patchwork.kernel.org/cover/11824871/

Thanks
Pradeep
