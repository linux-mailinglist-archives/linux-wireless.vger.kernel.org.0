Return-Path: <linux-wireless+bounces-16168-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBAC9EB5CB
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 17:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 144A228168E
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 16:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE841C07EE;
	Tue, 10 Dec 2024 16:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZ4stD6N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4044A23DEBB;
	Tue, 10 Dec 2024 16:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733847301; cv=none; b=NMJtiJsA6VwDcU6tJ3xBPkOw1bCyHJvW8SeEulZNktU1TmnxsbHaWMT1Kv49WHNU8dMQlI6NWz45DVA/KLv1DAXQL7qpQ21w9zRE0Yb9z2NRk0XL8xvxWN6eo6DzU10Gz5YE55iyPjTHdIMfa3s/mPl/Ktmrte/YnjxWnYyeZx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733847301; c=relaxed/simple;
	bh=YKJueWy6tNGzFZqwMVGDkhBDz5+P0CEqnmS/Chj3Z3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AHG+vyjR2kO2SVV6rMISwlhPXJTt2mZESpw63BlsXTo4CBqjZkcKPShlM85uTvTCH9qytYmAEWWQcK8qLxs31yFyLXL/7705k2pvzFhdfpB2bMvEKfdVAqf/WXkVjlYnx1aaNDGuFYClYdWshfpj5c4KsQlo0w/5D1b9P2JZGxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZ4stD6N; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3862d161947so2805066f8f.3;
        Tue, 10 Dec 2024 08:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733847297; x=1734452097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b2kZqD7Wt0Fzg/4fk67GLv1SmsuozOqBh2njfbOzIsI=;
        b=GZ4stD6NTwF5k+Aw8PFdXrihdFGS0YQ7BMFbzgXuesSkAX5fu1iQnCgnqlu/Yzk3uT
         rHcs4TOsrr5rqUoQr/viyFd5vrmpEuC+xl0p95Y+DFWlAE+kyCuUsrMgfdyU/Mn6jlU9
         Yoh45F7X8rSrNWwXmvD9GXSQNn4XbN4LAkEdhIGdTW1Cn7ke4gS9RAUEfFy0JvnuU29+
         FZMtWb1TcbETNjzRFHDUb48jb3/C1egFvTL27NTHORqDHgzodruipKxmG1LkuOZ6Ybcv
         LlwBuEKwnJOEgzxgm5v+5ZMRI35lUWQm/CAFkDBBxC12nakj8HS72JKdahwRSYz02zw0
         kSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733847297; x=1734452097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b2kZqD7Wt0Fzg/4fk67GLv1SmsuozOqBh2njfbOzIsI=;
        b=tXheUrMHZ9+EaJX4LZgnqd7IGg3sqciYmzBTxh2Vvz7CE06hi2lnBwsyrzYzBXl3+R
         EC4KM11QpgqkJWY2CkpehoVW/27YaPBUGeB1ViURjKWFwSPb/ilzJEFSjpZONOZ/268V
         SVjEbd1VXOuYJPJA5wEMOljA1drtQ9f480rEMDg/ydJR8lMgQhIeJv8IYOR2EztupuIp
         hpDlTStcczy5FFz5bOufXm/WOZW1WcolLZ5LXVo+bELiDsPKkkv8Pxfulnk2ADJ2ld9q
         AGv9dUeuCGn0/EJQ0lRaWNzAyKRP+qbgZOFWc7NvK9hYH/PpDeF9IvB+uu3uTdCf13i+
         NYpw==
X-Forwarded-Encrypted: i=1; AJvYcCU0MRyHY0ADvbi9AQuxJzwdYRZybMkq3Q9YkxP2p9Z1Jt+pYnIenj8Tm0Vwto5qgCUwywFtsejiI7GznQeqxg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx02gdCV/vEPYnhD+2aq1eB0Rx3B2B68koh7BaX/K9GiQgt454L
	Tf9P4yfW3/fA4ZZ2NkpKvplkhyvJeTQ7AG5j6PcpALxFxilUB7ip7pItFg==
X-Gm-Gg: ASbGncvU8o/A+VNBpQ1omTx8Sa54AkLLSE+jnkCywI0lvE/ZrG/sXcwHKM0JelogrrY
	ZbtkwgTvYdM3y1Cw7SB6pwIBJOKSsOmMXNvCfsPDnUwLaCfVn0efNT/stLQTNgQNpELm3qRIvAq
	m399WfbZvkFcWSknINsIua/BU+kgpuJrVbRrH0T/ec0BmoIhTy09x6Ah+9Met0oBgxYeVRThoSo
	CSX+Rb22TwJD23Ho2cU148H0cpA+xxTdH6H8ZrEWsqQ8GcFN3ivp0HjKFtPClnkraunDwzg
X-Google-Smtp-Source: AGHT+IFrunASWFM+kVEDgg00JoDIUUDCUOYzzNwMirWOWSeEYV07VhTPD4RbGinhWIGL9yxmsRk3qA==
X-Received: by 2002:a05:6000:144a:b0:385:f8bd:6e80 with SMTP id ffacd0b85a97d-3862b3e4458mr14221989f8f.56.1733847297044;
        Tue, 10 Dec 2024 08:14:57 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:75bb:8102:943a:2eb2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f30bceadsm102383045e9.41.2024.12.10.08.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 08:14:56 -0800 (PST)
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
Subject: [PATCH net-next v2 0/7] netlink: specs: add a spec for nl80211 wiphy
Date: Tue, 10 Dec 2024 16:14:41 +0000
Message-ID: <20241210161448.76799-1-donald.hunter@gmail.com>
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

v1 -> v2
 - Add formatting hints support to patch 3, thanks Jakub
 - Raise exception for unhandled hints in patch 4, thanks Jakub
 - Update nl80211 spec w/ split-wiphy-dump in patch 7, thanks Johannes

Donald Hunter (7):
  tools/net/ynl: remove extraneous plural from variable names
  tools/net/ynl: support decoding indexed arrays as enums
  tools/net/ynl: support rendering C array members to strings
  tools/net/ynl: accept IP string inputs
  netlink: specs: support nested structs in genetlink legacy
  netlink: specs: add s8, s16 to genetlink schemas
  netlink: specs: wireless: add a spec for nl80211

 Documentation/netlink/genetlink-c.yaml      |    2 +-
 Documentation/netlink/genetlink-legacy.yaml |    5 +-
 Documentation/netlink/genetlink.yaml        |    2 +-
 Documentation/netlink/specs/nl80211.yaml    | 1938 +++++++++++++++++++
 tools/net/ynl/lib/ynl.py                    |   45 +-
 5 files changed, 1978 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/netlink/specs/nl80211.yaml

-- 
2.47.1


