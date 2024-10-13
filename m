Return-Path: <linux-wireless+bounces-13929-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBE099B92C
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Oct 2024 13:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D339E1F217AF
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Oct 2024 11:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAD313D245;
	Sun, 13 Oct 2024 11:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Mp00CnmF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7E61E495;
	Sun, 13 Oct 2024 11:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728818381; cv=none; b=TWOinhZ4QQlgSmNtv8oDlkBWQeZ0f1GDEcxAl2m5V7Us6q60n3S9oQavLC3iRj1XRAYhoxG0RBt7w/iMurjyZn9bnhxunCIBu/xlYyrc61RmZXl8Dj9kyrSyofUiMRYHTBkr7VwgSIPf5laqqYA3n6n3uoJ72UgbKzaAoSKisIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728818381; c=relaxed/simple;
	bh=dQIhx85P5+avHvO6BNKpI2DsjSrClwyn3dzCv19zTLc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZOkn9oupuGZTVa7BQkdk8NYQWhfGFhff1hzG9Zy/UkSqudBFD8djgDaDPPHe47yE+aQAcfKzp2KJW78oCC8cV+15ytKMLUZpcQgudgDMtfwGGII8hlLLniOn4eadc3hISHJR/y1U+ts7WMweHg5EyfeQEZcE0OndOLG2phgLyZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Mp00CnmF; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c94c4ad9d8so2622256a12.2;
        Sun, 13 Oct 2024 04:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1728818377; x=1729423177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a78jCwD07IIr0zzbJdTp9e6+G/hl6TYZEf6UvVEfM8c=;
        b=Mp00CnmF3D89I7WflRb33xeyv6KNOQt5RrVT7cCcJx9m11AurHinuhd/LBQ6IHliH2
         YcL64O5rxn0DH03abVF3n9Q6pstC8+l+No4fIXnjws+NTRzyiClgaPrx54NrVg8D8596
         nDXOz7CaXbDsfIepSBSPG0xh409DsARbjPLWOyDEI24mIPhpN6TSkC1NzTVqgTYwrdNa
         pqLwWtBIsI6CGYXSQNPpN8SDuC6wrGkDVYmdIj4CYfKeI16sTJkEdZK7oy5F6Z+tjJrL
         xsz75KdcLum34A2CAnaub2NMgmRvAGfc3aemo4t1BY3mugDp6SLb8zee/4fRtK6crccs
         BuBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728818377; x=1729423177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a78jCwD07IIr0zzbJdTp9e6+G/hl6TYZEf6UvVEfM8c=;
        b=FzArJWDHCko5KVOoZQbfU6AWYughpsnCVyHvnZQDuMeGxU12PXSuJo1FJsPPnaH8vw
         4JQD9s5FsYhDeY+M0D/HZcHt/z+KFhvYR4QqaKm37ORegl179/Dcjb0MrYOgOnVvOfFe
         oGjRh/QUncO3RS5LErHJfYWr47QiFZN18msX8fRlWo0bFQZsB7cdtXAKutzCvyrbvtzP
         Cd/Pg3TYF5UvUBTFeSe1ViHk87SaRT+kngnLz1YM/nuZRLLo3a9PcmwySbQu3Gwep192
         CbTuD9G446NX5SkrYcGVlkgmKs9zQTKC9MmRpdBUV85lsAcHCy8GlZeETipMUhGaj4HI
         deSA==
X-Forwarded-Encrypted: i=1; AJvYcCXUBMOiwBX93dnWyf6R6oK5WBCya77pQdwje8EFIoMyLxfHXot+MXxPbCNf4yWpwOjpZDNeXr/1pAz5o3g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy01I4JVXMoPaFvnboiLRpkCe6ypKp+ZDwDgQGVn9vP/pMqtAhh
	GPyK5tjXV81hxWiTEp0J3lDcuqQcaLmcR3TYHgDLh5MuEVkh4zjEZ4+Jbw==
X-Google-Smtp-Source: AGHT+IHJ6a9mQsJnncdL0rnghqhEUMCPwK/kDBKoEWEsI2SsB6487fRFXbL4XVwWNHCkWXHsgVrblA==
X-Received: by 2002:a17:907:961e:b0:a9a:835:b4eb with SMTP id a640c23a62f3a-a9a0835b5c3mr117395766b.38.1728818376857;
        Sun, 13 Oct 2024 04:19:36 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ad8f-1500-0000-0000-0000-0e63.310.pool.telefonica.de. [2a02:3100:ad8f:1500::e63])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a99ea321959sm189788666b.194.2024.10.13.04.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 04:19:36 -0700 (PDT)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-wireless@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: wifi: mt76: mt7921 Survey is missing noise floor
Date: Sun, 13 Oct 2024 13:19:20 +0200
Message-ID: <20241013111920.679188-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I'm using an MT7921 PCIe card in AP mode on the 5GHz band.
It works well when I manually set a channel in hostapd.conf.

Setting channel=0 or channel=acs_survey (both have the same meaning)
should make hostapd check for a suitable channel and pick that
automatically.
Unfortunately this does not work as hostapd reports the following (for
all frequencies/channels):
    ACS: Survey for freq 5180 is missing noise floor
    ACS: Survey for freq 5180 is missing noise floor
    ACS: Survey for freq 5180 is missing noise floor
    ACS: Survey for freq 5180 is missing noise floor
    ACS: Survey for freq 5180 is missing noise floor
    ACS: Channel 36 has insufficient survey data

I suspect that this is due to mt792x_phy_update_channel() (from
drivers/net/wireless/mediatek/mt76/mt792x_mac.c) which calls
mt792x_phy_get_nf(). The latter just returns zero - so it seems
reading the noise floor from the hardware/firmware is not
supported yet.

What is needed to implement this? I can test patches or - if
someone describes which registers to program - I can also write
a patch and submit it upstream.


Thank you and best regards,
Martin

