Return-Path: <linux-wireless+bounces-22045-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E2DA9C202
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 10:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6102B3B1217
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 08:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C751B6D11;
	Fri, 25 Apr 2025 08:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PE0eWpiR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C7E21D59B
	for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 08:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745570726; cv=none; b=FYzjZRl4HTjVTC5pnHN0ta8Oi9pygHpJGLWLz5d+qRiAgTRPWlZkMGLpXOd6eFry39EwO36X64pcd+xbc64STdh/EtO1jQvUPawX4WRfvMihieUXjkUX73V89odDWk0RzPGOZaYhrcKSB3bg25fAkWl2nK19yWj373YnrYcjyCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745570726; c=relaxed/simple;
	bh=e0XX8DohJ6VA0/cNyZXvWggjah+MHvEtyETKVHlxyO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pq+Vbzk5rF1ndbnNDH8T3n3Y8o8B/cO2dTE0SNU+9w7W4GxSzqFMTOOeJ+hFNOTlE0D8BMupmPM29Zq12u0ykaqXFlMlld2yt8unYizSXxn66CkQ7PEIokBy58ojRAVjtDqGG/6ds/MWB89j+1Dm/K/eUpPxMGYJDT0wBU5Gsws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PE0eWpiR; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-223fd89d036so25070775ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 01:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745570724; x=1746175524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2UZxtW3kPc6nJSgpcHu4czu11dbH1HDpqjV9mIbR79E=;
        b=PE0eWpiRln4fCSXAiq0EdKabi53amZ3Vz81VuCq/WgJTY+uCvLf2/vgCbqkYRaGC59
         d3mg9Oz5MNtVsVz3bWEHah5Mwxif9Z6DKn2NKcR9OfMLNRpzW+eMOWmZqEnWjzfZ7Lwt
         bBAUai4Qapw7pHPI5vY++TTvaC5HN04mYDDcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745570724; x=1746175524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2UZxtW3kPc6nJSgpcHu4czu11dbH1HDpqjV9mIbR79E=;
        b=SaOAipAn/Cp0LCnlFtZzLvUPTdapLV1Cge7eOLDLlsiEVB0zY4GzhyKRBfjQjrhhnw
         WlIhVj7u7u4yMf6e0hjv+pOmzp6HkS5WfhaE9IDVnBP8pTdkzEfc1CwFcDFM1KyfClxi
         xSz6LArqN+wTHuMEwHBubukpZDuqgPyaCRUfW/i0QJ4lH23L3QuMhnTksRoDu3NZPM+X
         qdTTEnVIAyd0XsT6Vuij6h/RQ2Ta4DzP1uWI8xWaG7JyMGwnUvkMxHDOlJiDyRmX60Ri
         5aXQM+9I+7oJ0vMd2xcDvmNgquKOjwNKPw9ECwZezYAmIHAmYtyGHMo9YRdKqucPVviL
         qe3w==
X-Gm-Message-State: AOJu0YygClpVB99aVkULW1OLzxunxZgH3p64hZ5JpkUjMTZmlq8NEjmu
	zMFsbqAwEE6dAT17fBbsWl3faGmNgj9TsgOyoXqZwqoKul1b0WoKJDyOD96Fhg==
X-Gm-Gg: ASbGncsTh43UhhBo3mvpx3Jz0H3m84GT8QKYyU5DU9LyZPNERwL5NETdpIbVVHB/iNl
	Fu8tU0F17WaVyoPB4AAiG6e6HFuyinWkECet6MPJ/VMc8tQ7jl5yo1MPYgNNwmQbrnoutVF9eIc
	IUgUnxC0wX03DvVrSrGFhyLG+7z0ZGK0BeBDq6w7x9T1EPWp7vTiIxu6m8Ls5kmwKz1TGg3IpNF
	WeM+mYhWT36iuGPzK8Tcy0rr9pAGHny/zOh+5mozhlOct6Hvk+mvsjd8fzt0hfld1oETpRH2weu
	w4Mwpg/5bv+zCxj7aKYhBOq9/R0uTdtNOswcST3R4fHXT6PLzF3bFCXR6sRJ/7YDuuUQgK2G11A
	7u/7rgp8S2UWoTq8/aTCS
X-Google-Smtp-Source: AGHT+IEnj4QYzpVB6HHq3I6wqUH08a0ZpDspLpgUhqj3FZCWddBKMi+iXpwHZbHfGw23vUzS+X5Dvw==
X-Received: by 2002:a17:903:3bcf:b0:21c:fb6:7c3c with SMTP id d9443c01a7336-22dbf5e03cfmr20862325ad.17.1745570723732;
        Fri, 25 Apr 2025 01:45:23 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5102ddcsm26883665ad.190.2025.04.25.01.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 01:45:22 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	James Prestwood <prestwoj@gmail.com>
Subject: [PATCH wireless-next v2 2/4] wifi: brcmfmac: make per-vendor event map const
Date: Fri, 25 Apr 2025 10:45:03 +0200
Message-ID: <20250425084505.491631-3-arend.vanspriel@broadcom.com>
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

The event map is not intended to change so make it const.

Tested-by: James Prestwood <prestwoj@gmail.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h
index eed439b84010..38a9138f1fd3 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h
@@ -337,7 +337,7 @@ struct brcmf_fweh_info {
 	struct list_head event_q;
 	uint event_mask_len;
 	u8 *event_mask;
-	struct brcmf_fweh_event_map *event_map;
+	const struct brcmf_fweh_event_map *event_map;
 	uint num_event_codes;
 	brcmf_fweh_handler_t evt_handler[] __counted_by(num_event_codes);
 };
-- 
2.43.5


