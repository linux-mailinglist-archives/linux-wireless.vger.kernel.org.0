Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA75F2CDB7
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2019 19:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfE1Rgo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 May 2019 13:36:44 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:40501 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfE1Rgo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 May 2019 13:36:44 -0400
Received: by mail-oi1-f171.google.com with SMTP id r136so14943305oie.7
        for <linux-wireless@vger.kernel.org>; Tue, 28 May 2019 10:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=N9PqcuCQorjEPDVeIab0B3h0h+w8HGgFAnc07catgjQ=;
        b=hmOnlFVRhbhyjof3MlmDokkWal3Nfk0dxdIkpke0yIevjYkfCV3in20CFFN7e/zPrT
         kcwtYTs8zf76HxuslXbl9gAcU64kdc7SUth0NK4aCrkV/Qo+XQa1OCAS6uh1s+nYGQRZ
         4rdgt4v/lWW9TE/YFZmfyjfZQy2q1IoOLaBGQ0JTHM3shw5cKOSJoTZz7kProweobEBi
         bBVOfBETpxvTO4DY9MojPYi2uLyxC2ko0tgyotASfoeT5Q7P9IQBEm+6RAWmrD7bWUlU
         Cwf2hFBAqfwtxPMeTVq9niaDGdsmy8c8D16ku+q5jX6l6gXYbZTO7qhXtvjOuPcKRJk+
         oPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N9PqcuCQorjEPDVeIab0B3h0h+w8HGgFAnc07catgjQ=;
        b=cu3i301TNdzg3nMvkHfdBetLQwu1WuKMYoP9Pieyqlahg/Nl/TXPGVLL1TPbhJ1htF
         3w3aYDJfNuLTuFPXCbXKK4nIAY7xXqpotvvwVKR/KbrbsxjiUXGlrUz2VsDOOKeP8tO3
         DaQPXJVJ07Zl34nJpFAjxxxUT6vigTabHT2OOd3lL/2uYlLhrJdbc69S2cXXZTFlx1uE
         PBxX0bTwDibJw2nqu/x75vlim1TmH1rzbj07dSJMsAllSIUZhy0IFjMl55kRFn0X+2oU
         WM09zCtKvK48GiscQpukklCP4B02DI89j9T+nocPEhapqpADYZakdGOuUZ/d+lRTp46e
         BRlg==
X-Gm-Message-State: APjAAAX3v664msMrO9HLI2uM1K8K2L/E+nCTSkxsD4Gp/F6fBg5/aqSw
        jvfGOe8UrmXzQ2bgnD5SGt5RzJpX
X-Google-Smtp-Source: APXvYqy7zSeWQFqH2AbMrBjYxFeWj7mnFobJKQyF3FvaFgvXusclEqXz72WWOiUTyqBoeQ6F2aWEBQ==
X-Received: by 2002:a54:4f98:: with SMTP id g24mr3617604oiy.99.1559065003672;
        Tue, 28 May 2019 10:36:43 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id s201sm5674148oie.40.2019.05.28.10.36.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 10:36:43 -0700 (PDT)
Subject: Re: FYI: vendor specific nl80211 API upstream
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <c138fac51c7f49bbcd8617ae0a2c750d78abb35d.camel@sipsolutions.net>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <c7912523-ef79-9ac2-c465-80de189551a6@gmail.com>
Date:   Tue, 28 May 2019 12:36:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <c138fac51c7f49bbcd8617ae0a2c750d78abb35d.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

On 05/28/2019 06:51 AM, Johannes Berg wrote:
> Hi all,
> 
> FYI - at the discussions in Prague we decided to let some vendor
> specific nl80211 API go upstream, and I've just documented the expected
> rules here:
> 
> https://wireless.wiki.kernel.org/en/developers/documentation/nl80211#vendor-specific_api
> 

I'm guessing that you guys considered and rejected the idea of pushing 
these out to a separate, vendor specific genl family instead?

Regards,
-Denis
