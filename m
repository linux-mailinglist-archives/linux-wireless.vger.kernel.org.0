Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F420251CEE2
	for <lists+linux-wireless@lfdr.de>; Fri,  6 May 2022 04:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387906AbiEFBV0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 May 2022 21:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387901AbiEFBVN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 May 2022 21:21:13 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E16F612A6;
        Thu,  5 May 2022 18:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651799824; x=1683335824;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wcyBJZH+vYN1HhxctYVkkelKqQBprmPwo3C9ybF62sc=;
  b=l1x+FGoJwpIZWnnYO7eaCGso8DDIbvJyTcdt55Fi3/wmV/5IPnGeIkCV
   6Fx8o6h8JmKYoXL+Pj8c5a9V2Z6b9XpGBGKBRDRWSxE3JVau5++IKEmhG
   f39h2N5XuKo0Yt1KCSEJkn7SEVexFNrI2GWwTu659i6wGNtR4RyG/+0C9
   EkPQnvPeMdqGOyYNctOLz9f2/d0qEOvnS3hNXW758xuGb799AblfzXJGn
   1RAtSlaWd2ARbwjKwfz2hXutfvE1wUyOoDlJ8c46lGmvEXid5rGmxOn2n
   KFx+ebhT9RpSS20wbEtxpoEOoV7XdGVZw2U0NL30TQ1AgflFbXPPEPuRP
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="265902510"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="265902510"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 18:16:56 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="654482509"
Received: from kdjohns3-mobl1.amr.corp.intel.com (HELO rmarti10-nuc3.hsd1.or.comcast.net) ([10.212.250.65])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 18:16:55 -0700
From:   Ricardo Martinez <ricardo.martinez@linux.intel.com>
To:     netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Cc:     kuba@kernel.org, davem@davemloft.net, johannes@sipsolutions.net,
        ryazanov.s.a@gmail.com, loic.poulain@linaro.org,
        m.chetan.kumar@intel.com, chandrashekar.devegowda@intel.com,
        linuxwwan@intel.com, chiranjeevi.rapolu@linux.intel.com,
        haijun.liu@mediatek.com, amir.hanania@intel.com,
        andriy.shevchenko@linux.intel.com, dinesh.sharma@intel.com,
        eliot.lee@intel.com, ilpo.johannes.jarvinen@intel.com,
        moises.veleta@intel.com, pierre-louis.bossart@intel.com,
        muralidharan.sethuraman@intel.com, Soumya.Prakash.Mishra@intel.com,
        sreehari.kancharla@intel.com, madhusmita.sahu@intel.com,
        Ricardo Martinez <ricardo.martinez@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH net-next v7 14/14] net: wwan: t7xx: Add maintainers and documentation
Date:   Thu,  5 May 2022 18:16:16 -0700
Message-Id: <20220506011616.1774805-15-ricardo.martinez@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220506011616.1774805-1-ricardo.martinez@linux.intel.com>
References: <20220506011616.1774805-1-ricardo.martinez@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Adds maintainers and documentation for MediaTek t7xx 5G WWAN modem
device driver.

Signed-off-by: Ricardo Martinez <ricardo.martinez@linux.intel.com>
Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---
 .../networking/device_drivers/wwan/index.rst  |   1 +
 .../networking/device_drivers/wwan/t7xx.rst   | 120 ++++++++++++++++++
 MAINTAINERS                                   |  11 ++
 3 files changed, 132 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/wwan/t7xx.rst

diff --git a/Documentation/networking/device_drivers/wwan/index.rst b/Documentation/networking/device_drivers/wwan/index.rst
index 1cb8c7371401..370d8264d5dc 100644
--- a/Documentation/networking/device_drivers/wwan/index.rst
+++ b/Documentation/networking/device_drivers/wwan/index.rst
@@ -9,6 +9,7 @@ Contents:
    :maxdepth: 2
 
    iosm
+   t7xx
 
 .. only::  subproject and html
 
