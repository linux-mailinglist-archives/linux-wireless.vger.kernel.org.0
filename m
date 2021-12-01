Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0EEE465425
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Dec 2021 18:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243999AbhLARmq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Dec 2021 12:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbhLARmp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Dec 2021 12:42:45 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61A8C061574
        for <linux-wireless@vger.kernel.org>; Wed,  1 Dec 2021 09:39:24 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id d1-20020a4a3c01000000b002c2612c8e1eso8057352ooa.6
        for <linux-wireless@vger.kernel.org>; Wed, 01 Dec 2021 09:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/cNut1odEz58+5WQpjXbh5Y9M+BW4+Q22MxZye+tdpc=;
        b=T4Z2Ykqs4ogTIETvF9wdO3RMBKV61jDmUdanwFudXfF7HohR4TNPi0Pv/qGpexLjBE
         risgyv7H9BvbfwciBWl9KKh+nSUvxAkriJfsBFaufYxBUy3avQ7+w23b91WOnBGTLEni
         Tivhe6iKKEWA4rBmOHDGZa5EvYnziAgMx4L96gKtxmho2pAxen20mn4M7LvIXRL5wscT
         nNR/gF1r1P8yUyB2J6MVlKzrpZU0mc7zLSg1xUpm2qbHR/zDgOEnmZXusHTRDc1LdYqo
         TVDcSktZyS0z6or9KiiCPUCBvme5nZEZw3ZqqgnZUgnV/no2VdNkCI2NW4Q6mSOeec5e
         j9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/cNut1odEz58+5WQpjXbh5Y9M+BW4+Q22MxZye+tdpc=;
        b=RMCX1D9NWUeKu2KOiDVRzV6wmmyN/TDlBtnYQx+9Ie1xK2BFBjlDNmZTVKcsWg9Ebi
         PprdxJVGmBiSJM9cS9Wnfo90qz+ijcI7De8en49jEVsUd7DICOIrVJJon7cu3bXHTQ7t
         4gmDF971STOM7zDsKyk+prr7RzsvC6xyTNEgJt6gwe+9jazUSpGDZKPGzNHqZCAz5kZt
         DkAukegmvRu5GUF0LKOYmY7MhE0D3JHuLJ8fQb5m6UfISI6n39+BD9TUCbaJ5C1/aM39
         iXuuzhzrAvzyfzPHAOju0OBo3Cl/85Jv3BZ6qGoS0br641RlRmMZ2PXZyc67fCA84CNr
         rT/A==
X-Gm-Message-State: AOAM531vWPEUnyvwq5yBmIsllQdw4DNBR7uWJudDJWjgPoyWhxkLhkPX
        i9JYaZCWmAZ5CrLbDnkJHD4xk6QQtAmFF7+L
X-Google-Smtp-Source: ABdhPJyHf7jO/IracVwTSgnDN7lmS+0Go7vytwELHXdOMR6GWtspzKH3j8eAJ20B59vHCBeQxj1Yig==
X-Received: by 2002:a05:6820:388:: with SMTP id r8mr5304735ooj.0.1638380364155;
        Wed, 01 Dec 2021 09:39:24 -0800 (PST)
Received: from [10.62.118.101] (cpe-24-31-246-181.kc.res.rr.com. [24.31.246.181])
        by smtp.gmail.com with ESMTPSA id p23sm151504otf.37.2021.12.01.09.39.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 09:39:23 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <5dc56416-7564-6a11-d477-9841b27a7123@lwfinger.net>
Date:   Wed, 1 Dec 2021 11:39:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: Latency spikes in rtw89
Content-Language: en-US
To:     Jeff Clay <jeffclay@gmail.com>, Pkshih <pkshih@realtek.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <CACJOGMP0k1AH9Coz2DjZjkeoxPGjSyP60MYMSHrMN-hSJrrvTQ@mail.gmail.com>
 <74887ec8f49846f5ae8b40b4c213d2da@realtek.com>
 <CACJOGMOBaQ+vc37dnpS8JYEnE4v4bufSkw+_Or5FEzkTiKXfBQ@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <CACJOGMOBaQ+vc37dnpS8JYEnE4v4bufSkw+_Or5FEzkTiKXfBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/1/21 08:48, Jeff Clay wrote:
> Thank you for the information. Would the issue persist if I were to
> disable wireless power management?

That is an easy experiment to try. Use the "disable_ps_mode=y' module option for 
rtw89core.

Larry

