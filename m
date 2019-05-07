Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24672158BB
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2019 07:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfEGFF3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 May 2019 01:05:29 -0400
Received: from alexa-out-tai-01.qualcomm.com ([103.229.16.226]:40710 "EHLO
        alexa-out-tai-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725839AbfEGFF1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 May 2019 01:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1557205525; x=1588741525;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=UrV7zyLquGaGyp71Wl+1EFTpGEsSXpjTEyDgqzkJm58=;
  b=uvlVH52D6SwjletGPX5xEpWQSPkYc267hEpHTQ2qbDJ0YbwoBMnr2WfV
   Qm7gGXvUmBLY2VMPdeEasewGLosaPB/3v62dnJw3peJ5ulboeEymV9Hp+
   dEMGpXhT1kUR2NgeDbv8nJDXMLQE1wR322aOS8H9UOo9x+86ha3smjcXo
   g=;
Subject: RE: [PATCH] ath10k: remove mmc_hw_reset while hif power down
Thread-Topic: [PATCH] ath10k: remove mmc_hw_reset while hif power down
Received: from ironmsg03-tai.qualcomm.com ([10.249.140.8])
  by alexa-out-tai-01.qualcomm.com with ESMTP; 07 May 2019 13:05:24 +0800
X-IronPort-AV: E=McAfee;i="5900,7806,9249"; a="28693442"
Received: from aptaiexm02f.ap.qualcomm.com ([10.249.150.16])
  by ironmsg03-tai.qualcomm.com with ESMTP/TLS/AES256-SHA; 07 May 2019 13:05:24 +0800
Received: from aptaiexm02f.ap.qualcomm.com (10.249.150.16) by
 aptaiexm02f.ap.qualcomm.com (10.249.150.16) with Microsoft SMTP Server (TLS)
 id 15.0.1395.4; Tue, 7 May 2019 13:05:22 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1]) by
 aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1%19]) with mapi id
 15.00.1395.000; Tue, 7 May 2019 13:05:22 +0800
From:   Wen Gong <wgong@qti.qualcomm.com>
To:     Grant Grundler <grundler@google.com>,
        Wen Gong <wgong@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
Thread-Index: AQHVAdpJadKuEaUlO02aG5lsvSOAm6ZfCRng
Date:   Tue, 7 May 2019 05:05:21 +0000
Message-ID: <36950ff25c0747629e60ccb68819e93a@aptaiexm02f.ap.qualcomm.com>
References: <1556417825-13713-1-git-send-email-wgong@codeaurora.org>
 <CANEJEGug_YregN5vZq_R=ppUV5ptb4WUq_TB+JApzQ4DEO_AfQ@mail.gmail.com>
In-Reply-To: <CANEJEGug_YregN5vZq_R=ppUV5ptb4WUq_TB+JApzQ4DEO_AfQ@mail.gmail.com>
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
> From: ath10k <ath10k-bounces@lists.infradead.org> On Behalf Of Grant
> Grundler
> Sent: Saturday, May 4, 2019 2:01 AM
> To: Wen Gong <wgong@codeaurora.org>
> Cc: linux-wireless@vger.kernel.org; ath10k@lists.infradead.org
> Subject: [EXT] Re: [PATCH] ath10k: remove mmc_hw_reset while hif power
> down
>=20
> [repeating comments I made in the gerrit review for Chrome OS :
> https://chromium-
> review.googlesource.com/c/chromiumos/third_party/kernel/+/1585667
> ]
>=20
> On Sat, Apr 27, 2019 at 7:17 PM Wen Gong <wgong@codeaurora.org> wrote:
> >
> > For sdio 3.0 chip, the clock will drop from 200M Hz to 50M Hz after loa=
d
> > ath10k driver, it is because mmc_hw_reset will reset the sdio's power,
> > then mmc will consider it as sdio 2.0 and drop the clock.
>=20
> Wen,
> 5468e784c0600551ca03263f5255a375c05f88e7 commit message gives
> reasons
> for adding the mmc_hw_reset() call. The commit message for removing
> gives different reason for removal. Both are good but second one is
> incomplete.
>=20
> The commit message for removal should ALSO explain why adding this
> call wasn't necessary in the first place OR move the call to a
> different code path.
>=20
> > Remove mmc_hw_reset will avoid the drop of clock.
>=20
> This commit message makes it clear the original patch introduced a new
> problem. But the original patch fixed a different problem and that
> this proposed change seems likely to re-introduce and the commit
> message should explain why that isn't true (or how the original was
> fixed differently)
Hi Grant,
The mmc_hw_reset's effect depends on the hardware layout/configure
software's behavior, recently it will effect the clock of sdio for the plat=
form
I used. And it will still work well without mmc_hw_reset for the platform I
Used currently.=20
If sdio cannot work on other platform, I think it can add flag in=20
ath10k_hw_params_list for the platform to call the mmc_hw_reset depends
on the flag.
>=20
> cheers,
> grant

