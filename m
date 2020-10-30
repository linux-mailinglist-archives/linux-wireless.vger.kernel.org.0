Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A0E2A10CA
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Oct 2020 23:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbgJ3WX4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Oct 2020 18:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgJ3WX4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Oct 2020 18:23:56 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058ADC0613D5
        for <linux-wireless@vger.kernel.org>; Fri, 30 Oct 2020 15:23:56 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id j41so1949316oof.12
        for <linux-wireless@vger.kernel.org>; Fri, 30 Oct 2020 15:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SAhoaRRnuOp+mj14rN9iY3PUjge0sZsbVMUob9eUL+M=;
        b=jHQmUW7EcUyl4mEGA//9kOyyQBC20CZ+EqLaT6RVOWPwXcd/vx+IpjkBuKYPt5eUzA
         SOLIij11VAfLjIHVD3IdN9DFl6pXOTbeWg4VzKO7zjB/UEPmkd62kj+Yl8vSkx+yiDLc
         ZuaGiwStDaC+fcRQLXeHc1kdhM5fHLM/o2diL8bo+6o2AftMxpbN6vePYlCFa71aarjs
         eccV1/u83FyvK+OF7b4qMC2WLmpai3oJ+EYaNr6n8j3f3qG4lSPlmGikgypxgZA4U2ai
         3U4Qz1NrEpUeUl8FwZVT9IQyVhekPzQUqh5MeXqDwvYDuQCchpVU9U2brJ4OsansMX4h
         3/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SAhoaRRnuOp+mj14rN9iY3PUjge0sZsbVMUob9eUL+M=;
        b=ilvk8mIns80nyrXEYx1f2p9JEKZ0L2E1hV6bajKrT0rZhAibP0HNriatgXIK7VLFDs
         ZDGEoTQHUl1DqP6z0nyh45Uf+RN8atpF5kHOPP6gNY77oIi/NAT4l5WeVeYwHna4RiD0
         Qd6rSPbf5CbWzlDmjIYWqn/NUxu8Eg1djZa7Y77ZS6vO1PF2d5/u9sUEO5RZ1vOzEKtc
         zOKLW4xxI7PsgTQDZqUxrD/XvkppB4Qqx2n2GK/Tsc+fiZYukH5TFV/FmbYmk8YchQhT
         ZsD7CVEThX9E1GQT2yRwZflVCn8DPIkGqx51yTvsjwL5pMLjln/lDhvc206WOSI0XAt1
         zJJw==
X-Gm-Message-State: AOAM530k+aw4A1GFWKSvwnLZuziE9no+QO6n/IBINAjpZQeUuXfnVJBg
        fBchvSXuDYX5jaV/Bsl68JZrXICiYII=
X-Google-Smtp-Source: ABdhPJzOItw6SQwWWRH/LsIZCb+zWtDA+OuS/FIvt7kXTgqcjAkKo8MHs2aactrktoEUZunm2NAdqQ==
X-Received: by 2002:a4a:9607:: with SMTP id q7mr3556102ooi.3.1604096635048;
        Fri, 30 Oct 2020 15:23:55 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id d199sm1714701oig.31.2020.10.30.15.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2020 15:23:54 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: rtw_8821ce driver in kernel 5.9.1: wifi module inactive
To:     Michal TOMA <michaltoma@sicoop.com>
Cc:     linux-wireless@vger.kernel.org
References: <6173742.tiux6Xeah1@linux-9g0r.site>
 <3c2baab8-bdcf-0679-b396-b42a05a0ef38@lwfinger.net>
 <2483828.eKyWTE2oqM@linux-9g0r.site>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <5a6155f1-f8ea-b8b4-e38f-0ebf8bf720d0@lwfinger.net>
Date:   Fri, 30 Oct 2020 17:23:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <2483828.eKyWTE2oqM@linux-9g0r.site>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/30/20 4:21 PM, Michal TOMA wrote:

> iwlist wlp7s0 scan
> 
> wlp7s0 No scan results
> 

You should move away from those obsolete commands (iwconfig, iwlist, etc.). The 
new command would be

sudo iw dev wlp7s0 scan

It might not make any difference, but the new ones are better.

Any additional messages between the start and stop vif messages in dmesg?

I do not have an 8821ce for testing' however, I am not aware of any changes in 
5.9.1 that should stop it from working/

Larry

