Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE8C1C2AA2
	for <lists+linux-wireless@lfdr.de>; Sun,  3 May 2020 09:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgECHwV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 3 May 2020 03:52:21 -0400
Received: from mout.gmx.net ([212.227.15.19]:41797 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726884AbgECHwV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 3 May 2020 03:52:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588492334;
        bh=A/nJWC7/FExLFiup0GI1qnhxkOVZJTAIzBKRg1zgUc0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Rag3U7TKXp21NW/Gg0bNvOoO2RLj/qr7r4o66Zg9ile0To2ViPtInK7ywZnfEqrvz
         hO1m/MsjAGgQj1bbAm/uWY7u5ygAHTM7QUBbSk9FhLb4E3vuEWUhVkQ9yIkRClfhUk
         NxTbnIZwUGhcyLH5FXY+b3kdVtp3tOIwzb96P9A0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MYeQr-1jhxTK3GU7-00VdXK; Sun, 03 May 2020 09:52:13 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Adham Abozaeid <adham.abozaeid@microchip.com>,
        Ajay Singh <ajay.kathat@microchip.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rachel Kim <rachel.kim@atmel.com>,
        Johnny Kim <johnny.kim@atmel.com>,
        Chris Park <chris.park@atmel.com>,
        Dean Lee <dean.lee@atmel.com>, linux-wireless@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Oscar Carter <oscar.carter@gmx.com>
Subject: [PATCH v2] staging: wilc1000: Increase the size of wid_list array
Date:   Sun,  3 May 2020 09:51:45 +0200
Message-Id: <20200503075145.4563-1-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qvvL1+SdxKFiDVKqX8vb6sp0013MXgY6KFNBrGzi5WW2EyekwOv
 FWuhJjXCK7zI8igLhf5vSxPSEnfeCACOKnQ6hNv95M9ZiskYE9+scneNjTNRtu0ArXuBJpQ
 cxERxtIi2SSadPM/7ieZSrUrEkiCHeco9TEFKC2o8W6Jz4LID71b4arcWELxR/PzF6XKyJb
 PPc5iySXyoC6FFzRcoXrQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6OILL9EKE3A=:1cyA5RM3VDcsMEboQaVktg
 7cjXo73+8YVzuMHXl+CbIGntoxU97ewALoHEB3atKeQbTYT1gwJbmTYsioHO5xR0GE5bZtOfK
 XPTW4oJt+q2fccnQwqBRaIUYwOrA5+7N6yrpJXW3mh6CVRRRI8UmBtZBWg9H2b83ZOqfw5nDF
 tmkez/E4GGl+2ix250wP50eNhvgKVk5uvm7mqsqVRYDyX2QZUbRs5ieR3RYP1rqmQgiP6ye4T
 tfQykdlgfD+uyLly16ChSSUabivJ2xLUhsHypEvmoT1JozIbOCEXKa2nI/mUtIItjW6js+SYh
 FnR742Gl7sIs6JFpdV6WZRRDCf9vWRFbAgzGcLunNWTBrEqATZrG/Y0iub23JDxK28K9SMAAU
 hPLH7w+dj615oIGdpLdhdNg+03f3hrhizBUIUtIVofao2eeMOLphl+RWp5Rewp651p9CoRPTq
 OGAkLNVlo7wLKXUIAmDDWuSkAP6zaDAp2kVJyE9/AxOYJnfMOO81mEDXtt1moRABKp2a5nlFD
 9J5QLdebWf/Ol0KglHiYE3o5sDWkmpkKzYw1MDUTPcgIr2CMR+3IzKdrINRFcoy9IQUc3c48k
 HmmZkCdou8QP58vQQacaSAOR//nO3cviWGmdI9RVKuCJf+55yU7nxcuaOFv1fdtkKVa4DtzC7
 bXddxdqbdZU9MDlWlS7yQit207cJCaeev42Q43tQNgF9q+HpBFkJTiKC6j9ymfEa/dnfFUcOL
 TfECkdmmoT5RzcqhTwg3jFbrhVBm7StnjZiU3RQlQFkg7MnJojdTRehdyf6YgA1aXByiXeyI5
 9b6ojM+4JF8G+VtBbsvxz4tIK0LPmhFT7c5I+p7mriOIK915ZCmSoFfaopg9tfmNKP7YMIWNC
 TBErbRH+JkDpy2Z+90AEX6OWaavNvuMCtULwbmZzjeoq8gKsMDINyqgywwhIFFCve3UPq7Tsk
 Mb5DC2gBqszPUXc+ZRS3eRuoI6CCQRb4mShZd5wuP8TkjcD1cenmz/Jk7Hf0XtPGSdBrCBxD3
 1Pw61d51lYHo0fiRs2w89KbK59Fl9NASjBGK4Vd/k4VXloNaWvR1vVmeey92+1U8gVdpCJWDK
 1tH2mPWAwiEi9uBqU67oz8Z5J2NX4dwZmqG9a2ovbi5BSdZhI1jyK8aHQppB9mt8h0Er81q45
 AUvJpglDCNCzMRRtNtf93pcrxpFVwS0p1eHCpyC1nwMQPps1/jrVh7/mN4ZOkMFeKZ7UG5LiY
 J+EhPqTp7LbPmlYW+
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Increase by one the size of wid_list array as index variable can reach a
value of 5. If this happens, an out-of-bounds access is performed.

Addresses-Coverity-ID: 1451981 ("Out-of-bounds access")
Fixes: f5a3cb90b802d ("staging: wilc1000: add passive scan support")
Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
Changelog v1 -> v2
- Fix the commit for the "Fixes" tag as Ajay suggested.

 drivers/staging/wilc1000/hif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wilc1000/hif.c b/drivers/staging/wilc1000/hif=
.c
index 6c7de2f8d3f2..128943c3be4f 100644
=2D-- a/drivers/staging/wilc1000/hif.c
+++ b/drivers/staging/wilc1000/hif.c
@@ -151,7 +151,7 @@ int wilc_scan(struct wilc_vif *vif, u8 scan_source, u8=
 scan_type,
 	      void *user_arg, struct cfg80211_scan_request *request)
 {
 	int result =3D 0;
-	struct wid wid_list[5];
+	struct wid wid_list[6];
 	u32 index =3D 0;
 	u32 i, scan_timeout;
 	u8 *buffer;
=2D-
2.20.1

