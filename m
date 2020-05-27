Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C301E492F
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2020 18:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389345AbgE0QDt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 May 2020 12:03:49 -0400
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:58637 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390044AbgE0QDp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 May 2020 12:03:45 -0400
Received: from [192.168.178.40] (unknown [87.147.49.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 81BB6580063;
        Wed, 27 May 2020 18:03:43 +0200 (CEST)
Subject: Re: [PATCH v2] nl80211: add control port tx status method
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
References: <20200527143653.3197-1-markus.theil@tu-ilmenau.de>
 <01ba6a6602e150b756fac8da1673cca34984c5d3.camel@sipsolutions.net>
From:   Markus Theil <markus.theil@tu-ilmenau.de>
Message-ID: <0f400886-9f09-3646-d068-fc7798db3ff6@tu-ilmenau.de>
Date:   Wed, 27 May 2020 18:03:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <01ba6a6602e150b756fac8da1673cca34984c5d3.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 5/27/20 4:47 PM, Johannes Berg wrote:
> On Wed, 2020-05-27 at 16:36 +0200, Markus Theil wrote:
>> This patch adds the actual code for returning the tx status of control
>> port frames sent over nl80211.
>>
>> NL80211_CMD_CONTROL_PORT_FRAME_TX_STATUS is a new command which is used
>> when returning the tx status. Its availability can be queried by checking
>> against NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_TX_STATUS.
>>
>> The ctrl port tx status over nl80211 path re-uses some code from the path
>> for advertising the tx status over socket control messages, when
>> SKBTX_WIFI_STATUS is set.
>>
>> The tx status can be used in a similar fashion as the mgmt tx status
>> already allows for. A cookie is included extended ack data of
>> NL80211_CMD_CONTROL_PORT_FRAME, which can be matched against the cookie
>> in NL80211_CMD_CONTROL_PORT_FRAME_TX_STATUS. The frame content is also
>> included, as for example hostapd currently uses it to match request and
>> reply.
> Looks good on a cursory review, but you forgot to set the feature flag?
Oh, I indeed forgot the flag.
> johannes
>
