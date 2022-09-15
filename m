Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C905BA10B
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Sep 2022 20:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiIOS4Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Sep 2022 14:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiIOS4O (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Sep 2022 14:56:14 -0400
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4620A3CBE4
        for <linux-wireless@vger.kernel.org>; Thu, 15 Sep 2022 11:56:12 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 30133 invoked from network); 15 Sep 2022 20:56:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1663268169; bh=/kZNb5DNcT8xTO7N7vLzj5Lbw+oKmWuyq0FnzqOHWCo=;
          h=From:To:Cc:Subject;
          b=nw+9uXWfEXk1XFlGurG8fvqbjyLbTOPX5S7RDZZpQqyjdq4Fhw4zpDGvIG6V7j38v
           ZwQBmksWDjV246ZCBCa4wCDNa2se7DimHnq1RgyurGa3Her+YkPMGTSBySamAhA4kO
           3PHn2/FlCdX7q3l0TgArzcrdPK5bsKSeJZ9V9Ia8=
Received: from 89-64-7-128.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.7.128])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <hdegoede@redhat.com>; 15 Sep 2022 20:56:09 +0200
Date:   Thu, 15 Sep 2022 20:56:08 +0200
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Helmut Schaa <helmut.schaa@googlemail.com>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/1] wifi: rt2x00: Fix "Error - Attempt to send packet
 over invalid queue 2"
Message-ID: <20220915185608.GA10590@wp.pl>
References: <20220908173618.155291-1-hdegoede@redhat.com>
 <20220908173618.155291-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908173618.155291-2-hdegoede@redhat.com>
X-WP-MailID: 0cf9e79b1ff8969f4ecab3c8f3fb0e5f
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [AfMx]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Sep 08, 2022 at 07:36:18PM +0200, Hans de Goede wrote:
> Even though ieee80211_hw.queues is set to 2, the ralink rt2x00 driver
> is seeing tx skbs submitted to it with the queue-id set to 2 / set to
> IEEE80211_AC_BE on a rt2500 card when associating with an access-point.

I'm impressed you have still working rt2500 card :-)
 
> This causes rt2x00queue_get_tx_queue() to return NULL and the following
> error to be logged: "ieee80211 phy0: rt2x00mac_tx: Error - Attempt to
> send packet over invalid queue 2", after which association with the AP
> fails.
> 
> This patch works around this by mapping QID_AC_BE and QID_AC_BK
> to QID_AC_VI when there are only 2 tx_queues.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
