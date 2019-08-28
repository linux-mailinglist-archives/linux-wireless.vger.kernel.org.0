Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45338A0ABC
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2019 21:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfH1Twg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Aug 2019 15:52:36 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:45136 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfH1Twf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Aug 2019 15:52:35 -0400
Received: from marcel-macbook.fritz.box (p4FEFC580.dip0.t-ipconnect.de [79.239.197.128])
        by mail.holtmann.org (Postfix) with ESMTPSA id 55F80CECA3;
        Wed, 28 Aug 2019 22:01:19 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2] cfg80211: add local BSS receive time to survey
 information
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <18c4232675c7b4f13fbfe9e5d8e9364a0908f316.camel@sipsolutions.net>
Date:   Wed, 28 Aug 2019 21:52:33 +0200
Cc:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <F29BC537-AED5-4BFA-915F-ED8E749124FC@holtmann.org>
References: <20190828102042.58016-1-nbd@nbd.name>
 <9189B2C1-6E5B-4457-9354-A010F946EE33@holtmann.org>
 <18c4232675c7b4f13fbfe9e5d8e9364a0908f316.camel@sipsolutions.net>
To:     Johannes Berg <johannes@sipsolutions.net>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

>> ... [snip]
> 
> Please trim quotes a bit.
> 
>>> 	NL80211_SURVEY_INFO_PAD,
>>> +	NL80211_SURVEY_INFO_TIME_BSS_RX,
>> 
>> wouldn’t this go before the PAD attribute?
> 
> No, as usual, that would break ABI. PAD is a regular attribute, just
> empty and ignored for aligning 64-bit values.

then I do not grok on how the nla_put_u64_64bit works, but that is fine.

I assumed these are similar to the NL80211_SURVEY_INFO_MAX which we also always move, but also not expected to be part of the API as a fixed value.

Regards

Marcel

