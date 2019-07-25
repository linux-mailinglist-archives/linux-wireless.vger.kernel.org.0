Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E41674334
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2019 04:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbfGYCVU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Jul 2019 22:21:20 -0400
Received: from alexa-out-tai-01.qualcomm.com ([103.229.16.226]:26185 "EHLO
        alexa-out-tai-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726238AbfGYCVU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Jul 2019 22:21:20 -0400
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Jul 2019 22:21:18 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1564021279; x=1595557279;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=D8GTquOjv5a2dHq/HN3CvemJphUb20rQDDhnsXNJseo=;
  b=yhK5SrrY0n/aog72v6pQ4mhORGKv9z4TJsFsR9Bhctq3O1qcTont5bss
   0JvtOm+wy9gQAThOhp2XyjQafYLqwcGYNqT6ayYgOp5XtPZykEEiXAaN/
   kAi5a9BQZdo5nBNAseBQp3vVRwBVIKfIU3rfrCDthJJxOLAGrl3YIG54r
   w=;
Subject: RE: [PATCH] ath10k: add mic bytes for pmf management packet
Thread-Topic: [PATCH] ath10k: add mic bytes for pmf management packet
Received: from ironmsg02-tai.qualcomm.com ([10.249.140.7])
  by alexa-out-tai-01.qualcomm.com with ESMTP; 25 Jul 2019 10:15:11 +0800
X-IronPort-AV: E=McAfee;i="6000,8403,9328"; a="35329799"
Received: from aptaiexm02a.ap.qualcomm.com ([10.249.150.11])
  by ironmsg02-tai.qualcomm.com with ESMTP/TLS/AES256-SHA; 25 Jul 2019 10:15:05 +0800
Received: from aptaiexm02f.ap.qualcomm.com (10.249.150.16) by
 aptaiexm02a.ap.qualcomm.com (10.249.150.11) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3; Thu, 25 Jul 2019 10:15:04 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1]) by
 aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1%19]) with mapi id
 15.00.1473.003; Thu, 25 Jul 2019 10:15:04 +0800
From:   Wen Gong <wgong@qti.qualcomm.com>
To:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>
CC:     Ben Greear <greearb@candelatech.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>,
        Wen Gong <wgong@codeaurora.org>
Thread-Index: AQHVJSZMyCLP3ilNoE660R+W056916ahAcmwgDjlpJmAAOuawA==
Date:   Thu, 25 Jul 2019 02:15:03 +0000
Message-ID: <5d573271132e40f99326019d3d94827b@aptaiexm02f.ap.qualcomm.com>
References: <1560757079-19266-1-git-send-email-wgong@codeaurora.org>
 <136d04d4-671b-8dde-2abd-63070b07bd26@candelatech.com>
 <9403fef58374427fa76fb32ee64ee333@aptaiexm02f.ap.qualcomm.com>
 <87v9vrzl8d.fsf@kamboji.qca.qualcomm.com>
In-Reply-To: <87v9vrzl8d.fsf@kamboji.qca.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.249.136.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> From: ath10k <ath10k-bounces@lists.infradead.org> On Behalf Of Kalle Valo
> Sent: Wednesday, July 24, 2019 8:11 PM
> To: Wen Gong <wgong@qti.qualcomm.com>
> Cc: Ben Greear <greearb@candelatech.com>; linux-wireless@vger.kernel.org;
> ath10k@lists.infradead.org; Wen Gong <wgong@codeaurora.org>
> Subject: [EXT] Re: [PATCH] ath10k: add mic bytes for pmf management
> packet
> > seems the ieee80211_is_robust_mgmt_frame_tx is not
> > match my change.
>=20
> So what's the conclusion, can I take this patch?
>=20
Yes, you can take this patch.
> --
> Kalle Valo
>=20
> _______________________________________________
> ath10k mailing list
> ath10k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath10k
