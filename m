Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33718A4150
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Aug 2019 02:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbfHaA16 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Aug 2019 20:27:58 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:40574 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbfHaA15 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Aug 2019 20:27:57 -0400
Received: by mail-ot1-f48.google.com with SMTP id v5so1989343oto.7
        for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2019 17:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bIH22Ig07PTQNruqPebrBmj9giHX7BcULgpVdfOPVbM=;
        b=XdpSfyxITcTpj2IF2q6aK8+5KIujiHYjoQLmsuwwldWPlzceSFd/QtWT0PuapRf/kn
         I1vl6QHkabUKH01GzyrRei3NXegBYADPr77yqDI4DfkcUS3SJMSdJNgtt8cS4Wkvi6+G
         raaRoSJvycIZSxsSKAbKZlRNhG3rH/EEkxJR9pMBSnLLD1eKzJsw5evjWPkmcihERvkL
         Q/QWh60A04mMzWTdhaNAUXJIw48z9YfiHraceDSSzd3yeCZifzcjYNdSz4/ZWXpgsJ/M
         xvIqOnvbp6oKOEKV9Cz6BXOqhpdDW+95Vh3nVu5AHj6+w7qushpDXXabK9dDEOkEHThI
         mFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bIH22Ig07PTQNruqPebrBmj9giHX7BcULgpVdfOPVbM=;
        b=L4GWCKwjHLXmssnOErEOJlN4OpzPmemiqtGRuhOMW2nfUWcWJ+QOjAAEEaaQO6FaMJ
         Zm6mWzs+89Ie8D4ktZZNnh8U+ENksV7t0eX6E6XqCiC7uBD4C3dAJ5GtGI2HwgaNO32U
         LUldDFPR6EuKSgwcamlE+sxG3GcvGi+3bIx9dIZVYXCsaTM3ziqzfD58e0rgnk0LQAE4
         JIwHaJOegPJI7DvL3lS3Ln+Zhzn+ixkfKlb198malHR34VeJFcAjguOxdh2IDGXo3BvF
         nWcygjtdM052ddrGfRo7gI1K8/yKPtLMmT69rHT+LZ+fz/PeYIEofeGbzcQ66xFs2vOF
         5fQw==
X-Gm-Message-State: APjAAAXb2IF8cck7kei8gmWewq7wX20RytNFtBqRQ5/+E0UFWspt65Xh
        Psr6ux/ZxvLbaSs2fl4gNxwxCK9v
X-Google-Smtp-Source: APXvYqxRach+2hiaRUn2gxL8ntH4WEsqJS1qCrrc7D+fnDt+FvoG7MrtbJ5EF0Y5HGtEmxRma4kZTg==
X-Received: by 2002:a9d:69d5:: with SMTP id v21mr2510851oto.279.1567211277036;
        Fri, 30 Aug 2019 17:27:57 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id u17sm2095019oif.11.2019.08.30.17.27.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2019 17:27:56 -0700 (PDT)
Subject: Re: [Linux Realtek Wi-Fi support] rtl8192ee related bug
To:     Sergey Kharitonov <haritonovsb@gmail.com>
Cc:     linux-wireless@vger.kernel.org
References: <CAHmv74wK2NYuj2JuDUz-og5w+e=H1=ef9eCSMTbO6otaYQatKg@mail.gmail.com>
 <9172166a-eb77-a508-ba54-08fdf96912fc@lwfinger.net>
 <CAHmv74wNOM1QKUPp2Vax2Z+-JyoFC81WHVZ+XbYgiRMUGxCFUQ@mail.gmail.com>
 <9492be2d-abd1-0e1d-5d80-1a72b0250749@lwfinger.net>
 <CAHmv74x008FvhDztqOq-EC=d7fSXN7=kEOhQm3TPZn1PDZP=fQ@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <9b6f5c4c-2775-a5c2-0372-f8eb7ec18628@lwfinger.net>
Date:   Fri, 30 Aug 2019 19:27:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHmv74x008FvhDztqOq-EC=d7fSXN7=kEOhQm3TPZn1PDZP=fQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/30/19 4:45 PM, Sergey Kharitonov wrote:
> Sounds good!
> I made a little change to compile that old rtl8192ee_revised.tar.bz2
> driver on Linux 5.2.X and I get <1ms overall ping to the router with
> rare spikes to 1-2ms.
> I'm excited to know the right driver can provide the same performance,
> it's starting to look now like the hardware's achievable maximum.
> Is there any chance an improved rtl8192ee would be included in Linux 5.3?

It won't be in 5.3, and it is getting late for 5.4. I'll send the patches along 
and see what happens.

Larry


