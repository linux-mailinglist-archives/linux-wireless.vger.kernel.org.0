Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA6CB8993
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2019 04:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404020AbfITCzT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Sep 2019 22:55:19 -0400
Received: from alexa-out-tai-02.qualcomm.com ([103.229.16.227]:25257 "EHLO
        alexa-out-tai-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388199AbfITCzT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Sep 2019 22:55:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1568948118; x=1600484118;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=h5GDMNjW+EjFMM6Brw8DWg04GozxHkTpURfiFQTUTHk=;
  b=vOY4FwpTYzVD758IwZag6VQ6x74XXzvb9JCG+CR5908Qbi45Z0/4TV9v
   M05+ODd4fVaLQ9UD9+fni/fTkHHrnuQQQYZZ3BBNhW9UMisqvOZ9GOo13
   TmBNlrAmbXf8IQOz8RXYQfN+e40+7xtW6tfrIIOTTXnCQ82J1xgHRsuU+
   Q=;
Subject: RE: [PATCH v3] ath10k: support NET_DETECT WoWLAN feature
Thread-Topic: [PATCH v3] ath10k: support NET_DETECT WoWLAN feature
Received: from ironmsg01-tai.qualcomm.com ([10.249.140.6])
  by alexa-out-tai-02.qualcomm.com with ESMTP; 20 Sep 2019 10:55:16 +0800
Received: from aptaiexm02a.ap.qualcomm.com ([10.249.150.11])
  by ironmsg01-tai.qualcomm.com with ESMTP/TLS/AES256-SHA; 20 Sep 2019 10:55:10 +0800
Received: from aptaiexm02f.ap.qualcomm.com (10.249.150.16) by
 aptaiexm02a.ap.qualcomm.com (10.249.150.11) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3; Fri, 20 Sep 2019 10:55:08 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1]) by
 aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1%19]) with mapi id
 15.00.1473.005; Fri, 20 Sep 2019 10:55:08 +0800
From:   Wen Gong <wgong@qti.qualcomm.com>
To:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        Brian Norris <briannorris@chromium.org>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>,
        Wen Gong <wgong@codeaurora.org>
Thread-Index: AQHVbXWiq8VLkeX27kapg8LCqChuTqcxeMfAgAJpkJA=
Date:   Fri, 20 Sep 2019 02:55:08 +0000
Message-ID: <40854e84bd4b4a9699b60530b1c373ad@aptaiexm02f.ap.qualcomm.com>
References: <1534402113-14337-1-git-send-email-wgong@codeaurora.org>
 <20181114225910.GA220599@google.com>
 <CA+ASDXMh7vdfkA5jtJqWEU-g-4Ta5Xvy046zujyASZcESCGhAQ@mail.gmail.com>
 <87woe5aehr.fsf@kamboji.qca.qualcomm.com>
In-Reply-To: <87woe5aehr.fsf@kamboji.qca.qualcomm.com>
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

> -----Original Message-----
> From: ath10k <ath10k-bounces@lists.infradead.org> On Behalf Of Kalle Valo
> Sent: Wednesday, September 18, 2019 10:03 PM
> To: Brian Norris <briannorris@chromium.org>
> Cc: linux-wireless <linux-wireless@vger.kernel.org>; Linux Kernel <linux-
> kernel@vger.kernel.org>; ath10k@lists.infradead.org; Wen Gong
> <wgong@codeaurora.org>
> Subject: [EXT] Re: [PATCH v3] ath10k: support NET_DETECT WoWLAN feature
>=20
> So essentially the problem is that with firmwares supporting both
> WMI_SERVICE_NLO and WMI_SERVICE_SPOOF_MAC_SUPPORT ath10k
> enables
> NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR, but
> NL80211_FEATURE_SCHED_SCAN_RANDOM_MAC_ADDR is not enabled
> which is
> inconsistent from user space point of view. Is my understanding correct?
>=20
> Wen, can you enable NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR?
> Does firmware
> support that?

Yes, I test again, it is enabled NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR now.

>=20
> _______________________________________________
> ath10k mailing list
> ath10k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath10k
