Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A5A7788AD
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Aug 2023 10:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbjHKIBA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Aug 2023 04:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbjHKIA7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Aug 2023 04:00:59 -0400
X-Greylist: delayed 81718 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Aug 2023 01:00:59 PDT
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0417B1FD3
        for <linux-wireless@vger.kernel.org>; Fri, 11 Aug 2023 01:00:58 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 60AA0206D9;
        Fri, 11 Aug 2023 10:00:57 +0200 (CEST)
Date:   Fri, 11 Aug 2023 10:00:55 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     David Lin <yu-hao.lin@nxp.com>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: Re: [EXT] Re: [PATCH v3] wifi: mwifiex: added code to support host
 mlme.
Message-ID: <ZNXqt62xMQFQh16o@francesco-nb.int.toradex.com>
References: <DU0PR04MB963607ADBFC49C7AB713092DD113A@DU0PR04MB9636.eurprd04.prod.outlook.com>
 <ZNSrYEJ9m0jO/WU9@francesco-nb.int.toradex.com>
 <PA4PR04MB9638C1DB606524BD57AB59CED113A@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZNTzMrjfauSJN1ym@francesco-nb.int.toradex.com>
 <PA4PR04MB9638C81BE986779C9512E262D110A@PA4PR04MB9638.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR04MB9638C81BE986779C9512E262D110A@PA4PR04MB9638.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Aug 11, 2023 at 02:13:43AM +0000, David Lin wrote:
> > From: Francesco Dolcini <francesco@dolcini.it>
> > Sent: Thursday, August 10, 2023 10:25 PM
> > To: David Lin <yu-hao.lin@nxp.com>
> > Cc: Francesco Dolcini <francesco@dolcini.it>; linux-wireless@vger.kernel.org;
> > Sharvari Harisangam <sharvari.harisangam@nxp.com>; Pete Hsieh
> > <tsung-hsien.hsieh@nxp.com>
> > Subject: Re: [EXT] Re: [PATCH v3] wifi: mwifiex: added code to support host
> > mlme.
> > 
> > Caution: This is an external email. Please take care when clicking links or
> > opening attachments. When in doubt, report the message using the 'Report
> > this email' button
> > 
> > 
> > On Thu, Aug 10, 2023 at 10:51:36AM +0000, David Lin wrote:
> > > > From: Francesco Dolcini <francesco@dolcini.it> On Thu, Aug 10, 2023
> > > > at 02:39:21AM +0000, David Lin wrote:
> > > > > 3. Firmware version 2 is needed for this feature.
> > > > That would mean that we could just enable it for other Wi-Fi chip
> > > > variant that has firmware version 2, after testing it?
> > > Yes. But I only tested with IW416.
> > 
> > Can/should we probe the firmware version at runtime, instead of hard-coding
> > this?
> 
> Firmware version is reported by firmware after firmware is downloaded.
What's the problem with that? You cannot really do anything till the
firmware is loaded?

If I understand correctly the possibility to use this feature requires
its counterpart to be available on the device firmware, this should be
the criteria to use to decide if this functionality should be enabled or
not. Hard-coding this depending on the actual device does not look
correct to me.

Francesco

