Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4213D2BAC
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jul 2021 20:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhGVRXN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Jul 2021 13:23:13 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.164]:47220 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229909AbhGVRXN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Jul 2021 13:23:13 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.26])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id E8CF820068
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jul 2021 18:03:46 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id BBACB94008D
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jul 2021 18:03:46 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 3AC4C13C2B1
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jul 2021 11:03:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 3AC4C13C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1626977026;
        bh=9dsAdrd9yJF0lANchuZT6kzRegOIW5wOinXme5wXPy0=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=E3xzelUCTFBvuXpuFf3JYsPXZYLiS8JNXwqS8bdb86OKcm4BcFEWHslceF4gbnufk
         qPIB48NYj2DY/+kGTHyLC7QUugI5H4GYbyRBHn2tkacniLmSre7qyTk02erMxLQvuf
         mGOlH/Ql9eLGLJiP+J3ZQuPFPox/uxOVWNYjf7G0=
Subject: Re: [PATCH 10/11] mt76: mt7915: Report tx-retries
To:     linux-wireless@vger.kernel.org
References: <20210720182256.30536-1-greearb@candelatech.com>
 <20210720182256.30536-10-greearb@candelatech.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <41e9db97-741b-a4a3-4b15-2c1ea36a7f7c@candelatech.com>
Date:   Thu, 22 Jul 2021 11:03:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20210720182256.30536-10-greearb@candelatech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MDID: 1626977027-z7QVHiRwAg12
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/20/21 11:22 AM, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
> 
> mac80211 stack will only report tx-status for skb claiming to be ampdu heads,
> so lie a bit in mt7915 and set the flag so that mac80211 will record status
> for each skb.
> 
> mt7915 appears to report retry status on an individual per-skb manner,
> so that method above seems to work.
> 
> Re-constitute the txinfo status rate info so that the rix and flags
> is also at least close to correct.  No direct way to report HE
> rates that way, so mac80211 might could use some tweaking in
> the ieee80211_tx_status_ext to take both info and status->rate
> into account.

Please don't apply this patch, it has a bug related to the aql and how
I cleared the skb shared info struct..  I will fix this directly and
re-post the series.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