diff --git a/Documentation/networking/device_drivers/wwan/t7xx.rst b/Documentation/networking/device_drivers/wwan/t7xx.rst
new file mode 100644
index 000000000000..dd5b731957ca
--- /dev/null
+++ b/Documentation/networking/device_drivers/wwan/t7xx.rst
@@ -0,0 +1,120 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+.. Copyright (C) 2020-21 Intel Corporation
+
+.. _t7xx_driver_doc:
+
+============================================
+t7xx driver for MTK PCIe based T700 5G modem
+============================================
+The t7xx driver is a WWAN PCIe host driver developed for linux or Chrome OS platforms
+for data exchange over PCIe interface between Host platform & MediaTek's T700 5G modem.
+The driver exposes an interface conforming to the MBIM protocol [1]. Any front end
+application (e.g. Modem Manager) could easily manage the MBIM interface to enable
+data communication towards WWAN. The driver also provides an interface to interact
+with the MediaTek's modem via AT commands.
+
+Basic usage
+===========
+MBIM & AT functions are inactive when unmanaged. The t7xx driver provides
+WWAN port userspace interfaces representing MBIM & AT control channels and does
+not play any role in managing their functionality. It is the job of a userspace
+application to detect port enumeration and enable MBIM & AT functionalities.
+
+Examples of few such userspace applications are:
+
+- mbimcli (included with the libmbim [2] library), and
+- Modem Manager [3]
+
+Management Applications to carry out below required actions for establishing
+MBIM IP session:
+
+- open the MBIM control channel
+- configure network connection settings
+- connect to network
+- configure IP network interface
+
+Management Applications to carry out below required actions for send an AT
+command and receive response:
+
+- open the AT control channel using a UART tool or a special user tool
+
+Management application development
+==================================
+The driver and userspace interfaces are described below. The MBIM protocol is
+described in [1] Mobile Broadband Interface Model v1.0 Errata-1.
+
+MBIM control channel userspace ABI
+----------------------------------
+
+/dev/wwan0mbim0 character device
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+The driver exposes an MBIM interface to the MBIM function by implementing
+MBIM WWAN Port. The userspace end of the control channel pipe is a
+/dev/wwan0mbim0 character device. Application shall use this interface for
+MBIM protocol communication.
+
+Fragmentation
+~~~~~~~~~~~~~
+The userspace application is responsible for all control message fragmentation
+and defragmentation as per MBIM specification.
+
+/dev/wwan0mbim0 write()
+~~~~~~~~~~~~~~~~~~~~~~~
+The MBIM control messages from the management application must not exceed the
+negotiated control message size.
+
+/dev/wwan0mbim0 read()
+~~~~~~~~~~~~~~~~~~~~~~
+The management application must accept control messages of up the negotiated
+control message size.
+
+MBIM data channel userspace ABI
+-------------------------------
+
+wwan0-X network device
+~~~~~~~~~~~~~~~~~~~~~~
+The t7xx driver exposes IP link interface "wwan0-X" of type "wwan" for IP
+traffic. Iproute network utility is used for creating "wwan0-X" network
+interface and for associating it with MBIM IP session.
+
+The userspace management application is responsible for creating new IP link
+prior to establishing MBIM IP session where the SessionId is greater than 0.
+
+For example, creating new IP link for a MBIM IP session with SessionId 1:
+
+  ip link add dev wwan0-1 parentdev wwan0 type wwan linkid 1
+
+The driver will automatically map the "wwan0-1" network device to MBIM IP
+session 1.
+
+AT port userspace ABI
+----------------------------------
+
+/dev/wwan0at0 character device
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+The driver exposes an AT port by implementing AT WWAN Port.
+The userspace end of the control port is a /dev/wwan0at0 character
+device. Application shall use this interface to issue AT commands.
+
+The MediaTek's T700 modem supports the 3GPP TS 27.007 [4] specification.
+
+References
+==========
+[1] *MBIM (Mobile Broadband Interface Model) Errata-1*
+
+- https://www.usb.org/document-library/
+
+[2] *libmbim "a glib-based library for talking to WWAN modems and devices which
+speak the Mobile Interface Broadband Model (MBIM) protocol"*
+
+- http://www.freedesktop.org/wiki/Software/libmbim/
+
+[3] *Modem Manager "a DBus-activated daemon which controls mobile broadband
+(2G/3G/4G/5G) devices and connections"*
+
+- http://www.freedesktop.org/wiki/Software/ModemManager/
+
+[4] *Specification # 27.007 - 3GPP*
+
+- https://www.3gpp.org/DynaReport/27007.htm
diff --git a/MAINTAINERS b/MAINTAINERS
index fa6896e8b2d8..41bc2f3ae716 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12485,6 +12485,17 @@ S:	Maintained
 F:	drivers/net/dsa/mt7530.*
 F:	net/dsa/tag_mtk.c
 
+MEDIATEK T7XX 5G WWAN MODEM DRIVER
+M:	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
+M:	Intel Corporation <linuxwwan@intel.com>
+R:	Chiranjeevi Rapolu <chiranjeevi.rapolu@linux.intel.com>
+R:	Liu Haijun <haijun.liu@mediatek.com>
+R:	M Chetan Kumar <m.chetan.kumar@linux.intel.com>
+R:	Ricardo Martinez <ricardo.martinez@linux.intel.com>
+L:	netdev@vger.kernel.org
+S:	Supported
+F:	drivers/net/wwan/t7xx/
+
 MEDIATEK USB3 DRD IP DRIVER
 M:	Chunfeng Yun <chunfeng.yun@mediatek.com>
 L:	linux-usb@vger.kernel.org
-- 
2.25.1

