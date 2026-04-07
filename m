Return-Path: <linux-wireless+bounces-34397-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DwGARtN1GnvsgcAu9opvQ
	(envelope-from <linux-wireless+bounces-34397-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 02:17:31 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A613A8658
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 02:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AC703046066
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 00:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D1916132A;
	Tue,  7 Apr 2026 00:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qmRGGoWC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E946E15853B
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 00:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775520967; cv=none; b=bX69LfDYbUjfnjancWqyltnFjT0O52hrj7FW4iUM8lh8B+gfOr9lbaByfHgbw4I6WtqiRbGGyOOfRjMVvqILTK3M08N2Xvp2sRiltF43aXf6zB+maFbsd3b1zJKW2Bu9QBcmhpi4iuc/AdWIPgZZ00+aLj9v+Orz94sc63Ql3UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775520967; c=relaxed/simple;
	bh=abfviTMpwsyAYXHpfGP3UtITHSacM7Wk2/FOzUFi22s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AMxRQjcRaQelazoj7wlVc3luV/FqEOnfxPYTOnwSHLO8INboq3YPMduqH2PE4LVvrBBXDLjmXmK21mxGajimITBHqojizkZMzE19V7ZJVdSdH8U783pjDbFrG2PKAUgl+TTs+Eyd1SQLHvv9QWzqGRYS9HVy05Wao178pS2Gvh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qmRGGoWC; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6501c9903edso4345017d50.1
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 17:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775520965; x=1776125765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lpRQVBI/tGnu8w/tv0/ebsR+Iqg+v4kfFE8c2q2ORJ8=;
        b=qmRGGoWCpIrmqvOkwt2Y0ChJJ0DrZtTVJ99BHdaGVqsFqANVQNo9jO1asW3s6l7UD5
         uUN5mQ0uIRxrcbWZ9clZNNw0UnbKn509nteB1yVkK25KYXMubXt3HdojsLIMAeW1T4S6
         uJMyAatfRX4mTQKg4MiKMeyD6D97aKUzI4rx+tEsOOaTjIL99geB/9fGo2PJNytSSUMj
         B2PNSLqq4MIOpKY65b84XHDQIEOoFmFX0hyv1sQeTBn8MSGWOJM43BujOyyFqG3YwrIR
         xdpLWsWzuaFL2ryYZXB0KhYbjJT9nGH2NBK+cIEzmUiqugyOsKs4oVDEEQdeZvsOKv++
         K1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775520965; x=1776125765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpRQVBI/tGnu8w/tv0/ebsR+Iqg+v4kfFE8c2q2ORJ8=;
        b=Bk4pg8t7fCyTwyBOZCQg+rqypo7QOhXdIUKKGOYvMzwLS06JCFjC5NsOYT7B1b90De
         JbU8iEutpO6fiaxeboUxBGBDFPxm+XOD5xc2jntcWYMlLxsXaCRCp1P4Jurl9WWsA3Ry
         CFWP7auh68Th8nsC27ooZOCOOnexJgBTYu8mK3VXWO6OJYaRpbVe13oUmznNtSQE/vIg
         cXGDe+H5dJmeSmFDcd0P4WVm5qx3wTjupc1r6crEyH4FLDTWv48SrlWmUpvclwnaqjUa
         FLEivRF6M10nfqWvjJmdULIvvPv/MK0gXuMmSl+7n/iKezTr2EmeUA3RMGyAhOfJsaSh
         PLHw==
X-Gm-Message-State: AOJu0YxXpAYgTyxAXXDENANonlalxVsHQTHmhj7qmOJGMKQFUaTrWGSy
	DHvSBYtHVuRVB2Iim5YII9p/fJg84Se8Dc0UpLsCdDKFpwP+PB7VaSY3IvQtCZAs
X-Gm-Gg: AeBDiev0S8/6mk94CCvJ7LXWz9URh1yhz90kJ5LdzXg3JHY6raMFOVCLXZ9p5y1sZSl
	17RxdLGmM62keJeSMxaGb80Rt4Xxze9hhyq1vzcm6fnDacmeL0/YUfmm1Kq7ykbO3lsk6tH2FbA
	mUQ6nrlq+9ouJ/Ndn2nLBj7qQ7gIxt+NZ2p5YiV6k+zba8bstXewVycETr4Co0f+P8fcymG/H+d
	4gyGagxkwxPXX7AWXYem5PBL/BnWjM0SQzA2Xt35nwhMHBiKX6FHEEQ4LnDImtJhLBXrC80+MwZ
	blpqSKD9uHyPCO1Km1HoclIo4WwwbDDGn2k2J32c+FDEfiZr9Z5TSSokrSRMdOV1CGViTnNhtbS
	6lOG3ON+sfCKl/fKELo8lUt8uxMccSKtXdMS1rikkwl16I+vJyZW60RdDUZvgsYxYltkyXGjQvg
	HqHIevC815rr3yn528ektPdzJ8a+j8iUS1KhTKPXbBhRtyFycPjY3NGD8EGMQn
X-Received: by 2002:a05:690e:130c:b0:643:1a5f:aaec with SMTP id 956f58d0204a3-65048814920mr14309332d50.47.1775520964789;
        Mon, 06 Apr 2026 17:16:04 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a9d50afsm6698649d50.19.2026.04.06.17.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 17:16:04 -0700 (PDT)
From: Joshua Klinesmith <joshuaklinesmith@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	linux-kernel@vger.kernel.org,
	Joshua Klinesmith <joshuaklinesmith@gmail.com>
Subject: [PATCH wireless v2 0/4] wifi: mt76: fix RCPI chain 3 mask in sta_poll RSSI extraction
Date: Mon,  6 Apr 2026 20:15:56 -0400
Message-ID: <20260407001600.31234-1-joshuaklinesmith@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-34397-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuaklinesmith@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 59A613A8658
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The fourth receive chain RCPI extraction in sta_poll uses
GENMASK(31, 14), an 18-bit mask spanning bits 14-31. It should
be GENMASK(31, 24), an 8-bit mask for the fourth byte, consistent
with the other three chains and with the RCPI3 definitions used
elsewhere in the driver.

On devices with fewer than 4 antenna chains the corrupted value
is masked out by antenna_mask. On 4-chain devices this produces
incorrect ACK signal strength readings.
---
v1 -> v2: Rebased on wireless.git (was mt76-fixes)

Joshua Klinesmith (4):
  wifi: mt76: mt7915: fix RCPI chain 3 mask in sta_poll RSSI extraction
  wifi: mt76: mt7996: fix RCPI chain 3 mask in sta_poll RSSI extraction
  wifi: mt76: mt7921: fix RCPI chain 3 mask in sta_poll RSSI extraction
  wifi: mt76: mt7925: fix RCPI chain 3 mask in sta_poll RSSI extraction

 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)


base-commit: ce5cc2702bb63ecd1f2066acb7d6e7d19081618d
-- 
2.43.0


