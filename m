Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D61B138057
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2019 00:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbfFFWMl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jun 2019 18:12:41 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:38778 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfFFWMk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jun 2019 18:12:40 -0400
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 0418913C283
        for <linux-wireless@vger.kernel.org>; Thu,  6 Jun 2019 15:12:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 0418913C283
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1559859160;
        bh=8QSUWnElWxKMhxnPCYbkDI2DecFkYqoNBA/kWv/icLA=;
        h=Subject:From:To:References:Date:In-Reply-To:From;
        b=qAnqpMVsXI9S57yUwARo4rUhOILMq+yRJ5uS13KW9MqOOn81djkIGAeRx12RGkoFh
         3tPWmH1V8n//Ig4SYieC/cM6VkL3SfRflkkTAEFGUBUy2EPT3Ss358RdDtpa2ziIxc
         3Tit30ybkhvMV/24sV8pV7fFtJ/3cFIVBMsDlSyI=
Subject: Re: Help with encrypting PMF management frames
From:   Ben Greear <greearb@candelatech.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <fe571fe9-d5e5-38b8-5afa-2ba4fbb51f67@candelatech.com>
Organization: Candela Technologies
Message-ID: <bc99ae7e-ace3-94a4-03da-77db3698aadd@candelatech.com>
Date:   Thu, 6 Jun 2019 15:12:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <fe571fe9-d5e5-38b8-5afa-2ba4fbb51f67@candelatech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/6/19 9:54 AM, Ben Greear wrote:
> Hello,
> 
> My variant of ath10k uses the normal 'native-wifi' tx path for management frames.
> Internally in the firmware, it seems that the management TID is flagged to expect
> raw frames, and I think that is why I see Action frames on-air that are not actually
> encrypted but which have some space added to their packet that should be filled in by
> the hw-crypt engine.
> 
> Is there a way to get mac80211 to software-crypt just management-tid PMF frames?
> 
> So far, I have not been able to find the correct place in the tx logic of
> mac80211...
> 
> Thanks,
> Ben
> 

Ok, I found the issue.  It seems the ath10k hardware refuses to encrypt
management frames unless they are sent in RAW mode (nwifi mgt frames are sent
w/out encryption for whatever reason).

So, the fix is in the ath10k driver (and just my driver I suppose, stock
driver uses a different API for mgt frames that eventually is raw-tx down in
the firmware).

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

