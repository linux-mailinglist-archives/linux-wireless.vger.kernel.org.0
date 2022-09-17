Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB1C5BB848
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Sep 2022 14:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiIQMvG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Sep 2022 08:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiIQMvE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Sep 2022 08:51:04 -0400
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6012A95F
        for <linux-wireless@vger.kernel.org>; Sat, 17 Sep 2022 05:51:03 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 15029 invoked from network); 17 Sep 2022 14:51:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1663419061; bh=hs+G9vf/slDY/R7hS1QMJKur6391FDoOuknIR9eEmq8=;
          h=From:To:Cc:Subject;
          b=P7DD4HO0VAGowU9RXR6H2XCfT3brQSOq97WEcknqGEubgVTiceBcxpZg0TooBSKvL
           AGwYvkpaM05rqD+BjW5nSZ9GvIk6g0aYFF8Q2o0HEnF4wqtePxLHVs7uJySLVHMgR3
           hcYbRolfmOtzU1hzKEJpzjFPYalJ7KYfNmbwT6h8=
Received: from 89-64-7-128.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.7.128])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <daniel@makrotopia.org>; 17 Sep 2022 14:51:01 +0200
Date:   Sat, 17 Sep 2022 14:51:00 +0200
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
Subject: Re: [PATCH 15/15] rt2x00: correctly set BBP register 86 for MT7620
Message-ID: <20220917125100.GH17901@wp.pl>
References: <YyUCAab/UdlTViSp@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyUCAab/UdlTViSp@makrotopia.org>
X-WP-MailID: 7ccb83a2145e371ae13f9be3269a8270
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [USOE]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Sep 17, 2022 at 12:08:49AM +0100, Daniel Golle wrote:
> Instead of 0 set the correct value for BBP register 86 for MT7620.
> 
> Reported-by: Serge Vasilugin <vasilugin@yandex.ru>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
