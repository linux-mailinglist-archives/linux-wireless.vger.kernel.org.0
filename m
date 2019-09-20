Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 184A7B8DE1
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2019 11:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408536AbfITJhV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Sep 2019 05:37:21 -0400
Received: from alexa-out-tai-02.qualcomm.com ([103.229.16.227]:22851 "EHLO
        alexa-out-tai-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405989AbfITJhU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Sep 2019 05:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1568972239; x=1600508239;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=EjR88SkcwJWQCwJkrAGU5QpwuwVsApv848ZvrfCzvDU=;
  b=QRfB7cZq7UDTZpy8EP+fnbLjCfnbyFoaECTgvufqQIQIR5A3rqw993/S
   eFaJU85P5dOOcbkFBY5kgntt8MdkwaTkFqHWXfb+UMvpnUVF2WTVAF5mI
   iJhdK6UxEM30/fkybUkI/SV4rO3eF/nYgH1JUIt7a/bvH3855aC9Y1X+b
   o=;
Subject: RE: [PATCH v3] ath10k: support NET_DETECT WoWLAN feature
Thread-Topic: [PATCH v3] ath10k: support NET_DETECT WoWLAN feature
Received: from ironmsg02-tai.qualcomm.com ([10.249.140.7])
  by alexa-out-tai-02.qualcomm.com with ESMTP; 20 Sep 2019 17:37:18 +0800
Received: from aptaiexm02b.ap.qualcomm.com ([10.249.150.12])
  by ironmsg02-tai.qualcomm.com with ESMTP/TLS/AES256-SHA; 20 Sep 2019 17:37:11 +0800
Received: from aptaiexm02f.ap.qualcomm.com (10.249.150.16) by
 aptaiexm02b.ap.qualcomm.com (10.249.150.12) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3; Fri, 20 Sep 2019 17:37:10 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1]) by
 aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1%19]) with mapi id
 15.00.1473.005; Fri, 20 Sep 2019 17:37:09 +0800
From:   Wen Gong <wgong@qti.qualcomm.com>
To:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>
CC:     Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>,
        Wen Gong <wgong@codeaurora.org>
Thread-Index: AQHVb4WHGd4199NYPUebVxHu5lPNrac0M15w
Date:   Fri, 20 Sep 2019 09:37:09 +0000
Message-ID: <29044fb6c3ba43af9a433aeb63f55e41@aptaiexm02f.ap.qualcomm.com>
References: <1534402113-14337-1-git-send-email-wgong@codeaurora.org>
        <20181114225910.GA220599@google.com>
        <CA+ASDXMh7vdfkA5jtJqWEU-g-4Ta5Xvy046zujyASZcESCGhAQ@mail.gmail.com>
        <87woe5aehr.fsf@kamboji.qca.qualcomm.com>
        <40854e84bd4b4a9699b60530b1c373ad@aptaiexm02f.ap.qualcomm.com>
 <87pnjvctjh.fsf@codeaurora.org>
In-Reply-To: <87pnjvctjh.fsf@codeaurora.org>
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
> From: Kalle Valo <kvalo@codeaurora.org>
> Sent: Friday, September 20, 2019 3:32 PM
> To: Wen Gong <wgong@qti.qualcomm.com>
> Cc: Brian Norris <briannorris@chromium.org>; linux-wireless <linux-
> wireless@vger.kernel.org>; Linux Kernel <linux-kernel@vger.kernel.org>;
> ath10k@lists.infradead.org; Wen Gong <wgong@codeaurora.org>
> Subject: [EXT] Re: [PATCH v3] ath10k: support NET_DETECT WoWLAN feature
>=20
> >> Wen, can you enable NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR?
> >> Does firmware
> >> support that?
> >
> > Yes, I test again, it is enabled
> NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR now.
>=20
> Sorry, I'm not quite understanding your reply.
>=20
> But I mixed up the flags. I meant that can we enable
> NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR in ath10k? Does the
> firmware
> releases which have WMI_SERVICE_NLO support
> NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR as well?
Kalle,
I tested with this firmware: https://github.com/kvalo/ath10k-firmware/blob/=
master/QCA6174/hw3.0/sdio-4.4.1/firmware-sdio-6.bin_WLAN.RMH.4.4.1-00017-QC=
ARMSWPZ-2

In ath10k_mac_register, it has flag WMI_SERVICE_SPOOF_MAC_SUPPORT enabled.
	if (test_bit(WMI_SERVICE_SPOOF_MAC_SUPPORT, ar->wmi.svc_map)) {
		ar->hw->wiphy->features |=3D
			NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR;
	}

In ath10k_wow_init, it has flag ATH10K_FW_FEATURE_WOWLAN_SUPPORT, WMI_SERVI=
CE_WOW, WMI_SERVICE_NLO enabled.
int ath10k_wow_init(struct ath10k *ar)
{
	if (!test_bit(ATH10K_FW_FEATURE_WOWLAN_SUPPORT,
		      ar->running_fw->fw_file.fw_features))
		return 0;

	if (WARN_ON(!test_bit(WMI_SERVICE_WOW, ar->wmi.svc_map)))
		return -EINVAL;

	if (test_bit(WMI_SERVICE_NLO, ar->wmi.svc_map)) {
		ar->wow.wowlan_support.flags |=3D WIPHY_WOWLAN_NET_DETECT;
		ar->wow.wowlan_support.max_nd_match_sets =3D WMI_PNO_MAX_SUPP_NETWORKS;
	}
}
>=20
> --
> Kalle Valo
