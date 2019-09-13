Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB515B1780
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2019 05:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfIMDyY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Sep 2019 23:54:24 -0400
Received: from alexa-out-tai-01.qualcomm.com ([103.229.16.226]:51564 "EHLO
        alexa-out-tai-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726203AbfIMDyY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Sep 2019 23:54:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1568346862; x=1599882862;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=7Pd9wUt0LbpEluyUm8uyYDaVy9frIqdeh9hSUOTaRhk=;
  b=kZr6hZhBo8bzqh3SrQ/fLsTD6TYla0nmwudpSnw3Mg511SyAKBQ4oeVu
   Ebes+R22nJspHdMpeTF2VzvUy5JSJ45DvddMkCFIjVcyX5vXMdGX59U4l
   69kdqJfKTuQlGscmNKJUUsjZjzmC46ETOnYzXvEvtIkv9hkcZBah73tDH
   Q=;
Subject: Re: [PATCH v5 0/8] ath10k: improve throughout of tcp/udp TX/RX of sdio
Thread-Topic: [PATCH v5 0/8] ath10k: improve throughout of tcp/udp TX/RX of sdio
Received: from ironmsg02-tai.qualcomm.com ([10.249.140.7])
  by alexa-out-tai-01.qualcomm.com with ESMTP; 13 Sep 2019 11:54:21 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([10.249.150.16])
  by ironmsg02-tai.qualcomm.com with ESMTP/TLS/AES256-SHA; 13 Sep 2019 11:54:16 +0800
Received: from aptaiexm02b.ap.qualcomm.com (10.249.150.12) by
 aptaiexm02f.ap.qualcomm.com (10.249.150.16) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3; Fri, 13 Sep 2019 11:54:14 +0800
Received: from aptaiexm02b.ap.qualcomm.com ([fe80::d4db:8980:a041:2e5d]) by
 aptaiexm02b.ap.qualcomm.com ([fe80::d4db:8980:a041:2e5d%19]) with mapi id
 15.00.1473.005; Fri, 13 Sep 2019 11:54:14 +0800
From:   Wen Gong <wgong@qti.qualcomm.com>
To:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        Wen Gong <wgong@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
Thread-Index: AQHVaYBSskmnVODoB0WU3dS9hlPlKacoUocXgACff80=
Date:   Fri, 13 Sep 2019 03:54:14 +0000
Message-ID: <1568346854209.29270@qti.qualcomm.com>
References: <1567679893-14029-1-git-send-email-wgong@codeaurora.org>
 <87tv9hikwe.fsf@kamboji.qca.qualcomm.com>,<87d0g5h07v.fsf@kamboji.qca.qualcomm.com>
In-Reply-To: <87d0g5h07v.fsf@kamboji.qca.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [199.106.107.6]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

=0A=
>>> The bottleneck of throughout on sdio chip is the bus bandwidth, to the=
=0A=
>>>patches are all to increase the use ratio of sdio bus.=0A=
=0A=
>> I tried to apply patches 2-8, patch 2 had a conflict due to my changes=
=0A=
>> and patch 8 didn't apply at all. Also I saw few warnings with the=0A=
>> patches I was able to test:=0A=
=0A=
HI kalle,=0A=
=0A=
i see some warning is from patch "ath10k: add fw coredump for sdio when fir=
mware assert"=0A=
and this patch also have change in sdio.c, so maybe it will have conflict w=
ith the 8 patches.=0A=
=0A=
patch 8 didn't apply at all, is it means each change of the patch is confli=
ct?=0A=
=0A=
I used command to check each patch.=0A=
perl ~/opensource/checkpatch.pl --strict --no-tree --max-line-length=3D90  =
--show-types --ignore CONST_STRUCT ./*=0A=
=0A=
I found it not check Wunused-but-set-variable.=
