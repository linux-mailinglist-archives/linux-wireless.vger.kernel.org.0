Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9505C49A61
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2019 09:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfFRHVj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Jun 2019 03:21:39 -0400
Received: from alexa-out-tai-02.qualcomm.com ([103.229.16.227]:52347 "EHLO
        alexa-out-tai-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726007AbfFRHVj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Jun 2019 03:21:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1560842498; x=1592378498;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=BlWFhpuDlHD10LLxGZW5VKlsCNyfl9WDFOPkhExkpTk=;
  b=kVU8JRbI3m+x/Zn3W0VJO8hACbzoAMtrTyupIz5LTLfdg/z6t2U364E0
   Ctbn7v6NORaonhBYj7uTeAYYtB3WEc3vbLStq6MWJG0LPTaZfafo19qdX
   RV5I/dBMIh5SHe6eiyrCAaJa17vps+8RrvPduTdU5/LCxDzriEMsBG74S
   E=;
Subject: RE: [PATCH] ath10k: add mic bytes for pmf management packet
Thread-Topic: [PATCH] ath10k: add mic bytes for pmf management packet
Received: from ironmsg02-tai.qualcomm.com ([10.249.140.7])
  by alexa-out-tai-02.qualcomm.com with ESMTP; 18 Jun 2019 15:21:37 +0800
X-IronPort-AV: E=McAfee;i="6000,8403,9291"; a="32210948"
Received: from aptaiexm02b.ap.qualcomm.com ([10.249.150.12])
  by ironmsg02-tai.qualcomm.com with ESMTP/TLS/AES256-SHA; 18 Jun 2019 15:21:32 +0800
Received: from aptaiexm02f.ap.qualcomm.com (10.249.150.16) by
 aptaiexm02b.ap.qualcomm.com (10.249.150.12) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3; Tue, 18 Jun 2019 15:21:30 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1]) by
 aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1%19]) with mapi id
 15.00.1395.000; Tue, 18 Jun 2019 15:21:30 +0800
From:   Wen Gong <wgong@qti.qualcomm.com>
To:     Ben Greear <greearb@candelatech.com>,
        Wen Gong <wgong@codeaurora.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Thread-Index: AQHVJSZMyCLP3ilNoE660R+W056916ahAcmw
Date:   Tue, 18 Jun 2019 07:21:30 +0000
Message-ID: <9403fef58374427fa76fb32ee64ee333@aptaiexm02f.ap.qualcomm.com>
References: <1560757079-19266-1-git-send-email-wgong@codeaurora.org>
 <136d04d4-671b-8dde-2abd-63070b07bd26@candelatech.com>
In-Reply-To: <136d04d4-671b-8dde-2abd-63070b07bd26@candelatech.com>
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
> From: ath10k <ath10k-bounces@lists.infradead.org> On Behalf Of Ben
> Greear
> Sent: Tuesday, June 18, 2019 12:04 AM
> To: Wen Gong <wgong@codeaurora.org>; ath10k@lists.infradead.org
> Cc: linux-wireless@vger.kernel.org
> Subject: [EXT] Re: [PATCH] ath10k: add mic bytes for pmf management
> packet
>=20
> I was looking at mac80211 code recently, and it seems some action
> frames are NOT supposed to be protected.  I added my own helper
> method to my local ath10k.  Maybe you want to use this?
>=20
>=20
> /* Copied from ieee80211_is_robust_mgmt_frame, but disable the check for
> has_protected
>   * since we do tx hw crypt, and it won't actually be encrypted even when=
 this
> flag is
>   * set.
>   */
> bool ieee80211_is_robust_mgmt_frame_tx(struct ieee80211_hdr *hdr)
> {
>          if (ieee80211_is_disassoc(hdr->frame_control) ||
>              ieee80211_is_deauth(hdr->frame_control))
>                  return true;
>=20
>          if (ieee80211_is_action(hdr->frame_control)) {
>                  u8 *category;
>=20
>                  /*
>                   * Action frames, excluding Public Action frames, are Ro=
bust
>                   * Management Frames. However, if we are looking at a Pr=
otected
>                   * frame, skip the check since the data may be encrypted=
 and
>                   * the frame has already been found to be a Robust Manag=
ement
>                   * Frame (by the other end).
>                   */
> 		/*
> 		if (ieee80211_has_protected(hdr->frame_control))
>                          return true;
> 		*/
>                  category =3D ((u8 *) hdr) + 24;
>                  return *category !=3D WLAN_CATEGORY_PUBLIC &&
>                          *category !=3D WLAN_CATEGORY_HT &&
>                          *category !=3D WLAN_CATEGORY_WNM_UNPROTECTED &&
>                          *category !=3D WLAN_CATEGORY_SELF_PROTECTED &&
>                          *category !=3D WLAN_CATEGORY_UNPROT_DMG &&
>                          *category !=3D WLAN_CATEGORY_VHT &&
>                          *category !=3D WLAN_CATEGORY_VENDOR_SPECIFIC;
>          }
>=20
>          return false;
> }
>=20
> Thanks,
> Ben
>=20
> > +
> >   	data_len =3D msdu->len;
> >
> >   	switch (txmode) {
> >
>=20
>=20
Thanks Ben,

seems the ieee80211_is_robust_mgmt_frame_tx is not=20
match my change.
