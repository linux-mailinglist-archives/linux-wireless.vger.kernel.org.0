Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987BB2EAAF5
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Jan 2021 13:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbhAEMdL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Jan 2021 07:33:11 -0500
Received: from lpdvacalvio01.broadcom.com ([192.19.229.182]:33142 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728193AbhAEMdL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Jan 2021 07:33:11 -0500
X-Greylist: delayed 361 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Jan 2021 07:33:11 EST
Received: from bld-lvn-bcawlan-34.lvn.broadcom.net (bld-lvn-bcawlan-34.lvn.broadcom.net [10.75.138.137])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 3A7764360B;
        Tue,  5 Jan 2021 04:26:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 3A7764360B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1609849579;
        bh=dqacq57BwfJiDCTL9AzYfcuPIbbrixYEESPcebrImCk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=g25hw1XUlLEX9qmSHmnqgRl4kLCVwVWE6aLzRQt3rNe3BrKbNS0s0H1Zmb05lGAlt
         lgE5WRoCufnA/0i8ToDmZo7efJzctaMkqlHqd0MUr9I20JMc3Zro7jwncJ5zInzQY2
         f3eGU+PEjF5/ypDJCkEjTMwITJ0jUOmnC74r+/1g=
Received: from [10.230.41.55] (unknown [10.230.41.55])
        by bld-lvn-bcawlan-34.lvn.broadcom.net (Postfix) with ESMTPSA id 828FA187289;
        Tue,  5 Jan 2021 04:26:18 -0800 (PST)
Subject: Re: [PATCH] cfg80211: add VHT rate entries for MCS-10 and MCS-11
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
References: <20210105102250.3473-1-arend.vanspriel@broadcom.com>
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <aa8ea0e1-4f9f-0f3b-ec37-3b59427b1f3c@broadcom.com>
Date:   Tue, 5 Jan 2021 13:26:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210105102250.3473-1-arend.vanspriel@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 05-01-2021 11:22, Arend van Spriel wrote:
> Observed the warning in cfg80211_calculate_bitrate_vht() using an
> 11ac chip reporting MCS-11. Since devices reporting non-standard
> MCS-9 is already supported add similar entries for MCS-10 and MCS-11.
> 
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> ---
>   net/wireless/util.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)

Submitted a V2 so please discard this one.

Regards,
Arend
---
V1:https://patchwork.kernel.org/project/linux-wireless/patch/20210105102250.3473-1-arend.vanspriel@broadcom.com/
V2: 
https://patchwork.kernel.org/project/linux-wireless/patch/20210105105839.3795-1-arend.vanspriel@broadcom.com/
