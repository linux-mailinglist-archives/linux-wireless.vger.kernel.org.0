Return-Path: <linux-wireless+bounces-31677-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id BXmGFQiUimmAMAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31677-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 03:12:24 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4311162FB
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 03:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 27D8730300F7
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 02:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF67A2C1589;
	Tue, 10 Feb 2026 02:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PoY0Ora/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602EA2D1907
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 02:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770689537; cv=none; b=LpCFnSgH0wmrb56y6dpzcCmiH3XYQlSmqfe1KoP/pCBYVoRJRm6SxVkg20Nmjmxa2KWBkriZZ3wEqtVysCj0563+TbgYH/gihW9zi4vwB2J75iqO79Xhx6pZR80Hc7w5cehhWTNOtIVkpO+kUC4FOkQKqFYEIBnfwW2iOHICcJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770689537; c=relaxed/simple;
	bh=e1jthajRv72ei+dOEjhLdlwpNmBRn7XgiNKQt0ZSr9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bxCX9NDqnybvsBUhkwLKMidKyLD6c4Ww1T+eVA8B7zUesX+1iAmTXUypxnpTUPIln71nRkTnVfKmhPrOnTVm3OrXDOrKgtbzalOHpt4c22a/CrAHw4I40yAxUhycDC6OelCFnxmouyAfaXLiAP1f7TuMKBW05RwXJh7OdodJV+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PoY0Ora/; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8c59bce68a1so27863585a.0
        for <linux-wireless@vger.kernel.org>; Mon, 09 Feb 2026 18:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770689535; x=1771294335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wyckoz1LCy6lmq5T1nxhAjHQG5bYzvC9R2mzguy/dUM=;
        b=PoY0Ora/NCl71QRY+JhYSZlf9Pu4B9Nhqcg4iwLyp3JOTn68cNYJn6/EhIv9/lqo/Q
         IH+anSbWOCisOj9nti663pDs42dtBi2e83+beKaJccdz5WsnA/YxCFueVIcHqB13UrAd
         ZjxXpvaIiUgYdx+QTRNFhiKn3093kp92DUJtvYiqtL9+2T8Z24h9joU70B5R8YyOcIAM
         zQ99jkntsBbvSJRisCXobTlHU+m8ypTQuDB25p3rqpKXVMon3zMlfsJwZd7ST0CE98Gd
         pOW2zNdvmYflLqfWxZLVFUtWjxALSrrcw4JYIA9FfjfDSHZt7FHGF3X/ECohd4hQ2GCi
         RBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770689535; x=1771294335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wyckoz1LCy6lmq5T1nxhAjHQG5bYzvC9R2mzguy/dUM=;
        b=d8VltMzvxIOjf2/raWCmf4b+4qooy72XutWfWeWZ45kG249Z7zPkV1vM/1wWXNHYrS
         3lC2H+ejI5QWmEQKcUSTrdmER7ryS6GMJ4gAN+nN2GkCok6mQC5vus+Jx+ldzrEh08ho
         2/jBFzvzSx+asUydmUvM6Jq+NQU0/0L5jrUxTn2is6dVDAmzkC4yzP/ZnpanDyT/xAt6
         1a4nwX2FcrDCWsBXrjwqYydXkTcO4Kq4ntvmxguj0p4KSrINYDtdZI3LR7cvMpWsH0wD
         D4BqkSTBrCIl/x55k5ktuUkttExGLFeMIU5B+9nYvw+WCo9BAkz6hcNkZiQwLtDYxFDD
         lgRg==
X-Forwarded-Encrypted: i=1; AJvYcCWtCocGzzyIPY8AcXrV/v0yPfpzyIFL4WOcUE4dyepSvG8DG+TaUXlxeP7LzbhqFVbgOY1c1H0WEkd8pxHEPw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0t5T13PhT+tS4kmA0nlP70P+OyR/S/vGecivijEx/gg0DSnaa
	Rrc4DVv8Qla2mwaZnLlqlk22uV2s+oKAtI4gyaINERWlSQrPLbhHtChJ
