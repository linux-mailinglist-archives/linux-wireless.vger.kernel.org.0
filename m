Return-Path: <linux-wireless+bounces-15851-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 170D99E1FDA
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 15:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B3A1B23041
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 13:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04611E5721;
	Tue,  3 Dec 2024 13:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boNrvG3g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6681E47C4;
	Tue,  3 Dec 2024 13:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733231226; cv=none; b=kbsDSHJQvYcs++idKHP+zSw8Juiq4L+dTLidVgupjXRUJIHugX56xrs93QnqWLGIFdGEJyy2/gMqQ3U4bePnmcOEnTv4Ft+h92WC+EzJjXvsPpGAtzJY726pmjEk/9hdIodEPYGODOKv9kBGGpD/58km2XS8R5YRh/yX5zU6YI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733231226; c=relaxed/simple;
	bh=13AvOjllZFtUPseTAIkpqJNhcrRiFcBFx1+nJUBP8Rc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=keJYV/3tG2Q6eD5TJ/Mqhdn3gFkaIhv+yE00iOrFfpu9+sbmi6/qmfAidOrgLcSTlrxVUrOc53+HfinX5ODCqtoe9s8XCzCjyNMK2jyqouIWAUhr3PvS0MqBl3ZohZfl1WAICie+tbcGq3BNkhhgpP/EuC8FdUk0v8Gp/kJ9w+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=boNrvG3g; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-434aa472617so46936685e9.3;
        Tue, 03 Dec 2024 05:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733231223; x=1733836023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sKfu+etQ5ANxcOuW4h0fJXGVNERyNRtmAMyY5LefJQY=;
        b=boNrvG3g++eAOBhaJDtUfwb68Qr3oB3nUb9ntsammY1jC0kvRlhA6KxJs849Um7cT4
         eBpA75Uu62611k2Ezv0yLqGVl6YbJdxC2PMpMfpTxRmnP2HveNRNOfKU9HONAUQuhX3V
         gWCZK8ztJoc++3rvKh5Fx1ehGMSUYu8O7kvfj77GqiEC2pgN2DvVMMk2DfgjklHmOpwv
         YPQ21Mu/TWb7IFt9/Z/+xNCi95YqK6ONV/sE/mKOr2SVR2Fp7wgvYBUgQMUPDxevx/yK
         K2X6itQfUBhbHJNsTsUL7T+JBlVze7lzJ2FIDo76asvZmBQRETjfRHDaPu6yW3jBcT7c
         eyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733231223; x=1733836023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sKfu+etQ5ANxcOuW4h0fJXGVNERyNRtmAMyY5LefJQY=;
        b=wWj1DyDLIg9cEQo0rXlg2yIHW1+3qtsm1f53l6nrt4sst+k8flsT3aPYCOn7Z1mFSr
         27YqV8gYM374F92HWap73KpBS6Nl8mPXgTscSvxpR1I/ySWGtvk2Zk9QDdRiQTrx6o4h
         QQyqxhw23sNF8jBZ/1h8rF5a8heqgjeXov/XTIvdthCxGLpz10sWgzfYe+AlYEVXvnFI
         C7dbcAF8OXGgpYrZHED15MbcDJhIvdHzHSaUsB29HGVjT7U6YP3IUJOdimrSFTtN6IYm
         tBqGjAGc1fY0Y5LRWvDB9hUZYkoAsw2ZpwmpNmpeIRbhFajzbngFIWPj3Wp+M0AVYoCf
         WMTw==
X-Forwarded-Encrypted: i=1; AJvYcCWl8amAmTOt7WIt7gK1ljfFPg2CrAq/qq45E9bXIGBuqeIangC79T9VhUNkL11/rfrfO91gKz2vrs+zNZlGrA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJOjgCO3wZlJtemeCQLjK3MdKXz6iAOEPVDNOe8TJOcxvqc9SI
	nzO1kC8UqzhW7c18KQ2z1hrTm9CCYU3mJVAmEfa0uLrmLH0lXFzrVk7dzA==
X-Gm-Gg: ASbGncvEcoebu0sYFYusAtHKyc8LF28H/nIFXfTib/JD3omJuhw+Rgw8MCJhVeiw4YZ
	hRoie7Z8eUHqw9PVynRokif4p6Qei+/5frDF7qGyoz83w/Di3FCg41PBIyMe7b/oNXTgOltI2fJ
	SPzDXhIYYIVKp7yD/uBt8xKEzqtKfqNF7sy48j3RFl2+8HeMHYbdTvtLopUSi9msJYrYY2fHt/Y
	IwryY7mxszzECF3OUPaNqrZCMj1kUh33/rP4A/Ggbl/O87vgB5dpLeA6wD6RTAWCH4=
X-Google-Smtp-Source: AGHT+IHzNPKTBGNXnOjpWN1ppThaEh7Y2/EUOJW84nb0Yj5tjocTMudOght1ODqNrNFOZj+kfWRU1w==
X-Received: by 2002:a05:600c:1c8b:b0:434:a386:6ae with SMTP id 5b1f17b1804b1-434d09b14c7mr20224995e9.7.1733231222527;
        Tue, 03 Dec 2024 05:07:02 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:6140:2ef3:aaa:55ca])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e4d42sm219142365e9.37.2024.12.03.05.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 05:07:02 -0800 (PST)
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
Subject: [PATCH net-next v1 0/7] netlink: specs: add a spec for nl80211 wiphy
Date: Tue,  3 Dec 2024 13:06:48 +0000
Message-ID: <20241203130655.45293-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
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
Patches 5-6 are schema updates for feature parity
Patch 7 is the new nl80211 spec

Donald Hunter (7):
  tools/net/ynl: remove extraneous plural from variable names
  tools/net/ynl: support decoding indexed arrays as enums
  tools/net/ynl: support decoding C arrays as enums
  tools/net/ynl: accept IP string inputs
  netlink: specs: support nested structs in genetlink legacy
  netlink: specs: add s8, s16 to genetlink schemas
  netlink: specs: wireless: add a spec for nl80211

 Documentation/netlink/genetlink-c.yaml      |    2 +-
 Documentation/netlink/genetlink-legacy.yaml |    5 +-
 Documentation/netlink/genetlink.yaml        |    2 +-
 Documentation/netlink/specs/nl80211.yaml    | 1775 +++++++++++++++++++
 tools/net/ynl/lib/ynl.py                    |   42 +-
 5 files changed, 1812 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/netlink/specs/nl80211.yaml

-- 
2.47.1


