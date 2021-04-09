Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5087935A1EC
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Apr 2021 17:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbhDIPXz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Apr 2021 11:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbhDIPXw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Apr 2021 11:23:52 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F377CC061760
        for <linux-wireless@vger.kernel.org>; Fri,  9 Apr 2021 08:23:39 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id l12-20020a9d6a8c0000b0290238e0f9f0d8so6008236otq.8
        for <linux-wireless@vger.kernel.org>; Fri, 09 Apr 2021 08:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=3uk3LThOJ9dbUazuA8FvAARB3lSS0+3Ac9v6osEyA3o=;
        b=N2SJMkZvVmF5nYoDHxHXMTCoDS/3UrEeD17TO0EAJmrkg8q+97GGt9fSIUR+2I0uw1
         zK7KYYG6Xn4UYz9ytfC8cfObBdCHMYr8YYSyFScamPxNHS97E9oHhFcE5whB5kMVM9v8
         kh6VcTxQQgWEJy51Vtpas89oRXfgWqcGBak+l/sQWC/nUhZVzs7BVtk/soByJqDeYh/F
         Jc9poYb6bFZx2CgxmgPXpDfoikablY1GiZsYqfEXXBYuvW2fFR3q5mCMwd5XW9/spmxi
         zanTRfUOHGT6muBagxPanMGFamV+iQLhUrH+pwgQwc47I5BKzHOpodcqe9o3Muetnq7j
         886Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:from:subject:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=3uk3LThOJ9dbUazuA8FvAARB3lSS0+3Ac9v6osEyA3o=;
        b=X/KjMTO9RzMzrRkQJAJxyqTHDyYH/8kicFqxUrZv00uqrWjKfy8Bk10olEHkk9LhQ0
         u1SKVF6rxYzokjeqL75Pp+DGvlji97k/ZcllpxXe5Iznb+WNPCDfhHC2ao8vY2DSpRlX
         Ine6d5NVjSNZuwlufWIoc7fT5P2YUZxxYNjLJEQVtmL12cRR86VRK6r87w1xGW3/y+Xr
         9Svdpkg5uW10bVf8kX43FrzcI20AXnf+PLME0ZHBbkLkkZ9wEEPy6I/FD6kplWzpjb0V
         I7lHwKOPCK0uETyJs7iX3vPFIW+kzrdxpRjiY24htViLKpNoThVNSMNZ6qrslza41DJD
         wBlQ==
X-Gm-Message-State: AOAM533Ywqg69HwhGJ8oUYo0Lhlbkypu8fOrDLSCtSPBks3FO16c48jb
        i4JuZ00xt5sLl3UY7UEaemE=
X-Google-Smtp-Source: ABdhPJz0pwaF6i1mRI4antBQrs6ZdJ/MEA2lqjsaC3s+FgC9pYiw9rPiGT4AeSM9GzWrMvG2JLHTsQ==
X-Received: by 2002:a9d:748a:: with SMTP id t10mr12865702otk.198.1617981819456;
        Fri, 09 Apr 2021 08:23:39 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id d13sm661407otk.74.2021.04.09.08.23.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Apr 2021 08:23:38 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
To:     "Berg, Johannes" <johannes.berg@intel.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Pkshih <pkshih@realtek.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Subject: Memory leak in ieee80211_rx_napi()
Message-ID: <ad9bee4f-ef24-1fe0-5e63-e2e840ac0449@lwfinger.net>
Date:   Fri, 9 Apr 2021 10:23:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes and all mac80211 gurus,

What setting or lack of, would cause ieee80211_rx_napi() to leak the skb that it 
is given? The documentation states that once this call is made, mac80211 owns 
this buffer. Does this mean that it will also be freed?

Larry

