Return-Path: <linux-wireless+bounces-18579-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5298EA2A43D
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 10:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78CB81888DE7
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 09:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E58F226534;
	Thu,  6 Feb 2025 09:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJXHUnKc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743E1226165;
	Thu,  6 Feb 2025 09:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738834039; cv=none; b=h/rsg45YPVIkvZy0sTG4teQgRs22UXaatGLIeYqEbimxIwF0F4VGWahmm66RNOBs700xw+yW5ukGBnszUYSC3d6NSg8euoNXue4vVPzT97L9nP0WrsPpGVMsegyMucTCqA3yDBrGNjEOQj8X+4e2cL94PL3O7sFrF2QlqF/QRE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738834039; c=relaxed/simple;
	bh=lcx/16fnWRrRAPSitTCsB7hwMqM515e4kpAPwXmpS5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vFjqr7/E1gSq9PmNNTRKLBw8GF0PygvvmV3xWu/c1YwdHlbnEzK73+QwXMnmlhnjTDTXNm1uglp6aosYucfMWZGiS7TTAgtXXekOFO72Hid1lH19Omjle0d+a7No6KN2+/t7PBNRCgxutKeA0khERPnAhWC90zevR8SXWIflMb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJXHUnKc; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43675b1155bso7184405e9.2;
        Thu, 06 Feb 2025 01:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738834032; x=1739438832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fNDukdLUclulwvbY5VrD2HTtaCRvfs2m8Kmu+NBmTvM=;
        b=BJXHUnKct6SRG77JZ5MeNYsaLaCLSk3/vCY2jXTqtv7N5xqubkvDhpYIvZaGlFEYXW
         i8+bWwHSXXq/co2xrXotN1LG0FURbvp5rspO0G/gWqqMD9IV2HBKq+YJVaIweF1jvm/0
         8iXgO/Emo/EQQO9tDQ2nZ9k+wGaFd0G8iAcAd4v7jgxOwWRtZQRGyLqEGRDc7EYqD4tp
         O1+1hTUPDCJUZOVRhuzn+V8sYosQU/0KS6iHjxLWt9hp0gs+/soiMeiide/z2Kb+91jX
         UjY4a/pOYlz+pp5rYRHIlDxi9pzJTEiv5muG4J1dTToKrIkQUiDk2HLda+ijFlC7YII8
         tphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738834032; x=1739438832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fNDukdLUclulwvbY5VrD2HTtaCRvfs2m8Kmu+NBmTvM=;
        b=mPP6r0HHC5yza/I9UHKTCXCvvOZPs5mYv6lyRf+muKZRP2dK4Yxk1lRUnwMs45L2Xz
         HEklPi9602Drv1M8VLOqM9BIPauAsEMRKbrKmPUXrQj4o5J9q+/3T2v4Qqspg2CMpQcP
         yiD6hECX8TbOdoy5rO2wjtC/1lOFjoZxE6KY7tVWdrNttcNSo3zFUF0djQ+CGkShMg1H
         ATp4NNLbfHlYVE+0nZMCej+55p6XYxjsCI+/9DKFXWXqBWgv1yowEXHk5bYaAMhn5Co/
         NgRH4tvYdNqoiPujZlg2HWnRqc1EQ/jn5UufdMriUnlLTYKmN/vVribJRg4HRnAQACt5
         Uahw==
X-Forwarded-Encrypted: i=1; AJvYcCXixvL1U/HzwuTEMoto4NZf32BMLyZWWnKjll/o9ZdiEtmxlP/5NFTzJs+AhE83rDWtRruVv4KkpHT3RDIeEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTziQNL7aNulm2ggZtt3x36vQY6mq7wtUn5RYFl61DZ1WPXOwB
	+bFtpKtdkydH32+FKFvuQYRqzCCG94aD/0YEgFZYcajxWOr0XSAMJ/JUyA==
X-Gm-Gg: ASbGnct6ZrrDy5ZLwPBmXq2mZFgwebvPrWsqOCaoYv9yCN9buHWphvhk+YzyMc+ohXa
	t721NB55fAFG5GFDn+M29l04zK5VkqBxk05qvFJGYygh5QZhmUTHODicRyEF7XYYtzJ9ejmmdse
	s5JUDf3NZSBmmsQtfv2mawTN5Mr2GuyW2ybzRiz+w0DF1MiAow7+ppi0c0JBQaoBfVU0+j75M0F
	IvVvhYKjTDwJwmFkQnhEFpAYd3O19ITIirq7xHFTaiija2Cv8x/VkWQ6weppKIrrcAH+qoryO6A
	oXsGu7zHngNidciM4bPKvEQWe2jaxZsmew==
X-Google-Smtp-Source: AGHT+IHhSHxOUFCkPrhKeomCcGPw14hS4wb7HtxXpXpI8A8Oi5KJIRzr4NUSjnNn27/EnbOloQEJKw==
X-Received: by 2002:a05:600c:1d1e:b0:435:294:f1c8 with SMTP id 5b1f17b1804b1-4390d574e09mr44240645e9.28.1738834032203;
        Thu, 06 Feb 2025 01:27:12 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:c428:5404:970c:34c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dca004esm12832585e9.13.2025.02.06.01.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 01:27:11 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v3 00/10] netlink: specs: add a spec for nl80211 wiphy
Date: Thu,  6 Feb 2025 09:26:48 +0000
Message-ID: <20250206092658.1383-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a rudimentary YNL spec for nl80211 that includes get-wiphy and
get-interface, along with some required enhancements to YNL and the
netlink schemas.

Patch 1 is a minor cleanup to prepare for patch 2
Patches 2-4 are new features for YNL
Patches 5-7 are updates to ynl_gen_c
Patches 8-9 are schema updates for feature parity
Patch 10 is the new nl80211 spec

v2 -> v3
 - Updates to spec and codegen to clean up compiler
   errors in generated nl80211-user.[ch]

v1 -> v2
 - Add formatting hints support to patch 3, thanks Jakub
 - Raise exception for unhandled hints in patch 4, thanks Jakub
 - Update nl80211 spec w/ split-wiphy-dump in patch 7, thanks Johannes

Donald Hunter (10):
  tools/net/ynl: remove extraneous plural from variable names
  tools/net/ynl: support decoding indexed arrays as enums
  tools/net/ynl: support rendering C array members to strings
  tools/net/ynl: accept IP string inputs
  tools/net/ynl: add s8, s16 to valid scalars in ynl-gen-c
  tools/net/ynl: sanitise enums with leading digits in ynl-gen-c
  tools/net/ynl: add indexed-array scalar support to ynl-gen-c
  netlink: specs: support nested structs in genetlink legacy
  netlink: specs: add s8, s16 to genetlink schemas
  netlink: specs: wireless: add a spec for nl80211

 Documentation/netlink/genetlink-c.yaml      |    2 +-
 Documentation/netlink/genetlink-legacy.yaml |    5 +-
 Documentation/netlink/genetlink.yaml        |    2 +-
 Documentation/netlink/specs/nl80211.yaml    | 2000 +++++++++++++++++++
 tools/net/ynl/Makefile.deps                 |    1 +
 tools/net/ynl/pyynl/lib/ynl.py              |   46 +-
 tools/net/ynl/pyynl/ynl_gen_c.py            |   30 +-
 7 files changed, 2065 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/netlink/specs/nl80211.yaml

-- 
2.48.1


