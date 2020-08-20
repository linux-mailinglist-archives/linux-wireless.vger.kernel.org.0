Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9BDE24B44E
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Aug 2020 12:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729483AbgHTKDK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Aug 2020 06:03:10 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:35827 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730500AbgHTKCJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Aug 2020 06:02:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597917729; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=j7z1kb32SK0mpk3/cWjJZ/zdgqTe0+1ye7jE1RxyRZM=;
 b=lT5Xq9iP25HVkWojVy8eqLWTPUgWPARKXOgtHFcMgZBofFMhjkwiL/Dg+XMHn7PruYrrr86S
 IftOUvPH5wuk1/sw5FB0IAf1XIaUU9yjQlXc6iJwOKyPotQiUI2k8PSuVr39KF6uhUVQkz9t
 ZD2H+lAFWcvEwWigldst0RXwwNk=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5f3e4a20e8bbfbec10288f06 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 20 Aug 2020 10:02:08
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8ECA0C433CB; Thu, 20 Aug 2020 10:02:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tamizhr)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F197FC433CA;
        Thu, 20 Aug 2020 10:02:07 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 20 Aug 2020 15:32:07 +0530
From:   Tamizh Chelvam <tamizhr@codeaurora.org>
To:     Sergey Matyukevich <geomatsi@gmail.com>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] iw: add TID specific Tx bitrate configuration
In-Reply-To: <20200820074926.GA2255@curiosity>
References: <1597903916-8674-1-git-send-email-tamizhr@codeaurora.org>
 <20200820074926.GA2255@curiosity>
Message-ID: <e317da67206d1bfddbc335cdc22f7e0c@codeaurora.org>
X-Sender: tamizhr@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Sergey,

> 
>> Add TID specific Tx bitrate configuration by using
>> handle_bitrates already APIs.
>> 
>> Examples:
>> 	$ iw dev wlan0 peer xx:xx:xx:xx:xx:xx tids 0x2 bitrates auto
>> 	$ iw dev wlan0 peer xx:xx:xx:xx:xx:xx tids 0x2 bitrates limit 
>> vht-mcs-5 4:9
>> 
>> Signed-off-by: Tamizh Chelvam <tamizhr@codeaurora.org>
>> ---
>>  bitrate.c   | 27 ++++++++++++++++++++-------
>>  interface.c | 34 +++++++++++++++++++++++++++++++++-
>>  iw.h        |  3 +++
>>  3 files changed, 56 insertions(+), 8 deletions(-)
> 
> ...
> 
>>  COMMAND(set, tidconf, "[peer <MAC address>] tids <mask> [override] 
>> [sretry <num>] [lretry <num>] "
>> -	"[ampdu [on|off]] [amsdu [on|off]] [noack [on|off]] [rtscts 
>> [on|off]]",
>> +	"[ampdu [on|off]] [amsdu [on|off]] [noack [on|off]] [rtscts 
>> [on|off]]"
>> +	"[bitrates <type [auto|fixed|limit]> [legacy-<2.4|5> <legacy rate in 
>> Mbps>*] [ht-mcs-<2.4|5> <MCS index>*]"
>> +	" [vht-mcs-<2.4|5> <NSS:MCSx,MCSy... | NSS:MCSx-MCSy>*] 
>> [sgi-2.4|lgi-2.4] [sgi-5|lgi-5]]",
>>  	NL80211_CMD_SET_TID_CONFIG, 0, CIB_NETDEV, handle_tid_config,
>>  	"Setup per-node TID specific configuration for TIDs selected by 
>> bitmask.\n"
>>  	"If MAC address is not specified, then supplied TID configuration\n"
>> @@ -955,4 +985,6 @@ COMMAND(set, tidconf, "[peer <MAC address>] tids 
>> <mask> [override] [sretry <num>
>>  	"  $ iw dev wlan0 tids 0x5 ampdu off amsdu off rtscts on\n"
>>  	"  $ iw dev wlan0 tids 0x3 override ampdu on noack on rtscts on\n"
>>  	"  $ iw dev wlan0 peer xx:xx:xx:xx:xx:xx tids 0x1 ampdu off tids 0x3 
>> amsdu off rtscts on\n"
>> +	"  $ iw dev wlan0 peer xx:xx:xx:xx:xx:xx tids 0x2 bitrates auto\n"
>> +	"  $ iw dev wlan0 peer xx:xx:xx:xx:xx:xx tids 0x2 bitrates limit 
>> vht-mcs-5 4:9\n"
> 
> It just occured to me that I wrote incorrect help message in the patch
> adding tidconf command. IIRC the correct usage should be:
> 
> $ iw dev wlan0 set tidconf peer 1:2:3:4:5:6 tids 0x3 ampdu off tids
> 0x2 sretry 10 lretry 100
> $ iw dev wlan0 set tidconf tids 0xff ampdu off amsdu off sretry 10
> lretry 100 noack off
> 
> Could you please update new help entries and fix the existing ones ?
> 
Sure, will send as separate patch along with fixing new entries in this 
patch.


Tamizh.
