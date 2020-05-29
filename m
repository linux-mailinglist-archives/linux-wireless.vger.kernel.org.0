Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F20E1E7809
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 10:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725681AbgE2IRC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 04:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgE2IRB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 04:17:01 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD16C03E969
        for <linux-wireless@vger.kernel.org>; Fri, 29 May 2020 01:17:01 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c3so2353876wru.12
        for <linux-wireless@vger.kernel.org>; Fri, 29 May 2020 01:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:references:to:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MF1o7IBFcSCjvGRVy2NrQYvKsQDHh4VVD/9utmqs5Xc=;
        b=T/r3cveJ3P9at+DSIYIWlWxdGpyg0rA1fs+rXwDsyrmeRdrkqftsmSusHbGErjXZ/D
         E7ynTy39NDu07Gn8Aq5/Lmg2eDEVD10asU0ZTAdhQiuBpOfQJiqg74ijQuu0IgQMLgLI
         JP/N+L76u3cKguoL4qiEnD7Fsx1adGKaaO2Ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:references:to:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MF1o7IBFcSCjvGRVy2NrQYvKsQDHh4VVD/9utmqs5Xc=;
        b=b5YLys1AI4M6Qc54OaoozaREH40Fq2yH/NGgXAB948y4SBxasnrH4O/dFeSdnlodRi
         /ifzNZ444GNGflPpiQKnVirn9LUf6kINI8hhSgcLaaAs/F0Q/ksf2CHi7wYvzsPmDItT
         N6WW51VWCH15JHJLWgYjizROPXxeXceyiodkARBBpexR39Tk/TfJJbbN+zS3nd4ffZ//
         nmreo95xxgZfjs2Q13EUVKMzJl8RpDMDQNsuJobVYt+4y29749dLe3eRH12MP6rRB9fX
         JwzmFhi9/MTnEkEYLj6bAQJa46uhpbmetUnrXwtaHJm+ZcugAvXp8MVlZn3z9wrfrip1
         b5ZA==
X-Gm-Message-State: AOAM531Y8PE99wY1GB/GA6J6qKhZs2e8yf1aqhmk8YSo4hsq2+rZd0Qn
        6kMiXZBJ2U3l+shAkURzsO9RbA==
X-Google-Smtp-Source: ABdhPJzoEk3rjwEuXgwaCfoWqKFkgKkxMGwF4n8VPEBfb0k1JXWX3JMlGfJqepn7cYsCixYFzDN2pA==
X-Received: by 2002:adf:dc0a:: with SMTP id t10mr7931331wri.342.1590740219356;
        Fri, 29 May 2020 01:16:59 -0700 (PDT)
Received: from [192.168.178.129] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id b185sm12887575wmd.3.2020.05.29.01.16.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 01:16:58 -0700 (PDT)
Subject: [PATCH] cfg80211: adapt to new channelization of the 6GHz band
References: <1590053692-237138-1-git-send-email-arend.vanspriel@broadcom.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Jouni Malinen <j@w1.fi>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
X-Forwarded-Message-Id: <1590053692-237138-1-git-send-email-arend.vanspriel@broadcom.com>
Message-ID: <cbc3a214-db0d-18d4-b878-80277c210956@broadcom.com>
Date:   Fri, 29 May 2020 10:16:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <1590053692-237138-1-git-send-email-arend.vanspriel@broadcom.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The 6GHz band does not have regulatory approval yet, but things are
moving forward. However, that has led to a change in the channelization
of the 6GHz band which has been accepted in the 11ax specification.

This change is primarily thrown in to discuss how to deal with it.
I noticed ath11k adding 6G support with old channelization and ditto
for iw. It probably involves changes in hostapd as well.

Cc: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Cc: Jouni Malinen <jouni@w1.fi>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
  net/wireless/util.c | 43 ++++++++++++++++++++++++++++++++++++++-----
  1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index df75e58eca5d..f0a3a021ee0d 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -92,9 +92,11 @@ u32 ieee80211_channel_to_freq_khz(int chan, enum 
nl80211_band band)
  			return MHZ_TO_KHZ(5000 + chan * 5);
  		break;
  	case NL80211_BAND_6GHZ:
-		/* see 802.11ax D4.1 27.3.22.2 */
+		/* see 802.11ax D6.1 27.3.23.2 */
+		if (chan == 2)
+			return MHZ_TO_KHZ(5935);
  		if (chan <= 253)
-			return 5940 + chan * 5;
+			return MHZ_TO_KHZ(5950 + chan * 5);
  		break;
  	case NL80211_BAND_60GHZ:
  		if (chan < 7)
@@ -119,11 +121,14 @@ int ieee80211_freq_khz_to_channel(u32 freq)
  		return (freq - 2407) / 5;
  	else if (freq >= 4910 && freq <= 4980)
  		return (freq - 4000) / 5;
-	else if (freq < 5945)
+	else if (freq < 5935)
  		return (freq - 5000) / 5;
+	else if (freq == 5935)
+		/* see 802.11ax D6.1 27.3.23.2 */
+		return 2;
  	else if (freq <= 45000) /* DMG band lower limit */
-		/* see 802.11ax D4.1 27.3.22.2 */
-		return (freq - 5940) / 5;
+		/* see 802.11ax D6.1 27.3.23.2 */
+		return (freq - 5950) / 5;
  	else if (freq >= 58320 && freq <= 70200)
  		return (freq - 56160) / 2160;
  	else
@@ -1662,6 +1667,34 @@ bool ieee80211_chandef_to_operating_class(struct 
cfg80211_chan_def *chandef,
  		return true;
  	}
+	/* 6GHz, channels 1..233 */
+	if (freq >= 5935 && freq <= 7115) {
+		switch (chandef->width) {
+		case NL80211_CHAN_WIDTH_20:
+			*op_class = 131;
+			break;
+		case NL80211_CHAN_WIDTH_40:
+			*op_class = 132;
+			break;
+		case NL80211_CHAN_WIDTH_80:
+			*op_class = 133;
+			break;
+		case NL80211_CHAN_WIDTH_160:
+			*op_class = 134;
+			break;
+		case NL80211_CHAN_WIDTH_80P80:
+			*op_class = 135;
+			break;
+		case NL80211_CHAN_WIDTH_5:
+		case NL80211_CHAN_WIDTH_10:
+		case NL80211_CHAN_WIDTH_20_NOHT:
+		default:
+			return false;
+		}
+
+		return true;
+	}
+
  	/* 56.16 GHz, channel 1..4 */
  	if (freq >= 56160 + 2160 * 1 && freq <= 56160 + 2160 * 6) {
  		if (chandef->width >= NL80211_CHAN_WIDTH_40)
-- 
2.18.0

