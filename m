Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447CC5BB846
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Sep 2022 14:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiIQMt5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Sep 2022 08:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiIQMt4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Sep 2022 08:49:56 -0400
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D3FDEA3
        for <linux-wireless@vger.kernel.org>; Sat, 17 Sep 2022 05:49:54 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 8234 invoked from network); 17 Sep 2022 14:49:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1663418992; bh=1Vcg09U1ZcxCQrUNQpLoG06n0inisd5otw3pZo7Vse8=;
          h=From:To:Cc:Subject;
          b=V397E0dkihsRPx79gKvqs2E1HlaVfnJkDjO0WWUNpw66J7XvTPI7VvKFaW8kiSikM
           5pwPHcgQNgeF8lQTn8j0E2uizkzPK52Slm+hfaT4tqNho0WifC+Cxfe/GhpyyQ7StW
           SROouBFhgYO+LSB7z/BfnbFaWMW9UNpGocw3avqY=
Received: from 89-64-7-128.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.7.128])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <daniel@makrotopia.org>; 17 Sep 2022 14:49:52 +0200
Date:   Sat, 17 Sep 2022 14:49:52 +0200
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
Subject: Re: [PATCH 13/15] rt2x00: set VGC gain for both chains of MT7620
Message-ID: <20220917124952.GF17901@wp.pl>
References: <YyUB1j7mxE4mPvMg@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyUB1j7mxE4mPvMg@makrotopia.org>
X-WP-MailID: c9db40a8c4d2d095f7db0c00d79404e2
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [gUN0]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Sep 17, 2022 at 12:08:06AM +0100, Daniel Golle wrote:
> Set bbp66 for all chains of the MT7620.
> 
> Reported-by: Serge Vasilugin <vasilugin@yandex.ru>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>


Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
