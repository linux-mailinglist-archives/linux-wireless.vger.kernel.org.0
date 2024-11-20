Return-Path: <linux-wireless+bounces-15530-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0869D36E0
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2024 10:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA1111F269E8
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2024 09:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E957119F101;
	Wed, 20 Nov 2024 09:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=formulatrix.com header.i=@formulatrix.com header.b="H6aEQaal"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089D719D06D
	for <linux-wireless@vger.kernel.org>; Wed, 20 Nov 2024 09:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732094257; cv=none; b=Do/xVIXrGWF2djoKoFiCcAlEGm9+JmvoOrnLVwc/CdbU9zSMBHNeOrZ5/dt+rOkZM7r41m9VngjHBn945OYkNlSY2G2zOnSXWcv4u41DTVtxzXXbQmDLUIZEzCC1yAEATGnSR/6OJg7ZkgOu//5Mh+M/qdfzoWCNh5jXesXT6Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732094257; c=relaxed/simple;
	bh=IZ6jzVkrBcmn1RvO9Kg/OEPrQfhC7jvMivLi8P6phgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ioIEAC3t56ZTaZ69RhgaPk1qpHuc84cAHuuhiPQUFJ+iyQ7w2AO7J+jNyPwZb8tMm/bIDshYAPpG6gYXMWsKD02jily90e3Bkx8L93My8T6hBbT8T/TYZ5PW4FaUZ77rZXfpQcb9zptELrz/ImWiVFZoZ03kQn+lvsqbVy5LBCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=formulatrix.com; spf=pass smtp.mailfrom=formulatrix.com; dkim=pass (1024-bit key) header.d=formulatrix.com header.i=@formulatrix.com header.b=H6aEQaal; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=formulatrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=formulatrix.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21270d64faeso2217975ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 20 Nov 2024 01:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=formulatrix.com; s=google; t=1732094255; x=1732699055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bsHNONFaqk43oNnRZWyT1/nNWm6QloTnFfX1mn6cx1s=;
        b=H6aEQaalP7XwKUcR5ZHSgssAt5inFPrqkdN9xL7BrCmDEHF+u5SbD8YvRNOW7cqEOG
         0PpiluIu3jApFCsNtWJ67yHUETJdbA2+7g48F4H98goC8kMtmjkfa+ZrlsbuNZvo1J7c
         FxsYhaDw+DsMj9hdGXtnFKKlQDM5zl7MqL47Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732094255; x=1732699055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bsHNONFaqk43oNnRZWyT1/nNWm6QloTnFfX1mn6cx1s=;
        b=gvk+A9goleLRAhQWPxvIUKJ/dv/KA/425j/paeYDwSF0mYLqHVox+O0VoukrRFScxq
         i2WlKZXAg9T7W98G2iIvLjzU6FnhaAPYn2UayESB1OJfyBjKjhnHs+ezSIW298ZyQgW1
         Mw6OIJyDQt6lhIe/vrSWJ04rVtkN7byjpBfAt+uV51zDOyo/qSgs8LpSzNWu35rJDT7+
         tbKxHbdvBrb18+lojmmAcuCuolOLN2wuf6tt6ZSmeEUXEnC0w8OAznz1TkxDOi/okDsS
         Y6O60RJD1UwI+lBcrrHIIZtF5hFqSSQy8yBgtd8+I18moH3/PxNZLSdJm/mt1wtP0LoA
         XkHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWb+E+ZvXn8WKEGRKBDSPpvSO1c2FtoQ6i72UisECrsvp5Q+ux46r8hbUnIa+9iTV1Zxj632DW7ipSM5m84uQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Y4nyphrLXZOISmFj4wgvcXp/uJHi26/zQ7ez84JewqAkA//y
	fTy7giteDa2wu4ZiNPsYxTxLBEyzL+yiOqeAL5Y7d+Av+QfSXmqJVH5osMxowg==
X-Google-Smtp-Source: AGHT+IHmfLOZ11KQdKWckfvGTxCQ+WKU1Ma+u7hHvjoo/qqPJ5waauqswtRLuCVnLIaLkAjbOynAQg==
X-Received: by 2002:a17:902:e804:b0:20c:bbac:2013 with SMTP id d9443c01a7336-2126b04804dmr26631675ad.48.1732094255255;
        Wed, 20 Nov 2024 01:17:35 -0800 (PST)
