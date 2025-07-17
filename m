Return-Path: <linux-wireless+bounces-25584-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EBDB0872D
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 09:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C61D91A66366
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 07:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48F72571B4;
	Thu, 17 Jul 2025 07:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="HOLiRryH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D91D2566D3
	for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 07:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752738140; cv=none; b=GuxUvkMF4S8YKI0gKrO0Q0QYkTiHehNG3lHrlYaY9FvYF7enHX3TAUOcOnzN/CKsEsIt17PhgZbf5NOQoi2cABoHzbrwQg+8SiqABJ0exnChrg58IzYm9PtcIEHBgvGD85EbH+BOJswotrcudiXbwbT0XYRTwyAwbYcXooj2x2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752738140; c=relaxed/simple;
	bh=J1VE2R1ybQEcbhgTtOl9sI2MGyfO/BOFJ8HK4wPdbRw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NgZvysxfQPoMouUo/EqPis7XgoZlr6C3Rluf6hvxX3gk9P0fXN68jTcJWaApYSrRB0nQ0fW0n2ixkPnmh+ms1lZ2hkG98KdU54kAxIqDE9ImBMO02s8J0W9eigS9+VYbZGeum5gpb7PKwdmC1m1gULnXGRVcXdumieOzQA01x7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=HOLiRryH; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-742c7a52e97so562570b3a.3
        for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 00:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1752738138; x=1753342938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C1m6gOV5514jdNlpKj109YY4k4eqG2pXHlNm2Bpb4pI=;
        b=HOLiRryH4mXPrVrJciXrdtIEI11sQiFdEMfn6Bsg4JRa17G275Ia7AAPirgzQbtt/X
         D+JMw828R4rj6kVRelEG3HNUv+3gS4yr/GsArqkKTaJsre6vbDeMMjkAWB4BCIZdL9nj
         WMrxFUrkOoY2DqzXlYBeA1MXsyyumVY2277S5CpcgNsVytxrVIEe0JJOetizlAvbdLxN
         zYClkkICnoQGG3OsdfMxQ9j8igETSfHZN1WDsMKtiqs1t4TMkTtvm7l3vpUnJu68/zkl
         Hl+nrscUmfTjkWR6xsfTOeE9mubf+gJQlwHhtEntSa95jT8sE5wG34tr5hk1rOBWqKE+
         a9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752738138; x=1753342938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C1m6gOV5514jdNlpKj109YY4k4eqG2pXHlNm2Bpb4pI=;
        b=CsPzOgK7JB8f5/ITpuO17LsrmmwXTOJfqhBv7KGkBsocK0nRSPJu0tC1RvBU5CcbB2
         RCh6YJ5oAU+rWRNJBKcQvffmyV9eG4UsQt0SuULJVgpAr0xFDpHcIPcayDDC87uSR/H6
         H7LKPLozy1oxRZ97FI9Xvn73uBaU7ZOwdOwDSCCYnO9d+HX26XuGR+eLB231TSERS6ju
         FoCSSD21Zqjzg6ZAKscAHXKK1XzITSuqYZjYSchK4OhcPXmkc2sYjNDtXrf6g0NenE7z
         WWqmmI9UyXAyhZehG6RZV4qMuN8CuFOwJxBIIqhbyVr6AtCrbb4Lp1g7z27jc7t+7XIj
         cuDg==
X-Gm-Message-State: AOJu0YwqFWYEYE5Jzb0hbR5PgifudL30/QXbMt+reDuBSHCsqGocQPnc
	Dq3UralTXbP4IpkA3H259P1p52BW1wJno/MR6BhRs+d5C03W8+biic70v6IVglLAxOE=
X-Gm-Gg: ASbGncsXZOChXSRrMF3F/ksFmoXSu1QYggn1j4+OP/PII9JsoGYNepjGLVwkjRB4kh7
	cYIwftX08pkRpJhxV/NpTUTRuNoaredpGDvmc1/LXhdkj2Vzs77WtM6qj0AvfCSeOzU61GpQREz
	txycIK0iF8GrtE4eQ9OBEiV843KYNLhIm2DJQ5YyqXELiBclu0Q32YcPVqHcUoCFw1bFSiW0uOZ
	e0u01TJpqcKVnXTvS3z/fDoycHS4Q6EWMAc8M7T7S99buQVLYi+OJ6XnSexbxXNmlfTfKj1MrY0
	JP8wwNAGgVta5w68OuGsguQldVhpIkmrIqVMT4ZPH1IQkBBBGnux44e/HD37FWjWgwdkLwDWvjf
	hAF/czOWLLvu0OVM+bS0lnEV6O6A7SbwnYgbKRmNVSLsloAYI6EvRR4sDsWGMSJIh6Ah65Dg=
