Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75284663F2B
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jan 2023 12:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235744AbjAJLS0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Jan 2023 06:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjAJLSU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Jan 2023 06:18:20 -0500
Received: from mail1.systemli.org (mail1.systemli.org [93.190.126.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E98186EA
        for <linux-wireless@vger.kernel.org>; Tue, 10 Jan 2023 03:18:18 -0800 (PST)
Message-ID: <cc230245-2599-7665-3785-150dee0bf873@systemli.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=systemli.org;
        s=default; t=1673349497;
        bh=C3fLBTMIkJ1r+D80WAu/Bl6JUyrL0QY7t/SpIufZNaQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=4gIXcdmyd15f6XxF6vb8JIoXFfsdq6UrDZ6XQPMf70CEV0l3Gd90+aKRS4noDKLzw
         mW0pkeAbZIIu5ucucEC4TGb6b4HDu8tIttWDiMSDQSZR6VHV1swMl69Kq2yMQehnVx
         EjwJrRUGvMZKwLgKPN2xfML7L9Ynadfe+g3zDiN98qory5AxKMmig59BFzk74Yaipw
         1gsr15sI1GZRV4j9tWHDUrVHG1RUJ4M1/y8GFG2kQwPnxcV1Vu8Q+7JUZ1y6dl3B3O
         kWtKEhqU3DT7HsSUllSNpbi9UzE4i9+57VkmtnbSbCYg2XxaDUqQgcUHp93k5vs+JZ
         1H+qYdUtNqT/w==
Date:   Tue, 10 Jan 2023 12:18:14 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] wifi: mac80211: add support for scanning in ap mode
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     nbd@nbd.name, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
References: <20230110110524.511258-1-vincent@systemli.org>
 <a7ccf0e6a1481f592fa9ff81f7b6545a4f4a653f.camel@sipsolutions.net>
Content-Language: en-US
From:   Nick <vincent@systemli.org>
In-Reply-To: <a7ccf0e6a1481f592fa9ff81f7b6545a4f4a653f.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thanks for your feedback. Can you suggest a better way to do this?

Bests
Nick

On 1/10/23 12:07, Johannes Berg wrote:
> On Tue, 2023-01-10 at 12:05 +0100, Nick Hainke wrote:
>> OpenWRT has shipped a patch since 2011 that allows it to perform a scan
>> in AP mode, whether it is supported by the driver or not. In certain
>> situations, it may be desirable to scan an interface that is currently
>> in AP mode regardless of whether frames are missed. The patch adds a
>> module parameter "allow_ap_scan" that, if set to true, allows the behavior
>> described above.
>>
> I must say - not really in favour of throwing around random module
> parameters like that :)
>
> johannes