Received: from SE-151.formulatrix.internal ([36.73.154.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2124b56a3c3sm28139765ad.204.2024.11.20.01.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 01:17:34 -0800 (PST)
From: Renjaya Raga Zenta <renjaya.zenta@formulatrix.com>
To: johannes@sipsolutions.net
Cc: SHA-cyfmac-dev-list@infineon.com,
	arend.vanspriel@broadcom.com,
	aspriel@gmail.com,
	brcm80211-dev-list.pdl@broadcom.com,
	franky.lin@broadcom.com,
	hante.meuleman@broadcom.com,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org,
	marcan@marcan.st,
	wahrenst@gmx.net
Subject: Re: brcmfmac: Unexpected brcmf_set_channel: set chanspec 0xd022 fail, reason -52 - Part 2
Date: Wed, 20 Nov 2024 16:17:29 +0700
Message-ID: <20241120091729.57361-1-renjaya.zenta@formulatrix.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <1268ad6f22b61f1c9b3c7e20c45c1a0050aa3631.camel@sipsolutions.net>
References: <1268ad6f22b61f1c9b3c7e20c45c1a0050aa3631.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I've been observing this issue for a couple of days. I added pr_err (before and after) to debug this to find the culprit
who change the flags from 0x0001 to 0x80020. Please see below. I used Raspberry Pi 5 with kernel 6.6.51.

I think the flags are actually changed:

1) to 0x80000 in cfg80211.handle_channel_single_rule, then
2) to 0x80020 in cfg80211.reg_process_ht_flags_channel.

/* initial boot */

[    3.114181] cfg80211: handle_channel_custom: before hw_value: 0x0c, orig_flags: 0x0000, flags: 0x0000
[    3.123453] cfg80211: handle_channel_custom: after  hw_value: 0x0c, orig_flags: 0x0000, flags: 0x80180
[    3.132813] cfg80211: handle_channel_custom: before hw_value: 0x0d, orig_flags: 0x0000, flags: 0x0000
[    3.142074] cfg80211: handle_channel_custom: after  hw_value: 0x0d, orig_flags: 0x0000, flags: 0x80180
[    3.151421] cfg80211: handle_channel_custom: before hw_value: 0x0e, orig_flags: 0x0000, flags: 0x0000
[    3.160681] cfg80211: handle_channel_custom: after  hw_value: 0x0e, orig_flags: 0x0000, flags: 0x801b0
[    3.170030] cfg80211: handle_channel_custom: before hw_value: 0x22, orig_flags: 0x0000, flags: 0x0000
[    3.179291] cfg80211: handle_channel_custom: after  hw_value: 0x22, orig_flags: 0x0000, flags: 0x80000
[    3.188638] cfg80211: handle_channel_custom: before hw_value: 0x24, orig_flags: 0x0000, flags: 0x0000
[    3.197897] cfg80211: handle_channel_custom: after  hw_value: 0x24, orig_flags: 0x0000, flags: 0x80000
[    3.207245] cfg80211: handle_channel_custom: before hw_value: 0x26, orig_flags: 0x0000, flags: 0x0000
[    3.216512] cfg80211: handle_channel_custom: after  hw_value: 0x26, orig_flags: 0x0000, flags: 0x80000
[    3.225955] cfg80211: handle_channel_single_rule: before hw_value: 0x22, orig_flags: 0x80000, flags: 0x80000
[    3.235837] cfg80211: handle_channel_single_rule: after  hw_value: 0x22, orig_flags: 0x80000, flags: 0x80000
[    3.235841] cfg80211: handle_channel_single_rule: before hw_value: 0x24, orig_flags: 0x80000, flags: 0x80000
[    3.235843] cfg80211: handle_channel_single_rule: after  hw_value: 0x24, orig_flags: 0x80000, flags: 0x80000
[    3.265464] cfg80211: handle_channel_single_rule: before hw_value: 0x26, orig_flags: 0x80000, flags: 0x80000
[    3.275338] cfg80211: handle_channel_single_rule: after  hw_value: 0x26, orig_flags: 0x80000, flags: 0x80000
[    3.285218] cfg80211: reg_process_ht_flags_channel: before hw_value: 0x0c, orig_flags: 0x80180, flags: 0x80181
[    3.295270] cfg80211: reg_process_ht_flags_channel: before hw_value: 0x0d, orig_flags: 0x80180, flags: 0x80181
[    3.305318] cfg80211: reg_process_ht_flags_channel: before hw_value: 0x0e, orig_flags: 0x801b0, flags: 0x801b1
[    3.305320] cfg80211: reg_process_ht_flags_channel: before hw_value: 0x22, orig_flags: 0x80000, flags: 0x80000
[    3.305323] cfg80211: reg_process_ht_flags_channel: after  hw_value: 0x22, orig_flags: 0x80000, flags: 0x80020
[    3.335460] cfg80211: reg_process_ht_flags_channel: before hw_value: 0x24, orig_flags: 0x80000, flags: 0x80000
[    3.335462] cfg80211: reg_process_ht_flags_channel: after  hw_value: 0x24, orig_flags: 0x80000, flags: 0x80020
[    3.335463] cfg80211: reg_process_ht_flags_channel: before hw_value: 0x26, orig_flags: 0x80000, flags: 0x80000
[    3.335465] cfg80211: reg_process_ht_flags_channel: after  hw_value: 0x26, orig_flags: 0x80000, flags: 0x80000
[    3.406614] brcmfmac: brcmf_construct_chaninfo: hw_value: 0x0c, orig_flags: 0x80180, flags: 0x0001
[    3.415666] brcmfmac: brcmf_construct_chaninfo: hw_value: 0x0d, orig_flags: 0x80180, flags: 0x0001
[    3.424668] brcmfmac: brcmf_construct_chaninfo: hw_value: 0x0e, orig_flags: 0x801b0, flags: 0x0001
[    3.433669] brcmfmac: brcmf_construct_chaninfo: hw_value: 0x22, orig_flags: 0x80000, flags: 0x0001
[    3.442668] brcmfmac: brcmf_construct_chaninfo: hw_value: 0x24, orig_flags: 0x80000, flags: 0x0120
[    3.451667] brcmfmac: brcmf_construct_chaninfo: hw_value: 0x26, orig_flags: 0x80000, flags: 0x0001
[    3.464673] brcmfmac: brcmf_setup_wiphybands: hw_value: 0x0c, orig_flags: 0x80180, flags: 0x0001
[    3.473504] brcmfmac: brcmf_setup_wiphybands: hw_value: 0x0d, orig_flags: 0x80180, flags: 0x0001
[    3.482336] brcmfmac: brcmf_setup_wiphybands: hw_value: 0x0e, orig_flags: 0x801b0, flags: 0x0001
[    3.491162] brcmfmac: brcmf_setup_wiphybands: hw_value: 0x22, orig_flags: 0x80000, flags: 0x0001
[    3.499988] brcmfmac: brcmf_setup_wiphybands: hw_value: 0x24, orig_flags: 0x80000, flags: 0x0120
[    3.508812] brcmfmac: brcmf_setup_wiphybands: hw_value: 0x26, orig_flags: 0x80000, flags: 0x0001

