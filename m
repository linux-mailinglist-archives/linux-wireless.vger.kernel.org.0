Return-Path: <linux-wireless+bounces-15541-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AE79D4809
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 08:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD8F71F21ED6
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 07:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75416145B18;
	Thu, 21 Nov 2024 07:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OC4obv+v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D3BBA3D;
	Thu, 21 Nov 2024 07:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732172970; cv=none; b=ZViv3ckgGVwzOpbTERvTACEcbcYPzIIQnFxRHF7xosUiMQNbOFl5T96w6e4US3m1IaFpcR6tgzNMF5mzbE+fFPW/jymhEF0hJEyYC/BYyUU1O7fA6pkxddmlmxBc0SlcZ9WcrrVwcWS7CFPKmz+Z6PhBGRYXkBqLANEZDnzN9MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732172970; c=relaxed/simple;
	bh=aLFFCjrkdkrZhCu/NyexcMDYEcrLWZtaulB8rWwll78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LW2M6PrN66e3IluBniNjDLEoM2X66mcYOlM7hm3YCat+jCEERbyZFn9S8+T+P6M9uo33HNw/cf/2hGiy530r8Afm1JDrvjz8Vc6N9+K1DxchX1uh0+AepVRQxBbduGiAV2dxqJ4aoJg2oyjyhrGnpkAwhvKxnXHosnniKFtBlgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OC4obv+v; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ee7e87f6e4so524040a12.2;
        Wed, 20 Nov 2024 23:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732172968; x=1732777768; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K/bV5oWLDBC27cWZHR043yZGMTpwFi3iERVni6jKJ+U=;
        b=OC4obv+vbiKp4YIQt3CdXhJU2oo3JAUqi0oFX9YID3Gx3Ax+uJ07TCl4ZjYid3bKoc
         W+1zXHPT4+Xgrvt1lokvJ4PwgzdfTLixoRfsB1hWrfjlDWYuHcJJSf1qv6HVw7ZXAzRd
         K8ESZj9fYHphSm07mvF3COUfpCPcksW9f5q5luBV8Mh8sVGS/gk9vn9gSBr3/UPD9llQ
         gGS8xcbFG1wVrCmwMO8AECwoXAbc+l7ZjHTmU0P19X/z7ZdOABzQ0513TKQDKf9pr4sS
         /s/pS+JFZ5tf96VCiRWp55J16k7f0+ORd4Rw4jOMsboVdfH519ewh4xsASx6HXRq0w5p
         hAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732172968; x=1732777768;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K/bV5oWLDBC27cWZHR043yZGMTpwFi3iERVni6jKJ+U=;
        b=k6GfBpKusBS1z2g5pxReLpSsw6gQeh7pVvfNnA1A4ZX7U1X3M0QjGxqN0opLccGNPY
         Z1q8C+JDRwDqt4NDDKN+Z4Z1UYzzICux3aa8BnmUWUa8vprTH+iy1KgNYIfZMFVhsk5w
         +EeznJ0Ux62B7s+1L9JzlyrmgXxKMOwhuGkFlubeGfNYTs2zBJ63C7nuvcvtFFaKNfc0
         CfrW1s08Qy4m3MX7kPtjj3/PjwEdDcDZ3Scu69MG7GN8xCgmFarDfs1ySFeEReIVvVhi
         oIGc0lmpIOF6JboRvZppWncbbw+ohWcgq5eyQIN8094DFdpPHOu/lhOAd4GqxSYfGI8h
         THNg==
X-Forwarded-Encrypted: i=1; AJvYcCXa5SxrNFaTinMR5UfxRy+ZNLI/0pRMlcNbMDkhOLE4YSdQ5X7k04ZepFkLE5fQHr92bBsoUyXsNMv1RAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsKFCwytwRu4rjzk0iUL8GMSrkoDt8lFaTKxpEBOXOtmDUm0J+
	1wM79SpgZghxnsCwx0FRT2cLO8ySxL9y6sAjJ6ucDT0nPZZrt44KoPm4AVCZ
