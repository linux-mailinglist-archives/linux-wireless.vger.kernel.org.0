Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 800E9A7F12
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2019 11:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbfIDJQz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Sep 2019 05:16:55 -0400
Received: from alexa-out-tai-02.qualcomm.com ([103.229.16.227]:61915 "EHLO
        alexa-out-tai-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726240AbfIDJQz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Sep 2019 05:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1567588613; x=1599124613;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=PP2Afg5yUDKY22iaTPrCbZSu1AzLCBo5mDxsK7cDJHg=;
  b=NaoHIGaD5+pKZeZFI3mTR4hHNVHWqXa8GbPldfunp8DQozCCJ11YOqVH
   +ekaRU7ZplKQlydLwNevq7YLe7EdzLNoxxSVONhPQ+2A11E1wISk52tIC
   /rOl3R1ora7E6KK17CDhrSfmySlM3TSz1/egRFve1R/MctXliM6xur+fi
   4=;
Subject: RE: [PATCH] mac80211: Store max_mtu in ieee80211_hw
Thread-Topic: [PATCH] mac80211: Store max_mtu in ieee80211_hw
Received: from ironmsg01-tai.qualcomm.com ([10.249.140.6])
  by alexa-out-tai-02.qualcomm.com with ESMTP; 04 Sep 2019 17:16:52 +0800
Received: from aptaiexm02b.ap.qualcomm.com ([10.249.150.12])
  by ironmsg01-tai.qualcomm.com with ESMTP/TLS/AES256-SHA; 04 Sep 2019 17:16:47 +0800
Received: from aptaiexm02f.ap.qualcomm.com (10.249.150.16) by
 aptaiexm02b.ap.qualcomm.com (10.249.150.12) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3; Wed, 4 Sep 2019 17:16:45 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1]) by
 aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1%19]) with mapi id
 15.00.1473.005; Wed, 4 Sep 2019 17:16:45 +0800
From:   Wen Gong <wgong@qti.qualcomm.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Wen Gong <wgong@codeaurora.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Thread-Index: AQHVYu8BqfI75AhjWkCFjZRYnAho5acbPPdg
Date:   Wed, 4 Sep 2019 09:16:45 +0000
Message-ID: <6d86b38a6ea947d5821cd8a90c649ba4@aptaiexm02f.ap.qualcomm.com>
References: <1567577743-27684-1-git-send-email-wgong@codeaurora.org>
 <582e0a7eef96bb7d97fee4bae340ded97fda86a2.camel@sipsolutions.net>
In-Reply-To: <582e0a7eef96bb7d97fee4bae340ded97fda86a2.camel@sipsolutions.net>
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
> From: ath10k <ath10k-bounces@lists.infradead.org> On Behalf Of Johannes
> Berg
> Sent: Wednesday, September 4, 2019 3:04 PM
> To: Wen Gong <wgong@codeaurora.org>; ath10k@lists.infradead.org
> Cc: linux-wireless@vger.kernel.org
> Subject: [EXT] Re: [PATCH] mac80211: Store max_mtu in ieee80211_hw
>=20
Patch v2 sent, https://patchwork.kernel.org/patch/11129707/
> _______________________________________________
> ath10k mailing list
> ath10k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath10k
