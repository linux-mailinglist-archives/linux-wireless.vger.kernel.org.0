Return-Path: <linux-wireless+bounces-22057-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F11A9C284
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 10:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC4391BA149F
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 08:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACD523BCF0;
	Fri, 25 Apr 2025 08:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cZd5xjC0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9584B239585
	for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 08:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745571343; cv=none; b=mZw56DIB7Mx+JLi12h/+/+nzDBIX7vJOkqcryZifolzNVGNVyXbl4XkPnSOQq3sI1x4kGhDTCmSqcPLRWoJNw/eymAtvE5s0TKCTSDpcybkeowttl1ppOtU1EPsy+SIGe+7yGdzYl03oZFwZOPZdqMcuoNyZBLP7ah1MT/ZaMkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745571343; c=relaxed/simple;
	bh=yO1N7q1nXmdEytuVzH/H9GOfUp8zohzbYVr7ticuj1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9kUs2vALDatbZpL03NQQeyyCtkVp4O+HqakDMBianLpM9sEiFEvh4trEkxQzr+Rdu5uHZOX6LcPCnoQYwtjUfeYM6DzFE+oS365ZBzsYL5LwHc1tuCv+fpbGQozJBn2REyrjzNr29HpdaWVacavdxL+4GjsH8v+Gy3exTyF05I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cZd5xjC0; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22c33ac23edso18943385ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 01:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745571338; x=1746176138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OExy8sLSrgvVCUmAwXcFuSjWTxfcCVAuIO4FJVxyYMQ=;
        b=cZd5xjC0xUgpPozg5qNmiP5Hy51A34PXpoDEqxhpp7Akt5oXHCO4FoiGLijHNoFPsZ
         bRakDgATVOOodjyEOcTJUHDwC6PE7PUY4Pr0vU+G8IQFEcvbh2bsbGsFcuzkip278QeP
         +f9yaaXwl+onYa4eG9WZUa4JKDiolOmOFl2lo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745571338; x=1746176138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OExy8sLSrgvVCUmAwXcFuSjWTxfcCVAuIO4FJVxyYMQ=;
        b=tWrhUrFUO2m7Mk3BaW7adPV/ndqXNx65Q4TgD6c4HKHUt0kyKASCMyJ4cCsO/Bz1hj
         r4HXJHjvr193oXUzUYOwWAZRn5AjTZS3QDwLCwa+hVxtFxxrEylkEsKa37bhleplvatS
         WjkMMt8CZ7kgqEFrK66t9+r3BkP+kbI1uBSweI8yguO29dVhrqwhXFM/YFbKTLl4/8tK
         MDLnvSl5C4HDbzNOCckFkV8EBjxIw3gdM9Nrtxv0/pOTMzGHJJ5961WVxuallz38XLH1
         oNXs492Kvz2t7XFsvOE1T13cZ/EAMWvtBQFzQO2pEDzklKznO/7VqcsFnT+AsFCA1GwJ
         p4gQ==
X-Gm-Message-State: AOJu0YwwaZ1R7M5rN1LauqRc9RiMikNKma+Y4mHZuqar6/xe1E/NyS3l
	/SAT2qqZ06e6gijr6bXRPD7fwpRUKEVOc4YSFyQNflwsExGy826QKeBYyQHmhw==
X-Gm-Gg: ASbGncseP8m2yqj2vGtcQ6edjlr7ihd+BoDeHSV3J8NB+73fgp8eAPVRXa1xCdC36t7
	ZqLUAKvWW9NzrN9PkdV1fXc4cbgBN26gwFwb71fO5fCmqGvft1l9veqdRlmVjSQEwPp4MGsfohW
	4djsn/uJy4/4q2N/kxykyVEsmmTGusiqeCwE54Ecd9QQjc8osMQVH4CwUzDs/CQ9YbFHy5KEnod
	6JSarivPYXqDUgbIbC2IPTsuE3Vd9YcUUYIMAp8qI456SbdxiVibtPFAHPAzG5sQpo01uVF+5BU
	JCK81OUKKphUbh/BhQteo/VhNpU85KDxrSpmiZ+2BPS6Vl9ILMc4jyDcV2TbolejBfQKCl/HEUr
	9qUwJ7lI+R32tUbTjyIrJcnzodB9k7XM=
X-Google-Smtp-Source: AGHT+IGy9424wFQXc6q76hRX5u3bEVHS+OQ7YL5gz6P4GiK8kBGxJsLEf/ZcJDGl3WryIX9/E6QsUQ==
X-Received: by 2002:a17:90b:394d:b0:2ff:5ed8:83d0 with SMTP id 98e67ed59e1d1-309f7ddd554mr2845768a91.16.1745571337774;
        Fri, 25 Apr 2025 01:55:37 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5221943sm26988875ad.249.2025.04.25.01.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 01:55:37 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	Ting-Ying Li <tingying.li@cypress.com>,
	Ting-Ying Li <tingying.li@infineon.com>,
	James Prestwood <prestwoj@gmail.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH wireless-next v3 4/4] wifi: brcmfmac: Fix structure size for WPA3 external SAE
Date: Fri, 25 Apr 2025 10:55:19 +0200
Message-ID: <20250425085519.492267-5-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250425085519.492267-1-arend.vanspriel@broadcom.com>
References: <20250425085519.492267-1-arend.vanspriel@broadcom.com>
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
[arend: added kerneldoc for new struct field]
Tested-by: James Prestwood <prestwoj@gmail.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h   | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h
index a3243b940f10..08c69142495a 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h
@@ -48,12 +48,14 @@ struct brcmf_eventmsgs_ext {
  * @peer_mac: peer MAC address
  * @ssid_len: length of ssid
  * @ssid: ssid characters
+ * @pmkid: PMKSA identifier
  */
 struct brcmf_auth_req_status_le {
 	__le16 flags;
 	u8 peer_mac[ETH_ALEN];
 	__le32 ssid_len;
 	u8 ssid[IEEE80211_MAX_SSID_LEN];
+	u8 pmkid[WLAN_PMKID_LEN];
 };
 
 /**
-- 
2.43.5


