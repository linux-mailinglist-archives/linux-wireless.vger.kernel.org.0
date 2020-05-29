Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B641E799B
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 11:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgE2Jlr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 05:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgE2Jlr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 05:41:47 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF5DC03E969
        for <linux-wireless@vger.kernel.org>; Fri, 29 May 2020 02:41:46 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id j198so6406516wmj.0
        for <linux-wireless@vger.kernel.org>; Fri, 29 May 2020 02:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:references:to:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MXfCGGuy8jwivhJaLcPZKqN+AfKe27yPLHJ3Coil8IE=;
        b=c9EJqOs3yP8u2791MKt+obRi1C9JS29jDS2xFtEB4XpV8k1TErrrg2kVWSGPJ6lYxY
         QwnX3m9RCv6pziQxF6F5TpfoS1M4aqgWG/18yrMs1M+Xab7ipoMFbED2iuiyN/+ZkIDI
         bPcUK+2XxQUMQ5cKf2FGV2mPUG2sQr3iYZWJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:references:to:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MXfCGGuy8jwivhJaLcPZKqN+AfKe27yPLHJ3Coil8IE=;
        b=J1xl1MgSGgEtnjVD1c/T2IUXriG3fNWkQ7JhXsfAIyVx6PF+KyvInCLZtyiadqISar
         JZk1bkwGmRj/oEmKFFRN6O7KQNtnn5elRryc8P9mnIvFgj5hEOL6VzzfUP+3aWVJ3Ts7
         zADbKYsNwfSuMr11Oe5qEOCDGKLQK/I+tmilOhi/8yW5Js7ejY7y3aQ92t+5UCFcweOT
         lM7B7V9qh2Bh0C8rxAV9S0Edus5Z/TnZxkUWlaW9buQHvTz2je0V7R/lmCBfCWjQnxp1
         kh/C5qwhHlEgaRlF/zLkw2bHqlco9K8lG1IlkgwzvNsNtI6ISr11QqMt1ZU1QHW76byu
         /UTw==
X-Gm-Message-State: AOAM530YX+CBJHGnD9OLlNyJWByTY1tySWlv3c0/0O9OfoeyMOrxO1SP
        uZuQv5wuIFh/3jxVCBZ/L/dffw==
X-Google-Smtp-Source: ABdhPJzsmyecATkDjLB0DEgHHPGAVWXm8Nl/vgxZK/5HSUU/3buqnnE3H1LRZnCtcgRMeCaxxqtKhA==
X-Received: by 2002:a1c:7308:: with SMTP id d8mr8036822wmb.6.1590745305511;
        Fri, 29 May 2020 02:41:45 -0700 (PDT)
Received: from [192.168.178.129] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id h196sm10588700wme.22.2020.05.29.02.41.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 02:41:44 -0700 (PDT)
Subject: [PATCH V2] cfg80211: adapt to new channelization of the 6GHz band
References: <1590744414-55473-1-git-send-email-arend.vanspriel@broadcom.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Jouni Malinen <j@w1.fi>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
X-Forwarded-Message-Id: <1590744414-55473-1-git-send-email-arend.vanspriel@broadcom.com>
Message-ID: <edf07cdd-ad15-4012-3afd-d8b961a80b69@broadcom.com>
Date:   Fri, 29 May 2020 11:41:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <1590744414-55473-1-git-send-email-arend.vanspriel@broadcom.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The 6GHz band does not have regulatory approval yet, but things are
moving forward. However, that has led to a change in the channelization
of the 6GHz band which has been accepted in the 11ax specification. It
also fixes a missing MHZ_TO_KHZ() macro for 6GHz channels while at it.

This change is primarily thrown in to discuss how to deal with it.
I noticed ath11k adding 6G support with old channelization and ditto
for iw. It probably involves changes in hostapd as well.

Cc: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Cc: Jouni Malinen <jouni@w1.fi>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
V2:
  - deal with channel 2 in ieee80211_chandef_to_operating_class()
---
  net/wireless/util.c | 49 ++++++++++++++++++++++++++++++++++++++++-----
  1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index df75e58eca5d..220f44ae3a70 100644
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
@@ -1662,6 +1667,40 @@ bool ieee80211_chandef_to_operating_class(struct 
cfg80211_chan_def *chandef,
  		return true;
  	}
+	/* 6GHz, channels 1..233 */
+	if (freq == 5935) {
+		if (chandef->width != NL80211_CHAN_WIDTH_20)
+			return false;
+
+		*op_class = 136;
+		return true;
+	} else if (freq > 5935 && freq <= 7115) {
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

