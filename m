Return-Path: <linux-wireless+bounces-20902-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8FEA741C2
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 01:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 105073B0ACC
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 00:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435DB13DBB1;
	Fri, 28 Mar 2025 00:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYTAkodK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F2928373
	for <linux-wireless@vger.kernel.org>; Fri, 28 Mar 2025 00:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743122204; cv=none; b=rpfjggDPHZM3Q0ov0nyCqSY8TRFpsiRf84DVKH5HqMuX5CG+Cp6VU9+8Eh3Pq6I/d6VlSOMGbdYRmLoSSGE6ROEvYIwFO8zOz/d+w9GtRg4lx20hyVqzqe2J51j3dhvLgRVAfzQnCu4GB/yQDj9ZBoaMvVV0EXrHoZEkAdHm50s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743122204; c=relaxed/simple;
	bh=1uII/cyHRCshxvLRtMflHYwuF0oXNl9307h44MCYgTg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hMnWrx0TbreLYPapqAFmRAWhrl5BVddj8qSrI8nA2GaE+E9DRHBsGyTJpiJsDtu+4M376OMEIXmVnkalZ08235MxiWZXVK2/oeay7e5h8AXO2X2QXaz3E00uxynWqdn+pdA+k43KkG5gdL6qIXKg810CXLCa38HuuelQIaEoIAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYTAkodK; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3996af42857so1770183f8f.0
        for <linux-wireless@vger.kernel.org>; Thu, 27 Mar 2025 17:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743122201; x=1743727001; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qV8grmpi1aEvGUG0oyJ8akE8G0+45KOa5Xv7UHoo2Dk=;
        b=UYTAkodKCIIZY6ggdoD24Nm0GMApOKvm6nfKHL6EPJ2qY2dtWpBVyMzicMTQS7/FZ/
         g2pOb4Ih5lg20Ox9n6HfYIwPULh7u63Aj35YH7xFZhmmWqGQ6GalriiIuKzxmGRnu1wN
         HEl7wzpmR5IW7fnVdCU1kmGYEGcKRhtgi8MPHT0ZfKBNP85Z8YSP4zFZKpTHF48mOtK3
         oMBBvPY6C0P2Z6wT55bPtAVo3hnTe22TOKjHZY5Wk3dIF6nCTI3JY7c/iqYAovoY6EwT
         TqBrNXqedICCm0Q9ZifhGZZji7kt9o/NbAC0Ip1bCDOyMy7o0t4Z2m9qYII29/gMN2tA
         PoLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743122201; x=1743727001;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qV8grmpi1aEvGUG0oyJ8akE8G0+45KOa5Xv7UHoo2Dk=;
        b=sqvAwouKgTR/pwswjrnt5gB04uo7AAITqgYZalh2O880oFU8010K2zrNQm9819OFdq
         xUb8k8bll1vX5SWlDGf3W96jkmLDAO1T+QJHaIEQcnFFZVX6qIwKr+4LC4CyT1sDefVk
         HxVV8SzHX5F9dFvoBlFfOb7d6saCOT4G3DPRMjgRV02B463pHDG2fo4rH78zr4xwE1w9
         mDpw2Rl9rn4bpGGh2iJxszg3VuWY/c4UStCVHrQadJZJL+iF+jXtiTVC+6dzcun/U6nz
         MoctiitDZPOVoi480YT6qq1R60IZN7MdgmIxjzSTuDfHoLcE9huN7/V7ifX4upk8A7wh
         ifvg==
X-Gm-Message-State: AOJu0Yx0xl3WB6CEHxRBGjeXeS/3pf6RkTWp3rBwQPbVJ91q6db5CiAA
	GTvrPEbew5pPmgq5G6Xhox9nsVtJ5zwm192oJa+dbd9a8/q6jHbk
