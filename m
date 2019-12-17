Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B24A7123502
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2019 19:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbfLQSfi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Dec 2019 13:35:38 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:42834 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfLQSfi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Dec 2019 13:35:38 -0500
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id B269313C283;
        Tue, 17 Dec 2019 10:35:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com B269313C283
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1576607737;
        bh=IrNiNk6UmF7VdwueTHkCEP89UuBxQFPbO7T5qQSqFgI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CqiAxKb9u914mCYGaOB9gRORYIrI3ChJGrVah6IVIHyChUynnqf0lPgsbubpZKZZG
         cXTMrvXnCw/RvY5x3m2I0Hw5FIQB9vwuHUp1xgIQO6KrQ3+OXv+H5aqKxKYlQniWBl
         Jc1U3VXeBsMz92CbVQAZRi66T+Ef26Mj9/lX6xlU=
Subject: Re: [PATCH] ath10k: Per-chain rssi should sum the secondary channels
To:     Tom Psyborg <pozega.tomislav@gmail.com>
Cc:     Justin Capella <justincapella@gmail.com>,
        Sebastian Gottschall <s.gottschall@newmedia-net.de>,
        linux-wireless@vger.kernel.org, ath10k <ath10k@lists.infradead.org>
References: <20191216220747.887-1-greearb@candelatech.com>
 <a2af03e9-8b53-b297-467b-d0f07b8a002b@newmedia-net.de>
 <b5d63d96-4ba6-bbab-bf1c-a61c6c437f37@newmedia-net.de>
 <80700614-679a-336e-bd9a-e88622e75c9a@candelatech.com>
 <4775d91a-9719-46f8-b0f2-979b8d86cf9f@newmedia-net.de>
 <CAMrEMU-vGB8uR-JZbD2vj4vXgWNHfFqcbsqB=gOqBBDZWGkzQA@mail.gmail.com>
 <11290a30-46e8-638e-4110-86e6b2eb3d3f@candelatech.com>
 <CAKR_QV+xNbAzzw12x3Ku49bHnERTxYRAK8AfUSwp_uOgNMbY4Q@mail.gmail.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <a95e7f6d-1cb8-3188-aea4-233dce6f9330@candelatech.com>
Date:   Tue, 17 Dec 2019 10:35:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAKR_QV+xNbAzzw12x3Ku49bHnERTxYRAK8AfUSwp_uOgNMbY4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/17/19 10:29 AM, Tom Psyborg wrote:
> On 17/12/2019, Ben Greear <greearb@candelatech.com> wrote:
>> On 12/17/19 8:23 AM, Justin Capella wrote:
>>> I believe someone recently submitted a patch that defined noise floors
>>> per band (2/5).
>>
>> I looked at using the real noise floor.  Our radio was reporting a noise
>> floor of around -102,
>> where the hard-coded default is -95.  This of course would make the reported
>> RSSI lower by 7db
>> in that case.  I am not sure that is correct.
>>
> 
> Hi
> 
> I am getting similar NF values with all my ath10k devices, I thought
> default was changed since ath9k from -95 to -115 just like in the
> vendor driver? There were some discussions about it on mailing list.
> On some channels (5Ghz) the value goes down to about -107, even saw
> -110 once.
> 

If you use ath9k and ath10k on same channel/environment, do you see similar
RSSI reported (especially with the ath10k patch I just posted)?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

