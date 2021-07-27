Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61BD3D80DD
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jul 2021 23:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbhG0VIA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Jul 2021 17:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbhG0VG5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Jul 2021 17:06:57 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54069C061760
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jul 2021 14:06:56 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id l19so1923247pjz.0
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jul 2021 14:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UPGlu1gG6API/iCexVdVFLvP4yi8HHonlHYke9K7UR0=;
        b=m3xmCqlfQQl6y88gzGHqm2N3UvKEnCdok/BJyDNoduQEklW/A7rLG1ArcEbIa4sNpg
         gyE4VCnVWyScIlaG1xhcD8qrQj5NdPxQkhHLzIIQou5A0leQoAsnAyLU3S12xLMU/Hpr
         6bYRGbAjxTPd/EtMM4GpfIh0ws6if/8UYqIYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UPGlu1gG6API/iCexVdVFLvP4yi8HHonlHYke9K7UR0=;
        b=srxU4MFlDH0nrsVaWRg07/dU1BX0VJyZOsTO8ElHICGEfL/xAxW5KpQJR/vfkIgMRe
         R4YLcVbHVASJFPi9UWjrsqe3dUDRIC4fTohzbj5DU473tSD9xfXkG2SE6fc48utCJ6UN
         NlFA3+01u3TZmWctP/PsHsxy7i8LYAgbCGM5AcmT3+n7FdMkeZW4n3VxaHJrIuh0N66d
         MAdyzJAaGn8pULnd+hugnQSOtdojOWoPgBhsA+aJikE85tRcaWbYTt7Ynpm0IbdS72P4
         Ks1G1ZAFXJhSq3K1FUFKD6w4/Jejzt9HeL4pQaWJFwyoHgTbnM0aXIo2Kje86Q2FFCxv
         WamA==
X-Gm-Message-State: AOAM531xfS1xz1HJxRA5zdnDxZeeYbh1CVFh2doLzyNEMUoxPfL/Orcf
        m2WzzZUHXKgm8Rq6AJSNzfJ1ug==
X-Google-Smtp-Source: ABdhPJyRr41WjbyJq9nCLCxMpkCCFYsX51CfWKd4/S2P+UzJSAsEt1kW141ndTqkUOB7pGW66MCilA==
X-Received: by 2002:aa7:9546:0:b029:32e:5fdf:9576 with SMTP id w6-20020aa795460000b029032e5fdf9576mr25063139pfq.5.1627420015943;
        Tue, 27 Jul 2021 14:06:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d29sm4704061pfq.193.2021.07.27.14.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:06:54 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH 17/64] iommu/amd: Use struct_group() for memcpy() region
Date:   Tue, 27 Jul 2021 13:58:08 -0700
Message-Id: <20210727205855.411487-18-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727205855.411487-1-keescook@chromium.org>
References: <20210727205855.411487-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1451; h=from:subject; bh=3pnVXRScRiXcKlAzWmxtHjgtqdCSr5x9f+6aO5KQ5qc=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhAHODYV9h07PQ3v5RAvzij9k85T7DPu/8sNSs65Q4 0y0UliiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYQBzgwAKCRCJcvTf3G3AJiW2D/ 4nEDA70nGUYhVyf7oYOlQgzyry3f6d0tKPbEYWNkte1rIRW3O2InK76AVJyf0Q/BtnVYPXNStIrzaO SUDw2yOwXO4oq2+xlKHbSpDQcYZna36Xqovo10kVGY112L7kOGbUfQZZPm+9ZCxh9fprwP+ezpdrPw 5RhPSv0UwMiQYY/cih9csRF3Y0cUslbWzBAlMAKY4vV665FdBYm4Cd1UbBRiX7n5X6rkASp/R5KUJO gT9lqJlutTZcY84HhE2e7nVfUM1tK/zoQ1ZeRZ2l14KFhykcFSW9gTHS3VJa2Fr3ta26jaAzpIQzRI I1VZSdlxpEUPAljbEi8ms11eBPC5N8+yPox2bH9yz8bPLwwHOwyP+yRXagJSrsB0JY9elrri4Jr0d4 L0spfyNNFhXi1pYLN/VwHLWk0qCJ6U6H1/1yJ5fkSANbabpn+M+34UuJ87NhDZnoboRjX68s2N9xUp Ztc8gb6cNuq1OK7yjw+/s+IPxRe2Xrjyj6xMHQ75Nmq+kDqedEV8h/okfZHv9FN6eZGw8+d+79qrHr /MdSe/HI+xPECZcwJiIqojDU9hyrQ75Slj1hn65lXR2jBuZkuxOB9VWtjVZyPGXbccWBvdccl0Sthp x+6FisSerA0XyrnefqEYTnx+5XYfaYWhfusWvoUDsVRDlD5XjnXe/NKxjhWQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally writing across neighboring fields.

Use struct_group() in struct ivhd_entry around members ext and hidh, so
they can be referenced together. This will allow memcpy() and sizeof()
to more easily reason about sizes, improve readability, and avoid future
warnings about writing beyond the end of ext.

"pahole" shows no size nor member offset changes to struct ivhd_entry.
"objdump -d" shows no object code changes.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/iommu/amd/init.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 46280e6e1535..2df84737417b 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -121,8 +121,10 @@ struct ivhd_entry {
 	u8 type;
 	u16 devid;
 	u8 flags;
-	u32 ext;
-	u32 hidh;
+	struct_group(ext_hid,
+		u32 ext;
+		u32 hidh;
+	);
 	u64 cid;
 	u8 uidf;
 	u8 uidl;
@@ -1378,7 +1380,8 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 				break;
 			}
 
-			memcpy(hid, (u8 *)(&e->ext), ACPIHID_HID_LEN - 1);
+			BUILD_BUG_ON(sizeof(e->ext_hid) != ACPIHID_HID_LEN - 1);
+			memcpy(hid, &e->ext_hid, ACPIHID_HID_LEN - 1);
 			hid[ACPIHID_HID_LEN - 1] = '\0';
 
 			if (!(*hid)) {
-- 
2.30.2

