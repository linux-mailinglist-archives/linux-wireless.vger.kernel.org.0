Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDB5D61C5
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2019 13:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730905AbfJNLzI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Oct 2019 07:55:08 -0400
Received: from alexa-out-tai-02.qualcomm.com ([103.229.16.227]:24411 "EHLO
        alexa-out-tai-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730493AbfJNLzH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Oct 2019 07:55:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1571054106; x=1602590106;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=Mun65NHkwrpSXi54p910vbN/DRdianC6hu3rlSHVAYw=;
  b=MUb4R7Ns2qOW849sE2kfIEpork+e1qz6uSB5COIHyntJgXUZT9TTjrMT
   0FiP+plCOmZjYL6ZW7o0khPv4geMr00SjGGUgWkXpe5GKE0fxxjO3N99V
   lKwDwwDSC9cY2qbkb7RmZNYaCOUvNGVittvCoE64SXr5ZMaa59W3q+faW
   o=;
IronPort-SDR: f6yiCDM8duDiBVIaOTPtLOfqiccxu0M7lOlmfuDFTK5ngXUXM/U1QPLlBIIhMJzaCuYI+BgWCp
 6Sm5NCczNffw==
Subject: RE: [PATCH v5 0/8] ath10k: improve throughout of tcp/udp TX/RX of sdio
Thread-Topic: [PATCH v5 0/8] ath10k: improve throughout of tcp/udp TX/RX of sdio
Received: from ironmsg03-tai.qualcomm.com ([10.249.140.8])
  by alexa-out-tai-02.qualcomm.com with ESMTP; 14 Oct 2019 19:53:40 +0800
IronPort-SDR: dx6LspE/IYAIuuXNwj3FIVcbNI25nEfQU8I+7kdpQLyGSskO5kzbXfSbkL2lhdKMgQupxZas+m
 /b/qpktcq8xeQ4Ne1D/T/ehOt7ZzJcxq0=
Received: from aptaiexm02b.ap.qualcomm.com ([10.249.150.12])
  by ironmsg03-tai.qualcomm.com with ESMTP/TLS/AES256-SHA; 14 Oct 2019 19:53:09 +0800
Received: from aptaiexm02f.ap.qualcomm.com (10.249.150.16) by
 aptaiexm02b.ap.qualcomm.com (10.249.150.12) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3; Mon, 14 Oct 2019 19:53:07 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1]) by
 aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1%19]) with mapi id
 15.00.1473.005; Mon, 14 Oct 2019 19:53:07 +0800
From:   Wen Gong <wgong@qti.qualcomm.com>
To:     Wen Gong <wgong@codeaurora.org>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
Thread-Index: AQHVcfF/iNu+FJDGoUq5+5DyOmedXac7OcIAgAJ9LACAHHCTAA==
Date:   Mon, 14 Oct 2019 11:53:07 +0000
Message-ID: <048a697517b4459087bae05dce4cc1a4@aptaiexm02f.ap.qualcomm.com>
References: <1567679893-14029-1-git-send-email-wgong@codeaurora.org>
 <87sgon8inp.fsf@codeaurora.org>
 <11062c4e1659ac759cb73af7d46a6db2@codeaurora.org>
 <7f5d822f2dd1f98ba26a8fdecb5dc011@codeaurora.org>
In-Reply-To: <7f5d822f2dd1f98ba26a8fdecb5dc011@codeaurora.org>
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
> From: ath10k <ath10k-bounces@lists.infradead.org> On Behalf Of Wen Gong
> Sent: Thursday, September 26, 2019 10:33 AM
> To: kvalo@codeaurora.org
> Cc: linux-wireless@vger.kernel.org; ath10k@lists.infradead.org
> Subject: [EXT] Re: [PATCH v5 0/8] ath10k: improve throughout of tcp/udp
> TX/RX of sdio
>=20
> On 2019-09-24 20:32, Wen Gong wrote:
> > On 2019-09-23 17:29, Kalle Valo wrote:
> >> Wen Gong <wgong@codeaurora.org> writes:
>=20
>=20
> patch v6 ath10k: improve throughout of RX of sdio has sent
> new patch v6 only have 3 patches, the left patches will also sent later
>=20
> Alagu Sankar (1):
>    ath10k: enable RX bundle receive for sdio
>=20
> Wen Gong (2):
>    ath10k: change max RX bundle size from 8 to 32 for sdio
>    ath10k: add workqueue for RX path of sdio
>=20
> https://patchwork.kernel.org/patch/11160247/
> https://patchwork.kernel.org/patch/11160245/
> https://patchwork.kernel.org/patch/11160241/
>=20
Left 4 patches sent v6:
https://patchwork.kernel.org/patch/11188393/
https://patchwork.kernel.org/patch/11188403/
https://patchwork.kernel.org/patch/11188405/
https://patchwork.kernel.org/patch/11188407/

> _______________________________________________
> ath10k mailing list
> ath10k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath10k
