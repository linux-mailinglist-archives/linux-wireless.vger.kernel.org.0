Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60900CFC0A
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2019 16:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbfJHOLr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Oct 2019 10:11:47 -0400
Received: from roobidoo.pudai.com ([216.14.118.130]:34200 "EHLO
        roobidoo.pudai.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725821AbfJHOLr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Oct 2019 10:11:47 -0400
Received: from cruzio-216-173-129-210.static.cruzio.net ([216.173.129.210]:16671 helo=[172.16.30.215])
        by roobidoo.pudai.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <tim@timhiggins.com>)
        id 1iHqDI-0001jR-QF; Tue, 08 Oct 2019 09:11:45 -0500
Cc:     tim@timhiggins.com,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: AX200 crash on udp upload, cannot restart
To:     Luca Coelho <luca@coelho.fi>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>,
        Ben Greear <greearb@candelatech.com>
References: <08f29d02-2fcf-e779-6fc0-ea7a9d4e59b6@candelatech.com>
 <20191008073330.7nuwzwpwgzgjfswm@bars>
 <df659853170ddf7a309c2f132eb749a35fbd8caf.camel@coelho.fi>
From:   Tim Higgins <tim@timhiggins.com>
Message-ID: <d603172d-5642-13d4-ece7-301d9525351e@timhiggins.com>
Date:   Tue, 8 Oct 2019 07:11:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <df659853170ddf7a309c2f132eb749a35fbd8caf.camel@coelho.fi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

This is not just a UDP issue. I've seen crashes and/or throughput drops running 
TCP/IP uplink iperf3 traffic to test maximum bandwidth.

On 10/8/2019 12:58 AM, Luca Coelho wrote:
> On Tue, 2019-10-08 at 07:33 +0000, Sergey Matyukevich wrote:
>>> We have a system with several of the AX200 NICs in it, kernel is 5.2.14+.  We ran a udp upload
>>> test of 10Mbps across all radios, and after about 10 minutes one of the radios crashed and could
>>> not be restarted.  The others continued to run so far.
>>>
>>> I will open a bug in the kernel bug tracker.
>>
>> Hello Ben,
>>
>> We observed similar issues in our tests as well. All the details
>> have been described in kernel bugzilla issue:
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__bugzilla.kernel.org_show-5Fbug.cgi-3Fid-3D205061&d=DwIFAg&c=MHZppzMdXMt3JYjCV71UsQ&r=RFH8dgrFzz0_hnNXpEl_u3TZqD-B6kYLzfvbDuCKw3U&m=opeh64GEVevn0071vriL-kH2B_orc25yacBPa3YdgLI&s=CKuyBZ0VdAQocDiZGOIDyDC6GG9w4E7OikmGvzblazU&e=
> 
> Thanks for the reports!
> 
> Ben also added a bug in bugzilla[1], let's use that one for tracking
> (I'll mark Sergey's as a duplicate).
> 
> This is a know issue and our PHY team is already working on it
> internally.  I don't have much more details at the moment, but I'll
> update the bugzilla entry as soon as we know more.
> 
> 
> --
> Cheers,
> Luca.
> 
