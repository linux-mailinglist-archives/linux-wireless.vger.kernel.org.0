Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C584C294206
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Oct 2020 20:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387835AbgJTSRh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Oct 2020 14:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387783AbgJTSRh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Oct 2020 14:17:37 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3741C0613CE
        for <linux-wireless@vger.kernel.org>; Tue, 20 Oct 2020 11:17:36 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id u8so4163268ejg.1
        for <linux-wireless@vger.kernel.org>; Tue, 20 Oct 2020 11:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=2c+ZSN2VXHs/jpHTZppiiq12wLhTe/sAfOHIeT4XN+E=;
        b=J74FpGnz2az22YWvbeS2fpKIgRoef+7QFUHc2RwtC4Wa86zUs6bhWRvSGTOKf1jKQz
         kGRJ0aojBHhuPrfpSPhAfQcsASuttccLdskq/30Ye3N5+LoGlow3Q4LdYgkld0jHrzSn
         VaLJsfIuqkDCGBRPswCi/ALPB3TqEx+E2N36nlFA+f153uc91Asit1iXtOvi2s5WvRnN
         zgz9lvvbDf4nkucDE3ESXx8AsBefxCzEyU/GL7NAO/Yz136L1lxocQxQUX7Lwy9sKtNe
         jXmHgurLeiPRwTkqhTLb55YvekQBJKXONMxTmainX8w+FAuQLlKWlxdyNaYDMsuLIXDM
         koTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=2c+ZSN2VXHs/jpHTZppiiq12wLhTe/sAfOHIeT4XN+E=;
        b=CIJoSsZjwrpOabtpYL/U1M/MeX05Q8xNW0flVF+ZsoWupfEICWgJQoCssoMiSklDFP
         08gTEjbxcAcY4XL0I+rafpr2ywhHMyuHqdauN5zdn2YJL83xaQCCbjUILBhARbHlyzIT
         TUf1GVJQoXNGT8rfQ9yr0dmt8boJGqee7aTtZxN7bMF28tX0+iouey3/hP1UsjIhj8rO
         xXszgrLFzxg0Rmb3tKRbFTyvqymHZ3M20IzjvpJpL0Nnsxp8MWhz7OTA6iVzGlDq5H9S
         AMP8lRbCbAKJY2TSXziRN5FBlebYD1oau7WgsGSQVruVtA9GNuyq4Qilgu0wqqVdPn6W
         tg3w==
X-Gm-Message-State: AOAM5331pFaBF5oIkFKuGsgL5ZxFEr64ExFc1tZeX9N+G8nPvXLWHCNS
        0StmVP1NZAjqcvuSkpe2K10+BELt1a7G4A==
X-Google-Smtp-Source: ABdhPJxOnuQ1/hNh53Wk3M3Xknk1BeMbS6vqBpS5fwi5Zl/1fwPAHZlM34Z4sXH9d8XLXRfiSRyQVQ==
X-Received: by 2002:a17:906:a0cb:: with SMTP id bh11mr4657888ejb.314.1603217855258;
        Tue, 20 Oct 2020 11:17:35 -0700 (PDT)
Received: from leagueoflegends ([124.29.208.184])
        by smtp.gmail.com with ESMTPSA id b13sm3383010edk.22.2020.10.20.11.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 11:17:34 -0700 (PDT)
Date:   Tue, 20 Oct 2020 23:17:31 +0500
From:   Abdul Rauf <abdulraufmujahid@gmail.com>
To:     seth.forshee@canonical.com
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: [PATCH] wireless-regdb: Update regulatory rules for Pakistan (PK) on
 5GHz
Message-ID: <20201020181731.GA18865@leagueoflegends>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Update range to 5.725 - 5.875 Ghz
as mentioned at https://fab.gov.pk/type-approval/

Signed-off-by: Abdul Rauf <abdulraufmujahid@gmail.com>
---
 db.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/db.txt b/db.txt
index ac32483..ce8449c 100644
--- a/db.txt
+++ b/db.txt
@@ -1243,8 +1243,10 @@ country PH: DFS-FCC
 	(5735 - 5835 @ 80), (30)
 
 country PK: DFS-JP
+	# https://fab.gov.pk/type-approval/
+	# https://pta.gov.pk/media/Pakistan_Table_of_Frequency_Allocations.pdf
 	(2402 - 2482 @ 40), (20)
-	(5735 - 5835 @ 80), (30)
+	(5725 - 5875 @ 80), (30)
 
 # PL as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893)
 # and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
-- 
2.25.1

