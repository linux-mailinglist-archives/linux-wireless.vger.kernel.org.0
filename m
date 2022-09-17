Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229EF5BB847
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Sep 2022 14:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiIQMub (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Sep 2022 08:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiIQMua (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Sep 2022 08:50:30 -0400
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D75D1FCC5
        for <linux-wireless@vger.kernel.org>; Sat, 17 Sep 2022 05:50:29 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 17781 invoked from network); 17 Sep 2022 14:50:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1663419027; bh=XGIp728TAfSKLSEYxR8GyYq8BG9KI/+iKBGqxp69B6M=;
          h=From:To:Cc:Subject;
          b=g9xIivJRFjwbFo/Qcq1VBUGpXuUIXUz8UHhgrLqITXMsxFO0cAyLUtXfD+jT5L14G
           C+fa0jmZzJ+Gvf0g7SJ2OzKuZSwzZXY0DMHVt7UlsaiCeOf43htjLLH3ZxxIzFroc+
           v/4qT/n2aIvaaOL0MvFA2zh45iydOLW2wFM5ylkM=
Received: from 89-64-7-128.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.7.128])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <daniel@makrotopia.org>; 17 Sep 2022 14:50:27 +0200
Date:   Sat, 17 Sep 2022 14:50:26 +0200
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
Subject: Re: [PATCH 14/15] rt2x00: set SoC wmac clock register
Message-ID: <20220917125026.GG17901@wp.pl>
References: <YyUB79Kn6tQNylEB@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyUB79Kn6tQNylEB@makrotopia.org>
X-WP-MailID: c74de11078c5a4c0b09a93d110aa2880
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [kbP0]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Sep 17, 2022 at 12:08:31AM +0100, Daniel Golle wrote:
> Instead of using the default value 33 (pci), set US_CYC_CNT init based
> on Programming guide:
> If available, set chipset bus clock with fallback to cpu clock/3.
> 
> Reported-by: Serge Vasilugin <vasilugin@yandex.ru>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
