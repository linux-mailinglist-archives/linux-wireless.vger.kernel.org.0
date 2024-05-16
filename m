Return-Path: <linux-wireless+bounces-7747-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD818C7A2C
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 18:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B6791C20ADF
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 16:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651092421A;
	Thu, 16 May 2024 16:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jingojango.net header.i=@jingojango.net header.b="X9yTpdXx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9661E14D705
	for <linux-wireless@vger.kernel.org>; Thu, 16 May 2024 16:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715876291; cv=none; b=POj4cSzmiRG3tu26syrJWsb6U8LMVmUdF/tSdqYOHL60BqPpqrtIxbIaHn7X172AglLbBDx7JSEuccYajuTmrHPC2eYpviUu6MeWKdCI5LpGyCNk5H0gIG1gb596z+ErUUURB6GVZNmZ5crLv7HxqMl69cKKeyTy2KwyjjcwPQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715876291; c=relaxed/simple;
	bh=TYByc3xRMJUqeF71IkFNHNYVBPlYfxXiY1jKdPnIt6Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=RUYH2nibScnjasxCIdb35GjtmeC8nYFww2cU7BDUjYQ6QTF3Y+xvB5DONzG4xIOgt7nKCowm+7F2VA5dj+VeRZLrh5XzoeRqUkAKhskJgdYRha2Qgst5UrV+QkdG3OPiau6O7wYS3r4D/9vAETOyDnTP2EnH2NnlkFI/h34kZ94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jingojango.net; spf=pass smtp.mailfrom=jingojango.net; dkim=pass (1024-bit key) header.d=jingojango.net header.i=@jingojango.net header.b=X9yTpdXx; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jingojango.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jingojango.net
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6f0fd87da53so254039a34.2
        for <linux-wireless@vger.kernel.org>; Thu, 16 May 2024 09:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jingojango.net; s=dkim; t=1715876288; x=1716481088; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GZsTl7zvBtv1eGdwHa/2VXt+5D4wBcVnWp4HTaKRqDc=;
        b=X9yTpdXxXbtSXpdhHpCVB947kQDINAAVUp2JAtlMPkwb4iLrOZY010i/OKVq6nRbVE
         trk1p0KysS4PZ/2pIY7vMpagU3Gzm/cfQU+OFzM83aqQeTbvfekBbNPXun0PDdNd1rI1
         ZqmQAInnyMTG1Fd5usmNCt+7Pi74KmvN1P5P8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715876288; x=1716481088;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GZsTl7zvBtv1eGdwHa/2VXt+5D4wBcVnWp4HTaKRqDc=;
        b=mnDKo+Hy2qSvgGv8A+SsuKENdP4VzjgHqvCq4QvMHDw4dxgOcbyi5cviICk7DAy/xf
         vubLpkVWvOrmIN7otg0J9NlQRRV2axKeaG/oRgxb3zpCHkMoPVu/S4wbledXMAQnqjFq
         /MJOQvYueGLRrMbUZIZ/SRN230rbmSQv23/VnpQ2GyH3xNrZIU+buk6iW85uU9RMl9uB
         5Q1g007c6RCHNHVusl9GyrVO9Tv1a3VFWqaUJPap7EwqRiIhdAnCgdvwtacKRbl5BzAd
         vyBO+9Ar1H05TmbQnqzN+b2gUJ6Pdalb4XZO1r6QZtAwhSmoaeSpw4r7/f/NndWezPjd
         Diow==
X-Gm-Message-State: AOJu0YymH50mccf4FXC0xZ/JTTbYF4bRbXQy2xDPqj4eDHH9oRVZ5+yN
	0tI7rVmLDa4jLieW+BxwEXWQHsiHfLbAOrULw1rHwwAmiJkQ6kvIiE99osg4GEHjw6AGxl/dEbW
	xRvKhyFwSeDxF1IOBumB+QoZgUD9szAu8H+/GDaBMOyD5exQQww==
