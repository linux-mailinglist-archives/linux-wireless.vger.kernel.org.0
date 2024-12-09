Return-Path: <linux-wireless+bounces-16072-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7103F9E9AD8
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 16:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E570280A9C
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 15:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC7C25777;
	Mon,  9 Dec 2024 15:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dipier.ro header.i=@dipier.ro header.b="UoUy1K3D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from qs51p00im-qukt01072501.me.com (qs51p00im-qukt01072501.me.com [17.57.155.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5562F12DD88
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 15:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733759240; cv=none; b=BK8x/E3SP2xfAV59aUwJFlbSoLsFfM4wDe1ORkkLOafO7FcWC83QmlpcNt//et8A3NyuXjAUTqHEmb3G49Rbk5IMyD6cgcC3AQE9ORU68wZ2qmkeETSxL6tY/DwmOcdkyZo0KXZ4j0fon8tmilmm1rPTSHDX8aaeughbTIfSkJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733759240; c=relaxed/simple;
	bh=z9MoGV9v8S6xE4IPLFplZaKql3sbpYbhsxHnjvU94gk=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=QmxNdRfLrK6rxx1nrdACw4LALfTvXxBLJdKFUj9g1mY0HlwKDniVv7RBCvSGx/3vh7XAXh093jn5/fCTRm8f2v4MH7AWvPyF5GIrtr+KOpE5cWMk27zgBTTpWhH9kcGDUfFCHMkZdnv/JxsuyHbUyiooKaXWbfcKf+ZpuEp9Iwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dipier.ro; spf=pass smtp.mailfrom=dipier.ro; dkim=pass (2048-bit key) header.d=dipier.ro header.i=@dipier.ro header.b=UoUy1K3D; arc=none smtp.client-ip=17.57.155.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dipier.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dipier.ro
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dipier.ro; s=sig1;
	t=1733759236; bh=D9xNsw0Z721VfzeMUB/1PkzJCgqS1qTp/54moOOD5l4=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To:
	 x-icloud-hme;
	b=UoUy1K3DRtzGe/vn6duteCCDj8xEAZcxVPk266991Vb5k+PkL5wbmP40k8XhtHO9D
	 ncQCkTbLbiyThRkHznA1GXdrv13q21jyxYUiggmmvnVutj6WM+fAvSirFIGow1Hk8k
	 OJIN35VCRwR4TRdumrWa7HVZPVISznm+kdpMt3l24BYX1zWxhG7V11uzNnLx0R694m
	 S5rAjhLdDNeh5JYroB/Wvg6xjN0FY1ASON2+ai+ofoeC3FvLgKqW59L/h2DJR3WxNL
	 08XfYD5iPqD7JtKBQl3JFA2w/9QXX5RiiSxCFpNIvGHCJvM9SA5PgO47Wp+sthmDZS
	 iRsmes7to9m6Q==
Received: from smtpclient.apple (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01072501.me.com (Postfix) with ESMTPSA id 23E6944044C;
	Mon,  9 Dec 2024 15:47:14 +0000 (UTC)
From: tina@dipier.ro
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.2\))
Subject: wireless-regdb: Update regulatory rules for Armenia (AM) on 2.4 and 5
 GHz
Message-Id: <274D81C2-56C7-4042-96F9-A04A92BEAEFD@dipier.ro>
Date: Mon, 9 Dec 2024 19:47:02 +0400
Cc: wireless-regdb@lists.infradead.org
To: linux-wireless@vger.kernel.org
X-Mailer: Apple Mail (2.3826.300.87.4.2)
X-Proofpoint-GUID: UuWCcrbY94N62xca04BbdLA8e3rv5caQ
X-Proofpoint-ORIG-GUID: UuWCcrbY94N62xca04BbdLA8e3rv5caQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_12,2024-12-09_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 clxscore=1030 phishscore=0 adultscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412090123

