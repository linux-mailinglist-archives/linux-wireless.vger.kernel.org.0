Return-Path: <linux-wireless+bounces-3385-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C57B84F4BB
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 12:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1872B1F22F48
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 11:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CC62E400;
	Fri,  9 Feb 2024 11:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Znk2Ypva"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809732C1B1
	for <linux-wireless@vger.kernel.org>; Fri,  9 Feb 2024 11:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707478541; cv=none; b=fx/rCWbWaOGveGhqmKhmPkzPuW5Px9/Nw4g8Oeza5OJfianxC5rS6nG7TXfo/XtUbfG8YwNuenMezlJVAMsyyHxR6bVc2rXeT4JfdDkuVjPDYggwl5GEb2gTW+L4dyxeiKtwKJF6jf8cpMI9cdpR216iv0sx3lKAue4eCL4Y4nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707478541; c=relaxed/simple;
	bh=hQhn+O+PdOYD6x8VpewWB+AO/rwZ+xyqJVT3EkYvh+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uKAVhOqA4ODIxrf+Ar/rj0sKYZkxl9rRDN74lNiL5wy2j1Q6Znj+SyOSgOdZjN9q3i1hRC6hJz4gMLfHdwI+J3X1ol4sVGKUAqecwcQZMuR3+urYtQuJ+sdkyZadBHsyWmVY7QSW7kzSiFSkGCEbFzARJLMsCEpywzqEP/B7PJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Znk2Ypva; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5116b540163so1297836e87.1
        for <linux-wireless@vger.kernel.org>; Fri, 09 Feb 2024 03:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707478537; x=1708083337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uk7cGinUO6+MfI61MsY5TQbnfLIywEj+F5dM3m4tTkY=;
        b=Znk2Ypvawlndr1WlEw34r+H4MD/Lr9nJGDlMzGum7OlEag08Q33TaGcTF9/jgAga51
         64BlqMF9pBcuNq5EJsbDi4AKFpMC2uymLq4lAsm4ooHU9QJMpyQyNRqVoKlUoYSYkQaQ
         FjYkQcRcpO7DXbb2DKY3veKVeVXzSktZPyhy+j0z8G0A09jgZFnVCYmH2uaxCQdMujS3
         Ml1Gp6Y8ibJBpja5N2krSo7f5E2BCcgXYbnCv6MNE+OEb2jjaZvtRaHIqteH+KTjEvAy
         7if2cTvSwrlw4JAZDOO2FyRptdabAt+RNLcACtRzWlbQkWxJhJ+21FMrjgsObkInyUuY
         DEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707478537; x=1708083337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uk7cGinUO6+MfI61MsY5TQbnfLIywEj+F5dM3m4tTkY=;
        b=i1QK6WOiGM0x9d2leckkLA2/Rzxpy7RrdeQPQXRzFNPjy/B6YFvOJ+xFWJdEZS/R1t
         NvBn2WTjr6FOu81uj8TYBvma5SUB4ZXHJN0ab1kecrBNzErfx/U/f9otY37bVBgUHy3M
         VJKFhKTCqltvsSYtnFhIDpxvHmwm3bLKCxD5O8uZLqXZKEiKGYGOY9DouKG0qajPjM3z
         X+l49jRzZcNjfYn2oDseDmZwzGu60Wh8H6R0V6tqRv1Fc2pmxg1anID6LiyJ+XJAwuTq
         oMWPNjmUdBfh2O0f2favqChxuK3rkOdHfXr+7DIGPNF7269tdDCdaMBc834ZopRJ3oZL
         /Kkg==
X-Gm-Message-State: AOJu0YzqxDv+Eo+Jca+lsT5u3RjbbvevOsItHdxzU33hUHMOnDOshuIF
	2iwi44WHNxqGApk4zctBXhzMoOq4sfHCBhusbv6+1Z/jf3tbrxr7IlRYe827
X-Google-Smtp-Source: AGHT+IESjeCN+0gm1Cygx51rfe4zfSqRMK4u0AGeQhiAmkARA2syogLJyHdfIlwOgqccslSrRrG8tA==
X-Received: by 2002:a19:e048:0:b0:511:7abd:e64c with SMTP id g8-20020a19e048000000b005117abde64cmr620697lfj.23.1707478537207;
        Fri, 09 Feb 2024 03:35:37 -0800 (PST)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id y18-20020a1c4b12000000b00410723b14e4sm346251wma.19.2024.02.09.03.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 03:35:36 -0800 (PST)
From: Nicolas Escande <nico.escande@gmail.com>
To: ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v2 0/2] wifi: ath11k: fix layout of scan_flags in struct scan_req_params
Date: Fri,  9 Feb 2024 12:35:34 +0100
Message-ID: <20240209113536.266822-1-nico.escande@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As previously discussed in [1] we have a mismatch in struct scan_req_params
between the bitfield scan_f_xxx & the scan_flags when used with WMI_SCAN_XXX
values.

To fix the issue & prevent it from happenning again lets stop using & remove
scan_flags altogether in the driver and only use the bitfield instead. That way
even if the bitfield doesn't match the WMI_SCAN_XXX flags, the right value will
still be sent through the wmi command to the firmware (see
ath11k_wmi_copy_scan_event_cntrl_flags).

Questions:
  - In the same rationale shouldn't we remove scan_events from the same struct ?
  - The same goes for ath12k, should I send a seperate patch or respin a v3 with
    similar patches for ath12k ?

[1] https://lore.kernel.org/all/20231127180559.1696041-1-nico.escande@gmail.com/

v2:
  - remove explicit uses of scan_flags with WMI_SCAN_XXX flags
  - remove the underlying union of scan_flags to only leave the bitfield

Nicolas Escande (2):
  wifi: ath11k: Do not directly use scan_flags in struct scan_req_params
  wifi: ath11k: remove scan_flags union from struct scan_req_params

 drivers/net/wireless/ath/ath11k/mac.c |  6 +--
 drivers/net/wireless/ath/ath11k/wmi.c |  2 +-
 drivers/net/wireless/ath/ath11k/wmi.h | 55 ++++++++++++---------------
 3 files changed, 29 insertions(+), 34 deletions(-)

-- 
2.43.0


