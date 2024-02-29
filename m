Return-Path: <linux-wireless+bounces-4242-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C74186C3EC
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 09:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02D8F2843F0
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 08:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C31524BA;
	Thu, 29 Feb 2024 08:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="tKrXytYX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBC850A63
	for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 08:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709196069; cv=none; b=d5kXF1ykBpErVjQ7p09KZ5RWXlfnjPdSeEWtxv6qATJbYBsvLVPgIHgQXHBbwsnISeMCOd3nNRTwnPH9KTO8SXl+JpJ6x/A0j4FPqCIKT07SlfmLX2Aiqw4Ebttr8c8yGYcXNhRjamFNuG/m34ta7my61/ti3QrGY6OrV8Fvgs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709196069; c=relaxed/simple;
	bh=FPC/7D9VUAWtvds0/iDUODpNTYLTF9IwPj1Va/W1jfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sAedkdbiXCtNB+8UEmi47t+E4F0a+YzuyV+hb1roguQ52gmEdbSWy7MMe6zcrzYz2tRF7+vQc7oHeE9w8JvdQMHV/ecoqM5vXFZjoKu7QfbeTY6KZ7Jt7eZYh+g/6pFkw3lYTlEDxzsyl4J2GkoGSMo05esQEM2sPpLfYxLhswo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=tKrXytYX; arc=none smtp.client-ip=178.154.239.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:6e01:0:640:627f:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id 2207E608F4;
	Thu, 29 Feb 2024 11:40:58 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id teVSqmLJiW20-XbXOpn5f;
	Thu, 29 Feb 2024 11:40:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1709196057; bh=Y8PDnHy/+7z0sDz6icCVsb+FrINzU6iAYcCS8mDYRMc=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=tKrXytYXXTgBiriEUfIaIKTE08u7e7f7B2KmMrKNrb2l22syKt0nX433X86cjOBJ7
	 qRQKprR8WWG05Im2GIsSlta7h3Xpzc9b+w6sp00Ky1Tb9BeuV4EXKoEcccEYALBYwl
	 6XL+/J0VWmvLuEPCOSJ+4F+PFjEvIBm3fcFqdbJg=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,
	Kalle Valo <kvalo@kernel.org>,
	ath11k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/3] [v2] wifi: ath11k: handle unknown scan state in ath11k_mac_op_remain_on_channel()
Date: Thu, 29 Feb 2024 11:40:30 +0300
Message-ID: <20240229084031.51957-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240229084031.51957-1-dmantipov@yandex.ru>
References: <788f1df8-64e1-4b3c-ae8e-00c67be1c3de@quicinc.com>
 <20240229084031.51957-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 'ath11k_mac_op_remain_on_channel()', add fallback default to
handle an unknown scan state with -EINVAL. Compile tested only.

Initially found by Linux Verification Center (linuxtesting.org)
with SVACE (and reported as an attempt to use uninitialized
variable).

Suggested-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: prefer fallback branch over dummy initializer (Jeff Johnson)
---
 drivers/net/wireless/ath/ath11k/mac.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index a6a37d67a50a..47d3d5fd0423 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -9224,6 +9224,11 @@ static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 	case ATH11K_SCAN_ABORTING:
 		ret = -EBUSY;
 		break;
+	default:
+		ath11k_warn(ar->ab, "%s: unexpected scan state: %d\n",
+			    __func__, ar->scan.state);
+		ret = -EINVAL;
+		break;
 	}
 	spin_unlock_bh(&ar->data_lock);
 
-- 
2.44.0


