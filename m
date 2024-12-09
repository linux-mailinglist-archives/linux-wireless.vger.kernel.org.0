Return-Path: <linux-wireless+bounces-16073-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5049E9AE7
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 16:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A97EA164B36
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 15:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA68126C05;
	Mon,  9 Dec 2024 15:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dipier.ro header.i=@dipier.ro header.b="ix3vMrLl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from qs51p00im-qukt01072502.me.com (qs51p00im-qukt01072502.me.com [17.57.155.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0749D78C9C
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 15:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733759467; cv=none; b=bteMlSJ5rwY4so/kjQPg+UAkgAC3HjfWsgMEixegUTL0HpHxFd5RNKW+IpZOSQ4ffndMtjGxOS8mxtK7eMSrXGHBUis0ngAURbWSsXTVT581o3uvL8DlWSvOgEvi/pqBQXJfEJGHCuqJ9YoQKidXJQMv9ZbWKq8XKvgRThMwYpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733759467; c=relaxed/simple;
	bh=Q2lhX00dDGxDBus5dwOcsdhnuIvGqR7dxXB5yO8ZEP0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LM+Bfv0an95JYOtFf+Y5BMN38aDG+b/DZTEkGo6Uf3WqAyfP9w2uz52jJn5Ajj2eFIpVhOJ1BUZib5uzGVsqNSaAOytRKWrGAwnl5iyKBzffFuYdxLEX7bSL+MIUE3HVzoLuRw4KLEjhzej5sOQMgreHlMmgRXvjryzPH1GLtjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dipier.ro; spf=pass smtp.mailfrom=dipier.ro; dkim=pass (2048-bit key) header.d=dipier.ro header.i=@dipier.ro header.b=ix3vMrLl; arc=none smtp.client-ip=17.57.155.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dipier.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dipier.ro
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dipier.ro; s=sig1;
	t=1733759465; bh=Q2lhX00dDGxDBus5dwOcsdhnuIvGqR7dxXB5yO8ZEP0=;
	h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:
	 x-icloud-hme;
	b=ix3vMrLlqiaOPhshjrdLipw26cAWYRjWnPrGLPxnpQCItsQA3+usU6azSlnsYnCb0
	 oCuzd1oRqOBlBZPJPv18EGdhNDjgZj7IMKsIzmflIM+236mnfokzbMnA0yHLIBv2r3
	 98xdnoZ3JVdvZGwDuM0Y0wjG8iYsaYAROtQwsFkfH1SPNGiW8j5fFrPYyP1Fdr8VbY
	 mUDi2ANZ+ERFsoUYbIBzEMrG0CHHmDGFQR5c59ibJkLFXaB84nfxY1QnmZ+/VcHHN2
	 eIaWx9i/EEvxrTfjg+DkV34UccLhJDuT02kb+e1C9WYLR3luASY8zJMeBo8fdS9W5K
	 LC6D0WCG/lbjA==
Received: from smtpclient.apple (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01072502.me.com (Postfix) with ESMTPSA id 0D2976EC0462;
	Mon,  9 Dec 2024 15:51:02 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.2\))
Subject: Re: wireless-regdb: Update regulatory rules for Armenia (AM) on 2.4
 and 5 GHz
From: Avgustina DiPierro <tina@dipier.ro>
In-Reply-To: <274D81C2-56C7-4042-96F9-A04A92BEAEFD@dipier.ro>
Date: Mon, 9 Dec 2024 19:50:49 +0400
Cc: wireless-regdb@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <239E2B05-207C-469E-8145-BBFAE151ECA7@dipier.ro>
References: <274D81C2-56C7-4042-96F9-A04A92BEAEFD@dipier.ro>
To: linux-wireless@vger.kernel.org
X-Mailer: Apple Mail (2.3826.300.87.4.2)
X-Proofpoint-ORIG-GUID: aXkWUxGJf4D59HNGWBGSzwHG8PAl-tkg
X-Proofpoint-GUID: aXkWUxGJf4D59HNGWBGSzwHG8PAl-tkg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_12,2024-12-09_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 clxscore=1030 bulkscore=0
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412090124

For some reason, my FROM field was not populated correctly.

If you decide to merge this patch, please use this:

From: Avgustina DiPierro <tina@dipier.ro <mailto:tina@dipier.ro>>

Thank you.

