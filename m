Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A142B1C3E2F
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2020 17:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbgEDPJu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 May 2020 11:09:50 -0400
Received: from mout.gmx.net ([212.227.15.19]:43113 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729515AbgEDPJt (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 May 2020 11:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588604979;
        bh=5loQbnk5NzbdzYd9Vk2CFzQKt669ofY6RVhvD5r8rX0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=QGT2dG5XrSqusHhmUSKETajsJUCzEMUKnHGL4DT+5trX/C16MX4U8Em63WHjMf8Kn
         6a0J21yxGprPty1u7LkQ7jSAM7WQmxPQ+CxXm80VU1dyyP/WzeE4s7Wh2lxCyFfNk4
         su3u2wqXRSVtE/SG+47QvM9k3kgpNy6odbr7IhCg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1Mv2xO-1jEEQl02Nc-00r0Kn; Mon, 04 May 2020 17:09:39 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Adham Abozaeid <adham.abozaeid@microchip.com>,
        Ajay Singh <ajay.kathat@microchip.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rachel Kim <rachel.kim@atmel.com>,
        Johnny Kim <johnny.kim@atmel.com>,
        Chris Park <chris.park@atmel.com>,
        Dean Lee <dean.lee@atmel.com>, linux-wireless@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Oscar Carter <oscar.carter@gmx.com>,
        Joe Perches <joe@perches.com>
Subject: [PATCH v3] staging: wilc1000: Increase the size of wid_list array
Date:   Mon,  4 May 2020 17:09:11 +0200
Message-Id: <20200504150911.4470-1-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5pPDLQd5++qssZG6TMTxGpMEttxumBk/4aGEoRct66eTHm8ldCN
 YnuIjwLrdECATPGnJiY+r7pSiZxApOBATlP7LV0YJaKBsB0HQMxt3Aho+3JvuIq+jVLOJQ4
 xawRGXuP1UopMQjQxDvgJxnwdVogowxEc9FmDJm7if0FBR7w4fVRb8Beg1bDINJth82vNNp
 ilP2IVzo3PM7Y3kkj0BqA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gsvCyAo8ljA=:dKZAYnhYCM2NY9MiygSsDl
 rqcz3/ey24oi6oyTX9kgpQp9tX9R2TPsi8A8yUgScdf+LSWbq+p+2eKWebYnSHrKYaaqDMjai
 QS62p6zlyiLUmiHQdz8AjfAnMROpivf2GqSWk6zzjztRr2Ep5IX6WvIKhBZRWEW1hoD+ZNohQ
 e0uNJhsmilKjfUiwyO4sBh8NyxlSTI0I2x3s7tfe4LmDiyJHY1GtPxz08dNqxcQrxtDH3QoCr
 +feKlR+esGl0QVVht0KJsP44U2I1LpnshrO9UHISln8WO04mda9Jd6TGt7Fy6EFH2i2q2JqIk
 XgYV/wWjPu40h10QPR1AQ+uDS4GKUcukmIvW4+kwHVNZ8DdwT6DYGUdPt5u4W/qIfZzkjNU2K
 9USeJMo9BA0QLmxzJ9tCNFRubUJgssD2Yuh2IJaTUWBTIUcpII0bm+/VhyKKS1nThERLbvf0v
 SH72YHzqbxqUQW8XN5IIx1V3AGN0d4KeRnvFsQJI+GpIArVn1DkJD4iGD3SZxm8sYYFf8ZkVY
 0e42G4128D1mhnsCCqimmOs7mLhChe2Dn1k3WIwa07Hs6/m6jhbxzu28O1Zzb5Iv+UUX1drxg
 weGQsOvwO2WyMBgBVVEuHj+EvVenLa7cjwGQUqQkceCztlVxo7aCySHxW2X8o+FBeiE1XOy3O
 HQ0IpulEZPJEuNWvk9dtCMn3N5xMS9NQA20xnNfK3YYFU9+BuYvKF0XZEhiAMO5zvPRcCJA4u
 w16foxr4XceiDy6ofMm2ZKodhyQ6qLPMA48itkRPHC+DmUhyslOx9HCoTuGEH1j38H0ioTKNF
 M76XQJRHQu4bnEEsSS8U6htxEddbRJETm5xgB5Sdg6PD9DWJ9/NvjXpnwSrn0ighhrOGQ9gEu
 8j50uDvs1n2VzFqV8cZaIYlnglD7gl26QI+kZNXo0jk9VZ14SuAfgutZHYi7KzuCaYM3CrDa2
 QnZgrXnMgtHv0Fo2tnuchM9svGmqWwoL53I2gMP6WWsaRLt8w5iPmeV3YWYwxExXUKOD8RslP
 IELu5eXiJcpbTy+jM6hiqyoaGS8AeAb1yTli+RyjaqrQ9AnAanPkY/YRfxAcgsEIfelP1Ysaf
 ofIGYcc7MSH7K/DPq7jkuGlVpMvzdyPN6z6jTjyAFfr8tGnjlpywNv132gkgh2CN8FfkxzZt9
 2XQVHn5xLudFrsf3LwFGQnkyAOPA3XwEIAu2ABGsqFzOnIIQkeV8zVRv+88iPU5iFDGQqB5qk
 s5nqYEVKurKxVh4u3
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Increase by one the size of wid_list array as index variable can reach a
value of 5. If this happens, an out-of-bounds access is performed.

Also, use a #define instead of a hard-coded literal for the new array
size.

Addresses-Coverity-ID: 1451981 ("Out-of-bounds access")
Fixes: f5a3cb90b802d ("staging: wilc1000: add passive scan support")
Acked-by: Ajay Singh <ajay.kathat@microchip.com>
Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
Changelog v1 -> v2
- Fix the commit for the "Fixes" tag as Ajay Singh suggested.

Changelog v2 -> v3
- Use a #define instead of a hard-coded literal for the array size as Joe
  Perches suggested.
- Add the "Acked-by" tag.

 drivers/staging/wilc1000/hif.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/wilc1000/hif.c b/drivers/staging/wilc1000/hif=
.c
index 6c7de2f8d3f2..d025a3093015 100644
=2D-- a/drivers/staging/wilc1000/hif.c
+++ b/drivers/staging/wilc1000/hif.c
@@ -11,6 +11,8 @@

 #define WILC_FALSE_FRMWR_CHANNEL		100

+#define WILC_SCAN_WID_LIST_SIZE		6
+
 struct wilc_rcvd_mac_info {
 	u8 status;
 };
@@ -151,7 +153,7 @@ int wilc_scan(struct wilc_vif *vif, u8 scan_source, u8=
 scan_type,
 	      void *user_arg, struct cfg80211_scan_request *request)
 {
 	int result =3D 0;
-	struct wid wid_list[5];
+	struct wid wid_list[WILC_SCAN_WID_LIST_SIZE];
 	u32 index =3D 0;
 	u32 i, scan_timeout;
 	u8 *buffer;
=2D-
2.20.1