X-Google-Smtp-Source: AGHT+IEtcRvaBs1i7TnCpLzElJ80HHoH/dAZVIJo25lU2Di+rMTupUsI+O38evLmjh2A1othzFgvujPr3sbles53yM8=
X-Received: by 2002:a05:6808:2129:b0:3c9:9622:d5eb with SMTP id
 5614622812f47-3c99704c196mr26806796b6e.13.1715876288187; Thu, 16 May 2024
 09:18:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kurt Grutzmacher <grutz@jingojango.net>
Date: Thu, 16 May 2024 09:17:57 -0700
Message-ID: <CAMDnkSkWQqQN-cimuJ--XFEJbdNPJK_z7hocskSaBQbnH+tW=g@mail.gmail.com>
Subject: No packets in monitor mode with rtw89_8852ce
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Using a Realtek 8852ce module in monitor mode on Ubuntu 22.04 LTS I am
able to capture frames on 2.4 GHz channels but not any other
frequencies. Low power mode is disabled.

[98869.471001] rtw89_8852ce 0000:02:00.0: loaded firmware rtw89/rtw8852c_fw.bin
[98869.480121] rtw89_8852ce 0000:02:00.0: Firmware version 0.27.56.14,
cmd version 0, type 1
[98869.480142] rtw89_8852ce 0000:02:00.0: Firmware version 0.27.56.14,
cmd version 0, type 3
[98869.757041] rtw89_8852ce 0000:02:00.0: chip rfe_type is 1

ubuntu@ubuntu:~$ sudo iw realtekwifi0 set freq 2412
ubuntu@ubuntu:~$ sudo tcpdump -i realtekwifi0
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on realtekwifi0, link-type IEEE802_11_RADIO (802.11 plus
radiotap header), snapshot length 262144 bytes
00:26:02.650167 363978528us tsft 11.0 Mb/s 2412 MHz 11b 0dBm signal
antenna 0 Request-To-Send TA:98:18:88:be:f0:04 (oui Unknown)
00:26:02.650362 363978752us tsft 11.0 Mb/s 2412 MHz 11b 0dBm signal
antenna 0 Clear-To-Send RA:98:18:88:be:f0:04 (oui Unknown)

Moving to a 5 GHz or 6E-enabled channel returns no captured packets.
I've tried multiple channels.

ubuntu@ubuntu:~$ sudo iw realtekwifi0 set freq 5220
ubuntu@ubuntu:~$ iw dev realtekwifi0 info
Interface realtekwifi0
ifindex 4
    wdev 0x100000001
    addr 1c:ce:51:91:5b:50
    type monitor
    wiphy 1
    channel 44 (5220 MHz), width: 20 MHz (no HT), center1: 5220 MHz

ubuntu@ubuntu:~$ sudo time tcpdump -i realtekwifi0
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on realtekwifi0, link-type IEEE802_11_RADIO (802.11 plus
radiotap header), snapshot length 262144 bytes
^C
0 packets captured
0 packets received by filter
0 packets dropped by kernel
0.01user 0.00system 1:02.67elapsed 0%CPU (0avgtext+0avgdata 7936maxresident)k
0inputs+0outputs (0major+515minor)pagefaults 0swaps

APs are visible on freq 5220 when doing iw realtekwifi0 scan:

BSS 8e:18:98:be:f0:04(on realtekwifi0)
    TSF: 715485204454 usec (8d, 06:44:45)
    freq: 5220
    beacon interval: 100 TUs
    capability: ESS Privacy SpectrumMgmt ShortSlotTime RadioMeasure (0x1511)
    signal: -61.00 dBm
    last seen: 2852 ms ago
    Information elements from Probe Response frame:
    SSID: Free-WiFi
    Supported rates: 12.0* 18.0 24.0* 36.0 48.0 54.0
    Country: US Environment: bogus

--
 Kurt Grutzmacher -=- grutz@jingojango.net

