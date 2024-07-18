Return-Path: <linux-wireless+bounces-10320-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E32829345A9
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 03:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFCECB21BB0
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 01:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08F1620;
	Thu, 18 Jul 2024 01:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="taqWRA0j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFBD394
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 01:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721265382; cv=none; b=hoHCBakysb9l9SVMlcbf47obU8ZU/g/IyqBc7R9BKuKrzLxkkqYua/ZXWpnjyImrL83CAj+o38LIE/0klzvAFAtC9aBGkU6HEmtcBjNxB4iXvN2XJeOy0Baf/q4EweydxbiqLU8C04wyiRgjArENKzgjBm+HORCCdqWWJ5wBHgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721265382; c=relaxed/simple;
	bh=+uBw5rX7HkfpmlYDLmSfK/j1FDx5sECVUkaCwMBqDcw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lEgkAokV7A/I9aFSWQz3LtC5ib8JT0uAUN7+FcS03YDFh0wwr/+CEf+/3VdmOkpKOltFrsLir+OlbQ/XfVz8S8dMmobneV1b1bmSPJET4FbJAt6yVY2E8NYwoTgUPtm1TCPs5ouh859AdPZr+yrwLMrmNfA09xOQE6/1ghBMTI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=taqWRA0j; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721265377; x=1721870177; i=spasswolf@web.de;
	bh=j8F3tpIxMWL4YjjRHZoKIIqqxZpuUQ4NIlW96Rka8Mc=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=taqWRA0jeP5AiCP1EAcc1V4SVq5+BQFo5KTGOXN9Qv785bhAMGMk/E2X+s/Fuljv
	 S+Dmm6UuWtP2z0ZMZ0uHrxpZKTuXZJ0A7KNFXVsH9eRgSsfuzp227MSJ79+UyPgzF
	 uPpmVNHPRI+tK9Cp1dzdaNMQ//+FjGoTxw6AowFab4eAv9x4mV5tyabUKkgeo4JuA
	 LykU1Z9teUH3+C3x5Xqv/Ua7au8zitpvbJh6MS8tnv1+rSOFseeIvcMwvp+S0RkGw
	 hvxLJKUp0qE/nbyAFMWEtNgSNxJ/m6cAFnmHTUSUj9AU8pgJbf2/5nj89GvAoFbum
	 G2jAV5AveDJQezZXLg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M59n6-1sVM7Z2Gea-005tR5; Thu, 18
 Jul 2024 03:10:09 +0200
Message-ID: <308958f4c5689fd920c3915f4878850a09310b18.camel@web.de>
Subject: Re: patch 46/47 causes NULL pointer deref on mt7921
From: Bert Karwatzki <spasswolf@web.de>
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@kernel.org>
Cc: deren.wu@mediatek.com, linux-mediatek@lists.infradead.org, 
	linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com, 
	mingyen.hsieh@mediatek.com, sean.wang@mediatek.com, spasswolf@web.de
Date: Thu, 18 Jul 2024 03:10:07 +0200
In-Reply-To: <9fb7ac97d2ca472db469aefefbfeb94e0f886508.camel@web.de>
References: <20240711175156.4465-1-spasswolf@web.de>
	 <CAGp9LzoXMoAW6dVZjTf-JcD_wiU4yXpGwkLaVyWXTkaV2MOKwg@mail.gmail.com>
	 <adb192a59c44aa8708e80df30a6a47816a03e50f.camel@web.de>
	 <4e943a62736f955af5d9cd1aff7e2b9c084c8885.camel@web.de>
	 <2599b886-9c63-4989-a08a-7feab28f7c49@nbd.name>
	 <9fb7ac97d2ca472db469aefefbfeb94e0f886508.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-1 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:r2lo/zWQksxO8joft6Pgx0zUs9Oyjyt77rX7Stdp8p029CZEO+I
 pP3U0ObWMckpnu508+rsvA/+iU28VBfLhUTlTVDdbiJeovi3pyI7rbxiN+xBuwt7IwItSKk
 rjmFf1V2CM2jaKXLm5WMWojPJwZOBbex91IhLo9oxRlaZu2NLUGH5svL0XIeyD+B444yT1J
 8HqLuxLcO81QPzRT/7vwg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mcBrr9cU5Z8=;zN2o2oq8uI1Jr6EZloSXICOmXpY
 usWMepdLnCGtoIkYwZuhd+rSx9kgZ+d+hGhwVcaTMAXBVn/jHswNf4S7qnPyRUBtkodaqWH82
 vu4pCn1NTp2zkRbLwg1pkXSuTgRWM1Cjl0sL0cD4KYBaB/QElg09Rdt80BDXc04tHAxcKl5cU
 3h39rDfsaeQN3vhjO2STiYCzQwOHoDocg09n/24UAUCmvQvPocwfpbFE8lt66bentaxI/OZc6
 AWgpJD7vuKVE+Sun4tKpKiRQB4HbmlkKC8jdd5flbOKQzsOV4ok1qhFCguZko3UcYpsBjMFNg
 SVMtuMh87bXvVb0LjiIOBQvhGXukbQVDmZvPY0Y1zjyeT/g78w8Y1YRgKzQERY+SNtU/zZ7J0
 6syWoqmt3DA80j9YZbj7aql/Qy/NoTWik1iNfRX5bJHQ/t2X+Cn4LMSEVhVv3yhILy+d9//dU
 j1BQp10Joo2gVKRU5o1rdb1jQWIVz+8XvHnQrq+uC7FcA2Kv4g9l+6vYx/utOw3TpcyDMz3lw
 sogOq+YgHsoqATRMaXiZk5uJNwqKEKNuUijtbU7F/HxaS2nbLUMRZ3b0vRPx/Po+wWFakqObJ
 xW6BnvYMEA4mFl/rull46ikYawufu00Ybyy9xU7BJ/I1Z722oAxMEF4QSMHefHhrrCVVzD5KS
 fLanjYIQLdo/ZtcI8wcC96CGB0g4Gh4ouSF4I8hs+qz8tRZVk2hHBAO/TqXxF6whN2Fgb5l6l
 DWrFEkS4iRPXf8icXmdWykuuX2ORQ4PpF6UZaOfQSfW4PRbZs4uBmUO+Zd5a/SZtV6MlODkYq
 Rq3BT1hJ5GzefqpAVr3LbhGQ==

