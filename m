Return-Path: <linux-wireless+bounces-14022-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A8999FB41
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 00:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B47E11C23518
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 22:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468FD1B0F21;
	Tue, 15 Oct 2024 22:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gS4t2AGk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D42B185B47;
	Tue, 15 Oct 2024 22:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729030845; cv=none; b=epxscwD8E8odYge2afriZ8H/Vcdm/gjnptg8mDx3jKZuNajz5HFnZgPp8xc3Ju78+n1qU8ijFbLONuo/pk8oz/o9QVOHwq1KXGCve4ahsThg/cTQFJOJ9G4uHnDEwzJk2+wqXyPzmk61RiEqFsesCLChNVJCJYaHu4UbA0hEEZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729030845; c=relaxed/simple;
	bh=XYyFKaNRA4wWaSAfK8rsk2azG+eY0S/cwk//6ZrNo8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PFtrRqE11P24rBhZP0QXSvC+g3ASyD+HRXuWd0Mw+yRwEE6xHkvVs/VoXJI+durjP7mfKnINlLccpShqhKNzMRt/gGhjYV7CFhRK7WTzjqpTF/WKECxvbGb34rnIMZvkIbqNiKTwHy1UhomK8gATakylok8JsiUr9xEZGAYDfho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gS4t2AGk; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FHth3T019373;
	Tue, 15 Oct 2024 22:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=9amxsHQkQT/G9w3PaJaVF40PUix0E
	rL5Pm84yf3YqPc=; b=gS4t2AGkl98LYAhuJ6m2b5XYCRScFGfkcqxQgwCmW+zCC
	DpGzwRw+NlK1LmC3GukPrGh5k5CdJAVQ/jWWM6CJWTvkVwJHRUL0s1uVuuKj20C8
	IF320xSQ9c1k4SiskUtXhh2AbUT0eHd8x3mFGPy6azPyyNMwIull+3xsE41+5bnc
	rPpzg7NHvmvRjNLosx+L0HigMo7iLdiuYQgwbAx7f/4ubOiq34QBHUu4OA8/0NGa
	1dq6FoSgczwa1WWe9jtYBXGOuQ1Tto3kcAZBMU0mXcCLpDK8F8TE/KsnyrWbviMK
	ToFUzzZrH5MPVfGCErZFCsISKzpP3Tk89paAaa/XQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gq7jdab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 22:20:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49FLWmX5026429;
	Tue, 15 Oct 2024 22:20:33 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 427fj82ve0-1;
	Tue, 15 Oct 2024 22:20:33 +0000
From: Sherry Yang <sherry.yang@oracle.com>
To: stable@vger.kernel.org, sashal@kernel.org, gregkh@linuxfoundation.org
Cc: johannes@sipsolutions.net, davem@davemloft.net, kuba@kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 5.15.y 5.10.y 5.4.y] wifi: mac80211: fix potential key use-after-free
Date: Tue, 15 Oct 2024 15:20:30 -0700
Message-ID: <20241015222030.1105765-1-sherry.yang@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_17,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410150147
X-Proofpoint-ORIG-GUID: MlRzkmW65rnXGfo3puKQ1oyeU0YjGui1
X-Proofpoint-GUID: MlRzkmW65rnXGfo3puKQ1oyeU0YjGui1

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 31db78a4923ef5e2008f2eed321811ca79e7f71b ]

When ieee80211_key_link() is called by ieee80211_gtk_rekey_add()
but returns 0 due to KRACK protection (identical key reinstall),
ieee80211_gtk_rekey_add() will still return a pointer into the
key, in a potential use-after-free. This normally doesn't happen
since it's only called by iwlwifi in case of WoWLAN rekey offload
which has its own KRACK protection, but still better to fix, do
that by returning an error code and converting that to success on
the cfg80211 boundary only, leaving the error for bad callers of
ieee80211_gtk_rekey_add().

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Fixes: fdf7cb4185b6 ("mac80211: accept key reinstall without changing anything")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Sherry: bp to fix CVE-2023-52530, resolved minor conflicts in 
net/mac80211/cfg.c because of context change due to missing commit
23a5f0af6ff4 ("wifi: mac80211: remove cipher scheme support")
ccdde7c74ffd ("wifi: mac80211: properly implement MLO key handling")]
Signed-off-by: Sherry Yang <sherry.yang@oracle.com>
---
 net/mac80211/cfg.c | 3 +++
 net/mac80211/key.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f652982a106b..c54b3be62c0a 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -511,6 +511,9 @@ static int ieee80211_add_key(struct wiphy *wiphy, struct net_device *dev,
 		sta->cipher_scheme = cs;
 
 	err = ieee80211_key_link(key, sdata, sta);
+	/* KRACK protection, shouldn't happen but just silently accept key */
+	if (err == -EALREADY)
+		err = 0;
 
  out_unlock:
 	mutex_unlock(&local->sta_mtx);
diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index f695fc80088b..7b427e39831b 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -843,7 +843,7 @@ int ieee80211_key_link(struct ieee80211_key *key,
 	 */
 	if (ieee80211_key_identical(sdata, old_key, key)) {
 		ieee80211_key_free_unused(key);
-		ret = 0;
+		ret = -EALREADY;
 		goto out;
 	}
 
-- 
2.46.0


