Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9A919B4FC
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Apr 2020 19:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732448AbgDAR6c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Apr 2020 13:58:32 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:42476 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730574AbgDAR6b (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Apr 2020 13:58:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 442E44F7A4D;
        Wed,  1 Apr 2020 17:58:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JkcP8Tz8C9LM; Wed,  1 Apr 2020 17:58:28 +0000 (UTC)
Received: from [10.1.15.6] (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 88A174F7A49;
        Wed,  1 Apr 2020 17:58:28 +0000 (UTC)
Subject: Re: [RFC 4/7] mac80211: add freq_offset to RX status
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <20200401062150.3324-1-thomas@adapt-ip.com>
 <20200401062150.3324-5-thomas@adapt-ip.com>
 <e824f5f31e1fd2559d8416ee1f17597cff21c693.camel@sipsolutions.net>
From:   Thomas Pedersen <thomas@adapt-ip.com>
Message-ID: <62c642d8-1372-6021-b362-3be8d8d22a4c@adapt-ip.com>
Date:   Wed, 1 Apr 2020 10:58:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <e824f5f31e1fd2559d8416ee1f17597cff21c693.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/1/20 12:08 AM, Johannes Berg wrote:
> On Tue, 2020-03-31 at 23:21 -0700, Thomas Pedersen wrote:
>> RX status needs a KHz component, so add freq_offset. We
>> can make ampdu_reference u16 since it is probably
>> sufficient to be able to distinguish 64k different
>> A-MPDUs.
> 
> Is that necessary? Reads like we have 2 bytes free there?

Indeed there is, maybe this wasn't the case on 4.9 where I originally
wrote this patch.

> And we only need 13 bits for the frequency (up to 8192 MHz, 60 GHz isn't
> supported), so we could take out a few fractional ones for the S1G part?

Makes sense, and yeah we really don't need 2 whole bytes to essentially
express "+0.5 MHz". Will shorten the frequency and just use a single bit
indicating offset or not.

> Dunno, I mean, we probably also don't need the A-MPDU reference, even
> radiotap doesn't make much representation on this, but it sort of
> implies that it should be unique in a capture file, for which 16 bits
> wouldn't be enough? (should probably clarify that though and say that
> you should look only "close by" or something?)

Yeah. I'll drop this for now, but maybe the space will come in handy in
the future.

-- 
thomas
