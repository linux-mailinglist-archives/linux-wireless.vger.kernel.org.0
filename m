Return-Path: <linux-wireless+bounces-20121-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E481EA5A705
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 23:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72C93163B22
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 22:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5521E834E;
	Mon, 10 Mar 2025 22:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTbqlEak"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8101C1E0DDF;
	Mon, 10 Mar 2025 22:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741645385; cv=none; b=RM3rU2H9aIS7RHhdCAhaud4hePk37gd5xLS1Fn6gHZ/0VhwUUJEwnC5GWtzVOlyoTA0zAUx9sBHRnJrz6vrbD73vpn6GIHPwot3t6FNPZObTnM1meKreVZSaU/8EGgyFS8kOXnCOc763292jjzRrGTl7ChQjZoAj7sKc6CUZ9lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741645385; c=relaxed/simple;
	bh=7u1d/ZUDNDOKNKa9JHABah7nqhjeBSqW/b4gRgdl4i0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eE+0v6urxrSvP3Y5LBRjWNtUYNdsQ54lx3k1q6Rf1gv97LocXAjKnwJtYrk653YaC8Zs7OMfFfvsgZaSlG988HprIo6xBzczxIZNIy/hhnMSH79pNspsDbJZGv2pMUyJaYfir1Nwzy6fB9metpKH7YXGtjtj1MmCPA8iwMSC6BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTbqlEak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43658C4CEE5;
	Mon, 10 Mar 2025 22:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741645385;
	bh=7u1d/ZUDNDOKNKa9JHABah7nqhjeBSqW/b4gRgdl4i0=;
	h=From:To:Cc:Subject:Date:From;
	b=eTbqlEakS5rjb5k6+u6UTb3RkEuzTl/qIaCLc36HVbxyezKIRGU4tYxo/+KLccXko
	 1gR4p8zem71vUKMTfNS0HmMk3EkwEuDhQLJojS+xaano/9uTson5NOd3VbqYohvB1s
	 KD6TS88E/E8o3KJ9l9l1aqfV1PuZ9l9hu3t/iJ/2+xX3TSHu6iJ8eYJqNcwO6S3jtE
	 t4F7rBPSAlDjMCBRPmCP5z/i8TphuzRG7TFiCmTBCrAivDiJ3UXRr0k8MNLv/HtVLy
	 GzQ26qJEZ3GnWAl9aexxcTi4+XjWpo52msCTIQfxc29UQDnhfzvBZ5ygyDYO/Wjwvi
	 IaftvNAhVzE5g==
From: Kees Cook <kees@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kees Cook <kees@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] wifi: rtw88: Add __nonstring annotations for unterminated strings
Date: Mon, 10 Mar 2025 15:22:58 -0700
Message-Id: <20250310222257.work.866-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1087; i=kees@kernel.org; h=from:subject:message-id; bh=7u1d/ZUDNDOKNKa9JHABah7nqhjeBSqW/b4gRgdl4i0=; b=owGbwMvMwCVmps19z/KJym7G02pJDOnn0xwF53H+OX/FubA1uUDmDnfVzr1yL59YTC6Z+605e Nmyks53HaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABNZupLhf6Km5/RpN+r8fs7c v972Y+QzIU1B4aiza1/fFWf2Dp6ipcTwzzrlZYf7hSMCmse2Cyyvinj78/k1Zo3rOuaqXTLzz1U UMwAA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

When a character array without a terminating NUL character has a static
initializer, GCC 15's -Wunterminated-string-initialization will only
warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
with __nonstring to and correctly identify the char array as "not a C
string" and thereby eliminate the warning.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178 [1]
Cc: Ping-Ke Shih <pkshih@realtek.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
Signed-off-by: Kees Cook <kees@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/main.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 62cd4c526301..5d6df6b51698 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -822,7 +822,7 @@ struct rtw_vif {
 };
 
 struct rtw_regulatory {
-	char alpha2[2];
+	char alpha2[2] __nonstring;
 	u8 txpwr_regd_2g;
 	u8 txpwr_regd_5g;
 };
-- 
2.34.1


