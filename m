Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7448482871
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Jan 2022 21:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbiAAU1i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 1 Jan 2022 15:27:38 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:49315 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbiAAU1i (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 1 Jan 2022 15:27:38 -0500
Received: from localhost.localdomain ([37.4.249.169]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mhl4Q-1mQ0NL0gWe-00do8f; Sat, 01 Jan 2022 21:27:19 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Phil Elwell <phil@raspberrypi.com>, devicetree@vger.kernel.org,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH RFC 4/4] arm64: dts: broadcom: Add reference to RPi Zero 2 W
Date:   Sat,  1 Jan 2022 21:26:52 +0100
Message-Id: <1641068812-5851-5-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1641068812-5851-1-git-send-email-stefan.wahren@i2se.com>
References: <1641068812-5851-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:VUyfbNXMUTZ28FWicxIVh7Ab5XomgIvGNewGUykBBN+BdaVpTKF
 fd7K7/AnwSw54Q0jUcXxTbOIfhv8T8RjrbjfKAia1quN1RBqi/XZmgrjgFjAv75LD9yX+JF
 INqg6VlqwzPXQ6PdGlSM+QDKzN469ASPClUj3ix89M+Tj3J+wz4Pe6y206R7USzYomvTcYp
 g2ArOhhnuZE0AWPDLKlPg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RTIGgM0LfcE=:DCJ33IC5XicleX2NVL6AhH
 kNbu+Pd9g618cFxUyXyMLcHmaZIwOq7pmcDK+evfa+u7n+xIl98nIu0pISkkoU3pG/mo6GkW+
 UGotZI8fuaYN293E3gEBovMt6Lldi/FTEW/dLJ+kZTbEJnuCIzPplORrkc7XUjCp5j83A4L3X
 kcPIfuDPP7D3s6Rsex2UpbZAl9X+p3xrqdmDwrk+aGTXUtg9ZPGWGt0NNN3Dk+p7R3zga5jmz
 0joFRiWdgGOOAQmczHkayjlOc1xzK3j/3sCNjW+6MczECngs7dc9A4vSLJNCkTE/XDdgLvXrN
 v0Vdo+Iyn3x3XtyPFDm1J4dGB1zZhTFV3UZfcfgFgF8cBGLH4fW0WulSQCECO0pvMVG4Q3Z8J
 67XC11Vz6hQd/fiFIfBOQEgPWSzQV16f2EU7zAQ7DZkC+hYLDk1hJuy92es+9c1DoVGt4nRse
 zwUHN2WY3McuxFRzkR+YuyjhJ7+y5Ys7QM1zLZ8g+URkrFCMEHDcJUTzl2sOB5QzMccLO/rju
 cOsOjy0WIf0J3mLe5tCWZtDUA4pwbJnFlKeh3MJi1bJKJsybK7NuScwDWMKKL2SOiNlhTmkZl
 vSN437/oVlR/GmxiqXmlvQMEd94JzHalBaAUkQZ4V0EFnceV0cV9p4zET4JdmqGtPAQ8lGBV1
 vZ6nGNlFEdLsg5Vgl1vyVHHHy7sUhmjlqBPnNfIY3kN5aE4RsYV9KE5lluqkwPuID32XktJ0B
 sWa0rSu5ctgsjFpn
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This adds a reference to the dts of the Raspberry Pi Zero 2 W,
so we don't need to maintain the content in arm64.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm64/boot/dts/broadcom/Makefile                 | 3 ++-
 arch/arm64/boot/dts/broadcom/bcm2837-rpi-zero-2-w.dts | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2837-rpi-zero-2-w.dts

diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts/broadcom/Makefile
index c688203..5082fcd 100644
--- a/arch/arm64/boot/dts/broadcom/Makefile
+++ b/arch/arm64/boot/dts/broadcom/Makefile
@@ -5,7 +5,8 @@ dtb-$(CONFIG_ARCH_BCM2835) += bcm2711-rpi-400.dtb \
 			      bcm2837-rpi-3-a-plus.dtb \
 			      bcm2837-rpi-3-b.dtb \
 			      bcm2837-rpi-3-b-plus.dtb \
-			      bcm2837-rpi-cm3-io3.dtb
+			      bcm2837-rpi-cm3-io3.dtb \
+			      bcm2837-rpi-zero-2-w.dtb
 
 subdir-y	+= bcm4908
 subdir-y	+= northstar2
diff --git a/arch/arm64/boot/dts/broadcom/bcm2837-rpi-zero-2-w.dts b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-zero-2-w.dts
new file mode 100644
index 0000000..307ae69
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-zero-2-w.dts
@@ -0,0 +1,2 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "arm/bcm2837-rpi-zero-2-w.dts"
-- 
2.7.4