X-Google-Smtp-Source: AGHT+IGOjKa5iOZMPYdRG5yL8/kfGIYz5BtJHq8Hz0LHOt/xn94mcXEhhBaYjy3ZdtNoF//ltV2Jzw==
X-Received: by 2002:a05:6a21:99a0:b0:21a:df04:3285 with SMTP id adf61e73a8af0-237d702a3a6mr10626792637.22.1752738138284;
        Thu, 17 Jul 2025 00:42:18 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e063b3sm16072550b3a.54.2025.07.17.00.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 00:42:17 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [wireless-next v3 0/4] wifi: S1G short beacon support
Date: Thu, 17 Jul 2025 17:42:01 +1000
Message-ID: <20250717074205.312577-1-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds S1G short beaconing support to mac80211.

v1: https://patchwork.kernel.org/project/linux-wireless/cover/20250714051403.597090-1-lachlan.hodges@morsemicro.com/
v2: https://patchwork.kernel.org/project/linux-wireless/cover/20250716053254.439698-1-lachlan.hodges@morsemicro.com/

As stated in the discussion on v2, a core idea here is that short
beaconing as a feature cannot be enabled/disabled dynamically
without tearing down the interface. The same applies to the long
beacon period - which is a mandatory parameter when bringing up
the interface (and is only set during bringup) as opposed to
performing an update, which only updates the short beacon data
assuming we have an existing short beacon (i.e the BSS has been
configured to be short beaconing).

Changes Since v2:

(1) Removed the s1g_short_beaconing boolean from the BSS configuration
    as theres no need for drivers to be exposed to this and internally
    we can use the link->u.ap.s1g_short_beacon to make the same
    determination.

(2) Refactored ieee80211_set_s1g_short_beacon() to now update the
    template if an update has been made, else we do nothing. Removed
    the use of the old template entirely as this made no sense (besides
    of course freeing it if it existed).

(3) Assign link_conf->s1g_long_beacon_period without exception as for
    non-S1G BSSs this will always be 0, and for S1G BSSs will either
    be 0 or > 1.

(4) When assigning the short beacon, we now just check if we are an S1G
    interface, as an S1G interface that has / will not be configured for
    short beaconing won't have the update flag set. I think this makes
    sense and keeps the validation simpler and more inline with how the
    configuration flow functions.

(5) Removed the BSS update flag for changing the S1G short beacon as
    we always request the beacon each beacon interval, no templates
    are used nor is there support so it is redundant. This has then been
    removed from ieee80211_set_s1g_short_beacon().

(6) Minor code style cleanup when setting the vif.cfg.s1g (can be on a
    single line).

(7) When returning the SKB, we just return the targeted function rather
    then setting a locally allocated SKB. This is purely visual and
    really depends how maintainers think looks the nicest.

Thanks again for the quick review cycles and thorough feedback :)

Lachlan Hodges (4):
  wifi: cfg80211: support configuring an S1G short beaconing BSS
  wifi: mac80211: support initialising an S1G short beaconing BSS
  wifi: mac80211: support initialising current S1G short beacon index
  wifi: mac80211: support returning the S1G short beacon skb

 include/net/cfg80211.h        | 23 +++++++++
 include/net/mac80211.h        |  4 ++
 include/uapi/linux/nl80211.h  | 39 ++++++++++++++
 net/mac80211/cfg.c            | 74 +++++++++++++++++++++++++--
 net/mac80211/debugfs_netdev.c |  2 +-
 net/mac80211/ieee80211_i.h    | 15 ++++--
 net/mac80211/mesh.c           |  2 +-
 net/mac80211/tx.c             | 95 +++++++++++++++++++++++++++++++----
 net/mac80211/util.c           | 31 ++++++++++--
 net/wireless/nl80211.c        | 72 ++++++++++++++++++++++++++
 10 files changed, 335 insertions(+), 22 deletions(-)

-- 
2.43.0


