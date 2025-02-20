Return-Path: <linux-wireless+bounces-19171-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24128A3D292
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 08:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBA86177462
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 07:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0600722F11;
	Thu, 20 Feb 2025 07:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7Z2otDh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B63A930
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 07:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740037640; cv=none; b=sGBQUG+bGxt44VOIyL03vnwEfD4kIa6uKeVV46cvxqFKap+qJ3fou6FFkvImPWQQc6dDO1fAnxw0FJgJf8DxjXySv9028hC3R1GdXBsBn3+3oR43beVl15okc4gVCux5zaShkbkRfGd+P/EkarrW1MT8djnGWYOxko7Xy9+xfLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740037640; c=relaxed/simple;
	bh=It+tj5dxzDDZ1PsV6/nRtONXZfIprABDx3R6pGIVavQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BGhVLMUpDC3YASzAqw0bo9I4KL5k4jy9LioCIyi4l4TlCz1HkS5wA/9t9uDtT4Bpwoc3yvHxXgO80h4kcXdM03QGOldrNJzwAVaVmmE4StZ1llsWGUbP2Yv+gOzJ03o7S4NspsMMp6gW0R/YGja8fkOJ6xncLlRgmigfa7onAKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7Z2otDh; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abb892fe379so111100266b.0
        for <linux-wireless@vger.kernel.org>; Wed, 19 Feb 2025 23:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740037637; x=1740642437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kizMZXBvZWYMp3UdtimJt8rL4L1g53Q7nNsYzh45q0U=;
        b=H7Z2otDhnEwUL5tXBH5dSkTj3IfOEFahtdOYJDZogz7xf+kZLsc/Ifvz3ZWb3qtjX5
         8S0KBOuacz3xCrLfv+1D1A/U0kqnmDhui8tI0T4Q5WayyOsUH1J/biN6q2OZy5pvUBH9
         th6BOF1NOxVhSA8V9eUTKGq2o9QxGPnCkFS/TpybUVshkg+dTjtqB3gyomiUlZ8aiCom
         MyPNRVojGEjHbP55BZmFIpFnspRmrNVRnatv6LjVPjXDL/QfDYIfX7QawyOXPi9qRyvN
         Aaa+g12d46XOuPq5KG+yYr+Rw/Kh8mxcJ9xICZQ692UpFdRWSmyQcNJpu8FHUOszpUu+
         yGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740037637; x=1740642437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kizMZXBvZWYMp3UdtimJt8rL4L1g53Q7nNsYzh45q0U=;
        b=oMyVe8a+ve12CTcPumkKVpDA2Lu39JKuR2yRSb/3CCm8Pn6Q6G0fByE/1mjM4MLVVQ
         QEVl2ClV9BvQx9izW8os9PC5Zx4hHvLFQxfjndTt604XrtpKTb6ChQg83u9TVDNl5/o1
         bqYkakMxW34VwC3BdpvuTHlRA8srfiSFhCoTEeQOuOnb4UKyL/UV2GIlmKSdfXoDwN77
         VJ4BqBtbKe+owKbuqQmhpL6I2RjUfMFlWVFz1vjWXSJ1TvfhbbsmY4kWEst+KgV//E24
         eWxT7/57Mz27yDv1Rt/t201NeohWq2G2fnJEPd0JVkpq2dkyQ2wejGEFwAvNDa0aQkbi
         Ru2g==
X-Gm-Message-State: AOJu0YwCOuzjhWz8tTstBA1yjlRSREIpYtZHEhFOJdAMPn0TBU2f9Y9k
	aGvki6uAB1d+35RZF7FTomlsjc8GxzEfMZwFQCTZmGt4wGVF5HNk140+NQ==
X-Gm-Gg: ASbGnctSmIXaYoFp0tUq4WajJZUagj2PFz6hNIy3PP2ssVJa9bMD+yFZL163D6328uI
	SM7sDFcOK/HlDWGD6DpQglJVPi23Zc0i6wtQKvYNmwq3Mn9zYoSzRqyHrgW8zlGTkFDSHpIacaa
	raGbrMX/vQiEgfWsbZJUEumMqvWZgjTr6JOMZJD5e7UJtFPEgxPGH9enyCmQ+b2lIMQ6lOOYbQl
	Raz90seuRtZJ1YtbZnQ5Ut/6zPrT2iD6JR9hW7onplM8CXiOzEwzrAcI0FG5Zbz8mm+64lPyX40
	jNYcfdouYGep0JKGUrQEeBtg9KSh2qs9HZvFUbJkCIjz5omDsDmvJHRzvCjTYHtqbnYC3NzswjJ
	wH3W2IUk1ULHgISOvcDYgWX5dDyhQTXw=
X-Google-Smtp-Source: AGHT+IG/WHLp4u84QnvngTw5Udsuxk0XKdyFT/RHArDNto1L5ul9jTuTrZFMWBU03cHHbBaqcY/TAQ==
X-Received: by 2002:a05:6402:1f13:b0:5dc:80ba:dda1 with SMTP id 4fb4d7f45d1cf-5e03602e5d6mr49278966a12.9.1740037637096;
        Wed, 19 Feb 2025 23:47:17 -0800 (PST)
Received: from hp.NAT.swidnica_mmp.vectranet.pl (178235177162.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.162])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb7d4dc4dasm956292666b.3.2025.02.19.23.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 23:47:16 -0800 (PST)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [PATCH] wifi: nl80211: report real HE length
Date: Thu, 20 Feb 2025 08:46:57 +0100
Message-ID: <20250220074657.120288-1-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Report real length for:
 - supported HE-MCS and NSS set
 - PPE Thresholds

Signed-off-by: Janusz Dziedzic <janusz.dziedzic@gmail.com>
---
 net/wireless/nl80211.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 8bd09110d393..c0772e24cc2e 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1873,6 +1873,12 @@ nl80211_send_iftype_data(struct sk_buff *msg,
 		return -ENOBUFS;
 
 	if (he_cap->has_he) {
+		u8 mcs_nss_size, ppe_thresh_size;
+
+		mcs_nss_size = ieee80211_he_mcs_nss_size(&he_cap->he_cap_elem);
+		ppe_thresh_size = ieee80211_he_ppe_size(he_cap->ppe_thres[0],
+					he_cap->he_cap_elem.phy_cap_info);
+
 		if (nla_put(msg, NL80211_BAND_IFTYPE_ATTR_HE_CAP_MAC,
 			    sizeof(he_cap->he_cap_elem.mac_cap_info),
 			    he_cap->he_cap_elem.mac_cap_info) ||
@@ -1880,10 +1886,9 @@ nl80211_send_iftype_data(struct sk_buff *msg,
 			    sizeof(he_cap->he_cap_elem.phy_cap_info),
 			    he_cap->he_cap_elem.phy_cap_info) ||
 		    nla_put(msg, NL80211_BAND_IFTYPE_ATTR_HE_CAP_MCS_SET,
-			    sizeof(he_cap->he_mcs_nss_supp),
-			    &he_cap->he_mcs_nss_supp) ||
+			    mcs_nss_size, &he_cap->he_mcs_nss_supp) ||
 		    nla_put(msg, NL80211_BAND_IFTYPE_ATTR_HE_CAP_PPE,
-			    sizeof(he_cap->ppe_thres), he_cap->ppe_thres))
+			    ppe_thresh_size, he_cap->ppe_thres))
 			return -ENOBUFS;
 	}
 
-- 
2.43.0


