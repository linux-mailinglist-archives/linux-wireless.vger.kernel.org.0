Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294D11BF03E
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2020 08:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgD3G3D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Apr 2020 02:29:03 -0400
Received: from mga11.intel.com ([192.55.52.93]:25173 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbgD3G3C (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Apr 2020 02:29:02 -0400
IronPort-SDR: FlpsCbE3dyNDfEE7sQbuya5+gO/joBF0bIFm5AoOIWKRoBDxvOxlR4wPOGnkcVPupTX1RYLDZT
 wAmZrnfmOqsA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 23:29:02 -0700
IronPort-SDR: 0q28nHbbk/6gUiwLadn2gB5piEdZBNxCk25SQFP+0XMZjU157Ip4yGTQPbdPb6oxcbnM94kT0d
 pQC/H88ABe1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,334,1583222400"; 
   d="scan'208";a="282751597"
Received: from power-sh.sh.intel.com ([10.239.48.5])
  by fmsmga004.fm.intel.com with ESMTP; 29 Apr 2020 23:29:00 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-wireless@vger.kernel.org, daniel.lezcano@linaro.org,
        andrzej.p@collabora.com, b.zolnierkie@samsung.com, luca@coelho.fi,
        rui.zhang@intel.com
Subject: [PATCH 0/6] thermal: improve handling of disabled thermal zone
Date:   Thu, 30 Apr 2020 14:32:23 +0800
Message-Id: <20200430063229.6182-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Andrzej Pietrasiewicz has proposed two patches at
https://patchwork.kernel.org/patch/11506053/
and
https://patchwork.kernel.org/patch/11506065/
to improve the thermal zone mode support.

But there are still some issues left, and this patch set is made based on
these two patches, to improve the handling of disabled thermal zone.

Patch 1/6 to Patch 4/6 clean up the code and fix
thermal_zone_device_update() to do nothing but cancelling the polling
timer, for a disabled thermal zone.

Patch 6/6 is a prototype patch. Patch 1-5 in this patch series make it
possible to fix a known iwlwifi thermal issue, by registering the iwlwifi
thermal zone device as disabled, and enable it after firmware ready.
I'd like to get feedback from the iwlwifi experts to get it fixed.

thanks,
rui
