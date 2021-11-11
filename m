Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A0044D7E0
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Nov 2021 15:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbhKKOM6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Nov 2021 09:12:58 -0500
Received: from mx4.wp.pl ([212.77.101.12]:13978 "EHLO mx4.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232630AbhKKOM5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Nov 2021 09:12:57 -0500
Received: (wp-smtpd smtp.wp.pl 13722 invoked from network); 11 Nov 2021 15:10:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1636639803; bh=yM0ZL6Vn7C9FbY7TO+H0xrn+lkdEt4dPBObH2uDM7dA=;
          h=From:To:Cc:Subject;
          b=kDavkAmbQqf0eZ48y8HuhcZ/QjATj+EN9w9aU3A8ihdxFQlb/6EwfWWxLvWWS+Qda
           RWHhfKYhY+oJoXSVKoQY4ntjGMb6gMqDTR/fyZcHhD4ZCqHVPeJPGfV9KyKb5XxZAp
           yPgIxUTWDIcpyFcb0GBnpqPbz0RDqAjx2TSMRpIM=
Received: from 89-64-85-114.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.85.114])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <exuvo@exuvo.se>; 11 Nov 2021 15:10:03 +0100
Date:   Thu, 11 Nov 2021 15:10:03 +0100
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Exuvo <exuvo@exuvo.se>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: [PATCH] rt2x00: do not mark device gone on EPROTO errors during start
Message-ID: <20211111141003.GA134627@wp.pl>
References: <87czop5j33.fsf@tynnyri.adurom.net>
 <6366d9bd-9752-dbc2-8970-442bdc6e8eea@leemhuis.info>
 <7d353dd2-2ffb-6d5e-9983-f983c8b4f6da@leemhuis.info>
 <20211109073127.ga109212@wp.pl>
 <20211109120737.ga120005@wp.pl>
 <c81f829d-fd87-7580-fb9a-1a84958f890f@exuvo.se>
 <cc85b4e8a038417b865069c6578acf50@grupawp.pl>
 <87wnlgo5rp.fsf@codeaurora.org>
 <20211110080141.GA123566@wp.pl>
 <b3b9c143-485f-5fe1-312c-c64a8ce33f8a@exuvo.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3b9c143-485f-5fe1-312c-c64a8ce33f8a@exuvo.se>
X-WP-MailID: 17f86cb316900cb2700aaacdc2ce2206
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [MZNE]                               
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

As reported by Exuvo is possible that we have lot's of EPROTO errors
during device start i.e. firmware load. But after that device works
correctly. Hence marking device gone by few EPROTO errors done by
commit e383c70474db ("rt2x00: check number of EPROTO errors") caused
regression - Exuvo device stop working after kernel update. To fix
disable the check during device start.

Reported-and-tested-by: Exuvo <exuvo@exuvo.se>
Fixes: e383c70474db ("rt2x00: check number of EPROTO errors")
Cc: stable@vger.kernel.org
Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
---
 drivers/net/wireless/ralink/rt2x00/rt2x00usb.c | 3 +++
 1 file changed, 3 insertions(+)

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
-- 
2.25.4