Am Mittwoch, dem 17.07.2024 um 19:05 +0200 schrieb Bert Karwatzki:
> Am
>
> Your fix works. (I added a WARN() statement on the early return, to see =
if mvif-
> > phy actually was NULL during testing).
>
> Bert Karwatzki
>

While your fix works there was still the question why the driver is sudden=
ly
forgetting mvif->phy? So I've been testing with this script:

#!/bin/sh
for i in $(seq 1 100);
do
		nmcli radio wifi off
		nmcli radio wifi on
	# wait for wifi
	sleep 3
done

together with this patch:

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 4f30426afbb7..206f10473d92 100644
=2D-- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1182,6 +1182,10 @@ static void mt7921_ipv6_addr_change(struct ieee8021=
1_hw
*hw,
                                    struct inet6_dev *idev)
 {
        struct mt792x_vif *mvif =3D (struct mt792x_vif *)vif->drv_priv;
+       if (!mvif->phy) {
+               WARN(1, "mvif->phy =3D=3D NULL\n");
+               return;
+       }
        struct mt792x_dev *dev =3D mvif->phy->dev;
        struct inet6_ifaddr *ifa;
        struct in6_addr ns_addrs[IEEE80211_BSS_ARP_ADDR_LIST_LEN];


On linux-6.10 the script can be run several times without triggering a war=
ning
while on linux-next-20240716 running the script will trigger several warni=
ngs.
In the end the result of a bisection is this as the first commit to trigge=
r the
warning:
commit 574e609c4e6a0843a9ed53de79e00da8fb3e7437
Author: Felix Fietkau <nbd@nbd.name>
Date:   Thu Jul 4 15:09:47 2024 +0200

    wifi: mac80211: clear vif drv_priv after remove_interface when stoppin=
g

    Avoid reusing stale driver data when an interface is brought down and =
up
    again. In order to avoid having to duplicate the memset in every singl=
e
    driver, do it here.

    Signed-off-by: Felix Fietkau <nbd@nbd.name>
    Link: https://patch.msgid.link/20240704130947.48609-1-nbd@nbd.name
    Signed-off-by: Johannes Berg <johannes.berg@intel.com>

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 6d969d9f1ac9..97aee0a1a39a 100644
=2D-- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -689,8 +689,12 @@ static void ieee80211_do_stop(struct ieee80211_sub_if=
_data
*sdata, bool going_do

 		fallthrough;
 	default:
-		if (going_down)
-			drv_remove_interface(local, sdata);
+		if (!going_down)
+			break;
+		drv_remove_interface(local, sdata);
+
+		/* Clear private driver data to prevent reuse */
+		memset(sdata->vif.drv_priv, 0, local->hw.vif_data_size);
 	}

 	ieee80211_recalc_ps(local);

As this is in generic mac80211 code this could probably also affect other
drivers and their ipv6_addr_change function. (which in turn could easily b=
e
fixed by an early exit when mvif->phy =3D=3D NULL)

Bert Karwatzki

