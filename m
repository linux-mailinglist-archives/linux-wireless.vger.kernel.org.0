Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8167B391F
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Sep 2023 19:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbjI2Rqz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Sep 2023 13:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbjI2Rqz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Sep 2023 13:46:55 -0400
X-Greylist: delayed 490 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 29 Sep 2023 10:46:51 PDT
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc0d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99E51AC
        for <linux-wireless@vger.kernel.org>; Fri, 29 Sep 2023 10:46:51 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RxyHz69fRzMqF4h
        for <linux-wireless@vger.kernel.org>; Fri, 29 Sep 2023 17:38:39 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4RxyHz3dgyzMppKM
        for <linux-wireless@vger.kernel.org>; Fri, 29 Sep 2023 19:38:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ik.me; s=20200325;
        t=1696009119; bh=APNJRGEIuPUzEgOA6UgSotjXQE6zefsp4oWdAfpcvg8=;
        h=Date:To:From:Subject:From;
        b=WVi073GJIuqoVu91G9VYywLeOC5XjLj7c2bEbE0ZY3j2QO7bcc7u/GGxKcPyCGry8
         z5tsBD28HLL/NoFfrsQHiI33STuVvpOHeyc5uHRtGWHQ9obxzjABvSl3LB/J8qO24q
         pqiSJJWYA6l46ptJIUYkX3FL3XGiQjBBGO58epaA=
Message-ID: <1642436c-9046-1abe-c65b-880df9096038@ik.me>
Date:   Fri, 29 Sep 2023 19:38:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
To:     Linux Wireless <linux-wireless@vger.kernel.org>
Content-Language: en-US
From:   Fourhundred Thecat <400thecat@ik.me>
Subject: ath11k_pci: failed to connect to HTT: -110
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_STARTS_WITH_NUMS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

I have Qualcomm QCNFA765.
I am using custom-compiled kernel 6.1.55. I have ath11k_pci in the 
kernel, and all firmware files are loaded successfully. Yet, when 
booting, I see on the console:

ath11k_pci: Service connect timeout
ath11k_pci: failed to connect to HTT: -110
ath11k_pci: failed to start core: -110

and the network device wlan0 does not exist.

But lspci -v shows the network card, and module it is using.

and dmesg | grep ath11k

ath11k_pci: BAR 0: assigned [mem 0x90600000-0x907fffff 64bit]
ath11k_pci: enabling device (0000 -> 0002)
ath11k_pci: MSI vectors: 1
ath11k_pci: wcn6855 hw2.1
ath11k_pci: chip_id 0x12 chip_family 0xb board_id 0xff soc_id 0x400c1211
ath11k_pci: fw_version 0x11090c35 fw_build_timestamp 2022-04-18 20:23 
fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.9
ath11k_pci: leaving PCI ASPM disabled to avoid MHI M2 problems
ath11k_pci: failed to receive control response completion, polling..
ath11k_pci: Service connect timeout
ath11k_pci: failed to connect to HTT: -110
ath11k_pci: failed to start core: -110
ath11k_pci: ignore reset dev flags 0x4000
ath11k_pci: ignore reset dev flags 0x4000
ath11k_pci: failed to wait wlan mode request (mode 4): -110
ath11k_pci: qmi failed to send wlan mode off: -110

since I am using custom kernel, it is possible i am missing some kernel 
option. Here is my kernel config

https://ctxt.io/2/AABQk4VZEg

can somebody please tell me what is the problem ?

thank you,
