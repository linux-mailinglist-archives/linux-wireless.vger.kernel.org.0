Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC25287ADC
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Oct 2020 19:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731938AbgJHRVc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Oct 2020 13:21:32 -0400
Received: from z5.mailgun.us ([104.130.96.5]:46104 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731937AbgJHRVc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Oct 2020 13:21:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602177691; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=T4CyNJKnG99VEej2e/7lHhrxFfBRsgUPqyoAlIl4Qa8=;
 b=r6Rd97WDW4IiLADouP4ljUhU8NyxtZZ5oJXUjRi1k6IZ/Cmtg5s5fQjKKUIOrlBV1EcxisNi
 RPZDBe9XZf/O1LT6yWTF0Qp0yBpo//bfPI6VGsPA4if7i1gMcF6qdx8gJAy7hrRczhfYCJZG
 0XJTgTbDIYHyTTkx5p2xgsy8RGE=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5f7f4a9b22a1856a12e7f4a4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 08 Oct 2020 17:21:31
 GMT
Sender: pradeepc=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 796A2C433F1; Thu,  8 Oct 2020 17:21:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pradeepc)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3AFF9C433CA;
        Thu,  8 Oct 2020 17:21:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 08 Oct 2020 10:21:30 -0700
From:   Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
To:     John Crispin <john@phrozen.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH V3 2/9] mac80211: add multiple bssid support to interface
 handling
In-Reply-To: <cc1fd0b5-d12f-0cdc-f918-b8f761b18c88@phrozen.org>
References: <20200812150050.2683396-1-john@phrozen.org>
 <20200812150050.2683396-3-john@phrozen.org>
 <6e914f17bc1fcd57bfb1a0d9f68fe4ad@codeaurora.org>
 <cc1fd0b5-d12f-0cdc-f918-b8f761b18c88@phrozen.org>
Message-ID: <54033ab6e1bcf7ecda314c3ec81f1736@codeaurora.org>
X-Sender: pradeepc@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-10-08 01:06, John Crispin wrote:
> On 08.10.20 02:33, Pradeep Kumar Chitrapu wrote:
>>> 
>>>  static int ieee80211_del_iface(struct wiphy *wiphy, struct 
>>> wireless_dev *wdev)
>>>  {
>>> +    struct ieee80211_sub_if_data *sdata;
>>> +    struct ieee80211_vif *child, *tmp;
>>> +
>>> +    sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
>>> +    if (sdata->vif.type == NL80211_IFTYPE_AP) {
>> Hi John, Observed a NULL ptr dereference error here..
>> 
>> Thanks
>> Pradeep
> 
> 
> how did you trigger it ?
> 
>     John
Hi

Deleted the interface and did rmmod and insmod of cfg80211/mac80211/ath 
modules.

[  883.565933] Unable to handle kernel NULL pointer dereference at 
virtual address 00000000
[  883.565970] pgd = b311c000
[  883.573357] [00000000] *pgd=00000000
[  883.579021] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
[  883.848257] task: bd1ac600 ti: b027a000 task.ti: b027a000
[  883.852904] PC is at ieee80211_del_iface+0x34/0x90 [mac80211]
[  883.858333] LR is at extack_doit+0x20/0x6c [compat]
[  884.092936] [<c751fbd8>] (ieee80211_del_iface [mac80211]) from 
[<7f56181c>] (extack_doit+0x20/0x6c [compat])
[  884.100991] [<7f56181c>] (extack_doit [compat]) from [<8076a340>] 
(genl_rcv_msg+0x27c/0x300)
[  884.110854] [<8076a340>] (genl_rcv_msg) from [<807696c0>] 
(netlink_rcv_skb+0x58/0xb4)

Thanks
Pradeep
