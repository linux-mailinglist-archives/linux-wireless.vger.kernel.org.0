Return-Path: <linux-wireless+bounces-25348-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF27B0357C
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 07:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CDF27A5862
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 05:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A471F19A;
	Mon, 14 Jul 2025 05:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="hSGE51oq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34E618D
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 05:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752470065; cv=none; b=B600bRh4L9MvBvImbpNNpv5jgxNWHNExAGGrivJ89MpFTLknPu57gAGCUBCSAXthLxPchh1UBJyfk4BTZJTacI4DoASQA1nPi9lEBRRpZVYkNUTBK4hUIkXdGpp3x8u0ZbkNs5/7OOlD08EIP8caO4wdImDdIEbJF5P59f/VUyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752470065; c=relaxed/simple;
	bh=KM0dx7MSGp/uzGfz6p6Ps/InPd3hQ2O+FjCU0UPx1dk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rUPJWH6n/MXPNJgPb/cNrfF43Qwsb2DreAH6rzY9b5yKaTVDPIDK6iGeba5MG7kRx4NOQCzbipVTjiSA+HyGaaq1UloNSeDQqs6nji3SUFuzD9ekixyhdatST3YLlxbpKWl9OkS+MBumadZbbbuOv5WC1+Tsc3KQd081ZrxJc4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=hSGE51oq; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-311da0bef4aso3831830a91.3
        for <linux-wireless@vger.kernel.org>; Sun, 13 Jul 2025 22:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1752470063; x=1753074863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aAybXAC40eZtXXJfv8OqmiT/F2tzwKgIaCZNWTJWX9Y=;
        b=hSGE51oqF0dFnNG0LjFrNwkhqYlK11UnYw3CB/+0PnezrfrgXB7qSRLcBdxsFLyo2b
         d+c05GGEp1oy8d4W/PdN8VeZMsDhEEK03eDOPzEByRZYyGbSy3q07HmNRo/0kIHQKuU5
         8Hc8mZoUytaIdyzUP31ukKXkRoSoHW2Say8qch+FiCWmQwu7TGzeRTyfdLQp+olF/uVb
         V82TIG7g5vVRXCuD3fyS+ACPlvz5WH2Od/mGJZuNRytyqpxSPO0sze5CVpFIBO2ci+x1
         Bm2RjcjPXR1pGvsoqH9+9uZK9ryX/5IjWhYRUa29Q6qSeBjRgFKK4B2xogZkJ+FfiFkS
         FRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752470063; x=1753074863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aAybXAC40eZtXXJfv8OqmiT/F2tzwKgIaCZNWTJWX9Y=;
        b=t1SEEbRIjL2JKq4OcaOxq4P4GFr2wyZhLNSlnXeYyfcafrK1sIilU68a9EOH3U+7zO
         d6pzL8sOUtOA7sCBAOtNj1OJ7Cq5U6scPfHdXAXaQOYLYz1jufoioSrhvvA6Ome5ItWM
         ct/RyLIX0Gxu92WBGmMFZusaEOCmsYHzlnn9M9mkO49aPuouRRJMDa4phyd1yvESIhHf
         SmYYLb9QtKPEp4LCT1gnRpK2RCZFRUn8Mt4dDwzLaOOYUJxCDQ97T4tUAJna0DsckAZs
         0ImIBxxAC9kbnsk1cD//2Nyx4Y7lCv95Jx9to+DuShFY0ywhz3/QChHWVfDh071t5fAi
         K+Yg==
X-Gm-Message-State: AOJu0Yyd531OGEJsbUTVIRA5Op99VvI/OPfdMRJRzEVu8sc80+QLc8bl
	befT7Yw2zYC0RUJtpkA6bee/R5ppNzZ/S05m6HJKfH6emd9lQciIzBqEqyFbRlcSGVv+sepfNps
	U9wAWbTU=
X-Gm-Gg: ASbGnculB0OYlsrN59smnHkR3a/LUdQda+knRfNYK9RZDrCbcAvsQi0hr2N4Kv0BMUB
	p0Gx7AYve9g2f4vn/JlSCarhA1B6/C/gfhmRTM6N4XJbsSUgwh+949kQa4Z6wJfA6GN1TPJ6orn
	TFtNbo/SlFqowVdU3/bnjZdlrPmuurzS+0Z4QoNR7UsqCdgttbBouSSh1bnjfqJYa/UJ+zDLf5Z
	e4PSqvhqPrxNrfYwaAhg4ORRQGsXNiCAXF6yxIMAyg2n3SvSAzImAxvA73YpuytvoELmkksuipO
	fYXKIbb6BBf/pj4+Euok3K9ELM5WRWE5QDTVQ8oVtr1Cxsf9JlfLc6viMijXKtCAP3vJPpXfPKD
	/Qx9S1lc2fApl7UBuZvtEVSoqcJBjago1M0F7w47bJZ4di280NfKy3x8zhSFRTSKntS8/+KM=
