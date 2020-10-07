Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A582856C5
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Oct 2020 04:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgJGCvX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Oct 2020 22:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbgJGCvX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Oct 2020 22:51:23 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F97BC061755
        for <linux-wireless@vger.kernel.org>; Tue,  6 Oct 2020 19:51:23 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id t15so940562otk.0
        for <linux-wireless@vger.kernel.org>; Tue, 06 Oct 2020 19:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DdEUekTTBch2+91QykUcLZxLuA613SahDKSbrbrfJs4=;
        b=KqNDJWeN/8XJz4PX7Zs48yAF0KSzrSaZ9VukqopF9K0pJNExhV4318Bt7EHXwDxdRc
         Q4pX0n+ffVpZ3I33OD8D8dtZwq+QcSiRsJqOOBOlvvBIVmWJwBRh/FVernny2AFtbHIT
         ohObjkLGDxR93gLSZ5cbHM8YVd08c483jU8Nw7EBQFAbR/OPkjpdTEdW1YT1U6ce7KWR
         u7izyd21wlARnNsW/qVHbMjVW2j+cRJtejPLCkXjggsrzkf8yCSlSiTUEGSvSBFgFAg7
         zsx0xPlOkv6DcOEoIQGjZD1DBk6QoalT3q/uqA1PLfZxxbVOGKGQAuQ2J5xyfbzNUpnE
         1PKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DdEUekTTBch2+91QykUcLZxLuA613SahDKSbrbrfJs4=;
        b=qVtSx6Kber6zv9YXOEL7mDsOeSY3w1v9/8kdIouDBhUvBjUfJv7jC4Pn2dzmadMQAu
         rHkYqP/OFURPtoqxJhtNm3ibOZ2sYWDfmmxAoRhqNf+CGmFxTcZ/SjhHE6JsBVjXsAdQ
         qfgWZC90BJuzPuNEpTul4GB22Uso+/PS9s564WSuJQDQhEPO3YCyS0DU5pSbAKMgknM+
         KrrSl1HMMmrkaGzKrsj8HdoZiMe076iDREPvOIQfCWAEb0QM8oC3TouZjLa54IfSgckk
         QckeG30YwQI4Ks8h9OBoGK5WhSqwPNXgK6Ib4/tn0LT9XFmu9cB+xsainzq0zMserjEb
         kJAw==
X-Gm-Message-State: AOAM533I3iXB42ISLvcVgufKJvUdkl6XSgfIjzaH1fLOSyAkHM+OYyly
        Gp7caMINg/MtWYrU/IgMrEALz3zpTfA=
X-Google-Smtp-Source: ABdhPJzi8zpoSlH2LRLa4NvZbZu+8WWGOpErvlh//48YK9kDjDm5RJzGGaeHMpUs6eMIYW2PhEILEg==
X-Received: by 2002:a9d:518e:: with SMTP id y14mr561126otg.138.1602039082024;
        Tue, 06 Oct 2020 19:51:22 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id v18sm865524ooq.11.2020.10.06.19.51.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2020 19:51:20 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: Error in driver for RTL8821CE
To:     Cristian Llanos <cristian.llanos@gmail.com>
Cc:     linux-wireless@vger.kernel.org
References: <CANBg+yz2az1o9u7RDD6jwXCs=08u7izbmUOnkKJc2tnOQQCdog@mail.gmail.com>
 <97d78a81-b4fb-be83-5cb9-fa69575758c9@lwfinger.net>
 <CANBg+yy17Oj+WwvFRnC6PXJ4WWgwVm+O546F1Ju5xYHzu3kdnw@mail.gmail.com>
 <7b435755-a5e9-4cdb-05e0-c1aeea35bbf1@lwfinger.net>
 <CANBg+yyL5vSRxbL3WSzawS-CjOwE1jFJc0D+kBXFQJJsOMQJ5g@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <0ff3eede-a283-1f26-6ef5-be78842eb3a7@lwfinger.net>
Date:   Tue, 6 Oct 2020 21:51:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CANBg+yyL5vSRxbL3WSzawS-CjOwE1jFJc0D+kBXFQJJsOMQJ5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/6/20 7:31 PM, Cristian Llanos wrote:
> Actually, the first command outputs nothing..
> 
That means that it has not created a wireless interface.

Does the output of the dmesg command show any information?

Larry

