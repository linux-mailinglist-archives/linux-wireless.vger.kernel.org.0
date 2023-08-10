Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D50B77755F
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Aug 2023 12:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbjHJKGd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Aug 2023 06:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235289AbjHJKGC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Aug 2023 06:06:02 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015CC2735
        for <linux-wireless@vger.kernel.org>; Thu, 10 Aug 2023 03:05:55 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 47CD521226;
        Thu, 10 Aug 2023 12:05:53 +0200 (CEST)
Date:   Thu, 10 Aug 2023 12:05:48 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     David Lin <yu-hao.lin@nxp.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: Re: [PATCH v3] wifi: mwifiex: added code to support host mlme.
Message-ID: <ZNS2fEOt1CXLrWLf@francesco-nb.int.toradex.com>
References: <DU0PR04MB963607ADBFC49C7AB713092DD113A@DU0PR04MB9636.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB963607ADBFC49C7AB713092DD113A@DU0PR04MB9636.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Aug 10, 2023 at 02:39:21AM +0000, David Lin wrote:
> 1. For station mode first.
> 2. This feature is a must for WPA3.
> 3. Firmware version 2 is needed for this feature.
> 4. The code is only enabled and tested with IW416.
> 5. This feature is disabled for other chips.
> 
> Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> ---

please run ./scripts/get_maintainer.pl to be sure that the relevant
people receive this patch.

$ ./scripts/get_maintainer.pl --no-git-fallback --no-roles --no-rolestats drivers/net/wireless/marvell/mwifiex/
Brian Norris <briannorris@chromium.org>
Kalle Valo <kvalo@kernel.org>
linux-wireless@vger.kernel.org
linux-kernel@vger.kernel.org

