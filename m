Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423DF435EEE
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Oct 2021 12:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhJUKWb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Oct 2021 06:22:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:52726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230285AbhJUKWa (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Oct 2021 06:22:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADA91610FF;
        Thu, 21 Oct 2021 10:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634811615;
        bh=vxjLToWmhGidRwnC/GJcJnZsUPEjB94UTSwBizOpQeM=;
        h=From:To:Cc:Subject:Date:From;
        b=C0Ayqr2BExcovxJfX7p/7kiKzUnK9XDTFu6Uu14PIZhCk694gOcxZREcQ7v1mO1ur
         rRyz2YgZOAXVihzSW/INZduYDgZn3OqVLQv3eQNP+RFdRr0k77qno0gt/YGtX1HAW4
         PrFFljiwX4TfnS2u989vcoF4SXN/lLPf84enOjqi535hl/i1PzLhIyKign98MxIkUl
         RRoPQp/CzMJEmkTKR0lo4KtYlLjygz6NGqpOKr/ifZvvAZwJYRPYGu4ZhFdE+V2HCc
         FJe3+NlDuq/5z2it1MNz1MjJk1VO7cjBf3Hca6BDFkYM8gm70zR2dATKH5+Do/8LbZ
         ve1gIcXRAC3MA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com
Subject: [PATCH] iw: print BSS coloring capability if supported
Date:   Thu, 21 Oct 2021 12:19:57 +0200
Message-Id: <a935a11cabe630100385005b0c2bee9110fb9572.1634811514.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 info.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/info.c b/info.c
index 4884668..6b2bbd8 100644
--- a/info.c
+++ b/info.c
@@ -700,6 +700,7 @@ broken_combination:
 		ext_feat_print(tb, CONTROL_PORT_OVER_NL80211_TX_STATUS, "tx status for nl80211 control port support");
 		ext_feat_print(tb, OPERATING_CHANNEL_VALIDATION, "Operating Channel Validation (OCV) support");
 		ext_feat_print(tb, 4WAY_HANDSHAKE_AP_PSK, "AP mode PSK offload support");
+		ext_feat_print(tb, BSS_COLOR, "BSS coloring support");
 	}
 
 	if (tb_msg[NL80211_ATTR_COALESCE_RULE]) {
-- 
2.31.1

