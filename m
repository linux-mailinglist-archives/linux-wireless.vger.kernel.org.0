Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4786D0B75
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Mar 2023 18:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjC3Qh7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Mar 2023 12:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjC3Qh6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Mar 2023 12:37:58 -0400
X-Greylist: delayed 416 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Mar 2023 09:37:57 PDT
Received: from mail.w1.fi (mail.w1.fi [IPv6:2a01:7e00::f03c:91ff:fedb:30e2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2021172A3
        for <linux-wireless@vger.kernel.org>; Thu, 30 Mar 2023 09:37:56 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.w1.fi (Postfix) with ESMTP id 92F1911134;
        Thu, 30 Mar 2023 16:30:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at w1.fi
Received: from mail.w1.fi ([127.0.0.1])
        by localhost (mail.w1.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SZLsVuZvsI6R; Thu, 30 Mar 2023 16:30:23 +0000 (UTC)
Received: by jm (sSMTP sendmail emulation); Thu, 30 Mar 2023 19:30:21 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=w1.fi; s=default;
        t=1680193823; bh=ICBjYtEAwUGNp+Uwsk/p1WidSLqiz+PXLRerVHbTrEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g6uJr9d2lDYUBKO+IM0/8TaQ+xcBOlRSKmfwVU6JxAdUdJ40RZ410kNuQzbjcjdPh
         +ExfoJo3xW7WOQZlnH9HPPMxvpILA9qR9Pw9xg65zdIhtUeG9TPMsabdWHHwIUnUO6
         bL5+zfGjlrvsU63XHTb5EH9NOBHxUHBjLdi9Ui2gHvF0joFta6mG8Pbr34IK1nsla/
         9reFSMCertHHi4d9lFGzODpmtFsd7bOHOUrSV49G3T5oJHgyy8pJQWqBZ8SfyAzjun
         0VObMD6d2aI0j7E0rrITbLLIcBS/ejmxyRVPijTiikEykzt7GdZi4BBs3GpDl2mMCn
         Y1y4Hi5V+ESRA==
Date:   Thu, 30 Mar 2023 19:30:21 +0300
From:   Jouni Malinen <j@w1.fi>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Veerendranath Jakkam <quic_vjakkam@quicinc.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] nl80211: Add support to configure allowed frequency list
 for AP operation
Message-ID: <ZCW5HVMLHHW2bzKW@w1.fi>
References: <20230328093105.3640436-1-quic_vjakkam@quicinc.com>
 <421e93d78deda5ac9e62c58ee275758a3355a503.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421e93d78deda5ac9e62c58ee275758a3355a503.camel@sipsolutions.net>
X-Spam-Status: No, score=4.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,RCVD_IN_XBL,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Mar 28, 2023 at 11:42:17AM +0200, Johannes Berg wrote:
> On Tue, 2023-03-28 at 15:01 +0530, Veerendranath Jakkam wrote:
> > Add support to configure the list of allowed 20 MHz channels for AP
> > operation using an array of channel center frequencies in MHz, this
> > configuration is valid until the AP is stopped. Driver shall filter out
> > channels on top of this list of channels based on regulatory or other
> > constraints during channel switch etc. Driver shall stop the AP
> > operation if all the channels are filtered out during such operation.
> 
> Normally hostapd is doing anything related to the channel picking, so
> you need to explain why this is needed.

hostapd does this for many cases, but there are drivers, including a
couple of the upstream drivers, that select a channel internally for
channel switch cases. Those would be able to use this information. Is
that of sufficient generic interest or do you prefer vendor commands to
be used for such functionality?

-- 
Jouni Malinen                                            PGP id EFC895FA
