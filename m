Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6F63CF5D6
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2019 11:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbfJHJSt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Oct 2019 05:18:49 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:36484 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729375AbfJHJSt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Oct 2019 05:18:49 -0400
Received: by mail-ed1-f52.google.com with SMTP id h2so14992179edn.3
        for <linux-wireless@vger.kernel.org>; Tue, 08 Oct 2019 02:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncentric-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=XJNzwuSACqoG+YjSXJpWGWIqK0oqnbLGm7FyNj3gfNY=;
        b=cPqArEJ438pOxalTUW86kmCX4xhal4ix+RV8c8SHc/TcSU4gE33HWQ/8u5fQc5smIl
         Ict0SZAcQk5TLUbrg0suFIC1j9Fi4LKUy18Tdb7WNzYCSFH8zwRjUcZyE2UpHfCE8U27
         OJ2EsL0E3i+EDr+h7T3i9W+SqqvbI9oqOPnbV0nxuukyGx7rAdUsNbu2X5/MbwT0MXSw
         Cib3OFzTPg/lq0K1N5CS83S+Ig07NpUcppW9hIPC1ZPET+TJiWO+cM81VSyCy2/Sae+h
         DSThFDj5JTBD6UBQs/cV5bSpa28LGRO5+X0K+BYJT9div96dd1EQWLVqoEUt3d3wEQ0f
         xqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=XJNzwuSACqoG+YjSXJpWGWIqK0oqnbLGm7FyNj3gfNY=;
        b=Ra9m7yih/uDzWjTuW4x1EYnrUoo2iaZlAWUxNNGz0ysORhaF/UCoDRVTblNnqM1uIa
         seaooV50iKEYXvC2ICSYKwzBi/0fOoMbWSIMzhBz+wvcndTv8QE97wVOHV9q9KcilgG2
         CLzrH+CD2WujSX4g7zu0K3/hjByUeFeNQ7kMkEJHQAQGNvqpmrnNokvr/0hu8T4k3uKv
         DETqWrCAJiVPBQgnLOzIgi8Vo6/YknEIbT9PAIPTuPTYiL5oHq8l4i3aHO6suGqXYL3R
         FZhGJ4Q7Lt5VniJO5weD9kUa6BYyI/oAkRkezDU0SVqAmTBDMmb9RdqDqGr0XO31qZlb
         Uw7g==
X-Gm-Message-State: APjAAAUql+aIc5C1yuShHAdeHrEsSPDzUKQFdMd+mpvLZC1h6LZU9D1W
        MsFdoQ1qf7/b30Ui6qVZXu4ZSQ==
X-Google-Smtp-Source: APXvYqw2RpwD4vEI/quEsrxSTUFxvJbJUmj2AejKSv4bhUH49UUTFp/W9tVKv3vXUFda0RAzDbH5iQ==
X-Received: by 2002:a17:906:81c6:: with SMTP id e6mr27466019ejx.284.1570526326383;
        Tue, 08 Oct 2019 02:18:46 -0700 (PDT)
Received: from [192.168.3.176] (d515300d8.static.telenet.be. [81.83.0.216])
        by smtp.gmail.com with ESMTPSA id rl4sm2207819ejb.27.2019.10.08.02.18.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 02:18:45 -0700 (PDT)
Subject: Re: [PATCH 2/2] mac80211: minstrel_ht: replace rate stats ewma with a
 better moving average
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
References: <20190929154646.90901-1-nbd@nbd.name>
 <20190929154646.90901-2-nbd@nbd.name>
From:   Koen Vandeputte <koen.vandeputte@ncentric.com>
Message-ID: <a60a96ba-e344-fd5a-7af0-caea23f21945@ncentric.com>
Date:   Tue, 8 Oct 2019 11:18:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190929154646.90901-2-nbd@nbd.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tested on dozens of devices interconnected offshore in IBSS (static and 
moving)

Works as advertised and reduces slight drops noticed on vessel movement.

Tested-by: Koen Vandeputte <koen.vandeputte@ncentric.com>

