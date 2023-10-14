Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315727C95CE
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Oct 2023 19:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbjJNRzz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 14 Oct 2023 13:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbjJNRzy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 14 Oct 2023 13:55:54 -0400
Received: from mx3.wp.pl (mx1.wp.pl [212.77.101.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FE3AD
        for <linux-wireless@vger.kernel.org>; Sat, 14 Oct 2023 10:55:51 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 13601 invoked from network); 14 Oct 2023 19:55:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1697306149; bh=IviouoENiV3dIQX3le2G3hlEj85bbWI6cx7TYEfcPio=;
          h=From:To:Cc:Subject;
          b=m0nWIiKpn9jb2qRiAIIR3ppcZaLYQLbjJJCSZoKVtVx5drPDzj/6eN4PzTHm3+I1W
           lQxxJZecwUOvSlHxySMawx6xHJaDLIrgH+MFtWV3Ze/BhErzExTlemyuMPbsFOjaxM
           SmxMKxFS5jKKAUXZ6f3I7sRuKE4G4oLdv3WUVDcQ=
Received: from 89-64-13-175.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.13.175])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <yangshiji66@outlook.com>; 14 Oct 2023 19:55:49 +0200
Date:   Sat, 14 Oct 2023 19:55:48 +0200
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Shiji Yang <yangshiji66@outlook.com>
Cc:     linux-wireless@vger.kernel.org,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Kalle Valo <kvalo@kernel.org>
Subject: Re: [PATCH 3/3] wifi: rt2x00: rework MT7620 PA/LNA RF calibration
Message-ID: <20231014175548.GB477888@wp.pl>
References: <20231013232130.416-1-yangshiji66@outlook.com>
 <TYAP286MB031551F2B4A929484A35EF28BCD2A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYAP286MB031551F2B4A929484A35EF28BCD2A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-WP-MailID: b84589b2a147c8830702279fe2395879
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [EXMR]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Oct 14, 2023 at 07:21:30AM +0800, Shiji Yang wrote:
> 1. Move MT7620 PA/LNA calibration code to dedicated functions.
> 2. For external PA/LNA devices, restore RF and BBP registers before
>    R-Calibration.
> 3. Do Rx DCOC calibration again before RXIQ calibration.
> 4. Add some missing LNA related registers' initialization.
> 
> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
<snip>
>  int rt2800_enable_radio(struct rt2x00_dev *rt2x00dev)
>  {
>  	u32 reg;
> @@ -10762,6 +10831,10 @@ int rt2800_enable_radio(struct rt2x00_dev *rt2x00dev)
>  	rt2800_init_bbp(rt2x00dev);
>  	rt2800_init_rfcsr(rt2x00dev);
>  
> +	/* Do calibration and init PA/LNA for RT6352 */
> +	if (rt2x00_rt(rt2x00dev, RT6352))
> +		rt2800_calibration_rt6352(rt2x00dev);
rt2800_init_rcsr() -> rt2800_init_rfcsr_6352() is called right
before this. Could we have rt2800_calibration_rt6352() there ? 

Regards
Stanislaw
