Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B665BB873
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Sep 2022 15:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiIQNYw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Sep 2022 09:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiIQNYt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Sep 2022 09:24:49 -0400
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35FB13D3A
        for <linux-wireless@vger.kernel.org>; Sat, 17 Sep 2022 06:24:48 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 26636 invoked from network); 17 Sep 2022 15:24:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1663421086; bh=L/Ib9qp7V2nve3A7oBpmoG1s3NtVBHSLkJxA9UMRlXc=;
          h=From:To:Cc:Subject;
          b=YzZtsD6KyPv5QESVxCCPDeRf/R+2SzU8d8o9NybJnqnER86IIkxPpuaB7Dy9nqDsa
           q3ZppBdWX/KO+VCT2J10POzid+Pk01MW7+anvKtjK+henbZVm1L/kiWH/y9I3GVGRN
           zEYMEy8dDxaqtMeGhMyI2LYNxmVbR4KGHZxA5lrY=
Received: from 89-64-7-128.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.7.128])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <daniel@makrotopia.org>; 17 Sep 2022 15:24:46 +0200
Date:   Sat, 17 Sep 2022 15:24:45 +0200
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
Subject: Re: [PATCH 00/15] rt2x00: OpenWrt patches improving MT7620
Message-ID: <20220917132445.GO17901@wp.pl>
References: <YyUA3Xbhe7/RSjGz@makrotopia.org>
 <20220917131733.GM17901@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220917131733.GM17901@wp.pl>
X-WP-MailID: 8c917482b4030068441b469854ca3293
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [QTP0]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Sep 17, 2022 at 03:17:35PM +0200, Stanislaw Gruszka wrote:
> On Sat, Sep 17, 2022 at 12:03:57AM +0100, Daniel Golle wrote:
> > Over the years we have been accumulating a number of patches improving
> > support for the IEEE 802.11bgn 2T2R wireless interface built into the
> > MediaTek MT7620 MIPS SoCs. Many of them have not been in shape for
> > being submitted to Linux and changes were needed to make checkpatch.pl
> > all happy. Now they look as good as it gets, given that most code deals
> > with undocumented registers and was adapted from the vendor driver.
> > 
> > Patch 1/1 also has been previously submitted and then (imho wrongly)
> >rejected, so I've included it in this series.
> 
> In general this looks good. Some calibration functions are just too
> big, but we can eventually take them and refactor in the tree.
> Just please assure there are no compilation warnings and add
> yours signed-off by to all patches.

Also please configure git-send-email to send patches in one thread.

Thanks
Stanislaw
