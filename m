Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D64E34FFE2
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Mar 2021 14:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbhCaMEP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Mar 2021 08:04:15 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:41846 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235406AbhCaMD4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Mar 2021 08:03:56 -0400
Received: from [192.168.254.6] (unknown [50.34.172.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 21EA713C2B0;
        Wed, 31 Mar 2021 05:03:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 21EA713C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1617192235;
        bh=aVr5T7aOrelpWWkToh4pKKwdyHdS7ZKC4VAPM7asE6Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gmGMp1LOhcVUlP/1vzEz+ZbAdJQYswnrLmowIP4C/tYX9W9ED4bHJfvvFNH0bV0le
         dcj9VKYGBbJQXg2q0UYhfU6ClclhzPHcGylXP4acq1JRNRKpv6FZBvgy6WDmo19v68
         1c4Y18BOLhMIqrc51nG7LkgV7idfgiEV0JYVoskE=
Subject: Re: [PATCH 06/12] iwlwifi: mvm: Add support for 6GHz passive scan
To:     Luca Coelho <luca@coelho.fi>, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
References: <20210331091452.543321-1-luca@coelho.fi>
 <iwlwifi.20210331121101.7c7bd00e0aeb.Ib226ad57e416b43a710c36a78a617d4243458b99@changeid>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <aa0dae40-1565-2bb0-b33f-0da82a8de137@candelatech.com>
Date:   Wed, 31 Mar 2021 05:03:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <iwlwifi.20210331121101.7c7bd00e0aeb.Ib226ad57e416b43a710c36a78a617d4243458b99@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/31/21 2:14 AM, Luca Coelho wrote:
> From: Ilan Peer <ilan.peer@intel.com>
> 
> When doing scan while 6GHz channels are not enabled, the 6GHz band
> is not scanned. Thus, if there are no APs on the 2GHz and 5GHz bands
> (that will allow discovery of geographic location etc. that would
> allow enabling the 6GHz channels) but there are non collocated APs
> on 6GHz PSC channels these would never be discovered.
> 
> To overcome this, FW added support for performing passive UHB scan
> in case no APs were discovered during scan on the 2GHz and 5GHz
> channels.
> 
> Add support for enabling such scan when the following conditions are
> met:
> 
> - 6GHz channels are supported but not enabled by regulatory.
> - Station interface is not associated or less than a defined time
>    interval passed from the last resume or HW reset flows.
> - At least 4 channels are included in the scan request
> - The scan request includes the widlcard SSID.
> - At least 50 minutes passed from the last 6GHz passive scan.

Why are you trying so hard to not do passive scans?  This seems like it
is set up for all sorts of frustration.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
