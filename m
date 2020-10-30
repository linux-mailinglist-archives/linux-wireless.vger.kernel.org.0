Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD522A05B2
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Oct 2020 13:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgJ3MpM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Oct 2020 08:45:12 -0400
Received: from dvalin.narfation.org ([213.160.73.56]:40136 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgJ3MpM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Oct 2020 08:45:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1604061908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=hcGNXoxVuwEEEyeyR1+KamTg81XMipizN4MgTzx567k=;
        b=khalIXAeXbJfzaKY4u4eDn28ZsE+X/+9xcya6uhY6c6yojb5qD6g+N9Hl6DP08Mk41KJt5
        9WAVWy9G4tsgjZU+5Bb1l7mNH3u+J6+b3kNA4rs2Irj8UIzMlGd8Ozat6lzJFFdEqzI6zm
        q3JwMmXcqy00Ym36psBhOWl9erZQnFQ=
X-Mailbox-Line: From sven@narfation.org Fri Oct 30 12:34:21 2020
From:   Sven Eckelmann <sven@narfation.org>
To:     ath11k@lists.infradead.org
Cc:     sw@simonwunderlich.de
Subject: ath11k: Country code setting ignored on bootup
Date:   Fri, 30 Oct 2020 13:34:21 +0100
Message-ID: <1829665.1PRlr7bOQj@ripper>
X-KMail-Identity: 80820071
X-KMail-Transport: 1618418458
X-KMail-Fcc: 45
X-KMail-Identity-Name: Sven Eckelmann
X-KMail-Transport-Name: narfation.org
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1669516.2VI8MhZXb1"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart1669516.2VI8MhZXb1
Content-Type: multipart/mixed; boundary="nextPart1843920.GhX3yNMNC5"; protected-headers="v1"
Content-Transfer-Encoding: 7Bit
From: Sven Eckelmann <sven@narfation.org>
To: ath11k@lists.infradead.org
Cc: sw@simonwunderlich.de
Subject: Country code setting ignored on bootup
Date: Fri, 30 Oct 2020 13:34:21 +0100
Message-ID: <1829665.1PRlr7bOQj@ripper>

This is a multi-part message in MIME format.

--nextPart1843920.GhX3yNMNC5
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

just tested here with HK01 based board. The firwmare 
WLAN.HK.2.1.0.1-01228-QCAHKSWPL_SILICONZ-1 doesn't show this problematic 
behavior all the time but 2.4.0.1.r1-00026-QCAHKSWPL_SILICONZ-2 or WLAN.HK.
2.4.0.1.r1-00019-QCAHKSWPL_SILICONZ-1 does.

With 2.1.0.1 I could basically do following:

    iw reg set CA
    echo "c000000.wifi1" > /sys/bus/platform/drivers/ath11k/unbind
    echo "c000000.wifi1" > /sys/bus/platform/drivers/ath11k/bind

and the global and self managed country codes were still all CA (in many 
tests). But with 2.4.0.1, they will end up with CA as global and US as self 
managed. I can see that the country code change is correctly send by cfg80211 
when the HW is initializes but the 2.4.0.1 firmware just ignores it.

I can see following send command by ath11k in ath11k_wmi_send_init_country_cmd:

    00000000: 38 00 61 02 00 00 00 00 00 00 00 00 43 41 00 00

and I also receive a CA answer for that. But the response from the firmware comes
in when the ATH11K_FLAG_REGISTERED bit is still not set. Thus it is rejected by
ath11k_reg_chan_list_event for the regd_update_work.

This seems to be a race between receiving the 
"ATH11K_QMI_EVENT_FW_READY" event and the ieee80211_register_hw() in 
__ath11k_mac_register. The ieee80211_register_hw will make the hw responsible 
for handling the regd updates but they will not be correctly processed until 
the ATH11K_QMI_EVENT_FW_READY was handled by the firmware. And if the regd 
change was processed after ath11k_regd_update was called in 
__ath11k_mac_register (but before the ATH11K_QMI_EVENT_FW_READY was processed)
then we will just loose the regd change.

So I am a little bit baffled why ATH11K_FLAG_REGISTERED is bound to something 
which is not related to the  IEEE802211 registration code. Sounds to me like 
somebody wanted a FW_READY flag but misused the ATH11K_FLAG_REGISTERED flag 
for this purpose.

Btw. there are similar problems with the use of ATH11K_FLAG_REGISTERED in context
of ath11k_debug_pdev_create, ath11k_mac_register and ath11k_mac_allocate.

Maybe something like the attached patch could be used to improve this situation.

Kind regards,
	Sven
--nextPart1843920.GhX3yNMNC5
Content-Disposition: attachment; filename="0001-ath11k-Accept-new-regdomain-during-initialization.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0001-ath11k-Accept-new-regdomain-during-initialization.patch"

>From 931e5eb59e64804f3a90598b26c56643c43deb35 Mon Sep 17 00:00:00 2001
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 30 Oct 2020 12:02:21 +0100
Subject: [RFC PATCH] ath11k: Accept new regdomain during initialization

The driver is registering as iee80211_hw with its OPs and is then able to
be called by the upper layer. This for example happens early in the phase
when the correct regulary domain should be set. But the regulary domain
will only be accepted when the ATH11K_FLAG_REGISTERED flag was set after
the ATH11K_QMI_EVENT_FW_READY was processed. So it can easily happen that
the regularly domain is not correctly processed when
ATH11K_QMI_EVENT_FW_READY isn't handled immediately:

  $ iw reg set CA
  $ iw reg get|grep country
  country CA: DFS-FCC
  country CA: DFS-FCC
  country CA: DFS-FCC

  $ echo "c000000.wifi1" > /sys/bus/platform/drivers/ath11k/unbind
  $ echo "c000000.wifi1" > /sys/bus/platform/drivers/ath11k/bind
  $ iw reg get|grep country
  country CA: DFS-FCC
  country US: DFS-FCC
  country US: DFS-FCC

It is therefore essential to accept the regulatory changes without having
seen the ATH11K_QMI_EVENT_FW_READY. And since there are also potentially
more problems in ath11k_debug_pdev_create, ath11k_mac_register and
ath11k_mac_allocate with their use of ATH11K_FLAG_REGISTERED, it is better
to move the ATH11K_QMI_EVENT_FW_READY. to a new flag.

Tested with WLAN.HK.2.4.0.1.r1-00019-QCAHKSWPL_SILICONZ-1

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 drivers/net/wireless/ath/ath11k/core.h | 2 +-
 drivers/net/wireless/ath/ath11k/mac.c  | 2 ++
 drivers/net/wireless/ath/ath11k/qmi.c  | 4 ++--
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 18b97420f0d8..1d214eed9ea1 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -170,7 +170,7 @@ enum ath11k_scan_state {
 
 enum ath11k_dev_flags {
 	ATH11K_CAC_RUNNING,
-	ATH11K_FLAG_CORE_REGISTERED,
+	ATH11K_FLAG_FW_READY,
 	ATH11K_FLAG_CRASH_FLUSH,
 	ATH11K_FLAG_RAW_MODE,
 	ATH11K_FLAG_HW_CRYPTO_DISABLED,
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 7f8dd47d2333..00aca46505a6 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -6280,6 +6280,8 @@ static int __ath11k_mac_register(struct ath11k *ar)
 		 */
 		ar->hw->wiphy->interface_modes &= ~BIT(NL80211_IFTYPE_MONITOR);
 
+	set_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags);
+
 	/* Apply the regd received during initialization */
 	ret = ath11k_regd_update(ar, true);
 	if (ret) {
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index c2b165158225..417f63d9fb6d 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -2612,7 +2612,7 @@ static void ath11k_qmi_driver_event_work(struct work_struct *work)
 			ath11k_qmi_event_load_bdf(qmi);
 			break;
 		case ATH11K_QMI_EVENT_FW_READY:
-			if (test_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags)) {
+			if (test_bit(ATH11K_FLAG_FW_READY, &ab->dev_flags)) {
 				ath11k_hal_dump_srng_stats(ab);
 				queue_work(ab->workqueue, &ab->restart_work);
 				break;
@@ -2620,7 +2620,7 @@ static void ath11k_qmi_driver_event_work(struct work_struct *work)
 
 			ath11k_core_qmi_firmware_ready(ab);
 			ab->qmi.cal_done = 1;
-			set_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags);
+			set_bit(ATH11K_FLAG_FW_READY, &ab->dev_flags);
 
 			break;
 		case ATH11K_QMI_EVENT_COLD_BOOT_CAL_DONE:
-- 
2.28.0


--nextPart1843920.GhX3yNMNC5--

--nextPart1669516.2VI8MhZXb1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl+cCE0ACgkQXYcKB8Em
e0ZbWhAAjZ7OGMvFIYXT5cKo0xE5ubbOAtaLxciVgqeaku0ZK34LxJMU4bQm0dXc
jgVeo5grN26wGcr0kDslbS4RnZ2C8BBxNsHG+e45wKCRCwymnOcpqW566/KjcA61
ciIy4FU49F36hbrUuWjEMe7kG7XRZVK2ocY3J8Rp5wd8uXYoK374q1yTuGXeIkVb
vIdT39YJWSTXVEc/62G/l6vfdHmmqQHonsRg0B6KISeyAyuZ69rLjaJIAazb7vOr
P1lUUrwrXhhkiQ1j2G0Lmmz5qzx+scqCfp8T2l+bTPa1D67ND3dByT1ntVfSuRiS
7eLFfmWeAtjXxS2fnE5CHnlp94ri845TLQaOVVz3srKCynSxIBd0r5cfTvmSAgkU
D5IkQu1KqNKVOJeaUw6JpxdOsiBArdhawwxiKjx8oEHgxiiq+uqWDI+W6nqU+ymg
qZo957qeYHKaiyySv0D93/ykN26tj8iruX4ORJj2XLs9w8a4ER/hjyt6IBYozNWh
Bh5TSrqZr0NIO9bC1gVO5GNgCu3NTkBh5PznO/ZKkvJCmDObarz+n8R7awsh3PMN
Pu8PxNPjLAFztCIEKiMaXmYrDhcGSlUCYgAgyLzF4ZNgONs3CzFPWNFfICj54lhB
MQo0KKKGsRp8h08lSoO36/KKBG3BAKRkAcMGuwRS6L3FAvBhZbc=
=EGTx
-----END PGP SIGNATURE-----

--nextPart1669516.2VI8MhZXb1--

