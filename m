Return-Path: <linux-wireless+bounces-21036-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F27A78329
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 22:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2D2F1891630
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 20:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B8A1C5489;
	Tue,  1 Apr 2025 20:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3I4+qW2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3830F20E6E2
	for <linux-wireless@vger.kernel.org>; Tue,  1 Apr 2025 20:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743538392; cv=none; b=IuAWgr1u//OoQrn/iz+Ub5zCZjRI6u6uz4ehPeqwHQ+ZuSZb4cKmSLfYC0BZUksxv8HsnL2ahWla3tg+bL5Lq+wuVASmQ0uUyyCGHNQAZeg+qN1hz5LvUAbJ49fzsGY/WJFZbLrPaxjXaGDxMRs41nn6tWlQO9Xc8jso1Lr0gOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743538392; c=relaxed/simple;
	bh=kHDLRPJRlf7S7YmLMf1sGu97/2IH1KcR/HZdW62T6Xc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NftxhhFdFLoAWh6btM4jv12wFe/70TbIBAR7qpD+hwCsDgblGGyV9oeRk8CFeKpVP80sw+zXwpYMGZsIhyOwCg45t8UBYgC1STbB4DLgupTFKjTd6WmZspwnMSad5fJ6+OC+5aFOHD4CYD07LvHKV++xpji3Q1X3cNRyk9xAohg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3I4+qW2; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac2a81e41e3so1192431866b.1
        for <linux-wireless@vger.kernel.org>; Tue, 01 Apr 2025 13:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743538389; x=1744143189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BlTEmFVfvIl0Lrwn385U2rFW3b0ujHuWk/qz/olhaWw=;
        b=I3I4+qW2rx4B3RhesDqt5qtnvDXglLSZbGONnQHuRTG/tWFIQKo/2ZXTWJgsX6YqJE
         uLsne8/qhFGgmaxTQg/Rns+SXFV6ZcpFCAod3t6+OJrBNRy2PJoexHoGIyqXGBauwyST
         oB8wvsvKgD8IaMf03rbmx6qiQwz+YPxqP2MVbNTx20nR4WeVdptzSaDK01nR80KMcQp+
         wTAjKwyFJ8A72JoMSu4rDEZXejBMsupEN87ywEf7tvlzIcMblNl8m/hE+Q8UP5VwKArm
         ihkPSGHWjySChThfhhkz7ENNQMQeBO1uYd2DceOur65p09YJzulYcPH89zoiz/UBK4ii
         0FTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743538389; x=1744143189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BlTEmFVfvIl0Lrwn385U2rFW3b0ujHuWk/qz/olhaWw=;
        b=gIAYqnir29IafmxXIy6/S5+s2s21W5ly1yeGqgbV0E+fwBO/K4fHssMBPvydPoYQwl
         L0BRgMWN5p66gc4172dtfvV7JJK1VRnsg5FQXqQ3DDjrjBAxK3RjqwqJu0CazznOp44V
         mfd+5iaJxQcDGaLukr9AoFym11c5AK4c1q6jDPlXMDJCmk5f5XZqcmrgg8zQGzJcJiJH
         AYyNl+OxDzKFZ8Q+Z0hSVuO1wi6MezsuUINS5NJwQUzqERloneVRUh4cOcTnoNa6Rh4z
         ZX0vjBKTM5xqhXkrK1v6NIoM5Ut7UXc4N7p3Mm//9mb1l1Edb13RRKqzKG1mTW8zEEAi
         V9gA==
X-Gm-Message-State: AOJu0Yy6OLMySNCPuaknIRU4CqroUFsZJLwlYaT7zSqkMUKngkWeYpiP
	GIgHmXF2pT7c8PqsAle1Mo+po/w4RVSGpc4e1mX8tdvTWfGpjY5pKWYhcGQj
X-Gm-Gg: ASbGncsnA4SkwnvntgpS4qW/v9TS3QLUmhLXSWSaGHhdXLRAfNqO/BT/NtqxXB3FFHY
	IQ2rWC6KJIUx5V1YI+/kEtQ+OeemaGxtlFTUF5BlrD2AvrYrwhN+NUBITumYMgBH7qt5RGa9sNw
	UNZ+VXXYkLW1BfLrfGeENPWKO8O+qjxtXkoPjaCmBis1iBCy1SV/3E6TuS4NIlSK75NyyS/Ctd9
	3+wDtd2kaDKXT4wQzVG3SjlZIMinGdtj+YHoUYBCNOd/K51sfrCW6l8zx+CgbxfNP46IIx7b1Oa
	9VN68ZjqjOwM9gQSZuHucDRKGxpdBJ4aaTdSkxuSg0yLc4da5kniL/Ufc6QxLFYO1s+Vj/Lj3RK
	4uvjlg667SBPE3IzhqllngzW0RgCLFvLFrlJOK/skVofqzL9nl1V5A1mQjZJ+
X-Google-Smtp-Source: AGHT+IHRuaVB+juwR9Yl+rIc5cm7zhVA8T+0Hn5EdWWjCtzS4tEoBRlrv1BZW3dveWAhMPxLcSjQ/g==
X-Received: by 2002:a17:907:9693:b0:abf:7453:1f1a with SMTP id a640c23a62f3a-ac738be3a97mr1295518566b.36.1743538389288;
        Tue, 01 Apr 2025 13:13:09 -0700 (PDT)
Received: from hp.NAT.swidnica_mmp.vectranet.pl (178235177162.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.162])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7196ddfebsm799078966b.164.2025.04.01.13.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 13:13:08 -0700 (PDT)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	j@w1.fi,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [RFC wireless-next 0/2] wifi: allow tagged control packets
Date: Tue,  1 Apr 2025 22:04:12 +0200
Message-ID: <20250401201259.50627-1-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Base on EasyMesh spec:
If a Multi-AP Agent configures a Primary VLAN ID, the Multi-AP Agent
shall send EtherType 0x888E frames on a Wi-Fi link in a Multi-AP Profile-2
Network Segment with an 802.1Q C-Tag with VLAN ID equal to the Primary VLAN ID.

Today I see BRCM agents already tag EAP frames when we enable
EasyMesh traffic separation.

This is initial version I tested using Mediatek mt7915e and hostapd.
Guys please check/comment.


Janusz Dziedzic (2):
  wifi: cfg80211: allow send/recv tagged EAPOL
  wifi: mac80211: allow tagged control packets

 include/net/cfg80211.h       |  3 ++-
 include/uapi/linux/nl80211.h |  5 +++++
 net/mac80211/cfg.c           |  3 +++
 net/mac80211/ieee80211_i.h   |  3 ++-
 net/mac80211/iface.c         |  2 ++
 net/mac80211/rx.c            | 40 ++++++++++++++++++++++++++++++++++++
 net/mac80211/tx.c            | 24 +++++++++++++++++-----
 net/wireless/nl80211.c       | 11 +++++++++-
 net/wireless/rdev-ops.h      |  5 +++--
 9 files changed, 86 insertions(+), 10 deletions(-)

-- 
2.43.0


