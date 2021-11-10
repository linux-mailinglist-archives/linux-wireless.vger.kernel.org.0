Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1CCB44BC7D
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Nov 2021 09:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhKJIEc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Nov 2021 03:04:32 -0500
Received: from mx3.wp.pl ([212.77.101.10]:13849 "EHLO mx3.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229930AbhKJIEc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Nov 2021 03:04:32 -0500
Received: (wp-smtpd smtp.wp.pl 6841 invoked from network); 10 Nov 2021 09:01:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1636531302; bh=EYEVDSSY9Cjna9ZsPC0tjF2JJlj2uNQ53XJtrw1H++I=;
          h=From:To:Cc:Subject;
          b=mH/5PpI9PDOuXqMm6EiYiSBhMcJVf3glUydjOHSEAVx23LCHD/nu0gYeP64n7h98C
           nAPrwUI5F/8wc8W64AkowacZ12vG/+ExadUYtbkWKYDJ5vw5WsLXOhJzg4gfrfei3A
           VQqGpDp7+9q74+vpdHXjGSq6QqBNU3GHvA7zy4ck=
Received: from 89-64-85-114.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.85.114])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <kvalo@codeaurora.org>; 10 Nov 2021 09:01:41 +0100
Date:   Wed, 10 Nov 2021 09:01:41 +0100
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Exuvo <exuvo@exuvo.se>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: rt2x00 regression
Message-ID: <20211110080141.GA123566@wp.pl>
References: <c22673af-40e0-3af2-5ab7-69b23fc03598@exuvo.se>
 <f935dc15-08bd-2e28-fc1b-b27634c618be@exuvo.se>
 <87czop5j33.fsf@tynnyri.adurom.net>
 <6366d9bd-9752-dbc2-8970-442bdc6e8eea@leemhuis.info>
 <7d353dd2-2ffb-6d5e-9983-f983c8b4f6da@leemhuis.info>
 <20211109073127.ga109212@wp.pl>
 <20211109120737.ga120005@wp.pl>
 <c81f829d-fd87-7580-fb9a-1a84958f890f@exuvo.se>
 <cc85b4e8a038417b865069c6578acf50@grupawp.pl>
 <87wnlgo5rp.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wnlgo5rp.fsf@codeaurora.org>
X-WP-MailID: 3fc3f747f092fb63581fc54dcfbfd1b2
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [AZNU]                               
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Nov 10, 2021 at 08:59:22AM +0200, Kalle Valo wrote:
> Stanisław Gruszka <stf_xl@wp.pl> writes:
> 
> > Dnia 9 listopada 2021 16:22 Exuvo <exuvo@exuvo.se> napisał(a):
> >
> >  Just tested it and it passes the rt2x00lib_load_firmware but still errors on
> >  rt2800usb_set_device_state:
> >
> > <snip>
> >
> >  @@ -30,7 +30,8 @@ static bool rt2x00usb_check_usb_error(struct rt2x00_dev *rt2x00dev, int status)
> >    else
> >    rt2x00dev->num_proto_errs = 0;
> >   
> >  - if (rt2x00dev->num_proto_errs > 3)
> >  + if (rt2x00dev->num_proto_errs > 3 &&
> >  +    !test_bit(DEVICE_STATE_STARTED, &rt2x00dev->flags))
> >    return true;
> >   
> >    return false;
> >
> > Sorry, I screwed logic in my patch. It should be test_bit() instead of !test_bit(). 
> > And also we should not count when device did not start. So patch should be somewhat different. I'll
> > send tomorrow hopefully better patch. 
> 
> No HTML, please :) I'll reply so that lists see your email.

Eh, I sent from my phone to give quick update, did not realize
it send in HTML.

Anyway, below is updated patch. I hope it will work correctly now.

Regards 
Stanislaw

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c b/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
index e4473a551241..74c3d8cb3100 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
@@ -25,6 +25,9 @@ static bool rt2x00usb_check_usb_error(struct rt2x00_dev *rt2x00dev, int status)
 	if (status == -ENODEV || status == -ENOENT)
 		return true;
 
+	if (!test_bit(DEVICE_STATE_STARTED, &rt2x00dev->flags))
+		return false;
+
 	if (status == -EPROTO || status == -ETIMEDOUT)
 		rt2x00dev->num_proto_errs++;
 	else


