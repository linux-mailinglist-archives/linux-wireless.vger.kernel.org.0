Return-Path: <linux-wireless+bounces-18585-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94352A2A44E
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 10:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CAE13A814B
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 09:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A7B22759B;
	Thu,  6 Feb 2025 09:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OykfYmAE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA6B227572;
	Thu,  6 Feb 2025 09:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738834045; cv=none; b=b57zs7T1MiYZ50Hao3z06cTu+kcfon5uRe+TTNTSsh68u4hlS2XrLGPBYtS1ekCVHFJFfJLEBUPUpSEG5SBi5TEnFvoNLD2DB6EDM0kWAQVf9WsMqp/74lIbMHF6SVfFBUc7CG3xXWg0PbVSGAu9ZLlJqCw8pIsN+wBkkZv2hdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738834045; c=relaxed/simple;
	bh=l0ve3/ZfTrw8KX/paqRD9vxVfJgy5x+8T2goSjjrKvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gcup8rUKs/p4q/WCXZrF4sV++n5qxX+sNCPzQiHpqYVvc09zjfWnc1rD51iNFl5ITLEu4jFt8yWAL8tXNv5W3BS09bI9BJ+SJ/yVCWKaaZHlKY8WmmkDXii6dWA7Glk1NHko/zeLpFuyA3iBiXUCs/lXbozguTUNM6B8cW74HGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OykfYmAE; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-436a03197b2so4009655e9.2;
        Thu, 06 Feb 2025 01:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738834042; x=1739438842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfT6LZq3DFOpoqH60VVDcjGqtGHLOctS6hzPusqkWkg=;
        b=OykfYmAEOegkXqyhlWuWbmpxdNVHkTouE7PfCPJ8UPDMUk+/qkRFpUebHueTW6NpSJ
         dlacnJ8xudcFUIAXd9/oToHDoFOtM7QfFeyUCw6HHXmWUK17BbYXJqOPXOYBZvpqdnvD
         CzMiC2Q0Od9LXob3K8/7TguchCn3dqrQA59I9AyGmx+D38ocrHyeah7SX4jhbB5H7ZEW
         ePQKg6/S4HuWuBEvSwiKeQda1UztlwTp6rEy5yGbkLuIWIcSciropTPs/wXSUalXkf11
         XORjPmAO5nMif2jF6mLhx5aOHfRzVDGIv/ii4hUg2vrfDnubNQDGkg4K2kTxsGf62wEp
         0PFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738834042; x=1739438842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gfT6LZq3DFOpoqH60VVDcjGqtGHLOctS6hzPusqkWkg=;
        b=O2mnd/KdDxIBxdH/WdJQ5toq5FPSsWICOOq5SgcwT5sFrbfuJ6OOTUCUZb1xcYwC3p
         SlWXzsf6T3qvbl80oNVp09IrBIaafCXgqb22L+LhmQOyIA7dVtn5gzBTZujDes/fbXh4
         jBTiKM8nwtt74Jn24VMTo5K9In/2EytYTsqfp95d8R2iDfYz53I0Q88eIHUFD/CIiv+a
         Q3mMzDjssX91z41rgnjfTxigkyqUI/miYoqCgoxqDgyKgQDTufeGF4OsAkZyw49JzAJr
         LGR9Fq/BqlZO0j2/YYrfanJnh/KXGKE/ptRSRl1goO+3NFsq0D0yztPOP/nwyCg2Tepn
         +MhA==
X-Forwarded-Encrypted: i=1; AJvYcCVAFPxAn7FqN3ALRoxNDl1Mca6xTV7ASmZ2p4+laNYaCNf5jm5oGywVLIQjo/HzCOMxzCgb+pXIRdAyC0iHYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyK87gWfwwXNi0Qvr9FeKwObzjMaoOgjD0IkoImAqVtAT6LL3Lf
	8LRhOXHt92MStbU+6nhu4BLJ35IqaWPDH8cHeIVBxXY082rbV3j8NLAy8g==
X-Gm-Gg: ASbGncuhv22TrBThQdHEi2U5hq87wPaAiOMULMebHDs3xozqvinpKRql50ThFUaN41A
	Tv06rprxoXtpHJJmlvZwi4J3mR5xc50v1KSW5aY2l5YJGBd263sihtiTM74QLBs2iK4enXcel8f
	mTXXvlb+GwLUVPlEeCWP8e6ZCgZSNYOBx0dr71z1xOv5IINlgsJ9f7d8Da0Ywlmjx5DNzdsmjlq
	DX+cle9vjYv1+U+8jBC4Wb0cKfmc+EFlUXPEMupEyJ3Cko7EfgH0YLWEQz/hQM38iuRxn3I4TGc
	AOTfYe1yp++xMZY/slXx/5GVboUDcxj/JQ==
X-Google-Smtp-Source: AGHT+IGf0iUgly7IFSJWOfA0j8MMMW/pcIbelEXZkAjg5rzPPCZN6K/B+/0dRALENtHghKD2iqzL8Q==
X-Received: by 2002:a05:600c:3c9b:b0:431:54d9:da57 with SMTP id 5b1f17b1804b1-4390d56f1a6mr54979735e9.30.1738834041951;
        Thu, 06 Feb 2025 01:27:21 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:c428:5404:970c:34c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dca004esm12832585e9.13.2025.02.06.01.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 01:27:21 -0800 (PST)
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
Subject: [PATCH net-next v3 08/10] netlink: specs: support nested structs in genetlink legacy
Date: Thu,  6 Feb 2025 09:26:56 +0000
Message-ID: <20250206092658.1383-9-donald.hunter@gmail.com>
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

Nested structs are already supported in netlink-raw. Add the same
capability to the genetlink legacy schema.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/genetlink-legacy.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index 16380e12cabe..7520f63ec3d2 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -151,6 +151,9 @@ properties:
                   the right formatting mechanism when displaying values of this
                   type.
                 enum: [ hex, mac, fddi, ipv4, ipv6, uuid ]
+              struct:
+                description: Name of the nested struct type.
+                type: string
         # End genetlink-legacy
 
   attribute-sets:
-- 
2.48.1


