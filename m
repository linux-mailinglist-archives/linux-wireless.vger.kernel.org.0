Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649967548BB
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Jul 2023 15:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjGONXq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 Jul 2023 09:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGONXp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 Jul 2023 09:23:45 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973D5130
        for <linux-wireless@vger.kernel.org>; Sat, 15 Jul 2023 06:23:44 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-345e55a62d8so12585375ab.3
        for <linux-wireless@vger.kernel.org>; Sat, 15 Jul 2023 06:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malmoset.com; s=google; t=1689427423; x=1692019423;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cJzhqWxrQuVVS21st22aCtbQ2pu5dB25czC8+UhFcL4=;
        b=qZ/H/z1oNzx2iQvMEkxrSlP8RJ4JUzaEf9Jd1wWJJZJksZ6M04sSD5DaVB9LW5iJGD
         ZxU525SYKm1ApUC6WGDIXKy05h4f/5eQv5kREcA65MlHxpIQOyUhCBm5ChuoPzntEDIf
         m/3UWOlqnrgR+szCxkvUBK37smtsoVJWIJpA6m38756OagHmMbPs6hjzzKx1EgBf750k
         BYx7jkzgGWSk5olx9qtJJy9fYx5c5nIcBeGH28KhDEy3JLyACUa3X05xsAjgd1l3Xx+Q
         G5gGGX6IWN9HFNB15yA53JmwM+8+VZPidfeHDvNGdlI8iaDiurwOURevWy0/U2+uL931
         NRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689427423; x=1692019423;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cJzhqWxrQuVVS21st22aCtbQ2pu5dB25czC8+UhFcL4=;
        b=WaBq906usd6MjJIXrsFTDFNvzlQzjKoSNJVHAuF9UFQFzeEWNfB3WHq3Bhz1Mpg5Fw
         fCP6GMKRTqnYCm8TrcM97ZVoel/LXBwjEF17JBWTvmvc1+AoGZ4Gx0v/0jf6B4Ot4BOl
         iVg3X8ci6EI9Bafy7yNyYYVajC8nqJ2m9ort8znc9+6Z00pMMyNEAlcij1jUuEnfKhdn
         iAzkMiQc/e6u8ACQ2TckjrhVnabzpRgheYREoxXp0iElNMvi+w3kJLBnyllGgV0O81H6
         rADTnFSe+hfbrxHc1fkDHRzpZpNSPTXXAC+sV2jYmw80ZajBKJwt0xZa8GIIejE5Qrnq
         Cozg==
X-Gm-Message-State: ABy/qLbsn6GK9yp8x1vtYYVOp+X68Y/T8lrL1wJt89dl8/zeb89K/lsw
        sSPN/jVcX+gDPEq4I/GazDIjrWOj2xE7TEy3GO2JYw==
