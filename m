Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5CA9384E0
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2019 09:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfFGHWX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Jun 2019 03:22:23 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39587 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfFGHWX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Jun 2019 03:22:23 -0400
Received: by mail-ed1-f66.google.com with SMTP id m10so1575302edv.6
        for <linux-wireless@vger.kernel.org>; Fri, 07 Jun 2019 00:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WIWHcUlruIXuWb7Q4ynz/R9GRZd3PnDUIIzWnxLGnbU=;
        b=BcQFPhHfhwVZRgOVFwRt7Mkx1+kpvZItpmQh3BEcF5Wh8/aNgVD684++hWYf45IZUD
         K1pZ8g8NshAfFZi2WTU9qqRdOjeNl5xZlrIULYk62STnWAW1U9wcUlcdX0lIri2maVz6
         o7nEWrowl89M+LYQtOD+G3wNpNuabb640WkrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WIWHcUlruIXuWb7Q4ynz/R9GRZd3PnDUIIzWnxLGnbU=;
        b=RMpD7u9fS9K6NY/CeaRMaZk4w7y8OOOOpmVUzf02qy2dEda72IzagoOL8xeFw3x+AM
         RyuQaQ9zpj9NhXIc01GDqZOW6riHRgPToGEsuaA5ta91YeDBViMIK4QznLYWHhe2wt60
         ReGd6hqkqfDA8mw5QRd9e4T1wKZsg4tbipcMGmDoovJx8xHN9cnyXKyWqleRAYyn44No
         dj+ibMLf7UjFBGtYOwLN/Er7XOQ6W8yNGfXPpUe9jZYdwzN/HLP4j4DLTxyNlMj+ZON0
         IxHgE4AGaolDOr8D1IzxkONZ5nKNcjD19h/bp3bgGhT2AlsxYTVhqaT7HS3AkXtj0nnd
         xS4g==
X-Gm-Message-State: APjAAAVtTAgkQOzOSOG67gFUInPfnOD+wGwnG/qKcdubf+iUKgnwpCXp
        YCCS24jgVOO7IIqHeJQZovtOyA==
X-Google-Smtp-Source: APXvYqxQj6rBH38LA9YI4caeohRUERNuFRwalQB5gWn5Haan4KavMiNH9q8K0T/T7+VJZ3s1ZAXl+A==
X-Received: by 2002:a50:bdc5:: with SMTP id z5mr39004669edh.61.1559892141432;
        Fri, 07 Jun 2019 00:22:21 -0700 (PDT)
Received: from [10.176.68.125] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id c10sm302513edk.80.2019.06.07.00.22.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 00:22:20 -0700 (PDT)
Subject: Re: [PATCH V2] iw: print HE capabilities
To:     Joe Perches <joe@perches.com>, John Crispin <john@phrozen.org>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Shashidhar Lakkavalli <slakkavalli@datto.com>
References: <20190528065828.25356-1-john@phrozen.org>
 <c3f982260cdf0749201f5535bf0f3bf9f6bfa7ba.camel@perches.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <ffabd374-b0ff-1970-4b75-fbc6547fe5f1@broadcom.com>
Date:   Fri, 7 Jun 2019 09:22:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <c3f982260cdf0749201f5535bf0f3bf9f6bfa7ba.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/7/2019 4:11 AM, Joe Perches wrote:
> On Tue, 2019-05-28 at 08:58 +0200, John Crispin wrote:
>> Print the HE MAC/PHY capabilities and MCS/NSS sets.
> 
> trivia:
> 
>> diff --git a/util.c b/util.c
> []
>> +void print_he_info(struct nlattr *nl_iftype)
>> +{
>> +	struct nlattr *tb[NL80211_BAND_IFTYPE_ATTR_MAX + 1];
>> +	struct nlattr *tb_flags[NL80211_IFTYPE_MAX + 1];
>> +	char *iftypes[NUM_NL80211_IFTYPES] = {
>> +		"Unspec", "Adhoc", "Station", "AP", "AP/VLAN", "WDS", "Monitor",
>> +		"Mesh", "P2P/Client", "P2P/Go", "P2P/Device", "OCB", "NAN",
>> +	};
> 
> Should probably be
> 	const char * const iftypes[...]

We are doing this iftype string mapping in several places so a helper 
function may be warranted.

Gr. AvS
