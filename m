Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A38E5A8B8B
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Sep 2022 04:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiIACo2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Aug 2022 22:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIACo1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Aug 2022 22:44:27 -0400
Received: from hm1480-n-201.locaweb.com.br (hm1480-n-201.locaweb.com.br [189.126.112.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 945F4155A46
        for <linux-wireless@vger.kernel.org>; Wed, 31 Aug 2022 19:44:25 -0700 (PDT)
Received: from mcbain0010.email.locaweb.com.br (189.126.112.12) by hm1480-1.locaweb.com.br id h20e7o169rk3 for <linux-wireless@vger.kernel.org>; Wed, 31 Aug 2022 23:44:10 -0300 (envelope-from <cesarb@cesarb.eti.br>)
Received: from proxy.email-ssl.com.br (unknown [10.31.120.207])
        by mcbain0010.email.locaweb.com.br (Postfix) with ESMTP id C58F9F205E9;
        Wed, 31 Aug 2022 23:44:47 -0300 (-03)
x-locaweb-id: 5II90qkwcFl608adNSKU11Mhs1xf0MgAzPC-CIfMoteOMOLYZkorw41aZgtgCBGiz7JOWdNt-MIUbUFIqc5n_VfP5aYHWPJEum0HS-HjJOsIpO5T7hyEdQlNuz8mvNRMcNODC_fBQ_ssrqDqHxcCw9XB-YCW0kFcYlg4GV58UHALldGZZoamkcKgQkZzHn_vj9V_2LrSIFVQSoxh8p5TTA== NjM2NTczNjE3MjYyNDA2MzY1NzM2MTcyNjIyZTY1NzQ2OTJlNjI3Mg==
x-locaweb-id: 5II90qkwcFl608adNSKU11Mhs1xf0MgAzPC-CIfMoteOMOLYZkorw41aZgtgCBGiz7JOWdNt-MIUbUFIqc5n_VfP5aYHWPJEum0HS-HjJOsIpO5T7hyEdQlNuz8mvNRMcNODC_fBQ_ssrqDqHxcCw9XB-YCW0kFcYlg4GV58UHALldGZZoamkcKgQkZzHn_vj9V_2LrSIFVQSoxh8p5TTA== NjM2NTczNjE3MjYyNDA2MzY1NzM2MTcyNjIyZTY1NzQ2OTJlNjI3Mg==
x-locaweb-id: 5II90qkwcFl608adNSKU11Mhs1xf0MgAzPC-CIfMoteOMOLYZkorw41aZgtgCBGiz7JOWdNt-MIUbUFIqc5n_VfP5aYHWPJEum0HS-HjJOsIpO5T7hyEdQlNuz8mvNRMcNODC_fBQ_ssrqDqHxcCw9XB-YCW0kFcYlg4GV58UHALldGZZoamkcKgQkZzHn_vj9V_2LrSIFVQSoxh8p5TTA== NjM2NTczNjE3MjYyNDA2MzY1NzM2MTcyNjIyZTY1NzQ2OTJlNjI3Mg==
X-LocaWeb-COR: locaweb_2009_x-mail
X-AuthUser: cesarb@cesarb.eti.br
Received: from [192.168.96.204] (unknown [200.187.114.14])
        (Authenticated sender: cesarb@cesarb.eti.br)
        by proxy.email-ssl.com.br (Postfix) with ESMTPSA id 2BD36560892;
        Wed, 31 Aug 2022 23:44:18 -0300 (-03)
Message-ID: <2cf2cb6e-8083-9c09-c2a6-ae49424ea37a@cesarb.eti.br>
Date:   Wed, 31 Aug 2022 23:44:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [wireless-regdb] wireless-regdb: Update regulatory rules for
 Brazil (BR)
To:     Seth Forshee <sforshee@kernel.org>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
References: <271ca023-d574-7d84-a020-ec5950fb500e@cesarb.eti.br>
 <Yw4cTotCZm7CH/v7@ubuntu-x1>
Content-Language: en-US
From:   Cesar Eduardo Barros <cesarb@cesarb.eti.br>
In-Reply-To: <Yw4cTotCZm7CH/v7@ubuntu-x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Em 30/08/2022 11:18, Seth Forshee escreveu:
> On Wed, Aug 17, 2022 at 08:31:56PM -0300, Cesar Eduardo Barros wrote:
>> 	#(902 - 907.5 @ ???), (30)
>> 	#(915 - 928 @ ???), (30)
> 
> For these ranges I think you should use the same bandwidth as other
> rules in the database, i.e. 2 and 16 MHz.

I found only two entries in the database with rules for the 900MHz 
frequencies: US and "world". I don't think the US rule is a good model 
here; it can use 16 MHz because it's a contiguous range, but the range 
for Brazil has a hole in the middle.

Since there's nothing that a found in these rules which mention a 
maximum channel width, the correct width is probably the maximum which 
fits on each piece of the range. That is,

(902 - 907.5 @ 4), (30)
(915 - 928 @ 8), (30)

As far as I could find, the hole between 907.5 and 915 exists because 
there are three 2.5 MHz-wide GSM uplink channels there. However, I also 
found out that there is a proposal within ANATEL (Consulta Pública 52 
from 2021) to expand it with another uplink channel at 905 - 907.5 
(there are actually five uplink channels in that proposal, the other one 
is at 898.5 - 901). I have no idea when this will become official, or 
whether it has already happened (and just wasn't reflected yet in the 
restricted radiation rules I had researched), and what effect it would 
have on 802.11ah users.

Given the uncertainty from that change, and given that so far there are 
rules for the 900 MHz range in wireless-regdb only for the USA, it might 
be wise to hold it for now and apply only the rest of the changes, 
without these 900 MHz ranges.

> Otherwise I think these changes look good. If you can send a patch with
> the changes I would appreciate it, otherwise let me know and I can send
> a patch.

I will prepare a patch tomorrow.

-- 
Cesar Eduardo Barros
cesarb@cesarb.eti.br

