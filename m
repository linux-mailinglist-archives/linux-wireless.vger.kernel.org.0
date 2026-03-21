Return-Path: <linux-wireless+bounces-33624-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKI4GZB6vmnpQgMAu9opvQ
	(envelope-from <linux-wireless+bounces-33624-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 12:01:36 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B33A2E4E3C
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 12:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D9DB4302141E
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 11:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5783B36999F;
	Sat, 21 Mar 2026 11:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="0JZRyT3X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D883064A3;
	Sat, 21 Mar 2026 11:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774090863; cv=none; b=al2mSa7YOVcGCuEJnt6eMYsjpgVF2KF05vxZRowimsSSLICmZ6ulfHj2ePCmVFx4R4MRUtTs6aeZ5+lN9B4RFdE/dpOpGWBjnzb2eLcmQDQ9vRRdX258XrIkcO0/Nf8tRiI1k6/GWYst07cAnIwpWM+7k7iy/mf49Am1zscouJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774090863; c=relaxed/simple;
	bh=jw/kItdtWlgZqg2wcUP4NBQa6hDQrkiW++vneLi7sQM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AATFdvEfd9fL0V7UcChh7XJaZ886azAKojf0xGiPW2XTab6kj0nRmtolCoHuxZKp+h02GUP0dsPB2KcMbAuE7QrHfSNV2WK8sisblNGx5TtIeIdim+/Dn9TQHRKhvOf6dyD4ilkOJH/C74FzXwIAmC76bAPDaPDBHtOZ4r0uCTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=0JZRyT3X; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1774090815;
	bh=Ef569JwFdhZArx/omdQP7G4f/QaYGZIypXkoSFlABe0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=0JZRyT3XpJzW5ZgGg6zAxUmNmBJvyBMWfuTaphJUDAoImu3b2b/BStGq+9B+1Yw64
	 KKUZfBVGz6ORdOJSlBxV5qA/q800PRjBpZqtB/o93AWbQKNm/dtc31BvfM047UFkeN
	 iZ0klngPHnLzoPaX/uqd9PgNzX0bSxV9tR9IR3+0=
X-QQ-mid: zesmtpsz9t1774090813t02798f32
X-QQ-Originating-IP: 5rdXDJlqFBsdgN+dsz9GeL3hz4oX/Xu8ikpFlPCIiao=
Received: from localhost.localdomain ( [116.172.93.199])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 21 Mar 2026 19:00:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1672418629744604756
EX-QQ-RecipientCnt: 9
From: Kexin Sun <kexinsun@smail.nju.edu.cn>
To: jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: julia.lawall@inria.fr,
	xutong.ma@inria.fr,
	kexinsun@smail.nju.edu.cn,
	yunbolyu@smu.edu.sg,
	ratnadiraw@smu.edu.sg
Subject: [PATCH] wifi: ath10k: update outdated comment for renamed ieee80211_tx_status()
Date: Sat, 21 Mar 2026 19:00:11 +0800
Message-Id: <20260321110011.8556-1-kexinsun@smail.nju.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: MVMn5D3ouL6ClpMhQvg0dsE8alJDF1uZmy0w97vLx37312iOqXMATv0X
	RCFQSLMMNxXPWy95F+e/2Y0QagQzfVKQmE9uTUdAX7tKH+1/Ng+IDXLA/t/yoDffdoSJb1l
	BYi+C8763X7DkVJ0h9OjkhBxJK3BqJLL1lETg6uBSkdsD85kzYOA4F/zMcKmoGd50zVaeIx
	MhWbPOd4hIK/a6nt5f90cD6D9iKmJ/LQahgn+P3PSud1tkdOCtqnbU2MZtdpw/raKKriJih
	LK/dgNVoA7PmH0KYKE2c2dKnw6G1XT8Nm4PFr//VPhFZbehz3ACzK39vmu+f+bxqvD6A5MO
	BPQmM0pDGOIjj0XbNK+BA9eZawlc0BeSTQ5Li4kYtT01Xi83AfjyqgkTYEM5i0Mv0VaJ1P7
	0PnOZcv7p4cr6zise7ODa171BJCTWRdq5TdAdxLtZuGnl5wFm08nuOxIjyo41ve+YwnXieP
	9d1tWS9tI9pjf9IWYkmJXL3kpUpFgMiXG8b8sWKg36m/c7DDU3fa9SRtdJJnL0ZLsJOx4YZ
	SGb09nQD9BEM6PC1CLpx85SnEZVX6VXyVWWvwydPYlnxckP7jGBMCjSXqZmVQ1aO+22JDPm
	I84vK3q4dqEwKn3HuQaoPz7SrzEOZ6WxZBar7i4k6OFfjPbfcjlWluYa5yYtzWkCNIna5ED
	BH2JRWrrsXD5YHfZAQk+bAmbaAKcgPZ+bqthYezx4SpGvDTFJTRkjHTIsv2Z7qLufEYzyqw
	GwRKjrlHJUfENc6hMJhR1dr8wjKmCrUDQRuV6OkJmP4uz8PEWiPmRonCuMx0X+YA/mValSQ
	1FqMZmNllyFzGzyIsluoJPYVCjhXOjpjhV/FbZdn+yHhHQS+V9TzxgqtTSFu9VYV2mu2POJ
	bnhFYZOmQnBlRqE2bmy0wZvc3HMxvdgX+0bA52Z7qbXW2PfGr2xk9W6Ibo0VNiPuRXabgUJ
	6ldYl8+csDD0hvNZWbeMzfH7GveXIZyAiqX6nROAwn2Y2T/BggKzqIH4FRbUwEpnZvimY0A
	+9vD/xR3UrhqWBBjvlzaQYvHuScZo1iZtQbE98073HSNHr2eLdhcxEzAyYrq4vCmiV5MwGb
	Bwfl4JrVxz3VdZuh2uQhPI=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[smail.nju.edu.cn,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[smail.nju.edu.cn:s=iohv2404];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33624-lists,linux-wireless=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kexinsun@smail.nju.edu.cn,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[smail.nju.edu.cn:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nju.edu.cn:email,smail.nju.edu.cn:dkim,smail.nju.edu.cn:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0B33A2E4E3C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The function ieee80211_tx_status() was renamed to
ieee80211_tx_status_skb() by commit 2703bc851399
("wifi: mac80211: rename ieee80211_tx_status() to
ieee80211_tx_status_skb()").  Update the stale reference
in ath10k_htt_tx_hl().

Assisted-by: unnamed:deepseek-v3.2 coccinelle
Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
---
 drivers/net/wireless/ath/ath10k/htt_tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c b/drivers/net/wireless/ath/ath10k/htt_tx.c
index d6f1d85ba871..29e99fbf36fd 100644
--- a/drivers/net/wireless/ath/ath10k/htt_tx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
@@ -1353,7 +1353,7 @@ static int ath10k_htt_tx_hl(struct ath10k_htt *htt, enum ath10k_hw_txrx_mode txm
 		msdu_id = res;
 	}
 
-	/* As msdu is freed by mac80211 (in ieee80211_tx_status()) and by
+	/* As msdu is freed by mac80211 (in ieee80211_tx_status_skb()) and by
 	 * ath10k (in ath10k_htt_htc_tx_complete()) we have to increase
 	 * reference by one to avoid a use-after-free case and a double
 	 * free.
-- 
2.25.1


