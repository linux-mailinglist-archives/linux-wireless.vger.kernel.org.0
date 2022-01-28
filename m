Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02F649FB27
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 14:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244783AbiA1N6u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 08:58:50 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38482 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239445AbiA1N6t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 08:58:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F3C3B8259F
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jan 2022 13:58:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AEC5C340E6
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jan 2022 13:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643378327;
        bh=Rk5NXHzF6pb/CXhIzx6JMwPRPqGGHEGhGQ/TBV5xnLo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=N0G+rUfGlxvDbr2MF8EOP98Kb4Ba/n7MxNyQ46TNuYV6mBC5SnZY5kNuWQXB4U1xH
         AYUmdc5HNVPn1Bvda0ZAkVCrktnyv1RUkMqk9IMnHBHWQmfuJIAfQteYT9sCHr8THf
         neynSfPwWdgLsClBPW6gF415CYXQWtTpjD0Gru67w7BJlZbV92CX9f7ZnxCH1uMMYr
         4BlD14ghn2nWFinH2yFhHHjUq/PCw6qS/5xCOUVeYLgm5HP7ZzCj3ZMV37pKpo/FCI
         TIf4YWzZL47yu1kJFbZ2ho6KqeJMoFgUWI+A9gEdglU9oGNc+cTuhIQHa3zHuC06eJ
         kHomL/WwGwDYA==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH wireless v2 3/4] MAINTAINERS: hand over ath9k maintainership to Toke
Date:   Fri, 28 Jan 2022 15:58:40 +0200
Message-Id: <20220128135841.1926-3-kvalo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220128135841.1926-1-kvalo@kernel.org>
References: <20220128135841.1926-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In practise I have been the only maintainer for ath9k for some time now but I
don't really have time for it. Luckily Toke is willing to look after so mark
him as maintainer. Thanks Toke!

Signed-off-by: Kalle Valo <kvalo@kernel.org>
Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
---

v2:

* add Toke's full name

 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f57dcc8862c5..37573c9af10a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15898,9 +15898,9 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
 F:	drivers/net/wireless/ath/ath11k/
 
 QUALCOMM ATHEROS ATH9K WIRELESS DRIVER
-M:	ath9k-devel@qca.qualcomm.com
+M:	Toke Høiland-Jørgensen <toke@toke.dk>
 L:	linux-wireless@vger.kernel.org
-S:	Supported
+S:	Maintained
 W:	https://wireless.wiki.kernel.org/en/users/Drivers/ath9k
 F:	Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
 F:	drivers/net/wireless/ath/ath9k/
-- 
2.20.1

