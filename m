Return-Path: <linux-wireless+bounces-27145-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54318B4A48C
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 10:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B051E7AC386
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 08:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAF0DDC5;
	Tue,  9 Sep 2025 08:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="1wnxYrmm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FE427453
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 08:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405287; cv=none; b=uUho6QZSA1SXZgDGVCSXw6GNnPEluYGQhLRG/IKDok0VsN4SaZ5lP48Ra+L9/MEML5Ve9VOOFAFuSciAkeMKcQFcI/nhjNnPj5nG+DExSIGn3yKvI7+1g/IUUn1Ubpdxwk0vACfw66ipHUFDJGYjqA8MdMGZvvsOR74QA+wRZYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405287; c=relaxed/simple;
	bh=IUZFNUFLYV7fQMuV/eNlju4vxC/cGD/FENv6hzGMjEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B569JiKjaJJnCVg26HlUBtRP6kwdxViiRFBWkvy15X3Z7ZBo+32xjB6AMLtS88YQ8170dhmjv5rvqvw0/QNhbEQ9Iq9fzgrxpKUfntGZnKk5q73PggNqPxKdrW0K8HjK6adjKlwk135DPJEV2/MM29nQVerq+iAXdrSkWLcTWXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=1wnxYrmm; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24b1622788dso36492185ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 09 Sep 2025 01:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1757405285; x=1758010085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2+qeoFqZXY75zPM53sejuU+6C5I9KBHKuSJQApHjAyY=;
        b=1wnxYrmmQi82tFYmOagAiLBEA8uhw9AqzHZMj2fxjxWEEHxaYJwf/fEfTHUZMm8Euv
         CZQpq+c8s00Ifw3NXvbKFKDbC44RM6jOzMkPtoqzYEmTPpIrItmBBAM3Ma1sr9tsDd2E
         J6Q5F6UbeB1RAl8Bv7g0t5TFe7WG+kgo7bDtCAvQROHwFeYtobVf7WYCkQQ5ak3dsTgZ
         5wjcC6bCg+LcH+pKBgwhSRNeC+mVLZBy8r4cGi0qXHg4WasWGBzNlHQLjcmbr+p+a4ba
         wwfD7ic0HxWLhMUtaPbCZIrnvdTsW/FxsABWsYozsCgFYdS9/eOF2WPCB9RU4hDunK+4
         BQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757405285; x=1758010085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2+qeoFqZXY75zPM53sejuU+6C5I9KBHKuSJQApHjAyY=;
        b=TY/hZi+CJHyeL2+JNBv1Ay0+f48xZqi09k0+sdfrZByGyAjsd4DKXkZtAGkyH4vJb5
         /EF2ktkQeRGSOdP87VVN90u5DAKwv2aUSt1KwCQMO150jSg7QjtcBaofhTcHVjxSSR8R
         ihBa++faZFet9Bg2TtZNceSC2WLj/nV131krs72nMMqDqyX8hCVuc1BV6h28q4fukmcK
         j9pAFPnEuMfoPe8/3IzRZAAPMyESW/L6Gvt63dada29zzwjCmh6bB9JjfM6xW0UWib+J
         MwQtkNZ5CkX+1ACmsSSOdmDDJm7PGilI5AuWp19G61iI4YCGlc5JcSazZYGMmXlTR4SX
         cdyg==
X-Gm-Message-State: AOJu0YyABBohZsuESWKzHYj68QMw+cnZ8FRPvhwmppIa2AdZhmmLzVVz
	rqf+NnxKcu3FdCaAYx0iBhgWfKieIW8Q71fRp1UI5U0rIaaEE64zCoxi1aWUjC0/UqUj1iCS3ua
	+nZfxQdE=
X-Gm-Gg: ASbGncsKjH0PtsJhgg2qU0dHw64Hx0vDZXi0Dn0kuFT5c8O3dpBHg2GUBUEKlSSGyHF
	DbmrnGwNWCDN3QnAY5vFww59QIF98ugmibHjOxwxtfvkX0KTNQRjjYG3bTDUoRm0caqhGHT7q2f
	ShdvY9bzuHNFuQJVYTZRuUZ5wso/V5C3/DMhGdFaz4c1AE93hBndQjJE3iV5kDcl90xGQe//0OZ
	3MGhFluMBWZl8G9LL1sN06UzA/Qo7++gA+JPpZbDwyte4C+o8lBW14lNWfe41ltppiGyC5RgtoL
	+JPnz//4Ty/Wunv2YgcPmJak/XQpTkQM+V8+A2WGwPHOou8WWLprL85J8saH4zezu5tnx/uE4a2
	fMAUyAL1tu/ReC6iGo5/c37PHq1+iGx0CbCEznFDiU2zRi7Zfj3oMKINm4QjkFSq+ae6NAQR7u5
	KIQTe3gus6WNejOdBvaEvktXKCgXs=
