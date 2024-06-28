Return-Path: <linux-wireless+bounces-9700-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDE291C919
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Jun 2024 00:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D13731F229C8
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2024 22:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5870F770FD;
	Fri, 28 Jun 2024 22:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcvWo+7F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050181C20
	for <linux-wireless@vger.kernel.org>; Fri, 28 Jun 2024 22:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719613961; cv=none; b=SapvubnYWchioMagpJGgnUTnSsS/JWTIMsICddX/ic5vWaqDQF39UtzkS4DsPA6g86YhzIZdefHMsH57e17CixqJ96cXOdvldowK6eD7DUITSMi+4Z72WVShh0lTJpaN5sxP1tGNUUM47hC3yCg6j90EBKlih2h5/emx2lnNY+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719613961; c=relaxed/simple;
	bh=PoZZIfz65dA8PdCWWQMcK/7eiJpLCwqGV2o+haFWwWg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=JbkbBM2TiR/gwZG1VJcW2gAAj2K3Lx2uW1w+tZgDN8+te7KWYk0p2+cbZJSay4aFngmp+UEiX6YUicFDciWP+FLmxnd0VV8YMOBQZbdEqOeWloSPVGMep7ghG2HQHLS2FzzTS/Vw5wrOIS5+sft9P86ZcvUmUJMnTTHpbzYtbAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcvWo+7F; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7066f68e22cso904378b3a.2
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jun 2024 15:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719613959; x=1720218759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pcB1pNo1IbGcYmNDtAcjXDo0YwR9JsWFvwvtD93iEqs=;
        b=FcvWo+7FNzupxklqIJBfJkeln33Y9fvdR+a3DkjImVDm1SvXzcZiY7exIBBxlhbNuj
         hQb4QzRvI/J8liecjOTsrja77pe693zPouda4Yb6EojoAmozZNU9fFsDENMoNiiUz9ry
         stxKfhb4LRaYV3O+SLCuEZeNXTwm0DWpmyFyqzTlnLdOL06xn8aYqvacXVt/tDZ2JppZ
         NkmF7U4/MkOfnFimEWubPjJkHdta8n6ZGRqNqkazaK6vbbkJ7tdzddud258ZXpPSst2+
         5kdlj3bevGDkytlOKmP/0vbSVucN03V18ZGglQSt4kMXS8rCBlI6M4rUSPmiChAtt6XE
         Dpig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719613959; x=1720218759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pcB1pNo1IbGcYmNDtAcjXDo0YwR9JsWFvwvtD93iEqs=;
        b=s3LAmHSUNAtEgQZ2VPN/Y/ZODi6f9Byj6RtOO7Ts1skzWfmf9rnEY/fr317FJkNse9
         XpHgTm1g8frTb0BGebkq8ah5YBg0hprhVzTcWL2qPI8cIBs7kaNXI7zaZte+Ksk+4jrn
         luf5Kqs6ZVJ1vnCvvueeLuyGdDLL5M5Ydj8AhYKseAzsdvBBAOuC/mxjzrObvazOHX1A
         zQE+YDuu7y2tKYknvTan+gTDShYzwSS3O1cPIGFl9+YuCR8Pm3DaNJSQ6JQGM0aDUQPz
         1wfRQ0eb39ZbHPggyW5YZYg+9gClo+hdh1ob/Lk9yts/qo2t95goFfrAyoscasegltUl
         w0Yg==
X-Gm-Message-State: AOJu0Yy6Y2CDu2wADVjZDpHpMAEkJTBxBNAinBDrikCFEtDRxUWpi/0t
	UMtVX3wadXKCYT1kytaFiZ/xfkh8UqsqSvQ7Sih3nr0D+cSTel+QdfbIWg==
X-Google-Smtp-Source: AGHT+IHjvLwbvPi31TMmRUosGXAd1teWrJoMZ1/mT3XuVJTMxuMdFr8Wg6VghG0UMNj6m9+R5wiXow==
X-Received: by 2002:aa7:85d5:0:b0:706:2b1f:d443 with SMTP id d2e1a72fcca58-706710041bcmr18791969b3a.29.1719613958965;
        Fri, 28 Jun 2024 15:32:38 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6a8deff2sm1476012a12.37.2024.06.28.15.32.38
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 15:32:38 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH] iw: fix formats under MIPS64/PPC
Date: Fri, 28 Jun 2024 15:32:37 -0700
Message-ID: <20240628223237.16222-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__SANE_USERSPACE_TYPES__ needs to be defined to get consistent 64-bit
type defines and to fix -Wformat warnings.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 iw.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/iw.h b/iw.h
index f416d6d..436723f 100644
--- a/iw.h
+++ b/iw.h
@@ -1,6 +1,8 @@
 #ifndef __IW_H
 #define __IW_H
 
+#define __SANE_USERSPACE_TYPES__
+
 #include <stdbool.h>
 #include <netlink/netlink.h>
 #include <netlink/genl/genl.h>
-- 
2.45.2


