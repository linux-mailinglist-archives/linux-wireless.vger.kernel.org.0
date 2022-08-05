Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9974858AC46
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Aug 2022 16:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbiHEORP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Aug 2022 10:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240794AbiHEORN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Aug 2022 10:17:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DA85925A
        for <linux-wireless@vger.kernel.org>; Fri,  5 Aug 2022 07:17:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F122BB82867
        for <linux-wireless@vger.kernel.org>; Fri,  5 Aug 2022 14:17:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86BCAC433D6;
        Fri,  5 Aug 2022 14:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659709029;
        bh=a3nUXquMb6F64/WdIJWB2QBOrME6wTjNyx/piGNijBM=;
        h=From:To:Cc:Subject:Date:From;
        b=Carulu6aYdx29vEgvENU+w8hfdUH+asju7IeYuoHIkFODWkqH0M2i1+t3wEAiHOoP
         qX3KvaDxzMD29OFvYn1ypxW8buX6URwgc1bM1WciHqVJSeDIVdHkDFqyqEhK6794tm
         NVeuaJOk3pUtM+LmqbxQ9rS3fUL63gHfP1aOokNm+cpak/zj8R//ZmAL8lBcNpTnVf
         aTFEnaMI7PfvSyFLs9cDgu7CFCxLaxKlVH/TyEuE5LVAeGL2hNspkx7vwSohxB/Yiy
         rR+EDQ5FtWhsJDeuqB1CPijdomnxDhqn3iY4/+eP2k1ZuptEoIZDgPyBM8m4iVfCmv
         MqRpXTd4oDPpw==
From:   Seth Forshee <sforshee@kernel.org>
To:     wireless-regdb@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] wireless-regdb: add 5 GHz rules for GY
Date:   Fri,  5 Aug 2022 09:17:09 -0500
Message-Id: <20220805141709.106684-1-sforshee@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add 5 GHz rules which were provided by a representative of the Guyana
Telecommunications Agency. There is no published document which can be
used as a reference for these rules.

Signed-off-by: Seth Forshee <sforshee@kernel.org>
---
 db.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/db.txt b/db.txt
index 16b38b7cb2b2..16abf2951e77 100644
--- a/db.txt
+++ b/db.txt
@@ -732,6 +732,9 @@ country GU: DFS-FCC
 
 country GY:
 	(2402 - 2482 @ 40), (30)
+	(5170 - 5250 @ 80), (23), AUTO-BW
+	(5250 - 5330 @ 80), (23), DFS, AUTO-BW
+	(5490 - 5730 @ 160), (23), DFS
 	(5735 - 5835 @ 80), (30)
 
 country HK: DFS-ETSI
-- 
2.34.1

