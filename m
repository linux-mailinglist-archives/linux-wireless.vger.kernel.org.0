Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4F9293FA0
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Oct 2020 17:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408801AbgJTPez (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Oct 2020 11:34:55 -0400
Received: from z5.mailgun.us ([104.130.96.5]:43290 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408799AbgJTPez (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Oct 2020 11:34:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603208094; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=1luZM3cMtEycgqT5yFsLXY41KqfmOveEa6BJNuB26O0=;
 b=PJqm/jQqNx6AVM7+gb3aFfgTpSPfNo892uzEPjJbhOHrrEuA4QUhbYbj2B48oGUbaJy+p3yp
 xt0QLvkBQ6fm1vQakWdEGFsMNZB+jeRIriHF/W683i4Rm966ubwJpWCUya2vM8Ez5igd6gcK
 yGFqwcHpGjVZ+tkZTZKyk7j2qHQ=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f8f039d319d4e9cb50b5150 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 20 Oct 2020 15:34:53
 GMT
Sender: pradeepc=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 02F8DC433FE; Tue, 20 Oct 2020 15:34:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pradeepc)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9AC81C433F1;
        Tue, 20 Oct 2020 15:34:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 20 Oct 2020 08:34:52 -0700
From:   Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
To:     Peter Oh <peter.oh@eero.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/4] mac80211: save HE oper info in BSS config for mesh
In-Reply-To: <cc254230-5909-b77a-8c13-2c769a618660@eero.com>
References: <20201009021811.18584-1-pradeepc@codeaurora.org>
 <20201009021811.18584-2-pradeepc@codeaurora.org>
 <cc254230-5909-b77a-8c13-2c769a618660@eero.com>
Message-ID: <a08d1aae3c4359f736f25053c3075afd@codeaurora.org>
X-Sender: pradeepc@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


>> +	if (ieee80211_get_he_iftype_cap(sband, NL80211_IFTYPE_MESH_POINT) &&
>> +	    !(sdata->vif.bss_conf.chandef.width == 
>> NL80211_CHAN_WIDTH_20_NOHT ||
>> +	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_5 ||
>> +	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_10))
>> +		return;
> 
> Are you update BSS only for sub-20Mhz?
> 
> Shouldn't you remove "!" for 20~160Mhz?
> 
> 
> Thanks,
> 
> Peter
Thanks Peter for the review..Might have been a typo and I missed it..
I will fix this and submit next revision.
