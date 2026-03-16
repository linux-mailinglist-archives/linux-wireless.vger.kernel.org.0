Return-Path: <linux-wireless+bounces-33272-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAxROVKSt2k0TAEAu9opvQ
	(envelope-from <linux-wireless+bounces-33272-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 06:17:06 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A97CF294BB9
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 06:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 83A0E300E163
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 05:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F78233F8C1;
	Mon, 16 Mar 2026 05:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="XssW/4zb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from outbound.mr.icloud.com (p-west2-cluster2-host8-snip4-8.eps.apple.com [57.103.68.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECA4340DAB
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 05:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.68.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773638220; cv=none; b=JKcFB1k0bMxmy56pUWthjKpYckwFD5qjOWvSka3NCkg2atx753a/kf0wkdW1KjGuXhB5R/Ia4VI7RcVaK3eLSrYSs7yqQfnxv5fcQDY7u7WcCZ0E7zHr3u86CeiPOgfxbxpnmS/OZpnrrJJ74zRrGeaLo/fJLETZEmFM5Z6L9ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773638220; c=relaxed/simple;
	bh=yYRyJmHwYLpji+5oZQv0xFKk9Q+7CASUcxKrakMwXQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/yPpkzpQldSCdRCyofoXZgzvXFkvlSUzWwgz5Aa+50hPxHLcgBoTL8RAtr62zBNMBI9/3VZ6s4Dxi39d53165X8zPeM2YiI95Gb+3u6Hhv39tKGp5f0ecsOtev6jR6Zo5C/DjD+zhYvkR6VQnnhjq3gAdliw2nAIXQp1vVvqu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=XssW/4zb; arc=none smtp.client-ip=57.103.68.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-8 (Postfix) with ESMTPS id E28C418000BD;
	Mon, 16 Mar 2026 05:16:54 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1773638217; x=1776230217; bh=Pk0fJtrQ8f1xVoRQkblSvTNc6wCWoeBxQZjBUEQF898=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=XssW/4zb4tz5xzx5o0AwDQ3+/psokAly0D/oZKf2EsLSdq+wGYYBgiBjxkZytHHUC92mpx++ZmH/q4QDOzgK5/N6B/AU4cNTrkNMmEfP9zIRZkoVYQvd8kRmpOw0/5r6IGzxDCUroA9fy87wn6JbNN6npbTCeXdUIZ7uV0I6VyMv+/WU0qZXwOcPWdGk9l0tr23XKAsTemmOObvUJZw+1krI1RBZOEmfwwgk2dcStu+Py+cS4VRjfR5ipvz0qm7iwwJUO2V1BElwMLUN1D55Yq+zAVUfRpn8iQPrK6vaVfRGC8vmglmqoe6W+zOc1emjq/1MCAA1uBAoUHIzSra+EA==
Received: from arrendajo (unknown [17.57.152.38])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-8 (Postfix) with ESMTPSA id 0C1D718001CD;
	Mon, 16 Mar 2026 05:16:54 +0000 (UTC)
From: Alex Gavin <a_gavin@icloud.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Alex Gavin <a_gavin@icloud.com>
Subject: [PATCH 2/2] iw: scan: print RSN Element Override IEs
Date: Sun, 15 Mar 2026 22:16:46 -0700
Message-ID: <20260316051646.18303-2-a_gavin@icloud.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260316051646.18303-1-a_gavin@icloud.com>
References: <20260316051646.18303-1-a_gavin@icloud.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDAzOCBTYWx0ZWRfXwXNdMah1vGof
 duNQb93ZcwyCepcASvcZQqyXz+rWGz+vVfD9OloGoh0XTYo7amgYf+9enTfIo9f7FWitJNkCu0/
 5BI0W4hg58gJwIzG1mPL5FM0BW5n7OK0G4dlBV8Q2NGmDWb5ZUnFpQrRRftrMsGb0A0kJLI3Mov
 t3V/M0IkeHqpvUEfL7g4EBMbvH8W69JqPy3qIOftqiLr3vjebM6r+Olmq605G1NhG7VdkJzn6ad
 GhIEitANFmB8dtPu6Tv0u6hQg4rq/wwVQ4/sofNqPNw22mCs3yKhbiJZuEzFc/xmLfyVHQPlva2
 1TW/4Jol+OD5oq5fZGSgnMOAGWND+aaXZ1C4qo+FYBxK9aUgFnGdHwdjLjH0Tg=
X-Proofpoint-ORIG-GUID: f8NREl8ljr3Fmto1U9ca9MSKod9BxvsG
X-Authority-Info-Out: v=2.4 cv=d7L4CBjE c=1 sm=1 tr=0 ts=69b79247
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=Yq5XynenixoA:10 a=x7bEGLp0ZPQA:10
 a=h3XwevFeXowA:10 a=VkNPw1HP01LnGYTKEx00:22 a=v3ZZPjhaAAAA:8
 a=OXzpSoV8y9OLGlExBMsA:9
X-Proofpoint-GUID: f8NREl8ljr3Fmto1U9ca9MSKod9BxvsG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 adultscore=0
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603160038
X-JNJ: AAAAAAAB+QQ4fM9l2XizPJq/IMWdch/c1K+d3JcIoV7ZQrVlJj+qCD+ZIRRtIyyOUXeRFzBdZWtPgJYVWP0DJ/1ah0zVwhKCQ73igT3IxSIbk8ynltqqh1atvrXYA4p8izlxay0HEMitujRXQbVUDubYxxi99VPK68GMz7MNgkA9j3mgI1Rv1+Rn9dSwzvIbsTgRLkDCC8Siw7Ueii1iKiIVyXwBtnwhkCitf8zjWECohpgODuUjHAyfaQgm7tJixzkIFTK1+XBLoUDFjcojiVn1F8i2FxsojBRQCfdy5N8Zmeb6/yVO9CWjZERCfbeuF09ZVwfxWCPhjWUUqrpdqCbSl8PK+dBhslFX7Br9OrrLc+cfd4kDxBoh31x00JICThOt/SkBQD6Ml9jdszA44nThOEJlQ1tfh+/V9rowwfQYB0Cqc2LwylrdPpkSxGS7JDAU4Yqz7Zf8QyHkl+7w/+a4/O/VVcv2mJriYTVwkrKful8uTIXeIYYP4dYK4Fy8VyCYWTQQV/AeOKQPPXkbhwKSqWOMFRWN7+xruoJRB297h919Y6UgEVTN4NzXDGE90RDTV6doUlYq+4UT6mN6nSkG2RYX4F8imfHrULRkDjfV6UEeL97Tk3wbLhY5nG7PSfaD/NuFKj4hJmBr9eaw1WMB1lvJV0ebaug=
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
	TAGGED_FROM(0.00)[bounces-33272-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[icloud.com:dkim,icloud.com:email,icloud.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A97CF294BB9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Parse body of RSN Element Override IEs as RSN IEs
using existing code.

RSN IEs are a minimum size of 4 octets, as detailed
in IEEE802.11-2024, 9.4.2.23.1

Example output:
RSN Element Override:
	 * Version: 1
	 * Group cipher: CCMP
	 * Pairwise ciphers: CCMP
	 * Authentication suites: SAE
	 * Capabilities: 16-PTKSA-RC 1-GTKSA-RC MFP-required MFP-capable (0x00cc)
RSN Element Override 2:
	 * Version: 1
	 * Group cipher: CCMP
	 * Pairwise ciphers: GCMP-256
	 * Authentication suites: SAE-EXT-KEY
	 * Capabilities: 16-PTKSA-RC 1-GTKSA-RC MFP-required MFP-capable (0x00cc)

Signed-off-by: Alex Gavin <a_gavin@icloud.com>
---
 scan.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/scan.c b/scan.c
index 4d3284e..2b6e904 100644
--- a/scan.c
+++ b/scan.c
@@ -1893,6 +1893,14 @@ static void print_wifi_osen(const uint8_t type, uint8_t len,
 	print_osen_ie("OSEN", "OSEN", len, data);
 }
 
+static void print_wifi_rsn_override(const uint8_t type, uint8_t len,
+			    const uint8_t *data,
+			    const struct ie_context *ctx)
+{
+	printf("\n\t");
+	print_rsn_ie("CCMP", "IEEE802.1X", len, data);
+}
+
 static bool print_wifi_wmm_param(const uint8_t *data, uint8_t len)
 {
 	int i;
@@ -2344,6 +2352,8 @@ static const struct ie_print wfa_printers[] = {
 	[16] = { "HotSpot 2.0 Indication", print_hs20_ind, 1, 255, BIT(PRINT_SCAN), },
 	[18] = { "HotSpot 2.0 OSEN", print_wifi_osen, 1, 255, BIT(PRINT_SCAN), },
 	[28] = { "OWE Transition Mode", print_wifi_owe_trans, 7, 255, BIT(PRINT_SCAN), },
+	[41] = { "RSN Element Override", print_wifi_rsn_override, 4, 255, BIT(PRINT_SCAN), },
+	[42] = { "RSN Element Override 2", print_wifi_rsn_override, 4, 255, BIT(PRINT_SCAN), },
 };
 
 static void print_vendor(unsigned char len, unsigned char *data,
-- 
2.51.2


