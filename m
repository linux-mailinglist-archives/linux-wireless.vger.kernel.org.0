Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D625BB835
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Sep 2022 14:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiIQMbi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Sep 2022 08:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIQMbh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Sep 2022 08:31:37 -0400
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BC626574
        for <linux-wireless@vger.kernel.org>; Sat, 17 Sep 2022 05:31:36 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 3410 invoked from network); 17 Sep 2022 14:31:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1663417893; bh=ykhellfOivvhmRAj6IyaINw4KkjQ5uGdjyexixGo2IU=;
          h=From:To:Cc:Subject;
          b=nAmVbu6nZxHkYIZQMMuXisrd68vansUSw9Fe0qkuBpMdaxu7GSSezqrvGVpin1xnc
           xx9Ihp1G2j2O0/H/BWZcxHaiUvMHLyTGPyOQVWWC1q70OQ7BrGskVm1lrCnxl+0GgT
           F5m74ywkwBIU7Gc4rxVx8AInKefpsDQqRYdUc6qo=
Received: from 89-64-7-128.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.7.128])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <daniel@makrotopia.org>; 17 Sep 2022 14:31:33 +0200
Date:   Sat, 17 Sep 2022 14:31:33 +0200
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
Subject: Re: [PATCH 03/15] rt2x00: add support for external PA on MT7620
Message-ID: <20220917123133.GB17901@wp.pl>
References: <YyUBHg40OUWfuUWD@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YyUBHg40OUWfuUWD@makrotopia.org>
X-WP-MailID: 8bdb55643a4ab468ac896f8d2da5a9bf
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [MeNh]                               
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Sep 17, 2022 at 12:05:02AM +0100, Daniel Golle wrote:
> Implement support for external PA connected to MT7620A.
> 
> Signed-off-by: Tomislav Požega <pozega.tomislav@gmail.com>
> [pozega.tomislav@gmail.com: use chanreg and dccal helpers.]
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
