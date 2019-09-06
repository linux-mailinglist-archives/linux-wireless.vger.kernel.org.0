Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43566ABA43
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2019 16:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393932AbfIFOGG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Sep 2019 10:06:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39946 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393798AbfIFOGF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Sep 2019 10:06:05 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2BADE60770; Fri,  6 Sep 2019 14:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567778763;
        bh=V1dlkOUoFvPwbVzpwF7XL6XrB7q+VyTY3styvqJpTlw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=kbjY7xTtoXcI6ITPkFE79JeY4xRfffHl+Bk4uR+qnoOD6Smx0Z3VP0FA2p3g5KEkW
         zna1Cippu1AswCirATViIgKW5ZrpiIvNkDrr6aZcYBbO+O+h64D53uvTUWmimYNzvl
         xfezxIoyJxN1kfHBbubc4w6kfXwTI1eBuvT0lyN0=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 074E960770;
        Fri,  6 Sep 2019 14:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567778762;
        bh=V1dlkOUoFvPwbVzpwF7XL6XrB7q+VyTY3styvqJpTlw=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=QCSS4CN8PRlJlTkKGr6LB8rKS20kgW3ZNveIz8yfJHMyI8HwuRFuiTHt6bWo3tc21
         gO/z3ihn51SKLlAf3IfIM3XtQ45ZSEuxY0HL+i2KZNRSCgKAm343udW5Fv9xHhZay0
         IEQ6z3y1QjDjz3UXj+ZmoMQNy0T4c+60RPj4kM6k=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 074E960770
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/8] rtw88: 8822c: update PHY parameter to v38
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1565174405-2689-2-git-send-email-yhchuang@realtek.com>
References: <1565174405-2689-2-git-send-email-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>,
        <sgruszka@redhat.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190906140603.2BADE60770@smtp.codeaurora.org>
Date:   Fri,  6 Sep 2019 14:06:03 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> 
> Update PHY hardware parameters to v38.
> 
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

New warnings:

