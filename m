Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B726E4AC7
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 16:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjDQOGO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 10:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjDQOGK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 10:06:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5E5AD12
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 07:05:38 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1poPU7-0004iG-Op; Mon, 17 Apr 2023 16:05:35 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1poPU7-0007MY-F1; Mon, 17 Apr 2023 16:05:35 +0200
Date:   Mon, 17 Apr 2023 16:05:35 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-wireless <linux-wireless@vger.kernel.org>
Cc:     Hans Ulli Kroll <linux@ulli-kroll.de>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Pkshih <pkshih@realtek.com>, Tim K <tpkuester@gmail.com>,
        "Alex G ." <mr.nuke.me@gmail.com>,
        Nick Morrow <morrownr@gmail.com>,
        Viktor Petrenko <g0000ga@gmail.com>,
        Andreas Henriksson <andreas@fatal.se>,
        ValdikSS <iam@valdikss.org.ru>, kernel@pengutronix.de
Subject: Re: [PATCH v3 0/4] RTW88 USB bug fixes
Message-ID: <20230417140535.GO15436@pengutronix.de>
References: <20230417140134.2237428-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417140134.2237428-1-s.hauer@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Apr 17, 2023 at 04:01:30PM +0200, Sascha Hauer wrote:
> Third round of the RTW88 USB bug fixes.
> 
> After some discussion and thinking I came to the conclusion that the
> v1 variant of "wifi: rtw88: rtw8821c: Fix rfe_option field width" is
> better than the one posted in v2, so I reverted back to this version,
> but added a note to the commit message why this might not be entirely
> correct for all chip variants (though for all variants currently
> supported in the driver).
> 
> The patches are sorted in order of importance. 1/4 hasn't seen any
> negative comments and I think it should be applied right now.
> As stated above I think 2/4 should be applied as well. 3/4 fixes
> something I stumbled upon while reading in the vendor driver, but
> I don't what effect it actually has, I didn't notice any change
> in behaviour of the driver. 4/4 straightens the logic how
> rtw8821c_switch_rf_set() is called for different variants of the
> rtw8821c. This is taken from the vendor driver. From the supported
> chip variants this should only have an effect on the ones with
> rfe_option = 6, but I don't have that one available here for
> testing.
> 
> I would be glad if at least 1/4 and 2/4 could be applied as these
> fix real issues in the driver.

Please ignore. There was a typo in Larrys email address, I am resending
the whole series.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