X-Google-Smtp-Source: AGHT+IEzmKPZV9DXuTlhrjjpuI2A46bk45J1/rmh0zcoBqcaqcAsNiZX3rs5NWmV6slCtsJDFCDGag==
X-Received: by 2002:a17:902:d2c2:b0:24d:3ae4:1175 with SMTP id d9443c01a7336-2516c895b06mr175243985ad.5.1757405285105;
        Tue, 09 Sep 2025 01:08:05 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24cb28e33d7sm148882995ad.89.2025.09.09.01.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 01:08:04 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [RFC wireless-next 0/3] wifi: correctly represent S1G channels
Date: Tue,  9 Sep 2025 18:07:47 +1000
Message-ID: <20250909080758.1004956-1-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patchset adds support for correctly implementing S1G channelisation.

The email chain linked [1] provides some preliminary discussion regarding
the implementation of this patchset aswell as discussion of the NO_PRIMARY
flag which is an S1G specific flag that will be introduced.

S1G Primary Channel Overview
============================

An S1G PHY's channelisation comprises of two components, the primary channel
(also known as the "control" channel) and the operating channel. The primary
channel is either a 1MHz or 2MHz channel. The 1MHz channels are the building
blocks that make up both the 2MHz primary (if configured) and the wider
operating channel described by the chandef. While the S1G PHY is very similar
to the VHT PHY with 1/10th clock rate, the introduction of 1MHz channels is
unique. This enables the aforementioned 1MHz or 2MHz primary channel which
is the main deviation from the VHT PHY (atleast that we care about here).

Implementation
==============

Channel Reporting
-----------------

An S1G driver is expected to advertise the list of 1MHz channels it supports
such that it is inline with the other PHY types. An example using the AU
2020 channels:

#define CHANS1G(channel, freq, freq_offset, flags)
[...]

static struct ieee80211_channel s1g_channels[] = {
        CHANS1G(27, 915, 500, 0),
        CHANS1G(29, 916, 500, 0),
        CHANS1G(31, 917, 500, 0),
        CHANS1G(33, 918, 500, 0),
        CHANS1G(35, 919, 500, 0),
        CHANS1G(37, 920, 500, 0),
        CHANS1G(39, 921, 500, 0),
        CHANS1G(41, 922, 500, 0),
        CHANS1G(43, 923, 500, 0),
        CHANS1G(45, 924, 500, 0),
        CHANS1G(47, 925, 500, 0),
        CHANS1G(49, 926, 500, 0),
        CHANS1G(51, 927, 500, 0),
};

This list makes up the 1MHz primary channels that will be used both by the
chandef to describe the primary channel and reported to usermode for various
operations such as scanning.

Chandef Representation
----------------------

As mentioned previously, an S1G interface can be configured such that the
primary channel is a 2MHz channel which consists of 2 1MHz subchannels. When
configured as such, beacons are transmitted on the center frequency of the 2
bonded subchannels. However, when operating on a 2MHz primary channel, there
must always exist a 1MHz subchannel that can be used and advertised to STAs
that are configured to use 1MHz channels during association. How this 1MHz
subchannel is advertised to STAs is known as the primary channel location.

When an AP is beaconing on a 2MHz primary, the S1G Operation element will
advertise the 2MHz primary channel number. However, it also uses a single bit
to describe where the 1MHz primary subchannel lies within this 2MHz primary.
This is described in IEEE80211-2024 9.4.2.211, Table 9-363:

        Bitmap of B0–B4 indicates the primary channel width, and
        the operating channel widths, 1/2/4/8/16 MHz.

        The Primary Channel Width subfield, located in B0 of this
        field, and the BSS Operating Channel Width subfield,
        located in B1–B4 of this field, are defined in Table 10-39.
        B5 indicates the location of 1 MHz primary
        channel within the 2 MHz primary channel

                — B5 is set to 0 to indicate that is located at the lower
                  side of 2 MHz primary channel.
                — B5 is set to 1 to indicate that is located at the upper
                  side of 2 MHz primary channel.

To store this information within the chandef, we introduce a new variable -
s1g_primary_2mhz which indicates that the chandef::chan points to the 1MHz
subchannel denoted by the primary channel location, yet the AP is configured
with a 2MHz primary. However, this means we have no direct access to the
adjacent 1MHz channel that makes up the other bonded channel for the 2MHz
primary, we use the notion of "sibling" channel to describe this channel.
This will be described in more detail shortly.

When bringing up an S1G interface, we also expose a new netlink attribute,
NL80211_ATTR_S1G_PRIMARY_2MHZ which allows for configuring an AP such that
it is using a 2MHz primary channel.

1MHz Primary Sibling Channel
----------------------------

As mentioned above, since we only hold a single pointer to the 1MHz primary
subchannel, we still need to be able to extract the sibling 1MHz channel for
two reasons:

