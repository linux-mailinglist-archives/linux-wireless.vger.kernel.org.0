Return-Path: <linux-wireless+bounces-22881-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E99DAB4944
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 04:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5F6E3A38B2
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 02:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E091A5BA2;
	Tue, 13 May 2025 02:09:56 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98091A3155;
	Tue, 13 May 2025 02:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747102196; cv=none; b=LTG3uR2thpeDziCGVeZFejjZXu8aD+ScopluAPDVKW4yPg9ZACF68KegfCMxSBIdpDHsyiq3SNntDlQBNdQL75nvy2EyTDHjthzwxoe4QKVeyc/Stx6X3X5FKhkbDHTrj3LBwP3J2l0XfnhVepB+TN6OykY2W14VvNFfCCr9+vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747102196; c=relaxed/simple;
	bh=CNUHkt67UtuoRyMOScLNUcMEjQj2NOYzghsKilvulV0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ibgBGny5FVwmo/NrL98ceL6+olvB7lLJqt6sZ7Guwk7gex/hIHl9q546G4LRat/chHKfBpXAZLoGVJOUDkApZjs/LklwNtbR3gKN2H/6F+AD/ydy6e/48UVYX2g8LB3YqCTZTN8zGZumr6quWkPuzbkq8oRL+zbs5RavMRfUXao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D1a69g013504;
	Mon, 12 May 2025 19:09:42 -0700
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46j6ajt6gv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 12 May 2025 19:09:42 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Mon, 12 May 2025 19:09:41 -0700
Received: from pek-lpg-core1.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Mon, 12 May 2025 19:09:39 -0700
From: <jianqi.ren.cn@windriver.com>
To: <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>
CC: <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <jianqi.ren.cn@windriver.com>, <johannes@sipsolutions.net>,
        <davem@davemloft.net>, <kuba@kernel.org>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.or>,
        <johannes.berg@intel.com>
Subject: [PATCH 5.15.y] wifi: cfg80211: check A-MSDU format more carefully
Date: Tue, 13 May 2025 10:09:38 +0800
Message-ID: <20250513020938.3361430-1-jianqi.ren.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: sy68rH0rsLNH2Wxxt1FbCNwJQ_g1xihz
X-Authority-Analysis: v=2.4 cv=c8irQQ9l c=1 sm=1 tr=0 ts=6822a9e6 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=dt9VzEwgFbYA:10 a=bC-a23v3AAAA:8 a=QyXUC8HyAAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8 a=bq9goISz1wTSU3ywWP0A:9
 a=-FEs8UIgK8oA:10 a=FO4_E8m0qiDe52t0p3_H:22 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDAxOCBTYWx0ZWRfX5vleoji/wkxF e0BS2KuKdnJSZouTgb0QpDKdwFtGkpY+unpJZLUWy/UjSEgU+WTxPOYQE3e+AvGOqVdN7YjkBet oXOzZnCevK2ZK8c6uvggAyRfBNiuNqFR8PeXpK0pbH6VFTisgr3V69MwJFjbi7y37V6lYemmwJq
 5YuH2JASw2wLmuTYWSh/HyXde/F4PDPxfFtpOk6+RsEmy2MRXZEEfKSgWB0ywxT5cVWxtVtnara zXX8VSYsHZfnGRhTbikbaUnqjrrACt1BnkmipdN/y76yMKnpnZb2dRkvJ/G4NV91+MvX26nAuKC 5Z+KRn5/gxGD5eprM3Bfz3GldUYAxRvE4bdFfeDZWCLD8zlU1YlHCXlqhgPVXwD1myNXNdQyG4j
 3GHYZGMElvQG9H6W4AIa+qhg+dgDqxOewAw02t6MC4eyjVYnTUd0enCXcwXo6QUGrYez/MRK
X-Proofpoint-GUID: sy68rH0rsLNH2Wxxt1FbCNwJQ_g1xihz
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1011 bulkscore=0 adultscore=0
 mlxlogscore=945 malwarescore=0 spamscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505130018

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 9ad7974856926129f190ffbe3beea78460b3b7cc ]

If it looks like there's another subframe in the A-MSDU
but the header isn't fully there, we can end up reading
data out of bounds, only to discard later. Make this a
bit more careful and check if the subframe header can
even be present.

Reported-by: syzbot+d050d437fe47d479d210@syzkaller.appspotmail.com
Link: https://msgid.link/20240226203405.a731e2c95e38.I82ce7d8c0cc8970ce29d0a39fdc07f1ffc425be4@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[Minor conflict resolved due to code context change. And routine
ieee80211_is_valid_amsdu is introduced by commit fe4a6d2db3ba
 ("wifi: mac80211: implement support for yet another mesh A-MSDU format")
 after 6.4.]
Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Verified the build test
---
 net/wireless/util.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 6ebc6567b287..0fd48361e3e1 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -751,24 +751,27 @@ void ieee80211_amsdu_to_8023s(struct sk_buff *skb, struct sk_buff_head *list,
 	struct sk_buff *frame = NULL;
 	u16 ethertype;
 	u8 *payload;
-	int offset = 0, remaining;
+	int offset = 0;
 	struct ethhdr eth;
 	bool reuse_frag = skb->head_frag && !skb_has_frag_list(skb);
 	bool reuse_skb = false;
 	bool last = false;
 
 	while (!last) {
+		int remaining = skb->len - offset;
 		unsigned int subframe_len;
 		int len;
 		u8 padding;
 
+		if (sizeof(eth) > remaining)
+			goto purge;
+
 		skb_copy_bits(skb, offset, &eth, sizeof(eth));
 		len = ntohs(eth.h_proto);
 		subframe_len = sizeof(struct ethhdr) + len;
 		padding = (4 - subframe_len) & 0x3;
 
 		/* the last MSDU has no padding */
-		remaining = skb->len - offset;
 		if (subframe_len > remaining)
 			goto purge;
 		/* mitigate A-MSDU aggregation injection attacks */
-- 
2.34.1


