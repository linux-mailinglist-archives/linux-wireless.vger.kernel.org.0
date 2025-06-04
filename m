Return-Path: <linux-wireless+bounces-23680-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FC8ACDA5B
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 10:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8C2B1895DF2
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 08:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE0F1EDA04;
	Wed,  4 Jun 2025 08:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DKnFrOF/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DD41804A
	for <linux-wireless@vger.kernel.org>; Wed,  4 Jun 2025 08:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749027349; cv=none; b=lAV2T6cLCGnh6M9rhlouNuHJkiA1TnvZGiECSBEJW58cOmuSdwu4Api9sJ9IxCuBlcpv82BwDCTyysVCDgRNt4VfSMWccdluF1DsIw+/wlzP94ZkoVbbWPNkA3c+fX3Jn2ejcUf9PU1BViAJSAKcaBOaCOUVvrmcLSf5uDbKZyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749027349; c=relaxed/simple;
	bh=6hHp/Awh1FhOfOPS4xdPMFToVX2HzERItM9piZXQNx0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nEfa5yjtfVnvELS3qlbuHgMnmla6uM4tIaak470ZU51/Zy/zVdFvEqtvNWhv3xGFdviXQGubpLBnpIBJrVSdRHKPQAlsWlmC8SHEwKV1sM5kSVb+D9rTDzvb3M3sh4o+0ERRPszFm85YzR0oy6k3L/ZPCo5UgrX8SY/1aphG2pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DKnFrOF/; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a36efcadb8so5513086f8f.0
        for <linux-wireless@vger.kernel.org>; Wed, 04 Jun 2025 01:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1749027346; x=1749632146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y2y4fSm9Q4/lc9XkmVRnaW1rCfsvHl7po2HGQF5ZOPo=;
        b=DKnFrOF/IH96F9CxxessWIQwO9nSRcYOALTqVTc1qJMnnpE1Q5h+kploBQ34RuzCeF
         2HkHWZG99azqGy6OGEtxBa3e8XHq8azhtPvlpvSFwnqeXkMZc1dftjJHAPtAdMLtRgPs
         +Z5oIGPI4NjktUBW/v0NyCeDIJRvhGnzf0aLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749027346; x=1749632146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y2y4fSm9Q4/lc9XkmVRnaW1rCfsvHl7po2HGQF5ZOPo=;
        b=oJSvjpUhkMjczLyCsXFo1slW8zOYjide2nWVn21L0zAtJ/7ymsRdgv6e+qVk2r0X9t
         JvCqidgTV/DJCZ6QEB0XUvyKQZ4sWZWPSxO5SO/C00f/8ubJ7qmE0NIJPelNuXAa+6Rt
         5dJc3rrdO/sV4AG9Y1jeBhfuMay8mYTfT/3jjUmHP3ST9iwi2/LPQEltLOjF76zjxR+y
         6P/aFJzMbyBjYW6xEfcYakH27DOJCoHk1m6N5XkOStG50XojkOYxwLSjwIZ3Fci0iZr7
         iIdIn1TiXLPVesNdicvlm1e1K9bNBmv/zrlv6S8TlrrriIWuWqMvwz0Vw9S17ZLJpZhV
         VYzA==
X-Gm-Message-State: AOJu0Yw3KL4n6GZueM2HblUPJ7/0ta+C1VZAtRFmNYOrkTZr+gWJuZc2
	vOCs5QPo3GNtahXrv1JBmlf30UO/HQ31u328IZj8Q4LoxtB+g50GvvQ7f+RQ/5EDSvEEGr2Iubc
	UvXhEMg==
X-Gm-Gg: ASbGnctmn8HCCZ0iPx03GCJ0RStwlrEUvUPqlJaQkZo6fa74wJxaN5O/5vxORAtR+aI
	1Tpec0RVyEZsAfr/4SgZYsCc3myIc/ZxAfSKLkoJ4cYMMdoIvB1DXbf5NFGEMsLka7pO3XT5NlC
	f1gy9lHg6sMV0873GjoFBItZtyCvVycFIK3u+cigw7zeHJoOqcdtZVLDMUWJwYBVYBqJy1vygpx
	3zH8P+MaXM9G8OaxiMJOHVp2s7O3HB0thrqIbEu5d4ZB4sFDD4BjqPapbp5VG1UpE+9r2I8u+Tc
	Vcz7pa62PcS8r0GGsNxrGWm1AcNI3aUoLGKKluzkqGL8uIJJoP78eBCCcbhzoBDiinY1bjI+xnS
	U3GTxtvqkj760fHO0Vt7FQRExjIInRS0=
X-Google-Smtp-Source: AGHT+IFfcCs9qc/nsp54S9qOdKlt7sOskk20daGgdeH6AuGyzZQxhTtR5fttEBjqDkiBgmcYsZ2WNQ==
X-Received: by 2002:a05:6000:420a:b0:3a4:dd63:4adf with SMTP id ffacd0b85a97d-3a51d968a18mr1452970f8f.34.1749027345910;
        Wed, 04 Jun 2025 01:55:45 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fb09a3sm189165695e9.24.2025.06.04.01.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 01:55:45 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [RFC 0/4] alternative changes for NL80211_CMD_SET_BSS support
Date: Wed,  4 Jun 2025 10:55:34 +0200
Message-ID: <20250604085539.2803896-1-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here a series with my idea on how to solve the fact that drivers may not
support or handle all parameters contained in NL80211_CMD_SET_BSS message
as sent by user-space. The driver can announce in the wiphy info which
parameters it supports and user-space can indicate that the kernel may
enforce strict checking for the NL80211_CMD_SET_BSS.

Arend van Spriel (3):
  wifi: nl80211: allow drivers to support subset of NL80211_CMD_SET_BSS
  wifi: drivers; indicate support for attributes in NL80211_CMD_SET_BSS
  wifi: nl80211: strict checking attributes for NL80211_CMD_SET_BSS

Wright Feng (1):
  brcmfmac: support AP isolation to restrict reachability between
    stations

 drivers/net/wireless/ath/wil6210/cfg80211.c   |  1 +
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 24 +++++++
 .../wireless/microchip/wilc1000/cfg80211.c    |  7 --
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  8 ---
 include/net/cfg80211.h                        | 30 +++++++++
 include/uapi/linux/nl80211.h                  |  7 ++
 net/mac80211/main.c                           |  1 +
 net/wireless/nl80211.c                        | 64 +++++++++++++++++--
 8 files changed, 122 insertions(+), 20 deletions(-)


base-commit: 1b98f357dadd6ea613a435fbaef1a5dd7b35fd21
--
2.43.5


