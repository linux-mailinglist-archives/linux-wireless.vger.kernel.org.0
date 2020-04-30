Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC011C0346
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2020 18:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgD3Q5r (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Apr 2020 12:57:47 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:40794 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725844AbgD3Q5q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Apr 2020 12:57:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 38D274F80EE;
        Thu, 30 Apr 2020 16:57:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FHxCO478ExbD; Thu, 30 Apr 2020 16:57:42 +0000 (UTC)
Received: from [10.10.10.158] (c-73-202-5-52.hsd1.ca.comcast.net [73.202.5.52])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 93FB64F80ED;
        Thu, 30 Apr 2020 16:57:42 +0000 (UTC)
Subject: Re: [PATCH v3 1/5] cfg80211: add KHz variants of frame RX API
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <20200430010642.22552-1-thomas@adapt-ip.com>
 <20200430010642.22552-2-thomas@adapt-ip.com>
 <450305028ea9174998726c1647b08361a88dced5.camel@sipsolutions.net>
From:   Thomas Pedersen <thomas@adapt-ip.com>
Message-ID: <05073739-c686-dce9-8cfe-259ae62f0c92@adapt-ip.com>
Date:   Thu, 30 Apr 2020 09:57:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <450305028ea9174998726c1647b08361a88dced5.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/30/20 4:37 AM, Johannes Berg wrote:
> On Wed, 2020-04-29 at 18:06 -0700, Thomas Pedersen wrote:
>>
>> +#define PR_KHZ(f) KHZ_TO_MHZ((float) f)
> 
> You can't use float, sorry.

OK, I'll need to do something else, thanks.

-- 
thomas
