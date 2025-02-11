Return-Path: <linux-wireless+bounces-18767-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBBAA30B0D
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 13:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CF661887E91
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 12:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85F32206A6;
	Tue, 11 Feb 2025 12:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4zDk/jr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C91521D5A7;
	Tue, 11 Feb 2025 12:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739275313; cv=none; b=dKlH3Gxi4BjTRi09bOAf7t4HQ+telfBFL7Ga3qs9BICmCUuJ2XZMzX9rtFkkHgY91Qtc3mkpnW1iEWd+bDVaEh0+Dca9DDCyiePd7Ab3IKwhsCe6DVB3dUI6BgMYnKfYwugfJFWIX1Ey8Nf3N/tBQNF03XR2uqN0iqCcoP+lGXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739275313; c=relaxed/simple;
	bh=hngH+nkRM+69V8gMEYAXSayqQbNSU/kvsOcQdYK01ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/qKTTyImMiIYDX3Nxpzhe886Njn84BJGzTbSK27ouncREFibcQbS3Zx49C7HMI4PWeT3tq6MX4ks6RRSDUq5pmbTIAvRkXUcseAcsKErvSarUYRN73zMARsQxNC2DiT1dr4PZFQXNhGtRqn+dt63jXyMZp1IYSywQ6kNGCxer8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4zDk/jr; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38dc6d9b292so2292094f8f.2;
        Tue, 11 Feb 2025 04:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739275310; x=1739880110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpSnMf/WKCpk42PUpTTHzELsWuR5f0+/8dWnGZMy7ow=;
        b=B4zDk/jrwUlW8ZyUpy+1kY0qG2nTiZlexVTkXnAPfAriCgs3UQbWsbKPEAKa8kSnRP
         Bqb98YkVQbYtAD78aCK0w2VU701DvuXHHjM+uxkHgFq4REbJmqCy8o31+OgbQcKT1SZs
         bI7ItRTB1hgKuEnvUj7VIEpH0cxF8ycz1G+s0BX1lXxn13O+zl6Sf5zPg0/9kDIj30FP
         0BdSrWkRMIUpa4OqdSdeQS9BBk4rGxTXKFkagxITzLxRhEQoA7baONebi7PCmQEgswii
         d6Iu7JVzrsUiOxnaMkjaLmMx/sOqarS/h4YbZ8NoEuJ01cFWMWDMyVc7bVzcWx1mXYzt
         55bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739275310; x=1739880110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpSnMf/WKCpk42PUpTTHzELsWuR5f0+/8dWnGZMy7ow=;
        b=lPO2EQIUIkFS1spQEVQyk6m1GPCQLX2bhHqucIRDUCo2+aykmpar0Kir3zppNidvov
         4OpZa2DkxSASSmCLAXB4ML89q6O7cxTXCVU+5UdSYjsLdlDWTfJYf+KuxtYwG1SjI5n6
         gOo/kCr/nAEsPM8z4+Q0MfBL8C+ClCAFzYesQHvtjliiKKkRxZUbOqbWMSZWsxB3sRAC
         Z9i1H7biPUfGwTvqmHnag7M6hcx6bVCOCusPSjSVOtf6QpZnFo2NRnswOUz9HcSscYOW
         qAQZ1zeoaFYJH7f2eOuIQISwu1OZ17SgRiQXIue7DQYjtEOKpwNN4zN/AUeQI23J0he9
         XRTA==
X-Forwarded-Encrypted: i=1; AJvYcCUF+40h9iXw+qr6wYCPBnbZ/qlsInnDk6EOMGrR9SIzdNNPjI7B7VQwgJF+qfpPYwb9Py9d3CDmtXrEOitG+A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn/QYHDhIzRbvkFBOZJHZFe3te3AKLDpS1GHDqpJpt+xuwlC70
	NDS1okXymqXEauPfkS7ID4O+2zAbN/4wg6wge8SxesitmN3FsjmAkubXuw==
X-Gm-Gg: ASbGncvXO6w03S4kpJIK3yXMoUq4MmnDCfVMW+bN36aM0U17AQDC8gZdD+gOUHKeobs
	bEzbq2TtVUYcnn6cL1JB4mH84fhkmnyZWoLnMAUxBVLycBJb+U8xhKGe4NGY9qchjCUKHv/08Kv
	HSP3A9ZFl7Ntg1oAl+Xv7lB3PjC7hW3tNaBzkW7QkZb3g5LoFToOYb8G6/vQA77nHT5hkQufwRB
	WW0UZIZwFwk67V8SFiSa/qbA1Dwe0197tbpxzM7lzvLOzbjaRAFBCvzHVKFSRKEF1fkFCo/8chW
	DOpa2UgJAZOYsaijnL7VNXLP3+jFXvtA5A==
X-Google-Smtp-Source: AGHT+IFl7qxo+QvC/sZKDIPHcPXMj4RoHPI+XMMI3LS7mw9RUxqCFTTOF3580dlJbdybp4/K9r4k2Q==
X-Received: by 2002:a5d:59ae:0:b0:38d:d8e0:a9a1 with SMTP id ffacd0b85a97d-38de419486amr2914863f8f.29.1739275309962;
        Tue, 11 Feb 2025 04:01:49 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:ac07:4372:f96c:546e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dc933ff9fsm12466658f8f.96.2025.02.11.04.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 04:01:49 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v5 09/10] netlink: specs: add s8, s16 to genetlink schemas
Date: Tue, 11 Feb 2025 12:01:26 +0000
Message-ID: <20250211120127.84858-10-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250211120127.84858-1-donald.hunter@gmail.com>
References: <20250211120127.84858-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add s8 and s16 types to the genetlink schemas to align scalar types
across all schemas.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/genetlink-c.yaml      | 2 +-
 Documentation/netlink/genetlink-legacy.yaml | 2 +-
 Documentation/netlink/genetlink.yaml        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
index 44f2226160ca..96fa1f1522ed 100644
--- a/Documentation/netlink/genetlink-c.yaml
+++ b/Documentation/netlink/genetlink-c.yaml
@@ -161,7 +161,7 @@ properties:
                 type: string
               type: &attr-type
                 enum: [ unused, pad, flag, binary,
-                        uint, sint, u8, u16, u32, u64, s32, s64,
+                        uint, sint, u8, u16, u32, u64, s8, s16, s32, s64,
                         string, nest, indexed-array, nest-type-value ]
               doc:
                 description: Documentation of the attribute.
diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index c02ed8089746..a8c5b521937d 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -207,7 +207,7 @@ properties:
               type: &attr-type
                 description: The netlink attribute type
                 enum: [ unused, pad, flag, binary, bitfield32,
-                        uint, sint, u8, u16, u32, u64, s32, s64,
+                        uint, sint, u8, u16, u32, u64, s8, s16, s32, s64,
                         string, nest, indexed-array, nest-type-value ]
               doc:
                 description: Documentation of the attribute.
diff --git a/Documentation/netlink/genetlink.yaml b/Documentation/netlink/genetlink.yaml
index e43e50dba2e4..40efbbad76ab 100644
--- a/Documentation/netlink/genetlink.yaml
+++ b/Documentation/netlink/genetlink.yaml
@@ -124,7 +124,7 @@ properties:
                 type: string
               type: &attr-type
                 enum: [ unused, pad, flag, binary,
-                        uint, sint, u8, u16, u32, u64, s32, s64,
+                        uint, sint, u8, u16, u32, u64, s8, s16, s32, s64,
                         string, nest, indexed-array, nest-type-value ]
               doc:
                 description: Documentation of the attribute.
-- 
2.48.1


