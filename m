Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA6D7D011D
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Oct 2023 20:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345115AbjJSSEB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Oct 2023 14:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235508AbjJSSEA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Oct 2023 14:04:00 -0400
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE285121
        for <linux-wireless@vger.kernel.org>; Thu, 19 Oct 2023 11:03:58 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 4986 invoked from network); 19 Oct 2023 20:03:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1697738634; bh=jFJKM44kzxNqO5djZFtzUuwBdBC81OGEReCz1MBC1n0=;
          h=From:To:Cc:Subject;
          b=cQKDMwuCuYAGdR7j1aL47JCjVCxx8aP0jKdO0nXIzyIot0jud+Cgz13jDgCoa3xP8
           C2KihJ0aHRO8x9cJ7WnKGsaYWToxRqFGSyXV7OjMrlw3c/x9ZWJSNqrFm78lcIskzc
           oM1YzXWrVJmOR+exBzRZGc5ZLAzY+2J/XtJNJ2no=
Received: from 89-64-13-175.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.13.175])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <yangshiji66@outlook.com>; 19 Oct 2023 20:03:54 +0200
Date:   Thu, 19 Oct 2023 20:03:54 +0200
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Shiji Yang <yangshiji66@outlook.com>
Cc:     linux-wireless@vger.kernel.org,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Kalle Valo <kvalo@kernel.org>
Subject: Re: [PATCH V2 3/3] wifi: rt2x00: rework MT7620 PA/LNA RF calibration
Message-ID: <20231019180354.GD512047@wp.pl>
References: <20231019115859.2791-1-yangshiji66@outlook.com>
 <TYAP286MB0315979F92DC563019B8F238BCD4A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYAP286MB0315979F92DC563019B8F238BCD4A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-WP-MailID: 74f1861177d7f52fb4a9571e8fa60fc3
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [oTMh]                               
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

On Thu, Oct 19, 2023 at 07:58:58PM +0800, Shiji Yang wrote:
> 1. Move MT7620 PA/LNA calibration code to dedicated functions.
> 2. For external PA/LNA devices, restore RF and BBP registers before
>    R-Calibration.
> 3. Do Rx DCOC calibration again before RXIQ calibration.
> 4. Add some missing LNA related registers' initialization.
> 
> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
