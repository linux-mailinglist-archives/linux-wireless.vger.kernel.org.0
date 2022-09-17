Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26FD5BB84D
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Sep 2022 14:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiIQMyR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Sep 2022 08:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiIQMyQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Sep 2022 08:54:16 -0400
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130652B182
        for <linux-wireless@vger.kernel.org>; Sat, 17 Sep 2022 05:54:15 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 5571 invoked from network); 17 Sep 2022 14:54:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1663419253; bh=qtS5Rog7DVjVuHU+A5qf1SikFi++ermNXjX3nBfT5Qs=;
          h=From:To:Cc:Subject;
          b=brhMUf6FYeO0ZBKV/BK7mOSckZHVZ0zFAk1EsZeT37XjNS8Bj1AGrOn8mVDY/1+Q6
           XbvEqSL0eREM8Tgj9WF9QhbtNfI/Xgkga7Kg27iUQDMQqxFfez9xuDo5RGp/c+rmuy
           Hbm/VRGMjt/bRlycksh/VQSYi9uPjO9OGcLAry+U=
Received: from 89-64-7-128.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.7.128])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <daniel@makrotopia.org>; 17 Sep 2022 14:54:13 +0200
Date:   Sat, 17 Sep 2022 14:54:13 +0200
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
Subject: Re: [PATCH 10/15] rt2x00: move helper functions up in file
Message-ID: <20220917125413.GJ17901@wp.pl>
References: <YyUBox9ZFftKHXkD@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyUBox9ZFftKHXkD@makrotopia.org>
X-WP-MailID: e33158c5505e8fcaf196dc7dd6a63278
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [IVN0]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Sep 17, 2022 at 12:07:15AM +0100, Daniel Golle wrote:
> Move register access helper functions up to the head of the file so
> they can be used in all functions.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
