Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D37323ABAC
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 19:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgHCRbR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Aug 2020 13:31:17 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:38444 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726398AbgHCRbR (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Aug 2020 13:31:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596475877; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=JLTrPofgpKNRGi4suxW7LkDisdqOjfpt0aeFyUdoBMM=;
 b=CcwTmqacYbPKg77VWESVWqdlk6/DVwAEELYthkPvWDAP8Tu9Zu833psIFUCyi7WVR99VOmjd
 eTqCtCEGEEDFve6B/Tt1egBn73QLwXwBhKXYxxl2qMK2rFvYqrK0EoTYgyw73PctMucNmX3q
 rNNCgxjLz1QIRUcLc/0AdvLeBjc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f2849d2f89b692ba25c817b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 03 Aug 2020 17:30:58
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 39D48C433CA; Mon,  3 Aug 2020 17:30:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C2704C433C6;
        Mon,  3 Aug 2020 17:30:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 03 Aug 2020 10:30:55 -0700
From:   Aloka Dixit <alokad@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH v3 1/2] nl80211: Unsolicited broadcast probe response
 support
In-Reply-To: <6f23e2ac081a3960959f00dedcdf8795aef28a14.camel@sipsolutions.net>
References: <20200715230514.26792-1-alokad@codeaurora.org>
 <20200715230514.26792-2-alokad@codeaurora.org>
 <6f23e2ac081a3960959f00dedcdf8795aef28a14.camel@sipsolutions.net>
Message-ID: <1aca682f4b694c5ea3d1c57291e6c196@codeaurora.org>
X-Sender: alokad@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-08-03 03:20, Johannes Berg wrote:
> Also,
> 
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
> 
> 0 doesn't make sense, you should disallow that.
> 
> I see you used it for "turn off" at least in the mac80211 patch but it
> seems to me that should have a more explicit way at least in the
> external API? At the very least it needs to documentation.
> 
> johannes


Hi Johannes, interval=0 means 'disable' is given in the specification, 
will extend the documentation to mention that.