drivers/net/wireless/realtek/rtw88/phy.c: In function 'rtw_phy_get_dis_dpd_by_rate_diff':
drivers/net/wireless/realtek/rtw88/phy.c:1553:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (DIS_DPD_RATE ## _rate & chip->dpd_ratemask)  \
      ^
drivers/net/wireless/realtek/rtw88/phy.c:1557:2: note: in expansion of macro 'RTW_DPD_RATE_CHECK'
  RTW_DPD_RATE_CHECK(6M);
  ^~~~~~~~~~~~~~~~~~
drivers/net/wireless/realtek/rtw88/phy.c:1552:2: note: here
  case DESC_RATE ## _rate:     \
  ^~~~
drivers/net/wireless/realtek/rtw88/phy.c:1558:2: note: in expansion of macro 'RTW_DPD_RATE_CHECK'
  RTW_DPD_RATE_CHECK(9M);
  ^~~~~~~~~~~~~~~~~~
drivers/net/wireless/realtek/rtw88/phy.c:1553:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (DIS_DPD_RATE ## _rate & chip->dpd_ratemask)  \
      ^
drivers/net/wireless/realtek/rtw88/phy.c:1558:2: note: in expansion of macro 'RTW_DPD_RATE_CHECK'
  RTW_DPD_RATE_CHECK(9M);
  ^~~~~~~~~~~~~~~~~~
drivers/net/wireless/realtek/rtw88/phy.c:1552:2: note: here
  case DESC_RATE ## _rate:     \
  ^~~~
drivers/net/wireless/realtek/rtw88/phy.c:1559:2: note: in expansion of macro 'RTW_DPD_RATE_CHECK'
  RTW_DPD_RATE_CHECK(MCS0);
  ^~~~~~~~~~~~~~~~~~
drivers/net/wireless/realtek/rtw88/phy.c:1553:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (DIS_DPD_RATE ## _rate & chip->dpd_ratemask)  \
      ^
drivers/net/wireless/realtek/rtw88/phy.c:1559:2: note: in expansion of macro 'RTW_DPD_RATE_CHECK'
  RTW_DPD_RATE_CHECK(MCS0);
  ^~~~~~~~~~~~~~~~~~
drivers/net/wireless/realtek/rtw88/phy.c:1552:2: note: here
  case DESC_RATE ## _rate:     \
  ^~~~
drivers/net/wireless/realtek/rtw88/phy.c:1560:2: note: in expansion of macro 'RTW_DPD_RATE_CHECK'
  RTW_DPD_RATE_CHECK(MCS1);
  ^~~~~~~~~~~~~~~~~~
drivers/net/wireless/realtek/rtw88/phy.c:1553:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (DIS_DPD_RATE ## _rate & chip->dpd_ratemask)  \
      ^
drivers/net/wireless/realtek/rtw88/phy.c:1560:2: note: in expansion of macro 'RTW_DPD_RATE_CHECK'
  RTW_DPD_RATE_CHECK(MCS1);
  ^~~~~~~~~~~~~~~~~~
drivers/net/wireless/realtek/rtw88/phy.c:1552:2: note: here
  case DESC_RATE ## _rate:     \
  ^~~~
drivers/net/wireless/realtek/rtw88/phy.c:1561:2: note: in expansion of macro 'RTW_DPD_RATE_CHECK'
  RTW_DPD_RATE_CHECK(MCS8);
  ^~~~~~~~~~~~~~~~~~
drivers/net/wireless/realtek/rtw88/phy.c:1553:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (DIS_DPD_RATE ## _rate & chip->dpd_ratemask)  \
      ^
drivers/net/wireless/realtek/rtw88/phy.c:1561:2: note: in expansion of macro 'RTW_DPD_RATE_CHECK'
  RTW_DPD_RATE_CHECK(MCS8);
  ^~~~~~~~~~~~~~~~~~
drivers/net/wireless/realtek/rtw88/phy.c:1552:2: note: here
  case DESC_RATE ## _rate:     \
  ^~~~
drivers/net/wireless/realtek/rtw88/phy.c:1562:2: note: in expansion of macro 'RTW_DPD_RATE_CHECK'
  RTW_DPD_RATE_CHECK(MCS9);
  ^~~~~~~~~~~~~~~~~~
drivers/net/wireless/realtek/rtw88/phy.c:1553:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (DIS_DPD_RATE ## _rate & chip->dpd_ratemask)  \
      ^
drivers/net/wireless/realtek/rtw88/phy.c:1562:2: note: in expansion of macro 'RTW_DPD_RATE_CHECK'
  RTW_DPD_RATE_CHECK(MCS9);
  ^~~~~~~~~~~~~~~~~~
drivers/net/wireless/realtek/rtw88/phy.c:1552:2: note: here
  case DESC_RATE ## _rate:     \
  ^~~~
drivers/net/wireless/realtek/rtw88/phy.c:1563:2: note: in expansion of macro 'RTW_DPD_RATE_CHECK'
  RTW_DPD_RATE_CHECK(VHT1SS_MCS0);
  ^~~~~~~~~~~~~~~~~~
drivers/net/wireless/realtek/rtw88/phy.c:1553:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (DIS_DPD_RATE ## _rate & chip->dpd_ratemask)  \
      ^
drivers/net/wireless/realtek/rtw88/phy.c:1563:2: note: in expansion of macro 'RTW_DPD_RATE_CHECK'
  RTW_DPD_RATE_CHECK(VHT1SS_MCS0);
  ^~~~~~~~~~~~~~~~~~
drivers/net/wireless/realtek/rtw88/phy.c:1552:2: note: here
  case DESC_RATE ## _rate:     \
  ^~~~
drivers/net/wireless/realtek/rtw88/phy.c:1564:2: note: in expansion of macro 'RTW_DPD_RATE_CHECK'
  RTW_DPD_RATE_CHECK(VHT1SS_MCS1);
  ^~~~~~~~~~~~~~~~~~
drivers/net/wireless/realtek/rtw88/phy.c:1553:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (DIS_DPD_RATE ## _rate & chip->dpd_ratemask)  \
      ^
drivers/net/wireless/realtek/rtw88/phy.c:1564:2: note: in expansion of macro 'RTW_DPD_RATE_CHECK'
  RTW_DPD_RATE_CHECK(VHT1SS_MCS1);
  ^~~~~~~~~~~~~~~~~~
drivers/net/wireless/realtek/rtw88/phy.c:1552:2: note: here
  case DESC_RATE ## _rate:     \
  ^~~~
drivers/net/wireless/realtek/rtw88/phy.c:1565:2: note: in expansion of macro 'RTW_DPD_RATE_CHECK'
  RTW_DPD_RATE_CHECK(VHT2SS_MCS0);
  ^~~~~~~~~~~~~~~~~~
drivers/net/wireless/realtek/rtw88/phy.c:1553:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (DIS_DPD_RATE ## _rate & chip->dpd_ratemask)  \
      ^
drivers/net/wireless/realtek/rtw88/phy.c:1565:2: note: in expansion of macro 'RTW_DPD_RATE_CHECK'
  RTW_DPD_RATE_CHECK(VHT2SS_MCS0);
  ^~~~~~~~~~~~~~~~~~
drivers/net/wireless/realtek/rtw88/phy.c:1552:2: note: here
  case DESC_RATE ## _rate:     \
  ^~~~
drivers/net/wireless/realtek/rtw88/phy.c:1566:2: note: in expansion of macro 'RTW_DPD_RATE_CHECK'
  RTW_DPD_RATE_CHECK(VHT2SS_MCS1);
  ^~~~~~~~~~~~~~~~~~

8 patches set to Changes Requested.

11081855 [1/8] rtw88: 8822c: update PHY parameter to v38
11081853 [2/8] rtw88: 8822c: update pwr_seq to v13
11081843 [3/8] rtw88: 8822c: Enable interrupt migration
11081851 [PATCH 4/8] rtw88: 8822c: add FW IQK support
11081857 [5/8] rtw88: 8822c: add SW DPK support
11081845 [6/8] rtw88: move IQK/DPK into phy_calibration
11081849 [7/8] rtw88: add dynamic cck pd mechanism
11081847 [8/8] rtw88: allows to receive AMSDU in AMPDU

-- 
https://patchwork.kernel.org/patch/11081855/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

