Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 817B1448A9
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2019 19:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393321AbfFMRKL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jun 2019 13:10:11 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:49044 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729432AbfFLWxF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 18:53:05 -0400
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 8916C13C283
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2019 15:53:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 8916C13C283
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1560379982;
        bh=Kt5eWWaHP+XXbCgiP9vPYL/r27fgQb9YEFNFlcHt67U=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=JA6aZ8Wropb6/EGcdmL2qnYReg4AYFLU2KjnE6seGKDb7QudQ+wfP+NMmwYmm33W5
         Wk2n/UAf4LijhyYJ4Ju5iT2xfMhO7Y0r924ymY+1CiyMlwz86sRZqmQWWvbUkJRTTh
         FgRpPJVEH+nFR/M8suUvNi7/vy58xEkqF7VxNHq8=
Subject: Re: [PATCH-v3 2/2] mac80211: add assoc-at-ms support.
To:     linux-wireless@vger.kernel.org
References: <20190415172123.6532-1-greearb@candelatech.com>
 <20190415172123.6532-2-greearb@candelatech.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <f2b698d8-1596-5097-ff26-8bb3ed969d7a@candelatech.com>
Date:   Wed, 12 Jun 2019 15:53:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190415172123.6532-2-greearb@candelatech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/15/19 10:21 AM, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
> 
> Report when sta becomes associated.

While rebasing, I notice this file is just sitting in patchwork.

Any chance this patch and the previous one in the series can be accepted?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

