Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B7A59C94B
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Aug 2022 21:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236874AbiHVTvz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Aug 2022 15:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbiHVTvy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Aug 2022 15:51:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975225281F
        for <linux-wireless@vger.kernel.org>; Mon, 22 Aug 2022 12:51:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47EAAB818B8
        for <linux-wireless@vger.kernel.org>; Mon, 22 Aug 2022 19:51:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2BADC433D6;
        Mon, 22 Aug 2022 19:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661197911;
        bh=u9YrRPHhMV3GOUUrXNUN/wB7qQ5g2cHMURkE3+Oms6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jH1bh6I5kL73sZPUg4OP9yxPPK2bD9pegISG0/XXuD4yuyuSafzblVuNXHgjmcRTP
         nYerYKgoF+lVPviYOA5KlFHsvfKoTxUndwJ5pX6ayiaP8ruLpcYol+g00Gwi/GsDDf
         JmkgNzDR+FLYk7OQfbpCcqFuCeMrC8qzklT7uIYg=
Date:   Mon, 22 Aug 2022 21:51:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Magal Baz <mbaz@fb.com>
Cc:     "aspriel@gmail.com" <aspriel@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>
Subject: Re: Vulnerabilities in the brcmfmac driver
Message-ID: <YwPeVBeohpcd06A0@kroah.com>
References: <97D835D2-29C5-4C86-8602-4C02C61DB28C@fb.com>
 <YwPaASokqw0eunUj@kroah.com>
 <03D5D6F4-4471-4379-BF53-464DAA37C4B2@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03D5D6F4-4471-4379-BF53-464DAA37C4B2@fb.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Aug 22, 2022 at 07:43:14PM +0000, Magal Baz wrote:
> Hi Greg, Valid points, my bad :)
> 
> Please see the details below as textt:

<snip>

Also note that Linux kernel drivers trust the hardware for the most
part.  If you can get control over a spi or spio bus, then of course all
bets are off, that is not the Linux security model at all.  So if you
care about invalid data on that bus, please work on auditing and fixing
up all kernel drivers for that subsystem as this is a totally new threat
model that no one has ever handled for this operating system (and one
that no one ever said we were secure from.)

thanks,

greg k-h
