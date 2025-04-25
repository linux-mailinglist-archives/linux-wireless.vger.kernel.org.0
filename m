Return-Path: <linux-wireless+bounces-22047-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4734EA9C1DF
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 10:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2E1F16D2A0
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 08:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0596224B06;
	Fri, 25 Apr 2025 08:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DIYh1tWv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5779B22E3E1
	for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 08:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745570731; cv=none; b=QO6/OwiEaoKY4ytA5z3vG1TXUpb4gUtzseEUzxhs6BeWKrY03WxQ3ArYAU/6rknFDvw+7eFN+b8mlOm5oZToDpXxQ0RYt9tuenmuOOa0TApQ2vlNdGqrGjG0AdSMeoZrGr4qBUuISPnpbkTObJgVJDm7d5lczUgaGc5wwzrf/Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745570731; c=relaxed/simple;
	bh=omYrwZdYb25oWLgw0ZEamY66sK69quFj8xSeiTyG0n4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WK0BGH8ZtwXqypNPkVcbNdy2DTUDjtXYtz19mtI+AorJQlw5+WkN16REKCJUIjRrqcYWIMrxM0I/OroCHC9uEyM8fk/2z4amUCI2heHAnDZHh9pSpfsWFQEhmj9Z73J0eA7M17yfxROEnk4cR7fXeowDmwYqDzVl/uzzTvcKoG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DIYh1tWv; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22c33e5013aso24843585ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 01:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745570729; x=1746175529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9P7ZnmS7Adv4oGaE9rUSXG5FVmUraTI24z/lLS0uB4=;
        b=DIYh1tWvT1vNPL5yxiI4nwSqRUHxuAgoNLMWHP0oOsgA+aB0lxycPuUNeb3yRhj+1w
         CsR2pPj5b8qQ0XimAk/eOzo8ul2u1+7E4HwEYAFWdXnXa/MPP3fflTnNiVNrkxxY1xVy
         zeYbI7ciVzaeo5PrvJaO9iELH4zl3AMY9XVg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745570729; x=1746175529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C9P7ZnmS7Adv4oGaE9rUSXG5FVmUraTI24z/lLS0uB4=;
        b=H9Ytstx36kv51aGFW9EYbeLQGF3n4qdGVD3mZvXKiA/aIn6Tu5gM+T5mOGGA5Wz8yd
         KZlk1jlicrsUCLR1qbCRGVM1l1gGLFCiUjWUQKkBO+Fxz0xmG/8RVE7boHOrlmB9c+GE
         Bz+b27ERle9dqcV4C2ljZLeyncpxmKkhN5ljG5VRE6TZqbOhnRWfrlgrrHpgVWyxFrwx
         LMwl+3/0vB9ZUySx3HTt8nEF05TpHnb1MAGcZcRJ1KEvXVwClbZayqYSVLJr3fG9vI3X
         GxV7WsB+GKvk2sSAaoRtX2P8nqoqsYAKbDqnSO3bdSxl7XTCbZgdDnCTgaZjLcSFaEYQ
         l22g==
X-Gm-Message-State: AOJu0YyS8WVHrZYKNiLPL0H4fLLJwq3JajPbsBo5lHXQvfic1/C4oWnk
	6kAUOBfy3DNtK74sj+eb+jzCIIJIDk4trFnqjuuGq+yJhNUehMdix04BAxQOmw==
X-Gm-Gg: ASbGncuENDLR9dxEQvoLDxwBnlVGoN5DiHf1Y4Wba9PIAOkxPbvq58fCwgwLV+5S+5L
	0U4r/ZsIoU8adFn+Etrin9RI90S370Cd9z7mJOSXgg3wxOBdJgV/TwNjUVN1QmVqEDaspdFkxvQ
	LffGLVzc0bNgpZv3HytzuUcwVsPEN3hJqmqR5/ZS3pk4SvusbZjSITmPGNbrmTa8PDCrwec/sTM
	J3BJr7tyYxL3Tul0KE3GY0+s877uA7ActxIDqRnaLjjQ25OgeTCRBr+U3fVKYpoHBaMeCNim9MB
	UXNmPBuGpa4sC72UYKnKhDS/P+bQQ1v6ZlE8FLkIc120ioalhYGrV907pMtARpjNBc0OdMOU/sk
	3oukNGD0WBEY5j2WbpcUr
X-Google-Smtp-Source: AGHT+IFygxOVxMXjzAP1V8OvkKX1EfIZMiFMhKc+765KzampPZRjlxAWaBU0yFvoSDGMhyfP2Ew6Rw==
X-Received: by 2002:a17:902:db0e:b0:224:a79:5fe4 with SMTP id d9443c01a7336-22dbf5deeb8mr21635345ad.2.1745570729408;
        Fri, 25 Apr 2025 01:45:29 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5102ddcsm26883665ad.190.2025.04.25.01.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 01:45:28 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	Ting-Ying Li <tingying.li@infineon.com>,
	James Prestwood <prestwoj@gmail.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH wireless-next v2 4/4] wifi: brcmfmac: Fix structure size for WPA3 external SAE
Date: Fri, 25 Apr 2025 10:45:05 +0200
Message-ID: <20250425084505.491631-5-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250425084505.491631-1-arend.vanspriel@broadcom.com>
References: <20250425084505.491631-1-arend.vanspriel@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ting-Ying Li <tingying.li@infineon.com>

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


