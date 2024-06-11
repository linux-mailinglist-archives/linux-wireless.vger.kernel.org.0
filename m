Return-Path: <linux-wireless+bounces-8794-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D228E903CDA
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 15:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 435A328625F
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 13:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860CC17C7CD;
	Tue, 11 Jun 2024 13:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=saudiscarffolding.com header.i=@saudiscarffolding.com header.b="S4MHaxN+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from wfbtqsch.outbound-mail.sendgrid.net (wfbtqsch.outbound-mail.sendgrid.net [159.183.70.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1A217C9E5
	for <linux-wireless@vger.kernel.org>; Tue, 11 Jun 2024 13:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.183.70.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718111654; cv=none; b=ZbaP2FClWNWvmSKeWlgDrrsLsLWcLKFz8MpjqgetAPHY8+auhQtdnjPRf0EWdAUcj/Lie0MBJIRuQL+2CBqcqSgZL9A4WKcYjv0RkTQ5+CVIp5mzHx5BGD8stza7sGeDEOE2rIPHEzmKYSC6iLcryNqp8WXYeXTpN7qB6uD79Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718111654; c=relaxed/simple;
	bh=WLkjpUqcQbl+sdaBj9woV059RPnDX6PdKwhMvkZ1Z80=;
	h=From:Subject:Date:Message-ID:MIME-Version:To:Content-Type; b=VBtRRcPnXuNDH33UWbx266qNJDWaC86fD/3oX4wX+y/h+RUkgrooXrZUAodJn9YH2uPjfMPUh2jOPI//QrRYWGnVZfqg5aeAQCaPv5RVQF0v6lpQtcCUENyvrwdocrGM0J5HhLArsHLbOik6cZUFrW+Aw5/uv1zFSexlZZDfAa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=saudiscarffolding.com; spf=pass smtp.mailfrom=em3973.saudiscarffolding.com; dkim=pass (2048-bit key) header.d=saudiscarffolding.com header.i=@saudiscarffolding.com header.b=S4MHaxN+; arc=none smtp.client-ip=159.183.70.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=saudiscarffolding.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em3973.saudiscarffolding.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=saudiscarffolding.com;
	h=from:subject:mime-version:list-unsubscribe:reply-to:to:content-type:
	content-transfer-encoding:cc:content-type:from:subject:to;
	s=s1; bh=WLkjpUqcQbl+sdaBj9woV059RPnDX6PdKwhMvkZ1Z80=;
	b=S4MHaxN+3QYbQ4RN7GcK4INURsj8os3ZrfTaM5sPJcF2dplhCbLwr1HoNdfF35hCHnr3
	zc5G8f2A8xHjS6fKCAsM/dFIUF/bkEdT2IBW6qYn/PamfYCVNj+5Zcs677R38QhJ1LqCpf
	e3mdWMb/bFyOIkXzHBjPO6gV2yZk4e14AWA1uQ33hoiG1g+hg6XLhu/azE2tyVI2TYItbr
	o5WREDx43w5CuMbBWKkExGorDVvgZHVtiwZ9yq1RaI3NIaGBlZszEWEfv2EghsaybMwYrN
	txw6k4kzDG5Xc0nOibJ1HLwZa9Hj2E4rPE/+W1tKFvW54P9N5InWgb49Bi1Jj3kg==
Received: by filterdrecv-8685c87c88-97hd2 with SMTP id filterdrecv-8685c87c88-97hd2-1-66684DA3-26
        2024-06-11 13:14:11.340259374 +0000 UTC m=+3681169.723145465
Received: from 45.76.231.190.vultrusercontent.com (unknown)
	by geopod-ismtpd-2 (SG) with ESMTP id G_62rFnVQD-sTbbHAzIU8A
	for <linux-wireless@vger.kernel.org>;
	Tue, 11 Jun 2024 13:14:11.139 +0000 (UTC)
From: "H.E. Shk. Hamad Al Thani" <h.e.shk.hamadalthani@saudiscarffolding.com>
Subject: Explore Global Opportunities with Qatari Investment Group!
Date: Tue, 11 Jun 2024 13:14:11 +0000 (UTC)
Message-ID: <20240611131411.7567842AD4B4471F@saudiscarffolding.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: h.e.shk.hamadalthani@saudiscarffolding.com
X-SG-EID: 
 =?us-ascii?Q?u001=2EwM1n=2F8Egj9Xg9suzemoeiDT9s0DKXmGod5=2FxJp0FNqOtS9FNU5sj6wLi5?=
 =?us-ascii?Q?H+Iihj=2Fz7RUOiFBjR1xh83Uu=2Fb51Ix1ZLIrnCwY?=
 =?us-ascii?Q?Z+tK7nrsDlNFwmOSQq=2F3e5=2Fb1jcJFYYn4y+6ggE?=
 =?us-ascii?Q?gMjrJq0DpjK+n4=2Fa8ZweNk2WOlzRVgoZ9I38981?=
 =?us-ascii?Q?jep6rrsBNLiLGq5ZqtZGYPxM=2FPxUzGG21hsNqFS?=
 =?us-ascii?Q?RRx6DA6KSk0BPs4ztd9rCAGHuPlhzQBgnEVsBSV?=
 =?us-ascii?Q?0N37mFIIj0AtSJhlI35Xp0sB6=2Fo5w+tz1SVKCWW?=
 =?us-ascii?Q?1hd+I4y1nteUoTj5MEMUDBPLxcelb?=
To: linux-wireless@vger.kernel.org
X-Entity-ID: u001.J0g0Qk8cemlOYuEBJLW52g==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Salaam!

Looking to finance your project anywhere in the world? Look no=20
further! Qatari Investment Group offers a wide range of financial=20
services, including debt financing, loans, and partnerships=20
tailored to your needs.

With flexible loan options available in any currency and for any=20
amount, we empower project owners to turn their visions into=20
reality. Enjoy a generous twelve-month grace period and benefit=20
from our competitive interest rates and extended repayment terms.

We value collaboration and reward referrals. Brokers and=20
representatives who introduce project owners to us receive=20
commissions for their valuable connections.

Ready to take the next step? Contact us today with your detailed=20
loan request, and let's pave the way for success together!

May Allah bless you with good health and sound mind.

H.E. Shk. Hamad Al Thani
CHAIRMAN
Qatari Investors Group (QIG)

