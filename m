Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 902DF2C366D
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Nov 2020 03:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgKYB5a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Nov 2020 20:57:30 -0500
Received: from forward106o.mail.yandex.net ([37.140.190.187]:56315 "EHLO
        forward106o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726155AbgKYB53 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Nov 2020 20:57:29 -0500
X-Greylist: delayed 348 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Nov 2020 20:57:27 EST
Received: from forward103q.mail.yandex.net (forward103q.mail.yandex.net [IPv6:2a02:6b8:c0e:50:0:640:b21c:d009])
        by forward106o.mail.yandex.net (Yandex) with ESMTP id 8A7A5506282C;
        Wed, 25 Nov 2020 04:51:25 +0300 (MSK)
Received: from mxback8q.mail.yandex.net (mxback8q.mail.yandex.net [IPv6:2a02:6b8:c0e:42:0:640:b38f:32ec])
        by forward103q.mail.yandex.net (Yandex) with ESMTP id 85F3861E0002;
        Wed, 25 Nov 2020 04:51:25 +0300 (MSK)
Received: from vla1-1bc5b51c612f.qloud-c.yandex.net (vla1-1bc5b51c612f.qloud-c.yandex.net [2a02:6b8:c0d:89c:0:640:1bc5:b51c])
        by mxback8q.mail.yandex.net (mxback/Yandex) with ESMTP id cKG5bOXa5b-pPn4Ea8W;
        Wed, 25 Nov 2020 04:51:25 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ratijas.tk; s=mail; t=1606269085;
        bh=YszRmP2jRZSL10eennb7DsxzQAjLtn1mJIUoR7chxzY=;
        h=Subject:To:From:Cc:Date:Message-Id;
        b=lExMeMMEA2/3uf8b4ZvbcRUCHmYdierTcxzrAxdVsVRFPma2knfxRY3lxwYbA/DAl
         p5Veo60FNTloI5oNIRf1lqwv6/bvKPfzVKv54T7L/MHnB0u4y0eU2dEAagzRffQr5g
         L7XiHy4J41UNz6sbsZSBfWaR1GAP0UI2ZmaeEyvI=
Authentication-Results: mxback8q.mail.yandex.net; dkim=pass header.i=@ratijas.tk
Received: by vla1-1bc5b51c612f.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id YbWdwsgm07-pOn87NFE;
        Wed, 25 Nov 2020 04:51:24 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   ivan tkachenko <me@ratijas.tk>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     ivan tkachenko <me@ratijas.tk>, linux-wireless@vger.kernel.org
Subject: [PATCH] man: update wikipage URL, reformat SEE ALSO section
Date:   Wed, 25 Nov 2020 04:50:48 +0300
Message-Id: <20201125015048.197683-1-me@ratijas.tk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

groff_man(7) provides plenty of useful requests/macros, and one of
them is .UR/.UE for URL formatting.

Man pages should be formatted with paragraphs (.P or .PP) requests,
and source text should not contain empty lines -- use empty request
instead (literally, single dot on its own line).

Signed-off-by: ivan tkachenko <me@ratijas.tk>
---
 iw.8 | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/iw.8 b/iw.8
index d0fcb61..4ae55b8 100644
--- a/iw.8
+++ b/iw.8
@@ -1,4 +1,4 @@
-.TH IW 8 "7 June 2012" "iw" "Linux"
+.TH IW 8 "22 November 2020" "iw" "Linux"
 .SH NAME
 iw \- show / manipulate wireless devices and their configuration
 .SH SYNOPSIS
@@ -63,9 +63,13 @@ will print all supported commands, while
 will print the help for all matching commands.
 
 .SH SEE ALSO
+.P
 .BR ip (8),
 .BR crda (8),
 .BR regdbdump (8),
-.BR regulatory.bin (5)
-
-.BR http://wireless.kernel.org/en/users/Documentation/iw
+.BR regulatory.bin (5).
+.
+.P
+.UR https://wireless.wiki.kernel.org/en/users/Documentation/iw
+Documentation at kernel wiki
+.UE .
-- 
2.29.2