X-Gm-Gg: AZuq6aIVxx6Z6nS4E11O9UKjujAWfF5LizB1puJ925OLgvMYf8cgOBqiGX9dZJ16o5A
	EFm4Y1r7svaJTYurkgzqNlVRs01PnUlrNxNBALva8J5Ytgcj0mRKKlqNqBCSHpED+p2kABgFCiL
	C2kakCLUUilqNNEemSB+U7TK77guOyYCWO0xfkubvCic2PMKFFqBIjXs/ve0YbJ0SPqzAqm59V+
	A7o0U3jW4WzkEXq7w46JWcL022oHTU6JpzRkGjUsgepSdeknbH0dVFzMTWhk/NW3Oe6eBJsxsDn
	14GA/aGSNbgnVjDDufjmULfm0Q7c+wTOCP/Tk2iw1j/pIZT3qjTNi6AijiDRMxXc8bSdJErfnk7
	Bo8Z2WJNtYNd0beShEu14sjBICnjF3WPCd7rprFVKTjOc+pm2Z0N98XQ1VCKg8F2IfSXq424pkq
	A67bF0pU8497GqfKDb9UF7fNjyMahTMe26lzzLfnNursHb8gOvJ+emkuhShbsPaZgQR3TXx7kTc
	S/5JBnO7ox6ibg=
X-Received: by 2002:a05:620a:1a97:b0:8c6:a487:6add with SMTP id af79cd13be357-8caef029f46mr1835314385a.22.1770689535278;
        Mon, 09 Feb 2026 18:12:15 -0800 (PST)
