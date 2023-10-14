Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B197C95CC
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Oct 2023 19:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbjJNRyg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 14 Oct 2023 13:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjJNRyf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 14 Oct 2023 13:54:35 -0400
Received: from mx3.wp.pl (mx1.wp.pl [212.77.101.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA7AAD
        for <linux-wireless@vger.kernel.org>; Sat, 14 Oct 2023 10:54:31 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 13960 invoked from network); 14 Oct 2023 19:54:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1697306069; bh=NukBglDcBg34rJf8zBv5U1sDcjX8ryp9q2A7p1l2Gqw=;
          h=From:To:Cc:Subject;
          b=kZa2EyegjMQeeabjvbKx39VyR7KFfkbOO0FwCcqAK9FBUSqJLZ6D7WwCXtHJlQAoT
           8S806yHe4knpXoJWDKjPuUpYiofAHJIhHjrqCuINgtnYqzHjPR2gaggxqtHFLmhcOe
           9kl6oTL8QX5CQNMpCsBAxJADQefbL/+WsmdEo3PI=
Received: from 89-64-13-175.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.13.175])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <yangshiji66@outlook.com>; 14 Oct 2023 19:54:28 +0200
Date:   Sat, 14 Oct 2023 19:54:28 +0200
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Shiji Yang <yangshiji66@outlook.com>
Cc:     linux-wireless@vger.kernel.org,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Kalle Valo <kvalo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: [PATCH 0/3] wifi: rt2x00: various improvements for MT7620
 initialization
Message-ID: <20231014175428.GA477888@wp.pl>
References: <TYAP286MB03159DF41F754CB4F3AA4566BCD2A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYAP286MB03159DF41F754CB4F3AA4566BCD2A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-WP-MailID: 2e762d83e502cf2c0a5a93328347121f
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000001 [IcLN]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Oct 14, 2023 at 07:21:27AM +0800, Shiji Yang wrote:
> This series patches aim to improve the initialization of MT7620. All
> changes and register values were ported from the Mediatek vendor
> driver, and I have been testing them on OpenWrt for several weeks.

Hi Shiji!

Thank you for improving MT7620 support in rt2x00!
Your patches generally look ok to me.

I would suggest however consider to move support of MT7620 to
mt76 driver. It's much nicer and better written driver with
better mac80211/linux integration and support of various
features that rt2x00 lacks. Adding mt7620 sub-driver there
should not be that hard, and would be much "cooler" project
for you in my opinion.

This of course depend of how much time do you have to work
on this. Tweaking/improving rt2x00 can be easier and faster
way to achieve your goals and I don't want discourage 
you from doing this, if that's something you prefer.
Keep good work!

Regards
Stanislaw
