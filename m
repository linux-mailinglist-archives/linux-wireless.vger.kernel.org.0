Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E677EEC754
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2019 18:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfKAROL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Nov 2019 13:14:11 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:48332 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfKAROL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Nov 2019 13:14:11 -0400
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 6D3BC13C358;
        Fri,  1 Nov 2019 10:09:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 6D3BC13C358
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1572628147;
        bh=MCK6Ywe7qDyygTHlBZzZkjl0/Sf7CAGF+Gag/VKFgHg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=F3Opa4aUBkMTsrosuAnH2K0Z/jNTHkiv/1upP7ObNg+6A6H00AzmeBWZIu80X7Cb+
         124FPPMzAhp+ktlp7j/UFxOwSP/+8vaJpi7OTscwIdSHeuGIUUY/uX6dnzjwSed3eT
         63TOLF2c/C6Sma69cCLxLwxexsxkWif21SyVIgNs=
Subject: Re: [RFC] ath10k: interface combination with monitor
To:     Tom Psyborg <pozega.tomislav@gmail.com>,
        ath10k <ath10k@lists.infradead.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <CAKR_QVJ2eHrESLOEqiKxbjr0SoZh3oJydtgcebBOXSpspbquWA@mail.gmail.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <bb62015e-d097-f54c-56ce-000d0b18a5ac@candelatech.com>
Date:   Fri, 1 Nov 2019 10:09:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAKR_QVJ2eHrESLOEqiKxbjr0SoZh3oJydtgcebBOXSpspbquWA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/1/19 10:03 AM, Tom Psyborg wrote:
> Hi
> 
> Is there a way to run monitor mode interface independent on STA/AP
> interface presence or their state?
> I am using airodump-ng/airmon-ng and I've noticed that while mon
> interface is brought up airodump-ng is unable to find any beacons
> unless sta interface is brought down. That is with QCA9880 devices,
> while with QCA9377 airodump-ng only finds beacons if the sta interface
> is associated to an AP.
> Does this need firmware change to work or driver changes are sufficient?
> 

I would expect it to work.  Have you tried -ct firmware on 9880 in this
manner?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

