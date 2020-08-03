Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C65823ABB9
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 19:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgHCRfi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Aug 2020 13:35:38 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:34688 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726398AbgHCRfi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Aug 2020 13:35:38 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596476137; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=xqsdB8SA2TcLoS7K4Z6j0L9XeBhxnUOyglQeVSMb09g=;
 b=hM39Q9fjK1joQr/sN8jd9aeaJAzPdQiYF7S3GvusM79Aq0pNKZcC93zO4R1woIJtKdJkYS6L
 mhkh2+ETzmuvtE9FhSDDsI3AZVv4miJx+UskVr6X5ptUlIgokfu/qQMQKOUSN7PZJx2x+1nv
 3fKLgluotAqeKHqqCBcU2YohExU=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f284a7be7a13aa204690340 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 03 Aug 2020 17:33:47
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EB305C433CB; Mon,  3 Aug 2020 17:33:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED autolearn=ham
        autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 49249C433C6;
        Mon,  3 Aug 2020 17:33:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 03 Aug 2020 10:33:45 -0700
From:   Aloka Dixit <alokad@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v3 1/2] nl80211: Unsolicited broadcast probe response
 support
In-Reply-To: <df36ecfb6fd72531727a0322f060a57761985294.camel@sipsolutions.net>
References: <20200715230514.26792-1-alokad@codeaurora.org>
 <20200715230514.26792-2-alokad@codeaurora.org>
 <df36ecfb6fd72531727a0322f060a57761985294.camel@sipsolutions.net>
Message-ID: <352e032b1b9086df89aa8ba862c5a91f@codeaurora.org>
X-Sender: alokad@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-08-03 03:20, Johannes Berg wrote:
> On Wed, 2020-07-15 at 16:05 -0700, Aloka Dixit wrote:
>> This patch adds new attributes to support unsolicited broadcast
>> probe response transmission used for in-band
>> discovery in 6GHz band (IEEE P802.11ax/D6.0 26.17.2.3.2, AP behavior 
>> for
>> fast passive scanning).
>> The new attribute, NL80211_ATTR_UNSOL_BCAST_PROBE_RESP, is nested 
>> which
>> supports following parameters:
>> (1) NL80211_UNSOL_BCAST_PROBE_RESP_INT - Packet interval
>> (2) NL80211_UNSOL_BCAST_PROBE_RESP_TMPL - Template data
> 
> And maybe some driver support flag is needed?
> 
> johannes

Are you referring to enable/disable flag separate from the interval 
field being used for that? Or a different command/event from driver to 
netlink advertising if the driver supports this feature?

If former, it isn't needed because interval=0 means disable.

Thanks.
