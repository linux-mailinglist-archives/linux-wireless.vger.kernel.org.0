Return-Path: <linux-wireless+bounces-15856-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E719E1D13
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 14:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA608283F0D
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 13:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CCD1F4265;
	Tue,  3 Dec 2024 13:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoTcw6yl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19A31F12E7;
	Tue,  3 Dec 2024 13:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733231231; cv=none; b=bVti9jyhxVs1vmNqO/wegTW/zPeT0zbqodTp+3i4cQ46uFH/1bKBd3CAZXV7F41judVMMWCqHlpsbtz1SWjQF0rfP6ryLE8eHCYRYCnLjI3b3GthS3Cadv3fmkm1KDdP0CuwB5adhTa2OkVo/KV4Y+hE4BtOHg5hO5zlF+g9OGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733231231; c=relaxed/simple;
	bh=nb4TcqyFwFrNECk7GrgbMSfs99F2H/Occac10+u1JeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CWaoku22eOmjMa+aqx66A9wrfEWQsNBorMCI6N5r0BbtQ6hteOyjyjflvdnSKB6Kancg0L8ybUxM/ZXuH9uatjTE4Gbs13xwBOqbtecb9LMwo0/XISMgDTEyY5fVkS2BcERQ+miMVQA3SUvetxm7wGlpFmqTN/ajb9fkvrFYJN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MoTcw6yl; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-434a736518eso68085955e9.1;
        Tue, 03 Dec 2024 05:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733231228; x=1733836028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBYNNBlClnEKzYwKe7q3SzjpvqA3u6IY9nr+3g23W18=;
        b=MoTcw6ylJJHAeLLWreDnZDhbGdCMKyL9ccYdLMiWNJ/F45Iu46UA0PGZJOyIGhWGDP
         SMCBKUae114FNP3Fm0N3JH1gEMah6I0lUxlvx94tmh5np3PCK0hoRlJ3h2u9s0ic0TqN
         y2uiOfyE36fWYPKkyXSmxHVIP+5aShJrvR9WfQK8AZTO/xlHDqxE35RYT9Jr5MvNTnKh
         +GJhepZt8oGa+Obz5N5sgy9ftphIbUy97QJpZbTYudQP1bn3j/EIQ4wgRzOr02e4S9iI
         shmsZO6aEQe/C3Ygl99m+QWGO1I4zE1l3uaUciHvTQPqnBREqeSYnBHc9MYhAVfXqIOe
         lr/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733231228; x=1733836028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lBYNNBlClnEKzYwKe7q3SzjpvqA3u6IY9nr+3g23W18=;
        b=dsPZgYTUM+a8xf8c8UG4dP+EYsBKZQihspbWBwxtx0zIZw+ObxD6674Jyl2hIw2gSf
         fX4v4PtVe77vs5/r+t7O1uQA7EpEy0eMWIc/vstDzs0PVhwvW1/udl/SJKS2NS6Cz/d+
         GsSqIENsX+NKE9D/CuyP3Hrqx7HoXjcAsApBTjyBDeGyrETldXIbN5JPGVymue5QSpdZ
         jT/n6yeV2cn37cY2bS5Azpyfmx1kQmOIwOn9+EpcmDDiZeFLT6CfxFovMj3ho2X6/nkQ
         FMrPx/RKvbkIOGZsEq1engr8dAkJ7Z1dfCx9xJlqa5OoWtR1HAYBB9n2NftkInQmfFEc
         9EFw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ7WduWFoy2CpQ/TT/S10UDTx7yGHQzU35n9kduuXG2zseJahjBNHNIev3QexDZOJmRaJXX8CTumxmZ5WQaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXyW7UThmPguT0LEI3ecD7y+i+4Run0jTjzMQnvy1TedlsAzOt
	w9dzeQIMJL+u1VGcZMHJk83f7L9f7gmqxi60D+WZHkKwqMtpOdZ/p4A0eQ==
X-Gm-Gg: ASbGncv3mW5JtuZ/1XFKkc+eiYQVVusaVxUQONqV8eAb6cLUO7/LwZqGiT03WQ4GXI2
	U/XAI1/Xb+SWGhH1ok3wHzlBF326LM0xw4buuWowA0+kpp8gJWt/cgdTkCvtVAy7z6qorFbj3PK
	UVRKcU5HKBkFgeIf/PDODeJM0QWrn6rdmI4ubpXxM+ND2S3EkKQ/IFgS7WlNfGWLQflzBvpkPQA
	D44ShCIZ7CsQIBiTkGHexUD5mgfzR0srkahQE/h9m+s48p4mWYPYLZP59f9JVfCL2o=
X-Google-Smtp-Source: AGHT+IGBpYcYzxJv/oZEOoDXCN6RQrjEPetJyybHrkPFJgd5/RsASHj2WLnzP194S5AJLiVt8KM1kw==
X-Received: by 2002:a05:600c:6b71:b0:432:d735:cc71 with SMTP id 5b1f17b1804b1-434d0a0e3c4mr21544235e9.25.1733231227834;
        Tue, 03 Dec 2024 05:07:07 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:6140:2ef3:aaa:55ca])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e4d42sm219142365e9.37.2024.12.03.05.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 05:07:07 -0800 (PST)
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
Subject: [PATCH net-next v1 5/7] netlink: specs: support nested structs in genetlink legacy
Date: Tue,  3 Dec 2024 13:06:53 +0000
Message-ID: <20241203130655.45293-6-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241203130655.45293-1-donald.hunter@gmail.com>
References: <20241203130655.45293-1-donald.hunter@gmail.com>
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
---
 Documentation/netlink/genetlink-legacy.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index 8db0e22fa72c..f8be52e7793b 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -148,6 +148,9 @@ properties:
                   the right formatting mechanism when displaying values of this
                   type.
                 enum: [ hex, mac, fddi, ipv4, ipv6, uuid ]
+              struct:
+                description: Name of the nested struct type.
+                type: string
         # End genetlink-legacy
 
   attribute-sets:
-- 
2.47.1


