Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3BB7DDDE8
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Nov 2023 09:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbjKAIxb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Nov 2023 04:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbjKAIxa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Nov 2023 04:53:30 -0400
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A93DF
        for <linux-wireless@vger.kernel.org>; Wed,  1 Nov 2023 01:53:23 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 9182 invoked from network); 1 Nov 2023 09:53:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1698828800; bh=wLT0rwgC43vbG5NaF/yffaV2Y8VjMiFfnQYK7YpD/lw=;
          h=From:To:Cc:Subject;
          b=jQwsMoTliUYkhGgkTf0R3yAPwvoolIKKdYxU5CFcBFBwr9oB+8Ia1ciB2kt1zF3SX
           Lea46Rm2jisip6x/R3zgRonvJt/Y6loDpkBZWI8PNOrapWMsZm/9JTPllUZNWJBVvc
           7GNfNJKogNgwpnct8QhPM9SItVyLYatT6Znr5pBU=
Received: from 89-64-13-175.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.13.175])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <yangshiji66@outlook.com>; 1 Nov 2023 09:53:20 +0100
Date:   Wed, 1 Nov 2023 09:53:20 +0100
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Shiji Yang <yangshiji66@outlook.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: Re: [PATCH 2/3] wifi: rt2x00: disable RTS threshold for rt2800 by
 default
Message-ID: <20231101085320.GA552433@wp.pl>
References: <20231028121532.5397-1-yangshiji66@outlook.com>
 <TYAP286MB0315DBC21F89552F7D235E56BCA3A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYAP286MB0315DBC21F89552F7D235E56BCA3A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-WP-MailID: b04c4d46c66ff06cfbe8c0ba36e6fb3c
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [QSNE]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Oct 28, 2023 at 08:15:31PM +0800, Shiji Yang wrote:
> Disable the RTS threshold for OFDM and CCK rates by default as the
> initial RTS threshold is 'IEEE80211_MAX_RTS_THRESHOLD'. And RTS
> thresholds for all other rates have already been disabled when init.
> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
