Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D41B9435AF0
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Oct 2021 08:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbhJUGes (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Oct 2021 02:34:48 -0400
Received: from ns.kevlo.org ([220.134.220.36]:17240 "EHLO mail.kevlo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231357AbhJUGep (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Oct 2021 02:34:45 -0400
Received: from localhost (ns.kevlo.org [local])
        by ns.kevlo.org (OpenSMTPD) with ESMTPA id 8ab2145d;
        Thu, 21 Oct 2021 14:32:27 +0800 (CST)
Date:   Thu, 21 Oct 2021 14:32:27 +0800
From:   Kevin Lo <kevlo@kevlo.org>
To:     linux-wireless@vger.kernel.org
Cc:     Pkshih <pkshih@realtek.com>
Subject: [PATCH wireless-drivers-next] rtw89: fix return value in
 hfc_pub_cfg_chk
Message-ID: <YXEJey8lKksAZif4@ns.kevlo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It seems to me when pub_cfg->grp0 + pub_cfg->grp1 != pub_cfg->pub_max is true,
it should return -EFAULT rather than 0.  Otherwise, the function doesn't need 
to exist.

Signed-off-by: Kevin Lo <kevlo@kevlo.org>
---
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 69384c43c046..afcd07ab1de7 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -560,7 +560,7 @@ static int hfc_pub_cfg_chk(struct rtw89_dev *rtwdev)
 	const struct rtw89_hfc_pub_cfg *pub_cfg = &param->pub_cfg;
 
 	if (pub_cfg->grp0 + pub_cfg->grp1 != pub_cfg->pub_max)
-		return 0;
+		return -EFAULT;
 
 	return 0;
 }
