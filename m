Return-Path: <linux-wireless+bounces-18758-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 997E2A30AFD
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 13:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8187818850B9
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 12:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDFE1FAC48;
	Tue, 11 Feb 2025 12:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bksaGsBj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECE71F1527;
	Tue, 11 Feb 2025 12:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739275303; cv=none; b=FjtPxSlEC4sxZh2kX1NEybP4SUBYi/LAtW8NAwBqNQfp2WrZyB1977dbiQlDGVUhTsk5WRepWc666QhVQVczv8luy5kkbuiYqiAF2sMMI/gx72hOWsZ0vu1ay1KQqW/L+kHV6mRKiwpxfKNyvIt2F9v1RItQlPTy67TWPRApu6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739275303; c=relaxed/simple;
	bh=7VXKGckgTXLQbLZqlx3iFOFqY1BCkUS116vkLEJFdoA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mu/K1G51ZSKFPUlEgiMJFzitAWFbA2IcERlK4GEaEIIKBUG5r897QhLWZB3aIflzt/K6Ib32c1QCPoDmvn3ZOgQ3GmDOXqCVlbF3hWP+MAArq2sq8Lt3F8n8Dwy/NFl28hc2GWk5GdNRoM0JWxQTCiCLdOVJ4WU0eq+W6BRAdXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bksaGsBj; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38dc0cd94a6so2571699f8f.0;
        Tue, 11 Feb 2025 04:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739275299; x=1739880099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vGTkgcpu6GeYJOfp2a5cUV6YJapwz25ukuoDqvZXbzc=;
        b=bksaGsBj0nK4F40kvHQtzFp+MJjJCkRq6CyRj+wJ3UKrrTDIBkDeEF5MQBjXsHr2TW
         Aq5Ql3kFpActvwnA6I2h4e6bDt1kxME/VnnqC0LVDTUVyAx7DE6CKr4C8kv5LqV77dBr
         vZ8h1PhcUOfER/CXbPW0RX+IWW24ErPxleV7TUgxcDEbId61E9fboXnbNGZ8wX3QwpIF
         rDLcCAXH+6IA7aTHRy5Gbzvwh8IKaIk7TsC667hCLRDNs9ExX4RAHLl7LbJ87zViVh1W
         WYI4wIN3E5BhSfTya7eyEMN2OnokWbOXZZCJwJr6nMLKDUxg4VVR3v59EeS+1qC6nCJK
         zwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739275299; x=1739880099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vGTkgcpu6GeYJOfp2a5cUV6YJapwz25ukuoDqvZXbzc=;
        b=Lqafs11jUmsAtAAuiSrBrBccTl+DHR2MWgXmBc0nr1ceTCty/yw0TFWZQmE2cavFdR
         B0mgW6w9MbFwn8evCgCtQo3cPp9L+EYwJgU3K+yLzP74DBqVvS7iiWhszyGfRwORq0P5
         XNKmrc0v8ZEKVv3kI+pIMyA137QeyBVXvtRkjIJhTgvQUyLW7y6GBwDB2/erQz91LIev
         wGXx9whdesoEfZXHYt07xVdPZ9FJ2AZENBmjrjSpDHsIumWBc0qhN+0g8yO6fIEZl0WX
         Zqo++jGVX+KoNq6qC05wKAaPOJsdB9IRJA6+RQ8iaRLx7uvu6V0zgU2FOIVB4rq/AnEa
         Bj6g==
X-Forwarded-Encrypted: i=1; AJvYcCWlCU5iuVG5pwRpMCcg+57lxwOmVHbTeIULmz0/8m1FDSHBt/dqDaSpAlHf0lmUiRAKFwSxekibPdENQEBGwA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5YDyGipEl8IxSIuLXfcCcquTkO8pD8yP0pUKH3rPaGBP/qqTv
	t8Rqc5DHv05R8OM91Ckon2hnikJBsTP6SMWyO615FEcMODt/AGX7bQ9gDQ==
X-Gm-Gg: ASbGnctdMGOh79fFbYLaoTfC5+Cta3etOXalfHGEQLfkWXaIRpdfMSZ83+1heZn7IJq
	STBaSqftNEYqdXodaf+GwF6R4sD53dCe4qq18gopNdqbbqxHkEJ4LVPBff9S55Rnm41GRkWcU0T
	7BoFz9BDSnFefmjvEMvrxxcL0OcrFOykCIHzA+WmiDob5w9oFqblGH2earjmleat2EizEcw2oxB
	MiXY8pJ21wtcX8buer9HiUn/FtcFYvhaGO2MVy1OkmjqBLvtGRP66QIQzjMXBKfWP8rjevM3A9u
	1jac//cgDznye+F4xrkoNChUq8aUUlPbxg==
X-Google-Smtp-Source: AGHT+IHklZt/L+K1Pi0r69p1vzW7qCqNjL9dPtnefYnt86yYASF/hehFOcELaLocy6p+vuyK5ShRvg==
X-Received: by 2002:a05:6000:1883:b0:385:f7ef:a57f with SMTP id ffacd0b85a97d-38dc9233968mr14206414f8f.27.1739275299332;
        Tue, 11 Feb 2025 04:01:39 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:ac07:4372:f96c:546e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dc933ff9fsm12466658f8f.96.2025.02.11.04.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 04:01:38 -0800 (PST)
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
Subject: [PATCH net-next v5 00/10] netlink: specs: add a spec for nl80211 wiphy
Date: Tue, 11 Feb 2025 12:01:17 +0000
Message-ID: <20250211120127.84858-1-donald.hunter@gmail.com>
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

v4 -> v5
 - Rename nl80211-iftype-attrs -> iftype-attrs, thanks Paolo

v3 -> v4
 - Simplify the leading digit check in p6, thanks Jakub
 - Fix a typo in the nl80211 spec, thanks Johannes

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
 tools/net/ynl/pyynl/ynl_gen_c.py            |   28 +-
 7 files changed, 2063 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/netlink/specs/nl80211.yaml

-- 
2.48.1


