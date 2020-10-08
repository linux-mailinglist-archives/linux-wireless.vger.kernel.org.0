Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2747287070
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Oct 2020 10:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgJHIG5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Oct 2020 04:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728395AbgJHIG4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Oct 2020 04:06:56 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C1CC061755
        for <linux-wireless@vger.kernel.org>; Thu,  8 Oct 2020 01:06:56 -0700 (PDT)
Received: from [2a04:4540:1402:c000:3d28:eae8:c654:ef6]
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1kQQws-0005z9-OG; Thu, 08 Oct 2020 10:06:50 +0200
Subject: Re: [PATCH V3 2/9] mac80211: add multiple bssid support to interface
 handling
To:     Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-wireless-owner@vger.kernel.org
References: <20200812150050.2683396-1-john@phrozen.org>
 <20200812150050.2683396-3-john@phrozen.org>
 <6e914f17bc1fcd57bfb1a0d9f68fe4ad@codeaurora.org>
From:   John Crispin <john@phrozen.org>
Message-ID: <cc1fd0b5-d12f-0cdc-f918-b8f761b18c88@phrozen.org>
Date:   Thu, 8 Oct 2020 10:06:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6e914f17bc1fcd57bfb1a0d9f68fe4ad@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 08.10.20 02:33, Pradeep Kumar Chitrapu wrote:
>>
>>  static int ieee80211_del_iface(struct wiphy *wiphy, struct 
>> wireless_dev *wdev)
>>  {
>> +    struct ieee80211_sub_if_data *sdata;
>> +    struct ieee80211_vif *child, *tmp;
>> +
>> +    sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
>> +    if (sdata->vif.type == NL80211_IFTYPE_AP) {
> Hi John, Observed a NULL ptr dereference error here..
>
> Thanks
> Pradeep


how did you trigger it ?

     John

