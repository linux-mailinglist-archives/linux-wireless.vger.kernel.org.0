Return-Path: <linux-wireless+bounces-30542-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D39EDD0315B
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 14:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AA5430A88BD
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 13:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE804ADD99;
	Thu,  8 Jan 2026 11:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="081T7U+b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86944ADD97
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 11:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767870660; cv=none; b=FbOQg+Jv2MdBeJpLOKvM51KPcA3OHNI7cHMvroW2D4CAYx8zL/y6XMPhrVvd862NjPxZhZ2rRBEJYL9ONk4bbAhsKJVDtKnnfuYzedv2FneEf9g1qt1ZQIh4FD8QUlZsA5JZHaISpU8kBL/uTzjmO+oUnFiNK3lxKDzfneUxsi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767870660; c=relaxed/simple;
	bh=gLupk7pkyhMRyVZ4jAeXCwK9ZKuelYKRs+8X67Kj6XU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XxCPQph2CtAwaM4/Gx0NPzyccZmA/vhNGr8B9dJp3PnMeEDbBzEb4tMTWs5gX3a9o5EtTvHPvEOS7H8npUie605rQAF0kLTN4+7UFVcvpE5PbWUn37pdRWvdtCFVXWI1UMNH8PQO4CMUalEE/F0l1QaxdT20li/bdrHmIXaCBuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=081T7U+b; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-88a32bd53cdso55964626d6.0
        for <linux-wireless@vger.kernel.org>; Thu, 08 Jan 2026 03:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767870641; x=1768475441; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6ekxs297qQPFSvF26tF3NNktqGOevw+/kYcudT3GgYk=;
        b=081T7U+bgdqRayuOtYdJ2DrYnnP0pIoDiHYtm0YvsXaWbZ0UbXcGQS3tCC8zkgLkpj
         RjqF6U6xIHMVPzU6nmnHLAGOiSvqafIpJY7/xwH2oS1ch/X7Dv8qYLg7bG/XRBew4nq7
         dQRu5vFrmzSQidUaVB2XQwZfW0/3kuGzULfV/lDxUF5JNrPUIJdW83+f3sJusQvPtrdU
         I4uKw1zc9wO+0W0dQ4CLzhsPYcD61I0OyUAVcC64S2kTuL/xI3F2TtC/7RVUzuaGaVUq
         3+zFwBq+Mn8BIa+OjvpIZXpECnkv7MlB0bv/nQCk59eha6rQ2m65YQqaXwIId+RBrHre
         zRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767870641; x=1768475441;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ekxs297qQPFSvF26tF3NNktqGOevw+/kYcudT3GgYk=;
        b=o4Cbh7zZ2eLJh1BrQ5oInER/sSilRtsAZgjFTPkpEDF4slPZ83nPDSX7geQROzoU1C
         OC3ByrE9Tj77WZydGgpeJe7erFUS43N1Y2QPGXGhpTZzrqqMT36fXI/jcUyakyi/KUWO
         V/yqt2//KPP0e5R+P3Oz9wQrP0DDOvZKn5/6TtrLnjwQWkTi3ODLZ0iywg3HrtMFcEp7
         QGDD4VSawIw/uWYff0kTLK4/D9M2bfpF9gjouD4h7TsHh4lVs+6qa14ZdnmWF2SeTNLF
         hnssk/yBXjOIB79+iTMCjijgU+LRB3G0PgpRy3dUd+MrOfhMgImxdmPvOR8pvjXFRU/B
         921A==
X-Gm-Message-State: AOJu0Yzfg1sTkTv2xDgkNG/4KFexq2HM46nWWIRJJq24JxwMo0HsBW7X
	/Jl9KlcBTXhIpiGpa9cCJBXUHwm6Rfblllcwc0m3ERPLQqCvuWT0GwLIVPsYLg6bjSxkVCA0ftW
	dMBSYwwQrMC8raw==
X-Google-Smtp-Source: AGHT+IEkRfWC/XeNlNnBAN+U28DwGlu/TP1KYx3zvViGsFM2019wehNzF7LuZKIttyiMh+1R4x5jip1jwcuKcA==
X-Received: from qkau19-n1.prod.google.com ([2002:a05:620a:a1d3:10b0:8b9:f221:4cbd])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:46ac:b0:8b2:6443:8401 with SMTP id af79cd13be357-8c38941924emr683726885a.76.1767867575563;
 Thu, 08 Jan 2026 02:19:35 -0800 (PST)
Date: Thu,  8 Jan 2026 10:19:27 +0000
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260108101927.857582-1-edumazet@google.com>
Subject: [PATCH net] wifi: avoid kernel-infoleak from struct iw_point
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	syzbot+bfc7323743ca6dbcc3d3@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

struct iw_point has a 32bit hole on 64bit arches.

struct iw_point {
  void __user   *pointer;       /* Pointer to the data  (in user space) */
  __u16         length;         /* number of fields or size in bytes */
  __u16         flags;          /* Optional params */
};

Make sure to zero the structure to avoid dislosing 32bits of kernel data
to user space.

Fixes: 87de87d5e47f ("wext: Dispatch and handle compat ioctls entirely in net/wireless/wext.c")
Reported-by: syzbot+bfc7323743ca6dbcc3d3@syzkaller.appspotmail.com
https://lore.kernel.org/netdev/695f83f3.050a0220.1c677c.0392.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: stable@vger.kernel.org
---
 net/wireless/wext-core.c | 4 ++++
 net/wireless/wext-priv.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/net/wireless/wext-core.c b/net/wireless/wext-core.c
index c32a7c6903d53686bc5b51652a7c0574e7085659..7b8e94214b07224ffda4852d9e8a471a5fb18637 100644
--- a/net/wireless/wext-core.c
+++ b/net/wireless/wext-core.c
@@ -1101,6 +1101,10 @@ static int compat_standard_call(struct net_device	*dev,
 		return ioctl_standard_call(dev, iwr, cmd, info, handler);
 
 	iwp_compat = (struct compat_iw_point *) &iwr->u.data;
+
+	/* struct iw_point has a 32bit hole on 64bit arches. */
+	memset(&iwp, 0, sizeof(iwp));
+
 	iwp.pointer = compat_ptr(iwp_compat->pointer);
 	iwp.length = iwp_compat->length;
 	iwp.flags = iwp_compat->flags;
diff --git a/net/wireless/wext-priv.c b/net/wireless/wext-priv.c
index 674d426a9d24f9aab7657d1e8ecf342e3be87438..37d1147019c2baba3e3792bb98f098294cba00ec 100644
--- a/net/wireless/wext-priv.c
+++ b/net/wireless/wext-priv.c
@@ -228,6 +228,10 @@ int compat_private_call(struct net_device *dev, struct iwreq *iwr,
 		struct iw_point iwp;
 
 		iwp_compat = (struct compat_iw_point *) &iwr->u.data;
+
+		/* struct iw_point has a 32bit hole on 64bit arches. */
+		memset(&iwp, 0, sizeof(iwp));
+
 		iwp.pointer = compat_ptr(iwp_compat->pointer);
 		iwp.length = iwp_compat->length;
 		iwp.flags = iwp_compat->flags;
-- 
2.52.0.351.gbe84eed79e-goog


