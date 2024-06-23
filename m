Return-Path: <linux-wireless+bounces-9465-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A624D91390D
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Jun 2024 10:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CECB1F21C1A
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Jun 2024 08:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A065F3AC1F;
	Sun, 23 Jun 2024 08:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zo8V5acx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2543DF9E9;
	Sun, 23 Jun 2024 08:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719132587; cv=none; b=V0LOQzys8tYt9lCid542FTyekoVWhCx/csT76BlVPjsfz6M1Bm0OFbNdy3fqYQm66bKWOQzUPmMBxsIbm9RyQ6UpjBPwVzbCyDuHsWdFrJKT6uBn5tAfKSwbheCReRnTJGTGWQB9fx1yYvc5+iLNPNYyQXsCr9RjMtR6iv4zNoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719132587; c=relaxed/simple;
	bh=syI/SxmIrlCPRAaFRApCeRw0mtBptNJgzqt/9yPHroc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pZq3wz91hWt1bTsDeZ85T06E49RN2QqKc/Zpksyq3iftM4GQpMZvK5SQ0GM0W4TwLQ04KAygtcIkkxN6oxOWq++jMA+Udq6t5lLUW1dcTslo4dVczQIWgUp9l1nLxFXFVJ/VnOx09/ghekTbBXbuRdhJQU8PHtbHj1VnbUVmRbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zo8V5acx; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3d4430b8591so1860004b6e.2;
        Sun, 23 Jun 2024 01:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719132585; x=1719737385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eyjIdb9pPb8rVdEIkJ3vL91vHjhqANnfZwHii49nCls=;
        b=Zo8V5acxJrrErrxg0lxZIYI0nMxsmcnZAr2ngA1Y5DK9hxK8tle3BGEeuXiifQhL/n
         /Phk4IfNcVWzl0/FVxlgC6cYw1Z+ZW/uPxA9B3dQcUhzl+13tFJ6Wtq/BYmJxVk5oG3t
         oG/f2psDsuBCsedMCED5WGyBysXQE264YKbjWwKXdr4VK+Af2HfpNpVC6FxSk+g5lqTr
         25YitZk2Vn5FcFz8HnBnfyCmC9iBQmd3v8MgihGzI1wpqGekKHzNdOca8guh5jpBNdnA
         OGbMEEKuVkgfJk+jUdYFVYwGADe34yb4mii6NQ1Aiym5+jVearongnm61nQRgypkK8c1
         mDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719132585; x=1719737385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eyjIdb9pPb8rVdEIkJ3vL91vHjhqANnfZwHii49nCls=;
        b=W0R9/4zvNz/4tXVi34b6J1ZevLsXRzWWUSYZMVL3xnCb3RrgzraQCQ8f04RHbspt+y
         7klsn7NUmp5dwXp0kX30UlsS2J3QOzejfHexjcGZpdzDhpVQb6IlDAO1SVDZ9PbDG86w
         W9QujfVpYOZx0Vl22V5kAj18oggW0K3fMXjG6Nj0OJ/mkk3nyoRks+cfXMvJVgq4cbN1
         FUTOgYtgdhodRSVyZMThFQGE3ES4AQOuJpgGJiTyE83TK72ssu5Y2Q08xy94I13oEDCL
         eSS2LUoIO3HT/1pbSsk+41jo8PNpjzER0snKrlKEqZZw/3b9DYM4p+9CACjsj5gm8fUr
         /Twg==
X-Forwarded-Encrypted: i=1; AJvYcCVa4zBOJKV/K40ZsqiZM5ipgIpoYlnzGAvJIr4t55HYMWqxpDBiXns5p0Bh1CE2+2wpEMHRiS0DOLfH/Lb4em7p00ooN3EapOrEPseN7P0tlBo/uto6O9aoQOjIpx+YuRWfRmgB
X-Gm-Message-State: AOJu0Yw2notBi4i9hnCgpYjC18+AAp8+gYMcMlzfHgTEGMNhk9OOEVFf
	rW4ajpnLAf/BML1a/lvhW3QPLsHUwJAtBaBj+TIoC1QupxX2mKi1vtTG4mM2
X-Google-Smtp-Source: AGHT+IFLCSM3lJV3vst1b0HO/MHiokHxaSRdzsulVqKK+K6oVSy+x1mzeSS/qSPqLMUDQEtfjCufGA==
X-Received: by 2002:a05:6808:1928:b0:3d2:1d91:68ca with SMTP id 5614622812f47-3d543b7c678mr2349098b6e.36.1719132585027;
        Sun, 23 Jun 2024 01:49:45 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706512900absm4299432b3a.147.2024.06.23.01.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 01:49:44 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] wifi: cfg80211: Fix out-of-bounds in cfg80211_wext_siwscan
Date: Sun, 23 Jun 2024 17:49:39 +0900
Message-Id: <20240623084939.6889-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the process of searching for matching hardware channels, wreq and 
wreq->num_channels are checked to see if they are NULL. However, 
if the value of wreq->num_channels is greater than IW_MAX_FREQUENCIES,
an out-of-bounds vulnerability occurs.

Therefore, you must also add code to check whether the value of 
wreq->num_channels is within the range.

Reguards.

Signed-by-off: Jeongjun Park <aha310510@gmail.com>
---
 net/wireless/scan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 0222ede0feb6..f253dee041d1 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -3460,6 +3460,10 @@ int cfg80211_wext_siwscan(struct net_device *dev,
 			if (wreq && wreq->num_channels) {
 				int k;
 				int wiphy_freq = wiphy->bands[band]->channels[j].center_freq;
+
+				if (wreq->num_channels > IW_MAX_FREQUENCIES)
+					wreq->num_channels = IW_MAX_FREQUENCIES;
+
 				for (k = 0; k < wreq->num_channels; k++) {
 					struct iw_freq *freq =
 						&wreq->channel_list[k];
-- 
2.34.1

