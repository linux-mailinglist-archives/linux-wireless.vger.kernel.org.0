Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79D65B01B8
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2019 18:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbfIKQh6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Sep 2019 12:37:58 -0400
Received: from roobidoo.pudai.com ([216.14.118.130]:37054 "EHLO
        roobidoo.pudai.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728794AbfIKQh6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Sep 2019 12:37:58 -0400
X-Greylist: delayed 1357 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Sep 2019 12:37:57 EDT
Received: from [71.219.36.120] (port=1667 helo=[10.168.3.100])
        by roobidoo.pudai.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <tim@timhiggins.com>)
        id 1i85H5-0001Df-5x; Wed, 11 Sep 2019 11:15:19 -0500
Cc:     tim@timhiggins.com
Subject: Re: Question on Intel AX200
To:     Ben Greear <greearb@candelatech.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <33bd9a39-0028-2f99-f43e-5e15c9e87287@candelatech.com>
From:   Tim Higgins <tim@timhiggins.com>
Message-ID: <ebe5532f-f456-2534-cd5e-c44d4c43696b@timhiggins.com>
Date:   Wed, 11 Sep 2019 12:15:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <33bd9a39-0028-2f99-f43e-5e15c9e87287@candelatech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - roobidoo.pudai.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - timhiggins.com
X-Get-Message-Sender-Via: roobidoo.pudai.com: authenticated_id: tim@timhiggins.com
X-Authenticated-Sender: roobidoo.pudai.com: tim@timhiggins.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/11/2019 9:49 AM, Ben Greear wrote:
> Hello,
>
> Does anyone know how well AX200 currently supports:
>
> OFDMA
>
> MU-MIMO (receiver)
>
> AP Mode
>
> And, can anyone suggest a good /AX AP to test against for these features?
>
> Thanks,
> Ben
>
Hi Ben,
I've been doing a lot of testing with the AX200 as a STA and sniffer, focusing on trying to see 
if OFDMA lives up to its advertised features. This topic is probably not of interest to this 
general list, so I'm happy to take the discussion to one-on-one.

Tim