/* wpa_supplicant connect, the flags are changed here */

[   10.493324] cfg80211: handle_channel_single_rule: before hw_value: 0x22, orig_flags: 0x80000, flags: 0x0001
[   10.503174] cfg80211: handle_channel_single_rule: after  hw_value: 0x22, orig_flags: 0x80000, flags: 0x80000
[   10.513094] cfg80211: handle_channel_single_rule: before hw_value: 0x24, orig_flags: 0x80000, flags: 0x0120
[   10.522898] cfg80211: handle_channel_single_rule: after  hw_value: 0x24, orig_flags: 0x80000, flags: 0x80000
[   10.532785] cfg80211: handle_channel_single_rule: before hw_value: 0x26, orig_flags: 0x80000, flags: 0x0001
[   10.542601] cfg80211: handle_channel_single_rule: after  hw_value: 0x26, orig_flags: 0x80000, flags: 0x80000
[   10.552496] cfg80211: reg_process_ht_flags_channel: before hw_value: 0x0c, orig_flags: 0x80180, flags: 0x0001
[   10.562479] cfg80211: reg_process_ht_flags_channel: before hw_value: 0x0d, orig_flags: 0x80180, flags: 0x0001
[   10.572453] cfg80211: reg_process_ht_flags_channel: before hw_value: 0x0e, orig_flags: 0x801b0, flags: 0x0001
[   10.582438] cfg80211: reg_process_ht_flags_channel: before hw_value: 0x22, orig_flags: 0x80000, flags: 0x80000
[   10.592498] cfg80211: reg_process_ht_flags_channel: after  hw_value: 0x22, orig_flags: 0x80000, flags: 0x80020
[   10.602557] cfg80211: reg_process_ht_flags_channel: before hw_value: 0x24, orig_flags: 0x80000, flags: 0x80000
[   10.612624] cfg80211: reg_process_ht_flags_channel: after  hw_value: 0x24, orig_flags: 0x80000, flags: 0x80020
[   10.622683] cfg80211: reg_process_ht_flags_channel: before hw_value: 0x26, orig_flags: 0x80000, flags: 0x80000
[   10.632740] cfg80211: reg_process_ht_flags_channel: after  hw_value: 0x26, orig_flags: 0x80000, flags: 0x80000

/* wpa_supplicant disconnect */

