Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 421C212E1C2
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2020 03:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbgABCjl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Jan 2020 21:39:41 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40180 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbgABCjl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Jan 2020 21:39:41 -0500
Received: by mail-pl1-f196.google.com with SMTP id s21so14541663plr.7
        for <linux-wireless@vger.kernel.org>; Wed, 01 Jan 2020 18:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Ehh8DQVFAGT2+nXBsFrbowHh8y2akSWjoRRHCcRDlno=;
        b=abnlLvaHQn8vfA7nRBOYsVYwU4WtO/lv20nRxHuw8JmHXPIYcvkzviHzQL38jScadH
         lnPB3S4MR7zi6uijpoqWtOruSweOpz7bnNt6uQDZ1q4boTJ3e/TJP7q2ezAC27ismM6E
         YhX7dViSNZ57lrMdf/6ln75tSa8mY25Pmcljn6PZTcMKntjcUcKupPA1FzRWtX/8SX7m
         a6wMroTdGj84ob6UUcOyU/Di3oEWinNAko58ejd+0SRIQ2lFMvX62Sq2J2RImK8+lh44
         FKT/gBL8O6O065L/C+AqRgkIkwEicx/gy5EMv8WS/RwAg/LqnnVZplP590uKuwZVCqQQ
         kyww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ehh8DQVFAGT2+nXBsFrbowHh8y2akSWjoRRHCcRDlno=;
        b=I8U4qVxD6OCjW7SAvT1Dy154LTa7N5rFJ9dmDI3MMXRI95HPfKYNl7Nso/QGYtljTO
         5fi8U843y+pQLSSTX+ZbsyJsByi0azj6+H6tuIfj2MLwrIHTx4K4KM8vzWGZsZHC/oBT
         LAca/gvJRJp322vyhAYTx3xSoYmwyRNGGnxY0xvZfj4gZLfsjEL+hFpIClP9dFlLVbLG
         ioAIvh/YPUEFBuKAOl34SYtL9XuCy/4DZAvTE2ucrTHI8YXBWuZGWRvWWCbOH1n8JTYJ
         mgbLlgrNSA6Rpqw3sEAuYDv5IUhSkN0+aebb0euXqpXHiYCn5+9YhWRVYbNj4RZGyVXa
         c+GA==
X-Gm-Message-State: APjAAAXXvTfRI1+TU7jtxe+bTBfpjLYzNyWXWtIiO0OUHtqe3ydWDClY
        Mauf+SfKoPTxW1uZwhDH8xQzas74T+w=
X-Google-Smtp-Source: APXvYqxKVM5NdSRJTOhAK8V+Q6v6qWiIs31B3zxx4WKiBBcI9aJEkKO/hQeS4SM8d+CplBIVxFLJBw==
X-Received: by 2002:a17:902:aa8f:: with SMTP id d15mr84981301plr.80.1577932780767;
        Wed, 01 Jan 2020 18:39:40 -0800 (PST)
Received: from localhost (172.96.199.36.16clouds.com. [172.96.199.36])
        by smtp.gmail.com with ESMTPSA id 11sm62706713pfz.25.2020.01.01.18.39.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Jan 2020 18:39:40 -0800 (PST)
From:   m1s5p6688@gmail.com
To:     linux-wireless@vger.kernel.org
Cc:     amitkarwar@gmail.com, nishants@marvell.com, gbhat@marvell.com,
        huxinming820@gmail.com
Subject: [PATCH 0/2] Fix two possible Buffer overflow in mwifiex
Date:   Thu,  2 Jan 2020 10:39:25 +0800
Message-Id: <20200102023927.4687-1-m1s5p6688@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Qing Xu <m1s5p6688@gmail.com>

Hi,

this is fixes for a few spots that perform memcpy() without checking
the source and the destination size in mwifiex driver, which may lead
to buffer overflows or read over boundary.


Qing Xu

===

Qing Xu (2):
  mwifiex: Fix possible buffer overflows in mwifiex_ret_wmm_get_status()
  mwifiex: Fix possible buffer overflows in
    mwifiex_cmd_append_vsie_tlv()

 drivers/net/wireless/marvell/mwifiex/scan.c | 7 +++++++
 drivers/net/wireless/marvell/mwifiex/wmm.c  | 4 ++++
 2 files changed, 11 insertions(+)

-- 
2.17.1

