Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465963E556F
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Aug 2021 10:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238455AbhHJIcs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Aug 2021 04:32:48 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:18525 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238412AbhHJIcU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Aug 2021 04:32:20 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628584318; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=k8fAPXmJhs2qAvhPhJBwaZE1UtzhiWWsv7aTQpRafF8=;
 b=g3DRnJSDJFJLXvglu/UJwHrJ5QXXwWhnxjVR9ckmirZUpemWLVdX6AtLqtlKNZlfp/VhyLyo
 ZER+GAzeolDu7CuDwYnBKHKIKGVbaQGxQsnLxP2ZCngyacxQe/XGbqR1TXFmuvL5pkA7ZlhS
 bpiF3Qd/Dl1aqjBl+QfFj91yw/Q=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 6112396bb14e7e2ecbb0e484 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 10 Aug 2021 08:31:39
 GMT
Sender: mkenna=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E6A20C43149; Tue, 10 Aug 2021 08:31:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mkenna)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C64CEC43143;
        Tue, 10 Aug 2021 08:31:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 10 Aug 2021 14:01:37 +0530
From:   Maharaja Kennadyrajan <mkenna@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v4 1/3] nl80211: Add support for beacon tx mode
In-Reply-To: <f14e6e6b81978ace4580774981a7e032b4001182.camel@sipsolutions.net>
References: <1623164855-15910-1-git-send-email-mkenna@codeaurora.org>
 <1623164855-15910-2-git-send-email-mkenna@codeaurora.org>
 (sfid-20210608_171052_201356_8AEA5406)
 <f14e6e6b81978ace4580774981a7e032b4001182.camel@sipsolutions.net>
Message-ID: <65b594ccab0a30bfb5bc2122cbf73f20@codeaurora.org>
X-Sender: mkenna@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-06-23 16:46, Johannes Berg wrote:
> First, I'd like to see some input from other vendors - is this useful?
> 
> I have no objections to it and it comes with an in-kernel driver, so 
> I'm
> inclined to accept it, but maybe we should have other modes, etc.?
> 
> 
>> + * @NL80211_ATTR_BEACON_TX_MODE: used to configure the beacon tx mode 
>> as
>> + *      staggered mode = 1 or burst mode = 2 in %NL80211_CMD_START_AP 
>> or
>> + *      %NL80211_CMD_JOIN_MESH from user-space.
> 
[Maha]: will replace the hard-coded values with enum here.
> 
> This should refer to the enum, not the hard-coded constants.
>> 
>> +/**
>> + * enum nl80211_beacon_tx_mode - Beacon Tx Mode enum.
>> + *      Used to configure beacon staggered mode or beacon burst mode.
>> + */
>> +enum nl80211_beacon_tx_mode {
> 
> 
> That's missing kernel-doc, and you also don't specify what default
> means. Why is it even here?
> 
[Maha]: sure, I will add the same in the kernel-doc.
>> +	[NL80211_ATTR_BEACON_TX_MODE] = NLA_POLICY_RANGE(NLA_U32, 1,
> 2),
> 
> That really also needs to use the enum, not hard-coded constants...
[Maha]: will replace the hard-coded values with enum also here.
> 
> johannes
