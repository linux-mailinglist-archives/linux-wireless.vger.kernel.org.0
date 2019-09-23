Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82E40BB499
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2019 14:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394705AbfIWM7J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Sep 2019 08:59:09 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34729 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394080AbfIWM7J (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Sep 2019 08:59:09 -0400
Received: by mail-lf1-f66.google.com with SMTP id r22so10021210lfm.1
        for <linux-wireless@vger.kernel.org>; Mon, 23 Sep 2019 05:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=k50d4zNpLRzhDQ657vV08/3TQcYi960pcyNCE+IKpGA=;
        b=Zp2FFk7VirwL/UMZ0KvSNy3BUVPf3N7l2pQQ0TvlshgrYI17n9Cg2wY+i8aPBt4TiV
         v+bNx7BITv6hxf490oHe2VgT8+4rJMgcl6VPHwtcFj0tKp0RGoq8XzE0OAlk191rBRXs
         STU5B5opNWu7wDWoTLrIln3C5kVPEzo9X/60eTXjhQAPxSvp4WCwYeXTfHsKUEID3sTi
         B818cTPF8HkOxzd1Ky5vznEV3gXy+BNl0BP24PxmNaUCjtZd057dGUIWwdtZ6BqXhwCg
         Ya9SnFJ4dQMTOjTco/Ig5A4mKp0F+ILmTxNBYPMK1R/N0qKJIfrLcQy5jbN0CjU5fXn1
         KBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k50d4zNpLRzhDQ657vV08/3TQcYi960pcyNCE+IKpGA=;
        b=EJF5kOoRZ+lPqyaaE9fDrgQIiD/BRVNEKNXjEtocNxPlhtfjiW0hQDpJio58WsU/Ho
         YA2Xn5MdEmRz/JSvMX6BFUUrnJMMVbr8g67SzFAsy7+gymzEH2T+wi3/pnc+mLMJDDlL
         Mk0980GGhkGe6IFrphHKt/xN4xdc21EU2CfDruVb9HB8B8WgVZDBAIMrXJqXXNNEFODv
         8eRMikCBKx8ao0C9VImfZJMnz7HaMGbwfJXoPeCoMF9RJX3CVllXN4Hv/PnhA3Yi2vte
         eCMQX2XFK2elROlfYrKeHeBDw6a4aVfkDGKF3rl1gtTQzwjqxM37TZlnhg8cG0hkK+kC
         94Kg==
X-Gm-Message-State: APjAAAWT9QUJn6GydOUmomvQ3jYS+RuquGRKlCEBINSVsLnj79URmPat
        byCz6qaooCyxyr2ldhVUfMjEAk7G
X-Google-Smtp-Source: APXvYqz9CjsckumGKB9S0B9yv3T1co/sntzWWi9h8/MnIhLKXL4T7nEPYHhyBiK2KrNoz7mawJY81Q==
X-Received: by 2002:ac2:5e9e:: with SMTP id b30mr16751949lfq.5.1569243546822;
        Mon, 23 Sep 2019 05:59:06 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-32-67.pppoe.spdop.ru. [94.29.32.67])
        by smtp.googlemail.com with ESMTPSA id 3sm2277925ljs.20.2019.09.23.05.59.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 05:59:06 -0700 (PDT)
Subject: Re: [PATCH] cfg80211: initialize on-stack chandefs
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <1569239475-I2dcce394ecf873376c386a78f31c2ec8b538fa25@changeid>
 <4576d1ca-3af6-476b-7fb8-4b99dc77b92b@gmail.com>
 <711186e8d875750f7ec962b0e96c3f1a050ae86d.camel@sipsolutions.net>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <cfcfcde8-5c97-316a-1053-60dc058346f7@gmail.com>
Date:   Mon, 23 Sep 2019 15:59:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <711186e8d875750f7ec962b0e96c3f1a050ae86d.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

23.09.2019 15:13, Johannes Berg пишет:
> On Mon, 2019-09-23 at 15:12 +0300, Dmitry Osipenko wrote:
>>
>> Tested-by: Dmitry Osipenko <digetx@gmail.com>
> 
> That was quick, heh!

Yes, it happened that I was doing some kernel work, had device to test
under my hand and checked email in the right time. Thanks again!
