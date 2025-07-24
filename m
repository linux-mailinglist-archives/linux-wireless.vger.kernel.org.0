Return-Path: <linux-wireless+bounces-25982-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B245B102EA
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 10:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBE1B3BD140
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 08:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9170273D6D;
	Thu, 24 Jul 2025 08:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVAiSQfI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED958230D14
	for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 08:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753344497; cv=none; b=TTUZEoHTfWr1UJn3Es+bUvPVavtz7J14R1Yu5MQrAREnMBWNguKDTBMiKBh0dcn06jlQkF4119dD8tP+DQ/GXRCxd2O5NqMcTEokBb58TSyqpEyfdO0rHQSW9QEehg/Dvuv1tae42a9SXs16tnScYgEhffBZ2j7Z+pWtYo1i1DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753344497; c=relaxed/simple;
	bh=1N6lGdcSK21SEwwl0uqRygw7L8tTQD6KrgynjOrj8CA=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=pLke6AexCZN7jUAc1O/RWSQcgOVz+VxABrRfieR5GHcxc23JtlEpAi3O39xz/Sk0yfA/LMPl+Yr3nGNZLXsHl+MTAVDzehf3GhjTlrut7b0HZ6rGQ9ZjW4zXzQpR495cHxmRnOceWTejGcm7GLLTwU5su+hPvQCA9LKqAX9xnFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVAiSQfI; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae6fa02d8feso104480766b.0
        for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 01:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753344493; x=1753949293; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HZ/aUevv/A/DGhIZaKgnH9cnq4cfXju9xmktnZdLvFM=;
        b=LVAiSQfIcHcstqeBhrQxCJtMiYaSMAesZYlPdql+AdxNXNGLItCw/Sc4jm/7SKKrx2
         HNlhxjXYjUboLJXJpl6yQYahGtNS6ty500RcQWP2fWhNxyB1hTkZI3PnvMSheWOIvZBR
         YZA8q02Jzijb2Ks/YQvMRHVARhqVlhmrW+r4GmbqO7YUVGiYB7KQ9YvAWq3fBloFyhmI
         NJ0SjRt0hlztsUuoSu6Wlc0Fj7FDOtmXNRzvmeBHQbX8ZGFncZa2NXnPNsheDGBgVgCY
         ghUdc9pTHgcWNAX1jBMa08QioNcSvb4xxgxUn5CtZUzR/NiEFBpXZxx7jE453hak5l1E
         5B7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753344493; x=1753949293;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZ/aUevv/A/DGhIZaKgnH9cnq4cfXju9xmktnZdLvFM=;
        b=P2Qhv2YmNaUBT2Wc+d+4Xc/8+T9VCDXy8IGdhJg8DG7diD3h7Da8uSAIB3rI4DSPHV
         6xd3UYqP6UtXE/wJGbT2dDzHwuUj5EOGzmSgijBgGnEu7Mr6Z0Ly5K812RAp/VEf5mC4
         3Gl1XAP8V0RE93m8jw28vJqwYaXoXm5LNQMKAXuNJbnP31oq8wsKZyrZZ+yJ3AZELDry
         MyGrf8W1oTiCiJS0ZpDDDm8oHWCQIc1XIE2GN6ckDKE6XTgcyNpQjG6rEdx77NtJ+TAC
         fxHvw+YmyPzVYkV2qNgfZV8s7KSCLWNlgxP8VEPunuCx0mHJ7XfjnqB9VwSSMlTav6UW
         rqoA==
X-Gm-Message-State: AOJu0YxU4nXwOzX13/9mcCl3PlG/FV/F59j7LooshwydbKu0DM8vjZ8u
	Klj4bCqLFSAhCTeF24nd42UwqDKesHdQ1XR0U0f3Fb303NH1zphV2bSp5BTb/Q==
X-Gm-Gg: ASbGncvT3uEfL8Gz9DSWc8U7k6U6wbCRtfgpJqIgCRk3omRD2gp9EJ+U12ixD77oMe5
	gjid4v2m352+yVAYZ8rzqTMhixII9l2F1I/I+w34vUqXfn2iWC+4488+uWK1gtb43iy7+xHxQU0
	ZDEyH4HaUKaEEW2dJaHn3OXX2BRD+EwsgXxKzBa3+yPeTFP1tKFXggM3+SrRx/Phj4NNM0uicfV
	BQKymnobVKBVqShWk+zFLfX27RK20+4020gYkv+5YpYP6F1tcGkQ1n4CrIUGs4bpmb4TK381qSn
	vXlq+8gyW4EIZi33CX0D+oz0yB5r0dyrntjj01xlIH9lX7RwiQEwttzkK/p4ohsG4D/rfKbtEWp
	8KeStZTu+MqbSzmpcbqyjIMUjy3TzWf+bmP0PJmf+V3RF7cIUU/YzvE2kSViCbIKkHbmlEyIrSL
	dK
