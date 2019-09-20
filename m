Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40301B93B8
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2019 17:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393287AbfITPJb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Sep 2019 11:09:31 -0400
Received: from roobidoo.pudai.com ([216.14.118.130]:60480 "EHLO
        roobidoo.pudai.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387614AbfITPJa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Sep 2019 11:09:30 -0400
Received: from [71.219.36.120] (port=10772 helo=[10.168.3.100])
        by roobidoo.pudai.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <tim@smallnetbuilder.com>)
        id 1iBKXI-0000xo-Uw; Fri, 20 Sep 2019 10:09:29 -0500
Subject: Re: Can Intel AX200 sniff UL OFDMA ?
To:     Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <82af1531-6f53-364c-46ed-e011455e9c01@smallnetbuilder.com>
 <54996f59d8fb8f0f766959672e3fb9681d6a09c9.camel@sipsolutions.net>
From:   Tim Higgins <tim@smallnetbuilder.com>
Message-ID: <7d5dfbe4-17a4-dce9-0119-f21df7d7c2a1@smallnetbuilder.com>
Date:   Fri, 20 Sep 2019 11:09:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <54996f59d8fb8f0f766959672e3fb9681d6a09c9.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - roobidoo.pudai.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - smallnetbuilder.com
X-Get-Message-Sender-Via: roobidoo.pudai.com: authenticated_id: tim@timhiggins.com
X-Authenticated-Sender: roobidoo.pudai.com: tim@timhiggins.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/19/2019 6:05 PM, Johannes Berg wrote:
> Hi Tim,
>
>> I have been using the debug hw_sniffer_params file to tune the AX200 to a specific AID. This
>> works well for capturing OFDMA DL. But I have yet to capture any UL OFDMA frames, or at least I
>> don't think I have.
>>
>> I am looking for QoS data frames that have HE_MU PPDU format. Is this correct?
>> I can see plenty of HE_SU PPDU frames from STA to AP, but no HE_MU uplink.
>>
>> Am I looking for the wrong thing or can the AX200 not sniff OFDMA UL?
> UL OFDMA frames should be HE_TB PPDU format, not HE_MU. They can only be
> sent as a response to trigger frames, so all the participants are
> synchronized etc.
>
> johannes

Thanks, Johannes. I believe Wireshark shows HE_TB as HE_TRIG (0x3) under HE information > HE Data 1, correct?

