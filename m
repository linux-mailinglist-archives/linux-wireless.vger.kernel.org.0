Return-Path: <linux-wireless+bounces-29569-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FA3CAB2EF
	for <lists+linux-wireless@lfdr.de>; Sun, 07 Dec 2025 10:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10058303BE2E
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Dec 2025 09:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1C32D2496;
	Sun,  7 Dec 2025 09:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fitzsimons.org header.i=@fitzsimons.org header.b="k0+vexUG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from outbound.st.icloud.com (p-east2-cluster6-host8-snip4-7.eps.apple.com [57.103.76.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AF12BE64A
	for <linux-wireless@vger.kernel.org>; Sun,  7 Dec 2025 09:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.76.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765098405; cv=none; b=oO+HrqH4n5zintACudcJFNwF0ygV5HIPqlOXal8LZ8QdwZg/WnzbRRZVmgbedqVZj2yFW9EgdDCktDhQubvFzc3p6WZ6FOkxfRzhlgOFr3FbM33D5ECr9D+SlsyO2CSVAyXwJWPXJPBKZMnOGn/ZdmydKoBkU0wzGx/flwtecdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765098405; c=relaxed/simple;
	bh=nhKRfSiTuHFmVZTemuR4DkqvKJdceChAwp7TaE1vHEw=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=OSeAgLGaXMZXi4BWCuL8DI/iUx9jkJFiq507lWefQZ35DZB/rBLQLqT9RG7g3vgN2DRcMn7wo5zjqaMkST7VGZyd6ZTyIgtCiucR/ZtM4hCklIn4TBMRE/l4SJZgu2V+N1yinBrDyDByAyxgrZKvZlUTFw72uh3Brc7I/GJihCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fitzsimons.org; spf=pass smtp.mailfrom=fitzsimons.org; dkim=pass (2048-bit key) header.d=fitzsimons.org header.i=@fitzsimons.org header.b=k0+vexUG; arc=none smtp.client-ip=57.103.76.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fitzsimons.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fitzsimons.org
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-20-percent-0 (Postfix) with ESMTPS id CBA691800847;
	Sun,  7 Dec 2025 09:06:39 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fitzsimons.org; s=sig1; bh=XAwaXzA72i2OABbnVn/1OPV8ALoYBoEA85sTcU8ejAQ=; h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To:x-icloud-hme; b=k0+vexUG6Gbh/Il1Oh8EFCBLJb5Xd+ZEga7UmZ4DoftEYF1QbUQT2NNM8X00nKHlTmZmlEe7b2K6PWSHrHJuGsLNLAKQ3WQihDGxNBSQdjBdFhopjRXaQ/vAl8I+rQvLRjTjcNhSA2ZGFMWer9P7ECXECH4yzMTAI8dBLzc3UvKteOQzDU5W1DLZ2kwZKQnrQBON+/I2Be5EQwBL9AFfB5oNz5DDf7qSBmJNwAlbcAQY0+qFVOZItuMht8eP1y4W0GUiCe4L3wzQhOq2PYnEzlsugsYCmUF0kD/LlCSypNzNaFHxazjO/7Id1+d3lsNTL3gMOg4omDgjmg+vzuGrWw==
mail-alias-created-date: 1311470795000
Received: from smtpclient.apple (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-20-percent-0 (Postfix) with ESMTPSA id 390921800841;
	Sun,  7 Dec 2025 09:06:38 +0000 (UTC)
From: bruce@fitzsimons.org
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.200.81.1.6\))
Subject: [PATCH] wireless-regdb: Update Australia (AU) 6 GHz band to 6585 MHz
Message-Id: <C9C14F68-BFFF-4BF6-A8AA-60E5EB445F4E@fitzsimons.org>
Date: Sun, 7 Dec 2025 20:06:24 +1100
Cc: wireless-regdb@lists.infradead.org
To: linux-wireless@vger.kernel.org
X-Mailer: Apple Mail (2.3864.200.81.1.6)
X-Proofpoint-ORIG-GUID: u2L9pU0s9iWJxRCOk36IeA8Ezo43O-rS
X-Authority-Info: v=2.4 cv=U4ufzOru c=1 sm=1 tr=0 ts=693543a0 cx=c_apl:c_pps
 a=YrL12D//S6tul8v/L+6tKg==:117 a=YrL12D//S6tul8v/L+6tKg==:17
 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=wQCEfU45AAAA:8 a=eimVCs3WAAAA:8 a=W57TY44-DrvBiHQ3VEYA:9 a=CjuIK1q_8ugA:10
 a=Oo_Imr1wRfQDNlTC4xgs:22 a=uDxkDUTIKcfgtb66RLhl:22
