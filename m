Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784B37B5A60
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Oct 2023 20:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237137AbjJBSgH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Oct 2023 14:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjJBSgH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Oct 2023 14:36:07 -0400
X-Greylist: delayed 399 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 02 Oct 2023 11:36:00 PDT
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF64A4
        for <linux-wireless@vger.kernel.org>; Mon,  2 Oct 2023 11:35:59 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 24090 invoked from network); 2 Oct 2023 20:29:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1696271357; bh=VI4fzX4YCICatDCWN/gnAXNwMyEgPycD6CixKHOeY1Q=;
          h=From:To:Cc:Subject;
          b=UadFxh0Vsng7g9CQOAwbGJXuxy2cnMfWbJ18MPuJIs1J32k4SORM5LBgPT5JCgBZY
           B08s9F11v/k+Khf9azi5ei8eqSp1TmhPMkGpnNlR7Z/E6kv8iI+BviV4RAdmqoGQXk
           oaWxNM/wFreTsJ8TjT3Xlfq9Zl5AJ3afSN3wUXw0=
Received: from 89-64-13-175.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.13.175])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <kvalo@kernel.org>; 2 Oct 2023 20:29:17 +0200
Date:   Mon, 2 Oct 2023 20:29:17 +0200
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Shiji Yang <yangshiji66@outlook.com>,
        linux-wireless@vger.kernel.org,
        Helmut Schaa <helmut.schaa@googlemail.com>
Subject: Re: [PATCH] wifi: rt2x00: fix MT7620 low RSSI issue
Message-ID: <20231002182917.GA402943@wp.pl>
References: <TYAP286MB031571CDB146C414A908A66DBCFEA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
 <169591791433.3187104.10405094082972103919.kvalo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169591791433.3187104.10405094082972103919.kvalo@kernel.org>
X-WP-MailID: 83afd588398a90ebd16741158bf08128
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [YSPl]                               
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Sep 28, 2023 at 04:18:36PM +0000, Kalle Valo wrote:
> Shiji Yang <yangshiji66@outlook.com> wrote:
> 
> > On Mediatek vendor driver[1], MT7620 (RT6352) uses different RSSI
> > base value '-2' compared to the other RT2x00 chips. This patch
> > introduces the SoC specific base value to fix the low RSSI value
> > reports on MT7620.
> > 
> > [1] Found on MT76x2E_MT7620_LinuxAP_V3.0.4.0_P3 ConvertToRssi().
> > 
> > Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
> 
> Can someone review this, please?

Yes. Sorry for late response. 

I think patch is fine.
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>


> Patch set to Deferred.
> 
> -- 
> https://patchwork.kernel.org/project/linux-wireless/patch/TYAP286MB031571CDB146C414A908A66DBCFEA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM/
> 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
> 
