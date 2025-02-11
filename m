Return-Path: <linux-wireless+bounces-18761-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E2DA30B04
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 13:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC37B18856E2
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 12:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D521FC7D8;
	Tue, 11 Feb 2025 12:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuCy/ZIu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3B61FDE3B;
	Tue, 11 Feb 2025 12:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739275308; cv=none; b=HnBGT+CRC6u3U4ieQC7rfIR5v64F3ROq5ogciyn4K9/bcnNoYNGB2Nf0hMluXpNDKLoHodo+ZNUZoxDR1SnrngmUHj7000DXHWU89XxUn1JQ02OARbJWBZyrprvT/ZniHRxdj3I08ngd+Q95jOXEiu/Slby209EhqA9exF2ba5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739275308; c=relaxed/simple;
	bh=1sXRpKRdwQWU3PDhHFw9zXhzGGi7++rZDL+a2/5+euE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BW+pVcTUf+tILv3foN+gAkf9q9aufPG4oFVUMMcwBPGjnnUmYQhzchgnij9R8qGO7HhEOweCIdgg3ei7Z571NurekzLT8JylGoJCzpjQ+O5B20avj1F9gTC3T9hNCTPN94t82sTO/k2ANvHcR2UGMjM26gTUm7MQGl29zn97X8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QuCy/ZIu; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43932b9b09aso31877245e9.3;
        Tue, 11 Feb 2025 04:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739275303; x=1739880103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRuritwii5Exw4qc/zxuGeTLgpqDh2QQL5NTFCoOB4M=;
        b=QuCy/ZIuemjpuK0E2p25n+LD7ND0x7IUmMUNuGSZxbTAVvIKtAh8aY3LY1JDsYalcG
         za1T9yhygMpD/W21jDjhTyWCToJJNbiT+fsrKRAmkrsbApNE8Ly7A3/xKaxiB0hBXNiu
         AGHwaOpE2rJ0S4ZunUi3Wg9J/KvU1d5/aVXuvim650kj1IX4SBk9qwp3NxP6sWrORhOk
         L97/jtROi7bStn8/RANAygH9womlztxt0K26WmMZABDONCXY19jamw2PdmjueNff30am
         KWc3SdLJiOGgHvKnwXySQZKLJgQFssTQ28UgRjdbhqEMeaAyFkzSySgijxuHMo9BAdQe
         QkiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739275303; x=1739880103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xRuritwii5Exw4qc/zxuGeTLgpqDh2QQL5NTFCoOB4M=;
        b=u+YFVZXbYHJqsxzm2I7R6UWA9K4opNrWPUqnprg3jHLDU25rQqBBR/mI6bIk8mC9Do
         o/KzudGoJPjEsY5x9xlgOBQQZWc9vkQpQaqJ45AL6a2N9zxgLAs8+Rv/wtV0Z+pF4jSp
         OZxNSEQrwL1W1APva6isCxEZIqzPiXwiR+Z5jvxAoueOGXm6WCC4VOes/XYpX9p6PRgg
         MdKurXoj7295pdzRbV0qOlNzoaXGFNtHaclLdrWpwJCp1iAdJgcV8m8Sw+lWZi19An7o
         wszWTuRb2bkiV63cVfaEEuhUnO3/iM/ByACaZ2IvEscg1ehEiFHJ7SVUdYpCqAf1N0ll
         KTCg==
X-Forwarded-Encrypted: i=1; AJvYcCXAh73F39k+AhXDs2YI2XLr4Vm+Bj8wFqIx8Wkl6JBN9ufRG7EkKSS1xgk5vluhTmlb3zWLmq/N/i5GpbK86Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJgqr3J5h2OcSiuUwaWJI7HCfVSUFlz1+L87rvK2oN3hgxs3Db
	2vm0llDb3GgmwtOZesc7CImGmTDYyUSMWgR83/kQ0DwMd2lb2lpuvzxkmw==
X-Gm-Gg: ASbGncs8KrsPb4u++2pXNisEhC4dT0L9aUQZ03063pT+KiYb+QlfR0IhB9w1244RIDu
	DEbVj5io4yimnRDQ5xu4lsc72tGpPTefruS83J42AIYVHx4uBC7Y8wJ2NHliXzveCFhw6dXX7gH
	8pJBEuYXQVWrCfeIIRymuNhE7nsweQU3SaG17ho+u3xuYlJLqKKez46bWep0JnoYPfz/aMMKaTP
	arKpn4vQQ+JmzIc99/OLw3iOUJO9lfPKbNruXYp1FzJQ9R0aXlVkGVA8ol8XOoqHOwvlqYSWtEo
	FharWy/lDu6iVUq9r2W8E8N+IxqxcPiymQ==
X-Google-Smtp-Source: AGHT+IFH1+wcinOe+AK4yhfhykoikJm3E5IhoPWLH5ipxJg2h/X8+O8J3+RAvwpNj/qdYlBpqgS5Ng==
X-Received: by 2002:a5d:47a9:0:b0:38d:d9e4:9ba0 with SMTP id ffacd0b85a97d-38dd9e49cccmr8900314f8f.25.1739275303239;
        Tue, 11 Feb 2025 04:01:43 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:ac07:4372:f96c:546e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dc933ff9fsm12466658f8f.96.2025.02.11.04.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 04:01:42 -0800 (PST)
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
Subject: [PATCH net-next v5 03/10] tools/net/ynl: support rendering C array members to strings
Date: Tue, 11 Feb 2025 12:01:20 +0000
Message-ID: <20250211120127.84858-4-donald.hunter@gmail.com>
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

The nl80211 family encodes the list of supported ciphers as a C array of
u32 values. Add support for translating arrays of scalars into strings
for enum names and display hints.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/lib/ynl.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index b73e07f1f60c..62ce3340796f 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -627,6 +627,11 @@ class YnlFamily(SpecFamily):
             decoded = self._decode_struct(attr.raw, attr_spec.struct_name)
         elif attr_spec.sub_type:
             decoded = attr.as_c_array(attr_spec.sub_type)
+            if 'enum' in attr_spec:
+                decoded = [ self._decode_enum(x, attr_spec) for x in decoded ]
+            elif attr_spec.display_hint:
+                decoded = [ self._formatted_string(x, attr_spec.display_hint)
+                            for x in decoded ]
         else:
             decoded = attr.as_bin()
             if attr_spec.display_hint:
-- 
2.48.1


