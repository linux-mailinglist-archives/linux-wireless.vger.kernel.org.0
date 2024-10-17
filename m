Return-Path: <linux-wireless+bounces-14144-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B2C9A1C9E
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 10:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9128287F73
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 08:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190E21D26F2;
	Thu, 17 Oct 2024 08:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3+MJgk9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256A71CF7C7;
	Thu, 17 Oct 2024 08:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152423; cv=none; b=Bg3dKTkTBw8dAvnSzEA/dIHSEpoygyWWOh7puAQ9Ks8KmQcpf0IZfGzR28nHi7X+4BMf35xllRegCFB7rhtiJLNpCtURSuSdwLAMXzbHItJfIUMsImbhxkIssHeUhNPLaHyMlmBvRuPmRQyakgYooai2RhEpmi6VIZGXAmVeglM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152423; c=relaxed/simple;
	bh=34qmFnpjtPgM64hHV/d3KZI9QOhHrf+WV9t+kBM7t3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TpnlTkqSN9pCpxt9OISuBADYyl3/0jBnu3QWNWXQ4YyvOtL6cHFRVpmn0ogfsCKgf7Etmlz8vUBvZeBOVuQ7J9RAUJuxhXD+ymyi7uTFm+IZzToqg8oLIuTCCkSentvc/p2PdfcjHahs4jG+00CkjRcsIj1qTh3OI1PITXknpOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3+MJgk9; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e1c91fe739so520298a91.2;
        Thu, 17 Oct 2024 01:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729152419; x=1729757219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=doPdjyTqoRoh33hI7C0I8OBtLtfWK7Aq8acLdfXO4tk=;
        b=h3+MJgk9+VLqnGWhb9uu6AjVL4xe4p0dGEiXFwmkdd2eBsALoiU7HOe/WcMz4xOuWa
         zHdBKp/qrQX5+WiLkwFrDXRQF45I+F2GqEGKcqoPpL3H/WJOfAy9rMb6+dPGAv7rAzJH
         m5pKjZRihLfkeyYwC1z7MLHLNHv9Wc76XaTzCYu+m87XcRUmaIiFr3lERUdR9lQm1bli
         a4TCMOI8eYH1FeCW0nUd9gwnEzoTJiOBqKr//SHYW6krVLSAPH7jQwaJr7lCiFFOB7uO
         qT+SxLFec86cIwvuHmDAMUKfxQF8kpL1XM7p/T3U9EwIGdpO20AqzDXXAPahwfGhcVUN
         QxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729152419; x=1729757219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=doPdjyTqoRoh33hI7C0I8OBtLtfWK7Aq8acLdfXO4tk=;
        b=hWDrKo5RCKasmVT7gEnp9o/c31/+Fah0WbqtX7p+yB3KkWGsdr7YqdcPSru/BzRVe/
         MNL0/5EbvCrisq5tWj8ynb4W2NlFW5e2m0X4OBBOwV2LFLCnm0X1opM9t/i7oIGNQ4Fi
         ezF9Dedm1Fkf3mYUl4DtHs8VsuQDKOAG7AQ+yluZDnJV63W1fRPNTsrNTJc/BfLZp55b
         mqoKm27LSu00IkD7uljRgc00a6ckkmi6gX/a//6t1+YCjs1M/rLXD/LROWEDpDNqndcM
         6zHAFMrs92bTKEG145rV0anl4fPvYSuCWO+mDthSz81AfVlE+IarQcwIfbvOekP+pSYb
         CkBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeEfrfBNgFfqrC7DWhmZC/6uDZAGkasxDrSQy4oeHUcrhpO8QYO/WrkP+cNudoqfPRWJa22XW4rdTdFA4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu5Gn8gXr8VQmfADsibbjsiBsmg4bDKYnsrqMyZlp02hYEKBXf
	M6fCfTbV2UurG3/rBLmghy/s3/lhC+EoScUaUuX+/yVauxbp1vDcdVgflAr0
X-Google-Smtp-Source: AGHT+IHsk9KSUSULHv3YQvFT1nOzL/iy4wVcpAiCOJZyZWCcEvefPxWBSxJ+1oX/bsWjt/dxebSLYQ==
X-Received: by 2002:a17:90b:360b:b0:2e2:8995:dd1b with SMTP id 98e67ed59e1d1-2e2f0a5d65emr22445720a91.3.1729152419036;
        Thu, 17 Oct 2024 01:06:59 -0700 (PDT)
Received: from archlinux.. ([2405:201:e00c:517f:5e87:9cff:fe63:6000])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2e3e0924c68sm1205658a91.39.2024.10.17.01.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 01:06:58 -0700 (PDT)
From: Mohammed Anees <pvmohammedanees2003@gmail.com>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Mohammed Anees <pvmohammedanees2003@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2] wifi: rtw88: Refactor looping in rtw_phy_store_tx_power_by_rate
Date: Thu, 17 Oct 2024 13:36:38 +0530
Message-ID: <20241017080638.13074-1-pvmohammedanees2003@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous implementation included an unnecessary else
condition paired with a continue statement. Since a check
is already performed to determine if the band is either
2G or 5G, the else condition will never be triggered.
We can remove this check.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202410171143.OnFlgIwK-lkp@intel.com/
Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>
---
v2:
- Changed from using a pointer approach to a simpler if-else structure for clarity.
---
 drivers/net/wireless/realtek/rtw88/phy.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index 37ef80c9091d..8b9f8f73c14c 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -1470,10 +1470,8 @@ static void rtw_phy_store_tx_power_by_rate(struct rtw_dev *rtwdev,
 		rate = rates[i];
 		if (band == PHY_BAND_2G)
 			hal->tx_pwr_by_rate_offset_2g[rfpath][rate] = offset;
-		else if (band == PHY_BAND_5G)
-			hal->tx_pwr_by_rate_offset_5g[rfpath][rate] = offset;
 		else
-			continue;
+			hal->tx_pwr_by_rate_offset_5g[rfpath][rate] = offset;
 	}
 }
 
-- 
2.47.0


