Return-Path: <linux-wireless+bounces-33271-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePi7Ck6St2k0TAEAu9opvQ
	(envelope-from <linux-wireless+bounces-33271-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 06:17:02 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C846F294BB2
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 06:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B694A300C9AD
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 05:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31F633F384;
	Mon, 16 Mar 2026 05:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Wpdqn+5q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from outbound.mr.icloud.com (p-west2-cluster2-host6-snip4-10.eps.apple.com [57.103.68.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1F4340A51
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 05:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.68.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773638217; cv=none; b=t0uceNf2v/Jyi79VC27QMYz1VDCVnBZFl+4LpGQWP1TuttqcN/VmneaKFya2hPQzciQPts9vcO7T51CmVvFDMJLMjyG64diW2+PGJBCaWiLpE7OyKLf33znFtcOL7wdpRGMLypBWniF3U8+VUd4bhWLzeYxM+6HCAeA582eeViQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773638217; c=relaxed/simple;
	bh=7ohb/arrOb55/Hsewxm+6JZ7Uyj0VDvOcavCaLN4pHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C0LhM6hNkisnuN0p1RjYImUbZPCmOfDEVUKVbtAs9NwIZmhhKBHvkW2opDbcGl92k/px5Zo8shBTnHaoIwnOJYvHxTcrugm1OuO01RNBf4mXE2vFZxifiWQOc/NwQqTCB1SwN9hbDPfnt6aKHGjIckk33cmUHUcpjByHylb0R74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Wpdqn+5q; arc=none smtp.client-ip=57.103.68.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-8 (Postfix) with ESMTPS id D6A661800162;
	Mon, 16 Mar 2026 05:16:53 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1773638214; x=1776230214; bh=C1KJTk5uhA3aGaltAT/bauWS34H0fThITdz2W/aMU0Q=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=Wpdqn+5qrbjEbD76o7n+XQfXmpPU/topZXRpEUe3ATOlovfMJMF5Lj+KUplvIVewIcHELrt86jsxsLxjs5DijwhG+xl6gUfCi0oHZ7e/V+pgCsdcyzUx7LrCiJ2lcgTuF4JDyNvzj5nBAe5HXn5ZCFqjM7f3xrott0FE26BrJDHZOuaEL/kyt3mvXyAq2kWrTdZhBVLuMvTuiWMiomRxOaDFYXMaHwXDutjlKJ+j0m7LpsMjWchq8JxH3tYlZ985SYxJPnqVhXWW/OBICrXNptImYMfkDNn7k6DSZOHL0hRZNYdadusbMjYKNkbZ6WFEoBB3l249NwAgorjJnwST5A==
Received: from arrendajo (unknown [17.57.152.38])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-8 (Postfix) with ESMTPSA id 5F4DF18000B4;
	Mon, 16 Mar 2026 05:16:53 +0000 (UTC)
From: Alex Gavin <a_gavin@icloud.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Alex Gavin <a_gavin@icloud.com>
Subject: [PATCH 1/2] iw: scan: rename OWE Transition parsing function
Date: Sun, 15 Mar 2026 22:16:45 -0700
Message-ID: <20260316051646.18303-1-a_gavin@icloud.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=XqP3+FF9 c=1 sm=1 tr=0 ts=69b79246
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=Yq5XynenixoA:10 a=x7bEGLp0ZPQA:10
 a=h3XwevFeXowA:10 a=VkNPw1HP01LnGYTKEx00:22 a=v3ZZPjhaAAAA:8
 a=D9qfrYdDo-BYakAvmMcA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
X-Proofpoint-ORIG-GUID: Rng8duJ8tk_E6ojEQ253NrZoakb-6A8q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDAzOCBTYWx0ZWRfX5SS01ZRy+JwT
 eTFUGixb1fanASMYw+hMAymi2c8/jZS5Y1sfqgJ1K6PHRFzH6JXZqHljptcORVHwPKU1LY/jRoR
 B3T6AsGbrRL/TCJWaYGFk+KL7c17DgOpgiG+QyQcguRt/yMNA/Gu7Z4BE8PLFFvKwsotT4lArxk
 SCRlNaI52lUUyahPiCsSXjv5Th761mPIr1ZIIhOytyYi28nWlUeHqAu2m+aozng4ntWnp89crts
 +lvdPK7CabB+fl8UuX1RNHOnPU4f/QKpc7R1Itacw0O8IKS7RzAF5SD6jQI3zsklT8UMFll+ayb
 pC2mZrP+DC9X7G5ckmsqFGAQJKNGowrpit/q5Ur0ywFHlFTRthsKaH7U8sY9p4=
X-Proofpoint-GUID: Rng8duJ8tk_E6ojEQ253NrZoakb-6A8q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 suspectscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603160038
X-JNJ: AAAAAAABM0HCVFPJFJ4WiLQ7iAhsNhGybxTjIEbpB9cr5fxdqle5+V9XdsIDQZIsdZoW/+hZcJWY+esIvkgO3R3H7Yf4dGfagCoakU7s8SMcc8hEnGkaI05/uMCc3AsHgLPn1byUYqWbLcuMkem7f8MLITCnwNmEvGfMC2h/uYj1WXRz13e8qdazN5fwM29/o1wvJ+s4X8lpwUXH/2Tc8IZxbASboijb8Yf/uDkjzJAQagsaONPDY72IM9qaf8l60LjT3GT5LHgpgVEr43FCZObbyBR3DS5ER2JQ29NnB0AeGjdwvEto3ZAPn80XiZJTMhEAPO2/CGmwji25XjTyTEgJU8cfKZPl0ziRPvFfzd2JB64LJ800PLltMFz9iEyhbtrbyO99G1ZNctNANWCuoLjytuK40SiDrApwvXTrCrsImLdiT2Kzm9aPA+7SF6WKgFDqhtwah7WGvqncUOOVqMNVvRiEjkER2Tebohg9lh36+rBpcpsNDj94SabV1vllmL8oYQzYfpL+QjmDBtJC5ucb886VWvVnALmxg31ZOVro3QN6JQoPttkDaso7/CoZErALrMN3PQh4d3WwVE9ArSbiy156BtCbIDsudIp8q3qLUs222sd1EundqRGZCxsu8TS9L0o9QVrZk7Q6vVknj2eZI5kk/OMX7AQ=
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[icloud.com,quarantine];
	R_DKIM_ALLOW(-0.20)[icloud.com:s=1a1hai];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,icloud.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33271-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a_gavin@icloud.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[icloud.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[icloud.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,icloud.com:dkim,icloud.com:email,icloud.com:mid]
X-Rspamd-Queue-Id: C846F294BB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Signed-off-by: Alex Gavin <a_gavin@icloud.com>
---
 scan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scan.c b/scan.c
index facb503..4d3284e 100644
--- a/scan.c
+++ b/scan.c
@@ -2311,7 +2311,7 @@ static inline void print_hs20_ind(const uint8_t type, uint8_t len,
 		printf("\t\tUnexpected length: %i\n", len);
 }
 
-static void print_wifi_owe_tarns(const uint8_t type, uint8_t len,
+static void print_wifi_owe_trans(const uint8_t type, uint8_t len,
 				 const uint8_t *data,
 				 const struct ie_context *ctx)
 {
@@ -2343,7 +2343,7 @@ static const struct ie_print wfa_printers[] = {
 	[9] = { "P2P", print_p2p, 2, 255, BIT(PRINT_SCAN), },
 	[16] = { "HotSpot 2.0 Indication", print_hs20_ind, 1, 255, BIT(PRINT_SCAN), },
 	[18] = { "HotSpot 2.0 OSEN", print_wifi_osen, 1, 255, BIT(PRINT_SCAN), },
-	[28] = { "OWE Transition Mode", print_wifi_owe_tarns, 7, 255, BIT(PRINT_SCAN), },
+	[28] = { "OWE Transition Mode", print_wifi_owe_trans, 7, 255, BIT(PRINT_SCAN), },
 };
 
 static void print_vendor(unsigned char len, unsigned char *data,
-- 
2.51.2


