Return-Path: <linux-wireless+bounces-34560-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEhSHrYp2GnIZAgAu9opvQ
	(envelope-from <linux-wireless+bounces-34560-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 00:35:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 814F53D04A0
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 00:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CA6A03018B70
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Apr 2026 22:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1B2395D9F;
	Thu,  9 Apr 2026 22:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="l0Wer/zk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from outbound.st.icloud.com (p-east2-cluster3-host10-snip4-10.eps.apple.com [57.103.77.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C15395DA9
	for <linux-wireless@vger.kernel.org>; Thu,  9 Apr 2026 22:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.77.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775774121; cv=none; b=e+uqmNdlCyM7B/ill5MapjcIlBShSG35hrkSBrFNeFg8VGrpOwa8nxLzOlxTKmR0QIvDdwBtcm9NYObflsm8NjLlK0AJEb+DJ8Sqi6oNs/P9vpLeTVCKNiNILd0/GfWze3SjVYqNmkZG0i3lGYyGPrTeQt00vREK/QcgWPjp0DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775774121; c=relaxed/simple;
	bh=8S6RQt1olzPV8F2So5I1DbM61w/JWVH3wNVRvHPlEPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SLxqtUNTHTf6442f6Snk12TtTeLie2n8jNo5oWiEzZRadhn8WbBwqIfIrG7Q7CoVP2oufPqkYcjkwDdOj9IHs6Csk18uwvVravCQqfL57FFifzsZ2XQ4oFfWYeMzgnnXG7ytpfRqBENwDmJRulUUYkVvRbBAEWUDSbw8DwTfof8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=l0Wer/zk; arc=none smtp.client-ip=57.103.77.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-9 (Postfix) with ESMTPS id 14DB418000AB;
	Thu, 09 Apr 2026 22:35:15 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1775774117; x=1778366117; bh=ZXXDLB2PUJ6vUR0wUEhcQKOb3E/u++jkUsUBsK8oyrE=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=l0Wer/zkI0xHQR2lsmdmxfkEmEWKac4wRBrMAcO9bpe5R0IeI9tZ+f7YkmzjNwuNcpuITSp5+H9/3oq0Iq6Pvn9YprxiqBIrquI+3tJzY4k+HcUR9MRDWQ7AKzN82bwxyZS/vpvAZ9JXxxyipkhMV/Hbd8wzFaqRoebkFbwADLrI4j6BdG5KBXq2zPbsv/+FlCtQDOofEttXm5hqvn33zzDT7hflUe8eujA6Uiz4xCdYu0ZsR3InOxrqaYKqe9ld1Xbbjmyi4apvlp9b8wYfNfFUFzpiFSCoU3gZg88YHhhVP6PFho7HdM6BsHz7vK4ehciZY4h4ZZD/+RulYcM3DA==
Received: from mainframe.tailfb0f7b.ts.net (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-9 (Postfix) with ESMTPSA id 875771800145;
	Thu, 09 Apr 2026 22:35:14 +0000 (UTC)
From: =?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <snowwlake@icloud.com>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org,
	stable@vger.kernel.org,
	krzysztof.kozlowski@linaro.org,
	=?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <snowwlake@icloud.com>
Subject: [PATCH net 4/4] nfc: digital: Fix OOB read of DID byte in digital_tg_recv_dep_req()
Date: Fri, 10 Apr 2026 00:34:34 +0200
Message-ID: <20260409223436.1887988-5-snowwlake@icloud.com>
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
X-Proofpoint-GUID: HdqTIsLjanfCzdreGKM4hW60-mkcGHO3
X-Proofpoint-ORIG-GUID: HdqTIsLjanfCzdreGKM4hW60-mkcGHO3
X-Authority-Info-Out: v=2.4 cv=BZ7VE7t2 c=1 sm=1 tr=0 ts=69d829a4
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=LbuW6tbUWPcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=v3ZZPjhaAAAA:8
 a=_7PiEvq1_GSvmz9hKDsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=JKcXVnpmuwdQ7RL0mgk_:22 a=5Q-93EyGrU3sW_9myDOF:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDIwOSBTYWx0ZWRfX4iUYDphLCofg
 3jOpr/sy0Kyu78wIHHnO5jRq2385LdxloMaBz1uh4T9hwBWqiBDsFt1DKnnHAJuxt5uzFy2T5EH
 YCZlEGUcPqsrGsYdqcVT9goRJxJjN00LyCut5Zo3pf8OZdpk2JJSqkz1ZzFQLf+wPtwTndclfG2
 PJrJrXITmZmTJDBvIGg7PeGT7W8ZmTlJ8K2xg3YFdtUVu5VO6rscLQX0K+UJ8ESuzrRaH+BDQVY
 A+vsibnsze21LEG6JU45CKkKWcfcXDNOllVEVTaVDsiVJuXOVyFboSxPF8UnDGrUNZx0kG9HzhL
 Y3VUb/yC6kQLVE8tvB/IMkHw/655Gq3mrni48Z+Lv2N04mJJZK5TPn+kKQpgo8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0 clxscore=1015
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604090209
X-Spamd-Result: default: False [-0.57 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.59)[subject];
	DMARC_POLICY_ALLOW(-0.50)[icloud.com,quarantine];
	R_DKIM_ALLOW(-0.20)[icloud.com:s=1a1hai];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34560-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,linaro.org,icloud.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[icloud.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[snowwlake@icloud.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[icloud.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,icloud.com:dkim,icloud.com:email,icloud.com:mid]
X-Rspamd-Queue-Id: 814F53D04A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

digital_tg_recv_dep_req() guards against short frames with:

  if (resp->len < size ...)   /* size = sizeof(struct digital_dep_req_res) = 3 */

This guarantees resp->len >= 3 (dir + cmd + pfb).  However, when the
DID bit is set in pfb, the code immediately accesses resp->data[3] — the
DID byte — which is one byte past the guaranteed minimum:

  if (DIGITAL_NFC_DEP_DID_BIT_SET(pfb)) {
      if (ddev->did && (ddev->did == resp->data[3])) {

A remote NFC-DEP initiator can trigger this with a 3-byte DEP_REQ frame
that has the DID bit set in the PFB field, causing a 1-byte
out-of-bounds read of kernel heap memory.

Increment the minimum required length to 4 when the DID bit is present
before accessing resp->data[3], mirroring the pattern used for the
size++ / check at the end of the DID block.

Fixes: 7d0911c07b44 ("NFC Digital: Implement NFC-DEP target TX and RX")
Cc: stable@vger.kernel.org
Signed-off-by: Lekë Hapçiu <snowwlake@icloud.com>
---
 net/nfc/digital_dep.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/nfc/digital_dep.c b/net/nfc/digital_dep.c
index XXXXXXX..XXXXXXX 100644
--- a/net/nfc/digital_dep.c
+++ b/net/nfc/digital_dep.c
@@ -1117,6 +1117,11 @@ static int digital_tg_recv_dep_req(struct nfc_digital_dev *ddev, void *arg,
 	pfb = dep_req->pfb;

 	if (DIGITAL_NFC_DEP_DID_BIT_SET(pfb)) {
+		if (resp->len < size + 1) {
+			rc = -EIO;
+			goto exit;
+		}
+
 		if (ddev->did && (ddev->did == resp->data[3])) {
 			size++;
 		} else {
--
2.34.1

