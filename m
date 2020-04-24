Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F11811B708A
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 11:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgDXJTM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 05:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgDXJTM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 05:19:12 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4CAC09B045
        for <linux-wireless@vger.kernel.org>; Fri, 24 Apr 2020 02:19:11 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j1so9895028wrt.1
        for <linux-wireless@vger.kernel.org>; Fri, 24 Apr 2020 02:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=y7Rn5PX8LPsiGeZ6RWpVJHpZHhwQ1ARgPo+9NaslZaY=;
        b=GEQkpcGO7jQJYP9XaposKMavQu43EVLjuNgbI5wYNYft0brx/E0CZ7Sjt9DAQVgIPj
         8usJIdN/0xzybF4FWXMNXZur/84SaWNl34DKttuyJQk5fWGzeRUUCthI02E69sbGlizb
         rDzbPTYubPpL0uNw7QJtBNmqz7kzXQBrSR/ug/VqsdfvZnfKIjqcKUgfOKNhgWR//aPO
         Ik3TtYZs9dBvenTpTobVs9fSRRwQD5/UsFXwWfwIiQBqRry7/pjlqav7OdVuTrQ8ds1J
         68Eke9iaBxrGC5nQTyKCLuWQj1ut0UsUpPKWv65fNIFITpwO+Z+37XJ8jfYCOe5erjVz
         ivMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=y7Rn5PX8LPsiGeZ6RWpVJHpZHhwQ1ARgPo+9NaslZaY=;
        b=VJCvXCbnLik8UXzCDpjcIyu9Gr7srxlxtg+4PkoBa12dyTG2Kr+uN3oGYVKFq9+aP9
         remoluxVkjIzkjrv7ACSuTKgQqZyMfxxRQ1YQK23D9Cs9zEf0xymOjsNv/XLgDdGmYJ+
         MmLQa1WhPNdEr4PLpDkdmF6ncx1/gy352xXqaSxqSGZRvVuLykMYGus76QnpoJkFlgcN
         T3EwT4tk1stbqxkkYYu9Tg9LhsP7WHsCdF7rf41vf1tg7DpJIAvORQlpfoc4b3SI+xQk
         NGlpMQ6n+XLIXr4H7z8XR4QGG7AmFC72UOYui48Rv0cGlj0lOhTkriV+K+/sdF5m8zFn
         GclA==
X-Gm-Message-State: AGi0PuaSAHVPxo4aIa26eXFKVYqaP/GmRLDXs9hGyHbdrIy2pcBrIlWn
        iQLJwS9PHiS6hPds1jKqn1YFr4H2+ew=
X-Google-Smtp-Source: APiQypJZ3jP1pM8/E4zHkEjWmkHWWqL1wXbsQnT57L3l5Pw2P1ikkjkGBi0JzxUmkuo3b0vaj9Hfbg==
X-Received: by 2002:a5d:4b04:: with SMTP id v4mr10483523wrq.358.1587719948895;
        Fri, 24 Apr 2020 02:19:08 -0700 (PDT)
Received: from ?IPv6:2a02:1811:e422:ad00:f58d:9165:44ce:c58b? (ptr-eiyd6234yxkksfgejd7.18120a2.ip6.access.telenet.be. [2a02:1811:e422:ad00:f58d:9165:44ce:c58b])
        by smtp.gmail.com with ESMTPSA id u188sm1461242wmg.37.2020.04.24.02.19.07
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 02:19:08 -0700 (PDT)
To:     linux-wireless@vger.kernel.org
From:   Wei Liu <wei.liu1011@gmail.com>
Subject: Questions regarding 802.11 TM and FTM in cfg80211/mac80211
Message-ID: <a1809833-fe87-3fac-0e7e-92a3dedeff8f@gmail.com>
Date:   Fri, 24 Apr 2020 11:19:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dear experts,

I am new to Linux kernel, and I have an ambitious goal to run ptp over 
wireless (yes I know..  and please don't judge .. )

When I browse code in mac80211, I found function start_pmsr in 
ieee80211_ops. At this moment, this function is serving a request 
(defined in cfg80211) to start peer measurement, and the request seems 
rather FTM specific.

Is there some code available to support the original Timing Measurement? 
As I am not interested in localization/ranging, but interested in 
synchronization, so the basic TM is enough for me.

Regarding FTM, the current cfg80211_pmsr_ftm_result does not contain the 
ToD, ToA timestamps, it only reports the RTT. Is there a proper way to 
expose these timestamps to the user space?

Thank you in advance for any guidance,

Wei

