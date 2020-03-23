Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADCE18F7C1
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 15:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgCWOy2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 10:54:28 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:47016 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgCWOy2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 10:54:28 -0400
Received: by mail-oi1-f182.google.com with SMTP id q204so7161675oia.13
        for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2020 07:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D6GXr8aaeP9bj5oGD8bQinBJS2DwCBuyrfDV2LY0+Vc=;
        b=Kzzyl5dJ/acrXB+IYN+fEWIolw6XF9Lg7ha855nElCNkesX40MAB+JCQET6C8n1490
         AluyfBOUK451Pz9uN4B/T84Uu2FFtENasesO9/H18txaGaV3VKyjn161+Rbldt+Aa0+W
         iP0LaQml8AWDYhRSwUu9+cDD+m+Fh0ZgtQWrmC5ua+GNJVSaAizll755vUfoz68n5fpG
         sC2yVgVPdEkF/3iBqniSMWh2+xqHno5b01+Fetd6ebKA11Z9Zdf4rFWlV/10tn4nMjtF
         FvssVeVYNelnEGUWXEQalP8mRqnXj7vZGzLj+TC/ZvLmKcfmWjNZG41ynEP8Yr1qlwCo
         JxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D6GXr8aaeP9bj5oGD8bQinBJS2DwCBuyrfDV2LY0+Vc=;
        b=r59rc5GF8vCnLNawx1earkT1mbTdWunQVEyLfcNyjfuknj7KkNk1x8i6LxgyXuLdY/
         F5+HVdehpt0UD/ROdJqdkGWtkyepxva1aH+ruOgm+5RM//aUkYXe609VMW+88cXri0Vx
         2dxOVSnWwkTKvLvk3uaAy1bjszFhHZu3KQdDOQJmuDsEAZvlfKLxt0PRWEUF8nykQ/6K
         WNp//mV9R27B8TRaxR9p0Gu2f6V5mDWr/h7r7xJUjhFTP1w0NHt/pwcZuVG5Wn2CzOJ5
         02xuSn+SlYOVxsrxdHkSzUWjmoGCp6KiMUh/m/rHwO0E4mwJa0x4933b898Mla0jCyiI
         pNcA==
X-Gm-Message-State: ANhLgQ34ltZSDeDFniFhsKUeI6CZ0eIRzk+q2ZnyDE1OsyqzUwtefn0Y
        55YAbMABZ3tgHKBjX+rSra9Lr5+p
X-Google-Smtp-Source: ADFU+vtCUOLTv0x27+Dk9y1gFCHgQg0kWnjQ6dao8rF9K5Vv3AjiAEnwwTvyK++HYHHAwcRcQ4TJKw==
X-Received: by 2002:aca:310a:: with SMTP id x10mr16707000oix.151.1584975267021;
        Mon, 23 Mar 2020 07:54:27 -0700 (PDT)
Received: from [192.168.1.120] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id c18sm5294443oig.53.2020.03.23.07.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 07:54:26 -0700 (PDT)
Subject: Re: [PATCH] rtlwifi: v88 firmware files for rtl8192cu
To:     Reto Schneider <code@reto-schneider.ch>
Cc:     linux-wireless@vger.kernel.org
References: <20200320025229.12084-1-code@reto-schneider.ch>
 <83d9a5bb-7802-2fa4-ffff-df318f8ce0e1@lwfinger.net>
 <f38d2640-940e-5cef-4f5e-026387bd2bd3@reto-schneider.ch>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <1d217b53-9090-1e7b-c744-fda914a2a98d@lwfinger.net>
Date:   Mon, 23 Mar 2020 09:54:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <f38d2640-940e-5cef-4f5e-026387bd2bd3@reto-schneider.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/22/20 8:51 PM, Reto Schneider wrote:
> On 3/20/20 5:00 PM, Larry Finger wrote:
>> File rtlwifi/rtl8192cufw.bin is loaded only when the initial firmware
>> file is missing or cannot be obtained for some reason. Ideally, it is
>> never used, thus you can skip updating it.
> 
> What would constitute the initial firmware? One of the updated three
> files? Something that is stored on the chip itself?

I should have said "initial choice for firmware" that is based on the chip 
parameters, and yes that will be one of the three versions. The chip has only 
enough firmware on it to be able to upload the 802.11n firmware. Only the 
Realtek 802.11g devices (RTL8187) have on-board firmware.

Larry
