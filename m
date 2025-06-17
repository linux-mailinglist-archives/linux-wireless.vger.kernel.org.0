Return-Path: <linux-wireless+bounces-24177-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB27ADC424
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 10:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A19457A337B
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 08:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1330C293B69;
	Tue, 17 Jun 2025 08:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="vMxfclQO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D02928FA89
	for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 08:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750147628; cv=none; b=cr0o/pmP/1LuqBlLgI/jvb86YAP+IcLI/4jZIKAzJDtzOBXYbKmLiBAePW2Yyeuu2Ug3LuikQUTSwlGKcQBvh+d+TelbgaKPOByqeFODAMwUm44TdyQaZ1wBR+fhfwBEwDVVrx4UXeOaYoe7G/46xE09pdfVWZ4l4m2oJWe7ajs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750147628; c=relaxed/simple;
	bh=Wo+osDR2YVFjM+dGVnl1GsE9DF53H7s18wok+bbDsZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OCm8sM2h3aGZyeny0Pdfcz4QF6zNI5ZploOJH5AW5S0qak+bwG12Mv2zUgADNZ6Ku7evJtUW17X8G5zEFao8lpBwYUQnBtSKvyRZvDs7q3X5Ese5XTo7XARG8rQg9Qqe/+og9t0+e+uPPmpYu8FEV2tMCQYhEC1B16/Dk8+r4k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=vMxfclQO; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23636167afeso52563635ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 01:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1750147625; x=1750752425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fdqaSbAHDb33K0J9LUCTlFM9SSQOACMg5bkorQKe76Y=;
        b=vMxfclQOc5HyzHefJ6/nPTTh/7g9e+PGb6HCED6zp6DRJ2JHAclenyLpIzdkYzRIkx
         3WEx8DMYyG+AJ1iiS6C9TWi9BL34Wf4g0nJJEsMo1DgKDVFLjrKX79E1LvCoVCi9Ej6P
         N59Ma9tjVUjUnsr8zY8FT0rMx8cue9L+YX4TbPjjxKcOMo313+rJLVnP859qdYmK/rs5
         mvHY1hdXQ+ztI12OUfcOCxf8w7yhPk3VkEV6WDZ8je0PpnA07br32EQPHzjmftC4z3Kl
         qjhN2wWyL+XbA5wjpWHWl/THhtyh2+3tKGE1rxiPaXuX1U+fjnwJOBpKSUJtHj22xKpC
         d1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750147625; x=1750752425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fdqaSbAHDb33K0J9LUCTlFM9SSQOACMg5bkorQKe76Y=;
        b=XKkvXE8lMfDq/VDTYfU+7VFy0XZVwl7jO94gLbvSil3cJC9Ld194uC61dfcMjC9WBn
         gKJetkd+8BTTervX9ujz+6OTJ4nKXqVMYTHpo5OCZ/Xe4hjKCH3+HzMBDN9atHrV30jT
         UMtcEMMAelwXX9dKsnUxBndcQQ8ltUC+J1KiGwalDSUJBPQ2ZkuVppMFfebcqh1X406G
         S0DVleGVw9ZGsPPsCEa+Nc8dXOUhhpjU6CVTgjFooakWFK2Nh/bJtEaduxX8A3LKYxjU
         PGgC1i8Pp4ekYW5O99pJM+ergO/SZEABqAl5yeWtNj4iTqCxNm5gkSHPLfiuLX5Mxyga
         X3bQ==
X-Gm-Message-State: AOJu0YwRl23wRfQ8f0KDKnGJETia85+bdQQvGE/gFhlJxCUFF/gx5q9c
	hBc4DuB9itI3+GGqQCSta9zB7yntEINGd45427239J5bEmp0h8o6MYuhTgn4N1Eh8M+7mMHu2A/
	paFDr+m0=
X-Gm-Gg: ASbGncvSldLIfOPF7im3CC0E0XgRt9WcEW2O9/lLgGGpYT8Mg8dXP19R0ABVp8SfEzx
	+bjJXR5yu5kF0xfjzofi1rOpHG6Vrhe2kVQRu6zgSChC8Pyin3ELKuN4/efEYP+p0WfFxYHHWvD
	ArtGM4RWY0PkBRuuL5e2DeyIwltLwabVHE6NvIt7NTU1TFxi+h44OLrIECzfkiTw/xyLpSak+dT
	zYSAJSWnGUmtl6Os5xw3Y4jDL+GZIUZbm92BRncFkFCuoOL7PEs+/daarZ5QsKu7aKDNP6LFr4B
	I/thq1UZ8YtLrY0L+2W5Mn49me1gNUK67IMQKaJhNDZOzRlWONfhS0CLipv8FBSgQ+on8k20AkM
	6H7Pz23MTXKJ4u84doG8RvMXFnOFz1UOKJac=
X-Google-Smtp-Source: AGHT+IGEaYozYQHVzdrcO3TXTHecnl6EavQxupJUwJsciOxppTHoayaImtSGuE3LtnLQNbb3apRXYQ==
X-Received: by 2002:a17:90b:3c8a:b0:311:ba32:164f with SMTP id 98e67ed59e1d1-313f1c9d429mr19192929a91.8.1750147625224;
        Tue, 17 Jun 2025 01:07:05 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31413d2c8fbsm3579365a91.10.2025.06.17.01.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 01:07:04 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [PATCH wireless-next 0/4] add S1G station support
Date: Tue, 17 Jun 2025 18:06:06 +1000
Message-ID: <20250617080610.756048-1-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently there is no support for S1G capabilities within the
link_sta. This causes a few issues:

1. Drivers that implement their own rate control with S1G (as
   there is currently no rate control support for S1G and
   every tx is fixed at MCS 0) need access to the stations
   capabilities to properly function.

2. Even though aggregation is supported by S1G, S1G drivers
   will fail to pass the checks due to the lack of S1G
   capabilities within the link_sta. The workaround was to
   set the ht_supported flag, this patch adds explicit S1G
   support.

This patch adds support for station capabilities to allow drivers
to properly perform rate control, aswell as future support for
mac80211-supported rate control for S1G. The same goes for
aggregation.

Lachlan Hodges (4):
  wifi: cfg80211: support configuration of S1G station capabilities
  wifi: mac80211: handle station association response with S1G
  wifi: mac80211: add support for storing station S1G capabilities
  wifi: mac80211: add support for S1G aggregation

 include/linux/ieee80211.h  |  4 ++++
 include/net/cfg80211.h     |  4 +++-
 include/net/mac80211.h     |  2 ++
 net/mac80211/agg-rx.c      |  6 ++++--
 net/mac80211/agg-tx.c      |  3 ++-
 net/mac80211/cfg.c         |  5 +++++
 net/mac80211/ieee80211_i.h |  3 +++
 net/mac80211/mlme.c        |  6 ++++++
 net/mac80211/s1g.c         | 26 ++++++++++++++++++++++++++
 net/mac80211/tx.c          |  3 ++-
 net/wireless/nl80211.c     |  8 ++++++++
 11 files changed, 65 insertions(+), 5 deletions(-)

-- 
2.43.0


