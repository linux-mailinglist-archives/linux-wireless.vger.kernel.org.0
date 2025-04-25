Return-Path: <linux-wireless+bounces-22043-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D04FA9C1DD
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 10:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A19E4663B6
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 08:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443C9218AAD;
	Fri, 25 Apr 2025 08:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZcKDwMDJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4662144DA
	for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 08:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745570721; cv=none; b=ONBVNB1lt1yQymZR+FkfE7McCl64yiqXycWDRCDDKFvoMhgijgcIHkDYLDPW9RDNwQv4D98/ADqYZx+GNBUVFcuBxMdGw0VI5I0JnTLNU3JWspm3LGvwA0uia/Fh47CcN7NshJYOI5/mEaHk5RoUsx2LTdjLSISYYfU7K4UDreM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745570721; c=relaxed/simple;
	bh=CZqj5BJ+F9nGfuUzehgz/29o8eO2JwnSjCkRPFzqBFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JATirzKyoVtWhXRYxW9GgI55ksosxttNYXOin6PdH2R/wdXOD5/YPKIGdhihNaZ0EQjB8vtqv5jYDC/vnKnqsxrOheXX7ccZe/1wW6KvA1sqe5sq5h7nJjIDZ5jjmhtqdOSukNb4vh493TyS+K8dVMnWjUELB+S+TTCIDd4IAV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZcKDwMDJ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22438c356c8so22651905ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 01:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745570719; x=1746175519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PLk1imrVTtrpJbWqDoaFAq9AHbfHxqAvYTRp4hVRDXA=;
        b=ZcKDwMDJmHWIwNTjtxlcZ986QF9KpyDnhm9eT74s0evaHmehEDnFffbeqPRfzEFi79
         NiKJ0xpGQX4GEQi0pfbN1jMH6NTggWmSukOot0uE0sijn0ULuyXTFzJSjpW/P64xB4Yw
         IlnyyXRSwFhoD+lMnnBc8NSd3BMrsU3JmBQbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745570719; x=1746175519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PLk1imrVTtrpJbWqDoaFAq9AHbfHxqAvYTRp4hVRDXA=;
        b=DyC9Z1puzGs7knW9Vyvmdx+B0Xgdm8Pcr8JTDlL6zBcFRT/alTLPh8I71BV824L0ID
         nG7aqL8byGte+KrgkkfNPUXrCKDBWPNRME/lTg6yCwx9is8zdNhPIqUAqIRQ4FMk/W4p
         BK7kG96QdcD4E/ATY5BAWxxd3A6N7kJYR+FqzWKielJCAqIuUNMjkRTRUn8z4yYUJc1y
         ma0hT2FISSLGyKudJZHpN2gJQkMy1hLn4WeNFrrA2NAvAfpIm6zvOCydea6iDRBEcEVv
         rzrLLvQqTdrHtIMg6yQwQd6HeQrizYbu3KjZSOPq7KGTajka/qQw9gEN41rndxBZWztG
         4GhA==
X-Gm-Message-State: AOJu0YypE5JFk9o6u/mXnAgspktV0pu6ctsxU7AxlCqlxm1uGtij2No2
	zPzjz2LyIkUsbmli+OHSLkr3tAu2xoVHldPBWd7tINAYS9KUUiQt3ClNq2avCQ==
X-Gm-Gg: ASbGncu7iM8NCMsvz0kVQFZSk95PRs1rz6SKG5Lczpiq+v2DHNJuRBdq1FtLNKnoHlD
	Z/OGE8BA0vQ6jFweNkv3hMVikzpO2SnzMGFE8RpXw3VPT0ZwCK4Gl81rQlipB4jFLNOZxTDvYfn
	fWO1/MWY0ER27Rk20jXoaaAkAym/6lF39d+YcTQuwSv1vRyNqMEGr5Jl31Gx3L4EQYA9pIaagc8
	rWKXKWFuIP9kWF2orcV5NfAkbo5FKMU5NOd2vU5Wc1jGNE0DBZQW3XhGz+8/oa/5sX4TGUwaAK+
	2FCeksxScYai7ZKjHtBUFIqfjKdlBIB3A7Iw0VYN4pLK8QCC5Lm9lIJgUm7Y1XZFw621C/KDtDt
	uXSSanBzBLtBX9na03Ue2
X-Google-Smtp-Source: AGHT+IHwtmtjweaqahg73jVCjpaBc/fqgd26dbxeV6NuU5ixsA45gOD/ynPh07Q3+NtHtBMv76H8gw==
X-Received: by 2002:a17:903:1aaf:b0:223:4bd6:3863 with SMTP id d9443c01a7336-22dbf4d51aamr24579845ad.10.1745570718748;
        Fri, 25 Apr 2025 01:45:18 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5102ddcsm26883665ad.190.2025.04.25.01.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 01:45:18 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH wireless-next v2 0/4] wifi: brcmfmac: external auth support for Infineon devices
Date: Fri, 25 Apr 2025 10:45:01 +0200
Message-ID: <20250425084505.491631-1-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Infineon chips support external authentication in station mode when
firmware advertises it. The feature that must be present in firmware is
sae_ext. This has been ported from Infineon repository and makes use of
the per-vendor framework. It showcases how things can be organized per
vendor to provide the functionality.

Unfortunately, I have no Infineon device and firmware that makes use of
external auth. This series was submitted earlier as RFT and it was tested
successfully by James Prestwood with iwd after adding a fourth patch to
the series. I would not mind if more testing is done with this series
like using wpa_supplicant instead of iwd.

Arend van Spriel (3):
  wifi: brcmfmac: support per-vendor cfg80211 callbacks and firmware
    events
  wifi: brcmfmac: make per-vendor event map const
  wifi: brcmfmac: cyw: support external SAE authentication in station
    mode

Ting-Ying Li (1):
  wifi: brcmfmac: Fix structure size for WPA3 external SAE

 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  44 ++-
 .../broadcom/brcm80211/brcmfmac/cfg80211.h    |  25 ++
 .../broadcom/brcm80211/brcmfmac/common.c      |   1 +
 .../broadcom/brcm80211/brcmfmac/core.c        |   2 +
 .../broadcom/brcm80211/brcmfmac/cyw/core.c    | 308 ++++++++++++++++++
 .../brcm80211/brcmfmac/cyw/fwil_types.h       |  87 +++++
 .../broadcom/brcm80211/brcmfmac/feature.c     |   3 +-
 .../broadcom/brcm80211/brcmfmac/feature.h     |   4 +-
 .../broadcom/brcm80211/brcmfmac/fweh.c        |   7 +-
 .../broadcom/brcm80211/brcmfmac/fweh.h        |   8 +-
 .../broadcom/brcm80211/brcmfmac/fwvid.h       |  29 ++
 11 files changed, 495 insertions(+), 23 deletions(-)
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h


base-commit: f600832794c91d7021d7337104734246b02a2b86
-- 
2.43.5


