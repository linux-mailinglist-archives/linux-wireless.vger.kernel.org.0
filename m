Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8F32497C2
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Aug 2020 09:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgHSHxI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Aug 2020 03:53:08 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:19805 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726187AbgHSHxH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Aug 2020 03:53:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597823587; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=RrVpEphjVTEqwF6oHShBBsJrviA1GX40o4k/iUO63WM=;
 b=OLfrz5zti241hUvgLjiZbl21wQRip0QFNbuNr7UYoFEShLFuKRomXxOayT0tkZtierQ3itcK
 2rgsSctGItOVVn4+wRw57r5yLF5pHTs1WeGuUK85aEYWEDYjqAystRasm+4GRpxS+GirZA4w
 tXUdHTqcpVh2jDCfgMPTTbYQufc=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-west-2.postgun.com with SMTP id
 5f3cda601e4d3989d45f05b0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 19 Aug 2020 07:53:04
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6E395C433CA; Wed, 19 Aug 2020 07:53:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: seevalam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 34FEEC433C6;
        Wed, 19 Aug 2020 07:53:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 19 Aug 2020 13:23:03 +0530
From:   Seevalamuthu Mariappan <seevalam@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] mac80211: send only vlan group traffics in 80211 xmit
 path
In-Reply-To: <4abebda6ee90ce59b9dc5121b07d1954841351c7.camel@sipsolutions.net>
References: <1597819527-31887-1-git-send-email-seevalam@codeaurora.org>
 <4abebda6ee90ce59b9dc5121b07d1954841351c7.camel@sipsolutions.net>
Message-ID: <94f16e76ca54dc175a756a51a4907a1c@codeaurora.org>
X-Sender: seevalam@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

On 2020-08-19 12:24, Johannes Berg wrote:
> On Wed, 2020-08-19 at 12:15 +0530, Seevalamuthu Mariappan wrote:
>> AP-VLAN multicast/broadcast packets are expected to be encrypted
>> in software.
> 
> Err. Expected by whom?

Not an expectation exactly. As of now, AP-VLAN multicast/broadcast 
packets are encrypted in mac80211 itself. So these packets needs to go 
through 80211_xmit path. This change is just to redirect the other 
packets (unicast) to 802.3 xmit path if hw encap is enabled on AP 
interface.
> 
>> Those packets should follow 802.11 xmit path.
> 
> You should explain why ...
> 
>> -void __ieee80211_subif_start_xmit(struct sk_buff *skb,
>> -				  struct net_device *dev,
>> -				  u32 info_flags,
>> -				  u32 ctrl_flags,
>> -				  u64 *cookie)
> 
> There's no way I can review this if you move the whole function while
> making a small change to it ...

Will split into two patches, one having function movement and another 
patch having the actual change.
> 
> johannes


Thanks,
Seevalamuthu M
