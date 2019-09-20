Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D373DB96D8
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2019 19:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405704AbfITR4i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Sep 2019 13:56:38 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36512 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392496AbfITR4i (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Sep 2019 13:56:38 -0400
Received: by mail-qt1-f196.google.com with SMTP id o12so9672196qtf.3
        for <linux-wireless@vger.kernel.org>; Fri, 20 Sep 2019 10:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=xwXwb0VRr0Y5mbIrCdrhW15Qm4cGAzoeDVJ2lEpfOz8=;
        b=U3SmG6MqU1G3DvKMpMi11blBiYYiRG4IcOO9Awa0gS87SZtXwHxfRAO+oIJ9MK0/EA
         Y5Nsta25gV6EmMx5g/TCw3dF35cXtaZf4UJQ2ybwL38/fuf5L0gSLWl/pIgkAy/Tr/9W
         9lOEUdnL6ZM0CekQcwazwaVgejdB3SGe6ZWzCcI24li08Gqx59nLfW91oHIlP8XTnHGZ
         8rVb6AExkrDnCzj8p+HKIxY250lw4QXE+FgqHm2qbRqX/YbEWhYwnNj0plotZ8P4mjFL
         YVQUH4FOhow4YLVAXaWBn0aBFQjADYeLIIcVijsmpWz5SUH2FgLmopUo3+6vwdV+rEDp
         IaDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=xwXwb0VRr0Y5mbIrCdrhW15Qm4cGAzoeDVJ2lEpfOz8=;
        b=cmGIZ9e+Ch2ovmanX4E92I0mYDkW9rVrc/qSs9VfJmxkAYDALHjT2TvMQLFNdepRke
         EEQUsPTaI30tUw0TIGBjTm4WbbSzer/rf1vp95MVnMiPCveWuVwhojrXuprsujvJHXwW
         +p6kPfSOdtXAje2lrY9gLLVTAMz+ItTIGeXaSQa6yIPmNsl9ECcOHi/se35oyAVz9ug6
         QEANGQFXC2BXWpQtxZYGqxCSzzOriuXSAY+eRxe+X10Kh6EROa+XF2mr6FKluqdgI8WS
         TeQNsFEDN0MGBGYe/RKTM7EHIQ0Lkqdv1XNunh6Bms4gTyxZiOhzIFUEAOKhzPvlMg6H
         Xrxw==
X-Gm-Message-State: APjAAAWMyaTqq3WWSh921ZUoJbEShARn+0kyxAmSIqrV1lPQr5GSFHIG
        qxY3Lc5yCQoAaOIn9D6BoChjKw==
X-Google-Smtp-Source: APXvYqzUx+S3hfpDDdk07qdwvak3LptBgH6Z52kWxHyuo6TSEFqvvIY8MMZv6cgKWhdxOKPG8VCRTg==
X-Received: by 2002:ac8:3fd2:: with SMTP id v18mr4595140qtk.73.1569002197003;
        Fri, 20 Sep 2019 10:56:37 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id e42sm1322992qte.26.2019.09.20.10.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 10:56:36 -0700 (PDT)
Date:   Fri, 20 Sep 2019 10:56:31 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     "David S . Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jouni Malinen <j@w1.fi>,
        hostap@lists.infradead.org, openwrt-devel@lists.openwrt.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH RFC] cfg80211: add new command for reporting wiphy
 crashes
Message-ID: <20190920105631.34f10d79@cakuba.netronome.com>
In-Reply-To: <20190920133708.15313-1-zajec5@gmail.com>
References: <20190920133708.15313-1-zajec5@gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 20 Sep 2019 15:37:08 +0200, Rafa=C5=82 Mi=C5=82ecki wrote:
> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> Hardware or firmware instability may result in unusable wiphy. In such
> cases usually a hardware reset is needed. To allow a full recovery
> kernel has to indicate problem to the user space.
>=20
> This new nl80211 command lets user space known wiphy has crashed and has
> been just recovered. When applicable it should result in supplicant or
> authenticator reconfiguring all interfaces.
>=20
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> ---
> I'd like to use this new cfg80211_crash_report() in brcmfmac after a
> successful recovery from a FullMAC firmware crash.
>=20
> Later on I'd like to modify hostapd to reconfigure wiphy using a
> previously used setup.
>=20
> I'm OpenWrt developer & user and I got annoyed by my devices not auto
> recovering after various failures. There are things I cannot fix (hw
> failures or closed fw crashes) but I still expect my devices to get
> back to operational state as soon as possible on their own.

Perhaps a slightly larger point, but I think it should be raised -=20
is there any chance for reusing debugging, reset and recovery work done
in devlink originally for complex Ethernet devices?

WiFi drivers have been dealing with more complex/FW heavy designs for a
while so maybe you've grow your own interfaces, and maybe they
necessarily need to be 802.11-centric, but I'm a little surprised that:

linux $ git grep devlink -- drivers/net/wireless/
linux $
