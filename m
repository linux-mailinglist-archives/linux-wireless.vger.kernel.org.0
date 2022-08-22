Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC45959C946
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Aug 2022 21:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237505AbiHVTuI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Aug 2022 15:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237501AbiHVTuG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Aug 2022 15:50:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A424F18C
        for <linux-wireless@vger.kernel.org>; Mon, 22 Aug 2022 12:50:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F5B461233
        for <linux-wireless@vger.kernel.org>; Mon, 22 Aug 2022 19:50:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C062C433D6;
        Mon, 22 Aug 2022 19:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661197801;
        bh=EL6KkZ7ncjaKALhAwhZGJntxdgCfYFL/9uDOMCsh49s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rbez1CIVh/TAwoMpjVW24ReddQ3DV77OywEsbaP2T9mnkhtMmXeNLY8yp12fOTosq
         b3wBMmuZxyVA07sk3uK/PffiJoFcm1Ei+X/NhnmTujt2efi3YRxNd1jNX6oPgBcnEC
         g6RSi+CGLRHIwxLCD+LTBGLBvKATnm9zAcZwIVZo=
Date:   Mon, 22 Aug 2022 21:49:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Magal Baz <mbaz@fb.com>
Cc:     "aspriel@gmail.com" <aspriel@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>
Subject: Re: Vulnerabilities in the brcmfmac driver
Message-ID: <YwPd5hvD0zfOz7iv@kroah.com>
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

html email is rejected by the public mailing lists, please fix your
email client :(

Anyway, just submit patches for these issues, nothing new or special
about them, no need to try to lump a bunch of different things all in
one long email without wrapped lines...

thanks,

greg k-h
