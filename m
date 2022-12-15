Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8098364D782
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Dec 2022 09:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiLOIGD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Dec 2022 03:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiLOIGB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Dec 2022 03:06:01 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C35331DC9;
        Thu, 15 Dec 2022 00:05:59 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id m14so2177044wrh.7;
        Thu, 15 Dec 2022 00:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1BOtxxm4hSJIEL6wxTsNCBusLvyMX1O2ctAiD2U166U=;
        b=qwLfbdTpPpDW3TZKpZjHqYluZ04OdRP4nfrp9PgjuCj6pVh7syntbkMFo95OxE0jd0
         8w6CsaZ9JQvQnyqDnGgUsCdoWMegtXeruTzHI7HzE7Z4EA9A/QlqzvExz0Npz3C1KmBc
         DKKT7CJFstdHgnnG7gwIc+UvF93CxWmSX+fXJLfAoWvxMrJQ5PqijSj98p/Lto6Y6rhi
         MXgSSlL01Dl489bBvQWBwvJHZO8K6qqXxAEmYuQX9qMsI3uml2I08HngLuf7SOZnlgb/
         m7J9I40rWLhmzo2GQrfcc+ld0CqBKTUYkdWApXtgpxd02Tpvs688qrW5dx1NmpCmuEm1
         0H7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1BOtxxm4hSJIEL6wxTsNCBusLvyMX1O2ctAiD2U166U=;
        b=QmtNSy02St7FyUeBrfp00zaULy9kpFfdn3rDF8CUstZkDss5OXbA74932ykNu6kX7d
         r9ZYcw+nmue9EdMkKVrETlPmEe1eHfaSloJGrtagCruLsJ1cEzBzwoApnU7Ev/R6kWo5
         xhMCAng8qGcPFv8gwTKw8eVmPlqjRNmPuLeJzxzS/aV5OjjaBVQSYNCMIxKXS1m660zU
         lvkBQ5lMfi3FKvPx22HjsG84EPl0dIj2xbU/TPSBB8tXY3qgqg6ymb4bg+eCpQnflRCp
         WHknn6+YS5tHEXUgj4y6G2NJlk7aFQKFaWuZEw1Bp+8qVvGbKXXHclzvO1yHB9TcJkW2
         ieTA==
X-Gm-Message-State: ANoB5pm9cS5ZuFS/e53gznlieAIWg71nSGK6XEgow9N4NfZ8uFvboR2s
        JtMs/v1Wj5s23LmItdJ1ZHE=
X-Google-Smtp-Source: AA0mqf7vFP70Dy9aysz0sHb0joZrUkB4/zxZGB1oQh1CaPxICD2M8Ne+WYOpH6TSUFUV/c5CGfXnpA==
X-Received: by 2002:a5d:61c9:0:b0:242:40de:332 with SMTP id q9-20020a5d61c9000000b0024240de0332mr15386068wrv.40.1671091557920;
        Thu, 15 Dec 2022 00:05:57 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id k17-20020adfb351000000b002423edd7e50sm5308497wrd.32.2022.12.15.00.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 00:05:57 -0800 (PST)
Date:   Thu, 15 Dec 2022 11:05:47 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     miquel.raynal@bootlin.com
Cc:     linux-wpan@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: [bug report] mac802154: Move an skb free within the rx path
Message-ID: <Y5rVW/Mb8nw0MCF3@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Miquel Raynal,

The patch 4d1c7d87030b: "mac802154: Move an skb free within the rx
path" from Oct 26, 2022, leads to the following Smatch static checker
warning:

	net/mac802154/rx.c:307 ieee802154_rx()
	warn: 'skb' was already freed.

net/mac802154/rx.c
    271 void ieee802154_rx(struct ieee802154_local *local, struct sk_buff *skb)
    272 {
    273         u16 crc;
    274 
    275         WARN_ON_ONCE(softirq_count() == 0);
    276 
    277         if (local->suspended)
    278                 goto free_skb;
    279 
    280         /* TODO: When a transceiver omits the checksum here, we
    281          * add an own calculated one. This is currently an ugly
    282          * solution because the monitor needs a crc here.
    283          */
    284         if (local->hw.flags & IEEE802154_HW_RX_OMIT_CKSUM) {
    285                 crc = crc_ccitt(0, skb->data, skb->len);
    286                 put_unaligned_le16(crc, skb_put(skb, 2));
    287         }
    288 
    289         rcu_read_lock();
    290 
    291         ieee802154_monitors_rx(local, skb);
    292 
    293         /* Level 1 filtering: Check the FCS by software when relevant */
    294         if (local->hw.phy->filtering == IEEE802154_FILTERING_NONE) {
    295                 crc = crc_ccitt(0, skb->data, skb->len);
    296                 if (crc)
    297                         goto drop;
    298         }
    299         /* remove crc */
    300         skb_trim(skb, skb->len - 2);
    301 
    302         __ieee802154_rx_handle_packet(local, skb);

This frees skb.

    303 
    304 drop:
    305         rcu_read_unlock();
    306 free_skb:
--> 307         kfree_skb(skb);

Double free.

    308 }

regards,
dan carpenter
