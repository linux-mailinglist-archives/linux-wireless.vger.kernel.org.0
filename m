Return-Path: <linux-wireless+bounces-25443-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8211FB05163
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 08:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B56027A59B1
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 05:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2282D4B5C;
	Tue, 15 Jul 2025 05:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="JHe/+Plq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F397C2D46C6;
	Tue, 15 Jul 2025 05:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752559166; cv=none; b=u3UebJKhvqWYQbCLNlU9LU0EekxfWhGjkSomuPRgWUgMWY5pEpkQkq9Exl2tf0j5ZXwJXEQ7rIrV4ktTKLHmLd1KwEp4E85zherUy0BBtsiqyj6eSZ8Wm8AQhOaWMIQlqTcLUTZLIRywdbJG5iVH3svx1NK+xdQ0fX/Zqgduq80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752559166; c=relaxed/simple;
	bh=3w9v5XOK3nmKbzXyHo05dTFMRJDiL16We6EdBNUBIBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eeR1dShdV8kW5uHyGx2UqpoBVDLu8h60ahwjNRdjxiwDqOW+09GSLvSynFI/Bb0uTF2nyW2A1QT6lFs4kNbIzTINs6EmXYGKoABzu2XV3rwA18fVrUo4cWOKbv3UcyBdSMmjpZqb/bdjc8BK5IolzMDqkY2n6+QFxktYi62HBe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=JHe/+Plq; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1752559137;
	bh=T/H+H7acnSrH5T9y4IM2o1Lp8lnee9ih+TYEECoYWaw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=JHe/+PlqpqGoIwkvrNKaueIG2zdoLPUrDawJ7SMPBSj/LCKh621nqvJWGZ+uBiPpP
	 UzzZEK9+HKg8KYA8EdnjGYF0fz4EkBXZJkc7/AucfCRG60GtXF6pXfNTi2s2LSBCq0
	 vxd/x1w5PUzBcwoJtKsw2Db813JpZMbWwMFOUc8U=
X-QQ-mid: zesmtpip2t1752559125t7614b251
X-QQ-Originating-IP: YJx1RDH6gR8OG8KqFJj4ZZluKNyk9emldY6n56EeJ2Q=
Received: from avenger-e500 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 15 Jul 2025 13:58:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13187885021772657945
EX-QQ-RecipientCnt: 15
From: WangYuli <wangyuli@uniontech.com>
To: wangyuli@uniontech.com
Cc: akpm@linux-foundation.org,
	colin.i.king@gmail.com,
	cvam0000@gmail.com,
	emmanuel.grumbach@intel.com,
	guanwentao@uniontech.com,
	johannes.berg@intel.com,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	miriam.rachel.korenblit@intel.com,
	niecheng1@uniontech.com,
	shenlichuan@vivo.com,
	yanzhen@vivo.com,
	yujiaoliang@vivo.com,
	zhanjun@uniontech.com
Subject: [PATCH v2 2/2] scripts/spelling.txt: Add ransport||transport to spelling.txt
Date: Tue, 15 Jul 2025 13:58:28 +0800
Message-ID: <3B08394F75C07CCB+20250715055828.932160-2-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <949F0ED6008D554F+20250715055031.928947-1-wangyuli@uniontech.com>
References: <949F0ED6008D554F+20250715055031.928947-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: M/gVfrk+L+QsTmqEIWWJOgGKwpXdCq7DlT4MVKOdYa1+12Ssc5CnxPWt
	0cwkFGwCezj7UHE29f6Sw24Rtyo22J35pJTYvbpRtjUsueXcCyGZvmqROHaYkbSW2IerlS8
	vV+wfguhTOBVEBp2FeJvki662ub0jFKQSdUzq5MpoSRVqYuftp+MSF507xnkqS0YpzamM1M
	CBNJHWcCShLTh1222vzKclzQijUlsxExHaPrsy+e+yMJKTfl2pH1L7mgvX+XMBdc2CdJQPf
	2E9b4qnGzeyGLPX68Axwin9OG0vgy9qtqo5rWN58mt02TyghFy3cSyIo/lfrnWmxY2q9UDu
	FV27o4WIcEzrRUWLHHbyjWUGqW94pKdJ2UiIZI+eEHWWHNhSjr+Cy1JACj46NNiBDjoB/Qr
	8/p2f+k6rf15QiCUOOxbt+7A9hLjH1EQet8DV74Bfnp+XDmeysGiqIoF2gs5VwFFSlAu4jU
	tya2k6+oWJv/Coyro/ql2xPjQUt/CzgOhh1g9WWKZqPnxQD5SFsfZpykSvFuUp9QDtMbcZ4
	9usQPwRMZXMtzAIKyAcwAPxzM6BU8Vl1PMuT8BZJPAgS8rSsN90GbCzz6xhoUFkvhKAuyQ0
	l42iYegsz5u/pBde4wPQP9nrltJrfyvZVBtTfSJEF2ztjxPstDH5dHtnA4wyd3ILhtOz31K
	AT/R50Ib7kjYx2jqqIy+OFhiCzDpgRdHWKS6KWwQJQpTbGpEjV2y7tt5Zt8NFDfccaNcWzV
	UmPitpWLH0VKoNCtxbUHGo4z/ZJAYtNvnp5nKOgC873HSCeRaXA0pG9ovNNqpdFYunpzNWr
	Vl90D8W7hUHJHfQwwR4ck7rkfglUl4uIgeosxSYQhzwMm3j2EA+3fByZv+cBAKRzgsSfE07
	hdx1lYv72ze3TZT2D/m+mN7BfnnchmrRd12b3D20H9MW3iP9lamqsE4jKcWvN1bko1mzb3k
	cKRlMNNjOxS5i4k3dtGzzBkvTSlESo9udpUGLcHH2ZG/fe0pgc70bGi25nD+5mLUUqcmkSS
	p2SvwC+vH3pesQmK56JrC+byGZLb4X8AR2cvWThf5F3HpBwYKYMR5ckIYFVhBnWKO3rPy47
	5LwOm/SZ+vCWxtkedszDz8=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

This typo was not listed in scripts/spelling.txt, thus it was more
difficult to detect. Add it for convenience.

Link: https://lore.kernel.org/all/C17A7B492949C5EC+1ddb2dab-9bb0-43d9-a022-118a34180a87@uniontech.com/
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 scripts/spelling.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index c33128db7163..c9a6df5be281 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -1314,6 +1314,7 @@ quering||querying
 querrying||querying
 queus||queues
 randomally||randomly
+ransport||transport
 raoming||roaming
 readyness||readiness
 reasearcher||researcher
-- 
2.50.0


