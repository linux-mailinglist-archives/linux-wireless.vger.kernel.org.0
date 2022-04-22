Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CC250B6D8
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Apr 2022 14:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444931AbiDVMK5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Apr 2022 08:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384839AbiDVMK4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Apr 2022 08:10:56 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F24856436;
        Fri, 22 Apr 2022 05:08:03 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id A22A180A8;
        Fri, 22 Apr 2022 12:05:08 +0000 (UTC)
Date:   Fri, 22 Apr 2022 15:08:01 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Yegor Yefremov <yegorslists@googlemail.com>
Cc:     Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-wireless@vger.kernel.org, sebastian.reichel@collabora.co.uk
Subject: Re: wl18xx: NVS file handling
Message-ID: <YmKaoRfxo4bMzDdR@atomide.com>
References: <CAGm1_ktEim1vGOf5i=H_sqrPvg=dT50790YYwXgYKgAut-a=ng@mail.gmail.com>
 <YmDpTAu9wmlLijDA@atomide.com>
 <CAGm1_kv+b1h1OuWr4w5jS_mqfQpXF7UexiWFsOSs+MJK546=ew@mail.gmail.com>
 <CAGm1_ksOt-JtOcTBG7wEqaHagx1NTGYXTMTOG40AN2RELqWKwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGm1_ksOt-JtOcTBG7wEqaHagx1NTGYXTMTOG40AN2RELqWKwg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

* Yegor Yefremov <yegorslists@googlemail.com> [220422 10:40]:
> Wouldn't we need this functionality [1] to make the NVS fw file optional? :-(
> 
> [1] https://patchwork.kernel.org/project/linux-dmaengine/patch/20181112160143.4459-1-l.stach@pengutronix.de/

Hmm yeah, how about if we use just an empty nvs file for no warnings then?

Regards,

Tony
