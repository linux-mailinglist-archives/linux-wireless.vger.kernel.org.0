Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 663FDC9038
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2019 19:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbfJBRu1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Oct 2019 13:50:27 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37630 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbfJBRu1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Oct 2019 13:50:27 -0400
Received: by mail-pl1-f193.google.com with SMTP id u20so67286plq.4
        for <linux-wireless@vger.kernel.org>; Wed, 02 Oct 2019 10:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eero.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=toF6A8tWgh1ccfZbQy+x0axxQ4r9Y7TXsgXbVDoMnL0=;
        b=T08zyqNz+oj7U1SMjHXhBPdRWLtSEn+ED9FWIHFnhapLQ6wvIeTmTu9W3j+UTRmjUz
         EhO+yU6QA/Z4LGnqv3+/+ekzwLaVNYhYHmQpCWzPh0quZ+LwlXON0DrttlaK4D+rSDaV
         mi1kXus5syPhy6y5hYmeDrtYaCpr65n9EoJgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=toF6A8tWgh1ccfZbQy+x0axxQ4r9Y7TXsgXbVDoMnL0=;
        b=hG2WdJfu4L/4EJ54DaW3e1fXqAV3vbkesDPMdDHozAfkFmMGw1T8u+uIUUxBaoDCFV
         GvqqWL2r+3KAqFawx+inAlbzFmQLBMkbBUrwI5zlxqSwxP78gKxHnfMCpR72Q7vSy+SR
         RVUkKWRuCzVyA5mbEgMD3SXvwoiUHaQog2SWG3LzHh3PwqQnfUz0CjJQZELkp7HfgSU9
         ngXZuix8Y+KqlymSxRVBPp+qsNUq2RaGsIiUPV7xOc78opXOb7L9gqgQ29Ke2JzwQk24
         HBNIeLf4v3kImuoVPjfYuwMqztVNaobnS4+mW6mQNaxTMsBpu+P7sLuBjriLcqdYA3PI
         VvAg==
X-Gm-Message-State: APjAAAV1g1zMTV2J+hY89yKraqiNwxcGiT4RSNmSJlGqwxhHRaNAOWP9
        Rjj9GBud22Ma2rUBRpc8f2D+I6VD7gA=
X-Google-Smtp-Source: APXvYqy5pYFa2saNx9RmG3Xo8oLxV6LVibuQHffevwsFFIzGOywdwU9J5MbrQ0lkSHjHDIZf1vlenw==
X-Received: by 2002:a17:902:ff12:: with SMTP id f18mr5127974plj.266.1570038626271;
        Wed, 02 Oct 2019 10:50:26 -0700 (PDT)
Received: from [10.0.2.15] (96-64-208-121-static.hfc.comcastbusiness.net. [96.64.208.121])
        by smtp.gmail.com with ESMTPSA id c26sm73820pfo.173.2019.10.02.10.50.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Oct 2019 10:50:25 -0700 (PDT)
Subject: Re: [PATCH v3] mac80211: fix scan blocked on DFS channels in ETSI
 domains
To:     Aaron Komisar <aaron.komisar@tandemg.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <1570024728-17284-1-git-send-email-aaron.komisar@tandemg.com>
From:   Peter Oh <peter.oh@eero.com>
Message-ID: <02f58201-4b92-0a1e-d237-6838543a3513@eero.com>
Date:   Wed, 2 Oct 2019 10:46:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1570024728-17284-1-git-send-email-aaron.komisar@tandemg.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 10/2/19 6:59 AM, Aaron Komisar wrote:
> In non-ETSI reg domains scan is blocked when operating channel is a DFS ch.
> For ETSI domains, however, once DFS channel is marked as available afer
> the CAC, this channel will remain available even after leaving this channel.
> Therefore a new CAC will not be required when scan is done.
>
> In cfg80211 scan is not blocked for ETSI reg domains.
> This patch enables scan in mac80211 as well when operating channel is a radar
> channel for ETSI reg domains (unless CAC is in progress).
>
This is not the right approach to solve the problem.

The real reason of scan failure is because mac80211 checks if it's DFS 
channel, but it doesn't check if CAC is done or not.

So to solve the issue, the right approach should be "check if DFS 
channels and check if CAC is done".

You may refer how "cfg80211_reg_can_beacon()" is doing for that.


Thanks,

Peter