[   78.902910] cfg80211: handle_channel_single_rule: before hw_value: 0x22, orig_flags: 0x80000, flags: 0x80000
[   78.912850] cfg80211: handle_channel_single_rule: after  hw_value: 0x22, orig_flags: 0x80000, flags: 0x80000
[   78.922781] cfg80211: handle_channel_single_rule: before hw_value: 0x24, orig_flags: 0x80000, flags: 0x80000
[   78.932705] cfg80211: handle_channel_single_rule: after  hw_value: 0x24, orig_flags: 0x80000, flags: 0x80000
[   78.942623] cfg80211: handle_channel_single_rule: before hw_value: 0x26, orig_flags: 0x80000, flags: 0x80000
[   78.952518] cfg80211: handle_channel_single_rule: after  hw_value: 0x26, orig_flags: 0x80000, flags: 0x80000
[   78.962433] cfg80211: reg_process_ht_flags_channel: before hw_value: 0x0c, orig_flags: 0x80180, flags: 0x80181
[   78.972500] cfg80211: reg_process_ht_flags_channel: before hw_value: 0x0d, orig_flags: 0x80180, flags: 0x80181
[   78.982563] cfg80211: reg_process_ht_flags_channel: before hw_value: 0x0e, orig_flags: 0x801b0, flags: 0x801b1
[   78.992623] cfg80211: reg_process_ht_flags_channel: before hw_value: 0x22, orig_flags: 0x80000, flags: 0x80000
[   79.002694] cfg80211: reg_process_ht_flags_channel: after  hw_value: 0x22, orig_flags: 0x80000, flags: 0x80020
[   79.012765] cfg80211: reg_process_ht_flags_channel: before hw_value: 0x24, orig_flags: 0x80000, flags: 0x80000
[   79.022835] cfg80211: reg_process_ht_flags_channel: after  hw_value: 0x24, orig_flags: 0x80000, flags: 0x80020
[   79.032891] cfg80211: reg_process_ht_flags_channel: before hw_value: 0x26, orig_flags: 0x80000, flags: 0x80000
[   79.042969] cfg80211: reg_process_ht_flags_channel: after  hw_value: 0x26, orig_flags: 0x80000, flags: 0x80000

/* wpa_supplicant re-connect */

[  156.971916] brcmfmac: brcmf_set_channel: set chanspec 0xd022 fail, reason -52
[  157.087904] brcmfmac: brcmf_set_channel: set chanspec 0xd026 fail, reason -52
[  157.199928] brcmfmac: brcmf_set_channel: set chanspec 0xd02a fail, reason -52
[  157.310944] brcmfmac: brcmf_set_channel: set chanspec 0xd02e fail, reason -52
[  159.774209] cfg80211: handle_channel_single_rule: before hw_value: 0x22, orig_flags: 0x80000, flags: 0x80020
[  159.784166] cfg80211: handle_channel_single_rule: after  hw_value: 0x22, orig_flags: 0x80000, flags: 0x80000
[  159.794073] cfg80211: handle_channel_single_rule: before hw_value: 0x24, orig_flags: 0x80000, flags: 0x80020
[  159.803977] cfg80211: handle_channel_single_rule: after  hw_value: 0x24, orig_flags: 0x80000, flags: 0x80000
[  159.813887] cfg80211: handle_channel_single_rule: before hw_value: 0x26, orig_flags: 0x80000, flags: 0x80000
[  159.823792] cfg80211: handle_channel_single_rule: after  hw_value: 0x26, orig_flags: 0x80000, flags: 0x80000
[  159.833689] cfg80211: reg_process_ht_flags_channel: before hw_value: 0x0c, orig_flags: 0x80180, flags: 0x801b1
[  159.843751] cfg80211: reg_process_ht_flags_channel: before hw_value: 0x0d, orig_flags: 0x80180, flags: 0x801b1
[  159.853814] cfg80211: reg_process_ht_flags_channel: before hw_value: 0x0e, orig_flags: 0x801b0, flags: 0x801b1
[  159.863889] cfg80211: reg_process_ht_flags_channel: before hw_value: 0x22, orig_flags: 0x80000, flags: 0x80000
[  159.873958] cfg80211: reg_process_ht_flags_channel: after  hw_value: 0x22, orig_flags: 0x80000, flags: 0x80020
[  159.884038] cfg80211: reg_process_ht_flags_channel: before hw_value: 0x24, orig_flags: 0x80000, flags: 0x80000
[  159.894100] cfg80211: reg_process_ht_flags_channel: after  hw_value: 0x24, orig_flags: 0x80000, flags: 0x80020
[  159.904187] cfg80211: reg_process_ht_flags_channel: before hw_value: 0x26, orig_flags: 0x80000, flags: 0x80000
[  159.914248] cfg80211: reg_process_ht_flags_channel: after  hw_value: 0x26, orig_flags: 0x80000, flags: 0x80000


Is there any workaround for this or is this behavior expected?

Regards.

Renjaya

