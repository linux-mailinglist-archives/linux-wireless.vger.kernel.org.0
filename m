Return-Path: <linux-wireless+bounces-23837-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D49AD1746
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 05:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8736F3AA032
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 03:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAAC24678E;
	Mon,  9 Jun 2025 03:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZtWofSN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7354D3F9C5;
	Mon,  9 Jun 2025 03:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749438539; cv=none; b=gmr8+DhNaCLE0VtbMI/XdkkA+YZDHdIJceTsw+PYL+EE8PZ4M7LQ9a37sXjmneifxtaDdudgn8GRVNr3cKiYBE3yC9pquWfOG/Y5jOf3FOsfWY/V4oxZbBkI8TPuBSiQS7srnl0Ay7AcZE0tQcgtgmKy2g4GVDxk3xlECSEp7Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749438539; c=relaxed/simple;
	bh=oXQXxjTALOTFjWdlxtu05VxJFQTkZYKZbJDwGuMYCcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJhN+1PwXhACPddpvWg1PaHzvQ/fRzCfYoKZCnpuFR8k8A0v7j6bSsIK3vtdTD2f/lCXBmbCOiQxFuNcMgelQ8JZh6XPiQfTHqMct9o7OL2ap9UeP/iw8Kw0IJWVhvGUbIQ61u18MbH3CJASrsd7sIFO0AdrZVa/t2JBMT/vpxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZtWofSN; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b271f3ae786so2535440a12.3;
        Sun, 08 Jun 2025 20:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749438537; x=1750043337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOWE1y1rQxLOG5GOa/59yxesoVBg3D6FcRe1q8J8DYs=;
        b=VZtWofSNmjz6LylhL657Y2u5giYc1MaNffer+fznQIjLDEgOCCNeo/adCdL5qJBJTn
         ihFUXQ4YdUdtzlzxVizJc/2JR1hhLsYt4y1ilXf5DcHBSBO/ayKEd+FIbwgNK9ljaroW
         m7+MgBVUOcGoCzob0efrEQXuZD0kOSxSmefHtoSnquSX+AY4A2DG+thIqUCSCeN9AW61
         7A0WCSFQBB1LB6aDsiN/KIBt98Vu1tS+Xj4o9cOS/QJBoW7HX7ALwDClbcqH4ot7rwCh
         2tlP7sSLBMSn4lEDUBH1zbOgEgY5anp9HEochQGdnSfTl7Dz0A92Ykz6TZAcJQUhzOyR
         DgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749438537; x=1750043337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sOWE1y1rQxLOG5GOa/59yxesoVBg3D6FcRe1q8J8DYs=;
        b=sZU68d9SLHPMQbf/SeypUH9QvM4byTOeQz2diHRfULXDTCqF2h2u7FLC7lfFXspXaA
         lqDS3a/HrlIvVXkJ2XERfzidcp5lVxHAGjuZ6oM5ii8Qq1orW6DA6ZvWWu3k6kx+stPO
         vyioIDZ+C6VQWtK7gWbLB3I/N5gJDZ7SVUJxATT8sJBzj5mT6eDjeGasCEeBweA0N3E+
         Gel7L9Jb39kZVzTDlp2Rb9uaaxQk9wOtGUvT4pbeM609Av3dSbEbu6anCRXuXNcqRv07
         eYoRnS6T7tYe9sgiFCGA8Av286uYaTcFn+F+Ut2Cll5+tDtfPfQqzSDOIxNToKb4uLkl
         9XkQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1/fuJLgonQESLi5P4Qzj9VNvAXfvIC5T9byyrTGTQxFvQdzdY8PYucP6+0OoCTUtoOuTU36hPizym@vger.kernel.org, AJvYcCVpr+XcNPObyRvRuiKbyYQ2mbn+P0ZDClHezn9mAdiUPO5OVL3AgN5ooOFy8yFcaZEeIDy75Er8Hodnjg==@vger.kernel.org, AJvYcCWjpWicQhHkfGmQvOOhGt5blEX5pewfd4fJdz3wRvnsA20vStwBbt+FC+T5AkjKVIj/Pizp0bl+bonkCw57@vger.kernel.org
X-Gm-Message-State: AOJu0Yx54uqy85PJVGzChlUb3ANsIAAdrdPjy4Igb4h+smmicGX5PU6N
	EJNqdc6PkQpTHuYwp977eKvz91HYDYMVVWBdFPWIsKKmlE8nA69Cf2OPcHSteg==
X-Gm-Gg: ASbGnctIrvXIqvlzMAifAqvwxwGsnn2CAw7y8Bph2/GMTXsavsmDQZi9bbL+iUq5jeS
	5Lv8mgRa4ychrWys0YXTNkNCVs1YqzPU57tBo1tqRgJYLoe55MV96Y77fLanwHvYcdNOtfGqNT2
	w6ReXpbeoX/WdWmarHRAbQwuk0g0IiciYCVJtAapCUmDpmPDdHkfAsdigk7mmThhWNi3yM3e2yI
	jI9TBVa8MVtynaIpvloY0E4MlJmufNqsoCJTZCntAIRuPbG/i1XYVpI4TOZThksvj9tRYPe2x/u
	HGjwEpc+PtCVP77UgBIXF3oGUCA=
X-Google-Smtp-Source: AGHT+IELwlhTQkiJOYPGlt3XYlo+IBYZznMvUVcU8lV/PUnsS+PJJbzNp5xQB4aCT7Hc/LTXrKKq0g==
X-Received: by 2002:a17:90b:3c81:b0:2ee:d371:3227 with SMTP id 98e67ed59e1d1-31347409db3mr19820849a91.17.1749438537450;
        Sun, 08 Jun 2025 20:08:57 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236032fccd6sm45310125ad.134.2025.06.08.20.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 20:08:57 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	nbd@nbd.name,
	Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-mips@vger.kernel.org (open list:MIPS)
Subject: [PATCHv5 2/5] wifi: ath9k: ahb: reorder includes
Date: Sun,  8 Jun 2025 20:08:48 -0700
Message-ID: <20250609030851.17739-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609030851.17739-1-rosenp@gmail.com>
References: <20250609030851.17739-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Alphabetic includes are easier to look at and to make further changes to
them.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/wireless/ath/ath9k/ahb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ahb.c b/drivers/net/wireless/ath/ath9k/ahb.c
index d2a97e74f451..1ffec827ed87 100644
--- a/drivers/net/wireless/ath/ath9k/ahb.c
+++ b/drivers/net/wireless/ath/ath9k/ahb.c
@@ -16,10 +16,11 @@
  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
 #include <linux/nl80211.h>
 #include <linux/platform_device.h>
-#include <linux/module.h>
-#include <linux/mod_devicetable.h>
+
 #include "ath9k.h"
 
 static const struct platform_device_id ath9k_platform_id_table[] = {
-- 
2.49.0


