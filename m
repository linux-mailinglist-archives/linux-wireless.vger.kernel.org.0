Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6915D1F8CAC
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2020 05:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgFODsS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 14 Jun 2020 23:48:18 -0400
Received: from mail-40141.protonmail.ch ([185.70.40.141]:36513 "EHLO
        mail-40141.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbgFODsS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 14 Jun 2020 23:48:18 -0400
X-Greylist: delayed 1075 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Jun 2020 23:48:17 EDT
Date:   Mon, 15 Jun 2020 03:30:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=protonmail; t=1592191821;
        bh=AZHhe0ubwoNSJs7vImPxQuRQNtbnXNwdqJmrtedtWTo=;
        h=Date:To:From:Reply-To:Subject:From;
        b=c/ga1T3zt76MCOvzWhW41ukUcVD76fdQmK0ttrRM8mxhVg2vp4qJSH27jL52Jnp0d
         W1zfeBLEuNJJM2kb7ZOHGwo82vJBUsh9adb1nAlRX4AuumRnv+j7jV3dSvpIslihoR
         OI7yOF7IeGKRpTTC5BRjRfepQ+2dY4x1nIbLpWXo=
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   yagoplx <yagocl@protonmail.ch>
Reply-To: yagoplx <yagocl@protonmail.ch>
Subject: rtlwifi/rtl8192ee suffers with very low performance in AP mode
Message-ID: <_9i057mDZgqJwU9cZCClK7erB0rE5GPEuQ37f981Y4iTNgXOy043Ha_Mi1tY4Qj4gbmdkpoShkETdtX448tXL_pH5TT9yC02TsEnia_Dmmw=@protonmail.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on mail.protonmail.ch
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I have been using my home server as wireless router for a while, and this i=
ssue has been around with me for a while too. I got the TL-WN881ND v2 from =
TP-Link as it was the most robust option I could find for sale in my region=
, and started using it as my home personal usage access point. This is a PC=
I-E rtl8192ee-cg device.


However, with the rtlwifi rtl8192ee driver, the AP suffers from tremendousl=
y slow performance, especially on download speeds (from the point of view o=
f a client device). This in turn makes this driver's AP unsuitable for anyt=
hing other than very light browsing. Here are some results:
(as measured from a very close device in line of sight with a clear airspac=
e)


Link Power Save ON: download - 105 kB/s, upload - 1194kB/s
Link Power Save OFF: download - 105 kB/s, upload - 1194kB/s
reference, ethernet connection feeding the server
download - 91786 kB/s, upload - 38255 kB/s
It's always the same speeds... which is very odd. I get very similar result=
s with the default firmware and the "_new" firmware. At this point it feels=
 like I have tried everything under the horizon.


There is one thing that works to make this card more performant as an AP an=
d it is to use this driver: github.com/lwfinger/rtl8192ee .



It lets the AP work at about 50Mbps download on the client device, which is=
 half of the wired speed but still less than advertised by the device. Howe=
ver I would like to ditch that driver in favor of the kernel driver, becaus=
e the kernel driver has features I am interested in that the alternate code=
base one doesn't.

