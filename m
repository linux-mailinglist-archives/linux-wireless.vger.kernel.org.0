Return-Path: <linux-wireless+bounces-13657-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B85F6993A38
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 00:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 484671F21757
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 22:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D253C18B482;
	Mon,  7 Oct 2024 22:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=embeddedts.com header.i=@embeddedts.com header.b="P2IvEpWQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E3318CBE6
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 22:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728340196; cv=none; b=MSBI9LkssnbTszb2R6X5CZN96X+LIoweVQvl+OJSrgmon+yIt88ZEv378BROPogOTueAjjXGR6b6jNNP6NQUJlc0ttPeutleocYOXdbyabYQKGvqaq+f3GOcl/k6vwoODzS27u79jiYVahU97RYp++PcznWBc6pqHcWYUML6XIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728340196; c=relaxed/simple;
	bh=SHcG6t4MwAp+AKGIaP3hq/cpwCtvUIxFdzxskObwFtc=;
	h=From:Message-ID:Subject:To:Date:Content-Type:MIME-Version; b=peWd6ZvcL0I/GYzN27VL8WV+7Z3Mdo3qDq/x/7ph+6fiNYlDFvK5FFJMqj5exETS+YArxvHRByTyltKfFRWIeDXI9I12wqdxTDfAOCGqQRZLgV02KzfMPfYQ34YSvXe7/MwhvXzluUJ2lQC9TeW4+3eUbSrKYpsDXkPZE19l/P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=embeddedts.com; spf=pass smtp.mailfrom=embeddedts.com; dkim=pass (1024-bit key) header.d=embeddedts.com header.i=@embeddedts.com header.b=P2IvEpWQ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=embeddedts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedts.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20b833f9b35so42796435ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 07 Oct 2024 15:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embeddedts.com; s=google; t=1728340194; x=1728944994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:organization:date
         :to:reply-to:subject:message-id:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2CLngY83w58hgTTPStkbvADKKuKTp95LPa3J0QYduc=;
        b=P2IvEpWQtk9R9aRHq3LG8hN3eMt/pwrKcNBic23Da2aQtH/dfv77+kULhAy76bOw6h
         fO6V7fQz502ACcIY+LzHDFo7hc0qYCUkFysSp8WgdsfpYkvmA6ms9NSVtOTVLClB/YrL
         RJ3v6zYn3aPa8LH57KeJaKLRnI8ETA8BHwD9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728340194; x=1728944994;
        h=content-transfer-encoding:mime-version:user-agent:organization:date
         :to:reply-to:subject:message-id:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2CLngY83w58hgTTPStkbvADKKuKTp95LPa3J0QYduc=;
        b=YzTDApVgYcWFRePqdSkVtoMbmfHzv1uatoTQTNagWOQdXR0+WQfb6vfSeWIkxfwKpp
         jU9kaIdRQ7GrWLd5oSmmdiXcI5XsRlKsNT0ZahIGJUmwKc3Wxuwf//unoxYTTPw+qQs/
         Qzqg9Wai4PHe+t7l+H8S36IBMerfhObugxpHh72CJaB8SJteMdk6R8q+7NOl78xw6Ogq
         gJV6i9RlSPkLWhNWVdFRVW/TwPkge6P+L5GGq7cEdx0wl1HgV6KcgpXy+yYdjtF5i9Ur
         uIYGw+kFeHsrIgDntnd3nHETE3E7aPKCZ3hdIFVGT2eXjoojUJ+r/fcVLHBr8zeqx3Kh
         HdnA==
X-Gm-Message-State: AOJu0Yw7VH+gci8dOwz2n4ztGsZuT7/5FRPJCN4cCKL9dUdQy7/pjwjP
	ZQbOUjXiJVB/wEPnQJgAAbxeTaZdIIKF6Yo/cBtFzf4tpSAdGtIDoJ4zIFMmRjdDAzaFfK295gO
	Moq4=
X-Google-Smtp-Source: AGHT+IFYtxvc0GUfZqgi+pG9SK/r5qx1Adua0TX5uA4CZqp5wr8w95q8v3o+anXbkXSU1rG4eKyanA==
X-Received: by 2002:a17:902:ec84:b0:207:6e8:1d84 with SMTP id d9443c01a7336-20bfe291d43mr168037005ad.42.1728340193841;
        Mon, 07 Oct 2024 15:29:53 -0700 (PDT)
Received: from [10.10.10.105] (75-164-160-206.ptld.qwest.net. [75.164.160.206])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c139a4b50sm44401755ad.306.2024.10.07.15.29.53
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 15:29:53 -0700 (PDT)
From: Kris Bahnsen <kris@embeddedts.com>
X-Google-Original-From: Kris Bahnsen <kris@embeddedTS.com>
Message-ID: <2092a65abd344195791ccb9d2673b3896995680a.camel@embeddedTS.com>
Subject: ath10k_sdio unable to connect to WPA2-PSK network on wpa_supplicant
 2.10+
