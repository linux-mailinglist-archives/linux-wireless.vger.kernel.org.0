Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E78C2EA167
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Jan 2021 01:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbhAEAT2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jan 2021 19:19:28 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:36318 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbhAEAT1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jan 2021 19:19:27 -0500
Received: from [192.168.254.6] (unknown [50.46.152.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 1A3F013C2B0;
        Mon,  4 Jan 2021 16:18:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 1A3F013C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1609805927;
        bh=BgBvQ3tngIKZfMOStwU79haJSNRA7/wJGpW6iPo6NVY=;
        h=Subject:From:To:References:Date:In-Reply-To:From;
        b=oc3z+RckfgNIgraoev2Fa09WXm/jr3QvMLOA2r8joxrNq9pedQTIScGBM4ZlsaD8C
         nvyt4ok3ZqWPcwkoG+IG6JQtii51+x8563QUqkvRL8WeB8KHQr42wkNpON+QCI8z6i
         D9HUGou13ykfXmHRL/w7etZtzPphIn8q1s3AjVi4=
Subject: Re: RX rate is wrong in 5.10? (bisected to: mac80211: receive and
 process S1G beacons)
From:   Ben Greear <greearb@candelatech.com>
To:     ath10k <ath10k@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
References: <584816e2-ed18-3d5e-651e-293637222148@candelatech.com>
Organization: Candela Technologies
Message-ID: <5dc86950-1672-6900-dad4-3b437f4959c5@candelatech.com>
Date:   Mon, 4 Jan 2021 16:18:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <584816e2-ed18-3d5e-651e-293637222148@candelatech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 1/4/21 8:18 AM, Ben Greear wrote:
> Hello,
> 
> I noticed that RX rate is always 6Mbps when I use -ct firmware and -ct driver in
> 5.10, and on stock 5.10.0 driver and stock firmware, rx-rate does not show up at
> all in 'iw dev wlan1 station dump'.
> 
> I'm using 9984 NIC...
> 
> Anyone else see this?

After a bisect, the first bad commit shows this:

commit 09a740ce352e1a1d16b9984115514ba9a4f4704b (refs/bisect/bad)
Author: Thomas Pedersen <thomas@adapt-ip.com>
Date:   Mon Sep 21 19:28:14 2020 -0700

     mac80211: receive and process S1G beacons

     S1G beacons are 802.11 Extension Frames, so the fixed
     header part differs from regular beacons.

     Add a handler to process S1G beacons and abstract out the
     fetching of BSSID and element start locations in the
     beacon body handler.

     Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
     Link: https://lore.kernel.org/r/20200922022818.15855-14-thomas@adapt-ip.com
     [don't rename, small coding style cleanups]
     Signed-off-by: Johannes Berg <johannes.berg@intel.com>

 From a glance through the diff, I'm at a loss as to why it causes the symptom.  I manually
double-checked the bisect, an it appears correct.

What I see is that in the commit before this, I see a useful rx rate (1.3Gbps for instance)
in 'iw dev wlan1 station dump', but in this bad commit, both show 6Mbps rate.  (Tx rate
in ath10k is probably broken for other reasons, so I only bisected the rx side issue.)

I'm using ath10k 9984 radio with firmware 10.4-3.9.0.2-00070 in station mode.

AP is an ath11k Hawkeye...

I'm using a 1Mbps UDP packet 'download' stream to make sure I'm seeing rates for data frames
and not just management frames.

Any idea what might be the issue?

Thanks,
Ben


