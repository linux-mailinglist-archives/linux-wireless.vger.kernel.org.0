Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18DE25F072
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Sep 2020 22:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgIFUGD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Sep 2020 16:06:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58193 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726445AbgIFUF7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Sep 2020 16:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599422758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=22GEKdlDGamdrcCdfxHjJVYzr9HNsngs+YDvy62bHWk=;
        b=IswqyEf5QVzlKIejYq8RmT4IakKRV9IAQTH6WPLG2JV1XI9SvI9CsbmEBRK6dKwwcgpNJn
        Ooo5d9cp7HlUi6j7C+4rtYGejfE/Oi+X0RkkrreAlpDunysTsplGWG1Bet3q1DpE+4JvcX
        BCfW16+6W8nArMb+ddUzlC0lN590MxM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-t5QdK5hDP6W38Mk9iFTicA-1; Sun, 06 Sep 2020 16:05:55 -0400
X-MC-Unique: t5QdK5hDP6W38Mk9iFTicA-1
Received: by mail-qv1-f72.google.com with SMTP id t4so5253042qvr.21
        for <linux-wireless@vger.kernel.org>; Sun, 06 Sep 2020 13:05:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=22GEKdlDGamdrcCdfxHjJVYzr9HNsngs+YDvy62bHWk=;
        b=JnvBfldQ8zZDNFg/RH8nuMospYLujK/77I3FdZhqK6MRLqckqep4pjwanEMSZXUvmF
         Iv3+zHWEDxKxtF05XoQbOVXtEgHZ6GW13MjfT3CGhq170zimTMqMaOpKszWHTVAObxkW
         pZ7QNVgpS/Ny8hEUiVkRcIBvV0ubEaEGWNSP1QJ6dALJshoMbgCv+XS+q+fnRlxkOh4y
         /gxsqELRy6C0ILJwuSy6vaAo5Q0VLcjVOSrwmMqMT5X2fge1NHaU7u5d+9EtCHtfRZAy
         +3QcwCftdgmNrkImtXLObGYCfzKSFry/WS0vzHiEOcP+Bh7EjIWptc60QQ2YSnKs2dPw
         fE4A==
X-Gm-Message-State: AOAM531rE0rPn7aEO0pHrp6HRSheJGfXHhx0TSRZ/x0LQaLpm/nZhY1u
        +LHhMUE3jyXZgVtrK7MFjgANyCtQ3YIWTxpsGsjVhE+7PhDokqPRA23vn0fYkb0Ghwa9FEDyvDT
        TasK08beHkpl87Dm3CWLTgF/goJI=
X-Received: by 2002:ac8:310c:: with SMTP id g12mr18097168qtb.281.1599422755466;
        Sun, 06 Sep 2020 13:05:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUi6FjudeZbwzO+c/2NwD6TWr2lq6erqaKfWv9r02JiQWr5InA3Ycp5fEU/mKbzgvlBSRZsA==
X-Received: by 2002:ac8:310c:: with SMTP id g12mr18097140qtb.281.1599422755202;
        Sun, 06 Sep 2020 13:05:55 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x3sm3727737qta.53.2020.09.06.13.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 13:05:54 -0700 (PDT)
From:   trix@redhat.com
To:     amitkarwar@gmail.com, ganapathi.bhat@nxp.com,
        huxinming820@gmail.com, kvalo@codeaurora.org, davem@davemloft.net,
        kuba@kernel.org, natechancellor@gmail.com, ndesaulniers@google.com,
        bzhao@marvell.com, dkiran@marvell.com, frankh@marvell.com,
        linville@tuxdriver.com
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] mwifiex: remove function pointer check
Date:   Sun,  6 Sep 2020 13:05:48 -0700
Message-Id: <20200906200548.18053-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analyzer reports this problem

init.c:739:8: warning: Called function pointer
  is null (null dereference)
        ret = adapter->if_ops.check_fw_status( ...
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In mwifiex_dnld_fw, there is an earlier check for check_fw_status(),
The check was introduced for usb support at the same time this
check in _mwifiex_fw_dpc() was made

	if (adapter->if_ops.dnld_fw) {
		ret = adapter->if_ops.dnld_fw(adapter, &fw);
	} else {
		ret = mwifiex_dnld_fw(adapter, &fw);
	}

And a dnld_fw function initialized as part the usb's
mwifiex_if_ops.

The other instances of mwifiex_if_ops for pci and sdio
both set check_fw_status.

So the first check is not needed and can be removed.

Fixes: 4daffe354366 ("mwifiex: add support for Marvell USB8797 chipset")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/wireless/marvell/mwifiex/init.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/init.c b/drivers/net/wireless/marvell/mwifiex/init.c
index 82d69bc3aaaf..f006a3d72b40 100644
--- a/drivers/net/wireless/marvell/mwifiex/init.c
+++ b/drivers/net/wireless/marvell/mwifiex/init.c
@@ -695,14 +695,12 @@ int mwifiex_dnld_fw(struct mwifiex_adapter *adapter,
 	int ret;
 	u32 poll_num = 1;
 
-	if (adapter->if_ops.check_fw_status) {
-		/* check if firmware is already running */
-		ret = adapter->if_ops.check_fw_status(adapter, poll_num);
-		if (!ret) {
-			mwifiex_dbg(adapter, MSG,
-				    "WLAN FW already running! Skip FW dnld\n");
-			return 0;
-		}
+	/* check if firmware is already running */
+	ret = adapter->if_ops.check_fw_status(adapter, poll_num);
+	if (!ret) {
+		mwifiex_dbg(adapter, MSG,
+			    "WLAN FW already running! Skip FW dnld\n");
+		return 0;
 	}
 
 	/* check if we are the winner for downloading FW */
-- 
2.18.1