Reply-To: kris@embeddedTS.com
To: linux-wireless@vger.kernel.org
Date: Mon, 07 Oct 2024 15:29:54 -0700
Organization: embeddedTS
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1+deb11u2 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hello,

We have an i.MX6 embedded platform using a soldered down Silex SX-
SDMAC-2832S; a QCA9377 chipset supported by ath10k_sdio with firmware
in linux-firmware since somewhere around kernel 5.10. In the 4.9 LTS we
used a proprietary driver and firmware provided by Silex. Since kernel
5.10, through the latest 6.12 we've been facing an issue where this
device no longer connects to a WPA2-PSK when using wpa_supplicant 2.10
or newer (other encryption methods untested, open networks connect
fine). Downgrading to wpa_supplicant 2.9 works without issue and we've
been using that as a workaround hoping newer kernel or hostap releases
would resolve the issue. Now that we're working in 6.6 and 6.12, the
issue is still present unfortunately:

# wpa_supplicant -iwlan0 -c wpa.conf 
Successfully initialized wpa_supplicant
wlan0: CTRL-EVENT-REGDOM-CHANGE init=BEACON_HINT type=UNKNOWN
wlan0: CTRL-EVENT-REGDOM-CHANGE init=BEACON_HINT type=UNKNOWN
wlan0: SME: Trying to authenticate with aa:bb:cc:dd:ee:ff
(SSID='my_ssid' freq=5240 MHz)
wlan0: Trying to associate with aa:bb:cc:dd:ee:ff (SSID='my_ssid'
freq=5240 MHz)
wlan0: Associated with 8aa:bb:cc:dd:ee:ff
wlan0: CTRL-EVENT-SUBNET-STATUS-UPDATE status=0
wlan0: CTRL-EVENT-DISCONNECTED bssid=aa:bb:cc:dd:ee:ff reason=15
wlan0: WPA: 4-Way Handshake failed - pre-shared key may be incorrect
wlan0: CTRL-EVENT-SSID-TEMP-DISABLED id=0 ssid="my_ssid"
auth_failures=1 duration=10 reason=WRONG_KEY
BSSID aa:bb:cc:dd:ee:ff ignore list count incremented to 2, ignoring
for 10 seconds
wlan0: CTRL-EVENT-REGDOM-CHANGE init=CORE type=WORLD
wlan0: CTRL-EVENT-REGDOM-CHANGE init=BEACON_HINT type=UNKNOWN
wlan0: CTRL-EVENT-REGDOM-CHANGE init=BEACON_HINT type=UNKNOWN
wlan0: CTRL-EVENT-SSID-REENABLED id=0 ssid="my_ssid"


However, simply switching to wpa_supplicant 2.9:

# wpa_supplicant -iwlan0 -c wpa.conf 
Successfully initialized wpa_supplicant
wlan0: CTRL-EVENT-REGDOM-CHANGE init=BEACON_HINT type=UNKNOWN
wlan0: CTRL-EVENT-REGDOM-CHANGE init=BEACON_HINT type=UNKNOWN
wlan0: SME: Trying to authenticate with aa:bb:cc:dd:ee:ff
(SSID='my_ssid' freq=5240 MHz)
wlan0: Trying to associate with aa:bb:cc:dd:ee:ff (SSID='my_ssid'
freq=5240 MHz)
wlan0: Associated with aa:bb:cc:dd:ee:ff
wlan0: CTRL-EVENT-SUBNET-STATUS-UPDATE status=0
wlan0: WPA: Key negotiation completed with aa:bb:cc:dd:ee:ff [PTK=CCMP
GTK=CCMP]
wlan0: CTRL-EVENT-CONNECTED - Connection to aa:bb:cc:dd:ee:ff completed
[id=0 id_str=]


I was able to bisect through hostap and found this commit as the first
breaking commit:
https://w1.fi/cgit/hostap/commit/?id=144314eaa7e09374b7f9a3708263a298e05cbfd6

Reverting that change on the hostap_2_10 and hostap_2_11 tags allowed
me to connect to the network again on those builds.

Looking through hostap and kernel code, net/mac80211/main.c sets the
ext_feature NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211 which hostap
reads and calls WPA_DRIVER_FLAGS_CONTROL_PORT. Unsetting that feature
in net/mac80211/main.c completely breaks even associating with the AP.

Unfortunately this is where my understanding of the Linux networking
system ends and I'm unsure where to start looking now to get to the
bottom of this. The ath10k driver obviously needs
NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211 enabled, but I'm unsure
if the connection failures are a driver or firmware issue. At the very
least I'm now certain it is not a hostap issue.

I would appreciate any insight to the issue. Happy to do any further
testing or provide additional output as needed.

-Kris
embeddedTS


