Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EB57D0106
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Oct 2023 19:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345222AbjJSRz7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Oct 2023 13:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235486AbjJSRz5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Oct 2023 13:55:57 -0400
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BAAE8
        for <linux-wireless@vger.kernel.org>; Thu, 19 Oct 2023 10:55:55 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 3138 invoked from network); 19 Oct 2023 19:55:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1697738152; bh=tOeU8Gr+pCXMizoG1xqv7ZP3zYUQybkXw1dZBZOOFJk=;
          h=From:To:Cc:Subject;
          b=TlyiNPhYW7/d/35c440HfAN3Ib97Io7A+WIZoZgHVGwymMTXN/8J+KP0Hm6RiV10J
           gbn99DyKj0dFuyx8tOtAMwl3S7C4g3+LZD1XZ5XJdS7HLYYtYzsD04zVmwVvasbLcH
           GWM/beRz6F2e4NDvgyPMmnpckYIH8ceQIlI+kOoo=
Received: from 89-64-13-175.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.13.175])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <yangshiji66@outlook.com>; 19 Oct 2023 19:55:52 +0200
Date:   Thu, 19 Oct 2023 19:55:51 +0200
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Shiji Yang <yangshiji66@outlook.com>
Cc:     linux-wireless@vger.kernel.org,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Kalle Valo <kvalo@kernel.org>
Subject: Re: [PATCH V2 1/3] wifi: rt2x00: improve MT7620 register
 initialization
Message-ID: <20231019175551.GB512047@wp.pl>
References: <20231019115859.2791-1-yangshiji66@outlook.com>
 <TYAP286MB031553CCD4B7A3B89C85935DBCD4A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYAP286MB031553CCD4B7A3B89C85935DBCD4A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-WP-MailID: cccd5f950d76bba8aac8fac418ab862d
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [kYMh]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Oct 19, 2023 at 07:58:56PM +0800, Shiji Yang wrote:
> 1. Do not hard reset the BBP. We can use soft reset instead. This
>    change has some help to the calibration failure issue.
> 2. Enable falling back to legacy rate from the HT/RTS rate by
>    setting the HT_FBK_TO_LEGACY register.
> 3. Implement MCS rate specific maximum PSDU size. It can improve
>    the transmission quality under the low RSSI condition.
> 4. Set BBP_84 register value to 0x19. This is used for extension
>    channel overlapping IOT.
> 
> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
