Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F6E2A63A4
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Nov 2020 12:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgKDLwA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Nov 2020 06:52:00 -0500
Received: from mx3.wp.pl ([212.77.101.10]:7649 "EHLO mx3.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728287AbgKDLvu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Nov 2020 06:51:50 -0500
Received: (wp-smtpd smtp.wp.pl 24418 invoked from network); 4 Nov 2020 12:51:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1604490708; bh=4GuFzihVKujz9z8NNmlcBN9xznDKy3SEygpTG7Lqmc8=;
          h=From:To:Cc:Subject;
          b=mQu3AkbeZajbaBdFaG3v+ZYolkvB3SGFRg9kbbXau+zC2IIAIJRZD36O75sYzhy8G
           ZXbORGkv8ERh8sYkUk6HCtfkHwR54ccgRFHLw4A59W4D46Hp6tEx5kZSJUxzcHzo8Q
           ADqSSit6gzlran2IDihDcmFH5707iikrvvzpTWvs=
Received: from ip4-46-39-164-203.cust.nbox.cz (HELO localhost) (stf_xl@wp.pl@[46.39.164.203])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <linux-wireless@vger.kernel.org>; 4 Nov 2020 12:51:48 +0100
Date:   Wed, 4 Nov 2020 12:51:48 +0100
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     linux-wireless@vger.kernel.org
Cc:     Markov Mikhail <markov.mikhail@itmh.ru>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH] rt2x00: remove unused variable in rt2800_get_survey
Message-ID: <20201104115148.GA84318@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-WP-MailID: 4927119d5022a1630cfcb07b5174607d
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000001 [gYJW]                               
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Patch fixes this compile warning:

drivers/net/wireless/ralink/rt2x00/rt2800lib.c: In function ‘rt2800_get_survey’:
drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10533:25: warning: unused variable ‘conf’ [-Wunused-variable]
10533 |  struct ieee80211_conf *conf = &hw->conf;
      |                         ^~~~

added by recent patch "rt2x00: save survey for every channel visited"

Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
---
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index e94c59c76559..5264b0a1f098 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -10530,7 +10530,6 @@ int rt2800_get_survey(struct ieee80211_hw *hw, int idx,
 		      struct survey_info *survey)
 {
 	struct rt2x00_dev *rt2x00dev = hw->priv;
-	struct ieee80211_conf *conf = &hw->conf;
 	struct rt2x00_chan_survey *chan_survey =
 		   &rt2x00dev->chan_survey[idx];
 	enum nl80211_band band = NL80211_BAND_2GHZ;
-- 
2.25.4

