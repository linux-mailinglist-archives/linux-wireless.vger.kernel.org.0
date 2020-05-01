Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED251C1B15
	for <lists+linux-wireless@lfdr.de>; Fri,  1 May 2020 19:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbgEARDR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 May 2020 13:03:17 -0400
Received: from mout.gmx.net ([212.227.15.18]:54439 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728975AbgEARDQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 May 2020 13:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588352587;
        bh=im7UoRGRqKTmxhp4QzZMb5sui+SkwX0MbHQyE4WNRh4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=PJsQ/R8E9aJ5gReDGn0eGTtHAjbO+cS6bIVE2l3zp7DA1cVrp/9ghI72RBVQ/ob7t
         GY+cqwA/6sNwGto1LLPJdv5yPGuFXYsdYhftSPfxWMjK5351S3Uw0OzSW++VdNvgGI
         4aex6ufg3J4qfh7K7+FtS0Z0m3acSKGry5gxXTgw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MKbgE-1jinaw3mAu-00KyZz; Fri, 01 May 2020 19:03:07 +0200
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
Subject: [PATCH] staging: wilc1000: Increase the size of wid_list array
Date:   Fri,  1 May 2020 19:02:39 +0200
Message-Id: <20200501170239.16917-1-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l8IGiAo/+ZjQsmQfamzYuV5ZICWBc4esNNlTP6qfdg60KXL+SFI
 TAoOphehrGDD5qftiHjSRkuwN9mrFcL6aMazBYOeG6MmGT/rZNvgt4NsRzg7L+zZEtGSA4Y
 b+9Dh9y1tV7hmF+QSTcejPH8ct6NGKp0ElRn/PKnkSJHnkOCLfA8JiCv2+rLiMGMgxh+U8m
 A8m18mv9ZgRTrcn+wWwBA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qG98HsMxVf0=:Nk6O7bJeZMQsMWt585Nx8H
 IS8Ll6KBFedpl1WmvXyemO1oswyIgz89xyMl6SlfEyQJvvk9HQHy4RbVl4GZfoWqi8v/2kXVR
 k5keEG9q1Em8V5vzHi6YecJaq1hw5WYn31ZPxZud7Tfq2dMEemUzwRI3rI3B6uM/qxX7nEyOR
 Xk56xGX7PpZQR8CgMYfCOTDSdieB7L1WCxAbx8FR9ji2NZzEJJw/0TY3xUQ8YBhPkxzcGfCEx
 Sp2mf0EPZG0kya4CCjk07pgWrzQpLppgZITx3ijKoUUGz5u9wEVG1ZrR53v9ua20yWi9G64cm
 h4JbS300kf/hAyR59HG3Bi2I43bAuTJncP11JAkETIKW6dCMNaOeVi+7GSajj+ic3ZhxesckE
 +ejs82H6C289QhMl1l5S0EHytBJ4ZaaOmK+VrY8vDUs3oVg/dcJYZEhdbm/twyswNfc+1129l
 NVVnpQdytgP/Vj8tJ0VwxAnjhz1uxrwXy5yIIaTGS+gSq3HnsoVC61J22Z0PchCzdVJu7MThP
 UUIkqulWaE5HzU0GnPhfB7rvIIJIFDleEdmek4vJ9siKwRhM0r876wRSnosQZtDuqqFMYAZa0
 /rg18PRghnnu+RPWnkzXtHsTwLzeAKYn8+4wYb8AYnATG82NFCnXA3Fd0ndmeq7kMZEnbyJtp
 OQhed3oRsAFfgn0kDVTOY3hTPZ6XYI7yo4aDzropnSAToAo4TfO9A3k6K5S0AKdq65L3o8Z86
 SkPVTLsr4o2UsSwbgmRDOKSHM3o3jpbFMwmPIxMMWzhcUgYDh5NmtHVgkXv8RjdmYvTBmcF9S
 GZDT60Qt7WppFLZsHigna/ZzDOR2Ax5c1Nm4JLriE/syQpkJ8xz+57N0mdxQv+YWtIDQPpuyw
 E/+/t1yFTIBTA0jbBwpdCtCrDml6ESfju6ofRnDhh+CurpL8Q2R3W71ffD8ujK50uOMuAQL5/
 MnO0nznr7XvgkTB5kCQzVeZ7JDJhrSo1R0C+tUBLdBax7ZJmcdPbsb3oPbmFgorCjaSl47Jdj
 QVmak2uddP+7WoLj3uBYqnOuWA8O2B0sGV2D1zVe+EBUwTC3PUGud2cfLWw34VckTkA+eT4VJ
 6BuYl4FxbvBuW+w4+gJS+bq32gDCuab1XU01MWcB3sZUl7/gbizNG4YzgC9ac1kGU9KtWCCkR
 wcCVwbmFuojubMUrylM9cTlf3YbbmXTinkYbDFaZwWvKk+pyyD6T9eX4SvURGbbCu1Z/cHcrE
 NWzra6Ae54LKajJUS
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Increase by one the size of wid_list array as index variable can reach a
value of 5. If this happens, an out-of-bounds access is performed.

Addresses-Coverity-ID: 1451981 ("Out-of-bounds access")
Fixes: c5c77ba18ea66 ("staging: wilc1000: Add SDIO/SPI 802.11 driver")
Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
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

