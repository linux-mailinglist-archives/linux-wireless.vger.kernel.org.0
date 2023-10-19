Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E397D011C
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Oct 2023 20:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344979AbjJSSDI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Oct 2023 14:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbjJSSDH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Oct 2023 14:03:07 -0400
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76E811B
        for <linux-wireless@vger.kernel.org>; Thu, 19 Oct 2023 11:03:05 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 45914 invoked from network); 19 Oct 2023 20:03:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1697738581; bh=Qm5p1QDBAZrWX9WpN2eiJO+Muvq3TRQrLTgtknHQqxM=;
          h=From:To:Cc:Subject;
          b=krNj2ic3qYuVAgDkl1/IlVuYcxJJnz0T/JLw6LHn6Dv76bC4A5r1hPpnmKZz73zOi
           UV/IobqSRW4shBw3BG3ge/KfRVUpEx/7ceoufumT2WeDsRb7zFa/5zy0Sa5LnTk9QK
           zYxs8Ue2wjXjWxyVXsIQXDqazju1hTQ9iu5KDMMM=
Received: from 89-64-13-175.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.13.175])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <yangshiji66@outlook.com>; 19 Oct 2023 20:03:01 +0200
Date:   Thu, 19 Oct 2023 20:03:01 +0200
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Shiji Yang <yangshiji66@outlook.com>
Cc:     linux-wireless@vger.kernel.org,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Kalle Valo <kvalo@kernel.org>
Subject: Re: [PATCH V2 2/3] wifi: rt2x00: rework MT7620 channel config
 function
Message-ID: <20231019180301.GC512047@wp.pl>
References: <20231019115859.2791-1-yangshiji66@outlook.com>
 <TYAP286MB0315622A4340BFFA530B1B86BCD4A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYAP286MB0315622A4340BFFA530B1B86BCD4A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-WP-MailID: e86e911c34ef01366fee6e1ec4f3c617
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [oQMB]                               
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

On Thu, Oct 19, 2023 at 07:58:57PM +0800, Shiji Yang wrote:
> 1. Move the channel configuration code from rt2800_vco_calibration()
>    to the rt2800_config_channel().
> 2. Use MT7620 SoC specific AGC initial LNA value instead of the
>    RT5592's value.
> 3. BBP{195,196} pairing write has been replaced with
>    rt2800_bbp_glrt_write() to reduce redundant code.
> 
> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
