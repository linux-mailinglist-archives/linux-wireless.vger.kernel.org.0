Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9080B23ABAA
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 19:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgHCR3I (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Aug 2020 13:29:08 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:34546 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726398AbgHCR3H (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Aug 2020 13:29:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596475747; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=0OosOyOReZIaB9lhBiQuqtf/Qc7eZX8uXFImePyi4FE=;
 b=reBzdnYPuTfiT8Mh6kuSompdz2jw1tG3ysMkjG+wL7wW4uBmWSZrnH78LKe1f9uujddaMCdc
 i08FF0HRNU9edYPxJvcEFMD7odwmefA+yoqfAO/d4fdKVzVwrUI2ZJZtY48A5vOuLU4bWm/n
 h0eqereYgEw6bV+8Wnnqo2VmPHA=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f284954eecfc978d3c68f94 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 03 Aug 2020 17:28:52
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2BF25C433C9; Mon,  3 Aug 2020 17:28:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EE637C433C6;
        Mon,  3 Aug 2020 17:28:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 03 Aug 2020 10:28:48 -0700
From:   Aloka Dixit <alokad@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v3 1/2] nl80211: Unsolicited broadcast probe response
 support
In-Reply-To: <b8455091e9ab4c0c3690dc3fadd000f1d1ca9165.camel@sipsolutions.net>
References: <20200715230514.26792-1-alokad@codeaurora.org>
 <20200715230514.26792-2-alokad@codeaurora.org>
 <b8455091e9ab4c0c3690dc3fadd000f1d1ca9165.camel@sipsolutions.net>
Message-ID: <4c07745c1fd5c6e19a9b01488ca9e92a@codeaurora.org>
X-Sender: alokad@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-08-03 03:18, Johannes Berg wrote:
>> +/**
>> + * enum nl80211_unsol_bcast_probe_resp_attributes - Unsolicited 
>> broadcast probe
>> + *	response configuration. Applicable only in 6GHz.
>> + *
>> + * @__NL80211_UNSOL_BCAST_PROBE_RESP_INVALID: Invalid
>> + *
>> + * @NL80211_UNSOL_BCAST_PROBE_RESP_INT: Maximum packet interval (u32, 
>> TU).
>> + *	Allowed range: 0..20 (TU = Time Unit). IEEE P802.11ax/D6.0
>> + *	26.17.2.3.2 (AP behavior for fast passive scanning.
> 
> nit: that "(" never closes
> 
>> +	tmpl = tb[NL80211_UNSOL_BCAST_PROBE_RESP_TMPL];
>> +	if (tmpl) {
>> +		presp->tmpl = nla_data(tmpl);
>> +		presp->tmpl_len = nla_len(tmpl);
>> +	}
>> 
> So, hmm. Similar question here - what do you do without a template? Or
> OTOH, why do you even need a template? Would you advertise something
> that's *different* from the regular probe response template you already
> get for offloaded probe request/response support?
> 

The template will be same as the probe response, except for the 
destination MAC address as this one is broadcast.
Main reason is that this unsolicited broadcast probe response 
transmission is specific to 6GHz and not applicable to lower bands. 
Having a separate netlink command allowed not messing with the existing 
probe response offload feature which is for all bands. Thanks.

> johannes
