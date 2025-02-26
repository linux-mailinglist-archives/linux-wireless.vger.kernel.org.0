Return-Path: <linux-wireless+bounces-19455-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE022A45379
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 03:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE820177426
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 02:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E229A21C9F9;
	Wed, 26 Feb 2025 02:57:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6202AE7F;
	Wed, 26 Feb 2025 02:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740538621; cv=none; b=q1y2AIu914H4IQCAZU8s4/aQel0LYHW0aWnwfobw08haHpWyVYKDYljyaj6wXAVgzEGGVealof/hycqTMc6BtVrvrljbmIPrmcXMComrLXuiZCsrsUoIj0VPWEFh7isqDKORLTW+jIFF7ZJBTriWqBH6LycS7fHJWJe5iROU/WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740538621; c=relaxed/simple;
	bh=ODSpIx3EESNjHncI8MxY793ZC2PIPsY7Y5SFJDVU/xU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jj7WYz+jiomuu3RvX+TGMkE33db6UenOhM6eAUShXsP76xsM7fwjTtDQbEhKt8QNYQls8xmyjF4xwXq/DZ2th1rghZfxSBg+zZTYwK3NHi0AkNuFpWMyERNbQCE+eN4HbC2/LuFzhKj5vzNpN6G9hu+vLy60RtbO/C9KHPBmaSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7273b0d4409so1547841a34.1;
        Tue, 25 Feb 2025 18:57:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740538619; x=1741143419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4VmNKfDBeT2r+sunfTq9ySMJ9kY9GvZ3/jQtVX3LyqY=;
        b=Dwv8Cqv/2b9ReJB65MFKtAyjncOvrX7JXdQ08TzvgPxB1yddzTYk8LKZK33moEKQ8J
         FzEPAoOpY1n5fRqn1T9rv7BU83nO4z+Cem7S4LfQbtYp6CHrn6nmY92QphAlYyO+qf69
         SOtwmjdWI7tUGV9goEurxmbLKtzIlHNscQJ+KYqIzQvOUikgzMxqyQ5w8/KJ3LI/ROXb
         0qrb9EwX1yNsb+8e14r9rcMA/53C3BBcZ2LKeQnDKVT9zJMxjbGkeZEe5nvnI142sFZy
         B5nNh2PE4MEoPb2z7QNKzm1e5wf/T68umnERAxuKO9lg9z5f+rEX8/lv5ydj/F23mgXQ
         VFaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6Qv4umilE7pT4+Ck0l4z8tUkx7ZQststvzQH6rECBqs1dYE9SUqEV6lxfHU1d/MdTj/3gi/9Z@vger.kernel.org, AJvYcCX52uJSsxT+bFuBOUrKs8T0A7uhSiIb2M/rMPDNK7jIH0Z7tACTMGxWn9iqv3atBgZU6DBjMe5delgEvexLrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVTN3jVARwnLwAW1F0moQJDqsoQrIa1tERN3Gx+ZIG0sOG9jAo
	Ss9ViruQutMFv1Vl6e78pK+tVQ3EoN0S4BV/ni2zZczzAuPSmoCY
X-Gm-Gg: ASbGnctJMvdOcYi2ejyhBrEvM0z2GpKqAu6NBIA6eZL90rZ0H9LN7dGWku1McL2biYy
	PipJYF7Xkbb59QDciMitn0vTpBnu8T1+LdObQ6ul3ejX+RT9SzCrFD8OzCM5VBWFBGkduc06qcW
	b8DrOm/72itPm4ub4PZvi1JF5vo86BNCEuCWFujXpGR7f6Via2AVTjjVdV+YECegnIVKf6vS4Hp
	7IhpYnC18/W18FIuYeL+BfOO1QsNiti1xmDH8EiJBwGwOosYE4udgLpdaqnpyCtA/LVxvwkTDmf
	YPmsQUJHVyzIxAGVro+7DfStsg0ynoP/EeDwuiPjEdM=
X-Google-Smtp-Source: AGHT+IFiUnxL+4G0l2kiQXu6jPoju3mD9QkYVvUkz+KEOIYzU+4oe5AsYRZuU8AunD+nl3yeKCZrdA==
X-Received: by 2002:a05:6830:8d2:b0:727:38a9:c203 with SMTP id 46e09a7af769-7289d197965mr4381520a34.25.1740538619373;
        Tue, 25 Feb 2025 18:56:59 -0800 (PST)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c1113f0135sm676360fac.27.2025.02.25.18.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 18:56:57 -0800 (PST)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org,
	Caleb Jorden <cjorden@gmail.com>
Subject: [PATCH v4 3/6] wifi: mt76: mt7925: fix the wrong simultaneous cap for MLO
Date: Tue, 25 Feb 2025 18:56:44 -0800
Message-Id: <20250226025647.102904-3-sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250226025647.102904-1-sean.wang@kernel.org>
References: <20250226025647.102904-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

The mt7925 chip is only support a single radio, so the maximum
number of simultaneous should be 0.

Fixes: 86c051f2c418 ("wifi: mt76: mt7925: enabling MLO when the firmware supports it")
Cc: stable@vger.kernel.org
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Tested-by: Caleb Jorden <cjorden@gmail.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v2:
  1) generate the patch based on the latest mt76 tree
  2) update the commit message
v3:
  1) fixed the merge conflict
v4:
  1)  add tested-by tag
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 4f35c2f16d0d..604f771af68e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -256,7 +256,7 @@ int mt7925_init_mlo_caps(struct mt792x_phy *phy)
 
 	ext_capab[0].eml_capabilities = phy->eml_cap;
 	ext_capab[0].mld_capa_and_ops =
-		u16_encode_bits(1, IEEE80211_MLD_CAP_OP_MAX_SIMUL_LINKS);
+		u16_encode_bits(0, IEEE80211_MLD_CAP_OP_MAX_SIMUL_LINKS);
 
 	wiphy->flags |= WIPHY_FLAG_SUPPORTS_MLO;
 	wiphy->iftype_ext_capab = ext_capab;
-- 
2.25.1


