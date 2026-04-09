Return-Path: <linux-wireless+bounces-34557-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKq8Nr0p2GnIZAgAu9opvQ
	(envelope-from <linux-wireless+bounces-34557-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 00:35:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 720223D04AE
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 00:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32AE4300F5EA
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Apr 2026 22:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A504395D8E;
	Thu,  9 Apr 2026 22:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="bdAN+OT+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from outbound.st.icloud.com (p-east2-cluster2-host11-snip4-10.eps.apple.com [57.103.78.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E04E396572
	for <linux-wireless@vger.kernel.org>; Thu,  9 Apr 2026 22:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.78.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775774109; cv=none; b=RAPP5s0posZ6GaHFSNF+pKjYsU/G/EWeEufbcUENTjHUtm7TG96NbySfmp1vpLA1lVLfvxMhCZeVVo3rHJzcECUb2wA0fSRbstHsLls+TsppRhfyjy4DJznj49idESJbslGkvozoaYB4usfeTvp4HiXEusYC1evT2vRdwqK8fAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775774109; c=relaxed/simple;
	bh=rgixYpwLExRxCfdfzg422xukK3gtHMn9rlC80FajZiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H3WXMFaeupA3norG82hwYTrZtIZRawG++DCatuvZGKwnRJnWWfXn7BzXcJk/wRLDjz10BgaepIuhRkv8W8LQi2W8Rg5YrUclA5qeRKhu4hK/QUGYwBgGQv0mb78oA2GIFXv9jz3s8UYIwo48zYBp3fBcmbbhkuXw8epYYxvvBIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=bdAN+OT+; arc=none smtp.client-ip=57.103.78.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-9 (Postfix) with ESMTPS id A1C401800145;
	Thu, 09 Apr 2026 22:35:06 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1775774107; x=1778366107; bh=PV4d/TSvGRvOStbS6GmMVT/xygEMxo0GarP17giw+BQ=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=bdAN+OT+5RTAxIctHtUTOtZ9hZopF/iWacjxQvGQVPCy9Fafy+GE86c59MPhUEL5VLEclQJxenAlji86E63H6Go8Uq8FBN/pyQmBRfcWi+8u75J9JZQ/X36mLNYsGE+TgQIJDl23OFF1xtWOYvVeX0eesNPE1YqsbwqT4fevqNdZNasb9CPj7OM9+yUlH7VloPGCX1PxL15j69x4p1JbC9nReURsuBrfP8e6s0AkWRQZ/4LcvfMZnLXOUlvV4lTQJ3X2GkVmBPQ9zgTpEcNjSMco1G1oFP1WrfLvx35RXrzi0k3r9nSQAXtyPT5JMOmfG0TUGesqPTrkMXYSsg8jig==
Received: from mainframe.tailfb0f7b.ts.net (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-9 (Postfix) with ESMTPSA id 2082D1800165;
	Thu, 09 Apr 2026 22:35:05 +0000 (UTC)
From: =?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <snowwlake@icloud.com>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org,
	stable@vger.kernel.org,
	krzysztof.kozlowski@linaro.org,
	=?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <snowwlake@icloud.com>
Subject: [PATCH net 1/4] nfc: digital: Fix stack buffer overflow in digital_in_recv_sensf_res()
Date: Fri, 10 Apr 2026 00:34:31 +0200
Message-ID: <20260409223436.1887988-2-snowwlake@icloud.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDIwOSBTYWx0ZWRfX46oxqYc4I6+b
 WIssA/3tLgcCavLEvJCsjyO0nd1+hFBjV8wJWEso3n0s6WbB0SIbSIanIDv8bzBoobkKXBdwLiO
 RgIbeLsu7r0fZQdtJMTaP8+3yp7usIENzF1bG1pvf3J8fGEGyaVke0mU/zx62NfAjs0HikQc1wj
 dqH06H+U71xYLsbH1EbGYVAnkvUx2xfBr6Ej7Lt59jxZn/IN4eQQUquH7Dynra7+zneqUTMwg4T
 E5YuwGgD2YG6VW9wHQSvCnwnRiywajjHnlmoX9sPIpvKxW0N2BuiONVshlipuMY2iixxKHxl2Fq
 ZtUbYdp4TaBKfp4Lixrd9sf4wL6Ao6R0MNd8PY4bGoYsa+//B8yB08R47tT8cU=
X-Proofpoint-ORIG-GUID: gmM5NUEEHorRrA2UtfLU-sqcCF5395Oo
X-Proofpoint-GUID: gmM5NUEEHorRrA2UtfLU-sqcCF5395Oo
X-Authority-Info-Out: v=2.4 cv=BefVE7t2 c=1 sm=1 tr=0 ts=69d8299b
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=LbuW6tbUWPcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=v3ZZPjhaAAAA:8
 a=oaZbOBuStBcXi9oZc-cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=JKcXVnpmuwdQ7RL0mgk_:22 a=5Q-93EyGrU3sW_9myDOF:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 lowpriorityscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604090209
X-Spamd-Result: default: False [-0.49 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.67)[subject];
	DMARC_POLICY_ALLOW(-0.50)[icloud.com,quarantine];
	R_DKIM_ALLOW(-0.20)[icloud.com:s=1a1hai];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34557-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,linaro.org,icloud.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[icloud.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 720223D04AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The function digital_in_recv_sensf_res() validates that the incoming
SENSF_RES frame is at least DIGITAL_SENSF_RES_MIN_LENGTH (17) bytes,
but does not check that it is at most NFC_SENSF_RES_MAXSIZE (18) bytes
before copying into the 18-byte target.sensf_res stack buffer.

After skb_pull(resp, 1) removes the framing byte, resp->len can range
from 16 up to 253 — an NFC-F frame carries a 1-byte length field with
maximum value 255, from which the driver status byte (pulled here) and
the protocol length byte are subtracted.  The memcpy() at line 775 then
writes up to 235 bytes past the end of target.sensf_res, overflowing
into adjacent stack data including saved registers and the return address.

A device in NFC-F polling mode can trigger this condition without any
prior pairing or authentication by responding to a SENSF_REQ with an
oversized frame.  No user interaction is required on the victim device
while NFC discovery is active.

The NCI code path handles this correctly; nci/ntf.c line 508:
  nfcf_poll->sensf_res_len = min_t(__u8, *data++, NFC_SENSF_RES_MAXSIZE);

Apply the equivalent upper-bound check to the digital protocol path by
rejecting frames whose post-strip length exceeds NFC_SENSF_RES_MAXSIZE.

Fixes: 8c0695e4998d ("NFC Digital: Add NFC-F technology support")
Cc: stable@vger.kernel.org
Signed-off-by: Lekë Hapçiu <snowwlake@icloud.com>
---
 net/nfc/digital_technology.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/nfc/digital_technology.c b/net/nfc/digital_technology.c
index XXXXXXX..XXXXXXX 100644
--- a/net/nfc/digital_technology.c
+++ b/net/nfc/digital_technology.c
@@ -768,6 +768,11 @@ static void digital_in_recv_sensf_res(struct nfc_digital_dev *ddev, void *arg,

 	skb_pull(resp, 1);

+	if (resp->len > NFC_SENSF_RES_MAXSIZE) {
+		rc = -EIO;
+		goto exit;
+	}
+
 	memset(&target, 0, sizeof(struct nfc_target));

 	sensf_res = (struct digital_sensf_res *)resp->data;
--
2.34.1

