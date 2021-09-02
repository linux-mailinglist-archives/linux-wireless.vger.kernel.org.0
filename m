Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A9E3FE8B2
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Sep 2021 07:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhIBF2W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Sep 2021 01:28:22 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:30744 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhIBF2V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Sep 2021 01:28:21 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630560444; h=Message-ID: Subject: Cc: To: From: Date:
 Content-Transfer-Encoding: Content-Type: MIME-Version: Sender;
 bh=xUPDCjlZZkxT5PbC0lrXcjdiYxOt/vxITKFTYtv1fFQ=; b=OfUDp8hP5oVeXyGVezupV0UmnxZCrHgOeyJvq8EApnV31ihMj9aLwYIlWVnKNzQXQ5AbECHl
 w8WNSsxgJgZ8+z2dfJSc/Vr9zcoTuPWQ1N5ocW7eXlPk3V06GCuqwMU9cBVvwyKwj9EdF4Mg
 yuSeyG/sbk9JmEEj7x5AOS/H644=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 613060aa825e13c54a9f691c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 02 Sep 2021 05:27:06
 GMT
Sender: murugana=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CE65BC43460; Thu,  2 Sep 2021 05:27:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: murugana)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B699EC4338F;
        Thu,  2 Sep 2021 05:27:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 02 Sep 2021 10:57:04 +0530
From:   Sathishkumar Muruganandam <murugana@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: Multi-client EAPOL key timeout when not having RTNL lock protection
Message-ID: <6cae54aee83a19dc13e458e4d20e4f28@codeaurora.org>
X-Sender: murugana@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

In the multi-client (64 or higher clients on single radio) test scenario 
of AP mode using hostapd, we are facing EAPOL key timeout for random 
clients.

wlan1: STA 00:41:c0:a8:03:10 WPA: received EAPOL-Key msg 4/4 in invalid 
state (7) – dropped

This is happening due to delay in transmission of association response 
frames for retried association request frames from the client and one of 
the association requests is received when EAPOL key exchange is in 
process. NL80211_CMD_NEW_STATION is received on hostapd when already 
EAPOL M3 is transmitted and waiting for EAPOL M4. But since hostapd 
received NL80211_CMD_NEW_STATION, it resets the handshake process from 
M1 again by the time client sends M4 to see the above error.

This delay is seen only after the commit, a05829a7222e ("cfg80211: avoid 
holding the RTNL when calling the driver") and not seen before/without 
this commit. We could see delay in processing of nl80211_get_key, 
nl80211_set_key, nl80211_new_key, nl80211_del_key and nl80211_tx_mgmt 
commands.

The delay and EAPOL key timeout is not seen when NL80211_FLAG_NEED_RTNL 
is set back to internal_flags of nl80211_get_key, nl80211_set_key, 
nl80211_new_key, nl80211_del_key and nl80211_tx_mgmt messages alone.

Please share your comments on this issue requiring RTNL lock for key and 
mgmt nl80211 commands.

With regards,
Sathishkumar
