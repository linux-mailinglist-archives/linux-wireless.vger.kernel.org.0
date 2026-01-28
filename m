Return-Path: <linux-wireless+bounces-31253-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CC+bNyCCeWmexQEAu9opvQ
	(envelope-from <linux-wireless+bounces-31253-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 04:27:28 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3EC9CA9C
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 04:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C532E302811A
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 03:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0109C32E6BD;
	Wed, 28 Jan 2026 03:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="YkFy3Mhf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from n169-110.mail.139.com (n169-110.mail.139.com [120.232.169.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2DA215F5C;
	Wed, 28 Jan 2026 03:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769570828; cv=none; b=fG7ddZdsknlWoaOLMm7Lj/PTa5vntPWQuHMapIL2cSqRic7QIN49HfTPa0nGcS70xxtFYAaKNlDuPmDSQEm6vQUpd5EI+HuaSHM7D7+HjsZvIGk/m85zB8Wgy4nMuw62zVT5GsmvPlV6/17Lafm5btqaABOt/6HLKeLfzKCj5BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769570828; c=relaxed/simple;
	bh=T+AzJ7O6qkrMlPzPI8H4i32qKP+WFb+bmH/ksAazUgs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sF8dhkqKDQOfFypblqDs5HQGb4N2FsOKrvVGUVN3WqPvYp4PqER4HRB3IgPXg+LnESW9PJIyjOC9Q/HOy1Nrpr08M0EpPN5c56SYhqUp3Tk/M87S6V0hEI0wOWMEtXVHgpvcRmxpjkYwAQR4i01t4RZxG4p+/95lA9HMJALIoqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=YkFy3Mhf; arc=none smtp.client-ip=120.232.169.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=YkFy3MhfwFXTE1XjtTOvfMz/yiUCdBImkeb9XLiYDcCWCbVTvsSKg7K7RiF6UUED4Fu/7LdUDaara
	 NoMRmdRLJ+W2fb58Pk5g0hTdZFPiXFOZbxFElGKb9ykaTDiAtJeQQn3aAYwfpPjKWJ/CXpghEmRpa7
	 u4d2V7llf6lhfEy0=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[60.247.85.88])
	by rmsmtp-lg-appmail-05-12083 (RichMail) with SMTP id 2f33697981c6653-0065b;
	Wed, 28 Jan 2026 11:26:02 +0800 (CST)
X-RM-TRANSID:2f33697981c6653-0065b
From: Li hongliang <1468888505@139.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	quic_ppranees@quicinc.com
Cc: patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	quic_kangyang@quicinc.com,
	kvalo@kernel.org,
	quic_jjohnson@quicinc.com,
	jeff.johnson@oss.qualcomm.com,
	jjohnson@kernel.org,
	quic_msinada@quicinc.com,
	rmanohar@codeaurora.org,
	julia.lawall@lip6.fr,
	quic_pradeepc@quicinc.com,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org
Subject: [PATCH 6.12.y] wifi: ath11k: fix RCU stall while reaping monitor destination ring
Date: Wed, 28 Jan 2026 11:26:57 +0800
Message-Id: <20260128032657.1183323-1-1468888505@139.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31253-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[139.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[139.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	FROM_NEQ_ENVFROM(0.00)[1468888505@139.com,linux-wireless@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,139.com:mid,139.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 8A3EC9CA9C
X-Rspamd-Action: no action

From: P Praneesh <quic_ppranees@quicinc.com>

[ Upstream commit 16c6c35c03ea73054a1f6d3302a4ce4a331b427d ]

While processing the monitor destination ring, MSDUs are reaped from the
link descriptor based on the corresponding buf_id.

However, sometimes the driver cannot obtain a valid buffer corresponding
to the buf_id received from the hardware. This causes an infinite loop
in the destination processing, resulting in a kernel crash.

kernel log:
ath11k_pci 0000:58:00.0: data msdu_pop: invalid buf_id 309
ath11k_pci 0000:58:00.0: data dp_rx_monitor_link_desc_return failed
ath11k_pci 0000:58:00.0: data msdu_pop: invalid buf_id 309
ath11k_pci 0000:58:00.0: data dp_rx_monitor_link_desc_return failed

Fix this by skipping the problematic buf_id and reaping the next entry,
replacing the break with the next MSDU processing.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Acked-by: Kalle Valo <kvalo@kernel.org>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Link: https://patch.msgid.link/20241219110531.2096-2-quic_kangyang@quicinc.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Li hongliang <1468888505@139.com>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 66a00f330734..9373bfe50526 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -4777,7 +4777,7 @@ ath11k_dp_rx_mon_mpdu_pop(struct ath11k *ar, int mac_id,
 			if (!msdu) {
 				ath11k_dbg(ar->ab, ATH11K_DBG_DATA,
 					   "msdu_pop: invalid buf_id %d\n", buf_id);
-				break;
+				goto next_msdu;
 			}
 			rxcb = ATH11K_SKB_RXCB(msdu);
 			if (!rxcb->unmapped) {
@@ -5404,7 +5404,7 @@ ath11k_dp_rx_full_mon_mpdu_pop(struct ath11k *ar,
 					   "full mon msdu_pop: invalid buf_id %d\n",
 					    buf_id);
 				spin_unlock_bh(&rx_ring->idr_lock);
-				break;
+				goto next_msdu;
 			}
 			idr_remove(&rx_ring->bufs_idr, buf_id);
 			spin_unlock_bh(&rx_ring->idr_lock);
-- 
2.34.1



