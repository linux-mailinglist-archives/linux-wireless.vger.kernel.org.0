Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE6D284F40
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Oct 2020 17:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgJFPvf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Oct 2020 11:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgJFPve (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Oct 2020 11:51:34 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2E1C061755
        for <linux-wireless@vger.kernel.org>; Tue,  6 Oct 2020 08:51:34 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id t77so9576759oie.4
        for <linux-wireless@vger.kernel.org>; Tue, 06 Oct 2020 08:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S8m7OHHZnmxP0iAk0jZIhLxJ43ZGWVGptOjHwmhvuEE=;
        b=eCy7h3WwreZpcq+GVzFID7ES11bSXD52sIcCcKaIOP+LVrJRx7si+XVPFLXlLXsGuq
         iql5l7a/AiPmfHQoaJTMWORPDi7kRKePaLnyhPHCOTxArdWt9/0FwwOalIKGIe66jO9P
         SMk2ukqAXmtjjq9JC/npiNdGenMwqOWvzrZvYRC9r1yBxKkUYNKPrukeqbVOt7EdEcSa
         LWt1gFl793mc2VHMKgvvS4OI0Rs3TylGwIn+woSVY8kFln5EMTedjzTKVrg8oAikZWJ+
         5XZaFkinMChw/A0LWIRprOcpHfTdrFZAvF3qb884Orm71s/kOhMFAXE6pt/9BEgcYso+
         mRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S8m7OHHZnmxP0iAk0jZIhLxJ43ZGWVGptOjHwmhvuEE=;
        b=umKMfvdGZ2vaUbS6Yg7kHmSVOdsIVs2+sJkd4NTfG6GhwSXAu6PlVgtHT6VzSTP0E6
         +yS1begoKmvnLf2gZ/sDf4Tr3ouDbIKfqKa2m5JtSn5U7Cf9qUTvhHQXqrCUhVgPdBTe
         H30WTbfZSs6uOo6+dxGS/G/kWwB9EaZH53H6+5u6buZ5l+p9RX1J8+IN3TfEAFrWuxuj
         GgpOQjY+MBl/NVD+KlSjSb4BvL26iPMUxNwVAUTw8hhwtJIJAOzNkezYBGFZLVFi18LM
         qLQMAXIwDoA8X3PX8/yjtCuAbsrEtUx0d1tvX2OfwBTh2ku4UtnZIwWOriw/B6+anWPp
         lQFQ==
X-Gm-Message-State: AOAM530/SUiDYSCNezvnyFYGFaSuyzeMwiaCks7owH3tIlGuHBoTX66J
        J549mfWTP4CpFBGY656XDf6Rso/38h4=
X-Google-Smtp-Source: ABdhPJwFhudv/03xR57ncR+qEFZXZmXv431JUlZ1JFI1vbF7nr6+sdguTetfDqiW3OAqK2zg7gwrDw==
X-Received: by 2002:aca:f54e:: with SMTP id t75mr2967200oih.84.1601999493544;
        Tue, 06 Oct 2020 08:51:33 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id t5sm1063046otl.22.2020.10.06.08.51.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2020 08:51:32 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: Error in driver for RTL8821CE
To:     Cristian Llanos <cristian.llanos@gmail.com>
Cc:     linux-wireless@vger.kernel.org
References: <CANBg+yz2az1o9u7RDD6jwXCs=08u7izbmUOnkKJc2tnOQQCdog@mail.gmail.com>
 <97d78a81-b4fb-be83-5cb9-fa69575758c9@lwfinger.net>
 <CANBg+yy17Oj+WwvFRnC6PXJ4WWgwVm+O546F1Ju5xYHzu3kdnw@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <7b435755-a5e9-4cdb-05e0-c1aeea35bbf1@lwfinger.net>
Date:   Tue, 6 Oct 2020 10:51:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CANBg+yy17Oj+WwvFRnC6PXJ4WWgwVm+O546F1Ju5xYHzu3kdnw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/5/20 4:36 PM, Cristian Llanos wrote:
> $ lsmod | grep rtw
> rtw_8821ce 16384 0
> rtw_8821c 77824 1 rtw_8821ce
> rtw_pci 24576 1 rtw_8821ce
> rtw_core 167936 2 rtw_8821c,rtw_pci
> mac80211 843776 2 rtw_core,rtw_pci
> cfg80211 704512 2 rtw_core,mac80211
> 

The drivers look OK.

Try the following commands:

iw dev | grep Interface
sudo iw dev XXXXX scan | egrep "signal|SSID"

Replace the XXXXX with the device name listed on the "Interface" line following 
the first command. Post the output of the second command and indicate which SSID 
is from your AP.

Larry