> On 9 Dec 2024, at 19:47, tina@dipier.ro wrote:
>=20
> Public Services Regulatory Commission of the Republic of Armenia has =
released two amendments to its 2011 Decision =E2=84=96169=D5=86 on =
Approval of the Procedure for Issuing Permits for the Use of Radio =
Frequencies.
>=20
> 1. Amendment =E2=84=96159=D5=86, on permit of usage of radio frequency =
ranges without permit, released on May 11, 2012, available at =
https://www.psrc.am/contents/document/4749 (choose language =E2=86=92 =
HY)
>=20
> <=E2=80=A6> Based on Article 5, Part 1, Point 1(d) and Point 2(b), =
Article 6, Part 1 and Part 2, Point 1, and Article 17, Part 5 of the Law =
of the Republic of Armenia "On Electronic Communication," as well as =
Article 70, Part 1 of the Law of the Republic of Armenia "On Legal =
Acts," the Public Services Regulatory Commission of the Republic of =
Armenia decides:
> To amend Points 4 and 5 of the annex to the decision =E2=84=96169N of =
April 13, 2011, by the Public Services Regulatory Commission of the =
Republic of Armenia titled "Approval of the Procedure for Granting =
Permissions for the Use of Radio Frequencies," by restating them with a =
new wording. <=E2=80=A6>
> "4. No permission is required for:
> <=E2=80=A6>
> 9) The use of broadband wireless access equipment operating in the =
2400=E2=80=932483.5 MHz radio frequency band with a power of up to 100 =
mW.
> <=E2=80=A6>=E2=80=9D
>=20
>=20
> 2. Amendment =E2=84=96295-=D5=86, on permit of usage of radio =
frequency ranges without permit, released on August 23, 2023, available =
at https://www.psrc.am/contents/document/11375 (choose language =E2=86=92 =
HY)
>=20
> <=E2=80=A6> Based on Articles 33 and 34 of the Law "On Normative Legal =
Acts," the Public Services Regulatory Commission of the Republic of =
Armenia decides:
> To amend Subpoint 10 of Point 4 of the annex to Decision =E2=84=96169-N =
of April 13, 2011, of the Public Services Regulatory Commission of the =
Republic of Armenia, titled "Approval of the Procedure for Granting =
Permissions for the Use of Radio Frequencies," as follows:
> "10) For the use of local network equipment operating in the 5150-5350 =
MHz and 5470-5875 MHz radio frequency bands with an effective radiated =
power (e.r.p.) of up to 100 mW (only indoors, as well as in airplanes =
during all phases of flight), utilizing dynamic frequency selection =
(DFS) and transmitter power control (TPC).=E2=80=9D <=E2=80=A6>
>=20
>=20
> Essentially, this two documents define this frequencies as permitted:
> - 2400 - 2483.5 MHz @ 100 mW
> - 5150 - 5350 MHz @ 100 mW with DFS, outdoor usage forbidden
> - 5470 - 5875 MHz @ 100 mW) with DFS, outdoor usage forbidden
>=20
> However, I am not sure if AUTO-BW option here is required. As far as I =
know, there is currently no limitation on bandwidth usage in IEEE 802.11 =
set of protocols in Armenia.
>=20
> ---
> db.txt | 10 +++++++---
> 1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/db.txt b/db.txt
> index e282e3b..5d5ba22 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -81,10 +81,14 @@ country AL: DFS-ETSI
> # short range devices (ETSI EN 300 440-1)
> (5725 - 5875 @ 80), (25 mW)
>=20
> +# Source (in Armenian):
> +# 2.4 GHz https://www.psrc.am/contents/document/4749
> +# 5 GHz https://www.psrc.am/contents/document/11375
> +
> country AM: DFS-ETSI
> - (2402 - 2482 @ 40), (20)
> - (5170 - 5250 @ 20), (18)
> - (5250 - 5330 @ 20), (18), DFS
> + (2400 - 2483.5 @ 40), (100 mW)
> + (5150 - 5350 @ 160), (100 mW), NO-OUTDOOR, AUTO-BW, DFS
> + (5470 - 5875 @ 160), (100 mW), NO-OUTDOOR, AUTO-BW, DFS
>=20
> country AN: DFS-ETSI
> (2402 - 2482 @ 40), (20)
> --=20
> 2.45.2



