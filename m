Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9348135B1F
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2020 15:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731539AbgAIOMd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Jan 2020 09:12:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:48312 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731527AbgAIOMd (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Jan 2020 09:12:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BEE25B2F31;
        Thu,  9 Jan 2020 14:12:25 +0000 (UTC)
From:   Nicolai Stange <nstange@suse.de>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     huangwenabc@gmail.com, linux-wireless@vger.kernel.org,
        Takashi Iwai <tiwai@suse.de>, Nicolai Stange <nstange@suse.de>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH] libertas: Fix two buffer overflows at parsing bss descriptor
In-Reply-To: <20191122052917.11309-1-huangwenabc@gmail.com>
Date:   Thu, 09 Jan 2020 15:12:24 +0100
Message-ID: <87woa04t2v.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

the patch queued as e5e884b42639 ("libertas: Fix two buffer overflows at
parsing bss descriptor") at the wireless tree doesn't look completely
correct to me.

This hunk here...

diff --git a/drivers/net/wireless/marvell/libertas/cfg.c b/drivers/net/wireless/marvell/libertas/cfg.c
index 57edfada0665..c9401c121a14 100644
--- a/drivers/net/wireless/marvell/libertas/cfg.c
+++ b/drivers/net/wireless/marvell/libertas/cfg.c
@@ -1775,9 +1782,12 @@ static int lbs_ibss_join_existing(struct lbs_private *priv,
 	if (!rates_eid) {
 		lbs_add_rates(cmd.bss.rates);
 	} else {
-		int hw, i;
-		u8 rates_max = rates_eid[1];
-		u8 *rates = cmd.bss.rates;
+		rates_max = rates_eid[1];
+		if (rates_max > MAX_RATES) {
+			lbs_deb_join("invalid rates");
+			goto out;

... makes the error path skip over the rcu_read_unlock() following later
in the code and leaves the RCU read section unbalanced.

Also, I'm wondering if ret should perhaps get set to some -Exxxx in case
of rates_max > MAX_RATES?

Thanks,

Nicolai


+		}
+		rates = cmd.bss.rates;
 		for (hw = 0; hw < ARRAY_SIZE(lbs_rates); hw++) {
 			u8 hw_rate = lbs_rates[hw].bitrate / 5;
 			for (i = 0; i < rates_max; i++) {

-- 
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
(HRB 36809, AG Nürnberg), GF: Felix Imendörffer
