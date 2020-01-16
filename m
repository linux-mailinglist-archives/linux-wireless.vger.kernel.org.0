Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45BEE13D38E
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2020 06:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgAPFXF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Jan 2020 00:23:05 -0500
Received: from mail.adapt-ip.com ([173.164.178.19]:48350 "EHLO
        mail.adapt-ip.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgAPFXF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Jan 2020 00:23:05 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.adapt-ip.com (Postfix) with ESMTP id E5DFD2F0ADA;
        Thu, 16 Jan 2020 05:23:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at web.adapt-ip.com
Received: from mail.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EnUyHID1lMa6; Wed, 15 Jan 2020 21:23:03 -0800 (PST)
Received: from [10.10.10.201] (c-73-202-5-52.hsd1.ca.comcast.net [73.202.5.52])
        (using TLSv1.2 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: thomas@adapt-ip.com)
        by mail.adapt-ip.com (Postfix) with ESMTPSA id C00C52F0AA5;
        Wed, 15 Jan 2020 21:23:02 -0800 (PST)
Subject: Re: [PATCH v2 0/3] fix a STA PS bug and add PS support to
 mac80211_hwsim
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <20191119053538.25979-1-thomas@adapt-ip.com>
 <85ed0881d0aeecd886b27bd482fa61fa86d96729.camel@sipsolutions.net>
 <f0ae4c07-d3c3-768f-49c0-1f2a6c5a687d@adapt-ip.com>
 <d943f37db7a57dbc335cacfa5cbbd38c8ae8dea9.camel@sipsolutions.net>
 <43f4d446d7f8b9a08e091ab811fbf99bf00da2af.camel@sipsolutions.net>
 <8ebb225f-8ec5-0897-03cd-f37bfdd94429@adapt-ip.com>
 <34040c2da85b14ff7881460efd2348b7d84b4b21.camel@sipsolutions.net>
From:   Thomas Pedersen <thomas@adapt-ip.com>
Message-ID: <385589b2-e8a2-1e39-d347-f3353bc681aa@adapt-ip.com>
Date:   Wed, 15 Jan 2020 21:23:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <34040c2da85b14ff7881460efd2348b7d84b4b21.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 1/14/20 12:00 AM, Johannes Berg wrote:
> Hi Thomas,
> 
>> Is there a list of known passing hwsim tests somewhere?
>>
>> Maybe a subset of suites / tests you like to see passing as a smoke test?
> 
> Not really.
> 
>> Or do you run through the 3300+ tests and expect them all to pass?
> 
> Pretty much, yes. It takes <10 minutes on my quad-core desktop to run
> using the UML time-travel mode against recent kernels.
> 
> I don't always get 100% pass on the first round, but the handful that
> fails sometimes I expect to pass when running just those manually with
> vm-run.sh.

Thanks, I'll give UML time-travel mode a try.


-- 
-- thomas