X-Google-Smtp-Source: AGHT+IEzGlZoTbZxTuz0gQW/yB0n8DsEDvTleo7wm+CZlKDZqvQHQXtalqzllS9iu1T8LFAS/+lsRQ==
X-Received: by 2002:a17:90b:5105:b0:311:f2f6:44ff with SMTP id 98e67ed59e1d1-31c4f573304mr18111748a91.17.1752470062728;
        Sun, 13 Jul 2025 22:14:22 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3eb61291sm9881930a91.34.2025.07.13.22.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 22:14:22 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [RFC 0/5] wifi: S1G short beacon support
Date: Mon, 14 Jul 2025 15:13:58 +1000
Message-ID: <20250714051403.597090-1-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Short beaconing is a feature within S1G that allows beacons
to contain a limited set of elements, significantly decreasing
beacon size. This set of patches adds support for short beaconing
within mac80211 and cfg80211 aswell as mac80211_hwsim.

Preface:

Previously, some work was done ~2 years ago to get short beaconing
in the kernel but it was never successful. The patches can be found
here:

1/2: https://patchwork.kernel.org/project/linux-wireless/patch/20230810093556.33800-1-bassem@morsemicro.com/
2/2: https://patchwork.kernel.org/project/linux-wireless/patch/20230810093556.33800-2-bassem@morsemicro.com/

As a result of this, we have independently rewritten the patchset
based on feedback from the last attempt.

Implementation:

Note that all standards exerts reference below are from
IEEE80211-2024.

(1) S1G long beacons:

What makes S1G long beacons "weird" is that functionally, they
are the same as regular beacons - however they are defined as
a type of extension frame in the standard. While they do slightly
differ in terms of how they are parsed due to variable length
optional elements, as of now the way they are treated by mac80211
is equivalent to regular beacons.

This leads to a decision whether we build out some new infrastructure
to parse and store S1G long beacons separately or use the existing
beacon path (from cfg80211 all the way to beacon retrieval). We have
opted to use the existing code paths as there is already support for
parsing S1G beacons in the validate_beacon_head path and no changes
are required for S1G long beacons as functionally they are equivalent
to regular beacons.

There is something to say regarding whether this is "correct" as
after all they are extension frames and while we feel this is the best
approach when all factors are taken into account - ultimately it is
up to maintainers to decide.

(2) S1G short beacons:

Short beacons on the other hand are indeed functionally different
to long beacons alongside being optional. Primarily related to the
fact that the set of elements available to them is different to long
beacons and thus separate validation is required. We have based
the implementation on Alokas FILS Discovery patchset:

https://lore.kernel.org/linux-wireless/1912863dcd17aa50b09d1ddfc889478eb323f901.camel@sipsolutions.net/T/#m86511f184d40ab36221f4ceae066900233ceb84e

We have created a new nested attribute specifically for the short
beacon data alongside the various BSS parameters needed. This comes
with new validation policies for both the beacon elements and
the beacon head to ensure only elements permitted in a short beacon
are used. In addition, we also prevent short beacons from being
sent down the regular beacon path and vice versa.

We then introduce cfg80211_s1g_short_beacon and s1g_short_beacon_data
which store the related short beacon data, where the former is used
on AP bring up and to initialise the BSS related information and
the latter used when retrieving a beacon. This keeps the optional
short beacon related data separate from the beacon_data type which
makes sense as it is optional, aswell as introduces it into the
cfg80211_ap_update structure for beacon updates such as an SSID
change which may change the short beacon template if it contains
a CSSID field.

(3) S1G BSS:

When an S1G BSS is initialised with short beaconing enabled, the
standard dictates a few things:

9.4.2.5.1:

"If dot11ShortBeaconInterval is equal to true, the DTIM Period field
is set to dot11ShortBeaconDTIMPeriod. If dot11ShortBeaconInterval is
equal to false, the DTIM Period field is set to dot11DTIMPeriod"

11.1.2.1:

"In an S1G BSS, the S1G AP shall generate S1G Beacon frames every
dot11BeaconPeriod TUs; and if dot11ShortBeaconInterval is true, it
shall additionally generate S1G Beacon frames every
dot11ShortBeaconPeriod TUs"

