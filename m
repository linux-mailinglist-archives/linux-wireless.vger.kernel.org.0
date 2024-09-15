Return-Path: <linux-wireless+bounces-12869-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 637E19796F2
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Sep 2024 16:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26588282128
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Sep 2024 14:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C92D1C5789;
	Sun, 15 Sep 2024 14:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Y17Baf67"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB5E335C7
	for <linux-wireless@vger.kernel.org>; Sun, 15 Sep 2024 14:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726408874; cv=none; b=g3qf0PnsTRcXhcfoYCHtHtQ4D2H3k0/i+KWylBZTGwp4fXyY6ekPERBV7pK86mD4Stxh+Gv2z5mzKJljaLklbOuif5yWRlQ3nx45+/PPml751BzAH57F+JE6fRO2QIrD0Ejn2AEhhCxsWgRxZBVAfUgQKj5eSGr9++RjmaYtG10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726408874; c=relaxed/simple;
	bh=a+0uL7m0OC2siKcEU3XeOFMt04QXcrLXRC1IKqOBsZI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MxP76ueg9xSVPoKKuGyLagt3sh4aJSLMaD74Aj64j6dx8I2AWKu+sd4W8XTdu7Yf02l46YqHSN2rLMJtCy1dGPzSaSMIoz5Dw/SE2lwMss8W+9P57Sm+brTCeXlfnGcXsQPRqHwQg50vJ8Sa+0Jm677DPIJvp7HRETF0+j9KF6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Y17Baf67; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7191ee537cbso2585636b3a.2
        for <linux-wireless@vger.kernel.org>; Sun, 15 Sep 2024 07:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726408872; x=1727013672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XzjXCELMn5sAp75jFiBMFegVOo/PxDiQoVaRfxu8460=;
        b=Y17Baf67lGs7hA7gy+ywQ6WLzOE7C44EPl6TP3AoWpOCQrVdgNgeTb7OjItho5p6B2
         NRGMoLyJ0CjOce4gzfkp0KB7KkQHOaPkvi0uxFNyhk4QOj03uSNOny8ca8fSYAnHA8Tg
         7YDJQ/QpDFPfqnbQ8QFPBN2L0t6u7rdJc6Z94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726408872; x=1727013672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XzjXCELMn5sAp75jFiBMFegVOo/PxDiQoVaRfxu8460=;
        b=WlEyxivLreaGzw8ugkDvce7lQNoiSlynwUKrn3bxiboXqGLqioBPm1Wm2ATduTqbPr
         WONi6ofMHtJudPE0+Fkp7Yo1gqSnwuRmtBdk+O9/o71zaY5GROInNtwMn4sk5wHGKXWN
         GewNMp6x2DjmewmWBo0uaUJIDQ3udANs0smwoikb5LU6n5ihhodXrrqMQJYRpYViR6cY
         xk6Jsk9MTX6Iwi+xc6MP+FC2bIm5yGkb6+dZ8rRASzTIcK4cO4XsAdnYVW/x/ryUnpDf
         Ka+VXc2XyvsYS/96qGUW9gnJ7G39C0WEKCOkApC3AYXRY1y4QNoaUQH0izJdnyqcl/iZ
         JOHA==
X-Gm-Message-State: AOJu0YyNxMUhlmmiSwiA33FPpaCHsRp0mD+XiMnJVmdBaG4qBSg8o5Vs
	F5r/LyXFSY9Inv62lapBjyFvQzdNUvRUSb8tvzizVdqsQobZQDlg4jchOIARYQ==
X-Google-Smtp-Source: AGHT+IGQxzsRD+xIYHyePMLG931w0ChJOtyukmJq2dUqPEjupy3TUcIYWpdNBMHO7RBtVPZIwGQC9Q==
X-Received: by 2002:a05:6a21:1698:b0:1d2:ba7c:d8cf with SMTP id adf61e73a8af0-1d2ba7cdebcmr4924670637.7.1726408871876;
        Sun, 15 Sep 2024 07:01:11 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944ab50d6sm2233511b3a.75.2024.09.15.07.01.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Sep 2024 07:01:11 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [RFT 0/3] brcmfmac: external auth support for Infineon devices
Date: Sun, 15 Sep 2024 16:00:46 +0200
Message-Id: <20240915140049.181380-1-arend.vanspriel@broadcom.com>
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


base-commit: 34c44eb31de9cb7202ff070900463d6c706392c4
-- 
2.32.0


