Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A105BB833
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Sep 2022 14:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiIQMax (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Sep 2022 08:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiIQMas (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Sep 2022 08:30:48 -0400
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560BF255B0
        for <linux-wireless@vger.kernel.org>; Sat, 17 Sep 2022 05:30:44 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 2556 invoked from network); 17 Sep 2022 14:30:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1663417840; bh=WYgJejCIjfMwad3LivJDoBXp24ZHJVVK3Fs1is7rEFE=;
          h=From:To:Cc:Subject;
          b=FBj5vOD0Dw5F3QPrg1XGH6xS4xLdpIUQG/Mz6W5IhuajVQYg7syPpN/Q7nJZ9GakY
           0rKO0GgqtTRwrPiLSHQAfofL/18TADzamrz/gBpmWJvmOGrInzHAGSpdAeGBjH9/Ap
           Krfk02OB3Dt2XLdStCTMsk9V2OlHjL+/b7KS0QaQ=
Received: from 89-64-7-128.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.7.128])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <daniel@makrotopia.org>; 17 Sep 2022 14:30:38 +0200
Date:   Sat, 17 Sep 2022 14:30:33 +0200
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
Subject: Re: [PATCH 02/15] rt2x00: add throughput LED trigger
Message-ID: <20220917123033.GA17901@wp.pl>
References: <YyUBBqmK0gzmM1mP@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyUBBqmK0gzmM1mP@makrotopia.org>
X-WP-MailID: 79f9218c485c41f1fd0f838ca0445bab
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [kcOk]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Sep 17, 2022 at 12:04:38AM +0100, Daniel Golle wrote:
> From: David Bauer <mail@david-bauer.net>
> 
> This adds a (currently missing) throughput LED trigger for the rt2x00
> driver. Previously, LED triggers had to be assigned to the netdev, which
> was limited to a single VAP.
> 
> Tested-by: Christoph Krapp <achterin@googlemail.com>
> Signed-off-by: David Bauer <mail@david-bauer.net>

Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

