Return-Path: <linux-wireless+bounces-26205-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61398B1D8C7
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Aug 2025 15:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19B873A17EE
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Aug 2025 13:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E1B221269;
	Thu,  7 Aug 2025 13:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="NJOipFBH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EB92327A3;
	Thu,  7 Aug 2025 13:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754572613; cv=none; b=FM1nMNcDcqW711ek/D6YurNtmaDcZVOMELptnFqDAkuKdaFOxEtl+DUuL54IRZKgXYoEegMxd3lnnJDOURytfOZjwlzh0Fxr1kDknn+R7+k3wSPMrWpUhcRIrCLF+L/GEblqlmd3FT1j1Pgozb5S6i/HKUHo0ei8J+Tc+jeYfSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754572613; c=relaxed/simple;
	bh=d70PNvUSr+Ig8dY5oH1WbyWi3rXq3qN21CY3dQwEHwI=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=XDLO9ylFo8yIOl0PmM3TvMdqseTrCPx17prgcs8r3Hj1iiq7ZTdspD2QHCZMfeifZ9Fy5CQ37GbtzkiDH49/ID44deuH/IxW/qJK7Pi2EHP0wVSxOjRySzxP+JgUo5LAbDpFvG72f0cCEzAV3837m6ZDw5FcK/L/s9uLPjP82LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=NJOipFBH; arc=none smtp.client-ip=203.205.221.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1754572601; bh=RcHRWb5DAuWCDBHoiqPic68VtC16FWLD08hD8/gKNA4=;
	h=From:To:Cc:Subject:Date;
	b=NJOipFBH8vpNJsyNA4vuhJ5dNsgCsJN3Hvx/y7kL2u+agdmGRW0tULqmdGAL6cCTc
	 h7eY9HQ22vi/FywpnQfDZkMh7n6kxBLqPZV+uCVv4+dsdLyGJwfXbbZUXS4aKwL4dG
	 PO2vXw+Q71p75ITEhy1QmkHSCJdPnujJcvXmLG0I=
Received: from localhost.localdomain ([45.250.181.71])
	by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
	id 2A28B0C5; Thu, 07 Aug 2025 21:10:34 +0800
X-QQ-mid: xmsmtpt1754572234t10e38kwf
Message-ID: <tencent_FE21EA217C7FF6B3CEAB5749F98F0267EC0A@qq.com>
X-QQ-XMAILINFO: NAuAIaytDrXp5l4QV3QI1hr69CyNRgRDQ+H9pR/CvqdQdOgluR1TnJpqSzF4nN
	 0gQ9guSZHW6NJZ60wG39ETGSUoV89tWfl5WuublsevdraxGeryKPaL8M9aabqCRB/5b5dHsvZiq0
	 MwZYUNjeWysHdQtZhcWj6wEf2+Et/cMhGnbXaZtkFyvlZxnBnWW+v/Cb/xxud5wP/GcdgtJOvFwM
	 DLwk9G2RXIY5AbjdHh2OvQ65U9oN8WfmGsfaf3OMgU3n7/9ZgOuBvwsoN1XJymJjuvayE/Sznbsf
	 1mc7xpwrnQ3Pvprd7NAdpiWopQ+AXCQ/OgFBw2tcFmC1BGt/W7bVWazlhTyTXhg3b2i6Xr8wi59Y
	 8AGfGOl/o4MrXYcjmh0LtX0kziRlgZ/PNZJ0bPRVnuXNqHUBQq9PJAXOJZ2UCtMGK7Q+rmYQM07E
	 lUfezjzGSNXFvWK9Ta/sFlMX4C0LhBdk0ijlzDNXH4A1Ms553fZ2uoIes1atYvp1nh//pEBgoAin
	 Mjwcne7PRbJAGt9n3Eh6rN6Zz1TOo/SP88mjlT3fbUffqNLtyjD3MmzwI9IEzJaF3i7aSzRIYMf5
	 NS7X8fJTMQXQ6Uwda6cyh6EFX/nWhLWS/zVaBJku3MBnSSVnxcYVq0ozkLTdaoxv7Fv4gn0cUdaU
	 RxNPah9vdzs8m2xmM+thohVcCjgCt7xxlC2z3S4lSnMqLsz8Niwm91jDLOpFK5ERUFfgQd/dpHuy
	 wuMesRsocOfd+ZAVfhPwb2m6/0/xlRv5E3AET71DrMijxaZzeGbSRPnQXRKQOMsHcpRBY/mWANuv
	 6twEkS1f0tyZXpoB6eIV2CgpZvvWIN+GWs/NacgKem2jJQX8CLX7WTj2Pv3y77SlzPthSlFqsbQV
	 ct9L4CUlCdHp4YfT0FUcUW+/7OTOUrMxjhqyeHvNNzYwh7COP7yjakXfCHytfPo/EIpqGm3nbm6c
	 cyIg9aifL50nioeTAS6m9OJyZbXm0eQ1MPpJAMJ7Cuuy3gLTX6llTX49FjHu/mFgctnnhVwxWKE4
	 SuKTQ3b+o/Pxpgc706iWPR7JnBPCKXtmXo19QONz9vjall4poexxvDfmVxd7A=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Callan Huang <luvings@qq.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luvings@qq.com
Subject: [PATCH v1] wifi: wext: propagate metadata on -E2BIG for GET ioctls
Date: Thu,  7 Aug 2025 21:10:18 +0800
X-OQ-MSGID: <20250807131018.56291-1-luvings@qq.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When GET ioctls encounter insufficient buffer (-E2BIG),
preserve u.data.length metadata in iwreq structure for size detection

Typical usage in userspace tools like 'iwlist wlan0 scanning':
- Detect required buffer size via u.data.length
- Implement retry logic with proper allocation

Signed-off-by: Callan Huang <luvings@qq.com>
---
 net/wireless/wext-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/wireless/wext-core.c b/net/wireless/wext-core.c
index c32a7c690..b4f72a49f 100644
--- a/net/wireless/wext-core.c
+++ b/net/wireless/wext-core.c
@@ -1075,7 +1075,7 @@ int wext_handle_ioctl(struct net *net, unsigned int cmd, void __user *arg)
 	ret = wext_ioctl_dispatch(net, &iwr, cmd, &info,
 				  ioctl_standard_call,
 				  ioctl_private_call);
-	if (ret >= 0 &&
+	if ((ret >= 0 || ret == -E2BIG) &&
 	    IW_IS_GET(cmd) &&
 	    copy_to_user(arg, &iwr, sizeof(struct iwreq)))
 		return -EFAULT;
@@ -1138,7 +1138,7 @@ int compat_wext_handle_ioctl(struct net *net, unsigned int cmd,
 				  compat_standard_call,
 				  compat_private_call);
 
-	if (ret >= 0 &&
+	if ((ret >= 0 || ret == -E2BIG) &&
 	    IW_IS_GET(cmd) &&
 	    copy_to_user(argp, &iwr, sizeof(struct iwreq)))
 		return -EFAULT;
-- 
2.25.1