Public Services Regulatory Commission of the Republic of Armenia has =
released two amendments to its 2011 Decision =E2=84=96169=D5=86 on =
Approval of the Procedure for Issuing Permits for the Use of Radio =
Frequencies.

1. Amendment =E2=84=96159=D5=86, on permit of usage of radio frequency =
ranges without permit, released on May 11, 2012, available at =
https://www.psrc.am/contents/document/4749 (choose language =E2=86=92 =
HY)

<=E2=80=A6> Based on Article 5, Part 1, Point 1(d) and Point 2(b), =
Article 6, Part 1 and Part 2, Point 1, and Article 17, Part 5 of the Law =
of the Republic of Armenia "On Electronic Communication," as well as =
Article 70, Part 1 of the Law of the Republic of Armenia "On Legal =
Acts," the Public Services Regulatory Commission of the Republic of =
Armenia decides:
To amend Points 4 and 5 of the annex to the decision =E2=84=96169N of =
April 13, 2011, by the Public Services Regulatory Commission of the =
Republic of Armenia titled "Approval of the Procedure for Granting =
Permissions for the Use of Radio Frequencies," by restating them with a =
new wording. <=E2=80=A6>
"4. No permission is required for:
<=E2=80=A6>
9) The use of broadband wireless access equipment operating in the =
2400=E2=80=932483.5 MHz radio frequency band with a power of up to 100 =
mW.
<=E2=80=A6>=E2=80=9D


2. Amendment =E2=84=96295-=D5=86, on permit of usage of radio frequency =
ranges without permit, released on August 23, 2023, available at =
https://www.psrc.am/contents/document/11375 (choose language =E2=86=92 =
HY)

<=E2=80=A6> Based on Articles 33 and 34 of the Law "On Normative Legal =
Acts," the Public Services Regulatory Commission of the Republic of =
Armenia decides:
To amend Subpoint 10 of Point 4 of the annex to Decision =E2=84=96169-N =
of April 13, 2011, of the Public Services Regulatory Commission of the =
Republic of Armenia, titled "Approval of the Procedure for Granting =
Permissions for the Use of Radio Frequencies," as follows:
"10) For the use of local network equipment operating in the 5150-5350 =
MHz and 5470-5875 MHz radio frequency bands with an effective radiated =
power (e.r.p.) of up to 100 mW (only indoors, as well as in airplanes =
during all phases of flight), utilizing dynamic frequency selection =
(DFS) and transmitter power control (TPC).=E2=80=9D <=E2=80=A6>


Essentially, this two documents define this frequencies as permitted:
- 2400 - 2483.5 MHz @ 100 mW
- 5150 - 5350 MHz @ 100 mW with DFS, outdoor usage forbidden
- 5470 - 5875 MHz @ 100 mW) with DFS, outdoor usage forbidden

However, I am not sure if AUTO-BW option here is required. As far as I =
know, there is currently no limitation on bandwidth usage in IEEE 802.11 =
set of protocols in Armenia.

---
db.txt | 10 +++++++---
1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/db.txt b/db.txt
index e282e3b..5d5ba22 100644
--- a/db.txt
+++ b/db.txt
@@ -81,10 +81,14 @@ country AL: DFS-ETSI
	# short range devices (ETSI EN 300 440-1)
	(5725 - 5875 @ 80), (25 mW)

+# Source (in Armenian):
+# 2.4 GHz https://www.psrc.am/contents/document/4749
+# 5 GHz https://www.psrc.am/contents/document/11375
+
country AM: DFS-ETSI
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 20), (18)
-	(5250 - 5330 @ 20), (18), DFS
+	(2400 - 2483.5 @ 40), (100 mW)
+	(5150 - 5350 @ 160), (100 mW), NO-OUTDOOR, AUTO-BW, DFS
+	(5470 - 5875 @ 160), (100 mW), NO-OUTDOOR, AUTO-BW, DFS

country AN: DFS-ETSI
	(2402 - 2482 @ 40), (20)
--=20
2.45.2=

