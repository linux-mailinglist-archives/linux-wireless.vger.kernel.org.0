Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A011488642
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Jan 2022 22:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiAHVWk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 8 Jan 2022 16:22:40 -0500
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.184]:49170 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229953AbiAHVWk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 8 Jan 2022 16:22:40 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.165])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 3A3451A0065;
        Sat,  8 Jan 2022 21:22:39 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id F26AC9C0066;
        Sat,  8 Jan 2022 21:22:38 +0000 (UTC)
Received: from [192.168.1.115] (unknown [98.97.67.209])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 1B8D513C2B0;
        Sat,  8 Jan 2022 13:22:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 1B8D513C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1641676958;
        bh=WLKmX5Q2RY3NhoARrelA6B2rooJW1BdFE7M1A8kF6MQ=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=S/WeKrL45WyDRzzz7/43jdMd8GOhZTwlsBFtL5O6lEqIJ38/A4jdMhD4sm87ehiCJ
         qOi3eP8mnM5R/Zl2K/bM7avqC+uwyjWOlE7SZ6Sq3aW5lDUZN0wbsi/s+IBqEfLmsq
         Em1GWvq2bZ01JM72Jje3EvR6NdichMEF1U4Z7sBA=
Subject: Re: iwlwifi: AX201 not using 2 receive streams
To:     Brandon Nielsen <nielsenb@jetfuse.net>,
        linux-wireless@vger.kernel.org
References: <3cb11500-6828-6ded-bebc-cdb6e1f97bc0@jetfuse.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <521b0dba-5866-ff34-da5a-479bc95cc9d9@candelatech.com>
Date:   Sat, 8 Jan 2022 13:22:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <3cb11500-6828-6ded-bebc-cdb6e1f97bc0@jetfuse.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1641676959-UjgTLmQ3XhO6
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 1/8/22 12:50 PM, Brandon Nielsen wrote:
> I have a system with Intel AX201 not using 2 spatial streams in the RX (download) direction. TX (upload) functions as expected. I'm seeing similar behavior with 
> an AX200 system. I'm seeing the same behavior on 5.15.12 as I am with 5.16.0-rc8 so I didn't mark it as a regression. Windows works as expected.
> 
> I have opened bug 215465[0] with some more detail.
> 
> [0] - https://bugzilla.kernel.org/show_bug.cgi?id=215465
> 

We saw something similar with ax210, but only on 6E, in kernel 5.15.7+.  On 5Ghz, it worked 2x2 as expected.
On a 5.15.0-rc something, it worked OK for us.

We verified same firmware is used in both cases, but have not fully bisected the problem yet but we are
working on it.  In case you find the problem patch before us, please let me know!

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