Received: from localhost (bras-base-toroon21-grc-75-184-144-58-243.dsl.bell.ca. [184.144.58.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf7aeed8bsm963656285a.20.2026.02.09.18.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 18:12:14 -0800 (PST)
From: Richard Acayan <mailingradian@gmail.com>
To: Jeff Johnson <jjohnson@kernel.org>,
	Michal Kazior <michal.kazior@tieto.com>,
	Kalle Valo <kvalo@qca.qualcomm.com>,
	linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org
Cc: Richard Acayan <mailingradian@gmail.com>
Subject: [RFC PATCH 1/2] wifi: ath10k: make in-order rx amsdu buffers persistent
Date: Mon,  9 Feb 2026 21:12:48 -0500
Message-ID: <20260210021249.12132-2-mailingradian@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260210021249.12132-1-mailingradian@gmail.com>
References: <20260210021249.12132-1-mailingradian@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31677-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mailingradian@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CB4311162FB
X-Rspamd-Action: no action

The WCN3990 might split MSDUs among multiple "in-order" indications. The
driver needs information from previous indications to handle MPDUs that
are not started by the same indications that complete them. Move the
list that tracks unprocessed MSDUs to the driver state so the driver can
handle MPDUs that are split in this way and be less confused.

Fixes: c545070e404b ("ath10k: implement rx reorder support")
Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 drivers/net/wireless/ath/ath10k/htt.h    |  4 +++
 drivers/net/wireless/ath/ath10k/htt_rx.c | 41 ++++++++++++++++++------
 2 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt.h b/drivers/net/wireless/ath/ath10k/htt.h
index 603f6de62b0a..ec897175c933 100644
--- a/drivers/net/wireless/ath/ath10k/htt.h
+++ b/drivers/net/wireless/ath/ath10k/htt.h
@@ -1929,6 +1929,10 @@ struct ath10k_htt {
 	bool bundle_tx;
 	struct sk_buff_head tx_req_head;
 	struct sk_buff_head tx_complete_head;
+
+	u8 rx_in_ord_split_tid;
+	u16 rx_in_ord_split_peer_id;
+	struct sk_buff_head rx_in_ord_split;
 };
 
 struct ath10k_htt_tx_ops {
diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
index d7e429041065..b27271c56d07 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -297,6 +297,8 @@ void ath10k_htt_rx_free(struct ath10k_htt *htt)
 	skb_queue_purge(&htt->rx_in_ord_compl_q);
 	skb_queue_purge(&htt->tx_fetch_ind_q);
 
+	skb_queue_purge(&htt->rx_in_ord_split);
+
 	spin_lock_bh(&htt->rx_ring.lock);
 	ath10k_htt_rx_ring_free(htt);
 	spin_unlock_bh(&htt->rx_ring.lock);
@@ -846,6 +848,8 @@ int ath10k_htt_rx_alloc(struct ath10k_htt *htt)
 	skb_queue_head_init(&htt->tx_fetch_ind_q);
 	atomic_set(&htt->num_mpdus_ready, 0);
 
+	skb_queue_head_init(&htt->rx_in_ord_split);
+
 	ath10k_dbg(ar, ATH10K_DBG_BOOT, "htt rx ring size %d fill_level %d\n",
 		   htt->rx_ring.size, htt->rx_ring.fill_level);
 	return 0;
@@ -3264,7 +3268,6 @@ static int ath10k_htt_rx_in_ord_ind(struct ath10k *ar, struct sk_buff *skb)
 	struct ath10k_htt *htt = &ar->htt;
 	struct htt_resp *resp = (void *)skb->data;
 	struct ieee80211_rx_status *status = &htt->rx_status;
-	struct sk_buff_head list;
 	struct sk_buff_head amsdu;
 	u16 peer_id;
 	u16 msdu_count;
@@ -3299,16 +3302,32 @@ static int ath10k_htt_rx_in_ord_ind(struct ath10k *ar, struct sk_buff *skb)
 		return -EINVAL;
 	}
 
+	if (!skb_queue_empty(&htt->rx_in_ord_split)) {
+		/* It might still be possible to handle this case if there is
+		 * only one peer that splits at each given moment. We are
+		 * bailing out because we should have a test case for this
+		 * before trying to fix it.
+		 */
+		if (tid != htt->rx_in_ord_split_tid
+		 || peer_id != htt->rx_in_ord_split_peer_id
+		 || offload) {
+			ath10k_warn(ar, "split amsdu did not resume immediately\n");
+			htt->rx_confused = true;
+			return -EIO;
+		}
+	}
+
 	/* The event can deliver more than 1 A-MSDU. Each A-MSDU is later
 	 * extracted and processed.
+	 *
+	 * It can also continue a previous A-MSDU.
 	 */
-	__skb_queue_head_init(&list);
 	if (ar->hw_params.target_64bit)
 		ret = ath10k_htt_rx_pop_paddr64_list(htt, &resp->rx_in_ord_ind,
-						     &list);
+						     &htt->rx_in_ord_split);
 	else
 		ret = ath10k_htt_rx_pop_paddr32_list(htt, &resp->rx_in_ord_ind,
-						     &list);
+						     &htt->rx_in_ord_split);
 
 	if (ret < 0) {
 		ath10k_warn(ar, "failed to pop paddr list: %d\n", ret);
@@ -3320,11 +3339,12 @@ static int ath10k_htt_rx_in_ord_ind(struct ath10k *ar, struct sk_buff *skb)
 	 * separately.
 	 */
 	if (offload)
-		ath10k_htt_rx_h_rx_offload(ar, &list);
+		ath10k_htt_rx_h_rx_offload(ar, &htt->rx_in_ord_split);
 
-	while (!skb_queue_empty(&list)) {
+	while (!skb_queue_empty(&htt->rx_in_ord_split)) {
 		__skb_queue_head_init(&amsdu);
-		ret = ath10k_htt_rx_extract_amsdu(&ar->hw_params, &list, &amsdu);
+		ret = ath10k_htt_rx_extract_amsdu(&ar->hw_params,
+						  &htt->rx_in_ord_split, &amsdu);
 		switch (ret) {
 		case 0:
 			/* Note: The in-order indication may report interleaved
@@ -3340,12 +3360,15 @@ static int ath10k_htt_rx_in_ord_ind(struct ath10k *ar, struct sk_buff *skb)
 			ath10k_htt_rx_h_enqueue(ar, &amsdu, status);
 			break;
 		case -EAGAIN:
-			fallthrough;
+			htt->rx_in_ord_split_tid = tid;
+			htt->rx_in_ord_split_peer_id = peer_id;
+
+			return -EIO;
 		default:
 			/* Should not happen. */
 			ath10k_warn(ar, "failed to extract amsdu: %d\n", ret);
 			htt->rx_confused = true;
-			__skb_queue_purge(&list);
+			__skb_queue_purge(&htt->rx_in_ord_split);
 			return -EIO;
 		}
 	}
-- 
2.53.0


