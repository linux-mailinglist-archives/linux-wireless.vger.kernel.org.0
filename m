Return-Path: <linux-wireless+bounces-22024-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAE5A9B870
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 21:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BEE57AB11B
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 19:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709A3291169;
	Thu, 24 Apr 2025 19:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZSC1pZeE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1795A27FD56
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 19:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745523812; cv=none; b=SeuPTc3LcKuVqpspGurDCQyU4hmJU2bJA+9SRgXpdGb3kIZBbYP9WAMGZhjmmmIxhYJWHwj5Xx6m+0p5IY8x1TJpTa8Djjtpqgf5jpJCMnDCTFxUeSenzBiT5Va3en9/DXmYLgeSt5kQ74cojZuY5HFu7nZx4J4gUpJqJeRh+eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745523812; c=relaxed/simple;
	bh=xGl64ujrsdrC4dnDMQhjfBUYQlSQajI+VS8adhfAycM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a1ApJrBPYFyh99G0bXBgh52SURuc1Yti5txZRxVW/Pr3x440j6gtPlKeYUmILcwWSf4ECWBtsZROXA8mfr6nDLTYy69ZEobbJQnXbqcPjqd81Q4twHOUQZvwbSKLE33UBLvFRAJx+UvsUJtnVMkV6uo/uK4WbpRnNRVMKYqd63Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZSC1pZeE; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-736c1138ae5so1426819b3a.3
        for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 12:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745523807; x=1746128607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPDEHHnO2E4wWn9hSbYFv0XULhkYtZMw4vPWkP8Y7ZE=;
        b=ZSC1pZeEK7ABkqNmjp6Mc58yaorQ17x/DY9oFydXYaa1dZxB7o0ssqo2+8GhIwq3YC
         8d8dJpoFvuzrqQYNbQoFYWNm0Q0FOPfQs+9anoGD6DLhyAX/QmWB9oP6sypJ6YOHyygP
         Kr0zocEhzGFKBEg1YnRSQYuCScdvQHRcMYoyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745523807; x=1746128607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPDEHHnO2E4wWn9hSbYFv0XULhkYtZMw4vPWkP8Y7ZE=;
        b=N0tp0fQvnRXBPaqmcu8DLZ2QUGtY+opt1zppiP4Qkq1jivKzZjdEVidDQhLJxjnZsh
         zdXveAKk09dwU86VgnuV+XpTMHvFLtTev0ClYoc+81YOoYH4AlecZyEO4UQuOy6XaTei
         6X3pdwWXasdBpFsBYO3KA572e2JH0MHJTKLjdQnohsVvCSSB43L5wbw9VCeStmc/IVUu
         Bih4CG/qo0FmU559zSRHsw+qLot1vUeJRR/+qRveYcUz3o/MvFhps9am+y3Z53Fag5Cj
         GcCfdlq6VYLv4Xe7FTHJNzFsihqoqi7V8BRusZJfqUx6IwQ1lvoKYsiF3LUrUHXKvKim
         elDQ==
X-Gm-Message-State: AOJu0Yxtnrwnb/YMlzERUiabM/MT0USFuTuBFQWXWmGfu2QY1H2CLbFS
	owpAfqAAE3CBORgkyPzYSY50+1V7Qt8l5oB+tIQdRmxzp/DY7S6NFVc1LuRZPA==
X-Gm-Gg: ASbGncsGBruf1kEwwIB2q9WBxn0zPdOiaMdcrGLSyCX0gy5rt+Isj/lNmEsaocOLfsy
	XuuNl+j1nF5OHGVciRj9EwmGyU3VFTPEnNi3qAfYvu3SSeQOL4EgrpVyZtvD0b/bNpHHJJrvNcg
	9Sik9TCPH1PVKBvzcwpgrKpwYQ2FfT/b3jiiPzu7VLIku6j2gnjhISnjdekKipK1gTEW2Btfinw
	7vA8ofu4sy3yYysqawt3aT2Pbivzs9cD0bGnrr2Sj9yzGjZm+vTkwStNkAkUBiLnV8z2Gg67iH3
	NW95fP3qkLFDzs3xOnjwvz/uDvWIOaqFl4gk94pskzj26VDQu7lcqMarHcLXQs83ot64mtVMPTM
	OAX69y3i63Wl66hflhd4W
X-Google-Smtp-Source: AGHT+IGqPV5RU3YRJqKxlFcS4ArDbfyr8689XOGUQmFQZvrizvJi7h0h8dDGGgkj4fVx+2kC/VURZg==
X-Received: by 2002:a05:6a00:39a4:b0:73e:359:1c86 with SMTP id d2e1a72fcca58-73e330d3b0amr1224863b3a.18.1745523807257;
        Thu, 24 Apr 2025 12:43:27 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a6aa52sm1863494b3a.94.2025.04.24.12.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 12:43:26 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	Ting-Ying Li <tingying.li@cypress.com>,
	Ting-Ying Li <tingying.li@infineon.com>,
	James Prestwood <prestwoj@gmail.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH wireless-next 4/4] wifi: brcmfmac: Fix structure size for WPA3 external SAE
Date: Thu, 24 Apr 2025 21:42:39 +0200
Message-ID: <20250424194239.2825830-5-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250424194239.2825830-1-arend.vanspriel@broadcom.com>
References: <20250424194239.2825830-1-arend.vanspriel@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ting-Ying Li <tingying.li@cypress.com>

Add pmkid parameter in "brcmf_auth_req_status_le" structure to
align the buffer size defined in firmware "wl_auth_req_status"
structure.

Signed-off-by: Ting-Ying Li <tingying.li@infineon.com>
[arend: adapted path to apply to per-vendor variant]
Tested-by: James Prestwood <prestwoj@gmail.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h    | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h
index 18129adb5dc2..1cbe66526d82 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h
@@ -54,6 +54,7 @@ struct brcmf_auth_req_status_le {
 	u8 peer_mac[ETH_ALEN];
 	__le32 ssid_len;
 	u8 ssid[IEEE80211_MAX_SSID_LEN];
+	u8 pmkid[WLAN_PMKID_LEN];
 };
 
 /**
-- 
2.43.5


