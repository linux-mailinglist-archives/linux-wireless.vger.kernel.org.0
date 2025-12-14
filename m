Return-Path: <linux-wireless+bounces-29732-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCED3CBB6EC
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Dec 2025 07:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAE4730081A0
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Dec 2025 06:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF97757EA;
	Sun, 14 Dec 2025 06:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ZuB8kxyu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C80D7494;
	Sun, 14 Dec 2025 06:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765693036; cv=none; b=OTclIVRHGQlkT1fGVL18XMc+80/QikWVSq4Ds4feckDhdW37P2DeBoKC/+wo7rhAheSJBa/Tc89WptM03qof41iP+2DqeJJxbUQMTGJnjc7jxl1Nb9C/oLVTaSFvSa3QzzJTAga4/4IHoofG63x3BkpnXdTKwwOBzy3vr0vlWUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765693036; c=relaxed/simple;
	bh=HDL62iBPvLCZy8cVdALB22EHOryvl8QwKJk1y09TSjs=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=TAkdHPDgISO800BYJpBQqQKgpozOJZ64U8/JwWd7WF2ohdLMAeG0jOTqbEA7XqMif1CcTbgv50AWB3E08d9MMvpVSq9Wk0KI4Fd+DHI2ga5mtFmvJKt2CsDkPeFNfI4KN/HBO3mtDEGh1pnSadFCFHIk0jD31C5JvVDS/KsC/sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ZuB8kxyu; arc=none smtp.client-ip=203.205.221.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1765693024; bh=ukjS5wj9jDB0y5Jf+PQhcVoI1QsE8Fn3Sg/aeBpBrBg=;
	h=From:To:Cc:Subject:Date;
	b=ZuB8kxyul319M5p+lJxJWDC6xPirjB8t9PqCd+Zj7QmCLMoOOArjODyICf4su5TP6
	 HpPKpH8GKwkA8bA3dqH9i3rp0KseZSmNxNE+Ldbkky+ykEf4X/PE/p5CC/vPAf/TxP
	 sfApCa3KxWT48PdjhO+RPwpWHTmdcOVocMWuN+0Q=
Received: from cjz-VMware-Virtual-Platform.localdomain ([110.176.95.38])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 441376E4; Sun, 14 Dec 2025 14:17:01 +0800
X-QQ-mid: xmsmtpt1765693021tybyjneqg
Message-ID: <tencent_BAB546E9C29DF17A0E3BCE8EAE1428D88206@qq.com>
X-QQ-XMAILINFO: MWef2M2/68u3xlOTueYYcvBL42lp3wFQ4pqGXIs2SU7vtH76JsnI4dAG47hgVJ
	 O7PoJzUorfoxpQt7nKWEiirszbeeoEebjIZi51k/l3sevL/+Bp0y7ui3Pk9ZMPf9WR2XQDLgxh9l
	 v6okNFL9dU20v+NtwxY3NZo8mNsBQvvuwXOvLefmsEMSu0o/v4WWmDcBPsFh6/hqcVMNU/lg+4fO
	 Gi6D22ToJJgzFhMW3Gd5mMgwn9HTgw3X9h5PL0wv+6SDbrCUs1H2fLz+hBwSdCjYcca/jO1EmKkR
	 Schuo5z5ZVTb1tFUBAn+9pyuSpZGEYuWSETRPGEgM4FQCAclvDXdvSidnn5w9PrpIEY1ClUBDwjv
	 VXYw2/zypek6Cb9yt/aaQE69yduB6k2NFQwmr8F0RbHDxpeof0rjKz6ef8Hv7q1NusFdtUFSgd+4
	 GzRnVZLcO9WQHkPv06SN7hcdk/h4sR0CXw55KVvoobb0AFOKTQqGTqoL0jPdIRpsS79hAp+bSQIU
	 DIubX+R4yu9HJSeitcVlvC0W1W2FwHR50PJgtIRXwsfmu7vqs0dzGA32AB2VgJUt11f1MJCE8fGG
	 TCAYezVmj04pGTezpa80INbFuVYZ6SRJj7A79g1BY1A8Z/mWVNYbNkhNoLGi8EEAxEj8a9anj31z
	 JOkqRaoSTKbgLbLNZt0fO1ibx+viFx32AiFkkH3fWnhaHTJdvOaiyFmgHILsA/HDW31+jplieIYP
	 a7QGZX2JQitaAHwgrw/mvZAMwjJR5SJzSX/7pUa9HRyTeGwNIDKPsR6z4HWDWLOxOCaaBcPsL/+1
	 5oWlFVsvKHWkVNC/uFu2tU9qHRGCL6OTJcxwipHVQF3vbVsKANyKmbhAZVmlcLyeSO/dTDJ6PrPN
	 yXDvxEcG2Y7jiwVxvQCVLn7FingYFiALfWmHbufzP1/0fr8z2GlBT1fCBgYicI0F/jua41kJqYCk
	 POir0BX6oMvxd5uGzg4aw5RHKcr3nr
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: cjz <guagua210311@qq.com>
To: linux-staging@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	changjunzheng <guagua210311@qq.com>
Subject: [PATCH] rtl8723bs: Add kernel-doc comment for rtw_reset_continual_io_error in rtw_io.c
Date: Sun, 14 Dec 2025 14:16:59 +0800
X-OQ-MSGID: <20251214061659.20255-1-guagua210311@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: changjunzheng <guagua210311@qq.com>

rtw_reset_continual_io_error lacks a standard kernel-doc comment and has an incorrect
parameter name (dvobjprive vs dvobj) in the existing comment, which causes gcc W=1
warning and reduces code readability.

This change replaces the non-standard comment with a complete English kernel-doc comment,
fixes the parameter name error, and keeps all functional logic unchanged.

Signed-off-by: changjunzheng <guagua210311@qq.com>
---
 drivers/staging/rtl8723bs/core/rtw_io.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_io.c b/drivers/staging/rtl8723bs/core/rtw_io.c
index fe9f94001eed..358a16b25a20 100644
--- a/drivers/staging/rtl8723bs/core/rtw_io.c
+++ b/drivers/staging/rtl8723bs/core/rtw_io.c
@@ -147,7 +147,15 @@ int rtw_inc_and_chk_continual_io_error(struct dvobj_priv *dvobj)
 	return false;
 }
 
-/* Set the continual_io_error of this @param dvobjprive to 0 */
+/**
+ * rtw_reset_continual_io_error - Reset the continual IO error counter to zero
+ * @dvobj: Pointer to the device object private data structure
+ *
+ * Atomically set the 'continual_io_error' atomic counter in the dvobj private data
+ * structure to zero, resetting the state of consecutive IO error counting for the device.
+ *
+ * Return: None
+ */
 void rtw_reset_continual_io_error(struct dvobj_priv *dvobj)
 {
 	atomic_set(&dvobj->continual_io_error, 0);
-- 
2.43.0


