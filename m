Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94740244906
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Aug 2020 13:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgHNLl3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Aug 2020 07:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728224AbgHNLkW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Aug 2020 07:40:22 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E28C061387
        for <linux-wireless@vger.kernel.org>; Fri, 14 Aug 2020 04:40:18 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f7so8096508wrw.1
        for <linux-wireless@vger.kernel.org>; Fri, 14 Aug 2020 04:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QL8P1vJDktk76ShKc1HPImGMIug4YyMuQnQRcEyKkoI=;
        b=lnMu9WBEwLa+et+Tun3rNvwx1hf61X+CVtMJG/DDGWk2x5ctb0Nbd50aVhKtCXUC9T
         z6ydfEiNpiajXqm230uX3ya68ut+rULL9Dru//OVyEZ4SZ1kSGcYN7Pik0bGW0xe1/0t
         o0LC8U7sU4kcekipyEvc25ZIw9Iei0nwLE9H7xjrMT++K/jkrbZVgCpKLX/T7I1sTVkH
         wR7b71tU0bQw+hjMA7zA3bGbm+cMALRKFJhjQC/I+QEzkqSi3khmpkrIe2DjPXfhR9Vp
         /KA4+GUnu6MTA7dq5Kc0vhFdMxLlCV1CgQqkQPSPYU7Q90d4aRnkXxanxZvUPgLZLVbb
         kV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QL8P1vJDktk76ShKc1HPImGMIug4YyMuQnQRcEyKkoI=;
        b=Bsa2sLTqAXgNnVzn8D40OjPT7ssCYIFfnK5g1obMSPgnWRCFb9M2a647Yv4/+Hswic
         +Z04zQG8DuVBJpE2NvuUJc42FVVKAzXLkT5Qp5hMtbSIDKb+seYNiUNWm3SZ+c2GaJ9m
         8536apNWRmIPKM+fHOHxCWNzDvLkZzWVdfamUnMGv5Gob4Ec7P2wvvggVVmWz+/u9EPy
         PmyDODc2Uj1DGH2B4vCwivw5+SG468H3aLiWeEKlzIrBV6yqXXgNDKEfK3s4eW8fB4Tb
         lH7ZsUZUrlcqXkefOYpUTFkPKImfaG6C/U7NXX8RisrWRa4MX62NQXduBjVrak82gfwD
         P3dA==
X-Gm-Message-State: AOAM533xO7T1WDmKdVCibnS0Tv9q5B3scLY7Ue0UbBSDJTo89s9YxzDg
        fmtiAEbskbP9nndOHkzZKlfN+w==
X-Google-Smtp-Source: ABdhPJzyLjHxyrMZWitTzof2A/YZn3HTH6pdxivRPUutGlNS/6e66PfYqnT9d55LRQt0vgfwSqeylA==
X-Received: by 2002:adf:a19e:: with SMTP id u30mr2322432wru.274.1597405216394;
        Fri, 14 Aug 2020 04:40:16 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id 32sm16409129wrh.18.2020.08.14.04.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 04:40:15 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, netdev@vger.kernel.org
Subject: [PATCH 23/30] net: wireless: broadcom: brcm80211: brcmfmac: fweh: Fix docrot related function documentation issues
Date:   Fri, 14 Aug 2020 12:39:26 +0100
Message-Id: <20200814113933.1903438-24-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814113933.1903438-1-lee.jones@linaro.org>
References: <20200814113933.1903438-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Also demote a commit block header which is clearly not suitable for kerneldoc.

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c: In function ‘brcmf_fweh_handle_if_event’:
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c:131:6: warning: variable ‘err’ set but not used [-Wunused-but-set-variable]
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c:36: warning: Function parameter or member 'datalen' not described in 'brcmf_fweh_queue_item'
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c:44: warning: Function parameter or member 'code' not described in 'brcmf_fweh_event_name'
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c:44: warning: Function parameter or member 'name' not described in 'brcmf_fweh_event_name'
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c:127: warning: Function parameter or member 'emsg' not described in 'brcmf_fweh_handle_if_event'
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c:127: warning: Function parameter or member 'data' not described in 'brcmf_fweh_handle_if_event'
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c:127: warning: Excess function parameter 'item' description in 'brcmf_fweh_handle_if_event'
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c:127: warning: Excess function parameter 'ifpp' description in 'brcmf_fweh_handle_if_event'
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c:391: warning: Function parameter or member 'packet_len' not described in 'brcmf_fweh_process_event'

Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Franky Lin <franky.lin@broadcom.com>
Cc: Hante Meuleman <hante.meuleman@broadcom.com>
Cc: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Cc: Wright Feng <wright.feng@cypress.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: linux-wireless@vger.kernel.org
Cc: brcm80211-dev-list.pdl@broadcom.com
Cc: brcm80211-dev-list@cypress.com
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
index 6f74567c7bd72..3bdbb285b3aa6 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
@@ -23,6 +23,7 @@
  * @ifidx: interface index related to this event.
  * @ifaddr: ethernet address for interface.
  * @emsg: common parameters of the firmware event message.
+ * @datalen: length of the data array
  * @data: event specific data part of the firmware event.
  */
 struct brcmf_fweh_queue_item {
@@ -35,7 +36,7 @@ struct brcmf_fweh_queue_item {
 	u8 data[];
 };
 
-/**
+/*
  * struct brcmf_fweh_event_name - code, name mapping entry.
  */
 struct brcmf_fweh_event_name {
@@ -118,8 +119,8 @@ static int brcmf_fweh_call_event_handler(struct brcmf_pub *drvr,
  * brcmf_fweh_handle_if_event() - handle IF event.
  *
  * @drvr: driver information object.
- * @item: queue entry.
- * @ifpp: interface object (may change upon ADD action).
+ * @emsg: event message object.
+ * @data: event object.
  */
 static void brcmf_fweh_handle_if_event(struct brcmf_pub *drvr,
 				       struct brcmf_event_msg *emsg,
@@ -380,6 +381,7 @@ int brcmf_fweh_activate_events(struct brcmf_if *ifp)
  *
  * @drvr: driver information object.
  * @event_packet: event packet to process.
+ * @packet_len: length of the packet
  *
  * If the packet buffer contains a firmware event message it will
  * dispatch the event to a registered handler (using worker).
-- 
2.25.1

