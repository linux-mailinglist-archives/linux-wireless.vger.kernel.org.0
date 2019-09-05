Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0DEAACD0
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2019 22:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388362AbfIEUKS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Sep 2019 16:10:18 -0400
Received: from nbd.name ([46.4.11.11]:55150 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732468AbfIEUKS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Sep 2019 16:10:18 -0400
Received: from p5dcfb5d4.dip0.t-ipconnect.de ([93.207.181.212] helo=[10.255.231.27])
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1i5y5A-00084d-Fd; Thu, 05 Sep 2019 22:10:16 +0200
Subject: Re: iw scan dump for /AX attributes?
To:     Johannes Berg <johannes@sipsolutions.net>,
        Ben Greear <greearb@candelatech.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <8afa882e-64de-7c8b-49f4-ac318f395102@candelatech.com>
 <bf856e90e1a90f88f69365000dc24d29c025ec70.camel@sipsolutions.net>
From:   John Crispin <john@phrozen.org>
Message-ID: <55c26ec5-7745-1823-da2f-89abfcf30f6c@phrozen.org>
Date:   Thu, 5 Sep 2019 22:10:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <bf856e90e1a90f88f69365000dc24d29c025ec70.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 05/09/2019 21:02, Johannes Berg wrote:
> On Thu, 2019-09-05 at 11:20 -0700, Ben Greear wrote:
>
>> Is anyone working on getting iw to print out /AX (HE) related
>> info?
> Good question, I wonder why we didn't do that. But no, we're not working
> on it as far as I know, and I haven't seen anything from anyone else
> either.
>
> johannes
>

Hi Ben,

I sent patches recently for most of the AX stuff recently, got some 
local patches for scan, will post them soonish

     John