X-Gm-Gg: ASbGncuoVRA4W2yffNFFE9kUl9zmnEaI4tRNZb2bCyD0csnHfb5asVhq9fuMRfeDl1w
	ECykh2xLJwHnkx7/5XT+/mqS5UlXVf90txqL4tJEFtci2FPdaodoxvIB/ev8/OQGe5WfiTlEuxp
	zqrcCRQowKDmeEYjUTuIZCS/sDVuixIJyxuO2qw4Pl3G+znVOX5lw3jV12fL3OpgNR3aypjLcc+
	w4Hi65+q7sz6CU17CsPc0qJZYnIZuUNZOuh2vJP5aGB+Z3Q3X0maK8=
X-Google-Smtp-Source: AGHT+IEHtgwWOWAxj1UqicM0Uxnp4+dMA2ZTYHHv9dEZXodElmUipdeypRzYo+JScji7D9JjaMV7kA==
X-Received: by 2002:a05:6a20:2449:b0:1cf:6c86:231c with SMTP id adf61e73a8af0-1ddaf0b8a56mr6867894637.26.1732172967753;
        Wed, 20 Nov 2024 23:09:27 -0800 (PST)
Received: from [192.168.122.73] ([103.12.224.66])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ead03356fbsm2479723a91.31.2024.11.20.23.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 23:09:27 -0800 (PST)
From: Renjaya Raga Zenta <ragazenta@gmail.com>
Date: Thu, 21 Nov 2024 14:09:27 +0700
Subject: [PATCH] brcmfmac: fix brcmf_vif_clear_mgmt_ies when stopping AP
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241121-brcmfmac-v1-1-02fc3fb427c2@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKbcPmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQyND3aSi5Ny03MRkXWPTtCSLRMPEFCMjQyWg8oKi1LTMCrBR0bG1tQA
 KlAmqWgAAAA==
X-Change-ID: 20241121-brcmfmac-35fb8a1ad221
To: Arend van Spriel <aspriel@gmail.com>, 
 Franky Lin <franky.lin@broadcom.com>, 
 Hante Meuleman <hante.meuleman@broadcom.com>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com, 
 SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org, 
 Renjaya Raga Zenta <ragazenta@gmail.com>
X-Mailer: b4 0.14.2

This removes the following error log when stopping AP:

ieee80211 phy0: brcmf_vif_set_mgmt_ie: vndr ie set error : -52

It happened if
1) previously wlan interface was in station mode (wpa_supplicant) and
   connected to a hotspot
2) then started AP mode (hostapd)
3) and then stopped AP mode.

The error happened when it tried to clear BRCMF_VNDR_IE_PRBREQ_FLAG.
This flag is not set in `brcmf_config_ap_mgmt_ie`, but
BRCMF_VNDR_IE_ASSOCRSP_FLAG is set instead.

Signed-off-by: Renjaya Raga Zenta <ragazenta@gmail.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index e19c14ba35f60433de3702873b0a776945d0e548..ac958848935c920d446b64ac650d40968606cc4d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -5022,12 +5022,16 @@ s32 brcmf_vif_set_mgmt_ie(struct brcmf_cfg80211_vif *vif, s32 pktflag,
 s32 brcmf_vif_clear_mgmt_ies(struct brcmf_cfg80211_vif *vif)
 {
 	static const s32 pktflags[] = {
-		BRCMF_VNDR_IE_PRBREQ_FLAG,
 		BRCMF_VNDR_IE_PRBRSP_FLAG,
 		BRCMF_VNDR_IE_BEACON_FLAG
 	};
 	int i;
 
+	if (vif->wdev.iftype == NL80211_IFTYPE_AP)
+		brcmf_vif_set_mgmt_ie(vif, BRCMF_VNDR_IE_ASSOCRSP_FLAG, NULL, 0);
+	else
+		brcmf_vif_set_mgmt_ie(vif, BRCMF_VNDR_IE_PRBREQ_FLAG, NULL, 0);
+
 	for (i = 0; i < ARRAY_SIZE(pktflags); i++)
 		brcmf_vif_set_mgmt_ie(vif, pktflags[i], NULL, 0);
 

---
base-commit: df8a2f6dc114b2c5c7685a069f717f2b06186b74
change-id: 20241121-brcmfmac-35fb8a1ad221

Best regards,
-- 
Renjaya Raga Zenta <ragazenta@gmail.com>


