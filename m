Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E905BE033
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Sep 2022 10:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbiITIe3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Sep 2022 04:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiITIdz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Sep 2022 04:33:55 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6C710FF9
        for <linux-wireless@vger.kernel.org>; Tue, 20 Sep 2022 01:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:Subject:From
        :References:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=lEiPK7c2TaSBHuoUR+KKsMCM8lkvOOx9iu40MoQy8u0=; b=Bx1ki6MWB1zRqXZC3MzC2TMij1
        2UHgv8DBAmrIp4tnsio3BSAoeYHkWmzbJYBiY9hhxFUq4zaIjUgKb+V2pwZi9W3zr4tfrV6RdrczT
        f0C7mhJq9hi7pdWx4VAYMELU92DUbOifIcuKM4ru0Rf+N8eTZaSFB5vKtcFzEXXGExqw=;
Received: from p200300daa7301d00c12bff90dd0eb021.dip0.t-ipconnect.de ([2003:da:a730:1d00:c12b:ff90:dd0e:b021] helo=nf.local)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1oaYhS-006G5M-5P; Tue, 20 Sep 2022 10:33:50 +0200
Message-ID: <238a21a8-c97b-5a38-6c08-9057055bf73f@nbd.name>
Date:   Tue, 20 Sep 2022 10:33:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Content-Language: en-US
To:     venkatch@gmail.com, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Venkat Chimata <venkata@shasta.cloud>
References: <20220915043527.737133-1-venkatch@gmail.com>
From:   Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH v2] wifi: mac80211: Fix performance issue with mutex_lock
In-Reply-To: <20220915043527.737133-1-venkatch@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 15.09.22 06:35, venkatch@gmail.com wrote:
> From: Venkat Chimata <venkata@shasta.cloud>
> 
> OpenWiFi's ucentral agent periodically (typically 120 seconds)
> issues nl80211 call to get associated client list from the
> WLAN driver. Somehow this operation was causing tx/rx delays
> sometimes and the video calls on connected clients are experiencing
> jitter. The associated client list was protected by
> a mutex lock. I saw that ieee80211_check_fast_xmit_all uses
> rcu_read_lock and rcu_read_unlock to iterate through sta_list.
> I took it as a refernce and changed the lock to rcu_read lock
> from mutex.
> Also saw this this comment just above sta_mutex declaration.
>          /* Station data */
>          /*
>           * The mutex only protects the list, hash table and
>           * counter, reads are done with RCU.
>           */
>          struct mutex sta_mtx;
> 
> Hence tried changing mutex_lock(/unlock) in ieee80211_dump_station
> to rcu_read_lock(/unlock) and it resolved the jitter issue in the
> video calls.
> 
> Tests:
> We had this issue show up consistently and the patch fixed the issue.
> We spent a good part of 2 weeks following up on this and with this
> fix, the video calls are smooth.
> 
> Also tested if this could cause any crashes with below mentioned
> process.
> 
> 1. Connect 3 clients
> 2. A script running dumping clients in an infinite loop
> 3. Continuously disconnect / connect one client to see if
>     there is any crash. No crash was observed.
The drv_sta_statistics call (called from sta_set_sinfo) can sleep, so 
you're not allowed to use RCU for iterating over the station list.
Also, please analyze and explain the actual root cause before proposing 
another fix.

- Felix