X-Google-Smtp-Source: AGHT+IGB3zcLFgmdqDTEYJFrQxkmY82ibw55MEqGrW1EY+SVJ9MjT1CowoqtgcDXoxfpM9rPNjySnw==
X-Received: by 2002:a17:907:7f0c:b0:ae0:9fdf:25e8 with SMTP id a640c23a62f3a-af2f8d4ecf2mr519267666b.47.1753344492614;
        Thu, 24 Jul 2025 01:08:12 -0700 (PDT)
Received: from smtpclient.apple (89-66-237-154.dynamic.play.pl. [89.66.237.154])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47f44df92sm75071566b.69.2025.07.24.01.08.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jul 2025 01:08:12 -0700 (PDT)
From: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: 8822cs, 6.16-rc7: very low throughput
Message-Id: <E01134FB-61C8-4201-88C3-51317279673C@gmail.com>
Date: Thu, 24 Jul 2025 10:08:01 +0200
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 Ping-Ke Shih <pkshih@realtek.com>,
 martin.blumenstingl@googlemail.com
To: linux-wireless <linux-wireless@vger.kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Hi,
I'm playing with 8822cs (nanopi-r76s; m2 module; sdio intf) and i'm =
getting very low throughput on established wifi connections.

my user space is iwd 3.9.
linux-fw is current master.
6.16-rc7 with =
https://lore.kernel.org/linux-wireless/20250724004815.7043-1-pkshih@realte=
k.com/T/#u

iwctl shows:

            Scanning              no
            State                 connected
            Connected network     WarpedNET-5
            No IP addresses       Is DHCP client configured?
            ConnectedBss          8c:53:c3:e6:bb:90
            Frequency             5540
            Channel               108
            Security              WPA2-Personal
            RSSI                  -70 dBm
            AverageRSSI           -69 dBm
            TxMode                802.11ac
            TxMCS                 3
            TxBitrate             234000 Kbit/s
            RxBitrate             6000 Kbit/s


user space throughput:

19.08 Mbps (215.894%)
28.36 Mbps (48.6373%)
18.23 Mbps (-35.7193%)
33.45 Mbps (83.4888%)
33.13 Mbps (-0.956652%)
26.24 Mbps (-20.7969%)
24.92 Mbps (-5.03049%)
25.44 Mbps (2.08668%)
23.96 Mbps (-5.81761%)
25.82 Mbps (7.76294%)
30.15 Mbps (16.7699%)
30.72 Mbps (1.89055%)
25.23 Mbps (-17.8711%)


iwd log:

Wireless daemon version 3.9
Loaded configuration from /etc/iwd/main.conf
station: Network configuration is disabled.
[General].UseDefaultInterface is deprecated, please use =
[DriverQuirks].DefaultInterface instead
Wiphy: 0, Name: phy0
        Permanent Address: 70:68:71:a2:a8:0d
        2.4GHz Band:
                Bitrates (non-HT):
                         1.0 Mbps
                         2.0 Mbps
                         5.5 Mbps
                        11.0 Mbps
                         6.0 Mbps
                         9.0 Mbps
                        12.0 Mbps
                        18.0 Mbps
                        24.0 Mbps
                        36.0 Mbps
                        48.0 Mbps
                        54.0 Mbps
                HT Capabilities:
                        HT40
                        Short GI for 20Mhz
                        Short GI for 40Mhz
                HT RX MCS indexes:
                        0-15
                        32
        5GHz Band:
                Bitrates (non-HT):
                         6.0 Mbps
                         9.0 Mbps
                        12.0 Mbps
                        18.0 Mbps
                        24.0 Mbps
                        36.0 Mbps
                        48.0 Mbps
                        54.0 Mbps
                HT Capabilities:
                        HT40
                        Short GI for 20Mhz
                        Short GI for 40Mhz
                HT RX MCS indexes:
                        0-15
                        32
                VHT Capabilities:
                        Short GI for 80Mhz
                        Max RX MCS: 0-9 for NSS: 2
                        Max TX MCS: 0-9 for NSS: 2
        Ciphers: BIP-CMAC-256 BIP-GMAC-256 BIP-GMAC-128 CCMP-256
                 GCMP-256 GCMP-128 BIP-CMAC-128 CCMP-128
                 TKIP
        Supported iftypes: station
Wiphy phy0 will only use the default interface
event: state, old: disconnected, new: autoconnect_quick
event: connect-info, ssid: WarpedNET-5, bss: 8c:53:c3:e6:bb:90, signal: =
-73, load: 4/255
event: state, old: autoconnect_full, new: connecting
hardware_rekey not supported
event: state, old: connecting, new: connected


kernel log: https://termbin.com/o16p

1m away macbook gives me 40-45MB/s so issue isn't in my wifi router i =
think

i'm not sure how to move forward with this.....




