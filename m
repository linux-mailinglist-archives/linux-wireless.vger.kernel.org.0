Return-Path: <linux-wireless+bounces-34558-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJoCC9cp2GnIZAgAu9opvQ
	(envelope-from <linux-wireless+bounces-34558-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 00:36:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6273D04CD
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 00:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B593430107DC
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Apr 2026 22:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91563395279;
	Thu,  9 Apr 2026 22:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="dVBA+HTn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from outbound.st.icloud.com (p-east2-cluster2-host1-snip4-3.eps.apple.com [57.103.78.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7A439526C
	for <linux-wireless@vger.kernel.org>; Thu,  9 Apr 2026 22:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.78.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775774113; cv=none; b=oVAdBh359sSFKU5HYOCVICEmA1ywUOjq65YLjJIqC+4c2jxVK6zJo6xGUvT4FdtJ/j23lS3gGZZa4dTI1Sv0dM5s1cqbvb6zdmuszu7ty4HAl3fJO8vOdAMMfOWQNtXWCWKaIV202rec5wGq7Z5gminkFX89jHxhy+9juBrug9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775774113; c=relaxed/simple;
	bh=ElY76aRmQaV8414+l4e1E+9w/AgPL7C+YAnO+KZVCDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sDpYSl+AIVgIwshrm9WQ3Y+eZXMA67ha7XA7IX+gwvRGXcGs7cUZe13aMO3G6o3HDDdkfpd2glC+tQ2H2ePvGk3gvHsDgcOaPazW2/epgMgl6hGyuCJiGD0V7C39hyI2tkS4dtePUjEAFUMMkqxmi6kat4exFTFGQ+KQhf3kLnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=dVBA+HTn; arc=none smtp.client-ip=57.103.78.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-9 (Postfix) with ESMTPS id C6FF8180040B;
	Thu, 09 Apr 2026 22:35:10 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1775774111; x=1778366111; bh=LgUWEgZUYeu5as/EaW4uJAmp4IYUkS5eoA6OuLpkIPc=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=dVBA+HTnb+cM6jhE8jDCnggHlshr8Z+3xkkktfdSG3c+dGd+HhsyMyVgJBnSrH9iBAtJFB7XziRzDrhVWrEXLxoxP+yICwk4EAhpJKpEillO7M4DQGxyrrbgyOxkckc362T3UT0KOS7uEfrJZNXUCjh8SGrYlSnKlcdgqVEide/svHlLhv75Pu4XriTOmU25evDrqLwL+GV3GC0AOF99tS/KI5w+9IvKlpCvcrYSPLWC0OPbU9zD9/vHaJvCckBUgPlHlHAxsykbk4ZVdW5KBMTf19hDG2g3c2qc3IhqPECEpWHSGmwP4f2pay6f/w3p1A0GGSWtlte5KaLX4SEyaQ==
Received: from mainframe.tailfb0f7b.ts.net (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-9 (Postfix) with ESMTPSA id D83581800423;
	Thu, 09 Apr 2026 22:35:08 +0000 (UTC)
From: =?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <snowwlake@icloud.com>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org,
	stable@vger.kernel.org,
	krzysztof.kozlowski@linaro.org,
	=?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <snowwlake@icloud.com>
Subject: [PATCH net 2/4] nfc: digital: Fix check-after-read in digital_tg_recv_sens_req()
Date: Fri, 10 Apr 2026 00:34:32 +0200
Message-ID: <20260409223436.1887988-3-snowwlake@icloud.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDIwOSBTYWx0ZWRfX9xeMsyodG/lI
 r4un6xZP+r6mBnlN6QvnQePhC4OI46+lhYg+Yi8XIed8BAOTMjRn6pOCut6zc/VKcyw9esV1JRh
 6BIkXnoYZhWOi6kIljF3qlCYg+zV4NoKDwIq3WpfTDrXF0P+mwMRmLq+EgzGIosEHreT/9Mmfkc
 BNg5EahoqGzB+GfDaIkqV4PJfI0GOMGyXtnctO5x0Q2diDY5/y56YUlv/cf7s5Cl3prRzNcGhes
 nwA1gtKbSJunJoFlHCJHFSE6xdmefgmXDNUmXMwwyHdkCtRtyNpPAHUyGqmnSlBlFz9TrrW99Rv
 lN1jWk2Bfyd7q8WpvriE0VwItRhWE6zLbh4A2dv+hg68Rj0ArMo9rNWyRLKjqY=
X-Authority-Info-Out: v=2.4 cv=BIS+bVQG c=1 sm=1 tr=0 ts=69d8299f
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=LbuW6tbUWPcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=v3ZZPjhaAAAA:8
 a=xpOvdnX2Pm451MKX3XEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=JKcXVnpmuwdQ7RL0mgk_:22 a=5Q-93EyGrU3sW_9myDOF:22
X-Proofpoint-ORIG-GUID: zyUSGLdjY6LLEXo9wYfCmfOTjbKw7hLG
X-Proofpoint-GUID: zyUSGLdjY6LLEXo9wYfCmfOTjbKw7hLG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 clxscore=1015 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
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
	TAGGED_FROM(0.00)[bounces-34558-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: BE6273D04CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

digital_tg_recv_sens_req() reads resp->data[0] into sens_req at line
1092 before the !resp->len guard fires at line 1094.  A zero-length
frame causes an unconditional 1-byte out-of-bounds read before any
length check has taken place.

The root cause is that the assignment and the length check are split
across two statements: resp->data[0] is read unconditionally into
sens_req, and only then is resp->len tested as part of a compound
condition.  Even though the || operator correctly short-circuits, the
read on the previous line is already done.

Move the length guard before the data access by splitting the combined
condition into an early resp->len check followed by the data read and
the command comparison.

Fixes: 2e7a3e7ee80d ("NFC Digital: Add target mode for NFC-A/ISO14443A")
Cc: stable@vger.kernel.org
Signed-off-by: Lekë Hapçiu <snowwlake@icloud.com>
---
 net/nfc/digital_technology.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/nfc/digital_technology.c b/net/nfc/digital_technology.c
index XXXXXXX..XXXXXXX 100644
--- a/net/nfc/digital_technology.c
+++ b/net/nfc/digital_technology.c
@@ -1090,11 +1090,14 @@ void digital_tg_recv_sens_req(struct nfc_digital_dev *ddev, void *arg,
 	}

-	sens_req = resp->data[0];
-
-	if (!resp->len || (sens_req != DIGITAL_CMD_SENS_REQ &&
-	    sens_req != DIGITAL_CMD_ALL_REQ)) {
+	if (!resp->len) {
 		rc = -EINVAL;
 		goto exit;
 	}
+
+	sens_req = resp->data[0];
+	if (sens_req != DIGITAL_CMD_SENS_REQ && sens_req != DIGITAL_CMD_ALL_REQ) {
+		rc = -EINVAL;
+		goto exit;
+	}

 	rc = digital_tg_send_sens_res(ddev);
--
2.34.1

