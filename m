Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87D27F0982
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Nov 2023 23:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjKSW7a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Nov 2023 17:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKSW73 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Nov 2023 17:59:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6491312D
        for <linux-wireless@vger.kernel.org>; Sun, 19 Nov 2023 14:59:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2373C433C7;
        Sun, 19 Nov 2023 22:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700434766;
        bh=a8y7BCPGpWZ4azsUSnWEda0HJ2LmZLWegB7VygunxCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bJh2SqQEaerJlQiKZxmUAS2bHiAJdkxghEtR7KXTxwR9fR9/Oa3EkpepPKINQtN7d
         WAByXCgCb4HWY3Vnx+g6vj5FkFY3/wvfNs+hb0FgSKii1K2ky9M8A/caoDHd3N4KwY
         JdobaOxpYwMpT3CdG3uOf8HFfB6UYqrcmLn7iMR3p/FLsO6beSZaAnR02Vsh7x57DD
         Hadkz+H73aBUI3qDM89vAraKhM3PW5chWQDk564l1LGeVu606clxwIXX5VyqZ+q6yT
         TU+j9/lZcgqvsUrVAAqMDsYHsUwct/tvcIfu1KIWXuwV0TMAW9LqCOAxXXZ8CX8IM3
         HLUZsATcpuW6A==
Date:   Sun, 19 Nov 2023 16:59:24 -0600
From:   Seth Forshee <sforshee@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Chen-Yu Tsai <wens@kernel.org>, wireless-regdb@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: [wireless-regdb] [ANN] wireless-regdb: master-2023-09-01
Message-ID: <ZVqTTC2rqNpKHptJ@ubuntu-x1>
References: <ZPJF1/2YA4dP+ggY@ubuntu-x1>
 <CAGb2v657baNMPKU3QADijx7hZa=GUcSv2LEDdn6N=QQaFX8r-g@mail.gmail.com>
 <ZUAUahZakEvOXpip@do-x1extreme>
 <CAGb2v66cVj2O89G9qhKCqca+jyBK9ic3866giL=LZX4mQo-eDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGb2v66cVj2O89G9qhKCqca+jyBK9ic3866giL=LZX4mQo-eDg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Oct 31, 2023 at 05:32:15PM +0800, Chen-Yu Tsai wrote:
> > Johannes will be the one who needs to accept your key into the kernel,
> > so we should wait for a +1 from him at least before we really get the
> > ball rolling.
> 
> +Johannes for his opinion.

Johannes, we haven't heard from you. Let us know if you have any
objections, otherwise I'm going to start moving forward on this.

Thanks,
Seth
