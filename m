Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 424AF2AF87B
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Nov 2020 19:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgKKSqs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Nov 2020 13:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726904AbgKKSqq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Nov 2020 13:46:46 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E860C0613D1
        for <linux-wireless@vger.kernel.org>; Wed, 11 Nov 2020 10:46:46 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id o11so3298096ioo.11
        for <linux-wireless@vger.kernel.org>; Wed, 11 Nov 2020 10:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=iw7pd+7Piw+XxX2jyOKvkK0Mfc78jK1GM+YRGkFy7qc=;
        b=suiiyXjw9LOtw7vaymJgX6j5gE+ceY2SMUV8TDnUdqVovYGrylT54Z+M85LGYyJjhH
         HveeowlrPVAdd+vOm/7PhSHU72w6Y4kgmW55wexXkWpZDTmHs9u0nN8DkSFNHggYfhsS
         PYSE1/2tLRd3tf3gcIRzhxKSaZKSNioePu0QTPXEYupsZ08iipRXTig+nPW4+zVgHA4b
         jTdfPMQKAq9NcAFgo/8zwTqA2dF6urOWNy6/zSmedRMbfh0+Qb50tRhiHXaio5fyg6fB
         XDn9RCyaB5IE/GUpS0QHVt3D1BGjtoqW5TkXnyrDxPhshg/bl+pOLBWNYjU3p/G5U/Bq
         frxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=iw7pd+7Piw+XxX2jyOKvkK0Mfc78jK1GM+YRGkFy7qc=;
        b=H2e/vZqhb3eZLUvNWLZivHcF2q0U4qMVhWUGQ7Wr/jE8ps3rgxUketiCwLAhDuwjlF
         GvUYOBnsYahrMddJZ3zpZhAWpTfPO101ahUdEUbiQmIv8E+y4XGVvdVlpeHgDkvIO9Ho
         rHNhB9wDGz7BmwoSwbFNk2/C3+VioNH/+0VaEQTYGyyEMC6/Bm3XS6n5TBglmoKDJtt6
         ATN/SC7TuCEeMnP88xyTC+KXLfIRkcfL1y22rHyNvcBZ/vkQWtXX/Drvd5cgF1ByjrWb
         Wu2wvo3lqUPCK0vBTvuuszhZLca4hNF4gg17lPB/2WGOwX0QMNQ60bdpSbEin48C732g
         mfBg==
X-Gm-Message-State: AOAM530dyVg9+MdKaq9sz+SI+iWOtSG0gbbAP6qfjYJq2Ri+bTfziZpu
        IVANYEQtDQ0aJyoWsPxgpczGiFcby/yARhXiJY8=
X-Google-Smtp-Source: ABdhPJwCxA/c3u+WQNivwYkWKNrLuinc9sU+debO3jcnmpwtyUXDX21RRLbyJz0nd3ycYs6LUav5tFgvaRQP2jyB6io=
X-Received: by 2002:a6b:5809:: with SMTP id m9mr19271303iob.186.1605120405446;
 Wed, 11 Nov 2020 10:46:45 -0800 (PST)
MIME-Version: 1.0
From:   Pavel Starosek <starosekpd@gmail.com>
Date:   Thu, 12 Nov 2020 00:46:34 +0600
Message-ID: <CAPgWZqy_bD7KP_ONv1C7tUVw4TLw3QK_xcyYXpi_WH1=4VJwQw@mail.gmail.com>
Subject: [wireless-regdb] [PATCH] wireless-regdb: Update regulatory rules for
 Kazakhstan (KZ)
To:     Seth Forshee <seth.forshee@canonical.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Based on [1]:
* Extend 2400-2483.5 MHz range
* 5150=E2=80=935250 MHz range may be up to 200 mW
* Add 5725-5850 MHz range for indoor usage
* Add 57-66 GHz range.
* In 5470-5725 range change the bandwidth from 80 to 160

[1] http://adilet.zan.kz/rus/docs/V1500010730

Signed-off-by: Pavel Starosek <starosekpd at gmail.com>
---
 db.txt | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/db.txt b/db.txt
index 0bf6287..c71a03a 100644
--- a/db.txt
+++ b/db.txt
@@ -872,13 +872,15 @@ country KY: DFS-FCC
     (5735 - 5835 @ 80), (30)

 # Source:
-# http://mic.gov.kz/sites/default/files/pages/pravila_prisvoeniya_polos_ch=
astot_no34.pdf
-# http://adilet.zan.kz/rus/docs/P000001379_
+# http://adilet.zan.kz/rus/docs/V1500010730
+# http://adilet.zan.kz/rus/docs/V1500010375
 country KZ: DFS-ETSI
-    (2402 - 2482 @ 40), (20)
-    (5150 - 5250 @ 80), (20), NO-OUTDOOR, AUTO-BW
+    (2400 - 2483.5 @ 40), (20)
+    (5150 - 5250 @ 80), (23), NO-OUTDOOR, AUTO-BW
     (5250 - 5350 @ 80), (20), NO-OUTDOOR, DFS, AUTO-BW
-    (5470 - 5725 @ 80), (20), NO-OUTDOOR, DFS
+    (5470 - 5725 @ 160), (20), NO-OUTDOOR, DFS
+    (5725 - 5850 @ 80), (20), NO-OUTDOOR
+    (57000 - 66000 @ 2160), (40)

 country LB: DFS-FCC
     (2402 - 2482 @ 40), (20)
