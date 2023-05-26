Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19966712C17
	for <lists+linux-wireless@lfdr.de>; Fri, 26 May 2023 19:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjEZRz5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 May 2023 13:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjEZRz4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 May 2023 13:55:56 -0400
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508A5A4
        for <linux-wireless@vger.kernel.org>; Fri, 26 May 2023 10:55:54 -0700 (PDT)
Date:   Fri, 26 May 2023 17:55:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1685123752; x=1685382952;
        bh=LfPI5yLmcVzJvRmZZg6b6ZL754UI72XeZwVc220tpYc=;
        h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=aC+9m2XllgUSgqySO/jbwHwi5X+9A6TEC1kdssOVREhUdPhyO0pkXxPNw8kmgg73z
         g7uDBgfuQSLjPMkKfHbe/NRLl7hA3XM9JqhEea/7opXY48s0yfbrPOcYnfWh9vtRc6
         ojJO5CHqdQXCokFKYOb2p60vTQwmED/FqpKGlV6W26zJHzZ6ZpI6kEL1OC6WDGQPvz
         e1I1bd6HVKT7omARhaE96+HY1szOC6Mmqypw2SgPr2BcWZlTWst6Lfh+N2A7EzZb66
         LIcO2WPifDLI7JtO8Q/kPbsfxyeSJz9fB5owJULtM/0DgRfZgyb9s7P3BV8qneZC2L
         6sPn95ftvk4Ug==
To:     linux-wireless <linux-wireless@vger.kernel.org>,
        Gregory Greenman <gregory.greenman@intel.com>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: iwlwifi: AX201 misdetected as AX101
Message-ID: <gAwMzXEPlQZUgbc6n3yYY2soROKl4-D_JfWwoHW8CMx-LDkDEeAlwcyjOMy767W3eEVxS-e7oEihVh1PNHT-_iznSKneJjW0vu0PN7aQ9K8=@protonmail.com>
Feedback-ID: 20568564:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi all,

I have an Acer Aspire A315-58 laptop[0], which, according to lspci has the =
following intel wireless chip:

   Device:=0900:14.3
    Class:=09Network controller [0280]
   Vendor:=09Intel Corporation [8086]
   Device:=09Wi-Fi 6 AX201 [a0f0]
  SVendor:=09Intel Corporation [8086]
  SDevice:=09Wi-Fi 6 AX201 [0244]
      Rev:=0920
   ProgIf:=0900
   Driver:=09iwlwifi
   Module:=09iwlwifi

However, in the kernel message buffer, the following message is written:

  [    3.633490] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6 AX101, REV=
=3D0x351

Also, this chip did not work with the 6.3.3 Arch Linux kernel, the driver l=
oaded the
`QuZ-a0-hr-b0-74.ucode` firmware:

  [    6.516505] iwlwifi 0000:00:14.3: WRT: Collecting data: ini trigger 13=
 fired (delay=3D0ms).
  [    6.517615] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
  [    6.517616] iwlwifi 0000:00:14.3: Transport status: 0x0000004A, valid:=
 6
  [    6.517617] iwlwifi 0000:00:14.3: Loaded firmware version: 74.a5e9588b=
.0 QuZ-a0-hr-b0-74.ucode
  [    6.517619] iwlwifi 0000:00:14.3: 0x00000084 | NMI_INTERRUPT_UNKNOWN  =
    =20
  ...
  [    6.861510] iwlwifi 0000:00:14.3: Failed to run INIT ucode: -110


I then noticed that firmwares 75-77 are available and that there were recen=
t changes
to the iwlwifi module that increased IWL_22000_UCODE_API_MAX, so I gave it =
a go,
and built the kernel at ae8373a5add4ea39f032563cf12a02946d1e3546 and now fi=
rmware 77
is loaded, and that seems to work, at least I did not notice any issues so =
far.

The full logs and other information about the laptop can be found here[0].


Regards,
Barnab=C3=A1s P=C5=91cze


[0]: https://linux-hardware.org/?probe=3D43069955ee
