Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226FF753F6A
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jul 2023 18:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbjGNQA2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jul 2023 12:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235396AbjGNQA1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jul 2023 12:00:27 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A613595
        for <linux-wireless@vger.kernel.org>; Fri, 14 Jul 2023 09:00:24 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 319DA240061;
        Fri, 14 Jul 2023 16:00:21 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 70E2813C2B0;
        Fri, 14 Jul 2023 09:00:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 70E2813C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1689350420;
        bh=44I/oHYpbwaGxyZuGaybTNxfNGqp10/QKkaYBwyOFzk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DFdRxE8QPNnZ379IcYI+CW5LKLBTUGjU3yGmYpAnto46hWDWhnyFmeQCRuOcF+noI
         MaqP5OVcDNrAb7L76tifu1mJBfAShUdV1IlwctLh00uxWLnqb5V+4xltuViwRnIZ+V
         7B+ZQsXTGdnNfeopZkMA/li0xeHDppvjdJY3lXKY=
Message-ID: <486cb426-737e-fa57-20da-344fc44bb4de@candelatech.com>
Date:   Fri, 14 Jul 2023 09:00:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/3] wifi: mt76: mt7915: move mib_stats structure in
 mt76.h
Content-Language: en-US
To:     Lorenzo Bianconi <lorenzo@kernel.org>, nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
References: <cover.1683930235.git.lorenzo@kernel.org>
 <d7f29306df3495e183304825cd3159bf1ccb1d87.1683930235.git.lorenzo@kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <d7f29306df3495e183304825cd3159bf1ccb1d87.1683930235.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1689350422-WHbnmeyIBCtF
X-MDID-O: us5;at1;1689350422;WHbnmeyIBCtF;<greearb@candelatech.com>;0a45d51dfbd39c7bb3fe23128efe5de6
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/12/23 15:29, Lorenzo Bianconi wrote:
> mib_stats structure is shared by mostly all chipsets. Move it to shared
> code.

In case this thing hasn't been pushed upstream yet, then a suggestion:

Create a struct mt76_mib_stats_common class that has the common counters,
and then per-driver can have that struct as first member of its mib stats.

I have added a lot of per-driver stats that never made it upstream
and are not fully shared across different drivers.

Thanks,
Ben

> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>   drivers/net/wireless/mediatek/mt76/mt76.h     | 63 +++++++++++++++++++
>   .../wireless/mediatek/mt76/mt7915/debugfs.c   |  4 +-
>   .../net/wireless/mediatek/mt76/mt7915/mac.c   |  2 +-
>   .../net/wireless/mediatek/mt76/mt7915/main.c  |  4 +-
>   .../wireless/mediatek/mt76/mt7915/mt7915.h    | 63 +------------------
>   5 files changed, 69 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
> index 75b5c2c56a92..45bf1022a051 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> @@ -857,6 +857,69 @@ struct mt76_dev {
>   	};
>   };
>   
> +/* per-phy stats.  */
> +struct mt76_mib_stats {
> +	u32 ack_fail_cnt;

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


