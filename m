Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90E3017B895
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2020 09:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgCFIs2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Mar 2020 03:48:28 -0500
Received: from mailext.lri.fr ([129.175.15.10]:39458 "HELO mailext.lri.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725908AbgCFIs2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Mar 2020 03:48:28 -0500
Received: from [129.175.15.10] (mailext.lri.fr [129.175.15.10])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by mailext.lri.fr (Postfix) with ESMTPSA id 41155C0F17;
        Fri,  6 Mar 2020 09:48:26 +0100 (CET)
Subject: Re: [PATCH] mac80211: Do not send mesh HWMP PREQ if HWMP is disabled
To:     Thomas Pedersen <thomas@adapt-ip.com>,
        linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes@sipsolutions.com>
References: <20200305140409.12204-1-cavallar@lri.fr>
 <0deb25c7-4880-a29b-6a38-396e1d235180@adapt-ip.com>
From:   Nicolas Cavallari <Nicolas.Cavallari@lri.fr>
Message-ID: <2e29372a-de74-4cf5-ed53-ca5de15142b2@lri.fr>
Date:   Fri, 6 Mar 2020 09:48:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <0deb25c7-4880-a29b-6a38-396e1d235180@adapt-ip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 05/03/2020 21:07, Thomas Pedersen wrote:
> On 3/5/20 6:04 AM, Nicolas Cavallari wrote:
>> From: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
>>
>> When trying to transmit to an unknown destination, the mesh code would
>> unconditionally transmit a HWMP PREQ even if HWMP is not the current
>> path selection algorithm.
>>
> 
> The skb would still get queued onto the mpath->frame_queue. Is it
> this expected? ie. do you have a non-hwmp path selection algorithm which
> will handle it, or are you really checking if path selection is
> disabled?


Well, there is no way to disable path selection, is it ? The only way for
HWMP to be disabled is to use a vendor path selection, right ?
So as soon as userspace adds the path, the skb will be sent.
