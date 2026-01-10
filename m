Return-Path: <linux-wireless+bounces-30623-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50528D0CD70
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jan 2026 03:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7635230092B8
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jan 2026 02:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F44F17B50A;
	Sat, 10 Jan 2026 02:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="nEVbQdaJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA29A50097D;
	Sat, 10 Jan 2026 02:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768012260; cv=none; b=IPu/qB1Q9RuAqvSz5D27gWLF1gZh2UN4kab11HRp7zHeKDC8IF42O2vo8xkpZt34lHtexp+i+lVeR3owEt4G2ddXKZymeSMgOmE3yd6daNX8RFrDDWVWoioazMqnAurwQtlciWyGwEPYcE92232HjG9rFlhIQxyLjhsUsf/UAd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768012260; c=relaxed/simple;
	bh=RBf3Oxf9ZkNT+HIo3GdEkFqVzo4tPshMeIbuRQUKih0=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=a0k/X2vzMnIZ3z0QaLIEq/XIUuJzryZRK8wEyX4JUmCzpG1JDYrVtupBvxvGa0//1hAfmbb7yDlvLraAin5G+l+iw5blDI7BqxYBWHCWlC6HdrxDaMXdZtWfBGB5qCCreRfVMq4X3KKVR91x8yCsNW2wi8f0fyyprBR3RqlPGvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=nEVbQdaJ; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1768012245; bh=RBf3Oxf9ZkNT+HIo3GdEkFqVzo4tPshMeIbuRQUKih0=;
	h=From:To:Cc:Subject:Date;
	b=nEVbQdaJfTjV8/OScd8S5jsyfBKP1QLC9zt7fBWcMXDzQfNbpU3fX71K6izxdpvUM
	 W81XKAmTzDwejTXOuroFlwm6Zjb3t+m5ajhpuagllXa1sugTm1U4GzGgarpRD4kbaF
	 EyGHfEiGEJuHYWVP1WbcGd7mq74GE+R+/6gH9CvY=
Received: from cjz-VMware-Virtual-Platform.localdomain ([110.176.75.164])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 7AB14EA3; Sat, 10 Jan 2026 10:30:43 +0800
X-QQ-mid: xmsmtpt1768012243tmcdg4f3b
Message-ID: <tencent_8B6BB2D2C0BBBBF53D76839D23A902304C07@qq.com>
X-QQ-XMAILINFO: NGZp1yYNf7Y+P1fIId/2BJcMoqw5b6F55Ge3y5b/8aXnzRldFac8JGvKS06p75
	 NNF8lyUKw2ufEug9fRo8gMx0arwDCdNVtnKCnJeLSZ2hBVUZUjN8Rv/oSEnKzt+gyOE5E9K1Sb1c
	 NeI0TBlkIKn6Krzftz/BOP3fQ1YD21/W8NWUOJF7eRYU2+Z0bAB51NHZf2dr6q1c4rr/VM7PqY5p
	 YAHg8WEaEdTJQithLs/+bhIH7old1Gk4FL6np0p4t9tDtWSiuHc4PztZkw1ZNKD/pA6s17XN1GEs
	 /Sor15llKiUPnE7APc8bkxISFO+Clho5FVuC4DH3j46D3hXstZueqbfH4oinLvmMyz1kdJFkuulJ
	 8qs4Tf5LHA3RI6R2A6SfpDBObc8Leqcc5L2v88qjU814s9n1oOKmgZc4Idm19N9dModXXloNxvim
	 kV05TERDhcRW0yaZ3JuL3skvJVjTSOGs3y7yb148ACMiE5c9+Gca6hv9bvH2cbHa+j3M4UzAjDVR
	 woZTnZ63Z44UV6orhcs9QvyR7rJ/juHNbIwccn9DGDilH8eIX+lTVYTqO5wGrggHjgAWTpaDHcxF
	 VwC8bvRcTyJialhyUzqHz4GpPpCwQVOZfBDXZBIqEszSdu6Gw7J8UYRdxskM6OZlaMIuUHUoWVXE
	 f96LrkIAfcytyHUy0+Um1bnu84ezrFDj3tsRXp9Lp5Gdk+tNBCMD9zCi79O1zF1Ju2T8tKn09+hG
	 aQ4+W8NiE9/s6e7RwVMkzPAzek5fHLSGPPp+7AIMgQYwrPPr2zdUOOthtcvramtg+ijPKk5VhyLK
	 ILM16hZlkbRyiXd6Yg8SPa17NRyBocrkijBg9kB1Ry0J3++EHB2Qa4tsZODv++ivceOzKmfyguo4
	 hAE/KpdjHM97ng5/j9ZcL+V7VYk0hoDe4EYvXqch2cr3Cmq2PlgW4zCp6/BCi5s2lrfroEnUSi24
	 YTiLDf0iNBDrw/h3DSz0M1JuU0kc+UAdPyIK3USxI=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: cjz <guagua210311@qq.com>
To: linux-staging@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	guagua210311@qq.com
Subject: [PING] [PATCH v4 0/3] rtl8723bs: Remove redundant atomic op and replace global io error var
Date: Sat, 10 Jan 2026 10:30:39 +0800
X-OQ-MSGID: <20260110023040.5502-1-guagua210311@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg and maintainers,

This is a gentle ping for the v4 patch series sent on December 22nd. The key changes of this series are:
1. Remove redundant atomic_t operations on continual_io_error (no concurrency scenario, atomic ops are unnecessary);
2. Replace the global continual_io_error variable with local error_count in SDIO functions;
3. Clean up unused old functions related to io error counting.

I would appreciate it if you could spare some time to review this patch series when convenient.

Thanks,
changjunzheng
Signed-off-by: changjunzheng <guagua210311@qq.com>