1. To perform validation that, indeed, the 2MHz primary can be used. As in order
   for the 2MHz primary to be used - both 1MHz subchannels that make up the 2MHz
   primary must be valid. The validation criteria will be described shortly.
2. When receiving a beacon from a 2MHz primary, we need to be able to calculate
   the center frequency of the 2MHz primary, this requires us to first determine
   the sibling channel as we have no frame of reference to the location of the
   1MHz channel within chandef::chan.

To accomplish this, we introduce a new helper routine,
cfg80211_s1g_get_primary_sibling() which works by calculating the current 1MHz
index into the wider operating channel described by the chandef, and
returning the sibling 1MHz channel.

NO_PRIMARY Flag
---------------

The singular notion that the S1G PHY specification was designed around
unlicensed 'Sub 1GHz' spectrum means that varying adjacent spectrum
restrictions and hardware limitations require, in some circumstances, edgeband
primary channels to be disabled. However, this does not prevent the wider
operating channel described by the chandef from being used. It's also
important to note that you cannot assume this to be symmetric. This was
discussed in more detail in email chain linked above [1], so I don't believe
it worth going into detail again.

The important takeaway for this patchset, is that when performing validation
on a primary channel, we need to ensure that the channel does not contain the
IEEE80211_CHAN_S1G_NO_PRIMARY flag, and in the case of a 2MHz primary channel,
we need to ensure both 1MHz subchannels that make up this 2MHz primary do
not contain the flag. This was mentioned above as one of the reasons for
needing the cfg80211_s1g_get_primary_sibling() helper function.

Chandef Validation
------------------

Now that its implied that S1G drivers advertise 1MHz channels, we can correctly
perform subchannel validation. We introduce some new helper routines:

cfg80211_s1g_get_start_freq_khz(const struct cfg80211_chan_def *chandef)
cfg80211_s1g_get_end_freq_khz(const struct cfg80211_chan_def *chandef)
#define for_each_s1g_subchan(chandef, freq_khz)

which allow us to enumerate all subchannels described by chandef::center_freq1
+= chandef::freq_offset and chandef::width. This process is very similar to
other PHY types, where the following things are validated:

1. The primary channel 'chan' exists as a subchannel
2. The subchannels can operate on the desired bandwidth
3. There are no disabled subchannels
4. The primary channel (whether that being the 1MHz primary or both 1MHz
   primaries when using a 2MHz primary) does not contain the
   IEEE80211_CHAN_S1G_NO_PRIMARY flag.

However, there are also some unique scenarios to S1G that require extra
validation. The first one being the sibling 1MHz must also exist as a
subchannel when using a 2MHz primary alongside not being disabled.

Flag Removal
------------

This patchset removes the IEEE80211_CHAN_1/2/4/... flags and replaces them
with the more familiar IEEE80211_CHAN_NO_4/8/16MHz flags. These flags are
identical to their VHT counterparts, where 1MHz and 2MHz channels are
_required_ to be supported as per the standard. This allows us to perform
the regulatory and chandef validation in the exact same way, just at
1/10th the clock rate.

Since these flags are ABI and usermode programs rely on the ordering, maybe
its worth just inserting the new flags at the end and leaving them there for
now? I'm not sure, some clarification would be appreciated.

Notes
=====

1. I zero out one of the functions to keep the patchset incrementally
   buildable and then remove it in the last patchset, but maybe not the
   nicest?

Testing
=======

This patchset has been tested on the following configurations:

1. Real Morse Micro hardware
2. mac80211_hwsim AP + STA
3. hostap mac80211_hwsim test suite was run to ensure no regression
   along non-S1G paths.

References
==========

[1] https://lore.kernel.org/linux-wireless/xu4ftmpdwwpokw6exaprrv6wleptq7ggleiluiu6x2dzqbqfhv@6s4m3okiohzw/

Lachlan Hodges (3):
  wifi: cfg80211: correctly implement and validate S1G chandef
  wifi: mac80211: correctly initialise S1G chandef for STA
  wifi: cfg80211: remove ieee80211_s1g_channel_width

 include/linux/ieee80211.h    |  18 +++++-
 include/net/cfg80211.h       | 118 ++++++++++++++++++++++++++++-------
 include/uapi/linux/nl80211.h |  23 ++++---
 net/mac80211/ieee80211_i.h   |   3 +-
 net/mac80211/main.c          |   6 +-
 net/mac80211/mlme.c          |  52 ++++++++++++---
 net/mac80211/scan.c          |  13 ++--
 net/mac80211/util.c          |  39 +++++++++---
 net/wireless/chan.c          | 102 ++++++++++++++++++++----------
 net/wireless/nl80211.c       |  47 ++++++--------
 net/wireless/reg.c           |  82 ++++++++----------------
 net/wireless/util.c          |  27 --------
 12 files changed, 329 insertions(+), 201 deletions(-)

-- 
2.43.0


