Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8113A2EA173
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Jan 2021 01:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbhAEAZv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jan 2021 19:25:51 -0500
Received: from mail.adapt-ip.com ([173.164.178.19]:59794 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726026AbhAEAZv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jan 2021 19:25:51 -0500
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id C98184FB575;
        Tue,  5 Jan 2021 00:25:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id YNKD848N7Z3Z; Tue,  5 Jan 2021 00:25:01 +0000 (UTC)
Received: from mail.ibsgaard.io (c-73-223-60-234.hsd1.ca.comcast.net [73.223.60.234])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id DD05D4FB3F3;
        Tue,  5 Jan 2021 00:25:00 +0000 (UTC)
MIME-Version: 1.0
Date:   Mon, 04 Jan 2021 16:25:00 -0800
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Ben Greear <greearb@candelatech.com>
Cc:     ath10k <ath10k@lists.infradead.org>, linux-wireless@vger.kernel.org
Subject: Re: RX rate is wrong in 5.10? (bisected to: mac80211: receive and
 process S1G beacons)
In-Reply-To: <5dc86950-1672-6900-dad4-3b437f4959c5@candelatech.com>
References: <584816e2-ed18-3d5e-651e-293637222148@candelatech.com>
 <5dc86950-1672-6900-dad4-3b437f4959c5@candelatech.com>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <772a3a0517eb4d4cc6cee975e5fde100@adapt-ip.com>
X-Sender: thomas@adapt-ip.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Ben,

On 2021-01-04 16:18, Ben Greear wrote:
> On 1/4/21 8:18 AM, Ben Greear wrote:
>> Hello,
>> 
>> I noticed that RX rate is always 6Mbps when I use -ct firmware and -ct 
>> driver in
>> 5.10, and on stock 5.10.0 driver and stock firmware, rx-rate does not 
>> show up at
>> all in 'iw dev wlan1 station dump'.
>> 
>> I'm using 9984 NIC...
>> 
>> Anyone else see this?
> 
> After a bisect, the first bad commit shows this:
> 
> commit 09a740ce352e1a1d16b9984115514ba9a4f4704b (refs/bisect/bad)
> Author: Thomas Pedersen <thomas@adapt-ip.com>
> Date:   Mon Sep 21 19:28:14 2020 -0700
> 
>     mac80211: receive and process S1G beacons
> 
>     S1G beacons are 802.11 Extension Frames, so the fixed
>     header part differs from regular beacons.
> 
>     Add a handler to process S1G beacons and abstract out the
>     fetching of BSSID and element start locations in the
>     beacon body handler.
> 
>     Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
>     Link: 
> https://lore.kernel.org/r/20200922022818.15855-14-thomas@adapt-ip.com
>     [don't rename, small coding style cleanups]
>     Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> 
> From a glance through the diff, I'm at a loss as to why it causes the
> symptom.  I manually
> double-checked the bisect, an it appears correct.
> 
> What I see is that in the commit before this, I see a useful rx rate
> (1.3Gbps for instance)
> in 'iw dev wlan1 station dump', but in this bad commit, both show
> 6Mbps rate.  (Tx rate
> in ath10k is probably broken for other reasons, so I only bisected the
> rx side issue.)
> 
> I'm using ath10k 9984 radio with firmware 10.4-3.9.0.2-00070 in station 
> mode.
> 
> AP is an ath11k Hawkeye...
> 
> I'm using a 1Mbps UDP packet 'download' stream to make sure I'm seeing
> rates for data frames
> and not just management frames.

Sorry about that.

> Any idea what might be the issue?

It may be fixed by 
https://patchwork.kernel.org/project/linux-wireless/patch/1607483189-3891-1-git-send-email-wgong@codeaurora.org/

-- 
thomas
