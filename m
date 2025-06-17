Return-Path: <linux-wireless+bounces-24180-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D886ADC448
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 10:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A423BBF6D
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 08:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AE2293B5C;
	Tue, 17 Jun 2025 08:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="tl+s5vpS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D2E2949F4
	for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 08:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750147642; cv=none; b=pM4BrC6DfbzagXRTeDDBsUjInkmuc1bzfUHqNMHpchJk7M2HUwJ3IJBWNIKv9tSRl8myi0vd8SyNEne9EroL1ITDUksrUcJETocG7N9PZjtpAntlLOqLVdgmOMahD9jk+LGaNVVm++j0rNUCEKHP69ur8UeAfm8N4t1akZ3MX/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750147642; c=relaxed/simple;
	bh=qPO4Qo82YyZNZnYOkDm83QAg+7i8begiT7RH0I9P4/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o90/h+tPiN+iLgJ2XqefR5M9LRmA6Z2e9iRW+MG9G66PmrUkeFGZ3yX7SZeWL280prg94wiL9NGdbmHjrmg3xdjBtYFbbb75oZB35J8wy5u88SlX83DV+Qg53YxaPS8lcOvtfC6wWnQVlKWLTN1XANsZFQVDHzjUbe7d1a8tEEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=tl+s5vpS; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-234d366e5f2so70344745ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 01:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1750147639; x=1750752439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+LlqUUmqnaep7SBndHC7jrUhJnJIaMSK9j5M0uKtqY=;
        b=tl+s5vpSarRYa87YaqhDk7THUA9uDAZtlyFrnbJSNvpOXifFKAMULkqaEcimrhkVqo
         Q8RzXw663PCaxek47fK9cfqvvpTcLAPWAoaoFgQNmCTlapZVq1i2390z9+1k1XZ0HLqt
         WUY1jwVir153QGwBWiwVMTMahKW4RwDmeG4V/yuVxfZk3HeNlBEtUfN9Q0pFa/gFQBNj
         dMmkngHnvEYfhxCpgVlZPP2IENBpsRE6WMSTFInACqSy8vU2EG7RxpfTnZ953RkAIUo7
         UIegiAgzCIvEqyciHoBhfEsaSvPp82IYkXoskQ0PsoLVQRVhEynrDkO+i93WRXta+kI9
         8VYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750147639; x=1750752439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+LlqUUmqnaep7SBndHC7jrUhJnJIaMSK9j5M0uKtqY=;
        b=hbG683iPcD104G7RbU3XDladpOezY9WfEv1RKengQX3SiPAUXeQPlMe0eoV7rfo0Ot
         UKaT2gOi4iBH/+ZjDJU1AxuaTVifrnAB7AuoNbQCFbxWpvIDe74EBzlAT9Y5VNA/B+oB
         50nrC7oikhNl0VXWTyyI6uXYO7oGnfgOHnhbgn5PEN7/XfyrkpbN9wsbRYVOW2yEIt1c
         8LYE2rDz/WAyXnYSBYWfqzQ/bJX8INri3TEkLeb89Amqltk278atf2D54L5EE0UPHuMp
         ktrBuZc7jw9445sOqqmO4U1SXgWC+/C08owRzzSOfNyCLVjrhkf13EW5N/gPVFU773lK
         7raQ==
X-Gm-Message-State: AOJu0YyhNjY7QHWFq8sRhF6yMWW+pIQbuYt2PQIMrtkiAmJDys4SH3Eq
	pfabJIG0EBu74KtBRIQtQJiGsZBISpiq7Nbr/U8QzYXSym12S5x+vDLazqdl3wNh7kE=
X-Gm-Gg: ASbGncsMmOUI2Fr7JUvMyGQZ1536iSv/g80JktkV+mwqpXSUstd7Cnri+KzmGHcJa10
	AxTIcrOH3l+FwKzayYTnAZEpPgojAfSQnBYO0RC/5vpBFIAsk1scKOQYaDUdEYgJIlc9o+1BZ00
	0pQeiQOIojaqTiSQNeqPQJxorrLuljqQ83iQRWggHrOMr5NGWH24ZVSbJXgBy+qz6eYWYvcdQDJ
	0i+mM+bgh9lkmpnkoIRZskORoidXU8flAbK/VhozpWOcCpwqmIE00JQFcT/pN/amhA6jguGCIlz
	TDzh+pDTbJMyR46Dsj4ttrc3wg7YVfiFwfSr5MvHjI4GG8ACWCBPRn/mlR4rvf/k3UwDoar6Iu7
	pn317c5isLAaWiuHHuf/0Tz+8q+LQVnUIq5g=
X-Google-Smtp-Source: AGHT+IE8aGKhKlST42k4DaBwcbuCivggwz4giXaOn8YfeH8q+O01BbB5bnpjg03RCyOLviA8G5V1LA==
X-Received: by 2002:a17:903:32c9:b0:235:a9b:21e7 with SMTP id d9443c01a7336-2366b3df793mr173492495ad.48.1750147639664;
        Tue, 17 Jun 2025 01:07:19 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31413d2c8fbsm3579365a91.10.2025.06.17.01.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 01:07:19 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [PATCH wireless-next 3/4] wifi: mac80211: add support for storing station S1G capabilities
Date: Tue, 17 Jun 2025 18:06:09 +1000
Message-ID: <20250617080610.756048-4-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250617080610.756048-1-lachlan.hodges@morsemicro.com>
References: <20250617080610.756048-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a station configuration is updated, update the stations
S1G capabilities.

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 net/mac80211/cfg.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index d9d88f2f2831..bfa7e9f29d96 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1878,6 +1878,7 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 		       params->vht_capa ||
 		       params->he_capa ||
 		       params->eht_capa ||
+		       params->s1g_capa ||
 		       params->opmode_notif_used;
 
 	switch (mode) {
@@ -1956,6 +1957,10 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 						    params->eht_capa_len,
 						    link_sta);
 
+	if (params->s1g_capa)
+		ieee80211_s1g_cap_to_sta_s1g_cap(sdata, params->s1g_capa,
+						 link_sta);
+
 	ieee80211_sta_init_nss(link_sta);
 
 	if (params->opmode_notif_used) {
-- 
2.43.0


