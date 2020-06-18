Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F081FF3A0
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2020 15:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730295AbgFRNr0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Jun 2020 09:47:26 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:53074 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728159AbgFRNr0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Jun 2020 09:47:26 -0400
Received: from [192.168.254.4] (unknown [50.34.202.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id DDFED13C2B1;
        Thu, 18 Jun 2020 06:47:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com DDFED13C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1592488043;
        bh=DEKCIjBQ18dyZU9BBM/G26PPLdqoswHd90cEwAWsdrQ=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=WsZ1goiESYYz19bcf7vF09TgXNtWnlkrLgo6MMg51+xAp4g4xI0rm8AEv9iGAtbMk
         f1clD6p9XyC6tsCfpI98ppp5Ir/fPICmMt9px/0AtSoC4NJJwtmVOvXo6xYe55jSGX
         wvLWDQD2UNnDBsCKblYnQMAN0jfkT2hccPQFbW/c=
Subject: Re: [PATCH] mac80211: Send deauth to STA's upon AP stop
To:     Shay Bar <shay.bar@celeno.com>,
        Johannes Berg <johannes@sipsolutions.net>
References: <20200618093609.16514-1-shay.bar@celeno.com>
Cc:     linux-wireless@vger.kernel.org
From:   Ben Greear <greearb@candelatech.com>
Message-ID: <b76cea25-4fbc-9a95-743b-13443a6074a8@candelatech.com>
Date:   Thu, 18 Jun 2020 06:47:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20200618093609.16514-1-shay.bar@celeno.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 06/18/2020 02:36 AM, Shay Bar wrote:
> In current code, AP is not informing STA when its going down.
> So STA keep looking the AP (Null function etc.) and can't find it (it is down).

Hello,

It will take a noticeable amount of time to send deauth to hundreds of stations
in cases where a busy AP goes down.  Is there any clever way to use something like
11k/v to send a single frame to let all stations know AP is going down?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