X-Gm-Gg: ASbGnctpQ8288YRPOTs3GYGcag53avqZLPldpcCuDVYrrS19PBti4JfGZtxN7dOqkK+
	jk56G5gTrNgylsNl57swd84nf5oGQY1iNHqgjrJxme3HoxRKV0aACaz3zKZ1e8GykJk5ayqi0g2
	lIWtfqSq2T0O8nQ6vjDf1df7WWxt6qfsZH8lUHxMj5a0GBvW64P2s3Q8RrOPOLNS5s0IwiV8Qcu
	o7ocxScJ3uGtfbDjDrxnGvS8GQtsiaX+AH4LuVL2mRgKGagabPeuVy+nZxUTGU/mvVkZ5ECY90L
	yrXoKFcFNuYJsnFUo9qxZyLv/wHgkC8YbYBmzntoriZILlYft0UNx2JA0invvtZ10aQ=
X-Google-Smtp-Source: AGHT+IEVwI1RraT3wQd9MTFlOt+UOzbpLxT0PvFHkrm6cZHemZMbCzSqwRu1DpwrXojzv26fJuOhrQ==
X-Received: by 2002:a5d:59a3:0:b0:390:f9d0:5e7 with SMTP id ffacd0b85a97d-39c0c5a05acmr513916f8f.13.1743122200460;
        Thu, 27 Mar 2025 17:36:40 -0700 (PDT)
Received: from debian.local ([2a0a:ef40:4d4:f101:e41a:977a:f788:910f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b7a4318sm965126f8f.87.2025.03.27.17.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 17:36:40 -0700 (PDT)
Date: Fri, 28 Mar 2025 00:36:38 +0000
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>,
	"Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
	"Berg, Johannes" <johannes.berg@intel.com>,
	"benjamin@sipsolutions.net" <benjamin@sipsolutions.net>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: [REGRESSION] iwlwifi: probe with driver iwlwifi failed with error -22
Message-ID: <Z-XvFvGigpY7JYFn@debian.local>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Laptop: Lenovo Legion 7 16ACHg6.
Wifi: Killer(R) Wi-Fi 6 AX1650x 160MHz Wireless Network Adapter (200NGW)
04:00.0 Network controller [0280]: Intel Corporation Wi-Fi 6 AX200 [8086:2723] (rev 1a)

Wifi stopped working in recent kernel builds:

[   20.907824] Intel(R) Wireless WiFi driver for Linux
[   20.907955] iwlwifi 0000:04:00.0: enabling device (0000 -> 0002)
[   20.912024] ee1004 2-0050: 512 byte EE1004-compliant SPD EEPROM, read-only
[   20.913666] NET: Registered PF_BLUETOOTH protocol family
[   20.913670] Bluetooth: HCI device and connection manager initialized
[   20.913806] Bluetooth: HCI socket layer initialized
[   20.913810] Bluetooth: L2CAP socket layer initialized
[   20.913828] Bluetooth: SCO socket layer initialized
[   20.917455] iwlwifi 0000:04:00.0: Detected crf-id 0x3617, cnv-id 0x100530 wfpm id 0x80000000
[   20.917674] iwlwifi 0000:04:00.0: PCI dev 2723/1654, rev=0x340, rfid=0x10a100
[   20.917679] iwlwifi: No config found for PCI dev 2723/1654, rev=0x340, rfid=0x10a100
[   20.920126] iwlwifi 0000:04:00.0: probe with driver iwlwifi failed with error -22

Bisect led to:

commit 75a3313f52b7e08e7e73746f69a68c2b7c28bb2b (HEAD)
Author: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Date:   Wed Feb 5 14:55:42 2025 +0200

    wifi: iwlwifi: make no_160 more generic

    We'll have devices that are EHT capable but don't support 320 MHz and
    those devices look like the 320 MHz capable devices, but have distinct
    subsystem ID.
    We already had the same type of differentiation for HE devices that
    support 160 MHz or not.
    Enhance that mechanism and now the _IWL_DEV_INFO macro gets an
    indication whether the bandwidth should be limited for that specific
    device.
    The subsystem ID gives a binary answer about the bandwidth limitation
    and iwl_pci_find_dev_info() compares this to the list of _IWL_DEV_INFO
    entries.

    Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    Reviewed-by: Johannes Berg <johannes.berg@intel.com>
    Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
    Link: https://patch.msgid.link/20250205145347.1ba406c538a5.I6e24123f60a764aedfeaaac8768c26e136c320cf@changeid
    Signed-off-by: Johannes Berg <johannes.berg@intel.com>

#regzbot introduced: 75a3313f52b7e08e7e73746f69a68c2b7c28bb2b

