Return-Path: <linux-wireless+bounces-19568-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 183F6A48B48
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 23:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DD5A7A2827
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 22:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6B6270EC9;
	Thu, 27 Feb 2025 22:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhXGZGQI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A2B14EC60;
	Thu, 27 Feb 2025 22:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740694795; cv=none; b=Z3gQQ7iVqihRo6MhYZjv/CJdI10J2l6DzirCe9xKueRwZxBl8iugNuVmnGzYhn63OpfiXxRzYgRavoXM68w8W8H5iV2OKyo0sPZYS0YMS8C+D45Zm2NrBbZjNIBHvqZ/33rGKT4UUZmgHyYHVRqExZQXTl+3zjBMrRZyKnKa9gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740694795; c=relaxed/simple;
	bh=tQLQ4Qb5GR+yDm170bdMS7rNsxooH9HGs2hjQiBmDVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X6c2Vzjn4+YYpTztcgG1b0IOP4PEh+SXtyleFcw5RGMAE7MY8asIs7694h0MlSILTmZAE2tfJyEuP5uggBo7cCxAVL8Hmz109D1KPa1jQ0n7mTxvhxH/SQclQUBVYs4mLzuz5YIJOkEKF/ixVCMT0za0Ya98GEa+yVZjA7c1coQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhXGZGQI; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-390d98ae34dso1148402f8f.3;
        Thu, 27 Feb 2025 14:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740694792; x=1741299592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+HtVIOGx2XF/5tiyDgdaSj6I6ZqXG5FQW6c9HkgZTs8=;
        b=KhXGZGQIuJujk8TUkyqobFafF8lBG3Aaw+tkGKJN/rFWvI1JUS1CYkde2HIAfQVCxJ
         j80AXe6jTKJiUUQTj6ns2eEr8EaZ6c+W59d0Ok7Dl8F/b05DM47r1+Ms5nq8EkxGJ1rV
         PQ3uTXamuNNugE8zcGsOWrHrVhPo1MSUk/MGdWaF0ywXVf/P6uaSJONE8Bzp6fD7gZKp
         I4e2IglZYvoiV2IFPxLYRwSOpmFVx89ylGLFJhjq+9ltCoRZTPCVCt87fniMSJTCGPY4
         dYMJn8bQ64ynp5VDGys1QFz1nZTyAJFUmNWK18J8VXc2+yKUuGZf+6IkT5m/5jwGEMQx
         SjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740694792; x=1741299592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+HtVIOGx2XF/5tiyDgdaSj6I6ZqXG5FQW6c9HkgZTs8=;
        b=pgBq4S7MB0ThLM0ZgCto6A5TmsWeuSsY4EM11Pxjibi7RAPC/9lKhVmZUUPE5M4OQO
         RgMzpmlsSWgioq7Kh4EdeTRWfOMOFj2ubiuyODqrgYZzSsXaUU31g42+tBzTls8HJ5H6
         5B4fRPfe6GDU936Qj5zeOPyRjIY7PuVyurC8DtmDPZlX6qKXwv0ICc19IDILkZ/Y7vfo
         ZdHcSfv3LPig+wgj02oX0o+OqNppaV5s0I0zWO01p/1nnHQHRJGnxXXEszqMWQBf/9w1
         DIJF8qPa+RajYxsfax70nxYXJOyq2hD5+wYRfn8y5pwa/JMK9ShturgQsaq2+e7kxTSE
         vetg==
X-Forwarded-Encrypted: i=1; AJvYcCUc/V1bIKibZ7VaqaiG41P0zDnxJTi5Z3ZboF3qX/VmKxCjkrfqWaAUj7up/+s8wVHC5Y1N7EwEWHdYMRI=@vger.kernel.org, AJvYcCWX5E7D2C7mp2csNAUQzZTaTIO+V3GRL/PoZ+41NTMBmImsXsqj5alKF+hbs0zefH2dcT2hs20wWpoGSAZ5Z5o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw70dq2VHKmtnB6myut7DaRCQInFnWe8Amc435NlatYXpLLtWlo
	JdbrhwMb8KxG8bTopzEY+E+BVEk0xfmByL7LCfuLHhvaJbnJCQsj
X-Gm-Gg: ASbGnctB9Nlc+0sjyrjaSECVe5lPDWfrr1vRc+oSgXXX/tW8TZ3UImocPNEEItH90HW
	xsu3PNSpZCEh8e6BJGg1tKW6JSMxvWzkEwcU1Yzf/fBbb8x68v8kh7cNIvBLOiFjE6wxHUu6UJj
	b5MyWMwo/sFH2vunW6Swx4NENKw1xiILqdTb491t5h334BdW9bUhTCAR8CVE0PWzZenyCER1jFa
	ELPS8GZUH5j84qnvnMwKptaQ4r7jk2eszhBJ67J6TfR843xrge/eYXZSIhxoGQQqamFXwAk0+tM
	//BAxrLLGLer4akjxYOmR2PK3Mc=
X-Google-Smtp-Source: AGHT+IHbKkd9Alo9xQcVDmn3QI1aJq3/D7sXGkjMNWDCCzURyn5dbm5SUY01V6jWJN9VV8dTdNwhbg==
X-Received: by 2002:a05:6000:1a8d:b0:38f:37f3:5c9a with SMTP id ffacd0b85a97d-390ec9c2556mr760049f8f.31.1740694792469;
        Thu, 27 Feb 2025 14:19:52 -0800 (PST)
Received: from localhost ([194.120.133.72])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43aba52bbb0sm68003095e9.5.2025.02.27.14.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 14:19:52 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] wifi: iwlwifi: Fix spelling mistake "Increate" -> "Increase"
Date: Thu, 27 Feb 2025 22:19:17 +0000
Message-ID: <20250227221917.658401-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a IWL_DEBUG_RATE message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index a8c4e354e2ce..068c58e9c1eb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -1783,7 +1783,7 @@ static enum rs_action rs_get_rate_action(struct iwl_mvm *mvm,
 	if ((high_tpt != IWL_INVALID_VALUE) &&
 	    (high_tpt > current_tpt)) {
 		IWL_DEBUG_RATE(mvm,
-			       "Higher rate is better. Increate rate\n");
+			       "Higher rate is better. Increase rate\n");
 		return RS_ACTION_UPSCALE;
 	}
 
-- 
2.47.2


