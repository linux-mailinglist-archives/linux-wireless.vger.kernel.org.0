Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1BE5BB83B
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Sep 2022 14:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiIQMiJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Sep 2022 08:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIQMiI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Sep 2022 08:38:08 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491632C658
        for <linux-wireless@vger.kernel.org>; Sat, 17 Sep 2022 05:38:07 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1oZX56-0001bW-2x;
        Sat, 17 Sep 2022 14:38:01 +0200
Date:   Sat, 17 Sep 2022 13:37:58 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Stanislaw Gruszka <stf_xl@wp.pl>
Cc:     linux-wireless@vger.kernel.org,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH 04/15] rt2x00: add RF self TXDC calibration for MT7620
Message-ID: <YyW/pkcz/ZNFZu0S@makrotopia.org>
References: <YyUBN0F9t8GfTEQ3@makrotopia.org>
 <20220917123440.GC17901@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220917123440.GC17901@wp.pl>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Sep 17, 2022 at 02:34:40PM +0200, Stanislaw Gruszka wrote:
> On Sat, Sep 17, 2022 at 12:05:27AM +0100, Daniel Golle wrote:
> > From: Tomislav Požega <pozega.tomislav@gmail.com>
> > 
> > Add TX self calibration based on mtk driver.
> > 
> > Signed-off-by: Tomislav Požega <pozega.tomislav@gmail.com>
> 
> Daniel, this needs your Signed-off-by,
> 
> Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
> 
> > +	rt2800_rfcsr_write_bank(rt2x00dev, 5, 1, 0x4);
> > +	for (i = 0; i < 100; i = i + 1) {
> 
> Why not i++ ? :-) 

or even ++i. I'll fix that in v2.
