Return-Path: <linux-wireless+bounces-34556-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDKIEZ0p2GnIZAgAu9opvQ
	(envelope-from <linux-wireless+bounces-34556-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 00:35:09 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1983D047B
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 00:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 08317301727A
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Apr 2026 22:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BBE395274;
	Thu,  9 Apr 2026 22:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="bfS9DC6x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from outbound.st.icloud.com (p-east2-cluster2-host12-snip4-10.eps.apple.com [57.103.78.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5461639526D
	for <linux-wireless@vger.kernel.org>; Thu,  9 Apr 2026 22:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.78.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775774105; cv=none; b=Soh+m9TVmVLiW5EogoHH3Wxm0L9RJcu7dpuXFihiPlA9ZQvCQda8diYlghQ8BnzLiRBDNSQXE3wj/AB1k1f/NyuLLUDKBkJNImR/9bmaNmUC2cIu8jyOV8KCALVrWfSIlsssCn6pYlsE2QZwYr++3UBFgpO5tXk7pLM6sdAkLqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775774105; c=relaxed/simple;
	bh=yucS9jHX1Vik1EyRXjxmNY7qHasrrVv9k2cTnPM4rZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TRPRJp683SG5A5RVq9352hAMvZp/uwpXE89iGCW/xwf0Ftw6bWO9Iw1eoG00lJlYgyfbGdaxWe1a/i/4Wagrz9zRIq0kXJzXx0GFabbWum8Ywn7SN1n6YqAKBfoMB5gImFf98yVDP8OHOsqUg3Su6TX5tKhIbc+Qf9F18HO1v+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=bfS9DC6x; arc=none smtp.client-ip=57.103.78.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-9 (Postfix) with ESMTPS id A6A761800172;
	Thu, 09 Apr 2026 22:35:02 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1775774103; x=1778366103; bh=e6WpG4CMMLjhe1gNiuspc9ZHTLMZiFQggWMLI08Htto=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=bfS9DC6xVa3iKgs/LlMilg1jwKX0PblDA9jWLWGvIn3WIeX+ag+ra2ai6lBFm3MfE4kUhzx5s98qN0BNqWfxaNsKQvjCYxGmGrj5tGUxKRbn1KrPFtxviwxKznQXQHdB7a9rmfCdcXTMapnVP2wWuDcFBxKy8BbJ+ug0CVjnLoULYx7nh3IlMKLyXVnHczI/Byg7qDqjhLupLMRBdHoYVdA9ny/iwlnJKa+B59o1gKB1VGASqb/rGwgVWfHw6aE9sxQM99JFPOLpN8QMrneZ0F2BHpJRv58pdFAex+HiAbn8eBlxKCT6hgs4AhHjZdOTJimysv5HY4o3laU7Tj6G/w==
Received: from mainframe.tailfb0f7b.ts.net (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-9 (Postfix) with ESMTPSA id 0E1AA1800409;
	Thu, 09 Apr 2026 22:35:00 +0000 (UTC)
From: =?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <snowwlake@icloud.com>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org,
	stable@vger.kernel.org,
	krzysztof.kozlowski@linaro.org,
	=?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <snowwlake@icloud.com>
Subject: [PATCH net 0/4] nfc: digital: Fix missing and misplaced length checks
Date: Fri, 10 Apr 2026 00:34:30 +0200
Message-ID: <20260409223436.1887988-1-snowwlake@icloud.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDIwOSBTYWx0ZWRfXxfSleY8kUUyv
 ArEJwEKqdDZ+ENQMrnnbHwaKS0+tuZPQvKfYTR7oeB+nouo74Dcg7q+jvNJfGQTwhx8XOtPRgUw
 zqLRsL4I9DyMS8YfgAR8fmRah0cewmlDI49oJ9fIPYThZtXBtZbonjxU8STJITzMAgwrROeFA3A
 KvGWH1H2HGnu8SlzIsj0ZilYcBPqMHW5Mm4FfY6dKCCENPYBD4D+KAIFgo2KccSO+i2RTGP043o
 iu8Ew1fzRtGFeutcmWdfDXbazQkxzJjM9r7b6IuZzhUNc5w98gL+oVFoRIgPErUCvHI3LlWbAtl
 WzLIK5q1fRWbWJAJSotNwK7O4VTNM0v3g9pOeIAq01+HjkY2CmQrywNzV6VJn8=
X-Proofpoint-GUID: tLKkQIn0-zJu-E-DOd_e7f0noylWfhRn
X-Authority-Info-Out: v=2.4 cv=fsjRpV4f c=1 sm=1 tr=0 ts=69d82997
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=M51BFTxLslgA:10
 a=x7bEGLp0ZPQA:10 a=LbuW6tbUWPcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Sa2SXQg9nKkPhw_9Z44A:9 a=JKcXVnpmuwdQ7RL0mgk_:22 a=5Q-93EyGrU3sW_9myDOF:22
X-Proofpoint-ORIG-GUID: tLKkQIn0-zJu-E-DOd_e7f0noylWfhRn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 mlxlogscore=982 bulkscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1011 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604090209
X-Spamd-Result: default: False [0.01 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.67)[subject];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[icloud.com,quarantine];
	R_DKIM_ALLOW(-0.20)[icloud.com:s=1a1hai];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,linaro.org,icloud.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[icloud.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34556-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[snowwlake@icloud.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[icloud.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,icloud.com:dkim,icloud.com:mid]
X-Rspamd-Queue-Id: CE1983D047B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series fixes four length-check bugs in the NFC Digital Protocol stack.
All are reachable from RF without authentication:

  - Patch 1: Missing upper-bound check before memcpy into target.sensf_res
    in the NFC-F initiator polling path.  An oversized SENSF_RES overflows
    an 18-byte stack buffer by up to 235 bytes.  CVSS 8.1.

  - Patch 2: Check-after-read in the NFC-A target receive path.
    resp->data[0] is read before the resp->len != 0 guard fires.
    A zero-length frame triggers a 1-byte OOB read.

  - Patch 3: Missing post-pull length check in the RTOX handler inside
    digital_in_recv_dep_res().  After skb_pull strips the 3-byte DEP
    header, resp->data[0] is read with no guarantee that any payload byte
    remains.

  - Patch 4: DID byte accessed at resp->data[3] after only a
    sizeof(struct digital_dep_req_res) == 3 byte guard in
    digital_tg_recv_dep_req().  An attacker with DID bit set and a 3-byte
    frame triggers a 1-byte OOB read.

Patches 1-4 are independent and can be applied in any order.

Security Research (4):
  nfc: digital: Fix stack buffer overflow in digital_in_recv_sensf_res()
  nfc: digital: Fix check-after-read in digital_tg_recv_sens_req()
  nfc: digital: Fix OOB read of RTOX byte in digital_in_recv_dep_res()
  nfc: digital: Fix OOB read of DID byte in digital_tg_recv_dep_req()

 net/nfc/digital_dep.c        | 10 ++++++++--
 net/nfc/digital_technology.c | 13 ++++++++-----
 2 files changed, 16 insertions(+), 7 deletions(-)

