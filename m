Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024395B9F88
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Sep 2022 18:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiIOQTD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Sep 2022 12:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiIOQSn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Sep 2022 12:18:43 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4309CCC8
        for <linux-wireless@vger.kernel.org>; Thu, 15 Sep 2022 09:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yWtNuX2Y0yBQx1BHAgJFSA4C6O6ZJieQhQeChGx86FI=; b=BwJ1eula1pWL7NUV3f/CYhb20r
        Ox0N6sTqzupX1dXzJFJ8Yd1gqG4AVAJBaKq35LlXN3tDbTw4VmCs4HAhpPEgCemsd3V5WmmExAmsl
        v0Hc/6tZ/frqSyf+M3cbJTSCs0iLGbill0YXjIdvRksRToOh7dHbiAmK9c/ozLNEQL0A=;
Received: from p200300daa7301d00b82a348903aff2a7.dip0.t-ipconnect.de ([2003:da:a730:1d00:b82a:3489:3af:f2a7] helo=nf.local)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1oYrZY-005BaH-3E; Thu, 15 Sep 2022 18:18:40 +0200
Message-ID: <26e9ae91-8e13-df45-815c-cb45c1911032@nbd.name>
Date:   Thu, 15 Sep 2022 18:18:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH] mac80211: Ensure vif queues are operational after start
Content-Language: en-US
To:     Alexander Wetzel <alexander@wetzel-home.de>,
        linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes@sipsolutions.net>
References: <20220915130946.302803-1-alexander@wetzel-home.de>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <20220915130946.302803-1-alexander@wetzel-home.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 15.09.22 15:09, Alexander Wetzel wrote:
> Make sure local->queue_stop_reasons and vif.txqs_stopped stay in sync.
> 
> When a new vif is created the queues may end up in an inconsistent state
> and be inoperable:
> Communication not using iTXQ will work, allowing to e.g. complete the
> association. But the 4-way handshake will time out. The sta will not
> send out any skbs queued in iTXQs.
> 
> All normal attempts to start the queues will fail when reaching this
> state.
> local->queue_stop_reasons will have marked all queues as operational but
> vif.txqs_stopped will still be set, creating an inconsistent internal
> state.
> 
> In reality this seems to be race between the mac80211 function
> ieee80211_do_open() setting SDATA_STATE_RUNNING and the wake_txqs_tasklet:
> Depending on the driver and the timing the queues may end up to be
> operational or not.
> 
> Cc: stable@vger.kernel.org
> Fixes: f856373e2f31 ("wifi: mac80211: do not wake queues on a vif that is being stopped")
> Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>

Acked-by: Felix Fietkau <nbd@nbd.name>

Thanks for figuring this one out,

- Felix
