Return-Path: <linux-wireless+bounces-12979-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4FA97C053
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 21:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 327A4283BB3
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 19:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999181C9EDD;
	Wed, 18 Sep 2024 19:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ani53wYF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D646A1C9848
	for <linux-wireless@vger.kernel.org>; Wed, 18 Sep 2024 19:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726686684; cv=none; b=Q1oz6iljhnzM7s4donUhxM3F6zQ22hvKzMLtlaU+B8MDSsHBNW2iTscnRgnz1Hld5AztTHkX7HRE58l831Sg4trHPKJYGPhnOE57Em/Uc6/aVxOJZd4d0nt2upVBpFaiWAwCU98DPxMLX4oIxNqkdfjYB9I3ZgeKkdNjvFnvv4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726686684; c=relaxed/simple;
	bh=YlDlfO6oppdnTcmtFzD9lV7M+eeempLwE8HAxjK3sdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yv558FDAkqxxMA9D6FQvT/SYdYkeY4lvmbPsVWUrQddu+FHHeHHio+zkJffd+vZDqhZCgwWbO+41C26yrwprAsICY0mbHaB+FvTWjsl79AswewZIQVh8HaRYWm0uPcClp4iRWw929GghW6uaRLMwlZBievYpqTyqn8eZvs+VjHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Ani53wYF; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a9b049251eso3715185a.2
        for <linux-wireless@vger.kernel.org>; Wed, 18 Sep 2024 12:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726686682; x=1727291482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uBXNIld191O5zyOjokQ7vQg2NF4PyRalW9pITb/4A5Y=;
        b=Ani53wYFKx8eDf1McC9+blUJEM8hQHdydPmNHk90g5Vz1yqm6wJPHjdEWRyjPixpA/
         wVn+/gnpEHRuDGP90bTThNDZkNuusQyoYxamuFNEL8P5l88wL+YXCpp9load6xNZCY/D
         rWEkWXTVzosi3koP8M1O/fIlwVYZwxw7Nz8s8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726686682; x=1727291482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uBXNIld191O5zyOjokQ7vQg2NF4PyRalW9pITb/4A5Y=;
        b=lCqmkFTa+yhe6IcidobnA62geQKirXKC8EfUgshgTIzpA21CVgS/GB2vral2/zu13t
         vQ+1s5vv7D1UxPvTDSCMh5WtqHVS8oAPal7Xx7luzbML98rvJAO0ONPL9Jc7TiioNXYZ
         t69BeBbdpfff4qP29uiV/arEVYAEmA4SbGaiYVuI8vMFkP7d2I6Xd2b0qPy057yjs28z
         Atj/57OwYjoc7Cm1rTaRmZzy33FXOhC+1G/IXKUoLYyc4FSVvnuGHx1svNGRbQ7d8vyV
         g57+fgMqSRtuLRIdxZYDP3CVnp1vAY2r3lma4KoscDHKlKJ/MrIwWPFSQMoGB3nrDKkV
         iSiw==
X-Gm-Message-State: AOJu0Yy99tOVLBJmx+iG8FOWSlbHMb9dUOvwmjAMBO0/oEXEzTQXKfuz
	TjE9UEMj0UecI0YKryUuyDYPisSeNIYMP4QxhOMDGqS5TfxIj+dLTkMXIk18Aw==
X-Google-Smtp-Source: AGHT+IFytGm5v3MrxD8tbpqwSaaQU2+s/Ep8l2Re0UgFKnBOHSFmvMoYFLxSQLKhEV5P/YQMsaGEww==
X-Received: by 2002:a05:620a:400b:b0:7a7:fef9:f608 with SMTP id af79cd13be357-7a9e5f878c3mr3488019685a.52.1726686681705;
        Wed, 18 Sep 2024 12:11:21 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acb08dae51sm2275885a.122.2024.09.18.12.11.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2024 12:11:21 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [RFT v2 0/3] brcmfmac: external auth support for Infineon devices
Date: Wed, 18 Sep 2024 21:11:06 +0200
Message-Id: <20240918191109.41960-1-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.32.0
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
external auth. Hence this is a request for testing for people who do
before submitting as formal patch series. Before testing the firmware
features can be checked through debugfs file 'fwcap' to assure the
'sae_ext' feature is present.

Changes:
  v2:
	- address build issue reported by <lkp@intel.com>

Arend van Spriel (3):
  wifi: brcmfmac: support per-vendor cfg80211 callbacks and firmware
    events
  wifi: brcmfmac: make per-vendor event map const
  wifi: brcmfmac: cyw: support external SAE authentication in station
    mode

 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  44 ++-
 .../broadcom/brcm80211/brcmfmac/cfg80211.h    |  25 ++
 .../broadcom/brcm80211/brcmfmac/common.c      |   1 +
 .../broadcom/brcm80211/brcmfmac/core.c        |   2 +
 .../broadcom/brcm80211/brcmfmac/cyw/core.c    | 308 ++++++++++++++++++
 .../brcm80211/brcmfmac/cyw/fwil_types.h       |  84 +++++
 .../broadcom/brcm80211/brcmfmac/feature.c     |   3 +-
 .../broadcom/brcm80211/brcmfmac/feature.h     |   4 +-
 .../broadcom/brcm80211/brcmfmac/fweh.c        |   7 +-
 .../broadcom/brcm80211/brcmfmac/fweh.h        |   8 +-
 .../broadcom/brcm80211/brcmfmac/fwvid.h       |  29 ++
 11 files changed, 492 insertions(+), 23 deletions(-)
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h


base-commit: 5a4d42c1688c88f3be6aef46b0ea6c32694cd2b8
-- 
2.32.0


