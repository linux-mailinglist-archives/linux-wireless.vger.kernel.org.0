Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B416A5EC5
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2019 03:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbfICBSg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Sep 2019 21:18:36 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38300 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfICBSg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Sep 2019 21:18:36 -0400
Received: by mail-ot1-f67.google.com with SMTP id r20so15096104ota.5
        for <linux-wireless@vger.kernel.org>; Mon, 02 Sep 2019 18:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=yrRdmwiSrjD3DpOR7Sajqq+oy+JJuAEqIoEkNH5UOJo=;
        b=rP9Udc0sS+S+VT3KG8wgXgreWUHMaWomib+Nv/kcETq0VLx1Z5kw+U9Pyq7Drc7e+s
         CtNVKf0Zc00FP7XIdaeD6WlER4Hl0tBj+eoNcMsDN3mmywl5ONMzpfeuJ5HSaNXn+2ij
         Yt+2fHiAC+5MEctGCcNGzRGJk9oTOvFwT+e1BGxknvKmvwD4MqO4YAwYNKedqjvNl5gw
         ldGvFLf6OfwZYMx6feRpWeKiDaNdrBXr+Wu7rYpQ1CMlT9o5dtdGU/ybqC6OVqNrG3CB
         zoXQ4lGYEW9ne84yA5gvBAJG3AQpjNwTBxOa58o7EuAQxUAZGB1nNtuKklUT2YeGy2yp
         2tYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=yrRdmwiSrjD3DpOR7Sajqq+oy+JJuAEqIoEkNH5UOJo=;
        b=ZVcw80oGqkfvfwp00pVIxvwKbeXt0FUkyjUamBKrGTFlDThcqTIzX5rVZvgBHzHCDb
         yQAtgqG0Y3SIChqcTxbQW7Livlbkjat9B/vdyN4mvPrNRE8IBeWCuro1BcNj5RtX1W91
         OJBweGROXhfgH0pURiyUz9aJRY3tCYL99UZVu+wI6NyO0kz+C71XGn8Fd0XfzLPkyB8+
         fD7/kDEVbYhNH+bzxxI4egha+86xBgjOYZT+hFnMa7+IDuXFbD1b/NfmgbRPB9sZdDME
         bNseVnt+AtacsdLhBIHWZNeRIvqEJfgab08milYCHMdLUgcy16bXShkHyoz6OBbmimaV
         vn/Q==
X-Gm-Message-State: APjAAAXeorKJMzcES5lIZkVffIGAtSbQTfZBlELMv3ODDtLP0ML29U48
        hkk0kqELQJ3YfORY6h+cMcc=
X-Google-Smtp-Source: APXvYqwiyGYTSG2VGONWzEeBeEVhTq69V0G3/NKrpABUIXxeF7k0WUpEx+odXqt1/t1r+gF1SAg7xg==
X-Received: by 2002:a9d:5786:: with SMTP id q6mr2740209oth.125.1567473515682;
        Mon, 02 Sep 2019 18:18:35 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id d13sm230244oth.11.2019.09.02.18.18.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Sep 2019 18:18:35 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 0/3] rtlwifi: Fix some errors in recent patches
Date:   Mon,  2 Sep 2019 20:18:10 -0500
Message-Id: <20190903011813.13946-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When formuating the patches that converted the GET_XXX macros that read
RX and TX descriptor values, I made all of them return "int" values,
Unfortunately, the resulting inline routines must return unsigned values
when all 32-bits are returned as these entities are frequently addresses.

Although I have submitted fixes for several drivers, only 3 are affected
as the problem caused failures that led me to the problem.

Fortunately, none of these faulty changes will reach mainline until 5.4,
thus most users will not be affected until 5.4-rc1.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>

Larry Finger (3):
  rtlwifi: rtl8821ae: Fix incorrect returned values
  rtlwifi: rtl8188ee: Fix incorrect returned values
  rtlwifi: rtl8192ce: Fix incorrect returned values

 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.h | 14 +++++++-------
 drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.h |  6 +++---
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.h | 10 +++++-----
 3 files changed, 15 insertions(+), 15 deletions(-)

-- 
2.16.4

