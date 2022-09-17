Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CE95BB84A
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Sep 2022 14:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiIQMxS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Sep 2022 08:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiIQMxQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Sep 2022 08:53:16 -0400
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F35E28704
        for <linux-wireless@vger.kernel.org>; Sat, 17 Sep 2022 05:53:15 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 458 invoked from network); 17 Sep 2022 14:53:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1663419193; bh=w5ZrBRV7aPX4+B92MWqeYsGj8m1l7h2qwmB3b8KWACA=;
          h=From:To:Cc:Subject;
          b=kWX+LKY76HxerFgctem9AyyNq9seA8sPMvXmZ92s7Y9eZqTvDHD42T4tNAT4KzsL9
           Wdimih6SQ7xNfwOI6M8T2SjP5AXwSNBJNEG2t0xHEtZ0OfgRte4Yq2vizlFdY1qfGm
           aFEIRGfTj3dOO6RYZCeh7iZkb7GIGBZAbxYDQ1yM=
Received: from 89-64-7-128.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.7.128])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <daniel@makrotopia.org>; 17 Sep 2022 14:53:13 +0200
Date:   Sat, 17 Sep 2022 14:53:12 +0200
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     linux-wireless@vger.kernel.org,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH 11/15] rt2x00: fix HT20/HT40 bandwidth switch on MT7620
Message-ID: <20220917125312.GI17901@wp.pl>
References: <YyUBtAInd85qn1/7@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyUBtAInd85qn1/7@makrotopia.org>
X-WP-MailID: 5e01dd6b0c91aa8f0e0a071dc3f22d71
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [UUME]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Sep 17, 2022 at 12:07:32AM +0100, Daniel Golle wrote:
> Add missing configuration of the channel bandwidth filter to the
> channel setup function for MT7620.
> 
> Reported-by: Serge Vasilugin <vasilugin@yandex.ru>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
