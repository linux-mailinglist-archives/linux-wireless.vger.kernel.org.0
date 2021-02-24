Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC9C323864
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Feb 2021 09:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234386AbhBXINV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Feb 2021 03:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234285AbhBXIMt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Feb 2021 03:12:49 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CB5C061574
        for <linux-wireless@vger.kernel.org>; Wed, 24 Feb 2021 00:12:08 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id u4so1749614lfs.0
        for <linux-wireless@vger.kernel.org>; Wed, 24 Feb 2021 00:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=j77AkEbZoIWZSNLhMKy3qFeA4xeBMUijkMp35Qbxdpk=;
        b=DzscvkA0Ets0g3kR7AZM0oLb+inVbAujC95i5UoZ+CF4DyaUkFC8oPwrwVZaBGRJmE
         hkz3hHVM8Ld7nNYdwAKsS+AJWzKmG9j3fZrJQ/w/fd52kk7XX03HgguG6Dd9i5ScEkMD
         dD+Y11xyON1j509twa5RbFJpg7Td1+ei1IZvWTPY5DXCvbzknUwxoz+vsi/Gt7bWmkdP
         4YAXT55YVaDy65+MOOVSlRZuVgAMy5sHfD9uNaoLTyI+P2S+X5XG/dl5pb+B7XgiY5Xy
         DQ3zCZ04hEB5mypJtM1Flr/bq2gNkw6kUytc+UpvYDB59lYetkQp1OVFxcG4yBPiQwQ+
         Ownw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=j77AkEbZoIWZSNLhMKy3qFeA4xeBMUijkMp35Qbxdpk=;
        b=nUV0p+asCKUrEKT3heyCV2Q/qfW960akWy/WzY6JJPoOx5YvFqjayHohKmStLAXbtn
         5JBeAbcdptorc/LDyDSKrc1hOfWaj0eiOgH9yRlEjcdBKXWusmZcimkyNp//DoXcpMpU
         rx/grrnzjXB0JDSZIqz8gZWIBmydwSwh7im2H9ihebX01Ug/dF+Teh9iYp15u5ueOOK/
         ShomuUfBGQeg0AEEdj0CAebU0eQZFp3PCgRoEn2twFb0hZJBRpjHcvrvBwyU4rC8FIlj
         Q4y5IJd9MMmGPGPFMUp/VgWW4w50b2fkNeWZhPvu4BdK7xuTsmuP6+pWSmQnB5Tft0xs
         vdKQ==
X-Gm-Message-State: AOAM533QrM+I8NEFpeUx0sLZkjesDNcou1YxwNamq3tfnbr/r/EIxFF8
        9KpSDr0Rz+npJ2WJ5fvpJl4fWD+PBAJ2XScMMW9It+4Rm9L3CA==
X-Google-Smtp-Source: ABdhPJzK7UBraEID1rDsGItfsFxmZOVf4vPyQRbnylCAWrp1A0mZMRmJZr5AorTwMJB0zIQc1QY94iMloIIzFRBxUr0=
X-Received: by 2002:a05:6512:51a:: with SMTP id o26mr18410701lfb.240.1614154326915;
 Wed, 24 Feb 2021 00:12:06 -0800 (PST)
MIME-Version: 1.0
From:   Bassem Fahmy <bassem@morsemicro.com>
Date:   Wed, 24 Feb 2021 19:11:56 +1100
Message-ID: <CAEirPfyTgXPqT4bBSpqw1HCEMU2MWqj=THkL58BsfKuFttq0Cg@mail.gmail.com>
Subject: stall receiving change PS notification
To:     linux-wireless@vger.kernel.org, johannes@sipsolutions.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Jahannes, All,

I'm trying to get our WiFi driver to get power save  notifications
from the mac80211. For this I have set the below flags:

ieee80211_hw_set(hw, SUPPORTS_PS);
ieee80211_hw_set(hw, PS_NULLFUNC_STACK);

My tracing  shows that, once power save is enabled, we get a QoS NULL
Function packet. mac80211 is then waiting  for the ACK confirmation of
the packet. However even when this ACK is received (in the tx_status),
no change notification is sent to the driver.

The code below (in __ieee80211_tx_status), indicates that we set the
IEEE80211_STA_NULLFUNC_ACKED flag (for the managed interface), yet we
don't invoke ieee80211_dynamic_ps_enable_work (to notify the change of
PS state).

should we be calling the dynamic_ps_timer again or am I missing something?


if (ieee80211_is_any_nullfunc(fc) &&
   ieee80211_has_pm(fc) &&
   ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS) &&
   !(info->flags & IEEE80211_TX_CTL_INJECTED) &&
   local->ps_sdata && !(local->scanning)) {
       if (info->flags & IEEE80211_TX_STAT_ACK) {
           local->ps_sdata->u.mgd.flags |=
                            IEEE80211_STA_NULLFUNC_ACKED;
       } else
           mod_timer(&local->dynamic_ps_timer, jiffies +
                       msecs_to_jiffies(10));
      }
}

Thanks
Bassem
