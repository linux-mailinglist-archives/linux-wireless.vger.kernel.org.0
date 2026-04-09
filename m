Return-Path: <linux-wireless+bounces-34559-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJdYIfcp2GnIZAgAu9opvQ
	(envelope-from <linux-wireless+bounces-34559-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 00:36:39 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E02813D04EF
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 00:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B399230182BA
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Apr 2026 22:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6396B395D8E;
	Thu,  9 Apr 2026 22:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="0t9nIDvw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from outbound.st.icloud.com (p-east2-cluster3-host2-snip4-9.eps.apple.com [57.103.77.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3655639526D
	for <linux-wireless@vger.kernel.org>; Thu,  9 Apr 2026 22:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.77.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775774118; cv=none; b=TTT4sM/ESyHyS9Oj3RQcUmr/p0qRtrVM+FWs1uH5ogM29cLeOWtP/7BDnDNHCAOC6DX68ESv8nUGwIGuGMKPjmzyjGUKHxK/DOxPYPY/2rOMzG5x3cOP5+GyqgGlSZFfyNsGD7l14MYc1lZt4LG9MtN+ENhBz7223RzxGOMaz0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775774118; c=relaxed/simple;
	bh=ulwU50iu2o6IASyl6sYJbbyBQSTqqepbhFfy+GkNcmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HBd3oxVi8rGcgcUKFNe26uUquSqrc2ZgB05s1zfj+43zYcK16X6bk3LOMsxdoQdymUw2Gv8MmPZNSkAgHOgyAV1SKqKFK3pdukOcfvrKXk2j7HHXBVukWbcKvbvCmirquGTJVoK4srzZOaOZ6ESwFGjtpsa0Eh0Mak5Kzm4RF2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=0t9nIDvw; arc=none smtp.client-ip=57.103.77.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-9 (Postfix) with ESMTPS id E8F791800409;
	Thu, 09 Apr 2026 22:35:13 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1775774116; x=1778366116; bh=W0BUziTTsLVn2ctTi4opPvfWcnGNG9tOXIGstDAEeh8=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=0t9nIDvwm9ajIUo9zAZFByiLHiDzIvKQJYbM3xK3mp/hEnMwxmAnVDcR1nB+H/GgIlCAc1viJF1n18TW9VRwmhJpVSPdVvYSs1Z93YZ3m9JPTLz6THmDsQEVxzQJUUpZcN7jMA2q/DQz6zf+rwbcounAaqHKgAQ2y4vIj3G7sVfzrW+gkHHzqngEo6x0p5nR4oaDwZ7zta+4O4+tzwTje7mcfsWU0tLVMAdPVh+bepbIerjXVUDv5wAc5Ch7O5BfUt1qk+6S+fkzBBrTTnuf0Rncl4hVMF14CSunrnJ8jAnDJV3I0peae4gapj1hgUA6BOscBNvnvLIly+eYetmU4g==
Received: from mainframe.tailfb0f7b.ts.net (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-9 (Postfix) with ESMTPSA id 5450A1800413;
	Thu, 09 Apr 2026 22:35:12 +0000 (UTC)
From: =?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <snowwlake@icloud.com>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org,
	stable@vger.kernel.org,
	krzysztof.kozlowski@linaro.org,
	=?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <snowwlake@icloud.com>
Subject: [PATCH net 3/4] nfc: digital: Fix OOB read of RTOX byte in digital_in_recv_dep_res()
Date: Fri, 10 Apr 2026 00:34:33 +0200
Message-ID: <20260409223436.1887988-4-snowwlake@icloud.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260409223436.1887988-1-snowwlake@icloud.com>
References: <20260409223436.1887988-1-snowwlake@icloud.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: HwK4j0U-hqZpT0gCNQF0Jr2bsORHlaeq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDIwOSBTYWx0ZWRfX1OI+geBrEt9E
 WUp3MlYIyW1njDybpcRxj6FZuh12/jShyREKOE0JlQFjDG1pedKkb9w4idH8g6g5wm9rWg8mVwL
 wHxSTn+e2FrWzkew9SeFOAI4Nokfh8qQyv8GsoKxly3zMkRwmghFRmIWSCMnlVgWAravCNlkAFi
 ELP6IcXUIaZc02jN6wLwJcbip/rZWEO8K39P/7OCb3l94pgmKyMkdrr8NuUGdM7q/8CK8Ux5QBq
 EUV2LmgALPeC0+4Ub4TxovJPZ584YuV9SPqViSb1ts6kB0pLl5buGk/ELZ8C/R/a/7q/d3/X8nQ
 k2vL4wl8t/hck/V7Y+wCG0sX4ixTFUchUH74rC7t5hvt0HQTq+GPV36k0GS6mI=
X-Authority-Info-Out: v=2.4 cv=V+ZwEOni c=1 sm=1 tr=0 ts=69d829a2
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=LbuW6tbUWPcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=v3ZZPjhaAAAA:8
 a=RRCwjdIKexL7UHSVY30A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=JKcXVnpmuwdQ7RL0mgk_:22 a=5Q-93EyGrU3sW_9myDOF:22
X-Proofpoint-GUID: HwK4j0U-hqZpT0gCNQF0Jr2bsORHlaeq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0 mlxscore=0 malwarescore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604090209
X-Spamd-Result: default: False [-0.57 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.59)[subject];
	DMARC_POLICY_ALLOW(-0.50)[icloud.com,quarantine];
	R_DKIM_ALLOW(-0.20)[icloud.com:s=1a1hai];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34559-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,linaro.org,icloud.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[icloud.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[snowwlake@icloud.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[icloud.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[icloud.com:dkim,icloud.com:email,icloud.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E02813D04EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In the SUPERVISOR_PDU / timeout (RTOX) branch of digital_in_recv_dep_res(),
the RTOX value byte is read from resp->data[0] after skb_pull() has
stripped the 3-byte DEP_RES header:

  skb_pull(resp, size);   /* size = sizeof(struct digital_dep_req_res) = 3 */
  ...
  case DIGITAL_NFC_DEP_PFB_SUPERVISOR_PDU:
      ...
      rtox = DIGITAL_NFC_DEP_RTOX_VALUE(resp->data[0]);

If the remote device sends a DEP_RES frame that is exactly the minimum
length (3 bytes -- dir + cmd + pfb only, no payload), the skb_pull leaves
resp->len == 0 and the read of resp->data[0] is a 1-byte out-of-bounds
read of kernel heap memory beyond the socket buffer.

The I-PDU and ACK/NACK branches are not affected because they either
pass resp directly to upper layers or perform a separate minimum-length
check before accessing payload bytes.  Only the RTOX branch is missing
its guard.

Add a resp->len >= 1 check before the RTOX value read.

Fixes: 4b60cfce7aba ("NFC Digital: Implement NFC-DEP initiator TX and RX")
Cc: stable@vger.kernel.org
Signed-off-by: Lekë Hapçiu <snowwlake@icloud.com>
---
 net/nfc/digital_dep.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/nfc/digital_dep.c b/net/nfc/digital_dep.c
index XXXXXXX..XXXXXXX 100644
--- a/net/nfc/digital_dep.c
+++ b/net/nfc/digital_dep.c
@@ -866,6 +866,12 @@
 			goto error;
 		}
 
+		if (!resp->len) {
+			PROTOCOL_ERR("14.8.4.1");
+			rc = -EIO;
+			goto error;
+		}
+
 		rtox = DIGITAL_NFC_DEP_RTOX_VALUE(resp->data[0]);
 		if (!rtox || rtox > DIGITAL_NFC_DEP_RTOX_MAX) {
 			PROTOCOL_ERR("14.8.4.1");

--
2.34.1