X-Proofpoint-GUID: u2L9pU0s9iWJxRCOk36IeA8Ezo43O-rS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA3MDA4MCBTYWx0ZWRfXyFkPFhei6xn4
 jdBH526e4OIhPoelTiWhMgNine5gF3rxkNkdRzoZ2Jz4Wl8aUFExwTWwgotZzEbIDi9tta7LKII
 qgsNz8rUrESxNwnY0t01HkA+aRVdZgUjU90tEzsTKhM/rGOGFHFvMFol3u5XZ0luXBW13+i1U76
 rA7pg8nNbMI/7qcMWSUv1YhntUFZGUADFbi8++ZmeGHYVFsPyJrHk11brtcdZEkSn2FtUQ2ni/W
 7hnA6zO8d45Sdk/4NbIDKhbgepVbw1dTT12U8L8SCDtWwmw3SE06ci1y0uuxIA+XgZahKKnlPZp
 p7wD42GAd0fCojOMkMx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=898 mlxscore=0 spamscore=0 suspectscore=0 clxscore=1030
 phishscore=0 bulkscore=0 malwarescore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512070080
X-JNJ: AAAAAAAB4rpRfKeJ8UIGI47zFpUzvQepYU12/QJMg0B5LpJY3ugBEPnhgPOj6/8YOPLYKUnN3+aFFbldKXH3oPIgoe5AqxJwbGh3WkMJ+OVDhjVLFdeTx0k/C1+yJfVyibf2r3oe+Byx3+s7gHKEtMguy5W6P7xKTrKAUu7OPqB1DpykggqLxPOtDHKQac810BNNIa4iC42ZVIydaZKSUJprjrE88pTLVuXMNRAT3D1A4J6eDJ8nPIpvWAltQWsczZbUnXJ4gMQ7Fs89XlL4Pi9hybOBJiBjmQ9sXKiOTwOQEHQJtrE35KI49HrhL7VfwTzsTk7Ybor65BCCKr8OCJOf0r6vicygofl09qxmFvcrFKoUmY2IJh1BifXinPkwnw396P0/qFjxw8BYlVA59ScBzNMCkEggHKdYPgnB/ljAud+oH5OWOFIF/93stgGJmo1asm1j61NKxxXRKODkwrRKed57k+tb7VxiDNKZLznq6wLB0gdvr/F1kWi2evJzIukQWi3yUnw3A/kjXazaqDmnDzwVPnJFv1ZX+tx9o1dpD6dXaD0XdQRf83bMP+gdFhfvdZVAILy2ZsuKAgZtmStGCcAOe5/g/nyQckXH7Ou6QaYqE8N7a0vwVWFOAPLjbMau5glJ+AP9Hg==


Extend the 6 GHz band allocation for Australia from 5925-6425 MHz
to 5925-6585 MHz, adding 160 MHz of additional spectrum.

This change reflects the Australian Radiofrequency Spectrum Plan
Variation 2025 (No. 1), which took effect on 1 October 2025.

References:
- ACMA Outcomes Paper: Future use of the upper 6 GHz band (December =
2024)
  =
https://www.acma.gov.au/sites/default/files/2024-12/Outcomes%20paper%20-%2=
0Future%20use%20of%20the%20upper%206%20GHz%20band_0.pdf

Signed-off-by: Bruce Fitzsimons <bruce@fitzsimons.org>
---
db.txt | 3 ++-
1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/db.txt b/db.txt
index fdc2c13..7eac515 100644
--- a/db.txt
+++ b/db.txt
@@ -159,7 +159,8 @@ country AU: DFS-ETSI
(5850 - 5875 @ 20), (25 mW), AUTO-BW

# Item 63AA (25 mW if outdoors)
- (5925 - 6425 @ 160), (250 mW), NO-OUTDOOR
+ # Extended to 6585 MHz as of 1 October 2025
+ (5925 - 6585 @ 160), (250 mW), NO-OUTDOOR

# Item 65
(57000 - 71000 @ 2160), (20000 mW), NO-OUTDOOR
--=20
2.43.0=