X-Google-Smtp-Source: APBJJlFnWyuql7rQ6EnoNCP6IOljGiSJG/rro4hHsjzN8RkLVggW+3hBnpQFl/C4joZz4iMPG8//Yg==
X-Received: by 2002:a92:d792:0:b0:345:b923:971a with SMTP id d18-20020a92d792000000b00345b923971amr7064461iln.0.1689427423476;
        Sat, 15 Jul 2023 06:23:43 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:ac77:5802:90a7:e853:ea81:2e60])
        by smtp.gmail.com with ESMTPSA id m10-20020a924a0a000000b003317ebbc426sm3493594ilf.47.2023.07.15.06.23.42
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Jul 2023 06:23:42 -0700 (PDT)
From:   Sean Mollet <sean@malmoset.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: [PATCH] RTW88 firmware download issues - improvement, but not perfect
Message-Id: <491EE697-0DFE-433A-97EA-F7D40E9FE0A5@malmoset.com>
Date:   Sat, 15 Jul 2023 08:23:32 -0500
To:     linux-wireless@vger.kernel.org
X-Mailer: Apple Mail (2.3731.600.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I=E2=80=99m attempting to debug intermittent firmware download issues =
that occur with rtw88 on an RTL8821CU. I did not have these problems =
with the Realtek OOT driver (using morrownr=E2=80=99s version).

Based on GitHub issues I=E2=80=99ve found, this same problem seems to =
also occasionally occur with other chips in the family, including PCI-E =
ones.

Example dmesg including some telemetry I added to narrow down the issue:

[   28.486954] rtx88: Loading firmware rtw88/rtw8821c_fw.bin
[   28.492907] rtw_8821cu 1-1.5:1.0: Firmware version 24.11.0, H2C =
version 12
[   28.988012] check_hw_ready failed
[   28.991624] rtx_88 failed in download_firmware_validate
[   28.998626] rtw_8821cu 1-1.5:1.0: failed to download firmware
[   29.012373] rtw_8821cu 1-1.5:1.0: failed to setup chip efuse info
[   29.018749] rtw_8821cu 1-1.5:1.0: failed to setup chip information
[   29.029496] rtw_8821cu: probe of 1-1.5:1.0 failed with error -22

It=E2=80=99s failing in mac.c, in the call to =
download_firmware_validate. The register contains 0x4078 instead of the =
0xC078 that is usually present after a download.

Comparing this to the OOT driver, I noticed that the order of operations =
at the end of the process is different. In rtw88, lte_coe_backup is =
restored before checking the register. In the OOT,  it=E2=80=99s done =
after. Another difference is that the check loop in OOT has a much =
larger count and a larger delay. I applied both of these changes to =
rtw88 and the failure rate decreased significantly. It is still non 0.

I happen to have a nearly ideal test lab for exploring this problem in =
that I=E2=80=99ve got a factory full of embedded systems with the =
RTL8821CU chip attached to an automated boot/provisioning system. I can =
make a change and deploy+test on 10s or even hundreds of devices in a =
few minutes.=20

I don=E2=80=99t have chip documentation, so I=E2=80=99m shooting in a =
dark a bit here. My suspicion is that this is a race condition either in =
the rtw88 driver or in the hardware or the interaction between the two. =
It also seems to be exacerbated by high IO on the host CPU during driver =
loading. I=E2=80=99m further exploring the differences between the OOT =
driver and rtw88=E2=80=99s handling of firmware download, since I=E2=80=99=
ve never seen this happen with the OOT driver.

References:

=
https://github.com/morrownr/8821cu-20210916/blob/main/hal/halmac/halmac_88=
xx/halmac_fw_88xx.c
Line 205 restores the lte_coe_backup. The equivalent of the check in =
download_firmware_validate happens inside the call to flfw_end_flow_88xx =
on line 201, the opposite order compared to what
Line 666 sets the check loop, equivalent to rtw88's =
download_firmware_validate function to 5000 cycles and the delay used is =
50 uS on line 678.

diff --git a/mac.c b/mac.c
index 298663b..d595711 100644
--- a/mac.c
+++ b/mac.c
@@ -794,15 +794,15 @@ static int __rtw_download_firmware(struct rtw_dev =
*rtwdev,

        wlan_cpu_enable(rtwdev, true);

-       if (!ltecoex_reg_write(rtwdev, 0x38, ltecoex_bckp)) {
-               ret =3D -EBUSY;
-               goto dlfw_fail;
-       }
-
        ret =3D download_firmware_validate(rtwdev);
        if (ret)
                goto dlfw_fail;

+       if (!ltecoex_reg_write(rtwdev, 0x38, ltecoex_bckp)) {
+               ret =3D -EBUSY;
+               goto dlfw_fail;
+       }
+
        /* reset desc and index */
        rtw_hci_setup(rtwdev);

diff --git a/util.c b/util.c
index ff3c269..fbd6599 100644
--- a/util.c
+++ b/util.c
@@ -10,11 +10,11 @@ bool check_hw_ready(struct rtw_dev *rtwdev, u32 =
addr, u32 mask, u32 target)
 {
        u32 cnt;

-       for (cnt =3D 0; cnt < 1000; cnt++) {
+       for (cnt =3D 0; cnt < 5000; cnt++) {
                if (rtw_read32_mask(rtwdev, addr, mask) =3D=3D target)
                        return true;

-               udelay(10);
+               udelay(50);
        }

        return false;
--=
