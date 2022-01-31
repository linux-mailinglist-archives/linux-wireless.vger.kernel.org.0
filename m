Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 535DE4A52AA
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Jan 2022 23:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbiAaWxv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Jan 2022 17:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235325AbiAaWxr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Jan 2022 17:53:47 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5172BC06173D
        for <linux-wireless@vger.kernel.org>; Mon, 31 Jan 2022 14:53:47 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id p4-20020a4a8e84000000b002e598a51d60so3605264ook.2
        for <linux-wireless@vger.kernel.org>; Mon, 31 Jan 2022 14:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:from:subject:to
         :content-language:cc:content-transfer-encoding;
        bh=9zBApbkHMV/ng5boFN0AS4AxEVOvxdPwEfB+Zhf3A+w=;
        b=GtTiRABsXmhQsI5nLAIafs8HGm74/Rpzhg/8mW7Z8tnG4Af5i7FXbq9psgx81Junm6
         TCY7xeEzkQZdUJTCgFOltuFYJDPmNq7YPSElm1z5q0jFQHL4XZNlDejWYEl5eQwWaQ28
         mSZKpGYp95DnPtZEADh0dqi4867xZ9c6h2s59X5knRmKCJwZYs6rK1y6qlDKRwXnVP8E
         iwS575/apf/HIsKL3u00OicU3t53VvaHDiGoU7OO7hkAjFG7qDvTxjapNOaRIADgDJsw
         Kx1HH6pbYLT5B1lLenR/PHXEqiW7p2cmXBMDTU2EjPlaQAev8C138Zu8wPjqHci3+OEp
         AtXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :from:subject:to:content-language:cc:content-transfer-encoding;
        bh=9zBApbkHMV/ng5boFN0AS4AxEVOvxdPwEfB+Zhf3A+w=;
        b=anq44rnYdjEWTyU6VSTauDHaHOuLGGuNu32HKvQ0lrvx71w5Wd8vnMo0vHyASxh/li
         ErCgZI88oC5idtzv6NKp69UIqyVY41qRVUJ6Rw0veDKxhK4DdTgvbLOeEFowdOAYRaBt
         +Kaee+46VWKlVQ5VaB/yftTZ/adqlWIWztBtKI+HTZvHivSwAG6+QVQcg/w4V5CH+Y+/
         WGYLOYHauTpJ7z/KL8e2+Ml7wXfeTc4qdrQS0/LXD8JcnI4CpHlHJByCBSLvu8zOSD8o
         ZHlLHpFaVBv/slFgDsLIFXwY8sG6wFW0r8uPtdPTGX+EmgxaL5FJo/LRpzHiQ/AWZUWa
         Zwvw==
X-Gm-Message-State: AOAM531SGwfGNQi7A2+35VXRuRFb0+YgkOBjDGgdoIE81vbUFwwpM+R+
        Q/y3MJKa2r8aQiRArXW2CrJQa8VqkU8=
X-Google-Smtp-Source: ABdhPJymTPWGHpL4rMfVSxSHw+mAvkM6HRhz46YSER0d1eZm1MNzDlOxCefuCFGwx1Ik4wfZ035J6A==
X-Received: by 2002:a05:6830:1194:: with SMTP id u20mr12984724otq.148.1643669626617;
        Mon, 31 Jan 2022 14:53:46 -0800 (PST)
Received: from [192.168.1.103] (cpe-24-31-246-181.kc.res.rr.com. [24.31.246.181])
        by smtp.gmail.com with ESMTPSA id e5sm14448926oti.59.2022.01.31.14.53.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 14:53:46 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <c356d5ae-a7b3-3065-1121-64c446e70333@lwfinger.net>
Date:   Mon, 31 Jan 2022 16:53:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Larry Finger <Larry.Finger@lwfinger.net>
Subject: Funny log entries for rtw88_8821ce
To:     Pkshih <pkshih@realtek.com>
Content-Language: en-US
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke and list,

Within the last couple of days, I was testing rtw88 with an rtl8821ce card. I 
noticed that whenever the device is not connected to an AP, the log is flooded 
with messages like the following:
[130462.603539] rtw_8821ce 0000:02:00.0: stop vif ee:a4:95:4e:53:8b on port 0
[130463.116843] rtw_8821ce 0000:02:00.0: start vif aa:fc:19:66:5e:e2 on port 0
[130874.613430] rtw_8821ce 0000:02:00.0: stop vif aa:fc:19:66:5e:e2 on port 0
[130875.122641] rtw_8821ce 0000:02:00.0: start vif d2:e6:23:ba:98:76 on port 0
[131286.677828] rtw_8821ce 0000:02:00.0: stop vif d2:e6:23:ba:98:76 on port 0
[131287.192108] rtw_8821ce 0000:02:00.0: start vif 82:c4:33:96:2e:c6 on port 0\

After ~411 secs, the callback routine for remove_interface() in struct 
ieee80211_ops is called. After <1 sec, the add_interface() callback is called to 
restart the vif. Is this normal behavior and I see it in the logs because this 
driver is the only one that logs the start/stop calls, or is something else 
going on? It would be easy to disable those log entries, but I would like to 
know if there is some other condition?

On my kernel, HZ is 250, thus the interval is roughly 103,000 jiffies.

Thanks,

Larry

