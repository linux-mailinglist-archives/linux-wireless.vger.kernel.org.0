Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B462DD4FF
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Dec 2020 17:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbgLQQOh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Dec 2020 11:14:37 -0500
Received: from mout.gmx.net ([212.227.15.15]:58331 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728557AbgLQQOh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Dec 2020 11:14:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608221582;
        bh=H/K6LcxaUKdmSw0wEx0G2afNapJefkNpyXyrVK6Aap0=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=cqXAd53eTa4nRQPRx4iPtHfWGyieS7D3JHKmYE8VI17KlI7iU13fs1IPydSl2le8q
         v3cV2RkPgf/HJw2piTPf7BT4BHmk8sYqes3K4+Mv8MW4U9nw82TdBtOm22/KubtUhJ
         nsrbVmCC8qg+NF0MXG2/YWYe6za4glpJq9BiRzOE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from E480 ([188.105.239.238]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MG9kM-1ktIUU1bqO-00GW9w; Thu, 17
 Dec 2020 17:13:02 +0100
Date:   Thu, 17 Dec 2020 17:13:02 +0100
From:   Zhi Han <z.han@gmx.net>
To:     linux-wireless@vger.kernel.org
Cc:     kuba@kernel.org
Subject: [PATCH] mt7601u: process URBs in status EPROTO properly
Message-ID: <20201217161302.GA12562@E480>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:yjSfMX+ggaOTtZFbwNaz5Ro7oygNbamaGQX+dUQ/S/vuKvl0VU7
 G/BCn7Yd8mm/Zm4Umrsgra++CX+bpzK5ZIjf9v5I333ZHZMswEdhHD5Ih9sKcmuxSReeLHe
 QbvCMw4NEtNZi/ib2p0N9I4n5s3/gxZFq8oEm0TXDw5ZYTlSrTRJ5aK+NF9j8e2c9ok2yoU
 VmF4Q6N4faxZNPT+nPEuQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:eOmwB5Jj+AM=:pNg97+f2GS3HRapKbLJ9NT
 2zWc4SfxlOMW9NA3DlihhDb3Zh+4EGFn93oBJZIZ5u5vQ8iL7SUcCobYbgQ5ijL+gvdq0a5/s
 Xyn8inXyyhVNsGWu1W431zZzaFH125KAl55lNeyxQZ1Udv3pZiPdr81yMwurVGpZ7w3S/YAjl
 /2fPPohQme8jfmU5bnaNJEQrq/wl5eqzaLIMu6gcTjMhc8XrwEfWcK6ebRdrLY3STIVRmSNNX
 vxDb85l8+Nkc2zFfHBGrtp7HnJCfPcBP8PpTSYyO22Z4AHT//M1e6V09yuseDfJeBVZmiChKh
 o+NeWxDG6Mb5eAYk2x6vMM9Ap+dvLC6gxXrxWUmJt0Ov5qS9+xF9PlljPl2h+RPgmABjZ6+IN
 plxTdEmOZ5WmUzqBQtN2HRkTFDzaW3D18gYIXzYKZe8G79BXGuEl71mo6vP1jena59mkfJPrU
 xAKZ7XSI/71MXvBNPTY8ifvMSAvWm1va+Qq0w4JHOpywSBPQa/vk20Pifc6BonBpPBH8GtBAN
 DkjcWh56GXLYXx5VXh8uVD/pgq0w8M0nr42VLBTrhe2fulgHEjWamkTujAvD9xSGg1hzaesoK
 uN1clBrCWhi/4Bp8WVxG4xXr8A9+RJ1ZdVheJ+cwZ/cPRw0cK+fiaeiVTHJg6RJZl0SuELnNf
 teO6Uz1JidJi9H8X7qQjXOhyJ2BL1SZRpI4Vj8c1UKfCuxCgmS2BZFFcdHoWNl8/8MW5wQ5hD
 t7n+Kfuw9ipzKHA8weG2z8oq6GqBkggNiZ9hm3WKynQAOrF/ofm59JousEn1PUVerzKPrGm+J
 kjpgogH/PW+gVpkieFGOtQxzZ2Bx9Zppyz5/0jtU5gtMOdK56WAtFe2RsfL6UDEm7Wwt8L7mR
 OyDw/liYBOtiwHkG2Kpw==
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When the usb device being plugged out, before the usb_driver:disconnect
called by e.g workqueue, it is possible that some URBs are still in
processing, and being marked as EPROTO in host controller.

Those URBs should not be scheduled in complete_rx callback function to
get further processing.

Signed-off-by: Zhi Han <z.han@gmx.net>
Acked-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/wireless/mediatek/mt7601u/dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt7601u/dma.c b/drivers/net/wireless/mediatek/mt7601u/dma.c
index 09f931d4598c..7a9ab787cf3d 100644
--- a/drivers/net/wireless/mediatek/mt7601u/dma.c
+++ b/drivers/net/wireless/mediatek/mt7601u/dma.c
@@ -192,6 +192,7 @@ static void mt7601u_complete_rx(struct urb *urb)
 	case -ECONNRESET:
 	case -ESHUTDOWN:
 	case -ENOENT:
+	case -EPROTO:
 		return;
 	default:
 		dev_err_ratelimited(dev->dev, "rx urb failed: %d\n",
