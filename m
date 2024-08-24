Return-Path: <linux-wireless+bounces-11881-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 270A695DC86
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Aug 2024 09:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7483B21666
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Aug 2024 07:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52078156673;
	Sat, 24 Aug 2024 07:33:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64659155736;
	Sat, 24 Aug 2024 07:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724484804; cv=none; b=f7LMVWJDsYYCOfbwtHtMSn+K++birDqwOjxrwKNdi64l2vLEGLSVwzWbMNUGWuY7OGCo2oX8N0EFEsUevi8aCaYu0CURZomuSSA60DtmMhp6FDrBnn5oEvafuqsjIRnw041kVMT7eWYTi0j7z2y5Zt7OgbjuQyyLHNjvG/h8sP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724484804; c=relaxed/simple;
	bh=6JzBL7tRSY3xdYZzPOvXqNovzWc8wJRXhUw0LGRPXLQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Li4XOFfbUINiqgPZkKR+3opLt0lK5uzaBqhKNTpxXsFEhVvx0XdYyGd3J+Mygx1ONIiz4VTsxMjm7RZ15WGatlP8JeNcIlJmRWFYV6qoz8xC1JBm64bRFZC2BgAxUhsHf2m8DOHmKGwc8Y5SAPmXsopUQV9oOxO2PfbpS5t7DXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WrTF04xnwz2CnRb;
	Sat, 24 Aug 2024 15:33:08 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id AB74B14013B;
	Sat, 24 Aug 2024 15:33:14 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sat, 24 Aug
 2024 15:33:14 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <johannes@sipsolutions.net>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <allison.henderson@oracle.com>,
	<dsahern@kernel.org>, <pshelar@ovn.org>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
	<rds-devel@oss.oracle.com>, <dccp@vger.kernel.org>, <dev@openvswitch.org>,
	<linux-afs@lists.infradead.org>, <lihongbo22@huawei.com>
Subject: [PATCH net-next 5/8] net/dccp: Use min()/max() to simplify the code
Date: Sat, 24 Aug 2024 15:40:30 +0800
Message-ID: <20240824074033.2134514-6-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240824074033.2134514-1-lihongbo22@huawei.com>
References: <20240824074033.2134514-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Let's use min()/max() to simplify the code and fix the
Coccinelle/coccicheck warning reported by minmax.cocci.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 net/dccp/ackvec.c | 2 +-
 net/dccp/dccp.h   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/dccp/ackvec.c b/net/dccp/ackvec.c
index 1cba001bb4c8..faadd0190107 100644
--- a/net/dccp/ackvec.c
+++ b/net/dccp/ackvec.c
@@ -305,7 +305,7 @@ void dccp_ackvec_clear_state(struct dccp_ackvec *av, const u64 ackno)
 	 * Deal with overlapping Ack Vectors: don't subtract more than the
 	 * number of packets between tail_ackno and ack_ackno.
 	 */
-	eff_runlen = delta < avr->avr_ack_runlen ? delta : avr->avr_ack_runlen;
+	eff_runlen = min(delta, avr->avr_ack_runlen);
 
 	runlen_now = dccp_ackvec_runlen(av->av_buf + avr->avr_ack_ptr);
 	/*
diff --git a/net/dccp/dccp.h b/net/dccp/dccp.h
index 1f748ed1279d..872d17fb85b5 100644
--- a/net/dccp/dccp.h
+++ b/net/dccp/dccp.h
@@ -149,7 +149,7 @@ static inline u64 dccp_loss_count(const u64 s1, const u64 s2, const u64 ndp)
 	WARN_ON(delta < 0);
 	delta -= ndp + 1;
 
-	return delta > 0 ? delta : 0;
+	return max(delta, 0);
 }
 
 /**
-- 
2.34.1


