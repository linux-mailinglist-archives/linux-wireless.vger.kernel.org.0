Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F48044AD1D
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Nov 2021 13:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237681AbhKIMK0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Nov 2021 07:10:26 -0500
Received: from mx4.wp.pl ([212.77.101.12]:4971 "EHLO mx4.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236479AbhKIMKZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Nov 2021 07:10:25 -0500
Received: (wp-smtpd smtp.wp.pl 9402 invoked from network); 9 Nov 2021 13:07:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1636459657; bh=x8vezP+ySAQMzU4aH5GB9K9Xh+JMJ6//MlNYqk14zok=;
          h=From:To:Cc:Subject;
          b=k+P4M5FgvLpAcMCfITZmyobD4N5nuaymyVw2Fa3w7bNV2kfg6ZlzGLyokZ38Q1z67
           mmN3OgarorLXdHDDEVTUdu56haV9lyaRttndZyqvAKuOqZd4rkqzabk0+aHcGDuOzh
           1IIvg+rI+VxEsWpgbSidKyHX2rZ9KlmMbqZsrPtI=
Received: from 89-64-85-14.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.85.14])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <regressions@leemhuis.info>; 9 Nov 2021 13:07:37 +0100
Date:   Tue, 9 Nov 2021 13:07:37 +0100
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Stanislaw Gruszka <sgruszka@redhat.com>,
        linux-wireless@vger.kernel.org,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        regressions@lists.linux.dev, Kalle Valo <kvalo@codeaurora.org>,
        Exuvo <exuvo@exuvo.se>
Subject: Re: rt2x00 regression
Message-ID: <20211109120737.GA120005@wp.pl>
References: <CA+GwT0B5SyRZnGLqwqOeuJK4CWMVc=dKaWre9VN8KQC6kBzKGw@mail.gmail.com>
 <20191203075736.GA701@redhat.com>
 <d74dab51-3a84-9035-d89e-ea8f63e89198@exuvo.se>
 <a8eeb0bc-95da-291a-7fb9-5d15d1174c27@exuvo.se>
 <c22673af-40e0-3af2-5ab7-69b23fc03598@exuvo.se>
 <f935dc15-08bd-2e28-fc1b-b27634c618be@exuvo.se>
 <87czop5j33.fsf@tynnyri.adurom.net>
 <6366d9bd-9752-dbc2-8970-442bdc6e8eea@leemhuis.info>
 <7d353dd2-2ffb-6d5e-9983-f983c8b4f6da@leemhuis.info>
 <20211109073127.GA109212@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109073127.GA109212@wp.pl>
X-WP-MailID: 1d59ce342643a1460894678b87309333
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [ocO0]                               
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Nov 09, 2021 at 08:32:07AM +0100, Stanislaw Gruszka wrote:
> On Mon, Nov 08, 2021 at 07:00:20PM +0100, Thorsten Leemhuis wrote:
> > Sending this again, but this time also to Stanislaw's email address
> > currently found in MAINTAINERS.
> >
> > Stanislaw, can you help with this regression?
> 
> Yes. 
> 
> I'll check on mail archives what is the status and what can be done.

Ok, so what I can see here  
https://lore.kernel.org/linux-wireless/20211109073127.GA109212@wp.pl/T/#m6a677995c1afaf6b9b1ff19de9566f304089d3ac
is that this problem happen only on firmware load,
so I think we can use below patch as fix.

Anton, please test it.

Thanks
Stanislaw

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c b/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
index e4473a551241..57c947dad036 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
@@ -30,7 +30,8 @@ static bool rt2x00usb_check_usb_error(struct rt2x00_dev *rt2x00dev, int status)
 	else
 		rt2x00dev->num_proto_errs = 0;
 
-	if (rt2x00dev->num_proto_errs > 3)
+	if (rt2x00dev->num_proto_errs > 3 &&
+	    !test_bit(DEVICE_STATE_STARTED, &rt2x00dev->flags))
 		return true;
 
 	return false;
