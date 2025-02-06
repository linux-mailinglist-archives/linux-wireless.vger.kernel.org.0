Return-Path: <linux-wireless+bounces-18582-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1445AA2A449
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 10:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA83C3A7C40
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 09:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C657226884;
	Thu,  6 Feb 2025 09:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPkOFREi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C485F22655A;
	Thu,  6 Feb 2025 09:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738834042; cv=none; b=K+kGqwnp+U+SGAKijSFdAIDq4hoDrikKhlJEKP6EWB1IWV6jeWpP15hESFM8ThxwwmWdCYKgewFoq3FCcd39uUhweHPqkI+B8vJkI8JZeB1QCx+7u/W+cjFeQj6wHjEWsFk+JFt0JzBzsCjRSo3Q4Uz5cu0h8ZwnkKk8Yxd9I8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738834042; c=relaxed/simple;
	bh=uAA0SrBIEat8KHomEGBPPHi6DFugJWWC167a7gJeS1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H5YBDL7dGj+Drp/BaFfpuWbdYGCZBnheAl5tdxm48CJ7/ZE4AjtdNU8BDE+2RoVmVVrOgK51mU5UTi8RwXSEml3tsO2Qmx9a7CG7CPE4U0nUwNaX4uISkf6E+DlsHr1qXqOCJRpFakIXRmwo12Ac8QFzU9Z4cswY53B+OIjC6zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPkOFREi; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43618283d48so4304865e9.1;
        Thu, 06 Feb 2025 01:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738834038; x=1739438838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xw9XalKM7KcIW2N2jDDGMQtPiQlecJSRq7lkkgga6Wc=;
        b=ZPkOFREiAIlMWQs7p6HLtC1OxymTeUf3neY6JiRf9jicc1jAZ18ul3/EqRn2H9HPkm
         b3PXK74+0r1N+uInMbVulp+sgI0tfc/zQobjGiucUyD+xgSDB6VnGe8PAayxNtjQmJeQ
         Qmf0rHrXMRXH7tn+WPhZrAUbkNG1lTYgjeI6C7QHKJ5bUmsXl0tYkvKdV7RADbI3BwwI
         fKr/FAJqVYtCgRs3kOib+axptEQAYYVMX2Mzy9D5AeNKUMNIwYoR/vOg6Q8l1/zAhDeO
         LUI1RkWyWJ6f4ETtasmL7OSgjiLLsW9LH0AzX1I8MNtY0DQULMSyuDj1uux6f7VrHyZn
         4XSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738834038; x=1739438838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xw9XalKM7KcIW2N2jDDGMQtPiQlecJSRq7lkkgga6Wc=;
        b=b1veh06ibClXMm0ygEQKnxjj1Vq/eEg/vsuPmLwk8z/VUaj8PKlfafTL8Sxmh4B1sm
         +MCUCJzyE3y94ClBl5lbSnTkha1ft1kEBdQkr86M3ryJrwjyGP4tp6nXfcH4NMgUR4yT
         3WLZnFJrg8oL4dtIcF7Jwl14jHtI6tZVQRDaAv52KQ9LmU1khT01tY60GSqfGQcFktI9
         yKwb11s2wUrJn7OsLdTFahiIShhhsrbaftUOVBsdk+OixUfgK10JpeQ8jTlNkPKivLpo
         zMx2UwtGCf3PzePJpSZnIgNnYArBvH+oy+Ifh96nA88ypgZLfqqXlZg7QAf0YlOPCCx5
         KVpg==
X-Forwarded-Encrypted: i=1; AJvYcCXd8pq+/+JnvHVstHuSeZuBO1G0E0Tm2YVvTLAhUpGjJz9nkkFpKbfonxwITp+jty8u+BwMIRIhujp5j21rfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2VA9mhQXlJ64N7lYU/s/1iVNABus2qaZFqrl08ee11waTtsES
	TnLXmIs7VuuN7nE8FnmwFB5ueB06w2ImYk+BsKzLFOmeSzigh6efIH+LwA==
X-Gm-Gg: ASbGncuYkZRGqo2RZaUe6JOmKGKg7VCRFD1dT4cI7ymbLtmY9j/hDQjf+dNjDKizI80
	cdU0VD/VMoaylziMsJ2VHhtXRjlWvclYybYFwomhHXy3HcvDSnzkIdfIHjwthXBeIQxa/vM/3ne
	glGHgxV6Jz4bqvh/+5bbJAI7FHKw084WAKM0ojnfOSUuTlo9B24Th0mA+/9Df5Z0T621ZTtIiG9
	V2a13PzBPS84Wv2uZK1kru8hbHjkMyh6IlY0VtgcMbPFEZtdOOMHHj+dS3ubPggM2r7+qS8wrvg
	jKGgedUWtFyREIaMDfoPjkE1Cr+yDyaT2w==
X-Google-Smtp-Source: AGHT+IFsKWzmuGPREshk9x0xR8ujPED2HwsoSVLrOJMPwtUEytMYjnGepRB3adMb2KBden9DXQhgRA==
X-Received: by 2002:a05:600c:5252:b0:434:a711:ace4 with SMTP id 5b1f17b1804b1-4390d43dc2amr45777375e9.17.1738834038431;
        Thu, 06 Feb 2025 01:27:18 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:c428:5404:970c:34c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dca004esm12832585e9.13.2025.02.06.01.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 01:27:17 -0800 (PST)
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
Subject: [PATCH net-next v3 05/10] tools/net/ynl: add s8, s16 to valid scalars in ynl-gen-c
Date: Thu,  6 Feb 2025 09:26:53 +0000
Message-ID: <20250206092658.1383-6-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206092658.1383-1-donald.hunter@gmail.com>
References: <20250206092658.1383-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing s8 and s16 scalar types to the list of recognised
scalars in ynl-gen-c.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index c2eabc90dce8..803d49bf7c33 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -1437,7 +1437,7 @@ class CodeWriter:
         self._ifdef_block = config_option
 
 
-scalars = {'u8', 'u16', 'u32', 'u64', 's32', 's64', 'uint', 'sint'}
+scalars = {'u8', 'u16', 'u32', 'u64', 's8', 's16', 's32', 's64', 'uint', 'sint'}
 
 direction_to_suffix = {
     'reply': '_rsp',
-- 
2.48.1