Its important to note that dot11ShortBeaconInterval is a boolean
that states whether short beaconing is enabled or not, and
dot11ShortBeaconPeriod is the interval between each short beacon
transmission (TSBTT). We have opted to use the notion of "short beacon
interval" to represent the time in TUs between each TSBTT as
the kernel currently uses beacon_int to determine the time between
each TBTT, so using s1g_short_beacon_int seems appropriate here.

From the standard exerts above, it infers that when we are short
beaconing, decisions made regarding the DTIM period and beacon
transmission times use TSBTT's rather then TBTT's - so make sure
any calculations when short beaconing is enabled that involve
the DTIM period or beacon interval use the equivalent s1g_short_xyz
parameters.

In addition to this, we now need to know whether we need to send
a short beacon or a long beacon. From the standard it states:

11.1.3.10.2:

"The value for the dot11ShortBeaconPeriod shall be such that
dot11BeaconPeriod = n * dot11ShortBeaconPeriod, where n is a
positive integer. This defines a series of TSBTTs exactly
dot11ShortBeaconPeriod TUs apart"

the value for n here is what we are denoting as
s1g_short_beacon_period (another deviation from the naming
within the standard) which represents the number of short
beacons between each long beacon. To keep track of the current
state, we introduce a new parameter sb_count within the
struct ps_data structure to track the current index into this
period. This is what is used to determine whether we send a
long or short beacon on beacon retrieval where a value of 0
indicates a long beacon (following the same cadence of
decrementing the DTIM count).

We have opted to place it in the struct ps_data since,
fundamentally, it is a power save mechanism and is initialised
using the same TSF value the DTIM count is initialised with
as its very common for the short beacon DTIM period and
short beacon period to be equal - so this ensures we
initialise these values in sync.

(4) Beacon retrieval

There were essentially two options we could take with regards to
retrieving the beacons:

1.implement it in the traditional beacon path via
  ieee80211_beacon_get_ap

2.Implement an S1G (or maybe extension frame?) specific path
  such as ieee80211_s1g_beacon_get_ap where the S1G specific
  handling can be done in its own function, leaving the regular
  beacon path untouched

We have opted to take method (1) but this really comes down to
maintainers preference. New conditionals will be introduced
in the beacon path regardless and we feel this is the best
approach but are open to feedback.

(5) Testing

This patchset has been tested on the following configurations:

1. Multi-sta setup with real Morse Micro hardware.
2. S1G hwsim configuration with a single AP and > 10 STAs
3. 2.4GHz hwsim configuration to test for regressions along the
   non-s1g path consisting of a single AP and STA.
4. hostapd hwsim tests were run to ensure no regression for
   regular 2.4/5/6 radios.

(6) Other notes:

1. The update mechanism is not really that nice. Though that may
   stem from a misunderstanding with how FILS discovery and unsol
   bcast update mechanisms work. Since short beacons rely on a BSS
   to be configured we ensure that an update is only performed
   when this is the case, and when the BSS has not been configured
   we do not allow a set of parameters used for updating the beacon
   to be used when the BSS has not been initialised. Would like some
   feedback on our implementation here as Im not really convinved
   it's the right way, but it seems this is how we currently handle
   it. My understanding of an "update" is that we are updating an
   existing interface. When an interface is being initialised, we
   are not updating - we are setting... An option here is to just
   not even allow updates since this is how S1G is done now and this
   can be ammended in the future.

2. The power save patch (patch #3) is a bit ugly to split, so have
   kept as one as they are fundamentally related.

Lachlan Hodges (5):
  wifi: cfg80211: support configuring an S1G short beaconing BSS
  wifi: mac80211: support initialising an S1G short beaconing BSS
  wifi: mac80211: configure power save for an S1G short beaconing BSS
  wifi: mac80211: support returning the S1G short beacon skb
  wifi: mac80211_hwsim: add S1G short beacon support

 drivers/net/wireless/virtual/mac80211_hwsim.c | 109 ++++++---
 include/linux/ieee80211.h                     |   4 +
 include/net/cfg80211.h                        |  32 +++
 include/net/mac80211.h                        |  17 ++
 include/uapi/linux/nl80211.h                  |  32 +++
 net/mac80211/cfg.c                            | 132 ++++++++++-
 net/mac80211/debugfs_netdev.c                 |   2 +-
 net/mac80211/ieee80211_i.h                    |  15 +-
 net/mac80211/mesh.c                           |   2 +-
 net/mac80211/tx.c                             | 115 ++++++++--
 net/mac80211/util.c                           |  50 ++++-
 net/wireless/nl80211.c                        | 208 ++++++++++++++++++
 12 files changed, 661 insertions(+), 57 deletions(-)

-- 
2.43.0


