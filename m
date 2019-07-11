Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E512C6534B
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2019 10:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfGKIqj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Jul 2019 04:46:39 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:41218 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727991AbfGKIqj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Jul 2019 04:46:39 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.224.233])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id C986730C00F;
        Thu, 11 Jul 2019 01:46:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com C986730C00F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1562834797;
        bh=t7TiWU3jbrffnpNCf4AgGWOma9iqMP2druA3r+viIvM=;
        h=From:To:Cc:Subject:Date:From;
        b=dBA3F8GpzGmkpgS5Ica+e2P7sKe02G07h28Veoy2wcAyY2VWd9w01eQZkcGfl5i5U
         PQhiNQFDDzwv7zQrW19WfN0hmdyCxhj4FK4UDMbO0Gqlf4P7Xwmv7C7mJ2Bxu86dnc
         ZKxbDVAstRPWzXuMftasmdeiG/0yXrnr8eRMAPbE=
Received: from bld-bun-01.bun.broadcom.com (bld-bun-01.bun.broadcom.com [10.176.128.83])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id BD16660CB1;
        Thu, 11 Jul 2019 01:46:37 -0700 (PDT)
Received: by bld-bun-01.bun.broadcom.com (Postfix, from userid 25152)
        id 8EC61B02F12; Thu, 11 Jul 2019 10:46:35 +0200 (CEST)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH 0/3] brcmfmac: 160MHz fixes and DFS offload
Date:   Thu, 11 Jul 2019 10:45:29 +0200
Message-Id: <1562834732-31508-1-git-send-email-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The 160MHz AP mode was not properly working and limited due to lack of
DFS offload. So this series include following changes:

 * encode 160MHz channel definition to firmware format.
 * adapt custom regulatory rule allowing 160MHz.
 * enable DFS offloading for firmwares supporting it.

The series applies to the master branch of the wireless-drivers-next
repository.

Arend van Spriel (3):
  brcmfmac: add 160MHz in chandef_to_chanspec()
  brcmfmac: enable DFS_OFFLOAD extended feature if supported
  brcmfmac: allow 160MHz in custom regulatory rules

 .../broadcom/brcm80211/brcmfmac/cfg80211.c         | 30 +++++++++++++++++++---
 .../wireless/broadcom/brcm80211/brcmfmac/feature.c |  1 +
 .../wireless/broadcom/brcm80211/brcmfmac/feature.h |  4 ++-
 3 files changed, 31 insertions(+), 4 deletions(-)

--
1.9.1

