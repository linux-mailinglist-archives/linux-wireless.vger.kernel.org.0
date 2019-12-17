Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C240A123B05
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 00:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfLQXnb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Dec 2019 18:43:31 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:33174 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfLQXnb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Dec 2019 18:43:31 -0500
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 4A72A13C283;
        Tue, 17 Dec 2019 15:43:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 4A72A13C283
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1576626210;
        bh=W4EeFtOn6k8fxk6cPbhJW7G5Q9zNW6cz6lNTDxCi1UE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lTfcrIKz2sYsI040hvtQFod8r9jSgltjqAnuNaceRFIOYT9XxFBEH61hKNB3SNa3n
         ZTQ2VjUbqhaGXSmjYQTpJp3akPLGdHPb8a2D3MjW/hLFodt171VbwsUpk5eUKQNqrt
         GnMXdE2a189VG6V1XKJKj7PHoqL5rp3m+A+jetT4=
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
 <a95e7f6d-1cb8-3188-aea4-233dce6f9330@candelatech.com>
 <CAKR_QVL0P4qYidtqLwhhacCOpx2iq+4RRhTXbGhfRnf2PUj5tA@mail.gmail.com>
 <CAKR_QV+KV1dR_QKjANL34DGJuyf3OSN8J6gs3bqcmiRCCzkdXA@mail.gmail.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <475d9be9-622c-08b7-12b9-d7cdf80a04f6@candelatech.com>
Date:   Tue, 17 Dec 2019 15:43:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAKR_QV+KV1dR_QKjANL34DGJuyf3OSN8J6gs3bqcmiRCCzkdXA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/17/19 3:37 PM, Tom Psyborg wrote:
> also noticed now that the noise floor changes with signal strength as
> described in this bug report:
> https://www.mail-archive.com/ath10k@lists.infradead.org/msg11553.html
> 
> after wifi restart
> 
> iwinfo:
> 
> signal: -59dBm noise: -108dBm
> 
> then goes to
> 
> signal: -52dBm noise: -103dBm
> 
> and finally drops to
> 
> signal: -59dBm noise: -103dBm
> 

The problem with debugging this sort of stuff is that you need an RF scope
to determine whether signal power of transmitter is changing or receiver
is reporting stuff weirdly.

If you are comparing against ath9k, probably you need to force your ath10k station to do /n only
(or change your AP to do /n only) so that you can be comparing similar MCS rates.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

